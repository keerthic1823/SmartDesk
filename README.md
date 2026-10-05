# SmartDesk 2.0
IT Service Desk & Incident Management System built with Java 25, Jakarta Servlets, JSP, JDBC, MySQL, Apache Tomcat 11 and Bootstrap 5.

## Highlights
- Role-based Employee/Admin access
- Ticket lifecycle: OPEN → ASSIGNED → IN_PROGRESS → RESOLVED → CLOSED
- Ticket assignment
- Search and filters
- Ticket comments
- Ticket history foundation
- Responsive Bootstrap UI
- Dashboard cards, progress visualizations, carousel and responsive CSS

## Architecture
JSP → Servlet → Service → DAO → JDBC → MySQL

## Setup
1. Run `database/smartdesk.sql`.
2. Configure MySQL credentials in `DBConnection.java`.
3. Add MySQL Connector/J to `WEB-INF/lib`.
4. Deploy on Tomcat 11.
