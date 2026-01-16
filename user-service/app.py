from flask import Flask, render_template, request, redirect
import sqlite3
import os
import hashlib

app = Flask(__name__)

ENV = os.getenv("ENV", "local")
DB_PATH = os.getenv("SQLITE_DB_PATH", "database.db")

def get_db_connection():
    if ENV == "local":
        return sqlite3.connect(DB_PATH)
    else:
        # Placeholder for Azure SQL (later)
        raise Exception("Azure SQL not configured yet")


def init_db():
    if ENV != "local":
        return  # DB migrations handled separately in real envs

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        """CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL
        )"""
    )
    conn.commit()
    conn.close()

def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"]
        email = request.form["email"]
        password = hash_password(request.form["password"])

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("INSERT INTO users (username, email, password) VALUES (?, ?, ?)",
                       (username, email, password))
        conn.commit()
        conn.close()

        return redirect("/")

    return render_template("register.html")

@app.route("/users")
def users():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
    rows = cursor.fetchall()
    conn.close()

    return render_template("users.html", users=rows)

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000, debug=True)
