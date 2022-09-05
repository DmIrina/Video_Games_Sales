import pandas as pd
import mysql.connector as msql
from mysql.connector import Error

data = pd.read_csv('datasets/vgsales-1.csv')

# замінити пропущені строкові дані на empty
data.fillna({'Name': 'N/A', 'Basename':	'N/A', 'Genre': 'N/A', 'ESRB_Rating': 'N/A', 'Platform': 'N/A',
             'Publisher': 'N/A', 'Developer': 'N/A', 'url': 'N/A', 'img_url': 'N/A'}, inplace=True)

# замінити пропущені числові дані на -555, дати на 1901 рік для подальшої заміни на NULL СКБД засобами
data.fillna({'Rank': -555, 'VGChartz_Score': -555, 'Critic_Score': -555, 'User_Score': -555,
             'Total_Shipped': -555, 'Global_Sales': -555, 'NA_Sales': -555, 'PAL_Sales': -555,
             'JP_Sales': -555, 'Other_Sales': -555, 'Year': 1901.0, 'Last_Update': '01 Jan 55',
             'status': -555, 'Vgchartzscore': -555}, inplace=True)

# форматування 2020.0 -> 2020, '24th Jan 2018' -> 24 Jan 2018 -> 2018-06-24
data['Year'] = data['Year'].round(0).astype(int)
data['Last_Update'].replace(r'(\d)(st|nd|rd|th)', r'\1', regex=True, inplace=True)
data['Last_Update'] = pd.to_datetime(data['Last_Update'], format="%d %b %y")


try:
    conn = msql.connect(host='localhost', user='anna', password='123asdQ!', database='videogames')
    if conn.is_connected():
        cursor = conn.cursor()
        cursor.execute('SELECT DATABASE();')
        record = cursor.fetchone()
        print("You are connected to database: ", record)
        cursor.execute("DROP TABLE IF EXISTS stage_vgsales;")
        print("Creating table stage_vgsales...")
        cursor.execute("CREATE TABLE videogames.stage_vgsales (`rank` INT NOT NULL, "
                       "`name` VARCHAR(160) NULL DEFAULT NULL, `basename` VARCHAR(160) NULL DEFAULT NULL,"
                       "`genre` VARCHAR(50) NULL DEFAULT NULL, `esrb_rating` VARCHAR(10) NULL DEFAULT NULL,"
                       "`platform` VARCHAR(10) NULL DEFAULT NULL, `publisher` VARCHAR(50) NULL DEFAULT NULL,"
                       "`developer` VARCHAR(160) NULL DEFAULT NULL, `vgchartz_score` FLOAT(10,2) NULL DEFAULT NULL,"
                       "`critic_score` FLOAT(10,2) NULL DEFAULT NULL, `user_score` FLOAT(10,2) NULL DEFAULT NULL,"
                       "`total_shipped` FLOAT(10,2) NULL DEFAULT NULL, `global_sales` FLOAT(10,2) NULL DEFAULT NULL,"
                       "`na_sales` FLOAT(10,2) NULL DEFAULT NULL, `pal_sales` FLOAT(10,2) NULL DEFAULT NULL,"
                       "`jp_sales` FLOAT(10,2) NULL DEFAULT NULL, `other_sales` FLOAT(10,2) NULL DEFAULT NULL,"
                       "`year` YEAR NULL DEFAULT NULL, `last_update` DATE NULL DEFAULT NULL,"
                       "`url` VARCHAR(255) NULL DEFAULT NULL, `status` INT NULL DEFAULT NULL,"
                       "`vgchartzscore` FLOAT(10,2) NULL DEFAULT NULL, `uml_url` VARCHAR(255) NULL DEFAULT NULL);")
        print("Table stage_vgsales is created...")

        for i, row in data.iterrows():
            sql = "INSERT INTO videogames.stage_vgsales " \
                  "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            tuplerow = tuple(row)
            cursor.execute(sql, tuplerow)
            print("Record inserted " + str(i))
            # the connection is not autocommited by default, so we must commit to save our changes
            conn.commit()
except Error as e:
    print("Error while connecting to MySQL", e)
