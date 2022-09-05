CREATE TABLE IF NOT EXISTS fact_vgsales (
id INT PRIMARY KEY AUTO_INCREMENT,
`rank` INT NOT NULL,
`name` CHAR(160) DEFAULT NULL,
platform CHAR(10) DEFAULT NULL,
basename CHAR(160) DEFAULT NULL,
genre_id INT NOT NULL,
esrb_rating_id INT NOT NULL,
platform_id INT NOT NULL,
publisher_id INT NOT NULL,
developer_id INT NOT NULL,
year_id INT NOT NULL,
critic_score FLOAT(10,2) DEFAULT NULL,
user_score FLOAT(10,2) DEFAULT NULL,
total_shipped FLOAT(10,2) DEFAULT NULL,
global_sales FLOAT(10,2) DEFAULT NULL,
na_sales FLOAT(10,2) DEFAULT NULL,
pal_sales FLOAT(10,2) DEFAULT NULL,
eu_sales FLOAT(10,2) DEFAULT NULL,
jp_sales FLOAT(10,2) DEFAULT NULL,
other_sales FLOAT(10,2) DEFAULT NULL,
last_update DATE DEFAULT NULL,
url CHAR(255) DEFAULT NULL,
`status` INT DEFAULT NULL,
vgchartzscore FLOAT(10,2) DEFAULT NULL,
img_url CHAR(255) DEFAULT NULL,
console TINYINT(1) DEFAULT NULL,
alcohol_reference TINYINT(1) DEFAULT NULL,
animated_blood TINYINT(1) DEFAULT NULL,
blood TINYINT(1) DEFAULT NULL,
blood_and_gore TINYINT(1) DEFAULT NULL,
cartoon_violence TINYINT(1) DEFAULT NULL,
crude_humor TINYINT(1) DEFAULT NULL,
drug_reference TINYINT(1) DEFAULT NULL,
fantasy_violence TINYINT(1) DEFAULT NULL,
intense_violence TINYINT(1) DEFAULT NULL,
`language` TINYINT(1) DEFAULT NULL,
lyrics TINYINT(1) DEFAULT NULL,
mature_humor TINYINT(1) DEFAULT NULL,
mild_blood TINYINT(1) DEFAULT NULL,
mild_cartoon_violence TINYINT(1) DEFAULT NULL,
mild_fantasy_violence TINYINT(1) DEFAULT NULL,
mild_language TINYINT(1) DEFAULT NULL,
mild_lyrics TINYINT(1) DEFAULT NULL,
mild_suggestive_themes TINYINT(1) DEFAULT NULL,
mild_violence TINYINT(1) DEFAULT NULL,
no_descriptors TINYINT(1) DEFAULT NULL,
nudity TINYINT(1) DEFAULT NULL,
partial_nudity TINYINT(1) DEFAULT NULL,
sexual_content TINYINT(1) DEFAULT NULL,
sexual_themes TINYINT(1) DEFAULT NULL,
simulated_gambling TINYINT(1) DEFAULT NULL,
strong_janguage TINYINT(1) DEFAULT NULL,
strong_sexual_content TINYINT(1) DEFAULT NULL,
suggestive_themes TINYINT(1) DEFAULT NULL,
use_of_alcohol TINYINT(1) DEFAULT NULL,
use_of_drugs_and_alcohol TINYINT(1) DEFAULT NULL,
violence TINYINT(1) DEFAULT NULL,
KEY `nm_platform` (`name`,`platform`),
CONSTRAINT vgsales_publishers FOREIGN KEY (publisher_id) REFERENCES publishers (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT vgsales_genres FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT vgsales_esrb_ratings FOREIGN KEY (esrb_rating_id) REFERENCES esrb_ratings (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT vgsales_platforms FOREIGN KEY (platform_id) REFERENCES platforms (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT vgsales_developers FOREIGN KEY (developer_id) REFERENCES developers (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT vgsales_release_year FOREIGN KEY (year_id) REFERENCES release_year (id) ON DELETE CASCADE ON UPDATE CASCADE
);
SELECT * FROM fact_vgsales;
DROP TABLE IF EXISTS fact_vgsales;




INSERT INTO fact_vgsales
(`rank`, `name`, platform, basename, critic_score, user_score,
total_shipped, global_sales, na_sales,
pal_sales, jp_sales, other_sales, last_update, url, `status`,
vgchartzscore, img_url, genre_id, esrb_rating_id, platform_id,
publisher_id, developer_id, year_id, animated_blood, console,
alcohol_reference, blood, blood_and_gore, cartoon_violence,
crude_humor, drug_reference, fantasy_violence, intense_violence,
`language`, lyrics, mature_humor, mild_blood,
mild_cartoon_violence, mild_fantasy_violence, mild_language,
mild_lyrics, mild_suggestive_themes, mild_violence,
no_descriptors, nudity, partial_nudity, sexual_content,
sexual_themes, simulated_gambling, strong_janguage,
strong_sexual_content, suggestive_themes, use_of_alcohol,
use_of_drugs_and_alcohol, violence)

(SELECT vgs.rank, vgs.name, vgs.platform, vgs.basename,
vgs.critic_score, vgs.user_score, vgs.total_shipped,
vgs.global_sales, vgs.na_sales,
vgs.pal_sales, vgs.jp_sales, vgs.other_sales, vgs.last_update,
vgs.url, vgs.`status`, vgs.vgchartzscore, vgs.img_url,
g.id, esrb.id, pl.id, p.id, d.id, y.id, st.animated_blood,
st.console, st.alcohol_reference, st.blood, st.blood_and_gore,
st.cartoon_violence, st.crude_humor, st.drug_reference,
st.fantasy_violence, st.intense_violence, st.language,
st.lyrics, st.mature_humor, st.mild_blood,
st.mild_cartoon_violence, st.mild_fantasy_violence,
st.mild_language, st.mild_lyrics,
st.mild_suggestive_themes, st.mild_violence, st.no_descriptors,
st.nudity, st.partial_nudity, st.sexual_content,
st.sexual_themes, st.simulated_gambling, st.strong_janguage,
st.strong_sexual_content, st.suggestive_themes,
st.use_of_alcohol, st.use_of_drugs_and_alcohol, st.violence
FROM stage_vgsales AS vgs
LEFT JOIN genres AS g ON (vgs.genre = g.name)
LEFT JOIN esrb_ratings AS esrb ON (vgs.esrb_rating = esrb.name)
LEFT JOIN platforms AS pl ON (vgs.platform = pl.name)
LEFT JOIN publishers AS p ON (vgs.publisher = p.name)
LEFT JOIN developers AS d ON (vgs.developer = d.name)
LEFT JOIN release_year AS y ON (vgs.year = y.year)
LEFT JOIN stage_esrb_rating AS st ON (vgs.name = st.title)
);
