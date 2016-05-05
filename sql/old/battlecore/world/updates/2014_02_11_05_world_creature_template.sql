UPDATE `creature_template` SET `RegenHealth` = 0
WHERE entry IN (
-- Strand of the Ancients vehicles
28781, -- Battleground Demolisher
32796, -- Battleground Demolisher (1)
27894, -- Antipersonnel Cannon
32795,  -- Antipersonnel Cannon (1)
-- Wintergrasp vehicles
27881, -- Wintergrasp Catapult (both)
28094, -- Wintergrasp Demolisher (both)
28312, -- Wintergrasp Siege Engine (alliance)
28319, -- Wintergrasp Siege Turret (alliance)
28366, -- Wintergrasp Tower Cannon (both)
32627, -- Wintergrasp Siege Engine (horde)
32629, -- Wintergrasp Siege Turret (alliance)
-- Ulduar Vehicles
33060, -- Salvaged Siege Engine
33062, -- Salvaged Chopper
34045, -- Salvaged Chopper (1)
33067, -- Salvaged Siege Turret
33109, -- Salvaged Demolisher
-- Isle of Conquest vehicles
34793, -- Catapult (both)
34775, -- Demolisher (both)
34776, -- Siege Engine (alliance)
34777, -- Siege Turret (alliance)
34778, -- Flame Turret (alliance)
34802, -- Glaive Thrower (alliance)
34944, -- Keep Cannon (both)
35069, -- Siege Engine (horde)
35273, -- Glaive Thrower (horde)
36355, -- Siege Turret (horde)
36356); -- Flame Turret (horde)
