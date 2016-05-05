#ifndef SC_ACDATA_H
#define SC_ACDATA_H

#include "AnticheatMgr.h"

class AnticheatData
{
public:
    AnticheatData();
    ~AnticheatData();

    void SetLastOpcode(uint32 opcode);
    uint32 GetLastOpcode() const;

    const MovementInfo& GetLastMovementInfo() const;
    void SetLastMovementInfo(MovementInfo& moveInfo);

    void SetPosition(float x, float y, float z, float o);

    uint32 GetTypeReports(uint32 type) const;
    void SetTypeReports(uint32 type, uint32 amount);

private:
    uint32 lastOpcode;
    MovementInfo lastMovementInfo;
    uint32 typeReports[MAX_REPORT_TYPES];
};

#endif