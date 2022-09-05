UPDATE videogames.stage_vgsales SET vgchartz_score = NULL WHERE
vgchartz_score = -555;
UPDATE videogames.stage_vgsales SET critic_score = NULL WHERE
critic_score = -555;
UPDATE videogames.stage_vgsales SET user_score = NULL WHERE
user_score = -555;
UPDATE videogames.stage_vgsales SET total_shipped = NULL WHERE
total_shipped = -555;
UPDATE videogames.stage_vgsales SET global_sales = NULL WHERE
global_sales = -555;
UPDATE videogames.stage_vgsales SET na_sales = NULL WHERE
na_sales = -555;
UPDATE videogames.stage_vgsales SET pal_sales = NULL WHERE
pal_sales = -555;
UPDATE videogames.stage_vgsales SET jp_sales = NULL WHERE
jp_sales = -555;
UPDATE videogames.stage_vgsales SET other_sales = NULL WHERE
other_sales = -555;
UPDATE videogames.stage_vgsales SET vgchartzscore = NULL WHERE
vgchartzscore = -555;

UPDATE videogames.stage_vgsales SET `year` = NULL WHERE `year` =
1901;
UPDATE videogames.stage_little_vgsales SET `year` = NULL WHERE `year` =
1901;
UPDATE videogames.stage_vgsales SET last_update = NULL WHERE
last_update = '2055-1-1';

SET SQL_SAFE_UPDATES = 0;