import sqlite3

conn = sqlite3.connect(':memory:')
cursor = conn.cursor()
cursor.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT)")
cursor.execute("INSERT INTO users (name, email) VALUES ('alice', 'alice@example.com')")
cursor.execute("INSERT INTO users (name, email) VALUES ('bob', 'bob@example.com')")
conn.commit()

def get_user_by_name(name):
    # SQL Injection vulnerability
    query = f"SELECT * FROM users WHERE name = '{name}'"
    cursor.execute(query)
    return cursor.fetchone()
