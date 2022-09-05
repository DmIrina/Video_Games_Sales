-- ----------------- publishers -------------------------
DROP TABLE IF EXISTS publishers;

CREATE TABLE IF NOT EXISTS publishers (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` CHAR(50));

INSERT INTO publishers (name) (
SELECT DISTINCT publisher FROM (SELECT publisher FROM
stage_vgsales
UNION
SELECT publisher FROM stage_little_vgsales) as s3) ;

SELECT * FROM videogames.publishers ORDER BY id ASC;

-- ---------------- genres -----------------------
DROP TABLE IF EXISTS genres;

CREATE TABLE IF NOT EXISTS genres (
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) UNIQUE);

INSERT INTO genres (name) (
SELECT DISTINCT genre FROM (SELECT genre FROM stage_vgsales
UNION
SELECT genre FROM stage_little_vgsales) as s3);

SELECT * FROM videogames.genres ORDER BY id ASC;

-- -------------- platform -------------------
DROP TABLE IF EXISTS platforms;

CREATE TABLE IF NOT EXISTS platforms (
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(10) UNIQUE);

INSERT INTO platforms (name) (
SELECT DISTINCT platform FROM (SELECT platform FROM
stage_vgsales
UNION
SELECT platform FROM stage_little_vgsales) as s3);

SELECT * FROM videogames.platforms ORDER BY id ASC;

-- ------------ developer ---------------
DROP TABLE IF EXISTS developers;

CREATE TABLE IF NOT EXISTS developers (
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(160) UNIQUE);

INSERT INTO developers (name) (
SELECT DISTINCT developer FROM stage_vgsales);

SELECT * FROM videogames.developers ORDER BY id ASC;

-- ------------- esrb_rating type ------
DROP TABLE IF EXISTS esrb_ratings;

CREATE TABLE IF NOT EXISTS esrb_ratings (
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(10) UNIQUE,
ful_name VARCHAR(50) UNIQUE);

INSERT INTO esrb_ratings (name) (
SELECT DISTINCT esrb_rating FROM (SELECT esrb_rating FROM
stage_vgsales
UNION
SELECT esrb_rating FROM stage_esrb_rating) as s3);

UPDATE `videogames`.`esrb_ratings` SET `ful_name` = 'Kids to Adults' WHERE (`id` = '9');
UPDATE `videogames`.`esrb_ratings` SET `ful_name` = 'Teen' WHERE (`id` = '5');
UPDATE `videogames`.`esrb_ratings` SET `ful_name` = 'Mature 17+' WHERE (`id` = '3');
UPDATE `videogames`.`esrb_ratings` SET `ful_name` = 'Adults Only 18+' WHERE (`id` = '8');
UPDATE `videogames`.`esrb_ratings` SET `ful_name` = 'Everyone' WHERE (`id` = '1');
UPDATE `videogames`.`esrb_ratings` SET `ful_name` = 'Everyone 10+ ' WHERE (`id` = '4');
UPDATE `videogames`.`esrb_ratings` SET `ful_name` = 'Early Childhood' WHERE (`id` = '7');
UPDATE `videogames`.`esrb_ratings` SET `ful_name` = 'Rating Pending' WHERE (`id` = '6');


SELECT * FROM videogames.esrb_ratings ORDER BY id ASC;

-- ------------------- release_year -----------------
DROP TABLE IF EXISTS release_year;

CREATE TABLE IF NOT EXISTS release_year (
id INT PRIMARY KEY AUTO_INCREMENT,
`year` YEAR UNIQUE);

INSERT INTO release_year (`year`) (
SELECT DISTINCT `year` FROM (SELECT `year` FROM stage_vgsales
UNION
SELECT `year` FROM stage_little_vgsales) as s3);

SELECT * FROM videogames.release_year ORDER BY year ASC;