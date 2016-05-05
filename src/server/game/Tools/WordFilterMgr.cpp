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

#include "WordFilterMgr.h"

bool NormalizeWord(std::string& utf8String)
{
    // remove spaces
    std::string::size_type n = 0;
    while ((n = utf8String.find(' ', n)) != utf8String.npos)
        utf8String.erase(n, 1);

    std::wstring utf16String;

    if (!Utf8toWStr(utf8String, utf16String))
        return false;

    std::transform(utf16String.begin(), utf16String.end(), utf16String.begin(), wcharToLower);

    return WStrToUtf8(utf16String, utf8String);
}

/*
// Find words by letters next to it.
bool FindWordInSequence(const std::string& str, const std::string& word, const size_t maxDistBethChars)
{
size_t charsCount = 0, distBethCharsCount = 0;
bool lastCharIsExist = false;

for (size_t i = 0, lastI = 0; i < str.size(); ++i)
{
if (str[i] == word[charsCount])
{
if (!lastCharIsExist)
lastI = i;

++charsCount;
distBethCharsCount = 0;
lastCharIsExist = true;
}
else if (lastCharIsExist)
++distBethCharsCount;

if (distBethCharsCount > maxDistBethChars)
{
i = lastI;
charsCount = 0;
distBethCharsCount = 0;
lastCharIsExist = false;
}

if (charsCount >= word.size())
return true;
}

return false;
}
*/

WordFilterMgr::WordFilterMgr()
{
}

WordFilterMgr::~WordFilterMgr()
{
}

void WordFilterMgr::LoadLetterAnalogs()
{
    uint32 oldMSTime = getMSTime();

    m_letterAnalogs.clear();

    QueryResult result = WorldDatabase.Query("SELECT letter, analogs FROM letter_analogs");
    if (!result)
    {
        TC_LOG_INFO(LOG_FILTER_SERVER_LOADING, ">> Loaded 0 letter analogs. DB table `letter_analogs` is empty!");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        char letter = fields[0].GetString()[0]; // !fields[0].GetInt8()
        std::string analogs = fields[1].GetString();

        NormalizeWord(analogs);
        m_letterAnalogs[letter] = analogs;

        ++count;
    } while (result->NextRow());

    TC_LOG_INFO(LOG_FILTER_SERVER_LOADING, ">> Loaded %u letter analogs in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}


void WordFilterMgr::LoadBadWords()
{
    uint32 oldMSTime = getMSTime();

    m_badWords.clear();

    QueryResult result = WorldDatabase.Query("SELECT censure_word FROM custom_censure_word"); 
    if (!result)
    {
        TC_LOG_INFO(LOG_FILTER_SERVER_LOADING, ">> Loaded 0 censure words. DB table `custom_censure_word` is empty!");
        return;
    }

    uint32 count = 0;
    do
    {
        Field* fields = result->Fetch();
        std::string analog = fields[0].GetString();

        AddBadWord(analog);

        ++count;
    } while (result->NextRow());

    TC_LOG_INFO(LOG_FILTER_SERVER_LOADING, ">> Loaded %u censure word in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

inline void WordFilterMgr::ConvertLettersToAnalogs(std::string& text)
{
    // todo: to change to STL algorithms (for optimize).
    for (std::string::iterator sit = text.begin(); sit != text.end(); ++sit)
        for (LetterAnalogMap::const_iterator mit = m_letterAnalogs.begin(); mit != m_letterAnalogs.end(); ++mit)
            if (mit->second.find(*sit) != std::string::npos)
            {
                *sit = mit->first;
                break;
            }
}

std::string WordFilterMgr::FindBadWord(const std::string& text)
{
    std::string _text = text;

    if (_text.empty() || m_badWords.empty())
        return "";

    NormalizeWord(_text);
    ConvertLettersToAnalogs(_text);

    for (BadWordMap::const_iterator it = m_badWords.begin(); it != m_badWords.end(); ++it)
        if (_text.find(it->first) != std::string::npos)
            return it->second;

    /*
    // At ~5 times slower.
    for (BadWordMap::const_iterator it = m_badWords.begin(); it != m_badWords.end(); ++it)
    {
    if (it->second.size() <= 3)
    {
    if (_text.find(it->first) != std::string::npos)
    return it->second;
    }
    else if (it->second.size() <= 7)
    {
    if(FindWordInSequence(_text, it->first, 1))
    return it->second;
    }
    else
    {
    if(FindWordInSequence(_text, it->first, 2))
    return it->second;
    }
    }
    */

    return "";
}

bool WordFilterMgr::AddBadWord(const std::string& badWord, bool toDB)
{
    std::string _badWord = badWord;

    NormalizeWord(_badWord);

    std::string convertedBadWord = _badWord;
    ConvertLettersToAnalogs(convertedBadWord);

    // is already exist
    if (m_badWords.find(convertedBadWord) != m_badWords.end())
        return false;

    m_badWords[convertedBadWord] = _badWord;

    if (toDB)
        WorldDatabase.PQuery("REPLACE INTO custom_censure_word VALUES ('%s')", _badWord.c_str());

    return true;
}

bool WordFilterMgr::RemoveBadWord(const std::string& badWord, bool fromDB)
{
    std::string _badWord = badWord;

    NormalizeWord(_badWord);

    std::string convertedBadWord = _badWord;
    ConvertLettersToAnalogs(convertedBadWord);

    // is not exist
    BadWordMap::iterator it = m_badWords.find(convertedBadWord);
    if (it == m_badWords.end())
        return false;

    m_badWords.erase(it);

    if (fromDB)
        WorldDatabase.PExecute("DELETE FROM custom_censure_word WHERE `censure_word` = '%s'", _badWord.c_str());

    return true;
}
