# BattleCore

`master`: [![master Build Status](https://magnum.travis-ci.com/BattleCL/BattleCore.svg?branch=master&&token=x5A97TEb4yuM38tPHvD3)](https://magnum.travis-ci.com/BattleCL/BattleCore)
`stable`: [![stable Build Status](https://magnum.travis-ci.com/BattleCL/BattleCore.svg?branch=stable&&token=x5A97TEb4yuM38tPHvD3)](https://magnum.travis-ci.com/BattleCL/BattleCore)

## Rangos

__Formato:__ _Base_ + _Usados_
+ El numero _Base_ siempre debe estar libre.
+ El numero _Usados_ corresponde al ultimo utilizado, considerar un _+ 1_.

### Creature
+ GUID: _1.000.000_ + __915__
+ Entry: _5.000.000_ + __86__

### GameObject
+ GUID: _1.000.000_ + __419__
+ Entry: _5.000.000_ + __28__

### ItemTemplate
+ Entry:  _1.000.000 + __41__

### Permission
+ Ver en [RBAC.h](src/server/game/Accounts/RBAC.h)

## Estandares de desarrollo

### General
Utilizaramos el [estandar de TrinityCore](http://www.trinitycore.org/f/topic/6-trinitycore-developing-standards/) y adicionalmente para los comentarios utilizaremos el idioma español para identificarlo nuestro cambios, y no incluiremos acentuaciones ni la letra "ñ".

### Database
Todas las actualizaciones deben ser incorporadas en [sql/updates](sql/updates), y en su carpeta segun la base de dato respectiva.

+ [sql/updates/auth](sql/updates/auth)
    + __Formato:__ auth_year_month_day_count_table.sql
+ [sql/updates/characters](sql/updates/characters)
    + __Formato:__ characters_year_month_day_count_table.sql
+ [sql/updates/world](sql/updates/world)
    + __Formato:__ world_year_month_day_count_table.sql

Nota: _Si el cambio contiene muchas tablas se puede omitir la tabla y en su lugar poner "misc"_

## Historial de cambios

__Los ultimos cambios que contienen el tag [BattleCore] son mostrados automaticamente en el sitio web, cuando se encuentran en esa version el reino.__

+ 06/07/13  [iPlay96] Añadido readme
+ 06/07/13  [iPlay89] Se Añade Mejora al GCD. (Delay control). (Revertido)
+ 06/07/13  [iPlay98] Se Añade que la spell Lay of Hand no pueda ser critico
+ 06/07/13  [iPlay98] Fix Spell Shadowmeld Ahora saca de combate y ademas se corrije un exploit de autohit y autocast en shadowmeld.
+ 06/07/13  [iPlay99] Final Fix loot Gunship.
+ 07/07/13  [iPlay100] Fix Crash Gunship.
+ 07/07/13  [iPlay101] AzjolNerub: Cambio de la faccion de Hadronox para evitar que combata con los mobs que le rodean y se cuele en las texturas
+ 07/07/13  [iPlay102] Fix de especializacion de la profesion de ingeneria. (NPC)
+ 07/07/13  [iPlay103] Las spells Place Seaforium Bomb,Place Huge Seaforium Bomb y Place Seaforium Charge, ahora colocara la carga en la posición correcta, evitando que atraviese las texturas
+ 07/07/13  [iPlay104] Fix Tiempo En alterac Valley SNOWFALL FIRSTCAP .
+ 07/07/13  [iPlay105] Isle Of Conquest:Algunos ajustes en Creature::canCreatureAttack, añadido check para evitar que los boss de Isla de la conquista entren en “EvadeMode” esto permite una batalla más blizzlike
+ 07/07/13  [iPlay106] Algunos ajustes en MotionMaster::MoveKnockbackFrom, solucionado log cuando speedXY=0,ahora las spells que utilizan este efecto realizarán la animación de forma correcta.
+ 07/07/13  [iPlay107] Isle Of Conquest: Update Creatures Template Vehiculos etc En IOC.
+ 09/07/13  [iPlay108] Quest Fixed 10922 Digging Through Bones (Report: started by Joacoferna, May 2, 2013.)
+ 10/07/13  [iPlay109] Ahora Las creaturas jamas podran meterse a las texturas.
+ 10/07/13  [iPlay110] Isle Of Conquest Agregadas las inmunidades de los boss & Fix Barcos del BG
+ 10/07/13  [iPlay111] Implementamos Feature de WOW FadeOut https://www.youtube.com/watch?feature=player_embedded&v=SCJSGBYGobk
+ 10/07/13  [iPlay112] Isle Of Conquest se actualizan flags en SiegeEngine, ahora sera atacable en todo momento por los jugadores del equipo.
+ 12/07/13  [iPlay113] Quest Fixed 10086 I Work... For the Horde! (Reporte Bug: iniciado por orurddon, el 30 Jun 2013.)
+ 12/07/13  [iPlay114] Quest Fixed 12237 Flight of the Wintergarde Defender
+ 12/07/13  [iPlay115] Core/Movement: Spells de salto a distancia corregidos... ahora se veran mejor :)
+ 13/07/13  [iPlay116] Ahora los cementerios de la base horda y alianza daran resurreccion de forma correcta.Ademas todos los cementerios estarán funcionales solo cuando se este llevando a cabo una batalla.
+ 15/07/13  [iPlay117] Fix Spell Relacionadas (Spell Soul Drain y Arcane misil ) problema relatatado con "Another action is in process" en commit iPlay111.
+ 15/07/13  [iPlay118] Fix Spell relatados en cambios de Collision.
+ 15/07/13  [iPlay119] Revertimos Sistema de Bg's Mixtos para nueva implementacion.
+ 16/07/13  [iPlay120] Fix Spell resist Chance (cloack of shadow de rogue) y final fix hit en pve
+ 16/07/13  [iPlay121] Fix Crash en Sistema Arena Espectador.
+ 16/07/13  [iPlay122] Update al sistema de visibilidad en Stheal totalmente blizlike.
+ 16/07/13  [iPlay123] Update al sistema de Fade Out en commit [iPlay111]
+ 16/07/13  [iPlay124] Nuevo Sistema de GCD (Control delay).
+ 16/07/13  [iPlay125] Nuevo al tiempo de GCD y fix a vanish + fade control commit update de sistema GCD [iPlay124]
+ 16/07/13  [iPlay126] Removemos El buff de vanish despues remueve el stheal. (Visual Blizlike)
+ 16/07/13  [iPlay127] Fix Spell BG_DS_SPELL_WATER_SPOUT en Dalaran Sewers
+ 16/07/13  [iPlay128] Update al Sistema de Visibilidad implementado en [iPlay122]
+ 16/07/13  [iPlay129] Update al Sistema de Fade Out implementado en [iPlay111] se añaden mas spells con este atributo y mejoras & Pequeño Update al sistema de GCD  Implementado en [iPlay124]
+ 16/07/13  [iPlay130] Implementamos Spell de dk Risen ally
+ 16/07/13  [iPlay131] Fix crash por float y algunos warning's fix y añadiendo override primera parte.
+ 16/07/13  [iPlay132] Update a Pathgenerator de mmpas para arenas y bg's
+ 16/07/13  [iPlay133] Fix Evade de npc's relatado por sistema de mmaps
+ 16/07/13  [iPlay134] Fix typo de implementacion en Risel ally. relatada en [iPlay130]
+ 16/07/13  [iPlay136] Update a sistema de binarias resistencias Fixe Binary Resistance Spell Penetration de items y recalculo de la resistencia
+ 17/07/13  [iPlay137] Fix typo arena Dalaran Sewers condiccion implementado en [iPlay127]
+ 17/07/13  [iPlay138] Fixe Remove Stealth en AoE spells (Blizzard, Arcane explosion etc) & Fix Spell Soul Link & Fix Fel Guard
+ 17/07/13  [iPlay139] Añadido Al readme entry's custom como informacion para evitar duplicas & añadido spawn alos sqls de las craeturas custom
+ 17/07/13  [iPlay140] Implementamos AreaAuraEffect y final fix StealthRemoveOnAreaAuraEffect
+ 17/07/13  [iPlay141] Fix Ahora las pets meteran en combate al dueño y agustes de pet en cuando el player no se encuentra & Fix Glyph of Felguard & Hackfix en Delayed spells (Ejemplos Fearing While Block) & Hackfix seteamos CombatState para spell channeling Spell Drain Soul & Arcane missile & Fix Shadow Dance relatado con fadeout y delay de spells
+ 17/07/13  [iPlay142] Fix Espectador de arenas & Limpieza de codigo en fix recientes fix typos y fix en resistencias binarias y Control delay final fix de esto.
+ 17/07/13  [iPlay143] Quest Fixed 11611 Taken by the Scourge
+ 17/07/13  [iPlay144] Fix Pvp Trinket Forsaken CD
+ 18/07/13  [iPlay145] Creados Scripted AI para los NPC<25600,25609> <Borean Tundra>
+ 18/07/13  [iPlay146] Añadido Espectador de Battlegrounds
+ 18/07/13  [iPlay147] Warrior: Fix spell Deep Wounds, ahora hara el daño correcto con la habilidad trauma
+ 18/07/13  [iPlay148] Quest Fixed 11686 The Warsong Farms <Borean Tundra>.
+ 18/07/13  [iPlay149] Utilidades se Añade Filtro a la Solucion para mas orden en los cpp Solamente Scripts.
+ 18/07/13  [iPlay150] Creados Scripted AI para los NPC<25294,24566,25445> <Borean Tundra>
+ 18/07/13  [iPlay151] Fix a Npc Vote Points
+ 18/07/13  [iPlay152] fix vida de la pet despues del Resummon
+ 18/07/13  [iPlay153] Update al tiempo del Delay de spells algunos ajustes al sistema de fadeout y bus con delay spells. Fix spell Rogue Honor Among Thieves
+ 18/07/13  [iPlay154] Update Spell Raise Ally relatado en frenzy.
+ 18/07/13  [iPlay155] Update Formula Eviscrate y Master Poisoner Rogue
+ 19/07/13  [iPlay156] Añadido a DR spells 49886 & 60210
+ 19/07/13  [iPlay157] Fixed velocidad y exepciones de charge en path de sistema mmaps
+ 19/07/13  [iPlay158] Creados Scripted AI para los NPC<25496,25479,32576> <Borean Tundra>
+ 20/07/13  [iPlay159] Quest Fixed 11711 Coward Delivery... Under 30 Minutes or it's Free <Borean Tundra>.
+ 20/07/13  [iPlay160] Quest Fixed 11587 Prison Break <Borean Tundra>
+ 20/07/13  [iPlay161] Creados Scripted AI para los NPC<25467,25468,25464,25585> <Borean Tundra>.
+ 21/07/13  [iPlay162] Quest fixed 11895 Master the Storm <Borean Tundra>.
+ 21/07/13  [iPlay163] Quest 11881 Load'er Up! Se a mejorado la velocidad de movimiento de Jenny <Fezzix's Pack Mule>.
+ 21/07/13  [iPlay164] Quest Fixed 11893 The Power of the Elements <Borean Tundra>.
+ 21/07/13  [iPlay165] Quest Fixed 11684 Scouting the Sinkholes <Borean Tundra>.
+ 21/07/13  [iPlay166] Creados SCripted AI para los NPC<25687,25686,25701,25699,25685,25725,25622,25619> <Borean Tundra>.
+ 22/07/13  [iPlay167] Quest 11706 The Collapse Se a modificado el tiempo de despawn para 25742 Alluvius <Borean Tundra>.
+ 22/07/13  [iPlay168] Creados Scripted AI para los NPC<26202,25454,25383,25387,25386,25534> <Borean Tundra>.
+ 22/07/13  [iPlay169] Quest Fixed 11633 Blending In <Borean Tundra>.
+ 23/07/13  [iPlay170] Fix Trigger 1# de Quest 11633 deberia ser invisible para players.
+ 23/07/13  [iPlay171] Quest Fixed 11898 Breaking Through <Borean Tundra>.
+ 24/07/13  [iPlay172] Quest Fixed 11677 Stop the Plague <Borean Tundra>.
+ 24/07/13  [iPlay173] Fix Resumon pet la vida de esta.
+ 24/07/13  [iPlay174] Update a resummon de pet en commit  iPlay173
+ 24/07/13  [iPlay175] Añadimos inmunidad a frost a la pet water elemental de mago
+ 24/07/13  [iPlay176] Update tiempo y una exepcion al GCD
+ 24/07/13  [iPlay177] Implementamos RemoveNegativeAuras
+ 24/07/13  [iPlay178] Update 2 a resummon de pet en commit  iPlay173  iPlay174
+ 24/07/13  [iPlay179] Update Absorb Spells
+ 24/07/13  [iPlay180] Update Arena Espectador
+ 24/07/13  [iPlay181] Añadida Final Version Addon Espectador
+ 24/07/13  [iPlay182] Se aplica npc cambio de faccion por 100 BOJ
+ 24/07/13  [iPlay183] Update Formula Execute warrior
+ 24/07/13  [iPlay184] Implementamos que al ganar perder un bg te daran emblemas BoJ
+ 24/07/13  [iPlay185] Update npc cambiador de items costo
+ 24/07/13  [iPlay188] Update precio del cambiador de items y el sql se añaden nuevas opciones de cambio de raza y nick
+ 24/07/13  [iPlay189] Update Binarias Resistencias
+ 24/07/13  [iPlay190] Fix Cheat Death Rogue
+ 24/07/13  [iPlay191] Argent Tournament: Fix Quest THE_VALIANT_S_CHALLENGE (Alliance & Horde) de cada capital.
+ 24/07/13  [iPlay192] Fix Quest  Rescue from Town Square
+ 25/07/13  [iPlay192] Custom Sistema de premios para nivel 80
+ 25/07/13  [iPlay193] Update Sistema premios nivel 80 corrije bug de que lo de en todos los niveles
+ 25/07/13  [iPlay194] Update Sistema premios nivel 80 corrije bug de que no llega el correo
+ 26/07/13  [iPlay194] Posible Fix a los crash recientes del realm.
+ 26/07/13  [iPlay195] Fix Spell Honor Among Thieves
+ 26/07/13  [iPlay196] Fix Custom Script Premio ahora no enviara el correo por cada nivel
+ 26/07/13  [iPlay197] Fix Arena RV problemas de collision y efectos de fuego
+ 26/07/13  [iPlay198] Fix Ebon Gargoyle formula & Gargoyle Strike Formula
+ 26/07/13  [iPlay199] Fix bug de Shadow Dance
+ 26/07/13  [iPlay200] Fix velociad death grip y silence shot
+ 26/07/13  [iPlay201] Fix velociad death grip y silence shot v 2.0
+ 26/07/13  [iPlay202] Pequeño update a check en FleeingMovementGenerator
+ 26/07/13  [iPlay203] Fix Spell Master Call
+ 26/07/13  [iPlay204] Quest Fixed 11930 Cruzando Transborea | Across Transborea <Borean Tundra> (Soporte idiomas: enUS/esMX)
+ 27/07/13  [iPlay205] Fix Spell Shadowmeld
+ 27/07/13  [iPlay206] Añadido delay a Shadowmeld y fix delay de flare spell
+ 27/07/13  [iPlay207] Se añaden las armas furious al vendedor de StaffIplayWotlk by <Hold>
+ 27/07/13  [iPlay208] Añadido Correcto Dr a spells  Storm, Earth and Fire  Earthgrab  Freezing Arrow , se añaden algunas resistencias mas al sistema de resistencias binarias, se añade check para que algunas spells Tomen el LOS ,Living Bomb  fix rango y proc ,fix  Magic Suppression, ShockWave añadido correcto rango,Slice and Dice ya no dejara en combate
+ 27/07/13  [iPlay209] Test fix whispers gm's anbas facciones
+ 28/07/13  [iPlay210] Fix Grounding totem  Fix Spell Reflection  Fix Ice barrier
+ 29/07/13  [Iplay210] Creados Scripted AI para los NPC <25803,25839,25800,25764,26266,25351> <Borean Tundra>.
+ 30/07/13  [Iplay211] Fix ICC problemas reportados en issues, update statate de gunship, añadido gossip para poder saltarse gunship, fix blood prince council
+ 31/07/13  [Iplay212] Fix Fishing & Fix Test Problema Evade
+ 31/07/13  [Iplay213] Wintergrasp: Implementadas las quest Victory in Wintergrasp, Toppling the Towers y Southern Sabotage
+ 01/08/13  [Iplay214] Fix Condicion en LoS
+ 01/08/13  [Iplay215] Update Binarias Resistencias
+ 02/08/13  [Iplay216] Custom implementamos comandos para los players
+ 02/08/13  [Iplay217] Quest Fixed 11593 The Honored Dead | Homenaje a los difuntos <Borean Tundra>.
+ 03/08/13  [Iplay218] Quest Fixed 11571 Learning to Communicate | Aprender a comunicarse <Borean Tundra>.
+ 03/08/13  [Iplay219] Quest Fixed 11560 Oh Noes, the Tadpoles! | ¡Oh no! ¡Los renacuajos! <Borean Tundra>.
+ 04/08/13  [Iplay220] Fixed problemas de Bladestorm Inmunidades
+ 04/08/13  [Iplay221] Fixed Quest: The Drakkensryd (12886)
+ 04/08/13  [Iplay222] Fixed Quest  Jormuttar is Soo Fat...
+ 04/08/13  [Iplay223] Fixed Veil Skith: Darkstone of Terokk (10839)
+ 04/08/13  [Iplay224] Fixed Quest  Steamtank Surprise
+ 04/08/13  [Iplay225] Fixed Quest  Blowing Hodir's Horn
+ 04/08/13  [Iplay226] Fixed Quest  Sniffing Out the Perpetrator
+ 04/08/13  [Iplay227] Fixed Spell spell Dark Command del DK, para que tenga un % de activar los encantamientos de runas de las armas.
+ 04/08/13  [Iplay228] Fix  Test Evade problem
+ 04/08/13  [Iplay229] Fix Beacon ahora podra ser usado en las pet's
+ 06/08/13  [Iplay230] Custom Implementamos juego de futbol custom para wow :3
+ 06/08/13  [Iplay231] Update a quest The Valiant's Challenge
+ 06/08/13  [Iplay232] Fixed  Quest  Decoy!
+ 07/08/13  [Iplay233] ICC: ahora las pets tambien recibiran los buf's de ICC
+ 07/08/13  [Iplay234] Update Custom vendedor de items by hold
+ 07/08/13  [Iplay235] Update Custom cerdoball
+ 07/08/13  [Iplay236] Custom implementamos comando custom por db para eventos de zonas poder hacerlas pvp o santuarias
+ 07/08/13  [Iplay237] Fix Quest  The Nightmare Manifests
+ 07/08/13  [Iplay238] Fix Quest  Fervor of the Frostborn
+ 07/08/13  [Iplay239] Cerdoball añadido ambiente (por Hold) más update a inmunidades.
+ 07/08/13  [Iplay240] Fix Quest  Riding the Red Rocket
+ 08/08/13  [Iplay241] Fix Quest  The Echo of Ymiron
+ 08/08/13  [Iplay242] Quest  Gorgrom the DragonEater
+ 08/08/13  [Iplay243] Quest  It Rolls Downhill
+ 08/08/13  [Iplay244] Fix[Quest] Adversarial Blood
+ 08/08/13  [Iplay245] Quest  The Black Knight's Fall
+ 08/08/13  [Iplay246] Fix Beacon
+ 08/08/13  [iPlay247] Quest Fixed 11681 Rescuing Evanor | Rescatar a Evanor <Borean Tundra>. (Soporte idiomas: enUS/esMX)
+ 08/08/13  [iPlay248] Custom Implementamos Comandos para que los players puedan modificar ellos su rate de leveleo.
+ 09/08/13  [iPlay249] Quest Fixed 11656 Burn in Effigy | Quema en efigie <Borean Tundra>.
+ 09/08/13  [iPlay250] Agregado ScriptedAI para npc 25522
+ 09/08/13  [iPlay251] Creadas todas las interacciones de los npc en Area 4028 Riplash Strand <Borean Tundra>.
+ 09/08/13  [iPlay252] Agregado soporte DB base en idioma esMX.
+ 09/08/13  [iPlay253] Fix [Quest] Back So Soon
+ 09/08/13  [iPlay254] Agregadas nuevas actualizaciones en Area 4028 Riplash Strand <Borean Tundra>.
+ 10/08/13  [iPlay255] Nombre del Core IplayWotlk adios TrinityCore =)
+ 10/08/13  [iPlay256] Update Fix a Quest The Drakkensryd ahora dara los creditos correspondientes
+ 10/08/13  [iPlay257] Fix Quest "No Rest For the Wicked"  basado en script incompletos de Kiperr, Kandera ,Jankic
+ 10/08/13  [iPlay258] Fix Quest  Killing Two Scourge With One Skeleton
+ 10/08/13  [iPlay259] Fix Achievement Leeroy
+ 10/08/13  [iPlay260] Fix Quests  I'm Not Dead Yet!  Let's Get Out of Here!
+ 10/08/13  [iPlay261] Fix Quest  Destroy the Forges!
+ 10/08/13  [iPlay262] Fix Final Spell Master Call Corrije errro de auto target
+ 10/08/13  [iPlay263] Fix Quest  A Suitable Disguise basado en script incompleto de Discover
+ 10/08/13  [iPlay264] Se implementan los bg's Mixtos
+ 11/08/13  [iPlay265] Agregadas nuevas actualizaciones en Area 4028 Riplash Strand (Parte 3) <Borean Tundra>.
+ 11/08/13  [iPlay266] Agregado ScriptedAI para los npc 26449,26451,25523,25520,26452 <Borean Tundra>.
+ 11/08/13  [iPlay267] Quest Fixed 11626 The Emissary | El emisario <Borean Tundra>.
+ 11/08/13  [iPlay268] Actualizacion Area 4106 Garrosh's Landing <Borean Tundra>.
+ 11/08/13  [iplay269] Actualizacion Area 4031 Pal'ea <Borean Tundra>.
+ 11/08/13  [iPlay270] Quest Fixed 11627 Boiling Point | Punto de ebullición <Borean Tundra>. (Soporte idiomas: enUS/esMX)
+ 12/08/13  [iPlay271] Quest Fixed Second Chances y fix sql's anteriores espacio final
+ 12/08/13  [iPlay272] Fix Quest From Whence They Came - An Undead's Best Friend
+ 12/08/13  [iPlay273] Fix Quest - Fuel For the Fire
+ 12/08/13  [iPlay274] Fix Quest - Fate of the Titans
+ 12/08/13  [iPlay275] Fix Quest - The Chain Gun And You
+ 12/08/13  [iPlay276] Fix Quest - The Halls of Reflection
+ 12/08/13  [iPlay277] Fix [Quest] Suppression
+ 12/08/13  [iPlay278] Fix Spell Master Call
+ 12/08/13  [iPlay279] Quest Fixed 11592 We Strike! | ¡Atacamos! <Borean Tundra>. (Soporte idiomas: enUS/esMX)
+ 13/08/13  [iPlay280] Fix typo en implementacion de comandos custom!
+ 13/08/13  [iPlay281] Wintergrasp: Limpiando NPCs y Gobject de la base de datos ya que estos son spawneados mediante el script de wintergrasp y provoca que hayan npc's duplicados
+ 13/08/13  [iPlay281] Comentamos una parte del fix de la spell master call que puede producir los errores de las spells de los hunters. esto esta comentado momentaneamente
+ 13/08/13  [iPlay282] Quest - Fury of the Frostborn King - The Master Explorer
+ 13/08/13  [iPlay283] Añadimos nuevas spells al sistema de fadeout
+ 13/08/13  [iPlay284] Fix Hp naves de Gunship by <Coso>
+ 13/08/13  [iPlay285] Añadido seguridad de comandos a gms por nivel
+ 14/08/13  [iPlay286] Fix Quest The Lost Mistwhisper Treasure
+ 14/08/13  [iPlay287] Wintergrasp:
+ Algunos ajustes en el sistema del campo de batalla, ligamos cada WorkShop con sus GameObjects y NPCs, ahora las torres del atacante se mostraran neutrales entre batallas, los npc de la fortaleza serán tele portados a su correspondiente lugar según corresponda y dependiendo de quién este controlando, ahora cuando se gana una batalla haciendo click en la Reliquia, se actualizarán los Worldstates para mostrar correctamente quien está controlando la fortaleza.
+ Ahora el temporizador de conquista de invierno será visible por los jugadores cuando ingresen a cualquier zona de rasgan norte
+ Ahora los NPC Maestro de hudú Fu'jin horda y Sorceress Kaylana mostraran la opcion para ver sus productos
+ Ahora actualizamos Tenacity cuando los player se retiran de la batalla o cuando salen de la zona de combate
+ 14/08/13  [iPlay288] Update Delay de vanish spell y un fix typo de esto.
+ 15/08/13  [iPlay289] Ruby Sanctum se solucionan los errores de daño de la base de datos, se añaden scripts base a los trash se solucionan inmunidades y se solucionan bugs reportados en los boss.
+ 15/08/13  [iPlay290] Fix phases en Halion
+ 15/08/13  [iPlay291] Solucionamos que el boss Saviana Ragefire cuando usa su spell conflagration la use volando no bajo el agua xD
+ 15/08/13  [iPlay292] Update daño Ruby Sanctum by <Hold>
+ 15/08/13  [iPlay293] Añadimos SAI a los trash de ICC
+ 15/08/13  [iPlay294] Fix Quest A Hero's Burden
+ 15/08/13  [iPlay296] Quest Fixed 11879 Kaw the Mammoth Destroyer | Kaw el Destructor de Mamuts <Borean Tundra>. (Soporte idiomas: enUS/esMX)
+ 15/08/13  [iPlay297] Fix Quest - Thel'zan's Phylactery
+ 15/08/13  [iPlay298] Update Gcd Delay añadimos a esto los atributos de disarm y silencios ahora estaran en este sistema
+ 15/08/13  [iPlay299] Quest Fixed 11897 Plug the Sinkholes <Borean Tundra>.
+ 15/08/13  [iPlay300] Resistencias binarios retrabajo, ahora trabajan para Criaturas & Guardian y mascotas & Arreglado el problema con resistencias binarios que cuando tenias el cap de SP te decia resist Aun Solucionado
+ 16/08/13  [iPlay301] Quest Fixed 12035 Repurposed Technology <Borean Tundra>.
+ 20/08/13  [iPlay302] Fix bug exploit en totem grounding totem no se eliminaba si estabas en LOS
+ 20/08/13  [iPlay303] Aumentamos el Limite de minerales en Northrend
+ 20/08/13  [iPlay304] Fix daÃ±o bosses ICC blizlike
+ 20/08/13  [iPlay305] AÃ±adido Anticheat
+ 20/08/13  [iPlay306] Dungeon Icecrown Citadel (ICC)
+ Saurfang corregido el rate de curaciÃ³n del Blood Link
+ Festergut el Inoculated entrarÃ¡ al acabarse el efecto de Blighted Spores
+ Festergut mejora del vile gas en modo 25man, 3 targets
+ Festergut arreglo del comportamiento de las Blighted Spores
+ Rotface inmunidad aÃ±adida a big oozes avoiding
+ Rotface inmunidades en Oozes
+ Rotface ajustes de estabilidad en la spell Large Ooze Combine
+ Rotface aÃ±adiendo funcionamiento correcto a slime spray
+ Putricide ahora al comenzar la pelea se acerca el
+ Putricide la spell Expunged Gas ahora no es inmune a hand of protection ni otras
+ Putricide las babosas ahora no se quedaran despues de un wipe
+ Putricide ahora choking gas bomb no stuneara a la abominacion
+ Putricide arreglo de las condiciones del vile gas en heroico
+ Putricide arreglado para que los mocos no cojan el mismo target
+ Putricide Ajuste de velocidades para babosas Gas Cloud de Putricide
+ Putricide Ooze channel no puede ser cancelado por taunt
+ 21/08/13  [iPlay307] ActualizaciÃ³n Area 4041 Kaskala <Borean Tundra>.
+ Creados ScriptedAI para los npc ( 25514,26452 ) <Borean Tundra>.
+ 21/08/13  [iPlay308] Quest Fixed 11728 Lupus Pupus <Borean Tundra>.
+ 21/08/13  [iPlay309] Solucionamos problema de  Dalaran Sewer el efecto para atras de la cascada
+ 22/08/13  [iPlay310] Final Fix Arena Ring of Valor.
+ 22/08/13  [iPlay311] Quest Fixed 11796 Emergency Protocol: Section 8.2, Paragraph D <Borean Tundra>.
+ 22/08/13  [iPlay312] Update a TargetedMovementGenerator fixeando el problema de evade  y un update al movimiento de pets
+ 22/08/13  [iPlay313] Fix daÃ±o de la gargola de DK (Ebon Gargoyle) se le agrega aura de haste ademas
+ 22/08/13  [iPlay314] Update TargetMovemgenerator fix collision
+ 24/08/13  [iPlay315] Actualizacion Area 4163 Icemist Village <Dragonblight>.
+ Creados ScriptedAI para los npc (26643,26616,26606) <Dragonblight>.
+ 22/08/13  [iPlay316] Fix Nature Grasp aÃ±adido cd interno.
+ 22/08/13  [iPlay317] Prevenimos poder usar Ice Block,Divine Shield y cyclone cuando estas con efecto de cyclone
+ 22/08/13  [iPlay318] Fix Quest - Plan B ahora podras lotear los cuerpos muertos
+ 22/08/13  [iPlay319] Ahora al salir de bg no saldras con fear o algunos dots raros.
+ 22/08/13  [iPlay320] Solucionamos que al estar cerca de pilares te mandan al vacio.
+ 22/08/13  [iPlay321] AÃ±adimos algunos check mas para el totem grounding totem y actualizamos el GCD y aÃ±adimos hack de velocidad para las pets
+ 22/08/13  [iPlay322] Update al tiempo de delay de la spell Flare
+ 22/08/13  [iPlay323] Fix Collision ahora si no ves al target con zonales no las podras usar.
+ 22/08/13  [iPlay324] Fix TargetMovemt ahora las pets no se podran meter en la collision.
+ 22/08/13  [iPlay325] Añadimos pasivo anticheat.
+ 27/08/13  [iPlay326] Actualizacion Area 4157 Moonrest Gardens <Dragonblight>.
+ 27/08/13  [iPlay327] Update al npc custom de vendedor de items para los migrados se agregan Shields by <Hold>
+ 27/08/13  [iPlay328] Update TargetMovemnGenerator denuevo arreglando bugs de collision
+ 27/08/13  [iPlay329] Arenas Espectador actualizamos el codigo añadimos posibles fix de crash y implementamos finalmente el espectador en bgs.
+ 27/08/13  [iPlay330] ICC Solucionamos que el impale se pueda curar.
+ 27/08/13  [iPlay331] Actualizamos tiempo de GCD a spell Flare
+ 27/08/13  [iPlay332] Hunter: Fix spell Roar of Sacrifice (Pet), ahora la mascota recibirá el 20% del daño causado al objetivo que tenga el efecto.
+ 27/08/13  [iPlay333] Añadimos que cuando te caigas al vacio vuelvas inmediantamente esto solo para arenas, para casos rarisimos que por alguna razon te puedes caer al vacio
+ 27/08/13  [iPlay334] Update Mirror Image, añadido spell Fireblast y  atacara al target que tiene seleccionado el owner primero y fix a los cc
+ 27/08/13  [iPlay335] Añadidmos Inmunidades a ICC
+ 01/09/13  [iPlay336] Fix Evade maldito
+ 01/09/13  [iPlay337] Fix para poder cruzar al romper la puerta de la camara de Wintergrasp
+ 01/09/13  [iPlay338] Update daño 2 npcs trash de ruby by hold y un fix de sql typo
+ 01/09/13  [iPlay339] Nuevo sistmea de anunciador de cola de bgs:
+ Nuevo sistema de anuncio configurable por # de pjs unidos a un bg queue
+ Nuevos textos para el Bg Queue ahora en una sola linea y mejorados
+ cambiando el anuncio amarillo feo por algo mas bonito, comenzando BG INFO
+ Parametro de configuracion independiente para darle mayor cantidad de opciones al momento de ajustar el broadcast privado vs el broadcast global
+ el player que apunta debe ver por una vez inicialmente como esta la cola
+ Nuevos textos para el started! de bg
+ 02/09/2013 [iPlay340] Fix Npc Stormwind City Patroller by Coso
+ 02/09/2013 [iPlay341] Fix quest To Fordragon Hold! by Coso
+ 02/09/2013 [iPlay342] Fix Crash en Spell Penetration
+ 02/09/2013 [iPlay343] Añadidas Inmunidades a  Killing spree
+ 02/09/2013 [iPlay344] Update a SMOOTH_PATH_SLOP para solucionar algunos problemas con los patch
+ 02/09/2013 [iPlay345] Update script Gunship Battle. correjimos bugs en Ai de los trash y añadimos OVERRIDE
+ 02/09/2013 [iPlay346] Update a CanDetectStealthOf tratando de arreglar el bug que los boss al pasar por puertas cuando escapan por wipes se qeudan ahi.
+ 02/09/2013 [iPlay347] Removemos Codigo que ya no es necesario para el Sistema de Espectador de arenas.
+ 02/09/2013 [iPlay348] Fix KnockbackFrom
+ 02/09/2013 [iPlay349] Sacamos el autotelport de la arena Ring of valor.
+ 02/09/2013 [iPlay350] Arreglado Dynamic LoS adecuado de algunos gameobjects.
+ 02/09/2013 [iPlay351] Fix Coeficiente en Empowered Renew
+ 07/09/2013 [iPlay352] Fix Crash en Object Stealth Detection y tratando de solucionar error de Dieguin.
+ 07/09/2013 [iPlay353] Fix proc de item Solace of the Defeated
+ 07/09/2013 [iPlay354] Fix Wandering Plague Combat
+ 08/09/2013 [iPlay355] Update Comandos Gm's by Hold
+ 08/09/2013 [iPlay356] Implementamos custom Script de Goku creado por Hold y correjido por mi, se necesita mas trabajo en el aun
+ 09/09/2013 [iPlay357] Fix Quest - Out of Body Experience
+ 09/09/2013 [iPlay358] Fix Quest - On Ruby Wings
+ 09/09/2013 [iPlay359] Fix Quest - He's Gone to Pieces
+ 09/09/2013 [iPlay360] Fix Quest chain - The Conquest Pit
+ 09/09/2013 [iPlay361] Fix Quest A Dire Situation
+ 09/09/2013 [iPlay362] Fix requerimientos previos[Quest] Congratulations
+ 09/09/2013 [iPlay363] Fix Questline Thassarian Skybreaker  by <coso> and Fix To FordragonHold  by <coso>
+ 10/09/2013 [iPlay364] Fix Spell Lifeblom
+ 10/09/2013 [iPlay365] Se añade S3 al vendedor custom de Iplay by <dezmond>
+ 10/09/2013 [iPlay366] Finfal fix de Pathfind ahora las creaturas crearan la ruta correcta (path) y no se quedaran pegadas por problemas con la linea de vision. ahora funciona a la perfeccion, fix en wincaca de problemas en las variables.
+ 19/09/2013 [iPlay367] Hack para Ice Tomb de ICC - Sindragosa Encounter. Solucionamos algunos problemas con la visibilidad .
+ 19/09/2013 [iPlay368] buscar battlegroundAV para algunos objetos que sólo se activan después de gots mineros capturados por el propio equipo.
+ 19/09/2013 [iPlay369] Fix resilience blizlike
+ 19/09/2013 [iPlay370] Fix compile
+ 19/09/2013 [iPlay371] Update Spells y Mecanicas:
+ Update distancia de duelo
+ Añadida HolyRes
+ Otro hack fix solucionado de AV
+ Fix crash en arena espectador. update
+ Update al Sistema de GCD delay en spells.
+ Fix Grounding totem
+ Fix Glyph of Polymorph
+ Fix exploit Hungering Cold
+ Fix Item - Living Ice Crystal
+ Fix problemas de resistencias
+ Fix en chequeos de LoS
+ 20/09/2013 [iPlay372] Fix Quest - The Last of Her Kind
+ 20/09/2013 [iPlay373] Fix de algunos typos en sql errores wns xD
+ 20/09/2013 [iPlay374] Quel'Delar: Isle of Quel'Danas spawn y spell area y fases de npcs, faltantes
+ 20/09/2013 [iPlay375] Fix Quest - Foundation for Revenge
+ 20/09/2013 [iPlay376] Update StatSystem/Pets
+ Fix Fel Vitality.
+ Fix Wild Hunt HP.
+ Pet ya no tienen resistencia Holy.
+ Fix Hp Ebon Gargoyle
+ Fix Hp Mirror Image
+ 20/09/2013 [iPlay377] Fix Spell Dancing Rune Weapon DK
+ 20/09/2013 [iPlay378] Update Formula Execute Warrior un poco mas blizlike
+ 20/09/2013 [iPlay379] Fix spell entrapment Hunter & Update a check para Master Call en caso de no ver la pet o que este muerta
+ 20/09/2013 [iPlay380] Check para hacer que desaparesca de forma correcta el Elemental con el Glyph of Eternal Water
+ 21/09/2013 [iPlay381] Fix Warnings en compilacion
+ 21/09/2013 [iPlay382] Soporte Completo a Evento Brewfest
+ 21/09/2013 [iPlay383] Fixed crash en boss coren direbrew Brewfest evento
+ 21/09/2013 [iPlay384] Brewfest: Solucionamos que el boss tenga que ser insultado antes de empezar la batalla. se agrega a la base de datos la faction de amigable para que no ataquen y es removida despues de insultarlo por el core.
+ 21/09/2013 [iPlay385] Fix Quest - Thalorien Dawnseeker
+ 21/09/2013 [iPlay386] Final fix Lifebloom explosion
+ 21/09/2013 [iPlay387] Algunos update faltantes de quest que no fueron agregados, fix crash de npc 25987. y limpieza estilo de codigo de Gunship
+ 21/09/2013 [iPlay388] Update al combinador de sql's
+ 23/09/2013 [BattleCore389] Fixed ctrlf de algunos sql's de la carpeta Iplay para que funcionen bien con el combinador.
+ 23/09/2013 [BattleCore390] Añadimos Addon de Arena Espectador
+ 24/09/2013 [BattleCore391] Removimos Soporte de Armory del core.
+ 24/09/2013 [BattleCore392] Solucionamos Problema de Quest - The Halls of Reflection el npc no tenia el equipo adecuado.
+ 24/09/2013 [BattleCore393] Fix Quest Rough Ride (12536)
+ 24/09/2013 [BattleCore394] Fix Quest The Champion Of Anguish Blizlike incluye vehiculo
+ 24/09/2013 [BattleCore395] Fix Quest There's Something About the Squire ahora Maloric se podra lotear y te dara el objeto
+ 24/09/2013 [BattleCore396] Ahora para entrar a una Arena o Bg, los players seran desmontados y se les hara dismiss a las pets evitando exploits y problemas en arenas
+ 24/09/2013 [BattleCore397] Añadimos Spawn de Boss Coren Direbrew mas su correspondiente linkeo a el gameevent.
+ 24/09/2013 [BattleCore398] Removimos la carpeta Full de lo Sql's, correjimos la ruta del combinador de sql para las traduciones de las tablas a español.
+ 24/09/2013 [BattleCore399] Añadimos script de tienda (redeem)
+ 24/09/2013 [BattleCore400] Añadimos sistema de Houses
+ 24/09/2013 [BattleCore401] Añadimos sistema de Eventos (control de spawns)
+ 24/09/2013 [BattleCore402] Añadimos comandos de Eventos, Houses, tienda y otros
+ 24/09/2013 [BattleCore403] Añadimos tablas de Eventos y Houses
+ 24/09/2013 [BattleCore404] Actualizamos el Combinador de Sql's con la carpeta battlecore
+ 24/09/2013 [BattleCore405] Incluimos los PrepareStatement de Houses y Events
+ 25/09/2013 [BattleCore406] Jugabilidad - Dalaran Sewers: Corregida la posición de Shadow Sight en la arena.
+ 25/09/2013 [BattleCore407] DK: Fix spell Death Grip, ahora no se podra usar si el DK esta saltando o cayendo.
+ 25/09/2013 [BattleCore408] DK: Fix spell Death Grip, previniendo que se aplique el efecto de atraer al objetivo si este lo refleja
+ 25/09/2013 [BattleCore409] DK: Fix spell Raise Dead, ahora requerirá el componente necesario, el glifo o un cadaver cercano (y pasado a spell_script)
+ 25/09/2013 [BattleCore410] Evento/Brewfest: Fix posible crash en Coren Direbrew
+ 25/09/2013 [BattleCore411] Quest: Fix Credito de final quest de Dk Light Of Dawn
+ 26/09/2013 [BattleCore412] Quest: Fix Quest - Unexpected Results
+ 26/09/2013 [BattleCore413] Aplicamos sistema de Eventos a comandos .npc add, .npc del, .gobject add, .gobject del
    + Ademas bloqueamos los comandos .npc add, .npc add temp, .npc del, .gobject add, .gobject del, en mapas instanceables.
+ 26/09/2013 [BattleCore414] Añadimos reciclador de GUIDs de Creatures y GameObjects
+ 26/09/2013 [BattleCore415] Evento Brewfest Solucionamos Reward de DF en boss Coren Direbrew, añadimos unos float faltantes en el codigo.
+ 27/09/2013 [BattleCore416] Spell Rake ahora ignora la armadura
+ 27/09/2013 [BattleCore417] Warrrio: Los guerreros pueden usar algunos hechizos inmediatamente despues de cambiar las armas, pero probablemente no es un hechizo. (Temporal Solucion)
+ 27/09/2013 [BattleCore418] Mecanica: Se actualiza la funcion CalculateSpellDamageTaken con los  calculos de las resistencias de absorciones correspondientes a cada caso.
+ 27/09/2013 [BattleCore419] Paquete de teletransportacion, corregido.
+ 27/09/2013 [BattleCore420] Spell: Death Knight runeforging no necesitas estar cerca de la runeforge
    + DK: Fix Spell Explode ahora funciona como corresponde
+ 27/09/2013 [BattleCore422] Update Custom Transmodificador:
    + Se renombra la tabla adoptando el estilo de la tabla actual
    + Se traducen los string a español.
+ 28/09/2013 [BattleCore423] Battlegrounds: Implementamos Custom Feature para AFk's en bg.
    + Al reportar a un player afk ahora se le pone un aura que le da un 1 minutoto para entrar en combate si este no entra en ese minuto lo saca del bg añadiendo un aura afuera por afk =)
+ 28/09/2013 [BattleCore424] Fix Fishing, se soluciona el problema de que al estar dentro del agua no se podia pescar.
+ 28/09/2013 [BattleCore425] Fix crash en SmartAI::EnterEvadeMode.
+ 28/09/2013 [BattleCore426] DK: Fix spell Death grip ahora el efecto de velocidad de atraer y la elevacion sera la correcta, se asemeja al comportamiento en bliz
+ 28/09/2013 [BattleCore427] Pets: Fix pet ahora atacaran cuando estan en la stance pasiva
+ 29/09/2013 [BattleCore428] Wintergrasp: Solucionamos los portales de Winter como requerimiento que si tu faccion no controla winter no puedas entrar, ademas se añade un check dentro de VOA para evitar exploit de que otra faccion entre a VOA si no la tiene controlada
+ 29/09/2013 [BattleCore429] Typo, dedos rapidos me falto agregar el sql del commit anterior 9e45ba09d
+ 29/09/2013 [BattleCore430] AzjolNerub/Ahnkahet/Taldaram: Fix al daño de la spell flame sphere.
+ 29/09/2013 [BattleCore431] Battleground/EoE: Fix exploit que los players podian salir de la burbuja antes de empezar el bg. (base de Topbmas Modificado por mi).
+ 29/09/2013 [BattleCore432] Pet: Fix avoidance en las pets, ahora tendran 90% de daño de reduccion
+ 29/09/2013 [BattleCore433] Custom: Añadimos flag para quitar el pathfindig atravez de flag extra de algunas creaturas.
    + Ejemplo:
        + Para quitar bits usar: UPDATE `creature_template` SET `flags_extra` = `flags_extra` &~ 0x20000000 WHERE `entry` IN( ... );
        + Para añadir usar : UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x20000000 WHERE `entry` ='';
+ 29/09/2013 [BattleCore434] Teleport: removemos IMPAIRMENT_AND_LOSS_CONTROL cuando el player utiliza Player::TeleportTo function. (cambio para teleport de winter y otros)
+ 29/09/2013 [BattleCore435] Custom: Mejoramas el Script Custom de poder hablar con la faccion contraria en dalaran en la zona Circle of Wills - PvP zone, ahora sera por config para activarla o desactivarla.
+ 29/09/2013 [BattleCore436] Battlegrpund/Sota: Fix LoS entre las puertas al ser destruidas.
+ 29/09/2013 [BattleCore437] Data de Houses
+ 29/09/2013 [BattleCore438] Fix de algunos typos de errores de Sql's de iplay (por updates de TC)
+ 29/09/2013 [BattleCore439] Añadimos estructura de tabla battle_redeem_item_template
+ 29/09/2013 [BattleCore440] NPC "Warden" de House
+ 29/09/2013 [BattleCore441] Typos en sqls de BattleCore
+ 29/09/2013 [BattleCore442] Añadimos columna 'points' en account, para nuevo sitio de Battle.cl
+ 29/09/2013 [BattleCore443] Desactivamos script de estado de tienda, que solo es aplicable al nuevo sitio de Battle.cl
+ 29/09/2013 [BattleCore444] Solucionamos Spell Penetration en las pets
+ 29/09/2013 [BattleCore445] Movemos el Evento Brewfest A la carpeta Events. eliminamos un npc custom que no se necesitara Npc Vote points.
+ 29/09/2013 [BattleCore446] Añadimos Completo Soporte al evento Hallowen.
+ 30/09/2013 [BattleCore447] Activamos carga de Events y Houses. Correccion de compilacion.
+ 30/09/2013 [BattleCore448] Fix typos sql Hallowen. disculpen.
+ 30/09/2013 [BattleCore449] Añadimos NPC Redeem (Corresponde al que entrega las ordenes de la tienda)
+ 30/09/2013 [BattleCore450] Añadimos Vendedor de Armas Furius
+ 30/09/2013 [BattleCore451] Correcciones en data de Houses
    + Se borro House que no lo era en realidad
    + Se actualizaron entrys de NPC customs y se aniadieron templates
    + Se corrigieron typos y estilo
+ 30/09/2013 [BattleCore452] Update Combinador de sql's con la nueva estructura de las carpetas de Battlecore
+ 01/10/2013 [BattleCore453] Actualizamos los sql De Iplay con los update de TC.
+ 01/10/2013 [BattleCore454] Final Actualizacion de la carpeta Iplay con la nueva estructura de TC. (Maldito Ssp y sus cambios).
    + Falta mover los comandos el codigo comentado a un sql de Auth Update
+ 01/10/2013 [BattleCore455] Se añade sql update Auth con los cambios de los comandos custom mas documentacion de entrys(permissionId) custom utilizados
+ 01/10/2013 [BattleCore456] Correccion de tipos de datos en sistemas Events y Houses
+ 01/10/2013 [BattleCore457] SQL/Data: Guild Shirts
+ 01/10/2013 [BattleCore458] SQL/Data: Event implementado a Redeem y Furius Vendor
+ 01/10/2013 [BattleCore459] Solucionamos el problema de los sql de la carpeta iplay que se visualizaban de forma saltada
+ 01/10/2013 [BattleCore460] SQL/Data: Actualizamos el guid acordado a utilizar
+ 01/10/2013 [BattleCore461] Añadimos informacion detallada de sistemas Event y House en .npc info, .gobject target y .wowcl house info
+ 01/10/2013 [BattleCore462] SQL/Data: Transmogrifier
+ 02/10/2013 [BattleCore463] Añadimos filtro de log para sistema Event y corregimos maximo filtro
+ 02/10/2013 [BattleCore464] Actualizamos entry del NPC_HOUSE_WARDEN
+ 02/10/2013 [BattleCore465] Eliminamos grito de Wardens de House
+ 02/10/2013 [BattleCore466] Añadimos metodo de seguridad a .gobject add temp y .npc add temp
+ 02/10/2013 [BattleCore467] SQL/Data: Disables mmaps
+ 02/10/2013 [BattleCore468] SQL/Data: Permitimos multiples semanales de instancias
+ 02/10/2013 [BattleCore469] Actualizamos nombre del Core :B
+ 02/10/2013 [BattleCore470] README: Nombre del Core actualizado
+ 02/10/2013 [BattleCore471] Sistema Save mejorado
    + Los jugadores seran guardados de 5 en 5 cada 1 segundo aprox; con esto 1500 jugadores se guardarian progresivamente en 5 minutos.
    + Al completarse el loot en instancias se guardaran todos los jugadores, o el loot master unicamente.
    + Se redujo el save con quest, a solamente la completacion de esta.
+ 02/10/2013 [BattleCore472] Sql's Iplay:
    + Se añade a los custom entry la guid numerica acordada
    + Se actualiza el Wiki https://github.com/BattleCL/BattleCore/wiki
    + Se añade sintexis adecuada de algunos sql's
    + Se remueve el sql del transmodificador ahora esta en la carpeta de battle.
    + Combinador de Sql:
        + Se añade orden de colacion de sql's al generador
+ 02/10/2013 [BattleCore473] Mmaps:
    + Actualizamos Forzamos los path en arenas
    + Se agrega hack para conecion de path en las arenas de bladedge para correcto recorrido
    + Se corrijen posibles bugs de los pilares.
    + Se añade una limpieza de movimiento mas aura cuando el player esta bajo efectos de aturdimiento, estun o fear.
+ 02/10/2013 [BattleCore474] Actualizamos Los comandos custom al nuevo sistema de rbac
+ 02/10/2013 [BattleCore478] Actualizamos commandos .bc al sistema rbac
+ 02/10/2013 [BattleCore479] Corregimos roleId en consulta
+ 02/10/2013 [BattleCore480] Core/Spells: Fix spells con force reaction effect (SPELL_AURA_FORCE_REACTION).
+ 02/10/2013 [BattleCore481] Fix typo en teletranportacion de npc's que se caian al vacio
+ 02/10/2013 [BattleCore482] SQL/Data: Dejamos los eventos visible por default
+ 03/10/2013 [BattleCore483] SQL/Data: Corregimos guids de wardens en House
+ 03/10/2013 [BattleCore484] typo en de tiempo restante en House info
+ 03/10/2013 [BattleCore489] Log de Cambio de Nombre y Raza
+ 03/10/2013 [BattleCore490] Log de Comandos y Trades
+ 03/10/2013 [BattleCore491] Correccion de carpeta de estructuras anteriores
+ 03/10/2013 [BattleCore492] Corregimos algunos valores de configuraciones por default
+ 04/10/2013 [BattleCore493] Final Fix de mmaps y vmaps no se por que esto estaba comentado grrr fix typo
+ 04/10/2013 [BattleCore494] Revertimos [BattleCore467]
+ 04/10/2013 [BattleCore495] Corregimos comando .mmap path
+ 04/10/2013 [BattleCore496] Solucion al problema de las pets que se movian de izquierda a derecha en stay.
+ 04/10/2013 [BattleCore497] Posible crash, nos aseguramos que nunca suceda un crash con transportes. (Cambio para asegurar Gunship).
+ 04/10/2013 [BattleCore498] Se desactiva el Script de los iconos alliance y horde en los canales.
+ 04/10/2013 [BattleCore499] Warrior: Fix exploit Sum Of Enrage  y proc de Wrecking Crew (stack de enrage).
+ 04/10/2013 [BattleCore500] Mmaps/Pet:
    + Fix al contacto de las pets con las paredes. no mas pets metidas en las texturas.
    + Se corrije la distancia de movimiento de las pets.
+ 04/10/2013 [BattleCore501] Añadimos al ignore del git los archivos generados por el combinador de sql
+ 04/10/2013 [BattleCore502] Fix typos de requerimiento de quest en evento Hallowen ahora funciona bien el evento de proteger las ciudades
+ 04/10/2013 [BattleCore503] Mejora en MovePositionToFirstCollision
    + Desde Position pos, buscara la primera collision. Posteriomente desde Position pos hasta la posicion distancia de colision revisar que la ruta sea factible, fraccionando el destino y revisando que cada fraccion sea accesible.
    + Nota: Este cambio no influye en el rendimiento de MMAPS, ya que la funcion es utilizada generalmente con distancias de contacto, pero si evitara ciertas incidencias, con bordes del mapa o charges a una posicion en el aire.
+ 05/10/2013 [BattleCore504] Core/Object: Corregimos el angulo, para mejor comprension y un typo
+ 05/10/2013 [BattleCore505] Anticheat: Reestructuracion de funcionamiento de anticheat pasivo.
+ 05/10/2013 [BattleCore506] Script/Custom: Corregimos consulta de Redeem y la hacemos sincronica
+ 05/10/2013 [BattleCore507] Crash fix en Houses corregido
+ 06/10/2013 [BattleCore508] Actualizamos comandos de iplay a BattleCore (nombres en info)
+ 06/10/2013 [BattleCore509] Portamos Ulduar completo. (Funcional 80%)
    + Requiere un testeo en detalle
    + Estilo de codigo y mejoras en progreso.
+ 06/10/2013 [BattleCore510] Anticheat: Cambios finales para produccion.
+ 06/10/2013 [BattleCore511] Core/Movement: Corregimos la recalculacion de MMAPS sobre OffMeshPaths
+ 06/10/2013 [BattleCore512] Core/Movement: Permitimos saltar desde una superficie superior a una inferior, si esta es accesible.
+ 06/10/2013 [BattleCore513] Script/Halion:
    + Movemos el chequeo de los jugadores a un evento.
    + Berserker debe renovarse cada 5 minutos.
+ 06/10/2013 [BattleCore514] Core/Object: Añadimos mejora de zLOS en MovePosition
+ 06/10/2013 [BattleCore515] Core/Movement: Corregimos el angulo final de Charge con MMAPS
+ 06/10/2013 [BattleCore516] Core/Movement: Correccion final a orientacion final de charge
+ 06/10/2013 [BattleCore517] SQL/Ulduar: Agregando scriptnames de npc faltantes.
    + Aun faltan algunos que no encontre a que asignarlos.
+ 06/10/2013 [BattleCore518] Correccion de compilacion por commit anterior
+ 06/10/2013 [BattleCore519] Core/Movement: Evitamos que la criatura pueda ser atacada mientras retorna a su home position
+ 06/10/2013 [BattleCore520] Scripts/Custom: Removemos script y criaturas que no se plicaran inmediatamente.
    + Ademas limpiamos un poco el cambiador de anillos
    + Tambien hacemos que el reset de duelos no funcione estando en la ciudad enemiga
+ 07/10/2013 [BattleCore521] Scripts/Ulduar: correjimos los ultimos errores de Scriptname no asociados a la DB.( Nota solo queda un logro comentado que hay que buscar la criteria para anexarlo a la DB)
        + Se vincula un scriptname a la db del evento de Hallowen
+ 07/10/2013 [BatteCore522] Revertimos [BattleCore497] por bug ocasionado
+ 07/10/2013 [BatteCore523] Core/Mecanica: Correjimos un problema que los minions summon de creaturas en el mundo tenian un nivel de daño en spell super elevado para su nivel.
    + Ejemplo minions de lakeshare.
+ 07/10/2013 [BattleCore524] Core/Scripts: Solucionamos un problema en la dungeon Halls of Reflection ocurrido por la implementacion de la quest Halls Of Reflection ya que usaban el mismo Area Triger añadido soporte para quest e insta.
+ 08/10/2013 [BattleCore525] Core/Events/SQL: Solucionamos unos problemas de Scriptname asociados al script de Hallowen.
+ 08/10/2013 [BattleCore526] Core/Script: Gundrak: Realizamos que en el boss morabi solo la spell Transformation pueda ser cortada en el combate.
+ 08/10/2013 [BattleCore527] Core/Script: Solucionamos un exploit en la quest Death's Challenge de la cadena de DK, se podia hacer el duelo siempre con el mismo DK.
+ 08/10/2013 [BattleCore528] Quest/SAI: Fix Quest Icecrown: It's All Fun and Games
+ 08/10/2013 [BattleCore529] Quest/SAI: Fix Quest Icecrown: Free your Mind
+ 09/10/2013 [BattleCore530] Actualizacion Area 4157 Moonrest Gardens <Dragonblight>.
+ 09/10/2013 [BattleCore531] Core/PetAI: Solucionamos el combate de las pet's en el owner tanto para pvp/pve. se añade exepciones de spell que no dejaran en combate al player tanto owner como atacante. (Se requiere un testeo profundo)
+ 10/10/2013 [BattleCore532] Core/Mecanica:
    + Ajustamos el tiempo de CCdelay mas blizlike.
    + Solucionamos un problema con las trampas relatado por el CCdelay
    + Solucionamos Sight Arena.
    + Los bufs de los battlegrounds sacan de stheal e invisible.
    + Removemos un hack fix de Sight Arena
    + Solucionamos remover stheal en AoE Damage (cuando absorves) Hack Fix
    + Corregimos algunos comentarios erroneos typos
    + Implementamos 2 funciones custom para reutilizacion
        + CustomRefreshTimmer sera utlizada en ICC mas adelante.
        + Implementamos SPELL_ATTR0_CANT_BREAK_STEALTH
+ 10/10/2013 [BattleCore533] Core/Script:
    + ICC:
        + Implementamos evento Purticude Traps.
        + Solucionamos que las pets si reciban el buff de icc. (fix typo de un fix para esto implementado en  [Iplay-233] 19521d2cf0
        + Añadimos una condicion para la spell Ice tom en Sindragosa
        + Solucionamos el daño de la spell Bone Storm de Marrowar
        + Se añade un check de inmunidades para marrowar cuando haga bladestorm no se puede tauntear.
+ 10/10/2013 [BattleCore534] Sql: Solucionamos algunos typos en los sql's
    + ultimo Scriptname faltante del evento de hallowen.
    + convertimos algunos sql a utf8-sinbom (requerido para textos en español)
    + Estilo en algunos sql's.
+ 10/10/2013 [BattleCore535] Actualizacion Area 4225 Glittering Strand <Dragonblight>.
+ 11/10/2013 [BattleCore536] Update Logo del Core By Simon
+ 12/10/2013 [BattleCore537] Core/Mecanica:
    + Implementamos Objeto visibilidad delay y Stheal
    + Algunas correciones al sistema de fadeout
    + Correciones a vanish
    + Movemos Fix de Hand of Reckoning Damage a spell linked
    + Fixed Dragon & Living bomb explode
    + Actualizamos el tiempo de Gcddelay y removimos algunas.
+ 12/10/2013 [BattleCore538] Core/Custom: Actualizamos Mensaje del Cristal de Arenas
+ 12/10/2013 [BattleCore539] Core/Tool: Añadimos al combinador de sql la carpeta battlecore\auth\data
+ 12/10/2013 [BattleCore540] Core/Unit: Si el objetivo esta volando, no debe ser accesible por una criatura terrestre. (Blizzlike)
+ 12/10/2013 [BattleCore541] Core/Script: Se remueve soporte de ICC de algunas spells, ya que TC las soluciono de otra manera.
+ 12/10/2013 [BattleCore542] Core/Movement: Se soluciona un exploit reportado en TC.
    + Basically with MMaps, on any server I've seen with it including TrinityCores latest implementation of the system, there's an exploit where you can fly above the creatures range. If the creature does not have flying, he will stand idly at your feet while you cast spells on him.
+ 12/10/2013 [BattleCore543] Core/Script: Sons of Hodir: Fix Quest Battling the Elements
+ 12/10/2013 [BattleCore544] Actualizacion Area 4160 Lothalor Woodlands <Dragonblight>.
+ 12/10/2013 [BattleCore545] Core/Unit: Añadimos comentarios, check faltante, y evitamos generar demasiada carga
+ 12/10/2013 [BattleCore546] Scripts/Custom: Redeem
    + Correccion de Houses disponibles
    + Reactivamos anunciador de ordenes pendientes, y puntos
+ 12/10/2013 [BattleCore547] Scripts/Custom: Custom Rates desactivado por inestable
+ 13/10/2013 [BattleCore548] Core/Movement: Revertimos parte del commit [BattleCore512]
+ 13/10/2013 [BattleCore549] Core/SQL:Ignorar mmaps en los siguientes npcs (path - paths - pathfinding)
+ 13/10/2013 [BattleCore550] Scripts/Custom: Correcciones y limpieza
    + Reorganizacion de algunos archivos (he dejado una separacion entre los revisados y los que no)
    + Correccion en la ubicacion de custom script en ScriptLoader.cpp
    + Se han añadido correcciones de cuando es posible usar el item Arena Battlemaster Summoner
    + Eliminamos el Vendedor del item item Arena Battlemaster Summoner, sera ubicado en otro, removemos los items que se vendian junto a este y he actualizado el id del item
    + Mejoramos la mensajeria del NPC Redeem y su sistema de memoria
+ 13/10/2013 [BattleCore551] Script/Custom: Correcciones en returns, y GOSSIP_ICON_TALK removido por extraño error ocasionado.
+ 13/10/2013 [BattleCore552] Core/Spell: Warrior: Fixeamos un exploit de la spell TitanGrip ahora si reducira el daño en un 10% en los stats como debe ser.
+ 13/10/2013 [BattleCore553] Script/Custom: typo en ADD_GOSSIP_ITEM_EXTENDED de NPC Redeem
+ 13/10/2013 [BattleCore554] Core/Object: Sistema de visibilidad
    + Dos WorldObjects pueden verse mutuamente si:
        + Tiene la "lista" de visibilidad vacia (Puede darse en todos los casos)
        + Tiene al jugador visible en la "lista" (Solo en el caso: Unit::IsEventVisibleFor(Player) o GameObject::IsEventVisibleFor(Player))
        + Tienen algun jugador en comun para el cual sea visible en los dos (Solo en el caso: Unit::IsEventVisibleFor(Unit) o GameObject::IsEventVisibleFor(GameObject) o Unit::IsEventVisibleFor(GameObject) o GameObject::IsEventVisibleFor(Unit))
        + Ambos pueden verse a la vez (Valga la redundancia, me refiero la comprobacion de WorldObject::CanSeeOrDetect)
+ 13/10/2013 [BattleCore555] Script/Custom: Hacemos que el NPC invocado por el item Arena Battlemaster Summoner, sea visible solo para el invocador
+ 13/10/2013 [BattleCore556] Correccion de compilacion
+ 13/10/2013 [BattleCore557] Fix typo de Sql 773e4ce1e (175_Ignorar_Path_Finding[World].sql)
+ 13/10/2013 [BattleCore558] Core/Build: Fix warning compilacion.
+ 14/10/2013 [BattleCore559] Core/Mecanica:
    + Solucionamos un bug con las tramas + delay.
    + Se corrije la spell Ice barrier - dispel/absorb remove
    + Se corrije el delay de la spell Vanish
    + Se añade una condicion mas para el fix de la spell Hand of Reckonin
+ 15/10/2013 [BattleCore560] Actualizacion Area 4166 Lake Indu'le <Dragonblight>.
+ 16/10/2013 [BattleCore561] Core/Spell: Correccion de blink por Z LOS
+ 16/10/2013 [BattleCore562] SQL/Struct: Correcion de tipo de dato en Houses
+ 16/10/2013 [BattleCore563] Core/Quest: Fix crash en Quest 11627 npc_churn::npc_churnAI By <Diego>
+ 16/10/2013 [BattleCore564] Core/Quest: Argent Tournament - Movemos soporte de Quest The Aspirant Challenge a SAI
+ 16/10/2013 [BattleCore564] Core/Quest: Argent Tournament - Modificamos toda la linea de Quest. (Se Soluciona Reporte  http://www.battle.cl/foros/index.php?/topic/6143-quest-argent-tournament/)
+ 16/10/2013 [BattleCore565] Core/Quest: Fix typo en 5d53026608d2 (BattleCore563)
+ 16/10/2013 [BattleCore566] Sql Faltante de commit 094630672 (BattleCore564)
+ 16/10/2013 [BattleCore567] Core/Spell: Solucionamos Finalmente el Boom del LifeBlom esta parte es la final de los siguiente fix : 78b2874ba198 - 5a3388a0 (Reportado en http://www.battle.cl/foros/index.php?/topic/6133-lifebloom/#entry44681)
+ 17/10/2013 [BattleCore568] Core/Spell: Solucionamos problema de Anti-magic Shell ahora es Inmune a magical aura effects, poisons, diseases  y sus correspondientes exepciones (Reportado en  http://www.battle.cl/foros/index.php?/topic/6146-caparaz%C3%B3n-antimagia/)
+ 17/10/2013 [BattleCore569] Core/BG: Revertimos Soporte de alterminar bgs te da un emblema de las instas tbc. (Commit relacionados 2609fce41426b3c - 8b01a6dcbd9f758f - 154c68b528aa7).
+ 17/10/2013 [BattleCore570] Core/Spell: Chaos Bolt no puede ser resistido, y atraviesa todos los efectos de absorción. http://www.wowhead.com/spell=77069/chaos-bolt
+ 17/10/2013 [BattleCore571] Core/Spell: Druid Treants Debe tener una probabilidad de dejar dazeado con el talento Brambles
+ 17/10/2013 [BattleCore572] Core/Quest: Argent Tournament -Solucionamos la Quest The Grand Melee (Reportada en http://www.battle.cl/foros/index.php?/topic/6164-quest-argent-tournament-the-grand-melee/)
+ 17/10/2013 [BattleCore573] Core/Quest: Fix Quest - Tempering the Blade (Reportada en http://www.battle.cl/foros/index.php?/topic/6156-templar-la-hoja/)
+ 17/10/2013 [BattleCore574] SQl: Actualizamos el pool de los minares de Northrend
+ 17/10/2013 [BattleCore575] Core/Script: Fix crash de boss Headless Horseman.
+ 17/10/2013 [BattleCore576] Core/Script: Solo debe ser recompensado una vez, referencia a [BattleCore575]
+ 17/10/2013 [BattleCore577] Core/Spell: Se soluciona el problema de la Skill Animal Handler ahora dara el 10% de attack power a la pet (Reportado en http://www.battle.cl/foros/index.php?/topic/6167-animal-handler/)
+ 17/10/2013 [BattleCore578] Core: rever temporal a BattleCore570 a1f588a92e
+ 18/10/2013 [BattleCore579] Core/Spell: Fix Divine Guardian. Typo Gracias Lim por el cath
+ 18/10/2013 [BattleCore580] DB/SOTA: Solucionamos que los tanques de sota al bajarse se regeneren de vida. (Reportado en http://www.battle.cl/foros/index.php?/topic/6163-sota-bug-tanques/#entry44806)
+ 18/10/2013 [BattleCore581] Core/Spell: Fix Master's Call (revisar hack)
+ 18/10/2013 [BattleCore582] Core/Object: Fix gameobject la interacion con objetos questgivers type (GAMEOBJECT_TYPE_QUESTGIVER).
+ 18/10/2013 [BattleCore583] Core/Spell: Añadimos el decremento de armor con talento enrage de druida
+ 18/10/2013 [BattleCore584] Core/Spell: Inner Fire no se debe activar cuando el priest tiene activo Power Shield
+ 18/10/2013 [BattleCore585] Core/Spell: Fixed typo de trampas en pve relacionado con BattleCore559 (Soluciona http://www.battle.cl/foros/index.php?/topic/6165-trampas/)
+ 18/10/2013 [BattleCore586] Core/Spell: añademos delay a combi SP -> tel. delay y un check mas al fix de Hand of Reckoning
+ 18/10/2013 [BattleCore587] Core/Spell: Fix Stack de Aspect (Hunter)
+ 18/10/2013 [BattleCore588] Core/Pet: Se soluciona el daño bajo de las pets con una formula que requiere pulirse en el coefeciente (Se soluciona http://www.battle.cl/foros/index.php?/topic/6222-da%C3%B1o-de-las-pet-bajisimo/)
+ 18/10/2013 [BattleCore589] Core/Quest: Argent Tournament -  Se soluciona la Quest - Among the Champions (Soluciona http://www.battle.cl/foros/index.php?/topic/6213-quest-argent-tournament-among-the-champions/).
+ 18/10/2013 [BattleCore590] SQl: Fix de unos typo en condicion del sql de Hallowen, se mostraba en la consola del worldserver.
+ 18/10/2013 [BattleCore591] SQl: añadidas nuevas condicciones al evento de Hallowen. y se mueven algunas condiciones a otros typos para mejor funcionanmiento.
+ 18/10/2013 [BattleCore592] SQL/Data: Añadimos item Arena Battlemaster Summoner a npc Redeem
+ 18/10/2013 [BattleCore593] Scripts/Custom: Añadimos menu de vendor a npc Redeem
+ 18/10/2013 [BattleCore594] Parte faltante en el commit anterior
+ 18/10/2013 [BattleCore595] Parcial Fix crash en StaticMapTree::isInLineOfSight
+ 18/10/2013 [BattleCore596] Movemos el fix de Hand Of Reckoning a db.
+ 18/10/2013 [BattleCore597] Eliminamos el anuncio de una persona saliendo de la arena y "embellecemos" el mensaje.
+ 18/10/2013 [BattleCore598] typo en NPC Redeem
+ 18/10/2013 [BattleCore599] Clear menu olvidado en NPC Redeem
+ 19/10/2013 [BattleCore600] Crash hack fix, para algunas aserciones de VMAP
+ 19/10/2013 [BattleCore601] Correccion a BattleCore581 en check y aplicacion de efectos
+ 20/10/2013 [BattleCore602] Corregimos incidencia con Cambio de Nombre, y opcion de vendedor.
+ 21/10/2013 [BattleCore603] Core/Script: Evento Hallowend
    + Se reescribe Headless Horseman
    + Se añade compatibilidad con Textos en español/ingles en gossip
    + Se solucionan problemas de script y spells
    + Se ajustan timers y estilo.
    + Se remueve la seccion data del boss ya que no es necesaria cargarla en la insta ya que es farmeable.
+ 21/10/2013 [BattleCore604] SQL: Corregimos Hand Of Reckoning, inviertiendo logica.
+ 21/10/2013 [BattleCore605] Scripts/ICC: Se corrige puerta de Sindragosa que no se abria.
+ 21/10/2013 [BattleCore606] Core/Mecanica:
    + Actualizamos Vanishing algunos problemas encontrados en mi servidor local & update pequeño al sistema de visibilidad (Like AT)
    + Añadimos una condicion mas al check de BladeStorm
    + Añadimos a SelectExplicitTargets a las spell Dispel Magic - Spell Steal (Like AT)
    + Correjimos y actualizamos logica de FADEOUT
    + Correcion de un stack en las resistencias binarias
    + Actualizacion de Formula de las resistencias binarias
    + minor update en GCD
    + Actualizamos Glyph of Pain Suppression
+ 21/10/2013 [BattleCore607] Core/Spell: Añadimos inmunidades a Killing Spre.
+ 21/10/2013 [BattleCore608] Core/Spell: Actualizamos Formula de execute warrior. (Ahora calza igual que como esta en AT)
+ 21/10/2013 [BattleCore609] Core/Spell: Fix Spell Improved succubus (Reportado en http://www.battle.cl/foros/index.php?/topic/6363-sucubo-mejorado/).
+ 21/10/2013 [BattleCore610] Core/Spell: Fix Spell Honor among thieves ya no metera en combat. (Reportado en http://www.battle.cl/foros/index.php?/topic/6353-honor-among-thieves/)
+ 21/10/2013 [BattleCore611] Core/Quest: Argent Tournament - Fix Quest The Black Knight's Order (Reportada en http://www.battle.cl/foros/index.php?/topic/6264-quest-the-black-knights-order/)
+ 21/10/2013 [BattleCore612] Core/Player: Corregimos trainers que podian hablar con otras clases
+ 21/10/2013 [BattleCore613] Core/Spell: Fix Spell Rocket Blast (SOTA) La spell Rocket Blast utilizada por los Antipersonnel Cannon, ahora hara el daño esperado cuando impacta en los jugadores
+ 21/10/2013 [BattleCore614] Core/BG: Bugs de estado de puertas en SoTA (playa de ancestros)
+ 21/10/2013 [BattleCore615] Se añade sql faltante en [BattleCore613] (8c3bc43be7)
+ 21/10/2013 [BattleCore616] Fixed typo en recientes commits.
+ 22/10/2013 [BattleCore617] Limpieza de espacios en blanco
+ 22/10/2013 [BattleCore618] Core/Spell: Añadimos comentario para mejor comprension :P
+ 22/10/2013 [BattleCore619] Core/Spell: Corregimos un error de logica con las resistencias binarias de pets
+ 22/10/2013 [Battlecore620] Actualizacion blizzlike Area 4168 Ruby Dragonshrine <Dragonblight> (Faltan algunas spell de algunos npc que sin sniff no las puedo adivinar :c).
+ 22/10/2013 [Battlecore621] Quest Fixed 12417 Return to the Earth <Dragonblight>.
+ 22/10/2013 [Battlecore622] Core/Mecanica:
    + Final fix Vanish System Finaly fix Vanish & Hackfix for Breaking CC auras when SWD missed
    + HackFix de ruptura de auras de CC cuando SWD fue perdido
    + Removemos codigo inecesario y optimizamos sistemas.
    + Removemos Fix [BattleCore421] Spell: Shaman: Fix Tidal Waves
    + Actualizamos el GCD
+ 22/10/2013 [Battlecore623] Core/Utilidades: Implementamos check de IP en arena Queue, evitamos anti farmeos.
+ 22/10/2013 [Battlecore624] Core/Utilidades: Se implementa m_clicked para los cristales de areana, para un mayor detalle en las opciones de los que marcaron el cristal.
+ 25/10/2013 [Battlecore625] Core/Custom: Se implementan los titulos pvp sugeridos en http://www.battle.cl/foros/index.php?/topic/6384-titulos-pvp/
+ 25/10/2013 [Battlecore626] Core/Mecanica: Se soluciona el movimiento astronauta http://www.battle.cl/foros/index.php?/topic/6402-efecto-astronauta/
+ 25/10/2013 [Battlecore627] Simplificamos el codigo del script de titulos de pvp
+ 27/10/2013 [Battlecore628] Quest: Corregimos la Quest - The Plume of Alystros
+ 27/10/2013 [Battlecore629] Core/Mecanica: los spells FISICOS, tipo bleed (magico), eran agregados al incremento de daño. Ahora no sucedera
+ 27/10/2013 [Battlecore630] Core/Mechanic: Ahora el calculo de daño/heal del spell se hara cuando se castea el spell y los modificadores defensivos cada tick
+ 27/10/2013 [Battlecore631] Core/Pet: Leap de pet de dk ya no se tira a cualquier cosa
+ 27/10/2013 [Battlecore632] Core/Crash: Fix crash de Arena Espectador en comando arena_spectator_commands::HandleSpectateCancelCommand
+ 28/10/2013 [Battlecore633] Fix Exploit de enrage de druidas.
+ 28/10/2013 [Battlecore634] Core/Crash: Añadimos un check mas para el crash de Battlecore632
+ 28/10/2013 [Battlecore635] Core/Script: corregimos que el boss al hacer MC dejaba a los player fuera de combate, y se previenen unos crash.
+ 28/10/2013 [Battlecore636] Core/Spell: Removimos esta parte del codigo del Lifeblom para la solucion correcta de esta spell.
+ 28/10/2013 [Battlecore637] Core/Script: Actualizamos una ves mas el Boss Headles Horseman (Final).
+ 28/10/2013 [Battlecore638] Core/SQL: Corregimos el entry de c.template segun el wiki para la quest relatada en el commit Battlecore628.
+ 28/10/2013 [BattleCore639] Core/Loot: Algunas correcciones al anti-rollback, de loot.
+ 28/10/2013 [BattleCore640] SQL: Correccion de query en Battlecore628.
+ 28/10/2013 [BattleCore641] Core/Spell: Posible crash fix
+ 28/10/2013 [BattleCore642] Core/Spell: Optimizacion y posibles correciones a Battlecore630
+ 28/10/2013 [BattleCore643] Core/Spell: Normalizamos el daño de las pet de dk Gargola y Gargoyle
+ 29/10/2013 [BattleCore644] Core/Mecanica: Fixeamos el Spell Penetration para las resistencias binarias ( Reportado en http://www.battle.cl/foros/index.php?/topic/6519-spell-pen/)
+ 29/10/2013 [BattleCore645] Core/Quest: Corregimos la Quest - Spiritual Insight - http://www.wowhead.com/quest=12028 (by @Retriman & @Luz1fer)
+ 29/10/2013 [BattleCore646] falta de sql en [BattleCore645] 57094caf17a2
+ 29/10/2013 [BattleCore647] Core/Mecanica: Actualizamos el sistema de FadeOut, dejamos un poco mas blizlike le efecto con vanish. (fixed build por > faltante de commit BattleCore644).
+ 29/10/2013 [BattleCore648] Removemos algunas redundancias
+ 29/10/2013 [BattleCore649] Core/Spell: Limite maximo de absorcion de Anti-Magic Shell de dk a 50% de hp maximo
+ 29/10/2013 [BattleCore650] Core/Custom: Fix typo en mensaje de check del arena fast start.
+ 30/10/2013 [BattleCore651] Script/Spell: Revertimos BattleCore649, ya que fue aplicado en un contexto incorrecto.
+ 30/10/2013 [BattleCore652] Core/Movement: Variadas correcciones en Targeted Movement Generator
+ 30/10/2013 [BattleCore653] Core/Mecanica: Corregimos las resistencias binarias.
+ 30/10/2013 [BattleCore654] Core/Event: Añadimos algunas excepciones a los GameObjects prohibidos para GMs
+ 01/10/2013 [BattleCore655] Core/Utilidades: Ninguno de estos puede ser Negativo, porque son diferenciales de tiempo y el tiempo deberia "avanzar" y no "retroceder xD
+ 01/10/2013 [BattleCore656] Core/Dungeon: Añadimos evento de la estalastita en POS.
+ 01/10/2013 [BattleCore657] Core/Mecanica: Update formulas de las resisntencias binarias segun http://forums.elitistjerks.com/index.php?/topic/44232-resistance-mechanics-in-wotlk/
+ 02/11/2013 [Battlecore658] Actualizacion blizzlike Area 4179 Emerald Dragonshrine, 4152 Moaki Hargor <Dragonblight>.
+ 02/11/2013 [Battlecore659] Core/Spell: Implementamos que Death Grip pueda ser reflejado. (Pequeño update en unit.cpp  relatado en FadeOut).
+ 02/11/2013 [Battlecore660] Core/Spell: Corregimos FearWard (Hack Fix temporal). Soluciona http://www.battle.cl/foros/index.php?/topic/6507-bug-fear-ward/#entry48207
+ 02/11/2013 [Battlecore661] Core/Spell: Actualizacion al fix de Fear Ward del commit [Battlecore660] 7f7ec9a02643
+ 02/11/2013 [Battlecore662] Core/Custom: Añadimos sugerencia de los players ahora podras volverr al bg despues de caerte(por un rato te guarda el cupo). Sugerencia relatada en: http://www.battle.cl/foros/index.php?/topic/6757-desertor-de-bg/
+ 02/11/2013 [Battlecore663] Core/Spell: Ahora Overpower(Warrio spell) no puede hacer dodge ni parry ni block (Soluciona: http://www.battle.cl/foros/index.php?/topic/6673-overpower/)
+ 02/11/2013 [Battlecore664] Core/Custom: Corregimos el Slot del Item "Arena Battlemaster Summoner" para que se vea en el npc Redeem (Commit relatado en [BattleCore592] 76abe5c344)
+ 04/11/2013 [Battlecore663] Core/Spell: Real fix para Fear Ward Battlecore661 - Battlecore660
+ 04/11/2013 [Battlecore664] Core/Spell: Fix Absorv Seal of Corruption & Seal of Vengeance
+ 04/11/2013 [Battlecore665] Core/Mecanica: Update a las resistencias Binarias
+ 04/11/2013 [BattleCore666] Limpieza de error de logica (9fd20a3121c347c9f2ed2dd0c2b9bdde66aa98c6)
+ 04/11/2013 [BattleCore667] Core/Movement:
    + Se han actualizado las dependencias de MMAPS a sus versiones mas recientes.
    + Se ha optimizado el calculo de MMAPS con las mascotas.
    + Ahora las mascotas fuerzan el destino cuando estan siguiendo al dueño, es decir, ya no se quedaran atras nunca.
    + Ahora las mascotas pueden nadar.
    + Se han mejorado las conexiones entre los pilares y el punete de Blade Edge Arena.
    + Death Grip, ahora arrastra a la pet del Hunter, cuando esta considerablemente cerca al target.
    + Ahoras las mascotas son considerablemente mas sensibles al movimiento de los targets en Arenas y Battlegrounds.
+ 04/11/2013 [BattleCore668] Core/Movement:
    + Removemos una pequeña redundancia, que no tiene mayor importancia.
    + Pequeña correccion de logica.
+ 04/11/2013 [BattleCore669] Core/Spell: Fix calculo de spell Hammer of the Righteous
+ 05/11/2013 [BattleCore670] Core/Movement:
    + Removemos antiguo metodo para la deteccion de OffmeshPoint
    + Simplificamos logica
    + Reducimos carga
+ 05/11/2013 [BattleCore671] Core/Movement: Si se encuentra sobre el vector del Offmesh consideramos el final de este
+ 05/11/2013 [BattleCore672] Core/Movement: Reducimos pequeño delay producido por un cambio anterior
+ 05/11/2013 [BattleCore673] Core/Spell: El ghoul de dk ya no se beneficia con el armor extra
+ 05/11/2013 [BattleCore674] Core/Spell: Solucionamos el daño de force of nature
+ 05/11/2013 [BattleCore675] Core/Spell: Fix bonus Seal of Command Unleashed
+ 05/11/2013 [BattleCore676] DB: Añadimos un entry faltante a los demolishers de SOTA. ([BattleCore580])
+ 06/11/2013 [BattleCore677] Core/Movement: Corregimos metodo de BattleCore671
+ 06/11/2013 [BattleCore678] Core/Movement: Correccion de logica, removemos metodo ineficiente, y otimizacion.
+ 06/11/2013 [BattleCore679] Core/Movement: Posible correccion final de offMesh
+ 06/11/2013 [BattleCore680] Core/Movement: Corregimos el destino de la pet en el agua
+ 06/11/2013 [BattleCore681] Core/Movement: Ahora las mascotas pueden ingresar a los transportes
+ 06/11/2013 [BattleCore682] Correccion de compilacion
+ 06/11/2013 [BattleCore683] Core/Movement: Correccion final de conexiones Offmesh
+ 06/11/2013 [BattleCore684] Core/Movement: Detalles finales al movimiento de pets
+ 06/11/2013 [BattleCore685] Core/Movement: Añadimos hack fix para las arenas en gral cuando caes al vacio por alguna razon lo volvemos a la arena (mas que nada seguridad de por si llega a pasar tener algo para el jugado vuelva).
+ 07/11/2013 [BattleCore686] Core/Movement: Añadimos una limpieza del contenedor _OffMeshPoints, para evitar posibles casos de conflictos de datos en recalculacion de path
+ 07/11/2013 [BattleCore687] Core/Spell: Revertimos parte de BattleCore667, la pet no es movida por Death Grip.
+ 07/11/2013 [BattleCore688] Core/Movement: Removemos procesos innecesarios (Limpieza y optimizacion)
+ 08/11/2013 [BattleCore689] Core/Mecanica: Removemos Temporalmente las resisntencias binarias (Razon problema con Spell Penetration es solo temporal), Corregimos Hack fix de fear ward y removemos un fix a db
+ 08/11/2013 [BattleCore690] Core/Spell: Corregimos Devouring plague reflect
+ 08/11/2013 [BattleCore691] Core/Movement:
    + La unidad se reubicara si el jugador se posiciona sobre la unidad.
    + Ahora la mascota sigue la orientacion del dueño.
    + Removemos algunos procesos que no estaban siendo utilizados.
+ 08/11/2013 [BattleCore692] Core/Movement: Limpieamos la data de PathGenerator al iniciar el calculo, por posibles incidencias ocasionadas.
+ 09/11/2013 [BattleCore693] Custom/Script: Verificador de hechizos invalidos
+ 09/11/2013 [BattleCore694] Custom/Script: Ignoramos los hechizos predeterminados para su clase y raza, en el verificador de hechizos invalidos
+ 09/11/2013 [BattleCore695] Custom/Scripts: Evitamos que el verificador de hechizos invalidos borre hechizos profesiones y/o de misiones.
+ 10/11/2013 [BattleCore696] Scripts/Commands: Ahora con ".dev on", no se realizan verificaciones del sistema de construccion de eventos
+ 10/11/2013 [BattleCore697] Core/Spell: Solucionamos la seleccion del target de gargoyle DK.
+ 10/11/2013 [BattleCore698] DB: Se soluciona el Threat generado por el warrior reportado en http://www.battle.cl/foros/index.php?/topic/6797-threat-generado-por-el-warrior-tank/
+ 10/11/2013 [BattleCore699] Core/Spell: Fix Shield Block Value de items & daño de Shield Slam reportado en http://www.battle.cl/foros/index.php?/topic/6868-shield-slam/
+ 10/11/2013 [BattleCore700] Core/Quest: Corregimos la (Quest) The light of Dawn
+ 10/11/2013 [BattleCore701] DB/Spell: Druida: Fix spell Omen of Clarity, ahora solo se accionará la spell al causar daño o sanación. reportado en http://www.battle.cl/foros/index.php?/topic/6579-omen-of-clarity/
+ 11/11/2013 [BattleCore702] Core/Movement: Correccion de la orientacion final del movimiento
+ 15/11/2013 [BattleCore703] Core/Spell: Fix llamada de totems. Reportado en http://www.battle.cl/foros/index.php?/topic/6924-llamadas-de-totems-las-3/
+ 15/11/2013 [BattleCore704] Core/Movement: Se soluciona que nunca se pueda atacar por alguna razon en fear.
+ 15/11/2013 [BattleCore705] Core/Spell: Charge no debe tener DR. Patch 3.1.0 (14-Apr-2009): Duration of stun effect now lasts 1.5 sec. This effect no longer has diminishing returns.
+ 15/11/2013 [BattleCore706] Core/Spell: No se puede castear Death Grip saltando/huyendo, ni en target que no esten en LOS
+ 15/11/2013 [BattleCore707] Core/Movement: Toda unidad que este siguiendo a otra, puede forzar el destino
+ 16/11/2013 [BattleCore708] Scripts/Ulduar: Correccion de caida provocada por Algalon
+ 17/11/2013 [BattleCore709] Scripts/Ulduar: Fix Boss Thorim Ring. y trampas.
+ 17/11/2013 [BattleCore710] Scripts/ICC: Blood Prince Council.
    + Definimos una distancia apropiada para entrar en combate (generica).
    + Correcion Visual de SPELL_SHADOW_PRISON_DUMMY
    + Corregimos posicion de los summon y localizacion (Visual).
    + Evento EVENT_CONTINUE_FALLING Correcion de velocidad y limpieza de movimiento.
    + Posible Crash Fix.
    + npc_dark_nucleus condicion de ataque.
    + Removemos bool no utilizado.
+ 18/11/2013 [BattleCore711] Scripts/ICC:
    + Sindragosa:
        + Real Fix de puertas de Gaunglet y Sindragosa (Commit corregido [BattleCore605] Scripts/ICC: Se corrige puerta de Sindragosa que no se abria. ff0e46e097fc68f2f0d040e4abdddc729b1a4d1c)
    + ICC:
        + Añadimos Check de Loogro para la entrada a Heroico.
        + Añadimos Teleport to Frozen Throne
        + Sister Svalna
            + Correcion del evento de combate timer + Visual Spell que faltaba.
            + Añadimos Flag para correcion de exploit con pet.
            + Limpieza de movimientos
    + Lich King:
        + Añadimos que en una funcion que sea inmune a taunt donde se requiere (fix exploit).
        + Corregimos la velocidad de vuelo.
        + Limpiamos y corregimos visual bug en evento POINT_DROP_PLAYER
        + Corregimos los summon del boss.
        + Fix Spell Defile
        + Correcion en Spell plague jump condicion de remover el aura.
    + Rota Face:
        + Añadimos inmunidades de Knock back Efect
    + Festergut:
        + Añadimos inmunidades de Knock back Efect
+ 19/11/2013 [BattleCore712] Scripts/ICC: Boss Sindragosa Mejora en los ice tomb, corregido errores de reporte. (http://www.battle.cl/foros/index.php?/topic/6572-icc25n-271013/)
+ 21/11/2013 [BattleCore713] SQL/Disables: Desactivamos temporalmente la arena Ring of Valor, hasta solucionar problema de collision.
+ 23/11/2013 [BattleCore714] Core/Spell: Cambiamos el DR de Frostbite a su real DR.
+ 23/11/2013 [BattleCore715] Core/Spell: Fix Spell Penetration y vuelven las resistencias binarias
+ 23/11/2013 [BattleCore716] Core/Mail: Añadimos flag para npc's puedas ver los correos en ellos. (ejemplo npc de item de argent tournament Argent Squire , Argent Pony Bridle
+ 24/11/2013 [BattleCore717] Core/Movement: Correccion de "muros invisibles" con mmaps
+ 24/11/2013 [BattleCore718] Core/Spell: Fix typo de resistencias binarias implementado en [BattleCore715] 81c5df9bd5f
+ 24/11/2013 [BattleCore719] Core/Cfbg: Fix crash del cliente con Cfbg
+ 24/11/2013 [BattleCore720] Core/Movement: Mejoramos metodo de movimiento Knockback, posible crash fix.
+ 24/11/2013 [BattleCore721] Script/Custom: Item Arena BattleMaster
    + Corregimos su id para que pueda aparecer en el vendedor Redeem
    + Corregimos interpretacion de visibilidad especial
+ 24/11/2013 [BattleCore722] Script/ICC: Correcciones a BattleCore712
+ 24/11/2013 [BattleCore723] Core/Script: Se soluciona el item Argent Squire reportado en http://www.battle.cl/foros/index.php?/topic/6942-escudero-argenta-bug/
+ 24/11/2013 [BattleCore724] Core/Script: Fix typo de ID en loot de Gunship
+ 24/11/2013 [BattleCore725] Core/Script: Fix mimiron fase PHASE_V0L7R0N_ACTIVATION
+ 25/11/2013 [BattleCore726] Core/Script: Fix loot de freya
+ 25/11/2013 [BattleCore727] Script/Outland: Limpieza y crash fix en script de Blade Edge Mountains.
+ 27/11/2013 [BattleCore728] Core/Script: Fix Evento Pilgrims Bountry reportado en http://www.battle.cl/foros/index.php?/topic/7247-reporte-pilgrims-bounty/#entry53095
+ 27/11/2013 [BattleCore729] Añadimos faltantes Override a Hallowen.cpp y pilgrims.cpp
+ 27/11/2013 [BattleCore730] Core/Script: Update Script y Final Soporte A evento Pilgrims Bountry (Parte 1 [BattleCore728] 837a09)
+ 28/11/2013 [BattleCore731] Core/Movement: Se ha aumentado la precision de la correccion en BattleCore717 al 100%
+ 28/11/2013 [BattleCore732] Core/Spell: Fix Spell Shadowform bug del cliente.
+ 28/11/2013 [BattleCore733] Removemos Fix de [Battlecore663] 21a1f7, revisando bien esto deberia funcionar de por si ya que esta Unit::isSpellBlocked un check para esto.
    + Soluciona:
        + http://www.battle.cl/foros/index.php?/topic/6890-deterrence-bug/#entry53385
        + http://www.battle.cl/foros/index.php?/topic/7156-evasion/#entry53333
+ 28/11/2013 [BattleCore734] Core/Spell: Solucionamos Beacon Of Light ahora tomar las pets. Reportado en http://www.battle.cl/foros/index.php?/topic/7308-beacon-of-light/#entry53421
+ 28/11/2013 [BattleCore735] Core/Spell: Ajuste al Fix de Beacon Of Light para las pets (Commits relacionados [BattleCore734] ba4477e)
+ 28/11/2013 [BattleCore736] Core/DB: Final Fix lifeblom Reportado en http://www.battle.cl/foros/index.php?/topic/6224-lifebloom-sigue-bug/
+ 29/11/2013 [BattleCore737] Core/Spell: Fix Exploit spell Burning Determination Reportado en http://www.battle.cl/foros/index.php?/topic/7323-burning-determination/#entry53553
+ 29/11/2013 [BattleCore738] DB/Event: Fix al problema del logro Pilgrim's Progress del evento Pilgrim's Bounty  Reportado en http://www.battle.cl/foros/index.php?/topic/7309-pilgrims-progress/#entry53582
+ 30/11/2013 [BattleCore740] Revertimos BattleCore736
+ 02/12/2013 [BattleCore741] Script/Custom: Actualizamos Redeem a nuevo sitio.
+ 03/12/2013 [BattleCore742] Script/Custom: Actualizando tipos de datos de Redeem, con el nuevo sitio.
+ 09/12/2013 [BattleCore743] Script/ScarletEnclave: Ahora la quest "The Light of Dawn", se encuentra con el sistema de visibilidad de evento.
    + Se crean NPCs temporales para generar el evento.
    + Se conservan los NPCs orginales.
    + Se trabaja con la visiblidad entre las entidades.
+ 10/12/2013 [BattleCore744] Script/Custom: Comando redeem de GameMasters removido.
+ 10/12/2013 [BattleCore745] DB: Se ha removido antigua configuracion de BG y habilitado Alterac Valley
+ 10/12/2013 [BattleCore746] Core/Object: Correccion de logica en sistema de evento de visibilidad
+ 10/12/2013 [BattleCore747] Script/ScarletEnclave: Correccion de orden de ejecucion a BattleCore743
+ 12/12/2013 [BattleCore748] Battlefield/Wintergrasp: Ahora Wintergrasp se desactivara correctamente.
+ 14/12/2013 [BattleCore749] Core/Chat: SOAP con RBAC
+ 14/12/2013 [BattleCore750] Script/Custom: Commandos JSON para el sitio
+ 14/12/2013 [BattleCore751] Script/Custom: Commando JSON optimizado, mas info menos consultas
+ 15/12/2013 [BattleCore752] Script/Store: Actualizando tienda a soporte multi reino
+ 15/12/2013 [BattleCore753] Script/Custom: Espectado de arena
    + Se le ha aplicado una limpieza al codigo
    + Se han aplicado verificaciones faltantes
+ 16/12/2013 [BattleCore754] Prevenimos que se entre en combate estando muertos
+ 16/12/2013 [BattleCore755] Prevenimos caida mientras se levita.
+ 17/12/2013 [BattleCore756] Script/Ruby Sanctum: Ahora Baltharus the Warborn recive correctamente las Marca Enervantes
+ 17/12/2013 [BattleCore757] Core/Spell: Prevenimos la remocion de ciertas auras que no debe producirse
+ 17/12/2013 [BattleCore758] Script/Custom: Correcciones de crash en ArenaSpectator
+ 18/12/2013 [BattleCore759] DB/Ragnaros: Removemos mmaps y disminuimos el loot para que no haya colicion.
+ 18/12/2013 [BattleCore760] Quest/Helboar, the Other White Meat: Se arreglo el drop de Tainted Helboar Meat.
+ 18/12/2013 [BattleCore761] DB/Murlocs: Agregamos murlocs alianza y horda en sus capitales.
+ 18/12/2013 [BattleCore762] Quest/Smooth as Butter: Se a arreglado el drop de Plump Buzzard Wing.
+ 19/12/2013 [BattleCore763] DB/Ragnaros: Limitamos un poco mas el loot para asegurarnos de que bote items de mision.
+ 19/12/2013 [BattleCore764] DB/Infected Wounds: Ahora Thunderclap no sobreescrive el talento Infected Wounds.
+ 19/12/2013 [BattleCore765] DB/ToC: Desabilitamos MMAPS en ToC para su correcto funcionamiento.
+ 19/12/2013 [BattleCore766] DB/HoR: Desabilitamos HoR hasta corregir su funcionamiento.
+ 19/12/2013 [BattleCore767] Scripts/Azjol Nerub: Correccion de asignacion de Datas.
+ 24/12/2013 [BattleCore768] Core/Movement: Arreglamos la distancia minima de movimiento de NPC.
+ 24/12/2013 [BattleCore769] DB/ToC: Arreglamos el loot del Tribute chest limitando los trofeos.
+ 24/12/2013 [BattleCore770] Script/Steam Rager: CrashFix.
+ 24/12/2013 [BattleCore771] DB/ToC: Arreglamos el dispell de las spell de Twin Val'kyr en ToC.
+ 27/12/2013 [BattleCore772] Script/Custom: Nuevo comando ".cementerio", te lleva devuelta al angel de resurreccion.
+ 27/12/2013 [BattleCore773] Core/Movement: Se ha mejorado la precision del movimiento de seguimiento (follow)
+ 27/12/2013 [BattleCore774] Core/Movmenet: Prevenimos un posible crash
+ 27/12/2013 [BattleCore775] Core/Movmeent: Simplificamos metodo implementado en BattleCore773
+ 27/12/2013 [BattleCore776] Core/Movmeent: Detalles finales en BattleCore773
+ 31/12/2013 [BattleCore777] Core/Movmeent: Correcciones finales de precision de movimiento
+ 01/01/2014 [BattleCore778] Core/Guild: Packet exploit fix.
+ 05/01/2014 [BattleCore779] Core/World: Herramienta para restringir realm a un pais
+ 07/01/2014 [BattleCore780] Auth: Agregando check DDoS
+ 08/01/2014 [BattleCore782] Core/WorldSocket: Login asincronico, implementado.
+ 08/01/2014 [BattleCore783] Script/Custom: Removemos visualizador de GamePoints, para optimizar login.
+ 08/01/2014 [BattleCore784] Script/Custom: Solo mostramos que poseemos ordenes pendientes si hay.
+ 08/01/2014 [BattleCore785] Core:
    + Se ha optimizado la restriccion de realm a pais.
    + Se ha reducido la carga constante a la base de datos auth.
+ 08/01/2014 [BattleCore786] Core/Battlefield: Re-implementando Wintergrasp de BattleCore 1.0
    + Se han corregido los cementerios, de Wintergrasp (BattleCore 1.0)
    + Se ha adaptado base de datos para utilizar base de TrinityCore
+ 09/01/2014 [BattleCore787] Script/Command: Comando .pinfo asincronico.
+ 09/01/2014 [BattleCore788] Script/Command: Comando .bc accinfo asincronico.
+ 09/01/2014 [BattleCore789] Core/Account: Account access asincronico.
+ 10/01/2014 [BattleCore790] Core/Battlefield: Orbe de Wintergrasp, corregido.
+ 10/01/2014 [BattleCore791] SQL/Ip2Nation: Se ha añadido segmento de IP de Chile, faltante.
+ 10/01/2014 [BattleCore792] Core/Ip2Nation: Correccion de punteros
+ 10/01/2014 [BattleCore793] Core/Battlefield: Correccion de WorldState de GameObjects destructibles
+ 10/01/2014 [BattleCore794] Core/Unit: Corregimos movimiento de vehiculos rooteados.
+ 11/01/2014 [BattleCore795] Core/Battlefield: Collision visual de fortaleza de Wintergrasp corregida.
+ 11/01/2014 [BattleCore796] Core/Battlefield: Prevenimos unidades sin rango, que se accionen eventos de daño si no se esta en batalla y warning fix.
+ 12/01/2014 [BattleCore797] Core/Arena: Typo fix en carga de cofigs.
+ 14/01/2014 [BattleCore798] Core/Battlefield: Se ha corregido la aplicacion de auras para la batalla.
+ 15/01/2014 [BattleCore799] Core/Battlefield: Se han realizado correcciones y optimizaciones menores.
+ 20/01/2014 [BattleCore800] Core/Battlefield: Detalle de cambios anteriores, corregido.
+ 28/01/2014 [BattleCore801] Core/Battlefield: Correcciones de logica, que generaban errores al definir la faccion ganadora.
+ 28/01/2014 [BattleCore802] Core/Battlefield: Hack fix, para cañones de Wintergrasp.
+ 03/02/2014 [BattleCore803] Custom/Eventos: Agregando script para teletransportandose a evento pvp
+ 03/02/2014 [BattleCore804] Core/Battlefield:
    + Se activara un collision de la puerta de la fortaleza, al finalizar la batalla.
    + Los vehiculos de Wintergrasp desapareceran un minuto despues de finalizar la batalla.
+ 06/02/2014 [BattleCore805] Script/Spell: Ahora Enrage de druida reduce el armor.
+ 06/02/2014 [BattleCore806] Core/Pet: La pet no debe atacar a un jugador que se encuentre en una tramapa (Freezing Trap y Freezing Arrow)
+ 07/02/2014 [BattleCore807] Core/GameObject: Ahora las trampas tambien tienen delay cuando se encuentra fuera de combate.
+ 07/02/2014 [BattleCore808] Core/Spell: Dancing Rune Weapon corregido.
+ 07/02/2014 [BattleCore809] Core/Spell:
    + Fix Flag de spell Pungent Blight (Festergut)  ICC
+ 08/02/2014 [BattleCore810] Core/Mechanic: Implementamos DynCombat
+ 08/02/2014 [BattleCore811] Core/Mechanic: Mejor balance resilience Judador contra jugador
+ 08/02/2014 [BattleCore812] Core/Mechanic: Ahora las Trampas sólo pueden ser detectados a poca distancia de cuerpo a cuerpo
+ 08/02/2014 [BattleCore813] Core/Mechanic: Pequeño movimiento en FleeingMovementGenerator distancia
+ 08/02/2014 [BattleCore814] Core/Mechanic: Update a calculo de las resistencias binarias.
+ 08/02/2014 [BattleCore815] Core/Arena: SoloQueue.
+ 09/02/2014 [BattleCore816] Core/Arena:
    + Variadas correcciones de logica del Arena Spectator
    + Limpieza de espacios en blanco
    + Detalles menores en cambios de SoloQueue
+ 09/02/2014 [BattleCore817] Core/Arena: Arena Spectator
    + Correccion de caida al deslogear en modo espectador
    + Correccion de visibilidad durante la arena
    + Correccion de bug al abandonar el espectador
+ 09/02/2014 [BattleCore818] Core/Arena: Más correcciones a Arena Spectator
+ 10/02/2014 [BattleCore819] Core/Arena: Arreglando textos en anuncios
+ 10/02/2014 [BattleCore820] Core/Mechanic: Revertimos update a calculo de las resistencias binarias.
+ 11/02/2014 [BattleCore821] Script/Tournament: Agregando scripts para el torneo.
+ 11/02/2014 [BattleCore822] Core/Battlegrond: Se ha corregido la recompensa de reputacion al finalizar la batalla en Alterac Valley.
+ 11/02/2014 [BattleCore823] Core/Unit: Se a corregido la velocidad de las Val'kyr de Lich king y sus resistencias.
+ 11/02/2014 [BattleCore824] DB/Professor Putricide: Se han agregado resistencias a Volatile Ooze y Gas Cloud.
+ 11/02/2014 [BattleCore825] SQL/World: Se han corregido varios vehiculos que no deben regenerar su vida.
+ 12/02/2014 [BattleCore826] Script/ArenaSpectator: Crash recientes corregidos, optimizaciones y detalles menores.
+ 13/02/2014 [BattleCore827] DB/SQL: Estandarizando SQL.
+ 13/02/2014 [BattleCore828] Core/ICC: Corregido exploit en ICC utilizado para ganar logros con otros personajes.
+ 13/02/2014 [BattleCore829] Core/Warden: CrashFix.
+ 13/02/2014 [BattleCore830] Core/Spell: Prevenimos que Necrotic Plague sea resistida.
+ 13/02/2014 [BattleCore831] Script/EasternKingdoms: Correcciones a Light of Dawn
    + Ahora se inicial y cancela correctamente el evento paralelo.
    + Si el jugador se desconecta durante el evento se cancelara correctamente.
+ 17/02/2014 [BattleCore832] Core/Battleground: Rervertimos SoloQueue
    + Ref: 35cc955225 [BattleCore815]
+ 17/02/2014 [BattleCore833] SQL/Updates: Ahora "Prince Thunderaan <The Wind Seeker>", no desaparecera inmediatamente tras morir.
+ 17/02/2014 [BattleCore834] Core/Battleground: Facciones invertidas en Alterac Valley, corregidas.
+ 18/02/2014 [BattleCore835] Core/Misc: Se ha mejorado y corregido la vision de seguimiento en un jugador al espectar.
    + Puedes intercambiar de vision de seguimiento entre los participantes de la arena, haciendo clic sobre el foco/focus.
    + Si vuelves a hacer clic sobre el foco/focus de un jugador que ya estas siguiendo, dejaras de seguirlo.
+ 18/02/2014 [BattleCore836] Core/Quest: Event/Love Is In The Air: Solucionamos Quest (24657) A Friendly Chat A/H Reportado en http://www.battle.cl/foros/index.php?/topic/8718-evento-love-is-in-the-air/page-2
+ 18/02/2014 [BattleCore837] Core/Commands: Añadimos comando para solucionar problemas con la dualspec  .gm fixdualspec command.
+ 18/02/2014 [BattleCore838] Core/Commands: Añadimos comando para ver el status de quest en los players .quest status <#questId> command.
+ 24/02/2014 [BattleCore839] Core/Eventos: Love Is In The Air: Añadimos a Mazmorra ShadowfangKeep el evento Apothecary Trio
+ 24/02/2014 [BattleCore840] Script/ShadowfangKeep: Crash fix
+ 25/02/2014 [BattleCore841] Core/Custom: Arena Espectador, Se soluciona el problema con el npc del espectador de arenas ahora cuando el npc muestre la lista de arenas podras entrar a las arenas mostradas por el npc.
+ 26/02/2014 [BattleCore842] Core/Custom: Enchant Visuales: Ahora tus armas tendran la posibilidad (25% chance) de tener un enchant visual de color. Ojo Solo visual.
+ 26/02/2014 [BattleCore843] Core/Script: ICC: Ahora la spell Harvest Souls no podria ser resistida por los player. todos los players deben entrar a Frostmourne.
+ 26/02/2014 [BattleCore844] Core/Script: ICC: Se mejora la velocidad de las Val'kyr de Lich King. Ahora si su velocidad sera la adecuada
+ 26/02/2014 [BattleCore845] Core/Script: ICC: Inmunidades correctas a Val'kyr de Lich King.
+ 26/02/2014 [BattleCore846] Script/Spell: Gear Scaling aumentara vida y daño solamente en el vehiculo.
+ 26/02/2014 [BattleCore847] Core/Script: Evento/Love Is In The Air: Solucionamos los recientes problemas de que los npc's del evento no estaban y el npc Hummel no comenzaba el evento
+ 26/02/2014 [BattleCore848] Core/Custom: Enchant Visuales: Ahora el Chance sera de un 99% de obtener el efecto visual al lotear/crear un arma
+ 27/02/2014 [BattleCore849] Core/Script: UtgardePinnacle: Boss Skadi. Se corrigen los bugs en la fase aerea del boss se optimizan los metodos de llamada, se añade el logro My Girl Loves to Skadi All the Ime (2156)
+ 27/02/2014 [BattleCore850] Core/Script: UtgardePinnacle: Limpieza de codigo y estandares de codigo, solucionamos problemas reportados en http://www.battle.cl/foros/index.php?/topic/7387-bug-instancias-random/#entry65832. "Heroic:Utgare Keep:el ultimo boss no esta contando como muerto por lo q no da logro de la insta en ninguna de sus modalidades."
+ 01/03/2014 [BattleCore851] Core/Scripts: Black Temple - No permita que el evento de Shade of Akama se inicia por una segunda vez.
+ 01/03/2014 [BattleCore852] Core/Scripts: Fix Flame Shield targetting de los dragones de Malygos' phase 3
+ 01/03/2014 [BattleCore853] Core/Unit: Fix/Hack se soluciona el problema se fuerza que la creatura siempre pueda atacar
+ 01/03/2014 [BattleCore854] Core/Player: Fix exploit al estar desarmado el player puede cambiar el arma e incrementa el critico en 100%
+ 01/03/2014 [BattleCore855] Core/Spell: Fix exploit que al entrar a bg y cambiar de spec dentro podias quedar con 100% de critico
+ 01/03/2014 [BattleCore856] Core/WorldSession: Fix Abuso alt+f4 para evitar morir y salir de combate
+ 01/03/2014 [BattleCore857] Core/Spell: Update al sistema de vanish + fadeout delay system. reportado en http://www.battle.cl/foros/index.php?/topic/8835-bug-vanish-stealth/
+ 01/03/2014 [BattleCore858] Core/Script: Solucionamos problema que el cofre del boss Vazruden de la mazmorra Heroic Hellfire Ramparts no se podia targear. Reportado en http://www.battle.cl/foros/index.php?/topic/6366-heroic-hellfire-ramparts/
+ 02/03/2014 [BattleCore859] Core/Script: Toc5:
    + Renombramos algunos script typo y eliminamos warning de compilacion.
    + Syncronizamos varios textos con tc y añadimos emotens faltantes al anunciador del evento.
    + El evento de entrada se reescribe (Anunciador).
    + Añadimos Overrido y escritura de codigo estandar, renombre de variables etc.
    + Mejoramos el metodo de llamada de las memorias.
    + Añadimos logros faltantes a la mazmorra.
        + Logro 3804 - "I've had worse".
        + Logro the Argent Confessor (3802).
        + The Faceroller (3803)
    + Los Champions no seran atacables hasta la fase 2, "monturas".
    + Las monturas desaparecen despues de el encounter Grand Champions, prevenimos abuso.
    + Black Knight el evento ahora inicia como corresponde y añadimos textos correctos. (Problema conocido cuando el server se cuelge falta agregar un check que el evento se reinicie).
    + Enlazamos a los jugadores a la mazmorra cuando son derrotados los campeones y también solucionamos problemas de creditos de LFG.
    + Implementamos que al derrotar al jefe Black Knight's  empezara el evento post muerte de el.
+ 02/03/2014 [BattleCore860] Core/Script: ICC/Lk: Se ajusta aun mas el tiempo de las valkyr se añade excepción para que paren su movimiento y correctas inmunidades.
+ 02/03/2014 [BattleCore861] Core/Script: Fix Quest Steamtank Surprise Reportada en http://www.battle.cl/foros/index.php?/topic/8869-steamtank-surprise/
+ 02/03/2014 [BattleCore862] DB/Quest: Fix Quest There's Something Going On In Those Caves Reportada en http://www.battle.cl/foros/index.php?/topic/8849-reporte-de-quest-de-tundra-boreal-que-estan-bugs/
+ 02/03/2014 [BattleCore863] DB/Quest: Fix Quest Leading the Ancestors Home Reportada en http://www.battle.cl/foros/index.php?/topic/8849-reporte-de-quest-de-tundra-boreal-que-estan-bugs/
+ 02/03/2014 [BattleCore864] DB/Quest: Fix Quest Hampering their Escape Reportada en http://www.battle.cl/foros/index.php?/topic/8849-reporte-de-quest-de-tundra-boreal-que-estan-bugs/
+ 03/03/2014 [BattleCore865] Core/Spell: Fix Spell Gusanos de sangre([DK] Bloodworms) Ahora invocara los gusanos correspodientes y se corrige el daño de ellos. Reportado en http://www.battle.cl/foros/index.php?/topic/8950-gusanos-de-sangre/#entry66112
+ 03/03/2014 [BattleCore866] DB/Quest: Fix Quest Sibling Rivalry [SOH CHAIN] Reportada en http://www.battle.cl/foros/index.php?/topic/8399-sons-of-hodir-quest-chain-sibling-rivalry/#entry66213
+ 03/03/2014 [BattleCore867] Core/Scripts: Check fail en logro My Girl Loves en Skadi ahora es cuando comienza a moverse y no cuando acaba de anunciar xD typo xD
+ 03/03/2014 [BattleCore868] Core/Spells:
    + Shattered Barrier no debe activarse con dispel.
    + Los sellos ahora procearan atravez de los efectos de absorcion.
    + Fix Art of War & Blessed Recovery. Ahora procearan sobre Absorcion completa.
    + Lightning & Water Shield no procesearan con full absrocion.
    + No permite que Ignite haga procear Molten Armor, y tampoco permite que procee al momento de que el daño es absorbido en su totalidad
+ 04/03/2014 [BattleCore869] Core/Ticket: Implementamos que cuando se complete un ticket llegue un mensaje al destinatario de que su ticket fue completado.
+ 04/03/2014 [BattleCore870] Core/InstanceSave: Saves
    + obligando a eliminar registros en db a su vez que elimina el boundary
    + separando las ejecuciones sobre la base de datos
+ 05/03/2014 [BattleCore871] DB/Logros: Fix Warsong Gulch - Supreme Defender reportado en http://www.battle.cl/foros/index.php?/topic/7987-logro-bug/#entry64887
+ 05/03/2014 [BattleCore872] Core/Player: Fix a problema presentado por revision [BattleCore854], ahora los warros no se les bugeara el arma. (Final fix Exploit)
+ 05/03/2014 [BattleCore873] Core/Script: Fix quest The Purification of Quel'delar (Final Chain Blizlike) Soluciona http://www.battle.cl/foros/index.php?/topic/6324-the-purification-of-queldelar/
+ 06/03/2014 [BattleCore874] DB/Quest: Fix quest Borrowed Reportado en Technologyhttp://www.battle.cl/foros/index.php?/topic/7347-borrowed-technology/
+ 06/03/2014 [BattleCore875] DB/Quest: Fix quest In Search Of Answers Reportado en http://www.battle.cl/foros/index.php?/topic/8100-zuldrak-in-search-of-answers/
+ 06/03/2014 [BattleCore876] DB/Quest: Fix quest Quest - Tails Up Reportado en http://www.battle.cl/foros/index.php?/topic/8101-zuldrak-tails-up/
+ 06/03/2014 [BattleCore877] Core/Battleground: Posible correccion a reduccion de FPS con algunos jugadores en Strand of the Ancients
+ 06/03/2014 [BattleCore878] Core/Script: Fix Quest The Hunter and the Prince reportada en http://www.battle.cl/foros/index.php?/topic/8216-icecrown-quest-the-hunter-and-the-prince/
+ 06/03/2014 [BattleCore879] Core/Battleground: Logro Save the Day de Warsong Gulch, ha sido corregido.
+ 07/03/2014 [BattleCore880] DB/Spawns: Recuperando algunos spawns, extrañamente perdidos.
    + En Terokkar Forest: Bone Sifter
    + En The Scarlet Enclave: Koltira Deathweaver, Thassarian y Orbaz Bloodbane
+ 09/03/2014 [BattleCore881] Db/Quest: Fix Quest Reconnaissance Flight Reportada en http://www.battle.cl/foros/index.php?/topic/8994-quest-bugs-de-scholazar-basin/#entry66685
+ 09/03/2014 [BattleCore882] Db/Quest: Fix Quest - A Tale of Valor Reportada en  http://www.battle.cl/foros/index.php?/topic/9051-ice-crown-a-tale-of-valor/
+ 09/03/2014 [BattleCore883] Core/Bg: Ahora al terminar el bg no saldras con buff de incapacidad de movimiento ni perdidas de control del pj.
+ 10/03/2014 [BattleCore884] Core/Spell:
    + Se soluciona el bug de las runas de la muerte  Reportado en : http://www.battle.cl/foros/index.php?/topic/8987-bug-runas-de-muerte/
    + Se soluciona el bug de la spell Frio hambriento (Hungering Cold) Reportado en http://www.battle.cl/foros/index.php?/topic/7511-bug-frio-hambriento/
+ 10/03/2014 [BattleCore885] Core/Script: Reset de Hp en la fase de transicion en jefe Skadi de Utgarde Pinnacle (UP)
+ 10/03/2014 [BattleCore886] Db/Quest: Fix Quest Bury Those Cockroaches! Reportada en http://www.battle.cl/foros/index.php?/topic/9057-borean-tundra-bury-those-cockroaches/
+ 11/03/2014 [BattleCore887] Core/Script: Implementamos  A Tribute to Dedicated Insanity  Trial Of Crusader
+ 11/03/2014 [BattleCore888] Core/Spell: Posible Fix Gargoyle (Dk Spell) añadimos threat y mas distancia de busqueda http://www.battle.cl/foros/index.php?/topic/9015-bug-de-gargola/
+ 11/03/2014 [BattleCore889] Core/Bg: nos aseguramos que al terminar el bg saque el aura de Blood Frenzy (30070)  commit complemento de rev da42add419
+ 11/03/2014 [BattleCore890] Db/Quest: Fix Quest Hope Within the Emerald Nightmare Reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/#entry66917
+ 12/03/2014 [BattleCore891] Core/Spell: Se soluciona el problema de enrage con el T10 Feral Reportado en http://www.battle.cl/foros/index.php?/topic/8979-tier-10-feral-bonus-4/
+ 12/03/2014 [BattleCore892] DB/Quest: Fix Quest - Seeds of Chaos Reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/#entry66917
+ 13/03/2014 [BattleCore893] DB/Quest: Fix Quest - Get the key Reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/#entry66917
+ 14/03/2014 [BattleCore894] DB/Quest: Fix  Quest 13069 Shoot 'Em Up Reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/#entry66917
+ 14/03/2014 [BattleCore895] Db/Quest: Actualizamos Script SAI de quest The Sum is Greater than the Parts Quest Fixeada por Tc en rev 4fc1fdbb6d8ff7d2e3538e639bd6 se corrigen los bug's y se agrega soporte a un spell. Reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/#entry66917
+ 14/03/2014 [BattleCore896] Db/Quest: Fix Quest By Fire Be Purged Reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/#entry66917
+ 14/03/2014 [BattleCore897] Db/Quest: Fix Quest A Visit to the doctor Reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/#entry66917
+ 14/03/2014 [BattleCore898] Core/Script: Fix Quest Assault by Air Reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/#entry66917
+ 15/03/2014 [BattleCore899] Core/Custom: Soporte Evento PvP
+ 15/03/2014 [BattleCore900] Core/Player: Soporte para nuevo articulo de tienda "Seguro de personajes"
+ 15/03/2014 [BattleCore901] Core/Custom: Nuevo evento GuildWars
    + Desarrollado por @Retriman y @LiMCrosS
+ 15/03/2014 [BattleCore902] Core/Script: Fix Quest That's Abominable! reportada en http://www.battle.cl/foros/index.php?/topic/9076-reporte-quest-icecrow/
+ 16/03/2014 [BattleCore903] Core/Battleground: Correccion en el almacenaje del ganador y perdedor de GuildWars.
+ 16/03/2014 [BattleCore904] Core/BattlegroundQueue: Se ha corregido un error, que mostraba un numero incorrecto en la cola de GuildWars.
+ 17/03/2014 [BattleCore905] DB/Quest: Se Soluciona la Quest The Plains Of Nasam Reportada en http://www.battle.cl/foros/index.php?/topic/9169-borean-tundra-quests-bugs/
+ 17/03/2014 [BattleCore906] DB/Quest: Se solciona la Quest Patching Up Reportada en http://www.battle.cl/foros/index.php?/topic/9169-borean-tundra-quests-bugs/
+ 17/03/2014 [BattleCore907] Core/Script: Añadimos Soporte a  Quest just following orders y typo de Quest freya pact
+ 18/03/2014 [BattleCore908] Core/Script: Oracle Añadimos soporte a npc High-Oracle Soo-say http://www.wowhead.com/npc=28027#comments [1 Parte para cambio de faccion entre los Oracles]
    + Reportado en : http://www.battle.cl/foros/index.php?/topic/9118-bug-en-quest-diarias-facci%C3%B3n-the-oracles/
+ 18/03/2014 [BattleCore909] Core/Spell: Posible Fix Hungering Cold
+ 18/03/2014 [BattleCore910] Core/Script: Oracle Añadimos Npc Dummy con el cual los npc's trabajaran en la busqueda y spell visuales [2 Parte para cambio de faccion entre los Oracles]
    + Limpieza en Cpp zone_sholazar_basin.cpp
+ 19/03/2014 [BattleCore911] Core/Script: Oracle Añadimos  Script completo de Npc Oracle Treasure [3 Parte para cambio de faccion entre los Oracles]
+ 19/03/2014 [BattleCore912] DB/Quest: Fix Quest Kick, What Kick? Reportada en http://www.battle.cl/foros/index.php?/topic/9179-cuenca-de-sholazar-kick-what-kick/
+ 19/03/2014 [BattleCore913] Core/Script: Oracle Añadimos  Script  de npc para cambio de Npc Cambio Faction. Oracles<->Frenzyheart  [4 Parte para cambio de faccion entre los Oracles]
+ 20/03/2014 [BattleCore914] Core/Script: Oracle Añadimos  Script  Final para npcs Artruis y Zepij lo que da final al evento de cambio de faction Oracles<->Frenzyheart [5 Parte para cambio de faccion entre los Oracles Final]
+ 21/03/2014 [BattleCore915] Script/Dragonblight: Crash fix en Quest: Spiritual Insight
+ 21/03/2014 [BattleCore916] Script/Custom: Ahora se daran todos los titulos PvP que le correspondan al personaje automaticamente al matar un jugador.
+ 22/03/2014 [BattleCore917] Script/Custom: Correccion final a entrega de titulos de PvP
+ 23/03/2014 [BattleCore918] Script/Custom: Optimizamos Script custom player_duelo_reset_cd para adaptacion a nuevo sistema de duelos
+ 23/03/2014 [BatlteCore919] Script/Custom: Se ha corregido la antigua implementacion de los titulos PvP
    + Se ha removido el Rank 15, pues fue descontinuado y estaba incorrectamente asociado a titulos "of the Alliance" y "of the Horde".
    + Se han reajustado todos los Ranks:
        + Rank 1: 15 HK
        + Rank 2: 2.000 HK
        + Rank 3: 5.000 HK
        + Rank 4: 10.000 HK
        + Rank 5: 15.000 HK
        + Rank 6: 20.000 HK
        + Rank 7: 25.000 HK
        + Rank 8: 30.000 HK
        + Rank 9: 35.000 HK
        + Rank 10: 40.000 HK
        + Rank 11: 45.000 HK
        + Rank 12: 50.000 HK
        + Rank 13: 55.000 HK
        + Rank 14: 60.000 HK
    + Fuentes:
        + http://www.wowwiki.com/Honor_system_(pre-2.0)
        + http://wotlk.openwow.com/achievement=870
    + Nota: Todos los titulos mal asignados, seran removidos automaticamente.
+ 23/03/2014 [BatlteCore920]Core/Script: Custom Duel Reset:
    + Movemos todas las funciones a un header.
    + Se Implementa mediante configuracion en que zona y area puede estar activo este sistema.
    + Se implementa mediante configuracion si el servicio esta activado o desactivado.
+ 23/03/2014 [BatlteCore921]Core/Script: Custom Duel Reset:
    + Añadimos AntiExploit Check al sistema
+ 23/03/2014 [BatlteCore921]Core/Script: Custom Duel Reset:
    + Implementamos nuevo sistema de duelos jugador contra jugador (JcJ) consiste en que si peleas en las zonas asiganadas Elwynn Forest, Durotar, Dalaran podras acceder a ganar puntos de Rated
+ 23/03/2014 [BatlteCore922] Core/Script: Fix Quest Still At It reportada en http://www.battle.cl/foros/index.php?/topic/9178-cuenca-de-sholazar-still-at-it/. Removemos el soporte erroneo de SAI de tc y lo metemos a script.
+ 26/03/2014 [BatlteCore923] CoreScript: Fix Logro 'Full House' de jefe Lady Deathwhisper en banda ICC
+ 27/03/2014 [BattleCore924] Custom/Script: Ahora al remover titulos pvp mal asignados, removemos tambien el titulo seleccionado, si no le corresponde.
+ 28/03/2014 [BattleCore925] Custom/Script: Canal PvP:
    + Se implementa canal PvP historial en donde se mostrara toda la informacion de bgs y arenas  para ingresar al canal tipea /join pvp
+ 28/03/2014 [BattleCore926] Core/Script: Se Soluciona Quest Among the Champions se mueve el Soporte de SAI a Cpp. ya que el hay una funcion erronea en SAI la cual no funciona para los vehiculos. Reportado en http://www.battle.cl/foros/index.php?/topic/8988-among-the-champions/
+ 29/03/2014 [BattleCore927] Core/Spell: Fix Bug Shield Relatado & Reportado en: http://www.battle.cl/foros/index.php?/topic/9007-otro-bug-shield/#entry68214
+ 29/03/2014 [BattleCore928] Core/Quest: Fix Quest Gods like Shiny Things Reportada en http://www.battle.cl/foros/index.php?/topic/9216-gods-like-shiny-things/#entry68195
+ 29/03/2014 [BattleCore929] Db/Dungenon: Se soluciona el problema de  [Blackwing Lair] Nefarian Reportado en :http://www.battle.cl/foros/index.php?/topic/9329-blackwing-lair-nefarian/#entry68509
+ 29/03/2014 [BattleCore930] Core/Custom: Añadimos al Npc Reedem El Item loot especial, este item tiene la facultad de activar/desactivar el loot x1 , esto es necesario para la gente que quiere hacer quest, y al momento de lotear no les salia el item quest.
    + Modo de uso: con un "use" el loot se activa y con otro "use" se desactiva, esto arrojara un mensaje de verificacion en la pantalla del jugador con: Loot Especial Activado/Desactivado, al Logear te avisara si tu loot es Especial o No.
+ 29/03/2014 [BattleCore931] Core/Event: Fix Al tiempo de duracion del evento Noblegarden (dura 7 fías ahora), fix correcto inicio de evento.
+ 02/04/2014 [BattleCore932] Core/Item: Soporte de venta de items para transmogrificar
+ 04/04/2014 [BattleCore933] Core/WorldSession: Fix Exploit de que al morir te llevaba al cementerio y aparecias vivo (solo cuando aplicabas alt+f4)
+ 06/04/2014 [BattleCore934] Core/Scripts: Prevenimos multiple spawn de npc Ulag
+ 06/04/2014 [BattleCore935] Core/Custom: Final Fix Item Loot Especial
+ 08/04/2014 [BattleCore936] Core/Custom: Pequeñas mejoras al Item Loot Especial. Condiciones para uso y un bug.
+ 08/04/2014 [BattleCore937] Db/Quest: Fix Quest Shred the Alliance & Shredder Repair Reportada en:http://www.battle.cl/foros/index.php?/topic/9198-shred-the-alliance-grizzly-hills/
+ 08/04/2014 [BattleCore938] Core/Spell: Fix Detect Undead del Elixir of Detect Undead
+ 08/04/2014 [BattleCore939] Core/Unit: Ahora las auras de los npcs al hacer respawn volveran a estar presentes.
+ 09/04/2014 [BattleCore940] DB/Quest: Fix Quest Terokk's Downfall Reportada en http://www.battle.cl/foros/index.php?/topic/9408-misi%C3%B3n-terokks-downfall/
+ 09/04/2014 [BattleCore941] Core/Spell: Se Soluciona el Problema de las Spell Death Rune y Hungerind Cold [DK].
+ 09/04/2014 [BattleCore942] Core/Custom: Final Fix Item Loot Especial (logical typo).
+ 10/04/2014 [BattleCore943] Core/Arena: Se Solucionan los "Shadow Sight" cristal violeta para ver sigilos e invisibles.
+ 12/04/2014 [BattleCore944] Core/Eventos: Solucionamos pequeños improvenientes en evento de "Hallowen" reportados en: http://www.battle.cl/foros/index.php?/topic/6210-quest-evento-haloween-stop-the-fires/
+ 12/04/2014 [BattleCore945] Core/Script: Trial Of Champion:
    + Limpieza de los AI de los champions y Grand Champions.
    + Realizamos que el Charge (Carga) de los campeones (Grand Champions) sea mas dinamica , po lo que los campeones cargaran a todos.
    + Limpieza de Hacks implementados antiguamente.
    + Añadimos un nuevo metodo para el reinicio de la pelea de los campeones.
+ 12/04/2014 [BattleCore946] Core/Script: Fix Quest Dissension Amongst the Ranks Reportada en http://www.battle.cl/foros/index.php?/topic/6801-dissension-amongst-the-ranks/
+ 14/04/2014 [BattleCore947] Core/Spell: Fix [Totem] Grounding. Ahora al consumir los efectos desaparecera. Reportado en http://www.battle.cl/foros/index.php?/topic/9075-totem-grounding/#entry69310
+ 14/04/2014 [BattleCore948] Core/Script: Item Loot Especial Ahora podras desactivar el loot especial correctamente.
+ 14/04/2014 [BattleCore949] DB/Quest: Fix Quest Gauging the Resonant Frequency Reportada en http://www.battle.cl/foros/index.php?/topic/8848-reporte-de-quest-de-monta%C3%B1as-filoespada-que-estan-bugs/
+ 14/04/2014 [BattleCore950] DB/Quest: Fix Quest Whispers of the Raven God Reportada en http://www.battle.cl/foros/index.php?/topic/8848-reporte-de-quest-de-monta%C3%B1as-filoespada-que-estan-bugs/
+ 15/04/2014 [BattleCore951] Core/Loot: Formula de drop rate, afectada por recientes cambios ha sido corregida.
+ 15/04/2014 [BattleCore952] Core/Spell: Fix Spell Gusanos de sangre (DK Bloodworms Talent) Reportado en: http://www.battle.cl/foros/index.php?/topic/8981-gusanos-de-sangre/
+ 15/04/2014 [BattleCore953] Core/Script: Trial Of Champion:
    + Limpieza en Script
    + Añadimos evento faltante para Npc's (Grand Champions) Thrust
    + Removemos los hack de Trinity en el Script
    + Solucionamos improvenientes en Charge.
    + Fix Crash al desmontar los vehículos fuera de la instancia
    + Convertimos Eadric & Paletress' scripts a EventMaps
+ 15/04/2014 [BattleCore954] Core/Spell: Aumento de daño Skill Execute Warrior. AtLike
+ 16/04/2014 [BattleCore955] Core/Custom: Ahora al logear, el player que no este en el canal "pvp" recibira una invitacion para unirse a el.
+ 16/04/2014 [BattleCore956] Core/Bg: Sota:
    + Removemos el trigger del telepor  desde atras de la puerta cuando esta es destruida.
    + Ahora cuando utilizas el teleport este te llevara detrás de la siguiente puerta de ese lado.
+ 16/04/2014 [BattleCore957] Core/Spell: Ahora los Spell instantaneos flash of light y exorcism del talento The Art of War no restablece el swing timer.
+ 17/04/2014 [BattleCore958] Core/Spell: Ahora no usar Blink para acceder a superficies inaccesibles, y se respetara la distancia maxima permitida.
+ 17/04/2014 [BattleCore959] Core/Script: El npc ice tomb(cubos de hielo) del boss sindragosa  ahora sera inmune a los efectos knock back
+ 17/04/2014 [BattleCore960] Core/Spell: Mejoras menores de movimiento de Blink para cuando el destino esperado es inaccesible pero si es posible moverse una distancia menor.
+ 17/04/2014 [BattleCore961] Core/Spell: Solucionamos Improved Devotion Aura ahora al paladin le llegara el beneficio del 6% de heal mas, falta ver como lograrlo para a los que les llegue el aura tengan el mismo efecto. Reportado en: http://www.battle.cl/foros/index.php?/topic/9093-improved-devotion-aura/
+ 17/04/2014 [BattleCore962] Core/Spell: Solucionamos el problema del glyph of succubus Reportad en: http://www.battle.cl/foros/index.php?/topic/7170-glifo-de-sucubo/
+ 17/04/2014 [BattleCore963] Core/Spell: Update a la Spell spell lock Reportada en:http://www.battle.cl/foros/index.php?/topic/8982-bug-spell-lock/
+ 20/04/2014 [BattleCore964] Core/Quest: Fix Quest - The Art of Being a Water Terror Reportada en http://www.battle.cl/foros/index.php?/topic/9516-reporte-quest-icecrow-nuevo/
+ 22/04/2014 [BattleCore965] Core/Script: Movemos los ataques cuerpo a cuerpo de boss Eadric fuera del soporte de eventos y solucionamos problemas de Black Knight que no empezaba para todos.
+ 22/04/2014 [BattleCore966] Core/Script: Fix Crash en mazmorra ToCH reportado en http://www.battle.cl/foros/index.php?/topic/9532-la-prueba-del-campe%C3%B3n-toch/
+ 22/04/2014 [BattleCore967] Core/Script: Actualizamos el movimiento de las Valkyr Shadowguard ahora sera mas blizlike.
+ 22/04/2014 [BattleCore968] Core/Script: Fix crash en mazmorra Magiste Terrace.
+ 22/04/2014 [BattleCore969] Core/Script: Fix crash en npc arena espectador.
+ 23/04/2014 [BattleCore970] Core/Master: Añadimos BattleCore 3 logo en cmd
+ 23/04/2014 [BattleCore971] Core/Script: Solucionamos la Necrotic Plague de LK
+ 23/04/2014 [BattleCore972] Core/Stat: Actualizamos el sistema de estadisticas de las siguiente pets voidwalker, succubus, felhunter
+ 23/04/2014 [BattleCore973] Core/Script: Fix crash en ToCH
+ 23/04/2014 [BattleCore974] Core/Bg: Ahora al entrar en arena y bg le haremos dissmis a la pet para que no entre con buff externos y para que no se bugen los frame en arena. Reprotado en: http://www.battle.cl/foros/index.php?/topic/9549-reset-buff-pets
+ 23/04/2014 [BattleCore975] Core/Spell: Fix Spell Hand of Reckoning Reportada en: http://www.battle.cl/foros/index.php?/topic/6431-hand-of-reckoning/
+ 23/04/2014 [BattleCore976] Core/Pet: Update a reporte Spell gargoyle Dk ahora no deveria salir invalid target Reportado En: http://www.battle.cl/foros/index.php?/topic/9015-bug-de-gargola/
+ 24/04/2014 [BattleCore977] Core/Bg: Solucionamo problemas ocurridos con las pets por [BattleCore974]
+ 24/04/2014 [BattleCore978] Core/Bg: Solucionamos problemas con los vehiculos de sota ahora los demolisher recibiran el bono por las estadisticas de los items de los jugadores. Reportado en: http://www.battle.cl/foros/index.php?/topic/8952-hp-y-damage-pasajero-battleground-demolisher/#entry69725
+ 24/04/2014 [BattleCore979] Core/Script: Fix Quest No Mere Dream Reportada en: http://www.battle.cl/foros/index.php?/topic/9478-no-mere-dream/#entry70281
+ 24/04/2014 [BattleCore980] Variados cambios recogidos de TrinityCore
    + Daño de Sweeping Strikes.
    + Ya no se podra salir de Flame Ring en combate con Halion.
    + Corporeality de Halion.
    + Traducciones oficiales para: Items, Item Set, Quest (solo titulo y descripcion), Objets, NPCs.
    + Ahora no se podra subir a una montura con cualquier aura de transformación. (Blizzlike)
    + Problema en interfaz que indicaba siempre la misma dificultad en Icecrown Citadel. (Siempre mostraba el modo normal)
    + Mejoras en estabilidad.
+ 24/04/2014 [BattleCore981] Core/Script: Actualizamos los cristales de arena que reducen el tiempo de espera ahora al hacerles click te mostrara cuantos players faltan para que se pueda reducir el tiempo de partida.
+ 25/04/2014 [BattleCore982] Script/Ruby: Recorrecciones en Ruby por conflicto con cambios antiguos.
+ 25/04/2014 [BattleCore983] Script/Quest: Solucionamos la Quest Tirion's Gambit Reportada en: http://www.battle.cl/foros/index.php?/topic/9523-tirions-gambit/
+ 25/04/2014 [BattleCore984] Script/Ruby: Revertimos todos los cambios en Halion, a pedido de la gente.
+ 25/04/2014 [BattleCore985] Core/Bg:  Solucionamos problema con las pets en bg reportado en: http://www.battle.cl/foros/index.php?/topic/9601-problema-con-las-pets/#entry70473
+ 27/04/2014 [BattleCore986] Core/SAI: Fix crash en SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS
+ 27/04/2014 [BattleCore987] Core/Event: Crash fix on RunSmartAIScripts.
+ 27/04/2014 [BattleCore988] Core/Unit: Crash fix on IsAlwaysVisibleFor
+ 27/04/2014 [BattleCore989] Core/Vmap: Fix crash en IntersectRay (evitandolo)
+ 27/04/2014 [BattleCore990] Core/Map: Evitando crashes en el Unload del mapa, esto pasa frecuentemente aunque tengas unloadgrid = 0
+ 28/04/2014 [BattleCore991] Core/BG: Ajuste en la forma en que se activan los beneficios o Power-Ups en los campos de batalla y arenas, ahora funcionan de forma correcta. Reportado en: http://www.battle.cl/foros/index.php?/topic/9631-orbes-de-sombras-en-arenas/#entry70622
+ 28/04/2014 [BattleCore992] Core/Spell: Fix crash en Spell::SelectImplicitAreaTargets
+ 29/04/2014 [BattleCore993] DB/Event: Solucionamos errores del evento Children's Week Reportado en: http://www.battle.cl/foros/index.php?/topic/9642-misiones-evento-de-los-ni%C3%B1os/#entry70714
+ 30/04/2014 [BattleCore994] DB/Quest: Howling Fjord: Iron Rune Constructs and You: Rocket Jumping Reportada en: http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 30/04/2014 [BattleCore995] DB/Quest: Howling Fjord: Iron Rune Constructs and You: The Bluff Reportada en: http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 30/04/2014 [BattleCore996] DB/Quest: Howling Fjord: Iron Rune Constructs and You: Collecting Data Reportada en: http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 03/05/2014 [BattleCore997] Script/Custom: Crash fix on FastArenaCrystal.
+ 06/05/2014 [BattleCore998] Core/Collison: Line Of Sight (LOS):
    + Actualizamos el sistema de llamada de las spells que no funcionan si estan en LOS.
    + Blizzard, Rain of fire, Hurricane, Volley Ahora comprueba que los objetivos que se encuentran en la línea de visión esten en el centro del hechizo.
    + Shadowfury y Flamestrike ahora los objetivos seleccionados que esten en línea de visión se realizara desde el centro del efecto de la spell y no el del caster. (Reportado en: http://www.battle.cl/foros/index.php?/topic/9552-bug-shadowfury/)
    + Flamestrike el daño solo se realizara a los jugadores que esten en el centro de la linea de vision.
+ 07/05/2014 [BattleCore999] Core/Custom: Canal pvp
    + Ahora no podran setearle una pass al canal pvp
    + No podran kikear a nadie en el canal
    + No anunciara quienes entran o salen del canal
    + No anunciara cuando cambia de owner el canal.
+ 07/05/2014 [BattleCore1000] Core/System: Implementamos Sistema Antifarm para arenas.
+ 07/05/2014 [BattleCore1001] Core/Script: Pequeñas mejoras al movimiento de valkyr en ICC (LK) y añadimos un evento para el spell explosion (Blizlike).
+ 08/05/2014 [BattleCore1002] Core/Spell: Final Fix Spell Lock silence Reportada en http://www.battle.cl/foros/index.php?/topic/8982-bug-spell-lock/
+ 08/05/2014 [BattleCore1003] Core/Chat: ahora los gms en el chat general (say) su texto sera azul (Evitamos los exploit de gente que se hace pasar por gm).
+ 08/05/2014 [BattleCore1004] Core/Script: Fix Bugs en pelea vazruden (HR).
+ 08/05/2014 [BattleCore1005] Core/Script: Mejoras a boss argent challenge ToCH
+ 08/05/2014 [BattleCore1006] Core/Script: Fix Quest - The Way to His Heart... Reportada en: http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 08/05/2014 [BattleCore1007] Core/Vehicle: Actualizamos Velocidad de los vehiculos de Bg SoTA, IoC Wintergrasp
+ 08/05/2014 [BattleCore1008] Core/Spell: Nerf Spell deep wound Warrior AT Like
+ 11/05/2014 [BattleCore1009] Core/Script: Final Fix Val'kyr Shadowguard velocidad en LK.
+ 11/05/2014 [BattleCore1010] Core/Bg: Crash Fix BattlegroundMgr::SendToBattleground
+ 11/05/2014 [BattleCore1011] Core/Spell: Crash Fix AuraEffect::HandleEffect
+ 11/05/2014 [BattleCore1012] Core/Script: Fix Boss Ingvar the Plunderer ajustes blizlike y solucion al logro Reportado en: http://www.battle.cl/foros/index.php?/topic/9558-utgarde-keep-heroic/
+ 12/05/2014 [BattleCore1013] Core/Achievements: Fix crash AchievementMgr::GetCriteriaProgress
+ 12/05/2014 [BattleCore1014] Core/Quest: Fix Quest Drop It then Rok It! Reportada en http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 12/05/2014 [BattleCore1015] Core/Quest: Fix Quest - There Exists No Honor Among Birds Reportada en http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 14/05/2014 [BattleCore1018] DB/Quest: Fix Quest Destroying the Altars Reportada en: http://www.battle.cl/foros/index.php?/topic/9516-reporte-quest-icecrow-nuevo/
+ 14/05/2014 [BattleCore1019] Core/Script: Fix QuestBanshee's Revenge Reportada en: http://www.battle.cl/foros/index.php?/topic/9516-reporte-quest-icecrow-nuevo/
+ 14/05/2014 [BattleCore1020] DB/Quest: Fix Quest Putting Olakin Back Together Again Reportada en: http://www.battle.cl/foros/index.php?/topic/9516-reporte-quest-icecrow-nuevo/
+ 14/05/2014 [BattleCore1021] Core/Spell: El teleport de warlock no sacara de combate.
+ 14/05/2014 [BattleCore1022] DB/Quest: Fix Quest Zuluhed the Whacked Reportada en: http://www.battle.cl/foros/index.php?/topic/9694-zuluhed-el-demente/
+ 21/05/2014 [BattleCore1023] Db/Quest: Fix Quest Evento Childrens week
+ 21/05/2014 [BattleCore1024] Core/Spell: Update Daño Eviscrate  Reportado en http://www.battle.cl/foros/index.php?/topic/9294-puyazo/
+ 21/05/2014 [BattleCore1025] Core/Arena: Se implementan Preparativos para arena en el estado de espera de inicio de arena, Sugerencia reportada en: http://www.battle.cl/foros/index.php?/topic/9844-preparativos/
    + En el caso que sea un mago la mesa de conjuros estara añadida previamente (Conjure Refreshment Table)
    + En el caso de brujos Ritual of Souls estara añadida previamente
    + En el caso de cazadores Call Pet estara añadida previamente
+ 21/05/2014 [BattleCore1026] Script/Custom: Duel
    + Se ha corregido reset de duelo. (Reporta cualquier incidencia en el foro)
    + Se han realizado correcciones a sistema de rate de duelos (Aun no disponible).
+ 22/05/2014 [BattleCore1027] Core/Script: Incrementamos el daño de Bone storm (ICC) Blizlike
+ 23/05/2014 [BattleCore1028] Core/Quest: Fix Quest Betrayal Reportada en: http://www.battle.cl/foros/index.php?/topic/9519-betrayal-cadena-de-drakuru/
+ 24/05/2014 [BattleCore1029] Custom/Script: Fast Arena Crystal corregido
+ 24/05/2014 [BattleCore1030] Custom/Script: Ahora en las House funcionara el reset de duelo.
+ 25/05/2014 [BattleCore1031] Custom/Item: Actualizacion de tabards de campeon del torneo pvp.
+ 26/05/2014 [BattleCore1032] Core/Script: Actualizamos Spawn de Nefarian.
+ 26/05/2014 [BattleCore1033] Core/Spell: Fix Spell Anti-magic Zone
+ 26/05/2014 [BattleCore1034] Core/Pet: Cargamos las auras de las mascotas antes de establecer el estado de salud(HP), esto soluciona el problema Reportado en: http://www.battle.cl/foros/index.php?/topic/7108-pets/
+ 26/05/2014 [BattleCore1035] Core/Script: ICC: Lady reiniciamos el agro en la fase II
+ 26/05/2014 [BattleCore1036] DB/Quest: Fix Quest It's All Fun and Games Reportada en: http://www.battle.cl/foros/index.php?/topic/9931-pura-diversion/
+ 26/05/2014 [BattleCore1037] Core/Script: Fix Quest Shred the Alliance Reportada en http://www.battle.cl/foros/index.php?/topic/9889-shred-the-alliance-quest/
+ 26/05/2014 [BattleCore1038] Core/Script: Fix Quest Dead Man's Plea Reportada en :http://www.battle.cl/foros/index.php?/topic/9753-quest-dead-mans-plea-bug/
+ 26/05/2014 [BattleCore1039] Db/Spell: Fix Lock And Load Solucionamos el 6% proc
+ 28/05/2014 [BattleCore1040] Db/Quest: Fix Quest A Carver and a Croaker Reportada en: http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 28/05/2014 [BattleCore1041] Core/Quest: Fix Quest - It Goes to 11 Reportada en: http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 28/05/2014 [BattleCore1042] Db/Quest: Fix Quest Assault by Ground Reportada en: http://www.battle.cl/foros/index.php?/topic/9516-reporte-quest-icecrow-nuevo/
+ 28/05/2014 [BattleCore1043] Db/Quest: Fix Quest - The Flesh Giant Champion Reportada en: http://www.battle.cl/foros/index.php?/topic/9516-reporte-quest-icecrow-nuevo/
+ 28/05/2014 [BattleCore1044] Core/Script: Actualizamos Soporte Quest Tirion's Gambit
+ 28/05/2014 [BattleCore1045] Core/Player: Solucionamos el autoattack timer ahora este ataque no se ve afectado por el delay (hasta los 700ms)
+ 28/05/2014 [BattleCore1046] COre/Script: Ajustamos el tiempo de Meteor Strike en Halion (RS)
+ 31/05/2014 [BattleCore1047] DB/Wintergrasp: Correccion de guardias faltantes.
+ 01/06/2014 [BattleCore1048] Core/Custom: Evento Batalla Strategica
    + Hola chicos! He estado trabajando en esto últimamente.
    + Ahora, yo no sé cómo llamarlo realmente. Disponible para Renombre
    + El juego consiste en:
    + El jugador a la izquierda es el jugador 1 y el jugador de la derecha es el jugador 2.
    + Un jugador tiene una estrategia de defensa o ataque. Usted puede comprar Spike Defense (Pinchos de Defensa),la cual coloca Spike Bombs (Bombas de pinchos) alrededor de su base para protegerlo.
    + El concepto principal de este juego es derrotar a los minions (Secuaz) del jugador contrario. Si lo hace, se traducirá en una victoria y la recompensa al final.
    + El jugador 2 tiene el mismo concepto del Jugador 1, pero tiene la opción de generar torres Tótem para proteger su base.
    + Este evento esta en una etapa de prueba.
    + Vamos a una explicación mas detallada.
    + Jugador uno debe comenzar el juego, el jugador 2 no puede acceder a su menú hasta que el jugador 1 se haya registrado e iniciado.
    + Esto se debe a que por lo menos un jugador tendrá control sobre el juego para iniciarlo. Ahora, una vez que el jugador se ha registrado (haciendo clic en su minion (secuaz):
    + Usted tiene una cierta cantidad de unidades (las unidades pueden cambiar durante el desaroollo). El [X] (X = cualquier número) representa el número de unidades que se generan en la cola.
    + Unidades de Jugador 1 (sujeto a cambios):
    + Bestia no-muerto
    + Troll no-muerto
    + Crypto no-muerto
    + Torre de Defensa de pinchos
    + Jefe (Desconocido)
    + Unidades de Jugador 2 (sujeto a cambio):
    + vikingo
    + Vikingo con armadura
    + Dragón
    + Torre de defensa Totem
    + Jefe (Desconocido)
    + Cada jugador tiene un jefe que puede convocar, pero cada unidad e incluyendo el jefe requiere recursos para comprar.
+ 01/06/2014 [BattleCore1049] Core/Conditions: Correccion en interpretacion de WorldStates con Conditions, que generaba errores en Wintergrasp.
+ 01/06/2014 [BattleCore1050] Core/Custom: Actualizamos el sistema de invitacion al canal PVP
+ 02/06/2014 [BattleCore1051] DB/Quest: Update Quest Gods like shiny things
+ 03/06/2014 [BattleCore1052] Core/Custom: Arena Espectador:
    + Mejoras los frames de las pets ahora no se bugearan cuando se cambia el hp de las pets en el addon.
    + Ahora se mostrara la especializacion (build) del jugador.
    + Añadimos el total de arenas y las arenas que se estan jugando en el npc del arena espectador.
    + Ahora el npc mostrarar correctamente el numero de arenas, cuando no haya en curso ninguna arena podras volver al menu principal
+ 03/06/2014 [BattleCore1053] Core/Arena: Ring Of Valor:
    + Corregimos Bugs de los ascensores en el inicio de la arena.
    + Corregimos bug con los pilares de la arena (Soluciona temporal)
+ 03/06/2014 [BattleCore1054] Core/SpellAuras: Prevenimos crash UnregisterSingleTarget
+ 03/06/2014 [BattleCore1055] Core/Spell: Solucionamos reduccion de armadura del spell 'Enrage' (5229) [druida] y cambios en las formas pasivas de oso 'Bear form passive' (1178, 9635)
+ 03/06/2014 [BattleCore1056] Core/BG: Fix Logro Defense of the Ancients Reportado en: http://www.battle.cl/foros/index.php?/topic/8033-defense-of-the-ancients/
+ 03/06/2014 [BattleCore1057] Core/Spell: Ahora las Spell de LK no apuntan a line of sight (LOS) (Posible Fix Necrotic)
+ 03/06/2014 [BattleCore1058] Core/Script: Posible Fix Nefarian Reportado en: http://www.battle.cl/foros/index.php?/topic/9378-bwl-nefarian/
+ 04/06/2014 [BattleCore1059] Core/Aura: Fix Crash en auras cuando son eliminadas
+ 04/06/2014 [BattleCore1060] DB/Quest: Ajustamos fix Quest It's All Fun and Games Reportada en: http://www.battle.cl/foros/index.php?/topic/9931-pura-diversion/
+ 04/06/2014 [BattleCore1061] DB/Quest: Fix Quest - The Black Knight's Reportada en: Cursehttp://www.battle.cl/foros/index.php?/topic/9638-mision-la-maldicion-del-caballero-negro/
+ 04/06/2014 [BattleCore1062] Core/Script: Fix Posible Crash en boss blood queen lana thel
+ 04/06/2014 [BattleCore1063] Core/Player: Actualizamos la formula de Haste (Core/Players: Fix haste rating formulas https://github.com/TrinityCore/TrinityCore/commit/f5e6292b481c3d2731da33663cbefc73d5a7f14a)
+ 04/06/2014 [BattleCore1064] Core/Custom: Ahora las pets en los duelos tambien se les reiniciara su vida.
+ 04/06/2014 [BattleCore1065] Core/Script: Ahora Highlord Darion Mograine de la zona de los dk's tendra un respawn al instante.
+ 04/06/2014 [BattleCore1066] Core/TC: Compilacion de Fix de TC.
    + Mejoras en estabiliadd del reino (Fix crash).
    + Mejora fear bajo efectos de daño ahora tendra un comportamiento bli$$like.
+ 04/06/2014 [BattleCore1067] Core/Spell: Solucionamos la spell Death Grip  en la Arena Ring Of Valor
+ 07/06/2014 [BattleCore1068] Core/Creature: Fix crash  Creature::CanAlwaysSee
+ 07/06/2014 [BattleCore1069] Core/Arena: PR/MMR rating ahora cambiara al salirse(leave) de la arena
+ 08/06/2014 [BattleCore1070] Core/Scripts: Bug Logico con boss Paletres (TOCH)
+ 08/06/2014 [BattleCore1071] Core/Spells: Ahora las habilidades como shred & backstab (entre otras) no pueden ser esquivadas o parreadas (dodged & parry) versus jugadores
+ 09/06/2014 [BattleCore1072] Core/Custom: Removemos Spam Log de Arena Espectador en consola
+ 09/06/2014 [BattleCore1073] Core/Spell: Mejoramos Fix crash imlpementado en [BattleCore1059 ffe1180a18770d8988c11122192b92cb96f33e10 ] (Ahora si no deberia suceder).
+ 09/06/2014 [BattleCore1074] Core/Spell: Mejoramos La Spell 'Levantar aliado'/'Raise Ally' (61999) [DK] Ahora comprobara la spell antes de ser casteada.
+ 09/06/2014 [BattleCore1075] Core/Script: ICC/LK:
    + Evitamos que Raging Spirits no tengan ningun efecto en la fase de Frostmourne
    + Evitamos que Vile Spirits entren en el interior de Frostmourne
+ 10/06/2014 [BattleCore1076] Core/BG: Corregimos Logro implementado en [BattleCore1056] (fcdd44df8c079c1dc9b7d1691b816ba549c0b11e) "Logro Defense of the Ancients"
+ 10/06/2014 [BattleCore1077] Core/Instance: Fix Exploit:
    + Ahora al usar alt+f4 en cualquier caso el player permanecera con un delay de combate dejando a este en estado muerto (metodo bli$$like).
    + Ahora cuando estas en encounter (durante el combate de alguna pelea en mazmorras o bandas), no podras logear
    + Se reduce el homebind de la instance para prevenir exploit de loot.
    + Se añade un chequeo para prevenir exceder el limite de players en cualquier mode de alguna instance.
+ 11/06/2014 [BattleCore1078] Core/Custom: Nuevo sistema de Anuncios Arena
+ 15/06/2014 [BattleCore1079] Se revierte cambio [BattleCore1065] 2306a15a49bb6ac3bfae9d0ecf19004ff12af3b7
+ 15/06/2014 [BattleCore1080] Core/Script: Lich King, Solucion parcial para Lich King's Last Stand
+ 19/06/2014 [BattleCore1081] Core/Map: Fix crash en std::_Rb_tree_increment
+ 19/06/2014 [BattleCore1082] Core/Player: Fix Crash Player::RemoveFromWorld()
+ 19/06/2014 [BattleCore1083] Core/Spell: Parcial Fix Quest Riding the Red Rocket Reportada en: http://www.battle.cl/foros/index.php?/topic/9888-riding-the-red-rocket-quest/
+ 19/06/2014 [BattleCore1084] Core/DB: Fix Quest Let's Go Surfing Now Reportada en: http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 19/06/2014 [BattleCore1085] Core/Spell: Fix Improved succubus Añadimos DR Mejora [BattleCore609] 86cd5f6692cc4ac27d29a7fdc4c3bb6d07a4a80b (Reportado en http://www.battle.cl/foros/index.php?/topic/6363-sucubo-mejorado/).
+ 19/06/2014 [BattleCore1086] Core/Script: ICC: Ahora Vile Gas no tendra efecto a totems ni a pets
+ 21/06/2014 [BattleCore1087] Core/Script: Actualizamos Scipt Midsummer Boss Ahune Bli$$Like.
+ 22/06/2014 [BattleCore1088] Core/Script: Fix recompenza DF de boss Ahune
+ 22/06/2014 [BattleCore1089] Core/Script: Midsummer:
    + Fix logro Torch Juggler Reportado en: http://www.battle.cl/foros/index.php?/topic/10169-evento-midsummer-fire-festival/
    + Fix Quest Torch Tossing Reportado en: http://www.battle.cl/foros/index.php?/topic/10169-evento-midsummer-fire-festival/
    + Fix Quest Torch Catching Reportado en: http://www.battle.cl/foros/index.php?/topic/10169-evento-midsummer-fire-festival/
+ 26/06/2014 [BattleCore1090] Core/Script: Midsummer - Fix Logro King of the Fire Festival Reportado en: http://www.battle.cl/foros/index.php?/topic/10169-evento-midsummer-fire-festival/
+ 26/06/2014 [BattleCore1091] Core/Script: Midsummer - Fix Logro Burning Hot Pole Dance
+ 27/06/2014 [BattleCore1092] Core/Spell: Posible Fix Spell Death Rune [Dk]
+ 28/06/2014 [BattleCore1093] Script/Command: Nuevo comando para la eliminacion de logros
+ 29/06/2014 [BattleCore1094] Core/Spell: Fix Rango de Spells (Varios), Ejemplo Aracane Misisiles Reportada en: http://www.battle.cl/foros/index.php?/topic/7646-arcane-missiles/#entry72059
+ 29/06/2014 [BattleCore1095] Core/Vehicle: Posible Crash Fix Vehicle::RelocatePassengers() (Ayudando a Crash de [BattleCore1081] 20c39f7c4c2f28c7a5a908b3e0b91b2d2e5ec073 )
+ 30/06/2014 [BattleCore1096] Core/Custom: Solucionamos el problema con las vetas que cuando quedaban con loot dentro se bugeaba el respawn.
+ 30/06/2014 [BattleCore1097] Core/DB: Solucionamos Algunos errores menores para poder completar la Quest Torch Tossing
+ 30/06/2014 [BattleCore1098] Core/Script: Ajustamos logro Torch Juggler
+ 31/06/2014 [BattleCore1099] Core/Script: Midsummer - Mejoras Boss Ahune
+ 01/07/2014 [BattleCore2000] Core/Script: Midsummer - Actualizamos los textos del boss Ahune
+ 01/07/2014 [BattleCore2001] Core/Db: Vinculamos todos los spawn del evento Midsummer a sus correspondientes tablas de event, Ajustamos los camps defectuosos y spawn faltantes.
+ 01/07/2014 [BattleCore2002] Core/Custom: Solucionamos errores del Addon en Arena Espectador.
+ 01/07/2014 [BattleCore2003] Core/Bg: ROV añadimos Data de gameobject de Ring Of valor faltantes.
+ 01/07/2014 [BattleCore2004] Core/Spell: Correccion en delay de spell Ghost, que afectaba funcionamiento de visitas a GuildHouses
+ 02/07/2014 [BattleCore2005] Core/DB: Midsummer -  Solucionamos el bonnus del set del evento (Infused with the spirit of Midsummer)
+ 04/07/2014 [BattleCore2006] Core/Custom: Mejora Fix implementado en [BattleCore1096] (c9bdd38693d08b5445ab735f4137a6f2cb001905), Ahora las minas tendran el respawn adecuado cuando dejas algo del botin dentro.
+ 06/07/2014 [BattleCore2007] Core/Custom: Vein: Corregimos el bug de que el script del botin solo funcionaba con una mina.
+ 08/07/2014 [BattleCore2008] Core/Spell: Berserk: prevenimos doble buff de Berserk en los enchant de weapons.
+ 08/07/2014 [BattleCore2009] Core/Spell: El heal de Haunt (Warlock Spell) debe tomar el daño del golpe critico (AfterHit).
+ 08/07/2014 [BattleCore2010] Core/Custom: Evitando exploits con Arena Espectador.
+ 08/07/2014 [BattleCore2011] Core/Custom: Actualizamos el Npc Arena Espectador.
+ 10/07/2014 [BattleCore2012] DB/Quest: Fix Improvenientes en Fix de Quest  Iron Rune Contructs and You: Rocket Jumping Reportada en: http://www.battle.cl/foros/index.php?/topic/9520-reporte-quest-howling-fjord/
+ 12/07/2014 [BattleCore2013] Core/Commands:  Reliazamos que los daños (DAMAGE_FALL) no sean afectados cuando te encuentras bajo el comando .cheat god
+ 12/07/2014 [BattleCore2014] Core/Spell: Añadimos 8 segundos de cooldown a 'Life Steal' (20004) [Lifestealing enchant].
+ 12/07/2014 [BattleCore2015] DB/Event: Midsummer:
    + Removemos Obsoletas Quest de Midsummer Fire Festival.
    + Solucionamos reporte de [Bugs] Midsummer
    + Añadimos las quest de Midsummer Fire Festival a game event seasonal para que el proximo año los players antiguos no tengan problemas en realizar nuevamente las quest.
+ 12/07/2014 [BattleCore2016] Db/Quest: Fix Bli$$like a Quest A Carver and a Croaker
+ 14/07/2014 [BattleCore2017] Core/Spell: Ahora la Necrotic no podra ser resistida.
+ 14/07/2014 [BattleCore2018] Core/Spell: Swift Retribution se debe poder volver a aplicar su metodo cuando sea necesario.
+ 15/07/2014 [BattleCore2019] Core/World: Correccion en procesamiento de consultas al banear personajes.
+ 18/07/2014 [BattleCore2020] Se ha revertido [BattleCore739]
+ 29/07/2014 [BattleCore2021] Core/Script: Resolvemos problemas de despawn en Nefarian. [BWL]
+ 29/07/2014 [BattleCore2022] Core/Script: ICC
+ 29/07/2014 [BattleCore2023] Core/Spell: Fix Global cooldown serverside check
+ 29/07/2014 [BattleCore2024] Core/Quest: Fix tpos Quest Banshee's Revenge
+ 29/07/2014 [BattleCore2025] Core/Custom: Arena Spectator, Limpieza de codigo
+ 30/07/2014 [BattleCore2026] Script/Custom: Correcciones a Arena Spectator y metodos asociados.
+ 30/07/2014 [BattleCore2027] Script/Spell: Mejoras para estabilidad.
+ 01/08/2014 [BattleCore2028] Core/Pet: Fix Raise Dead cooldown
+ 01/08/2014 [BattleCore2029] Core/Spell: Fix Bug T9 Pala, DK, Hunter desactivamos triple daño
+ 01/08/2014 [BattleCore2030] Core/Channel: Removemos los avisos de join y leave de los canales.
+ 04/08/2014 [BattleCore2031] Core/Script: Solucionamos problemas ICC Blood Prince Council (kinectic bomb) Reportado en: http://www.battle.cl/foros/index.php?/topic/10181-icc-blood-prince-council/#entry77985
+ 04/08/2014 [BattleCore2032] Core/Script: ICC Ahora en saurfang Rune of Blood ignorara el armor
+ 04/08/2014 [BattleCore2033] Core/Script: ICC Saurfang incrementamos el poder de regenarcion de las runas de sangre
+ 04/08/2014 [BattleCore2034] Core/Custom: Añadimos Gomove addon para los gms para manejar los objetos del juego de una manera mas facil.
+ 05/08/2014 [BattleCore2035] Core/Aura: Nuevos sitema de Stack de auras y spells. (Base Trinity Core)
    + Core/Auras: Expanding functionality of SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT to be able to take care of aura effects inside their handlers
        + Currently handled:
            + SPELL_AURA_MOD_RESISTANCE_PCT
            + SPELL_AURA_MOD_STAT
            + SPELL_AURA_MELEE_SLOW
            + SPELL_AURA_MOD_MELEE_HASTE
            + SPELL_AURA_MOD_DAMAGE_PERCENT_DONE
    + Necessary to allow stack rules such as BoK/BoS/Bok-Drums and others to be all in a target with all of the aura effects, yet with only the 'highest' effect active (Fixing)
    + Core/Auras: Add a new stack rule to handle cases where the aura that is 'stronger' prevails (SPELL_GROUP_STACK_RULE_EXCLUSIVE_HIGHEST)
    + DB/SpellGroups: Completely review of WotLK Stack Rules
    + DB/SpellGroups: Quick fixes in latest SQL
    + Core/Auras: Implement stacking interaction between SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE and SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT. Allows BoK/BoS to stack while maintaining the strongest buff
    + DB/SpellGroups: Fix Poison Stacking
+ 05/08/2014 [BattleCore2036] Core/Battleground: Correcciones a sistema de reserva de cupo.
+ 05/08/2014 [BattleCore2037] Core/Server: Mejora en sistema de filtracion de IP extranjera.
+ 14/08/2014 [BattleCore2038] Script/Veins: Corregimos y mejoramos sistema de respawn para veins, no completamente looteadas.
+ 15/08/2014 [BattleCore2039] DB/Spell: Solucionamos el problema de stack de la spell Ebon plague (DK)
+ 15/08/2014 [BattleCore2040] Core/Bg: Reescribimos el metodo de llamada de RBG (Random Battle Ground).
+ 15/08/2014 [BattleCore2041] Core/Script: Fix Val'kyr  que quedaban volando en los players.
+ 15/08/2014 [BattleCore2042] Core/SpellInfo: ahora al morir removera el aura correctamente (Divine Intervention)
+ 15/08/2014 [BattleCore2043] Core/Spel: Fix exploit de rogue en respec ahora removera correctamente Rogue's Overkill & Rogue's Master of Subtlety
+ 15/08/2014 [BattleCore2044] Core/Custom: Implementamos sistema de leveleo de hermandad, por el cual mediante la obtencion de experiencia podras adquirir fabulosos bonus de hermandad.
+ 17/08/2014 [BattleCore2045] DB/Vendor: Se añaden [Formula: Enchant Weapon - Blade Ward] y [Formula: Enchant Weapon - Blood Draining] para la venta por 150 [Badge of Justice] con [Vanessa Sellers].
+ 18/08/2014 [BattleCore2046] Core/RollSystem: Resuelve problema con los items que son desencantados por el jugador cuando este tiene el inventario lleno para recibir el loot.
+ 19/08/2014 [BattleCore2047] Core/Script: Añadimos comandos para nuevo sistema de phases
+ 20/08/2014 [BattleCore2048] DB: Solucionamos problema de Item (http://www.wowhead.com/item=32696/banishing-crystal) este podia ser utilizado en cualquier zona, ahora solo podra usarse en la zona correspondiente.
+ 26/08/2014 [BattleCore2049] DB: Solucionamos problemas (Exploit) con el item Rocket Pack (Gunship ICC).
+ 27/08/2014 [BattleCore2050] Core/SAI: Fix Quest de Escort en grupo. (Recompenza)
+ 27/08/2014 [BattleCore2051] Core/Script: ICC:
	+ La puerta de acceso a Crimson Hall's no debe abrirse hasta que todos los trash esten muertos. (Video de referencia: http://youtu.be/yQo3vXGXTHQ?t=53m54s)
+ 27/08/2014 [BattleCore2052] Core/Script: Fix crash npc_geezle podias empezar cuantas veces quieras el evento.
+ 27/08/2014 [BattleCore2053] Core/Player:
	+ Removemos de la mecanica general de recibir XP en quest las de DF (Dungeon Finder).
	+ Solucionamos un problema con las quest que piden tiempo para ser desarrolladas. (FailQuest)
+ 27/08/2014 [BattleCore2054] Core/Arena: Fix Exploit no puede remover a un player del team mientras estas en una pelea.
+ 31/08/2014 [BattleCore2055] Core/Commands: Añadimos comando de Quest Completer (.qc $linkquest) a los players (mas informacion revisar articulo sobre el comando).
+ 03/09/2014 [BattleCore2056] Core/Script: ICC/Prof: Solucionamos los problemas de efectos knockback de los Ooze en los target.
+ 03/09/2014 [BattleCore2057] Core/Script: ICC: Solucionamos problemas con pre evento de sindragosa.
+ 03/09/2014 [BattleCore2058] Core/Battleground: Call to arms, Solucionamos la Quest de CTA, ahora seran completadas correctamente al equipo ganador.
+ 03/09/2014 [BattleCore2059] Core/Unit: Solucionamos problemas con Brunhildar Disguises
+ 07/09/2014 [BattleCore2060] Core/Guild: Se han corregido errores con la exp, al subir de nivel.
+ 07/09/2014 [BattleCore2061] Core/Script: Fic Crash Quest Zuldrak. (npc_enormos)
+ 08/09/2014 [BattleCore2062] Core/MotionMaster: Evitando crashes de UpdateUnderWaterState validando coordenadas
+ 08/09/2014 [BattleCore2063] Core/Battlegrounds: IOC: Ahora al morir los jugadores se iran a los cementerios de correctos.( dependiendo de la faccion de cada cementerio).
+ 09/09/2014 [BattleCore2064] Core/Mecanica: Solucionamos problemas Con el Stheal Reportados en el foro & Fix Death Rune.
+ 09/09/2014 [BattleCore2065] Core/Battleground: IOC: Añadimos script a boss Alliance & Horde - Se realiza un chequeo para evitar exploit con los boss.
+ 10/09/2014 [BattleCore2066] Core/Mechanic: Implementamos Rune Grace Period (Solucion Final Death Rune)
+ 10/09/2014 [BattleCore2067] Core/Script: Se soluciona problema de Quest A Hero's Burden Reportada en: http://www.battle.cl/foros/index.php?/topic/10685-la-carga-de-un-h%C3%A9roecuenca-de-sholazar/
+ 10/09/2014 [BattleCore2068] Core/Script: Se Soluciona el problema con la quest Gods like Shiny Things. Reportada en http://www.battle.cl/foros/index.php?/topic/10349-gods-like-shiny-things-a-los-dioses-les-gustan-los-brillantes/
+ 11/09/2014 [BattleCore2069] Core/Spell: Solucionamos Exploit de hunter con talento Cobra Strikes (no mas criticos infinitos).
+ 11/09/2014 [BattleCore2070] Core/Spell: Sheath of Light, hacemos que sea acumulativa.
+ 11/09/2014 [BattleCore2071] Core/Spells: Hunter - Fix Rap formula de Autoshot, Killshot, Aimed Shot, Multishot
+ 11/09/2014 [BattleCore2072] Core/Loot: Solucionamos problemas con loot duplicado.
+ 11/09/2014 [BattleCore2073] Core/Spell: Solucionamos Spell Shadow Dance (Relacionada en commit [BattleCore2064])
+ 11/09/2014 [BattleCore2074] Core/Battleground: Prevenimos que se pueda entrar a arena con Well fed (o buff de comuda)
+ 11/09/2014 [BattleCore2075] Core/Spell: Mage: Fix exploit Focus Magic (54646) talento, Ahora es removido si el player no tiene el talento.
+ 11/09/2014 [BattleCore2076] Core/Auras: Solucionamos exploit de SPELL_AURA_MOD_DAMAGE_DONE & weapon swapping
+ 11/09/2014 [BattleCore2077] Core/Spell: Posible Solucion reporte LoS http://www.battle.cl/foros/index.php?/topic/10891-bug-thunderstorm/#entry80048
+ 11/09/2014 [BattleCore2078] Core/Spell: Posible Fix Spell ShadowBurn Reportada en http://www.battle.cl/foros/index.php?/topic/11236-bug-shadowburn-quemadura-de-sombras/#entry80991
+ 11/09/2014 [BattleCore2079] Core/Mecanica: Solucionamos regla de mecanica general de done & taken procs (DoTs & HoTs), ahora los DoTs & HoTs de items y escuelas de auras seguiran la regla correcta de mecanica, no la actual que es de 3.0.3
+ 25/09/2014 [BattleCore2080] Core/Script: Solucionamos problemas del evento Brewfest reportados en http://www.battle.cl/foros/index.php?/topic/11435-brewfest-evento/#entry82537
+ 27/09/2014 [BattleCore2081] Script/Spell: Ahora al accionar el D.I.S.C.O. comenzara la fiesta!
+ 28/09/2014 [BattleCore2082] DB/Spell: [Call Emerald Drake] solo puede ser usado en [The Oculus].
+ 29/09/2014 [BattleCore2083] Core/Spell: Solucionamos problemas con Stheal, ahora sera removido correctamente.
+ 29/09/2014 [BattleCore2084] DB/Spell: [Call Ruby Drake] y [Call Amber Drake] solo pueden ser usados en [The Oculus].
+ 29/09/2014 [BattleCore2085] Script/Spell: Ahora [The Flag of Ownership] deberia funcionar ;).
+ 03/10/2014 [BattleCore2086] Core/Script: Solucionamos problema con Quest Bark for the Barleybrews & There and back again ahora seran completables para la allianza
+ 03/10/2014 [BattleCore2087] Core/Script: Ahora los items podran tener un gossip (menu) =)
+ 05/10/2014 [BattleCore2088] Core/Script: Final Fix Evento Dark Iron Attack (Brewfest).
+ 05/10/2014 [BattleCore2089] Core/Spell: Solucionamos problemas de stheal rogue vs rogue.
+ 05/10/2014 [BattleCore2090] Core/Spell: Solucionamos problemas del totem grounding y mejoramos el sistema de spell reflection relatados en: http://www.battle.cl/foros/index.php?/topic/11589-bug-grounding/
+ 05/10/2014 [BattleCore2091] Core/Bg: Solucionamos que no se pueda atacar entre por las paredes en el campo de batalla de Isle of conquest.
+ 05/10/2014 [BattleCore2092] Core/Spell: Posible Fix Death Rune (DK).
+ 06/10/2014 [BattleCore2093] Core/Scropt: Nightbane (karazhan)
	+ Ahora Nightbane podra ser llamo desde el objeto blackened urn correctamente
	+ Solucionamos errores en las fases del jefe.
	+ Ajustamos tiempos del jefe.
+ 06/10/2014 [BattleCore2094] Core/DB: Solucionamos problema de quest The Angry Gorloc reportada en: http://www.battle.cl/foros/index.php?/topic/11564-el-gorloc-enfadado/
+ 06/10/2014 [BattleCore2095] Core/DB: Solcionamos Quest Are we there, yeti? Reportada en  http://www.battle.cl/foros/index.php?/topic/11483-bug-quest-yeti%C2%BFya-hemos-llegado-parte-3/ & http://www.battle.cl/foros/index.php?/topic/10664-yeti-%C2%BFya-hemos-llegado/#entry77197
+ 06/10/2014 [BattleCore2096] Core/DB: Solucionamos problema de quest Mystery of the Infinite, Redux Reportada en: http://www.battle.cl/foros/index.php?/topic/11138-misi%C3%B3n-el-misterio-del-infinito-vuelta-atr%C3%A1s/
+ 06/10/2014 [BattleCore2097] Core/SpellAuraEffects:  Posible solucion a encantamiento Lightweave Embroidery Reportado en: http://www.battle.cl/foros/index.php?/topic/11539-bug-encantamiento-de-sastreria/
+ 06/10/2014 [BattleCore2098] Core/Script: Solucionamos problema de logro Mine Sweeper Reportado en: http://www.battle.cl/foros/index.php?/topic/9082-achievement-mine-sweeper/
+ 11/10/2014 [BattleCore2099] Core/Quest: Solucionamos problemas relatados en quest Redeeming the Dead & Redemption, Reportadas en: http://www.battle.cl/foros/index.php?/topic/9189-quest-para-skill-resurrecin-de-palad-n-blood-elf-bug/.
+ 19/10/2014 [BattleCore2030] Core/Spell: Optimizamos codigo de Beacon Of Light.
+ 19/10/2014 [BattleCore2031] Core/Auras: Incrementamos el almacenamiento de auras de 64 a 128
+ 22/10/2014 [BattleCore2032] Core/Script: Fix Quest No Mere Dream Reportada en: http://www.battle.cl/foros/index.php?/topic/9597-no-mere-dream/
+ 22/10/2014 [BattleCore2033] Core/DB: Fix Quest Arcane Disturbances Reportada en: http://www.battle.cl/foros/index.php?/topic/11123-quest-alteraciones-arcanas-mala-c/
+ 22/10/2014 [BattleCore2034] Core/DB: Fix Quest Defiling Uther's Tomb Reportada en: http://www.battle.cl/foros/index.php?/topic/7716-bug-quest-defiling-uther%C2%B4s-tomb/
+ 25/10/2014 [BattleCore2035] Core/Script: Solucionamos Problemas de Quest The Headless Horseman Reportada en: http://www.battle.cl/foros/index.php?/topic/11721-logro-de-halloween-el-salvador-de-halloween/ , pequeñas mejoras boss Headless Horseman
+ 25/10/2014 [BattleCore2036] Core/Spell: Solucionamos exploit Hunter damage.
+ 02/11/2014 [BattleCore2037] Core/Script: Fix Crash introducido en BattleCore2035 evento Hallowend
+ 02/11/2014 [BattleCore2038] Core/DB: Solucionamos problemas relatados con evento Day of the Dead reportado en: http://www.battle.cl/foros/index.php?/topic/11799-day-of-the-dead-evento/
+ 02/11/2014 [BattleCore2039] Core/Spell: Fix exploit Hot y dot's.
+ 03/11/2014 [BattleCore2040] Core/Spell: Fix exploit  Predatory Strikes
+ 03/11/2014 [BattleCore2041] Core/Spell: One-hand weapon specialization, realizamos que las armas de una mano no se beneficien de spells especificos. (pala(127)/warrior(1))
+ 04/12/2014 [BattleCore2042] Core/Script: Solucionamos los problemas del boss ragnaros en evento magma blast.
+ 04/12/2014 [BattleCore2043] Core/Spell: Fix Druid T10 Resto 4pc.
+ 04/12/2014 [BattleCore2044] Core/Spell: Solucionamos exploit de Sacred Cleansing
+ 04/12/2014 [BattleCore2045] Core/Unit: Shaman Elemental T10 4pc
+ 04/12/2014 [BattleCore2046] Core/Script: añadimos script a Vanity Pet Focus
+ 04/12/2014 [BattleCore2047] Core/Pet: Solucionamos problemas con el focus de las pet, ahora ya no desaparecera mas, nos aseguramos que bajo cualquier circuntacia sea guardado.
+ 05/12/2014 [BattleCore2048] Core/event: Mejoras al evento del peregrino.
+ 05/12/2014 [BattleCore2049] Core/Event: Añadimos evento Perry Gatner.
+ 05/12/2014 [BattleCore2050] Core/Spell: Solucionamos problemas de spell AOE en LOS. reportado en: http://www.battle.cl/foros/index.php?/topic/9552-bug-shadowfury/
+ 09/12/2014 [BattleCore2051] Core/DB: Solucionamos problemas de stack en spell Tierra y Luna (druida), Pesteador de Ebano (dk) y Maldicion de los Elementos (brujo) reducidos a maximo 1
+ 16/12/2014 [BattleCore2052] Core/Event: Evento de navidad (calendario). (Winter Veil Christmas).
	+ Solucionamos [Crashin' & Thrashin'] Ahora  el coche sera visible y tendra las habilidades del vehiculo que corresponden y se podra realizar el ataque contra el otro coche para completar el logro correctamente.
	+ Solucionamos [Bros. Before Ho Ho Ho's] ahora se podra lanzar el item a las creaturas correspondientes.
	+ Solucionamos Quest Chain Into the Soulgrinder http://www.wowhead.com/quest=11000
	+ Solucion parcial evento BB king.
+ 16/12/2014 [BattleCore2053] Core/Spell: Solucionamos problemeas con Tótem Chaman [Grounding Totem] reportado en: http://www.battle.cl/foros/index.php?%2Ftopic%2F11888-t%C3%B3tem-chaman-grounding-totem%2F#entry85328
+ 18/12/2014 [BattleCore2054] Core/Spell: Solucionamos exploit paladin Avenging Wrath + Divine shield.
+ 22/12/2014 [BattleCore2055] Custom/Script: Corrección a loop en Houses.
+ 22/12/2014 [BattleCore2056] DB/Quest: Añadimos Spawn de Npc Shaman Jakjek y Lightningcaller Soo-met Reportado en: http://www.battle.cl/foros/index.php?/topic/12140-herramientas-de-guerra-rasganorte-cuenca-de-sholazar/
+ 22/12/2014 [BattleCore2057] Core/Spell: Solucionamos problema con Spell PX-238 Winter Wondervolt de evento Winter Veil
+ 24/12/2014 [BattleCore2058] Core/Spell: Removemos spell delay. hasta ajustarlo apropiadamente.
+ 24/12/2014 [BattleCore2059] Core/Quest: Solucionamos problema con quest Into the Soulgrinder http://www.wowhead.com/quest=11000
+ 24/12/2014 [BattleCore2060] Core/Quest: Solucionamos problemas de Quest Chain The Champion of Anguish Reportada en: http://www.battle.cl/foros/index.php?/topic/12009-the-champion-of-anguish/
+ 24/12/2014 [BattleCore2061] DB/Quest: Solucionamos problemas de Quest Zul'Drak: Hexed Caches - Enchanted Tiki Warriors Reportada en: http://www.battle.cl/foros/index.php?/topic/12334-zuldrak-hexed-caches-enchanted-tiki-warriors/
+ 24/12/2014 [BattleCore2062] DB/Quest: Solucionamos problemas de Quest Zul'Drak: Wooly Justice Reportada en: http://www.battle.cl/foros/index.php?/topic/12335-zuldrak-wooly-justice/
+ 24/12/2014 [BattleCore2063] Core/Custom: Solucion al problema de bonus de hermandad "Amount Honor (Rank 1)"
+ 24/12/2014 [BattleCore2064] DB/Quest: Solucionamos problemas de Quest Zul'Drak: Leave No One Behind Reportada en: http://www.battle.cl/foros/index.php?/topic/12333-zuldrak-leave-no-one-behind/
+ 24/12/2014 [BattleCore2065] DB/Quest: Solucionamos problemas con Quest Storm Peaks: Slaves of the Stormforged Reportada en:http://www.battle.cl/foros/index.php?/topic/12322-storm-peaks-slaves-of-the-stormforged/
+ 24/12/2014 [BattleCore2066] Core/Spell: Test Fix Deaht Rune.
+ 24/12/2014 [BattleCore2067] Core/Spell: Omen of Clarity, ahora solo se accionará la spell al causar daño o sanación. Reportada en: http://www.battle.cl/foros/index.php?/topic/6945-omen-of-clarity/
+ 24/12/2014 [BattleCore2068] DB/Quest:
	+ Fix Quest: The Witness and the Hero
	+ Fix Quest: Distortions in Time
	+ Fix Quest: Changing the Wind's Course
+ 25/12/2014 [BattleCore2069] Core/Quest: Solucionamos Quest Reconnaissance Flight Reportada en: http://www.battle.cl/foros/index.php?/topic/11943-reconnaissance-flight/
+ 25/12/2014 [BattleCore2070] Core/Quest: Solucionamos Quest Zul'Drak: The Storm King's Vengeance Reportada en: http://www.battle.cl/foros/index.php?/topic/12336-zuldrak-the-storm-kings-vengeance/
+ 25/12/2014 [BattleCore2071] Core/Quest: Solucionamos Quest Storm Peaks: Forging the Keystone Reportada en:http://www.battle.cl/foros/index.php?/topic/12321-storm-peaks-forging-the-keystone/
+ 26/12/2014 [BattleCore2072] Core/Spell: Test Fix Death Rune 2
+ 27/12/2014 [BattleCore2073] DB/Quest: Ajustes a Quest Zul'Drak: Wooly Justice Reportada en: http://www.battle.cl/foros/index.php?/topic/12335-zuldrak-wooly-justice/
+ 27/12/2014 [BattleCore2074] DB/Quest: Solucionamos problema de Quest Icecrown: Slave To Saronite (Daily) Reportada en: http://www.battle.cl/foros/index.php?/topic/12409-icecrown-slave-to-saronite-daily/
+ 27/12/2014 [BattleCore2075] DB/Quest: Solucionamos problema de Quest Icecrown: The Broken Front Reportada en: http://www.battle.cl/foros/index.php?/topic/12408-icecrown-the-broken-front/
+ 27/12/2014 [BattleCore2076] DB/Quest: Solucionamos problema de Quest Grizzly Hills: Loken's Orders Reportada en: http://www.battle.cl/foros/index.php?/topic/12386-grizzly-hills-lokens-orders/
+ 27/12/2014 [BattleCore2077] DB/Quest: Solucionamos problema de Quest Grizzly Hills: Anatoly Will Talk Reportada en: http://www.battle.cl/foros/index.php?/topic/12385-grizzly-hills-anatoly-will-talk/
+ 27/12/2014 [BattleCore2078] DB/Quest: Solucionamos problema de Quest Grizzly Hills: See You on the Other Side Reportada en: http://www.battle.cl/foros/index.php?/topic/12384-grizzly-hills-see-you-on-the-other-side/
+ 27/12/2014 [BattleCore2079] DB/Quest: Solucionamos problema de Quest Howling Fjord: Alpha Worg Reportada en: http://www.battle.cl/foros/index.php?/topic/12375-howling-fjord-alpha-worg/
+ 27/12/2014 [BattleCore2080] DB/Quest: Solucionamos problema de Quest Howling Fjord: Burn Skorn, Burn! Reportada en: http://www.battle.cl/foros/index.php?/topic/12373-howling-fjord-burn-skorn-burn/
+ 27/12/2014 [BattleCore2081] DB/Quest: Solucionamos problema de Howling Fjord: The Rune of Command Reportada en: http://www.battle.cl/foros/index.php?/topic/12371-howling-fjord-the-rune-of-command/
+ 27/12/2014 [BattleCore2082] DB/Quest: Solucionamos problema de Howling Fjord: Draconis Gastritis Reportada en: http://www.battle.cl/foros/index.php?/topic/12368-howling-fjord-draconis-gastritis/
+ 27/12/2014 [BattleCore2083] DB/Quest: Solucionamos problema de Dragonblight: Return to Earth Reportada en: http://www.battle.cl/foros/index.php?/topic/12366-dragonblight-return-to-earth/
+ 27/12/2014 [BattleCore2084] DB/Quest: Solucionamos problema de Dragonblight: A Fall From Grace Reportada en: http://www.battle.cl/foros/index.php?/topic/12361-dragonblight-a-fall-from-grace/
+ 27/12/2014 [BattleCore2085] Core/Quest: Solucionamos los creditos de las quest en instancias ahora el rango para obtener el credito de estas sera blizlike.
+ 27/12/2014 [BattleCore2086] Core/Mechanic: Solucion Evade en mobs.
+ 28/12/2014 [BattleCore2087] Core/Script: Solucionamos Creadito de Quest Trial of the Naaru: Mercy en mazmorra Shatarred Halls (Heroico).
+ 28/12/2014 [BattleCore2088] Core/Spell: Añadimos seguridad shadow word death, evitando exploit.
+ 03/01/2015 [BattleCore2089] Core/Chat: Portamos Sistema Chat TC mas mejoras team BattleCore
+ 03/01/2015 [BattleCore2090] Core/Chat: Fix Crash cuando el npc corre pidiendo ayuda (relatado en nuevos sistema de chat).
+ 03/01/2015 [BattleCore2091] Core/Chat: Fix mensaje de los gms en los canales (relatado en nuevos sistema de chat).
+ 03/01/2015 [BattleCore2092] Core/Script: Añadimos check a los textos de muerte de objetivos en los script, ahora solo saldran cuando el objetivo sea un player.
+ 05/01/2015 [BattleCore2093] Core/Quest: Solucionamos problemas de quest Daily y repetibles al ser completadas por primera vez el signo de "?" seguia presente despues.
+ 11/01/2015 [BattleCore2094] Core/Spell:
	+ Solucionamos problemas de vanish en general. ahora sacara del combate como corresponde y tendras sus limitaciones adecuadas.
	+ Mejora a Spell::EffectPullTowards
+ 11/01/2015 [BattleCore2095] Core/chat: Implementamos nuevos sistema de textos para todos los npc's del mundo.
+ 12/01/2015 [BattleCore2096] Core/Spell: Savage Roar (Druid), ahora no rompera stheal y no genera threat
+ 16/01/2015 [BattleCore2097] Core/Spell: Añadimos Sistema mejorado de Spell delay removido en BattleCore2058 (d260aa0711087264ce80b4ecb579b2fcb19001d1).
+ 21/01/2015 [BattleCore2099] Core/Spell: Implementamos Periodic mechanics mas informacion en: http://forums.elitistjerks.com/topic/82503-frost-dps-in-333this-will-be-a-day-long-remembered/page-88
+ 21/01/2015 [BattleCore2100] Core/Spell:
	+ Caparazón antimagia (Anti-Magic shell) dara inmunidad a todos los hechizos que pertenecen a SPELL_SCHOOL_MASK_MAGIC independientemente del tipo de disipación
	+ Correcto Fix de exploit Disarm vs Bladestorm
	+ Fix Cheat Death formula
	+ Movemos y solucionamos stack de pestilence a spellscripts
	+ Implementamos  SPELL_ATTR7_CAN_RESTORE_SECONDARY_POWER (hechizos sin este atributo ya no se podran energizar con energía secundaria. Druidas en forma de gato ya no serán capaces de reponer mana de toda clase de hechizo)
	+ Capa de las Sombras (Cloak of Shadows) no debe eliminar desventajas físicas
	+ Convertimos "Shaman T10 Elemental 2P Bonus" en spell script
	+ Solucionamos atributo SPELL_ATTR0_UNAFFECTED_BY_INVULNERABILITY  que se comprueba en algunos lugares donde no se llama a IsImmunedToSpell
	+ "Black Magic" ya no se puede eliminar después de muerto
	+ Mejoramos LOS de Death and Decay
	+ Solucionamos doble daño de Hammer of the Righteous
	+ Añadimos funcion que modifica el cooldown de spells
+ 03/02/2015 [BattleCore2101] Core/Spell: Añadimos Distancia entre los Totems (Blizlike).
+ 03/02/2015 [BattleCore2102] DB/Spell: Solucionamos problemas de Stack de Enrage.
+ 03/02/2015 [BattleCore2104] Core/DF: Correciones a Dungeon Finder.
+ 11/02/2015 [BattleCore2105] Auth: Correcciones y mejoras de seguridad
+ 12/02/2015 [BattleCore2106] Core/Transport:
	+ Actualizamos el sistema de transportes, ahora los npcs si se quedara arriba de los transportes y al dialogar con ellos seguiran la ruta de este.
	+ Solucionamos problema transporte campo de batalla IoC (Isle Of conquest)
	+ Actualizacion script batalla naval ICC (Gunship), a las nuevas condiciones de transportes.
		+ Correcion de bugs reportados en foro y exploit.
+ 19/02/2015 [BattleCore2107] Core/Handlers: Se ha corregido el requisito de firmas, para Guilds y Arenas (2vs2 y 3vs3).
+ 19/02/2015 [BattleCore2108] Core/GuildLeveling: Nuevos bonus de descuento para transmogrificaciones.
+ 19/02/2015 [BattleCore2109] DB: Toxic Wasteling, ya no matara a los npcs Warden ni Redeem.
+ 23/02/2015 [BattleCore2111] Core/Spell: Correcion de atributo a Spell Lock Players and Tap Chest usada en Gunship.
+ 23/02/2015 [BattleCore2112] Core/Spell: Removemos hack de spell Rocket Pack
+ 23/02/2015 [BattleCore2113] DB/SAI: Añadimos Script a mobs de Gunship Battle.
+ 24/02/2015 [BattleCore2114] Db/Gunship: Limpieza Script obsoletos de Gunship.
+ 25/02/2015 [BattleCore2115] Core/Custom:
	+ Mejoramos el metodo de despawn para el cristal de arena.
	+ Añadimos sugerencia de anuncio al entrar a una arena de como funciona el cristal de arena. https://www.battle.cl/foros/index.php?/topic/12893-info-diamantes-de-arena/
+ 25/02/2015 [BattleCore2116] Core/Transport: Solucion final al crash en los transportes.
+ 25/02/2015 [BattleCore2117] DB: Solucion a vida de los cañones en gunship.
+ 25/02/2015 [BattleCore2118] DB/Spell: Corrección de cooldown para proc de Sacred Shield.
+ 26/02/2015 [BattleCore2119] Core/Spell: Solucionamos problemas en la spell de los cañones de <Gunship Battle> ahora si llegaran al destinatario y realizaran el daño correcto.
+ 26/02/2015 [BattleCore2120] Core/Spell: Añadimos atributos de que no se pueda resistir ni missear Necrotic Plague en todas sus modalidades.
+ 26/02/2015 [BattleCore2121] Core/Spell: Solucionamos problemas con  logro The Rocket's Pink Glare <Love is in the air>
+ 26/02/2015 [BattleCore2122] Core/Quest: Solucionamos Quest The Drakkensryd Reportada en: https://www.battle.cl/foros/index.php?/topic/9459-storm-peaks-the-drakkensryd/
+ 26/02/2015 [BattleCore2123] DB: Solucionamos problema de npc Kaye Toogie este no tenia el listado de mercancia que vendia Reportado en: https://www.battle.cl/foros/index.php?/topic/13062-kaye-toogie-la-floja/
+ 28/02/2015 [BattleCore2124] Core/Quest: Solucionamos Quest Krolmir, Hammer of Storms Reportada en https://www.battle.cl/foros/index.php?/topic/12871-the-storm-peaks-krolmir-hammer-of-storms/
+ 01/03/2015 [BattleCore2125] DB/Quest: Solucionamos quest Becoming a Shadoweave Tailor Reportada en https://www.battle.cl/foros/index.php?/topic/12999-quest-becoming-a-shadoweave-tailor/
+ 01/03/2015 [BattleCore2126] DB/Quest: Solucionamos quest Terokkar Forest: An Improper Burial Reportada en: https://www.battle.cl/foros/index.php?/topic/12489-terokkar-forest-an-improper-burial/
+ 02/03/2015 [BattleCore2127] Core/Vehicle: Solucionamos exploit en los demolisher de SOTA ahora resistiran Sacred Shield. Reportado en https://www.battle.cl/foros/index.php?/topic/13002-bugs-de-los-tanques-especial-x2/#entry96475
+ 02/03/2015 [BattleCore2128] Core/Script: Ajustando tiempo de spell burning bith de gunship battle relatada en el evento rifleman
+ 03/03/2015 [BattleCore2129] DB: Solucionamos Quest Nagrand: Standards and practices Reportada en https://www.battle.cl/foros/index.php?/topic/12494-nagrand-standards-and-practices/ [ci skip]
+ 03/03/2015 [BattleCore2130] Core/Lfg:
	+ Separamos la busqueda de paquetes cuando el jugador esta en la pantalla de carga del mapa, esto hacia que el jugador estubiera offline.
	+ Implementamos Sistema de GearScore en dungeon finder, ahora te pedira un minimo de equipo cada mazmorra.
	+ Solucionamos crash en GetCompatibleDungeons
+ 04/03/2015 [BattleCore2131] Script/Gunship: Problema de agro, corregido.
+ 05/03/2015 [BattleCore2132] Script/Gunship: Solucionamos problemas de agro en los boss Bronzebeard / High Overlord Saurfang en Gunshop Battle. Reportado en: https://www.battle.cl/foros/index.php?/topic/13447-reporte-de-bug-gunship-battle/page-2
+ 06/03/2015 [BattleCore2133] Core/Spell: Solucionamos problemas de cloack of shadows y deterrance reportados en: https://www.battle.cl/foros/index.php?/topic/13475-bug-cloak-of-shadows/#entry97144 & https://www.battle.cl/foros/index.php?/topic/13407-disuaci%C3%B3n-deterrence/#entry97274
+ 06/03/2015 [BattleCore2134] Core/Spell: Solucionamos problema typo de identificador de efecto de summon spell de quest Icecrown: That's Abominable!, ahora si sumoneara al npc correctamente. https://www.battle.cl/foros/index.php?/topic/13467-icecrown-thats-abominable/
+ 06/03/2015 [BattleCore2135] Core/Spell: Update AI a npc Reanimated Abomination de quest Icecrown: That's Abominable! ahora si casteara la spell SPELL_BURST_AT_THE_SEAMS.
+ 07/03/2015 [BattleCore2136] DB: Fix Quest Dragonblight: Blighted Last Rites Reportada en: https://www.battle.cl/foros/index.php?/topic/13478-dragonblight-blighted-last-rites/
+ 07/03/2015 [BattleCore2137] DB: Fix Quest Dragonblight: A Means to an End Reportada en: https://www.battle.cl/foros/index.php?/topic/13480-dragonblight-a-means-to-an-end/
+ 07/03/2015 [BattleCore2138] DB: Fix Quest Dragonblight: Dragonblight: Mystery of the Infinite Reportada en: https://www.battle.cl/foros/index.php?/topic/13481-dragonblight-mystery-of-the-infinite/
+ 07/03/2015 [BattleCore2139] Core/BG: SOTA:  Solucionamos error typo en logro Defense of the Ancients Repotado en: https://www.battle.cl/foros/index.php?/topic/13489-logro-defense-of-the-ancients/#entry97192
+ 08/03/2015 [BattleCore2140] Core/BG: Isle Of Conquest:
	+ Solucionamos las catapultas
	+ Solucionamos problemas en los cementerios
	+ Solucionamos problemas de los cañones en el barco.
	+ Añadimos evento blizlike en el momento de teletransportate al barco
	+ Solucionamos problemas de translado desde el barco al Hangar
	+ Solucionomos los efectos de traslado (teleport) en general.
	+ Actualizamos script de Bombas de Seforio
	+ Modificamos la forma en el cual se activa el parachute (Paracaidas)
		+ Reportado en: https://www.battle.cl/foros/index.php?/topic/13441-bugs/
+ 09/03/2015 [BattleCore2141] Core/LFG: Solucionamos problemas que alguna veces el grupo no es creado y otras veces si. Reportado en: https://www.battle.cl/foros/index.php?/topic/12931-herramienta-buscador-de-mazmorras/?hl=finder#entry96580
+ 14/03/2015 [BattleCore2142] Core/Pet: Reescribimos completamente el sistema de pets, ahora estan tendran su daño,vida y sistema de nivel correspondiente Blizlike. (Test).
+ 16/03/2015 [BattleCore2143] DB: Actualizamos Velocidad Valkyr - Lich King (Icecrown Citadel) Reportado en https://www.battle.cl/foros/index.php?/topic/12526-velocidad-valkyr-lich-king-icecrown-citadel-video/page-2#entry97916
+ 16/03/2015 [BattleCore2144] Core/Pet: Solucionamos problemas de vida en la pet al ser llamadas y cuando bajas de montura. reportada en:https://www.battle.cl/foros/index.php?/topic/13617-sistema-de-pets-en-general/#entry98178
+ 16/03/2015 [BattleCore2145] Core/Pet: Solucionamos problemas de tamaño de pets, Reportado en: https://www.battle.cl/foros/index.php?/topic/13624-pet-bm/#entry98104
+ 17/03/2015 [BattleCore2146] Core/Script: Solucionamos exploit con problemas en la puerta de sindragosa
+ 17/03/2015 [BattleCore2147] Core/Script: Añadimos por default hacer el evento gaunglet de sindragosa y mejora exploit puertas sindragosa.
+ 18/03/2015 [BattleCore2148] Core/House: Sistema de fases para Houses.
+ 19/03/2015 [BattleCore2149] Core/Game: Separamos  FindPlayerByName a FindConnectedPlayerByName, ahora si no perderas la conexion en los teleport, el player se mantendra online en todo momento, sin verse afectado con perdida de datos.
+ 20/03/2015 [BattleCore2150] Core/Pet: Solucionamos finalmente todos los posibles casos en donde la pet debe aparecer correctamente con toda su vida.
+ 21/03/2015 [BattleCore2151] DB: Fix Quest Icecrown: Sneak Preview Reportada en: https://www.battle.cl/foros/index.php?/topic/13536-icecrown-sneak-preview/
+ 21/03/2015 [BattleCore2152] DB: Fix Quest Icecrown: Basic Chemistry Reportada en: https://www.battle.cl/foros/index.php?/topic/13468-icecrown-basic-chemistry/
+ 21/03/2015 [BattleCore2153] DB: Fix Quest Howling Fjord: The Fallen Sisters Reportada en: https://www.battle.cl/foros/index.php?/topic/13488-howling-fjord-the-fallen-sisters/
+ 21/03/2015 [BattleCore2154] Script/Custom: Se ha ampliado el sistema de spawns de gobject parcialmente loteados a herbalismo y veins faltantes.
+ 23/03/2015 [BattleCore2155] Core/Custom: Añadimos Historial de quest para los players.
+ 23/03/2015 [BattleCore2156] Core/Script: Solucionamos problema de inicio de evento gaunglet sindragosa ahora iniciara correctamente.
+ 23/03/2015 [BattleCore2157] Core/Script: Actualizamos el evento Gaunglet de Sindragosa.
	- Nuevos metodos de manejo de las puertas. ahora cumple los standares de TC asi evitamos cualquier exploit de esto.
	- Nuevo SAI a trash del gaunglet.
	- Añadimos texto intro de gaunglet.
+ 23/03/2015 [BattleCore2158] Core/Script: Solucionamos problemas menores en el metodo en el cual se obtiene el estado del evento de gaunglet sindragosa, Implementamos inconspicuous lever palanca para desactivar las trampas de putricide.
+ 24/03/2015 [BattleCore2159] Core/Script: Implementamos pre evento gauntlet trap de putricide en ICC.
+ 24/03/2015 [BattleCore2160] Core/Script: No se puede llamar a Blood Queen cuando el evento de Princes este en progreso.
+ 30/03/2015 [BattleCore2161] Core/Script: ICC:
	+ Implementamos pre evento lord marrowgar, ahora estaran las trampas activas antes de este evento. las cuales reviviran a los esqueletos gigantes de las paredes.
	+ Implementamos pre evento gunship "The Rampart of Skulls".
	+ Implementamos post evento deathbringer saurfang
	+ Implementamos evento Valkyr Herald
		+ Jefe Festergurt:
			+ Solucionamos problemas con spell blighted spores el problema era el debuff de reduccion de daño. Este debuff se esta aplicando cuando explota la espora. ahora el debuff de reduccion de daño se aplicara cuando el debuff de daño expira. y solo se aplicara una carga.
			+ Removemos Gastric Bloat en los players cuando derrotan al jefe.
		+ Jefe Rotface:
			+ Solucionamos problemas con la spell slime spray, ahora al dalverse vuelta para realiazar el vomito le llegara a la raid correctamente y no solo al tanque.
			+ Se añade para en caso de wipes o cuando el jefe es derrotado, desaparecer los Ooze y las spells que le queden a los players del evento del jefe.
			+ Se añaden inmunidades correspondientes a las ooze y se ajusta su velocidad.
			+ se soluciona que cuando tengas 5 o mas cargas estas explotaran
	+ Mejoramos el evento Pre profesor putricide (gauntlet trap) ahora en casos de wipes se reiniciara correctamente.
		+ Jefe Professor Putricide:
			+ Añadimos inmunidades a los ooze y correcta velocidad de esta.
			 + Se añade para en caso de wipes o cuando el jefe es derrotado, desaparecer los Ooze y las spells que le queden a los players del evento del jefe.
	+ Mejoramos Visualmente el evento pre sindragosa (gauntlet sindragosa), ahora las arañas caeran con la telaraña correspondiente y actualizamos timers, oleades blizlike.
	+ Solucionamos exploit de puertas de jefe Sindragosa.
	+ Solucionamos problemas con evento Svalna ahora se iniciara correctamente siempre.
		+ Jefe valithria dreamwalker, ahora en caso de wipes se reiniciara correctamente.
	+ Jefe LK:
		+ Solucionamos exploit de los pilares de lk.
		+ Mejoramos la forma en que entras en la frostmourne en heroico ahora las bombas caeran como corresponde y los fantasmas.
		+ Mejoramos mecanica en desfile y valkys.
	+ Corregimos todos los problemas de inmunidades generales de esta dungeon.
+ 30/03/2015 [BattleCore2162] Core/Pet: Solucionamos problemas de target en pet ebon gargoyle [DK]
+ 30/03/2015 [BattleCore2163] Core/Commands: Solucionamos problema en comando GroupJoinCommand (Gms).
+ 31/03/2015 [BattleCore2164] Core/Spell: Solucionamos daño erroneo de spell explode (DK).
+ 31/03/2015 [BattleCore2165] Core/Pet: Solucionamos problemas de vida y daño en las pet de los cazadorez (Hunter).
+ 31/03/2015 [BattleCore2166] Core/Pet: Solucionamos problemas con daño pet Death Knight - Gargoyle Strike
+ 31/03/2015 [BattleCore2167] Core/Script: Implementamos primer release chess event kharazhan, Reportes de errores de este evento continuarlos aca: https://www.battle.cl/foros/index.php?/topic/13706-karazhan/#entry99163
+ 31/03/2015 [BattleCore2168] Core/Spell: Ajustamos la distancia entre los totems para reducir bugs de AOE-> Collision de estos.
+ 01/04/2015 [BattleCore2169] Core/Custom: Volvemos a añadir teleport a icc a las Guild House.
+ 01/04/2015 [BattleCore2170] Core/Script: Icecrown Citadel:
	+ Solucionamos exploit con las valvulas de fesgurt y rotface ahora sera necesario matarlos para accionarlas.
	+ Solucionamos problemas con el evento de Svalna ahora se iniciara siempre.
	+ Solucionamos exploit con el evento del mago en gunship battle.
+ 01/04/2015 [BattleCore2171] DB: Solucionamos problema de inmunidad en ciclone con ciclone y Faerie Fire en  Cyclone Reportado en: https://www.battle.cl/foros/index.php?/topic/13452-inmunidad-de-cyclone-en-cyclone/
+ 06/04/2015 [BattleCore2178] Core/Spell: Realizamos que Shadow Trap, Necrotic plague y Harvest soul en el desafio con el jefe Lich King jamas puedan ser resistidas.
+ 07/04/2015 [BattleCore2179] DB: Solucionamos el inicio del evento Noblegarden reportado en: https://www.battle.cl/foros/index.php?/topic/13942-evento-noblegarden/#entry100257
+ 07/04/2015 [BattleCore2180] Core/Spells: Solucionamos problemas de agro cuando usas la spell Invisibilidad en la clase mago. Reportado en: https://www.battle.cl/foros/index.php?/topic/13823-invisibilidad/
+ 08/04/2015 [BattleCore2181] Core/Battleground: Reactivamos /say, /yell en Battlegrounds
+ 09/04/2015 [BattleCore2182] Core/Script: Removemos duplica del teletransportador en ICC y añadimos que solo el lider de la banda pueda inicar el evento de deathbringer.
+ 09/04/2015 [BattleCore2183] DB/Quest: Solucionamos Quest Runes of Compulsion Reportada en: https://www.battle.cl/foros/index.php?/topic/13707-zuldrak-colinas-pardas-y-cumbres-tormentosas/
+ 13/04/2015 [BattleCore2184] DB/Quest: Solucionamos Quest Quest - Valduran the Stormborn
+ 13/04/2015 [BattleCore2185] DB/Quest: Solucionamos Quest Icecrown: Drag and Drop https://www.battle.cl/foros/index.php?/topic/13879-icecrown-drag-and-drop/
+ 13/04/2015 [BattleCore2186] DB/Quest: Solucionamos Quest The Forgotten Tale (12291) & The Truth Shall Set Us Free (12301), & Frostmourne Cavern. Reportada en https://www.battle.cl/foros/index.php?/topic/13736-bug-quest-la-verdad-nos-har%C3%A1-libres/
+ 16/04/2015 [BattleCore2187] DB/Quest: Solucionamos Quest Betrayal
+ 16/04/2015 [BattleCore2188] Core/Quest: Solucionamos Quest Or Maybe We Don't reportada en: https://www.battle.cl/foros/index.php?/topic/14007-colinas-pardas-o-quiz%C3%A1s-no/
+ 16/04/2015 [BattleCore2189] DB/Quest: Solucionamos Quest Storm Peaks: The Earthen Oath reportada en: https://www.battle.cl/foros/index.php?/topic/13498-storm-peaks-the-earthen-oath/
+ 16/04/2015 [BattleCore2190] DB/Quest: Solucionamos Quest Dragonblight: Fresh Remounts Reportada en: https://www.battle.cl/foros/index.php?/topic/13479-dragonblight-fresh-remounts/
+ 16/04/2015 [BattleCore2191] DB/Quest: Solucionamos problemas con quest Howling Fjord: Field Test reportada en: https://www.battle.cl/foros/index.php?/topic/13486-howling-fjord-field-test/
+ 16/04/2015 [BattleCore2192] DB/Quest: Solucionamos Quest Howling Fjord: The Frost Wyrm and Its Master reportada en:https://www.battle.cl/foros/index.php?/topic/13487-howling-fjord-the-frost-wyrm-and-its-master/
+ 16/04/2015 [BattleCore2193] DB/Quest:  Solucionamos Borean Tundra: Kaganishu Reportada en: https://www.battle.cl/foros/index.php?/topic/13485-borean-tundra-kaganishu/
+ 17/04/2015 [BattleCore2194] Core/Handler: Ahora es posible enviar correos entre personajes de la misma cuenta de juego.
+ 19/04/2015 [BattleCore2195] Core/Movement: Afinamos la distancia de movimiento en fear ahora sera mas similar al del servidor oficial. corregimos bug visual que algunas veces el player se ve en fear en un lado pero esta en otro.
+ 19/04/2015 [BattleCore2196] Core/Pet: Ahora las pet del tipo guardianes (gargola, elementa de algua, y pets temporales) se beneficiaran del spell penetration del dueño.
+ 19/04/2015 [BattleCore2197] Core/Spell: Solucionamos que ahora Berserking / Rabiar se puede stackear correctamente. Reportado en: https://www.battle.cl/foros/index.php?%2Ftopic%2F12211-error-enchant-berserking-rabiar%2F
+ 19/04/2015 [BattleCore2198] Core/Spell: Hand of Freedom ahora se podra usar en CC, Stuns atp.
+ 19/04/2015 [BattleCore2199] Core/Spell: Ahora el Caballero de la Muerte (Death Knight's) con su pet la Gargola (Gargoyle) debe heredar el 50% del poder de ataque mas las  auras que modifiquen el poder de ataque Reportado en: https://www.battle.cl/foros/index.php?/topic/13655-da%C3%B1o-de-gargola-erroneo/
+ 19/04/2015 [BattleCore2200] Core/Script: Solucionamos problema que no se activaba Malleable Goo en profesor putricide
+ 22/04/2015 [BattleCore2201] Core/Spell: Actualizamos formula de AP de la Gargoyle  en  commit BattleCore2199
+ 29/04/2015 [BattleCore2202] Core/House: Correcciones a perdidas de fases en sistema de fases para Houses.
+ 30/04/2015 [BattleCore2203] Core/Spell: Se ha corregido error que permitía utilizar monturas voladoras en zonas que no corresponde.
+ 03/05/2015 [BattleCore2204] Core/Custom: Implementamos Sistema Soloqueue 3vs3 % 1vs1, en el cual podras apuntar a arenas individualmente el cual buscara compañeros para ir a la batalla y ganar puntos en la modalidad 5vs5"
+ 03/05/2015 [BattleCore2205] Core/Spell: Actualizamos formula de AP de la Gargoyle  en  commit BattleCore2201
+ 05/05/2015 [BattleCore2206] Core/House: Crash fix.
+ 05/05/2015 [BattleCore2207] Core/Spell: Corregimos inconveniente que afectaba vuelo sobre Dalaran.
+ 06/05/2015 [BattleCore2208] Core/Spell: Solucionamos problema de que envenom podia ser dispeleado con el totem cleasing. Reportado en: https://www.battle.cl/foros/index.php?/topic/14172-envenom-y-cleansing-totem/
+ 06/05/2015 [BattleCore2209] Core/Spell: Solucionamos problemas que algunas veces Cold Snap no reinicia los poderes. Reportado en:https://www.battle.cl/foros/index.php?/topic/13993-bug-cold-snap/
+ 06/05/2015 [BattleCore2210] Core/Spell: Solucionamos problemas con la spell deep freeze ahora si esta spell tiene el efecto inmune entrara el segundo efecto. reportado en: https://www.battle.cl/foros/index.php?/topic/14198-bug-congelaci%C3%B3n-profunda/
+ 06/05/2015 [BattleCore2211] Core/Spell: Removemos hack fix de BattleCore2208 y añadimos fix generico.
+ 12/05/2015 [BattleCore2212] Core/Custom: Solucionamos problemas de grupos mixtos. ahora se podra interactuar de forma correcta en el Soloqueue y se activa los grupos mixtos en el LFG.
+ 13/05/2015 [BattleCore2213] Core/Build: Solucionamos problemas de OpenSSL en plataformas 64 bit en OS Windows
+ 14/05/2015 [BattleCore2214] Core/Anticheat: Implementamos nuevo sistema Anticheat basado en el movimiento.
+ 14/05/2015 [BattleCore2215] Core/Custom: Soloqueue Añadimos que puedas anotar solo o en duo.
+ 14/05/2015 [BattleCore2216] Core/Spell: Solucionamos problemas de aggro en talento bloodworms DK, Reportad en https://www.battle.cl/foros/index.php?/topic/14051-talento-bloodworms/
+ 16/05/2015 [BattleCore2217] Core/Custom: Removemos soporte de los arena crytal en arena (iniciadores de arena mas rapido) ahora son cambiados por un ready check que sera lanzado en la arena.
+ 16/05/2015 [BattleCore2218] Core/Spell Solucionamos problemas con el Bonus Damage pct
+ 16/05/2015 [BattleCore2219] Core/Entities Prevenimos algunos crash
+ 21/05/2015 [BattleCore2220] Core/Custom: Soloqueue:
	+ Solucionamos problemas de rating.
	+ Solucionamos problemas en el chat cuando estas en un grupo mixto.
+ 21/05/2015 [BattleCore2221] Core/Custom: Solucionamos que en los grupos mixtos (LFG y Soloqueue) se pueda utilizar Heroims / Bloodlust  al mismo tiempo.
+ 22/05/2015 [BattleCore2222] Core/Spell: Solucionamos problemas con la Spell Reflect, Reportada en: https://www.battle.cl/foros/index.php?/topic/14340-spell-reflect/#entry103966
+ 23/05/2015 [BattleCore2223] Core/Spell: Solucionamos problemas de la spell Mind Control en grupos mixtos. (soloqueue y lfg)
+ 23/05/2015 [BattleCore2224] Core/Spell: Solucion dos a exploit Mind control en grupos mixtos, apaña al commit [BattleCore2223]
+ 23/05/2015 [BattleCore2225] DB: Removemos totalmente los cristales de arena.
+ 24/05/2015 [BattleCore2226] Core/Spell: Solucionamos exploit de Spirit of redemption
+ 26/05/2015 [BattleCore2227] Core/Pet: Implementamos que todas las pets con barra de accion tales como elemental de agua (mago) y la gárgola (dk) para que mediante el action bar ellos eligan a quien atacar y no ataque solo.
+ 27/05/2015 [BattleCore2228] Core/Pet: Removemos debuffs,cd's externos de la clase y seteamos vida/mana a full al entrar a un campo de batalla, Reportado en: https://www.battle.cl/foros/index.php?/topic/14516-pets-de-hunters-en-general/
+ 28/05/2015 [BattleCore2229] DB/Quest: Solucionamos Quest Howling Fjord: The Slumbering King, Reportada en:https://www.battle.cl/foros/index.php?/topic/14237-howling-fjord-the-slumbering-king/
+ 28/05/2015 [BattleCore2230] DB/Quest: Solucionamos Quest Storm Peaks:The Reckoning, Reportada en: https://www.battle.cl/foros/index.php?/topic/14120-storm-peaksthe-reckoning/
+ 28/05/2015 [BattleCore2231] DB/Quest: Solucionamos Quest Colinas Pardas: Poder latente, Reportada en: https://www.battle.cl/foros/index.php?/topic/14104-colinas-pardas-poder-latente/
+ 28/05/2015 [BattleCore2232] DB/Quest: Solucionamos Quest Howling Fjord: The Fallen Sisters, Reportada en: https://www.battle.cl/foros/index.php?/topic/13488-howling-fjord-the-fallen-sisters/
+ 28/05/2015 [BattleCore2233] DB/Quest: Solucionamos Quest Icecrown: Battle at Valhalas: The Return of Sigrid Iceborn, Reportada en: https://www.battle.cl/foros/index.php?/topic/13508-icecrown-battle-at-valhalas-the-return-of-sigrid-iceborn/
+ 29/05/2015 [BattleCore2234] Core/Spell: Solucionamos los problemas con la seleccion de las DeathRunes, ahora marcara realmente la que es.
+ 29/05/2015 [BattleCore2235] Core/Pet: Añadimos que al entrar a arena o bg te saque de la montura siempre y haga un dissmiss en las pets para evitar exploit. reportado en: https://www.battle.cl/foros/index.php?/topic/14516-pets-de-hunters-en-general/
+ 29/05/2015 [BattleCore2236] Core/Pet: Limpiamos los bufss y debuffs al entrar a arena.
+ 30/05/2015 [BattleCore2237] Core/Script: Solucionamos problemas con logro Mine Sweeper
+ 30/05/2015 [BattleCore2238] Core/Script: Solucionamos Quest Howling Fjord: Warning: Some Assembly Required, Reportada en:https://www.battle.cl/foros/index.php?/topic/14121-howling-fjord-warning-some-assembly-required/
+ 30/05/2015 [BattleCore2239] Core/Custom: Fix typo de rating en Soloqueue
+ 31/05/2015 [BattleCore2240] Core/Script: Sindragosa: Solucionamos el AOE en las Ice Tomb Reportado en: https://www.battle.cl/foros/index.php?/topic/12777-ice-tomb-sindragosa-icecrown-citadel-tumba-de-hielo/
+ 03/06/2015 [BattleCore2241] Core/Spell: Mage: Burning Determination no proceara con Self Blood Elf Racial
+ 03/06/2015 [BattleCore2242] Core/Script: ICC/Deathbringer Saurfang: ahora al morir un jugador con Mark of the Fallen Champion el boss se curara.
+ 04/06/2015 [BattleCore2243] Core/Custom: Soloqueue: Normalizamos el sistema de rating , ahora podra ser modificado via config del servidor.
+ 04/06/2015 [BattleCore2244] Core/Script: ICC/Lord Marrowgar: movemos inmunnidades a una funcion, actualizamos el evento de bone storm ahora se diferenciara entre Normal y Heroico.
+ 05/06/2015 [BattleCore2245] Core/Spell: Solucionamos problemas en creaturas que se quedaban con "1" de vida cuando tenian un aura de sanacion.
+ 05/06/2015 [BattleCore2246] Core/Spell: Warlock: Solucionamos problemas con spells Curse of the Elements - Improved Corruption - Improved Curse of Agony - Shadow Mastery Reportado en: https://www.battle.cl/foros/index.php?/topic/7362-hauntcurse-of-elementsshadow-embrace-no-funcionan-en-dots/page-5
+ 05/06/2015 [BattleCore2247] Core/Spell: Solucionamos problemas de stack Ebon Plaguebringer [DK]
+ 07/06/2015 [BattleCore2248] Core/Script: Halls Of Reflection: Solucionamos problemas y reescribimos el guion de la mazmorra reportado en :https://www.battle.cl/foros/index.php?/topic/14266-bug-en-camara-de-reflection/
+ 07/06/2015 [BattleCore2249] DB: Halls Of Reflection: Solucionamos problema de npc amistoso Raging Ghoul Reportad en: https://www.battle.cl/foros/index.php?/topic/14654-halls-of-reflection-heroica-trash-del-%C3%BAltimo-evento/#entry105809
+ 08/06/2015 [BattleCore2250] Core/Scrip: Solucionamos problemas en LK por cambios realizados en HOR.
+ 14/06/2015 [BattleCore2251] Core/Spell: Solucionamos Spell Omen of Clarity Reportada en:https://www.battle.cl/foros/index.php?/topic/6945-omen-of-clarity/page-2
+ 16/06/2015 [BattleCore2252] Core/Script: ICC: Lady Deathwhisper
	+ Fix - Full House
	+ Solucionamos problemas de movmiento despues de  Mind Control
	+ Solucionaomos Probelmas de Agrro en Fase 2
	+ Actualizamos velocidad de  Vengeful Shade
+ 16/06/2015 [BattleCore2253] DB: Halls Of Reflection: Solucionamos problema de npc amistoso Risen Witch Doctor & Lumbering Abomination, Reportado en: https://www.battle.cl/foros/index.php?/topic/14654-halls-of-reflection-heroica-trash-del-%C3%BAltimo-evento/
+ 17/06/2015 [BattleCore2254] Core/Script: Culling Of Stratholme: Solucionamos problemas reportados en https://www.battle.cl/foros/index.php?/topic/12659-culling-of-stratholme/
+ 22/06/2015 [BattleCore2255] DB: Solucionamos problemas de evento midsummer reportado en https://www.battle.cl/foros/index.php?/topic/14908-2-misi%C3%B3n-malas/#entry107044 & https://www.battle.cl/foros/index.php?/topic/14687-evento-midsummer-fire-festival/#entry107031
+ 26/06/2015 [BattleCore2256] Core/Script: ICC (Icecrown Citadel):
	+ Ahora el Malleable Goo en Profesor Putricide sera casteado correctamente a la raid.
	+ Los vile gas funcionaran correctamente
	+ Se añade antiexploit en los ozze ahora estos removeran auras Forbidden.
	+ Se mejora la menora de encotrar al target de los ozze y los mutated.
	+ Se añade ScriptAI a plagued zombie en Rotface.
	+ Se mojora la posicion de los "strams" stalkers ahora no deberian aparecer pozas en el cielo de Rotface.
	+ Se añade despawn de toda creatura al terminar cualquiera de los encuentros de Festergut, Rotface, Professor Putricide
+ 27/06/2015 [BattleCore2257] Core/Script: Fix crash en npc_flash_freeze (Ulduar) Reportado en: https://www.battle.cl/foros/index.php?/topic/7303-ulduar/page-2#entry107333
+ 27/06/2015 [BattleCore2258] DB: Añadimos scriptname faltantes, (sacados del startup del servidor)
+ 30/06/2015 [BattleCore2259] DB: Solucionamos algunos bonfire defectuosos reportados en : https://www.battle.cl/foros/index.php?/topic/14687-evento-midsummer-fire-festival/page-2#entry107393
+ 30/06/2015 [BattleCore2260] DB: Scriptname faltantes en startup server.
+ 01/07/2015 [BattleCore2261] Core/Script: test fix crash v2.0 npc_flash_freeze (Ulduar) Reportado en: https://www.battle.cl/foros/index.php?/topic/7303-ulduar/page-2#entry107333
+ 03/07/2015 [BattleCore2262] Core/Spell: Solucionamos problemas de Power Word: Shield (interacción con AOE's en invisibilidad) reportado en: https://www.battle.cl/foros/index.php?/topic/14991-bug-spell-power-word-shield-interacci%C3%B3n-con-aoes/#entry107433
+ 03/07/2015 [BattleCore2263] Core/Custom: Arena Spectator.
	+ Implementamos nuevo version del addon Arena Spectator.
	+ Modificamos el aspecto del npc arena spectator.
	+ Ahora sera posible ver los CD en las arenas.
	+ Las Auras/buff etc se reiniciaran de forma correcta
	+ Se añade una UI mas amigable
+ 18/07/2015 [BattleCore2264] DB/Quest: Solucionamos Quest The Yeti Next Door Reportada en: https://www.battle.cl/foros/index.php?/topic/14926-el-yeti-de-al-lado/
+ 18/07/2015 [BattleCore2265] DB/Quest: Fix Quest Icecrown: Destroying the Altars Reportada en: https://www.battle.cl/foros/index.php?/topic/14544-icecrown-destroying-the-altars/
+ 18/07/2015 [BattleCore2266] Core/Script: Solucionamos problemas de cofre en matanza de stralhome (CoS) Reportado en: https://www.battle.cl/foros/index.php?/topic/15235-matanza-de-stralhome/
+ 20/07/2015 [BattleCore2267] Core/Spell: Fix exploit  daño Deep Wounds
+ 20/07/2015 [BattleCore2268] Core/Spell: Solucionamos problemas de spells Conflagrate & Swiftmend & Chimera Shot
+ 22/07/2015 [BattleCore2269] Core/Movement: Corregimos el movimiento ahora sera mas bli$$like bajo los efectos de fear.
+ 23/07/2015 [BattleCore2270] Core/Spell: Solucionamos problemas de spell instantaneos en Arena. reportado en: https://www.battle.cl/foros/index.php?/topic/15290-bug-arte-de-la-guerra/#entry109746
+ 23/07/2015 [BattleCore2271] Core/Mysql: Solucionamos problemas de Cd's pegados en los reset de instancias
+ 26/07/2015 [BattleCore2272] Core/Custom: Solucionamos problemas con calculo de rating en sistema soloqueue.
+ 27/07/2015 [BattleCore2273] Core/Script: Solucionamos problemas con las quest de Alterac Valley las que involucran recoger objetos o lotear. Repotado en: https://www.battle.cl/foros/index.php?/topic/8035-serio-problema-con-las-quest/
+ 27/07/2015 [BattleCore2274] Core/BG: Isle Of Conquest: Solucionamos problemas con gunship captian ahora saldra correctamente el zepelin.
+ 27/07/2015 [BattleCore2275] Core/Custom: ArenaSpectator: Añadimos menu para ver las arenas en progreso con el sistema Soloqueue.
+ 27/07/2015 [BattleCore2276] DB:  Solucion para problemas de fases en Quest de la faccion Oracles, Reportada en: https://www.battle.cl/foros/index.php?/topic/12741-npc-de-reputacion-oraculos-y-corazon-frenetico/#entry108409
+ 29/07/2015 [BattleCore2277] Core/Custom: Añadimos metodo anti spam.
+ 03/08/2015 [BattleCore2278] Core/Object: Añadimos mejora a las Icetomb - Sindragosa
+ 04/08/2015 [BattleCore2279] Core/Script: Solucionamos problemas con Quest Among The Champions (Entre los campeones), Reportada en: https://www.battle.cl/foros/index.php?/topic/14098-diaria-del-torneo-argenta-entre-los-campeones-mala-denuevo/
+ 05/08/2015 [BattleCore2280] Core/Script: Solucionamos problema en tiempo de respawn de boss Anubarak en ToC
+ 06/08/2015 [BattleCore2281] DB/Quest: Solucionamos problemas de Quest Escape from Silverbrook Reportada en: https://www.battle.cl/foros/index.php?/topic/15518-misi%C3%B3n-bug-huye-de-arroyo-plata/
+ 11/08/2015 [BattleCore2282] Script/Transmo: Mejoras en transfigurador.
  + Nuevo menu, más interactivo.
  + Gestión de sets, ahora es posible almacenar las transfiguraciones.
  + Corrección de bug con oro.
+ 11/08/2015 [BattleCore2283] DB/Quest: Solucionamos Quest Las Llanuras de Nasam Reportada en:https://www.battle.cl/foros/index.php?/topic/15656-tundra-boreal-las-llanuras-de-nasam/
+ 11/08/2015 [BattleCore2284] Core/Spell: Sanctified Wrath Ahora rompera los efectos de absorción
+ 11/08/2015 [BattleCore2285] Core/Spell: Solucionamos exploit de stacks de dobles auras, Reportado en: https://www.battle.cl/foros/index.php?/topic/15574-desenfreno-buff-fury/
+ 13/08/2015 [BattleCore2286] DB/Quest: Solucionamos Quest A Mammoth Undertaking Reportada en: https://www.battle.cl/foros/index.php?/topic/15699-cuenca-de-sholazar-cazar-un-mamut/#entry111473
+ 18/08/2015 [BattleCore2287] Core/Script: Solucionamos problemas con Ice Tomb
+ 20/08/2015 [BattleCore2288] Core/Spell: Corregimos calculos de cap en Armor Penetration, Reportado en: https://www.battle.cl/foros/index.php?/topic/15792-bug-spell-penetrecion-resistence/#entry112070
+ 20/08/2015 [BattleCore2289] DB/Quest: Fix Quest Freedom for All Creatures Reportada en: https://www.battle.cl/foros/index.php?/topic/15666-quest-libertad-para-todas-las-criatura-feralas/
+ 20/08/2015 [BattleCore2290] DB/Quest: Fix Quest Razormaw Reportada en: https://www.battle.cl/foros/index.php?/topic/15445-bloodmyst-isle-razormaw/
+ 20/08/2015 [BattleCore2291] Core/Script: Solucionamos Quet Just Following Orders Reportada en: https://www.battle.cl/foros/index.php?/topic/15604-quest-siguiendo-%C3%B3rdenes-cuenca-de-sholazar/
+ 22/08/2015 [BattleCore2292] Core/Script: Arena Spectator:
	+ Solucionamos problemas de visualizacion de juegos en el menu
	+ Solucionamos opcion de ver a un jugador en especifico.
+ 22/08/2015 [BattleCore2293] DB/Quest: Fix Quest Sniffing Out the Perpetrator Reportada en: https://www.battle.cl/foros/index.php?/topic/15689-cumbres-tormentosas/
+ 22/08/2015 [BattleCore2294] DB/Quest: Fix Quest Grizzly Hills: Latent Power Reportada en: https://www.battle.cl/foros/index.php?/topic/14122-grizzly-hills-latent-power/
+ 22/08/2015 [BattleCore2295] DB/Quest: Fix Quest Howling Fjord: The Fallen Sisters Reportada en: https://www.battle.cl/foros/index.php?/topic/13488-howling-fjord-the-fallen-sisters/
+ 22/08/2015 [BattleCore2296] Core/Spell: Solucionamos problemas de bonus con Mixology ("La ciencia de la mezcla") Reportada en: https://www.battle.cl/foros/index.php?/topic/14784-bug-pasivo-de-alquimia-la-ciencia-de-la-mezcla/#entry112363
+ 24/08/2015 [BattleCore2297] Battlefield/Wintergrasp: Correcciones a workshops
+ 01/09/2015 [BattleCore2298] Core/Script: LK.
	+ Solucionamos problemas con evento defile.
	+ Solucionamos problemas en el frostmourne.
	+ Solucionamos problemas con los wicked spirit.
	+ Solucionamos estados de velocidad en las creaturas en la pelea.
+ 01/09/2015 [BattleCore2299] Core/Spell: Fix hunter's Auto Shot after LOS break
+ 01/09/2015 [BattleCore2298] Script/Sunwell: Variadas correcciones por @retriman
+ 02/09/2015 [BattleCore2299] Script/Spell: Solucionamos problemas de beacon of light, Reportada en: https://www.battle.cl/foros/index.php?/topic/15724-beacon-of-light/
+ 02/09/2015 [BattleCore2300] Core/SAI: Añadimos Metodo SMART_ACTION_SET_COUNTER. esto solucionara el problema de los portales en el evento de kalecgos en sunwell.
+ 02/09/2015 [BattleCore2301] DB: Solucionamos problemas en el reino espectral en pelea de kalecgos ahora te teletransportara a Sathrovarr correctamente.
+ 02/09/2015 [BattleCore2302] Core/LFG: Solucionamos problemas en metodo de busqueda de LFG, ahora al desconectarse o salirse de la lista esta se reiniciara correctamente y seguira buscando los roles faltantes.
+ 02/09/2015 [BattleCore2303] Core/DBC: Solucionamos problemas con bandera CanEnterOrExit en vehiculos, ahora los vehiculos que no puedan ser controlados funcionaran correctamente.
+ 22/09/2015 [BattleCore2304] Core/Player: Fix Crash GetUInt32Value::GetEnchantmentId
+ 22/09/2015 [BattleCore2305] Core/Maps: No utilizar EnsureGridCreated_i() de base mapa en Map::LoadMap, usar EnsureGridCreated() que es seguro para subprocesos.
+ 22/09/2015 [BattleCore2306] Core/Commands: Fix memory leak comando phase system.
+ 24/09/2015 [BattleCore2307] Core/Map: Solucionamos problemas de combate de creaturas a distancia.
+ 26/09/2015 [BattleCore2308] Core/Unit: Solucionamos problemas con Threat.
+ 29/09/2015 [BattleCore2309] Core/Unit: Solucionamos problemas de creaturas sumoneadas por el player que causan daño y no eran aplicables para creditos en quest.
+ 29/09/2015 [BattleCore2310] Core/Pet: Solucionamos problemas de spell cooldown en las pets.
+ 29/09/2015 [BattleCore2311] Core/Spell: Solucionamos problema generico que los efectos de taunt en un boss interrumpian los casteos.
+ 29/09/2015 [BattleCore2312] Core/Creature: Solucionamos exploit de poder revivir en combate mientras un encounter esta en progreso.
+ 29/09/2015 [BattleCore2313] Core/Spell: Shadowfiend y Mana Leech ya no seran afectados por LoS.
+ 29/09/2015 [BattleCore2314] Core/Dungeon: Solucionamos problemas en dugeon Scholomance, Reportada en: https://www.battle.cl/foros/index.php?/topic/14682-scholomance-sin-mobs/#entry114472
+ 29/09/2015 [BattleCore2315] Core/Dungeon: ICC: Añadimos a tyron spell mass resuction, Reportada en: https://www.battle.cl/foros/index.php?/topic/15929-lich-king/#entry114817
+ 08/10/2015 [BattleCore2316] Core/Skill: implementamos nueva feature "Gem Perfection"
+ 11/10/2015 [BattleCore2317] Script/Custom: Ligera corrección en transmo de armas.
+ 16/10/2015 [BattleCore2318] DB/Items: Migraciones faltantes de algunos sets, al cambiar de facción.
+ 25/10/2015 [BattleCore2319] DB/Quest: Fix Quest: Zul'Drak: Horizonte Oscuro, Reportada en: https://www.battle.cl/foros/index.php?/topic/14005-zuldrak-horizonte-oscuro/
+ 25/10/2015 [BattleCore2320] DB/Quest: Fix Quest: Icecrown: The Art of Being a Water Terror Reportada en:https://www.battle.cl/foros/index.php?/topic/14536-icecrown-the-art-of-being-a-water-terror/
+ 03/11/2015 [BattleCore2321] DB/Event: Day of the Dead : Solucionamos problemas visuales en auras de npcs.
+ 03/11/2015 [BattleCore2322] DB/Quest: Fix Quest Flight of the Wintergarde Defender, Reportada en: https://www.battle.cl/foros/index.php?/topic/16611-flight-of-the-wintergarde-defender/#entry116861
+ 03/11/2015 [BattleCore2323] DB/Item: Tabard de ilusion ahora sera transparente.
+ 04/11/2015 [BattleCore2324] Core/Script: SOlucionamos problemas de Quest Hallowen event Fire Brigade Practice - Fire Training - Let the fires come - Stop the Fires
+ 15/11/2015 [BattleCore2325] Core/Custom: Camisas de Ilusion Añadimos:
	- ITEM_ORC_FEMALE      
    -  ITEM_ORC_MALE        
    -  ITEM_TROLL_FEMALE    
    -  ITEM_TROLL_MALE      
    -  ITEM_NIGHT_ELF_FEMALE
    -  ITEM_NIGHT_ELF_MALE  
    -  ITEM_DWARF_MALE      
    -  ITEM_DWARF_FEMALE    
    -  ITEM_DRAENEI_MALE    
    -  ITEM_DRAENEI_FEMALE  
    -  ITEM_GOBLIN_FEMALE   
    -  ITEM_GOBLIN_MALE
+ 21/11/2015 [BattleCore2326] Core/Custom: Ahora Timb Burto no tendra limite de tiempo para cambiar de escenarios. (Evento PVP)
+ 22/11/2015 [BattleCore2327] Core/Spell: Fix a sigilo (Stealth)
	+ Combate no elimina sigilo, solamente lo hace el daño
	+ Las creaturas persiguiran a una unidad de sigilo que no puedan ver si ya estan en combate con el.
	+ Cuando un jugador esta entre ~~ 3 yardas ~~ 8% + 1,5 yardas de distancia de la distancia habitual de detección de sigilo, la criatura entrara en estado de "alerta".
	+ Cuando las creaturas que esten sentadas o durmiendo y se les tira distract van a ponerse de pie.
	+ Las creaturas ya no tienen limite de visibilidad de sigilo.
+ 24/11/2015 [BattleCore2328] Core/Creature: Estadisticas de los npcs deben actualizarse cuando se cambia de entry.
+ 24/11/2015 [BattleCore2329] Core/Spell: añadimos tabla para almacenar los atributos custom
+ 24/11/2015 [BattleCore2330] Core/Spell: Actualmente sólo los hechizos dañinos CC se rompen el sigilo y modifica el estado de la unidad este comportamiento es incorrecto. Todos los impactos de hechizos dañinos deben romper el sigilo y modificar el estado.
	+ excepciones para esta mecánica, tales como:
    + Disipación en masa (sacerdote hechizo ID 32375, 32592, 39897)
    + Earthbind Totem (Pulso) (hechizo ID 3600)
    + Distraer (rogue hechizo ID 1725)
+ 29/11/2015 [BattleCore2331] DB: Solucionamos problemas de Guild Leveling Reportado en https://www.battle.cl/foros/index.php?/topic/16939-problemas-con-el-level-de-la-guild/.
	+ Se añade lvl9 al sistema
	+ Nueva mejora de guild al llegar al nivel lvl9 obtendras item Guild Vault Mobile.
+ 29/11/2015 [BattleCore2332] Core/Custom: Actualizamos limite de tickets para evento pvp.
+ 06/12/2015 [BattleCore2333] Core/Movement: Mejoramos el sistema cuando caes al vacio, ahora sera posible recupear tu cuerpo.
+ 06/12/2015 [BattleCore2334] Core/Spell: Los buff's de kharazan solo podran ser usados en la mazmorra.-
+ 06/12/2015 [BattleCore2335] Core/Arena: Las monturas Traveler's Tundra Mammoth quedan desactivadas en arenas.
+ 08/12/2015 [BattleCore2336] Core/Spell: Fix exploit miss direction.
+ 08/12/2015 [BattleCore2337] Core/Spell: Separamos los metodos de tiempo entre cast y channel spell.
+ 13/12/2015 [BattleCore2338] DB/Quest: Solucionamos Quest Dragonblight: Return to Earthu Reportada en: https://www.battle.cl/foros/index.php?/topic/13482-dragonblight-return-to-earthu/
+ 13/12/2015 [BattleCore2339] DB/Quest: Solucionamos Quest Into the Soulgrinder
+ 18/12/2015 [BattleCore2340] Core/Guild: Solucionamos problema que impedía que las Guild subieran de nivel
+ 25/12/2015 [BattleCore2341] DB/Item: Permitimos que las guild shirt puedan ser transfiguradas.
+ 25/12/2015 [BattleCore2342] DB/Item: Permitimos que los tabards de ilusion puedan ser transfigurados.
