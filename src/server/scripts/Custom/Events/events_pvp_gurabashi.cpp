/*
 * Copyright (C) 2010-2014 BattleCore3 <http://www.battle.cl/>
 *
 * BattleCore es un proyecto privado basado en TrinityCore
 * que tiene como finalidad el desarrollo de WoWChile, el estudio
 * y la practica de la informatica en World of Warcraft.
 *
 *  ____        _   _   _         ____                
 * | __ )  __ _| |_| |_| | ___   / ___|___  _ __ ___  
 * |  _ \ / _` | __| __| |/ _ \ | |   / _ \| '__/ _ \
 * | |_) | (_| | |_| |_| |  __/ | |__| (_) | | |  __/ 
 * |____/ \__,_|\__|\__|_|\___|  \____\___/|_|  \___|
 *                                               _____
 *                                              |__  /
 *                                               /_ < 
 *                                             ___/ / 
 *                                            /____/  
 */

#include "ScriptPCH.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Creature.h"

/*------------------------------------------------------*
 *                    PVP Gurabashi Arena               *
 *------------------------------------------------------*/

#define THEME 5000020
int length = 0;

class npc_pvp_gurabashi : public CreatureScript
{
private:    
    typedef std::list<Creature *> LC;    
    typedef std::list<GameObject *> LG;    
    LC listacreaturas;    
    LG listagameobjects;

    int CambioEquipoListo(Creature *creature)
    {
        QueryResult result;
        result = WorldDatabase.PQuery("SELECT `time`, `refresh` FROM `battlecl_pvp_gurubashi_masters` WHERE entry = %u", creature->GetEntry());        
        
        if (result)
        {
            Field *fields = result->Fetch();
            return fields[0].GetInt32() + fields[1].GetInt32();
        }
        else return 0;
    }

public:
    npc_pvp_gurabashi() : CreatureScript("npc_pvp_gurabashi") { }

    bool OnGossipHello(Player *player, Creature *creature) OVERRIDE
    {
            
        char msg[100];
        int UltimoTiempo = CambioEquipoListo(creature);

        if (UltimoTiempo)
        {
            QueryResult result;
            result = WorldDatabase.PQuery("SELECT `id`, `name` FROM `battlecl_pvp_gurubashi_escenarios` WHERE giver = %u", creature->GetEntry());            
            
            if (result)
            {
                do
                {
                    Field *fields = result->Fetch();
                    player->ADD_GOSSIP_ITEM(4, fields[1].GetString(), GOSSIP_SENDER_MAIN, THEME + fields[0].GetInt32());                
                } while (result->NextRow());
            }
        }
        else
        {       
            player->ADD_GOSSIP_ITEM(0, msg, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);  
        }
        player->ADD_GOSSIP_ITEM(0, "Close", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);        
        player->SEND_GOSSIP_MENU(1, creature->GetGUID());        
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *creature, uint32 sender, uint32 action) OVERRIDE
    {
        if (action > THEME)
        {
            if (CambioEquipoListo(creature))
            {
                int TimeCur = time(0);
                QueryResult result;

                WorldDatabase.PExecute("UPDATE `battlecl_pvp_gurubashi_masters` SET `time` = %u WHERE `entry` = %u", TimeCur, creature->GetEntry());                
                
                // GameObjects
                result = WorldDatabase.PQuery("SELECT `x`, `y`, `z`, `o`, `entry` FROM `battlecl_pvp_gurubashi_spawns_gameobjects` WHERE `theme` = %u", action - THEME);                
                LG::iterator l;                
                for (l = listagameobjects.begin(); l != listagameobjects.end(); ++l)                
                {                    
                    GameObject * go = *l;                    
                    go->Delete();                
                }
                listagameobjects.clear();   
                if (result)   
                {                    
                    do                    
                    {                        
                        Field *fields = result->Fetch(); 
                        GameObject * gob = creature->SummonGameObject(fields[4].GetInt32(), fields[0].GetFloat(), fields[1].GetFloat(), fields[2].GetFloat(), fields[3].GetFloat(), 0, 0, 0, 0, 2592000);      
                        listagameobjects.push_back(gob);   
                    } while (result->NextRow());               
                }

                // Creaturas                
                result = WorldDatabase.PQuery("SELECT `x`, `y`, `z`, `o`, `entry`, `spawndist` FROM `battlecl_pvp_gurubashi_creature_spawns` WHERE `theme` = %u", action - THEME);     
                LC::iterator i;        
                for (i = listacreaturas.begin(); i != listacreaturas.end(); ++i)  
                {                   
                    Creature * crtemp = *i;             
                    crtemp->DespawnOrUnsummon(0);
                }
                listacreaturas.clear();    
                if (result) 
                {                
                    do        
                    {           
                        Field * fields = result->Fetch();   
                        Creature * temCreature = creature->SummonCreature(fields[4].GetInt32(), fields[0].GetFloat(), fields[1].GetFloat(), fields[2].GetFloat(), fields[3].GetFloat(), TEMPSUMMON_MANUAL_DESPAWN, 0);    
                        temCreature->GetMotionMaster()->MoveRandom(fields[5].GetFloat());   
                        listacreaturas.push_back(temCreature);       
                    } while (result->NextRow()); 
                }
                player->PlayerTalkClass->SendCloseGossip();
            }          
            else
            {     
                OnGossipHello(player, creature); 
                creature->MonsterSay("The stage has been properly selected please wait a few seconds while the change is made...", LANG_UNIVERSAL, player);    
            }     
        }      
        else   
        {            
            switch (action)
            {           
                case GOSSIP_ACTION_INFO_DEF + 1: 
                    player->PlayerTalkClass->SendCloseGossip();
                    break; 
                case GOSSIP_ACTION_INFO_DEF + 2:
                    OnGossipHello(player, creature);
                    break; 
            }     
        }
        return true;
    }
};

void AddSC_events_pvp_gurabashi()
{    
    new npc_pvp_gurabashi();
}
