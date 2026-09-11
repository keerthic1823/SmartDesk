# SmartDesk - IT Service Desk Management System

SmartDesk is a Java-based IT Service Desk and Incident Management web application.

It allows employees to create and track IT support tickets, while administrators can monitor users and tickets through an Admin Dashboard.

## Features

### Employee Features

- User Registration
- User Login
- Logout
- Employee Dashboard
- Create Support Ticket
- View My Tickets
- Ticket Status Tracking
- Reports
- Account Settings

### Admin Features

- Admin Login
- Admin Dashboard
- View All Tickets
- View All Users
- Ticket Statistics
- Role-Based Access

## Technology Stack

- Java 25
- Jakarta Servlets
- JSP
- JDBC
- MySQL
- Apache Tomcat 11
- HTML
- CSS
- Bootstrap
- Eclipse IDE

## Project Architecture

Browser
↓
JSP
↓
Servlet / Controller
↓
Service Layer
↓
DAO Layer
↓
JDBC
↓
MySQL

## Database

Database Name:

smartdesk

Main Tables:

- users
- tickets

## User Roles

### ADMIN

Administrators can access the Admin Dashboard and view system-wide ticket and user information.

### EMPLOYEE

Employees can create and view their own support tickets.

## How to Run

1. Import the project into Eclipse.
2. Configure Apache Tomcat 11.
3. Create a MySQL database named `smartdesk`.
4. Create the required `users` and `tickets` tables.
5. Add MySQL Connector/J to the project.
6. Configure your MySQL username and password in `DBConnection.java`.
7. Run the project using Apache Tomcat.
8. Open the application in a web browser.

## Sample Admin Account

Email:

`admin@smartdesk.com`

Password:
password

## Future Enhancements

- Ticket Assignment
- Ticket Status Updates
- Search and Filtering
- Email Notifications
- Password Encryption
- Advanced Reports
- Production Deployment
