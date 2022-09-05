import pandas as pd
import mysql.connector as msql
from mysql.connector import Error

data = pd.read_csv('datasets/vgsales-2.csv')

try:
    conn = msql.connect(host='localhost', user='anna', password='123asdQ!', database='videogames')
    if conn.is_connected():
        cursor = conn.cursor()
        cursor.execute('SELECT DATABASE();')
        record = cursor.fetchone()
        print("You are connected to database: ", record)
        cursor.execute("DROP TABLE IF EXISTS stage_esrb_rating;")
        print("Creating table stage_esrb_rating...")
        cursor.execute("CREATE TABLE stage_esrb_rating ("
                       "title VARCHAR(160), console TINYINT(1), alcohol_reference TINYINT(1),"
                       "animated_blood TINYINT(1), blood TINYINT(1), blood_and_gore TINYINT(1),"
                       "cartoon_violence TINYINT(1), crude_humor TINYINT(1), drug_reference TINYINT(1),"
                       "fantasy_violence TINYINT(1), intense_violence TINYINT(1), `language` TINYINT(1),"
                       "lyrics TINYINT(1), mature_humor TINYINT(1), mild_blood TINYINT(1),"
                       "mild_cartoon_violence TINYINT(1), mild_fantasy_violence TINYINT(1), mild_language TINYINT(1),"
                       "mild_lyrics TINYINT(1), mild_suggestive_themes TINYINT(1), mild_violence TINYINT(1),"
                       "no_descriptors TINYINT(1), nudity TINYINT(1), partial_nudity TINYINT(1),"
                       "sexual_content TINYINT(1), sexual_themes TINYINT(1), simulated_gambling TINYINT(1),"
                       "strong_janguage TINYINT(1), strong_sexual_content TINYINT(1),"
                       "suggestive_themes TINYINT(1), use_of_alcohol TINYINT(1), use_of_drugs_and_alcohol TINYINT(1),"
                       "violence TINYINT(1), esrb_rating VARCHAR(160) DEFAULT NULL);")
        print("Table stage_esrb_rating is created...")

        for i, row in data.iterrows():
            sql = "INSERT INTO videogames.stage_esrb_rating " \
                  "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s," \
                  "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);"
            tuplerow = tuple(row)
            cursor.execute(sql, tuplerow)
            print("Record inserted " + str(i))
            # the connection is not autocommited by default, so we must commit to save our changes
            conn.commit()
except Error as e:
    print("Error while connecting to MySQL", e)
