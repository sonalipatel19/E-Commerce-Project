from flask import Flask, render_template, request, redirect
import sqlite3

app = Flask(__name__)

# Initialize DB
def init_db():
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()
    cursor.execute(
        """CREATE TABLE IF NOT EXISTS products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            price REAL NOT NULL
        )"""
    )
    conn.commit()
    conn.close()

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/add", methods=["GET", "POST"])
def add_product():
    if request.method == "POST":
        name = request.form["name"]
        price = request.form["price"]

        conn = sqlite3.connect("database.db")
        cursor = conn.cursor()
        cursor.execute("INSERT INTO products (name, price) VALUES (?, ?)", (name, price))
        conn.commit()
        conn.close()

        return redirect("/products")

    return render_template("add_product.html")

@app.route("/products")
def products():
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM products")
    items = cursor.fetchall()
    conn.close()

    return render_template("products.html", items=items)

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5002, debug=True)
