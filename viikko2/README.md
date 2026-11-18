# LEMP_stack
## LEMP stack project made for OAMK linux course.
This project is built using a LEMP stack (Linux, Nginx, MySQL, and Python). The web application is developed with Flask, served by Gunicorn, and exposed to users through Nginx, which acts as a reverse proxy. The application also includes a visitor counter whose value is stored in a MySQL database. Every time the page is visited or refreshed, the counter is updated in the database and the current visitor count is displayed on the webpage.

>app.py and /templates      go to PATH: ~/lemp-app

>lemp-app                   go to PATH: /etc/nginx/sites-available/lemp-app

>lemp-app.service           go to PATH: /etc/systemd/system/lemp-app.service


