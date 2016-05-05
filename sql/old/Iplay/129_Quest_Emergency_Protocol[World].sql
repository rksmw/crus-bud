UPDATE item_template SET scriptname = 'npc_emergency_torch' WHERE entry = 35224;

UPDATE creature SET position_x='3359.92',position_y='5047.29',position_z='13.1661',spawndist='0',movementtype='0' WHERE guid = 119029;
UPDATE creature SET position_x='3391.19',position_y='5136.23',position_z='14.6015',spawndist='0',movementtype='0' WHERE guid = 119030;
UPDATE creature SET position_x='3516.08',position_y='5015.59',position_z='0.76339',spawndist='0',movementtype='0' WHERE guid = 119150;
UPDATE creature SET position_x='3475.95',position_y='4916.29',position_z='14.3871',spawndist='0',movementtype='0' WHERE guid = 119186;
UPDATE creature SET position_x='3606.19',position_y='5063.01',position_z='14.8218',spawndist='0',movementtype='0' WHERE guid = 118881;
UPDATE creature SET position_x='3739.38',position_y='5047.41',position_z='-0.9576',spawndist='0',movementtype='0' WHERE guid = 118886;

UPDATE creature_template SET unit_flags = 0,TYPE=8,flags_extra=130,modelid1=10045,modelid2=0 WHERE entry IN (25847,25846,25845);
