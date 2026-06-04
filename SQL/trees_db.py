
import sqlite3

# Create a sql database file
conn = sqlite3.connect('reforestation.db')
cursor=conn.cursor()

# Create a table for the preliminary data
cursor.execute('''
    CREATE TABLE PRELIMINAR (
                ID INTEGER PRIMARY KEY AUTOINCREMENT,
                GENERAL_LOCATION TEXT,
                SPECIFIC_LOCATION TEXT,
                AREA_M2 REAL,
                PERIMETER_M REAL,
                TREES_BY_AREA INTEGER,
                TREES_BY_PERIMETER INTEGER
    )
''')

# Insert sample data
cursor.execute('''
    INSERT INTO PRELIMINAR (GENERAL_LOCATION,SPECIFIC_LOCATION, AREA_M2, PERIMETER_M, TREES_BY_AREA, TREES_BY_PERIMETER)
    VALUES ('Parque lluvia de oro', 'Rotonda', 1123.25, 122.22, 70, 30)

''')

# Commit and close
conn.commit()
conn.close()
