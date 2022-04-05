-- DB update 2022_03_06_08 -> 2022_03_06_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_08 2022_03_06_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646082947646026800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646082947646026800');

SET @NPC := 528;
SET @PATH := @NPC * 10;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -12321.5, -1062.25, 6.71975, 100, 0),
(@PATH, 2, -12316.1, -1056.04, 6.97003, 100, 0),
(@PATH, 3, -12308.2, -1047.11, 7.46321, 100, 0),
(@PATH, 4, -12311.1, -1049.92, 7.21966, 100, 0),
(@PATH, 5, -12316.2, -1055.99, 6.96187, 100, 0),
(@PATH, 6, -12321.4, -1062.2, 6.73149, 100, 0),
(@PATH, 7, -12327.6, -1067.39, 6.61384, 100, 0),
(@PATH, 8, -12331, -1068.94, 6.18957, 100, 0),
(@PATH, 9, -12335, -1069.22, 5.16496, 100, 0),
(@PATH, 10, -12338.8, -1068.72, 4.29683, 100, 0),
(@PATH, 11, -12341.5, -1066.1, 3.75147, 100, 0),
(@PATH, 12, -12345.4, -1059.12, 3.28727, 100, 0),
(@PATH, 13, -12346.6, -1055.36, 4.00031, 100, 0),
(@PATH, 14, -12348, -1051.57, 3.9798, 100, 0),
(@PATH, 15, -12351.3, -1049.17, 3.58065, 100, 0),
(@PATH, 16, -12355, -1048.05, 3.3413, 100, 0),
(@PATH, 17, -12358.8, -1048.94, 3.55616, 100, 0),
(@PATH, 18, -12366.8, -1056.54, 3.92688, 100, 0),
(@PATH, 19, -12366.8, -1056.54, 3.92688, 100, 0),
(@PATH, 20, -12364.2, -1053.43, 3.72082, 100, 0),
(@PATH, 21, -12361.6, -1050.32, 3.82116, 100, 0),
(@PATH, 22, -12358.9, -1047.54, 3.68409, 100, 0),
(@PATH, 23, -12355.1, -1047.05, 3.38913, 100, 0),
(@PATH, 24, -12351.5, -1049.17, 3.55732, 100, 0),
(@PATH, 25, -12348.4, -1051.71, 4.00812, 100, 0),
(@PATH, 26, -12344.6, -1058.7, 3.24289, 100, 0),
(@PATH, 27, -12341, -1065.64, 3.83569, 100, 0),
(@PATH, 28, -12337.8, -1067.93, 4.55854, 100, 0),
(@PATH, 29, -12333.9, -1068.88, 5.43942, 100, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_09' WHERE sql_rev = '1646082947646026800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
