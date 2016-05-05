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

#ifndef TRINITYCORE_WORDFILTERMGR_H
#define TRINITYCORE_WORDFILTERMGR_H

#include <string>
#include <map>

class WordFilterMgr
{
private:

    WordFilterMgr();
    ~WordFilterMgr();
    WordFilterMgr(const WordFilterMgr&);
    WordFilterMgr& operator=(const WordFilterMgr&);

public:

    static WordFilterMgr* instance()
    {
        static WordFilterMgr instance;
        return &instance;
    }

    /// Note for 0.6v : Will used std::map instead of UNORDERED_MAP, because of problems with cross-platform compilation.
    // [letter][analogs]
    typedef std::map<char, std::string> LetterAnalogMap;
    // [converted][original]
    typedef std::map<std::string, std::string> BadWordMap;

    void LoadLetterAnalogs();
    void LoadBadWords();

    inline void ConvertLettersToAnalogs(std::string& text);
    std::string FindBadWord(const std::string& text);

    // manipulations with container
    bool AddBadWord(const std::string& badWord, bool toDB = false);
    bool RemoveBadWord(const std::string& badWord, bool fromDB = false);

    // element (const) accessor
    BadWordMap GetBadWords() const { return m_badWords; }

private:
    LetterAnalogMap m_letterAnalogs;
    BadWordMap m_badWords;
};

#define sWordFilterMgr WordFilterMgr::instance()

#endif
