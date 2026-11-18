import os
from flask import Flask, make_response, render_template
import mysql.connector
from werkzeug.middleware.proxy_fix import ProxyFix
app = Flask(__name__)

app.wsgi_app = ProxyFix(
    app.wsgi_app,
    x_for=1,
    x_proto=1,
    x_prefix=1,
)

def increment_counter():
	# Connect to MySQL/MariaDB
	conn = mysql.connector.connect(
    	host=os.environ["DB_HOST"],
    	user=os.environ["DB_USER"],
    	password=os.environ["DB_PASSWORD"],
		database="visitcounterdb",
		charset="utf8mb4",
        autocommit=False,
	)
	try:
		with conn.cursor() as cursor:
			cursor.execute("UPDATE visit_counter SET count = count + 1 WHERE counterID = 1")
			conn.commit()
			cursor.execute("SELECT count FROM visit_counter WHERE counterID = 1")
			result = cursor.fetchone()
		return result[0]
	except mysql.connector.Error:
		conn.rollback()
		raise
	finally:
		conn.close()
@app.route('/')

def home():
	# Connect to MySQL/MariaDB
	result = increment_counter()
	return render_template("index.html", result=result)


if __name__ == '__main__':
	app.run(host='0.0.0.0', port=5000)

