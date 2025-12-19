from flask import Flask, render_template, request, redirect
import sqlite3

app = Flask(__name__)

# Initialize DB
def init_db():
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()
    cursor.execute(
        """CREATE TABLE IF NOT EXISTS orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            product_name TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            total_price REAL NOT NULL
        )"""
    )
    conn.commit()
    conn.close()

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/order", methods=["GET", "POST"])
def place_order():
    if request.method == "POST":
        username = request.form["username"]
        product = request.form["product"]
        price = float(request.form["price"])
        quantity = int(request.form["quantity"])

        total = price * quantity

        conn = sqlite3.connect("database.db")
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO orders (username, product_name, quantity, total_price) VALUES (?, ?, ?, ?)",
            (username, product, quantity, total)
        )
        conn.commit()
        conn.close()

        return redirect("/orders")

    # Hard-coded demo data (later replaced by API or internal service URL)
    users = ["alice", "bob", "charlie"]
    products = [
        {"name": "Laptop", "price": 900},
        {"name": "Headphones", "price": 50},
        {"name": "Mouse", "price": 25}
    ]

    return render_template("place_order.html", users=users, products=products)

@app.route("/orders")
def orders():
    conn = sqlite3.connect("database.db")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM orders")
    rows = cursor.fetchall()
    conn.close()

    return render_template("orders.html", orders=rows)

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5003, debug=True)
