from flask import Flask, render_template, request, redirect
import sqlite3

app = Flask(__name__)

def init_db():
    conn = sqlite3.connect("database.db")
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

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"]
        email = request.form["email"]
        password = request.form["password"]

        conn = sqlite3.connect("database.db")
        cursor = conn.cursor()
        cursor.execute("INSERT INTO users (username, email, password) VALUES (?, ?, ?)",
                       (username, email, password))
        conn.commit()
        conn.close()

        return redirect("/")

    return render_template("register.html")

@app.route("/users")
def users():
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
    rows = cursor.fetchall()
    conn.close()

    return render_template("users.html", users=rows)

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5001, debug=True)
