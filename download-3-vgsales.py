import pandas as pd
import mysql.connector as msql
from mysql.connector import Error

data = pd.read_csv('datasets/vgsales-3.csv')

data.fillna({'Year': 1901.0, 'Publisher': ''}, inplace=True)

data['Year'] = data['Year'].round(0).astype(int)


try:
    conn = msql.connect(host='localhost', user='anna', password='123asdQ!', database='videogames')
    if conn.is_connected():
        cursor = conn.cursor()
        cursor.execute('SELECT DATABASE();')
        record = cursor.fetchone()
        print("You are connected to database: ", record)
        cursor.execute("DROP TABLE IF EXISTS stage_little_vgsales;")
        print("Creating table stage_little_vgsales...")
        cursor.execute("CREATE TABLE videogames.stage_little_vgsales (`rank` INT NOT NULL, "
                       "`name` VARCHAR(160) DEFAULT NULL, `platform` VARCHAR(10) NULL DEFAULT NULL,"
                       "`year` YEAR DEFAULT NULL, `genre` VARCHAR(50) DEFAULT NULL,"
                       "`publisher` VARCHAR(50) NULL DEFAULT NULL, `na_sales` FLOAT(10,2) DEFAULT NULL,"
                       "`eu_sales` FLOAT(10,2) NULL DEFAULT NULL, `jp_sales` FLOAT(10,2) NULL DEFAULT NULL,"
                       "`other_sales` FLOAT(10,2) NULL DEFAULT NULL, `global_sales` FLOAT(10,2) NULL DEFAULT NULL);")
        print("Table stage_little_vgsales is created...")

        for i, row in data.iterrows():
            sql = "INSERT INTO videogames.stage_little_vgsales " \
                  "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            tuplerow = tuple(row)
            cursor.execute(sql, tuplerow)
            print("Record inserted " + str(i))
            # the connection is not autocommited by default, so we must commit to save our changes
            conn.commit()
except Error as e:
    print("Error while connecting to MySQL", e)
