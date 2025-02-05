from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)  # Allow requests from Flutter

# Connect to MySQL database
db = mysql.connector.connect(
    host="localhost",
    user="root",        # Replace with your MySQL username
    password="dharm2005", # Replace with your MySQL password
    database="attendance_system"  # Replace with your database name
)

@app.route('/register', methods=['POST'])
def register_student():
    try:
        # Get data from Flutter
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        photo = request.files['photo']

        # Save photo to server
        photo_path = f"uploads/{username}.jpg"
        photo.save(photo_path)

        # Insert data into database
        cursor = db.cursor()
        query = "INSERT INTO students (username, email, password, photo_path) VALUES (%s, %s, %s, %s)"
        values = (username, email, password, photo_path)
        cursor.execute(query, values)
        db.commit()

        return jsonify({'message': 'Student registered successfully!'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
