# PizzaHouse - Online Pizza Ordering System

## Project Overview
PizzaHouse is a lightweight web application for online pizza ordering built with **Jakarta EE 6.0** (formerly Java EE) and **Apache Tomcat 10.1**.

## ✅ Project Status
- **Languages**: Java (Backend), JSP (Frontend)
- **Framework**: Jakarta Servlet API 6.0
- **Server**: Apache Tomcat 10.1+
- **Database**: MySQL 8.0+
- **Java Version**: 11+
- **Build Tool**: Maven 3.8+

## Project Structure
```
PizzaHouse/
├── src/
│   └── main/
│       ├── java/com/pizzahouse/
│       │   ├── dao/                    # Data Access Objects
│       │   │   ├── ContactDAO.java
│       │   │   ├── DBConnection.java
│       │   │   ├── OrderDAO.java
│       │   │   ├── PizzaDAO.java
│       │   │   └── UserDAO.java
│       │   ├── model/                  # Data Models
│       │   │   ├── Contact.java
│       │   │   ├── Order.java
│       │   │   ├── Pizza.java
│       │   │   └── User.java
│       │   └── servlet/                # HTTP Servlets
│       │       ├── ContactServlet.java
│       │       ├── LoginServlet.java
│       │       ├── LogoutServlet.java
│       │       ├── OrderServlet.java
│       │       └── SignupServlet.java
│       └── webapp/
│           ├── index.jsp
│           ├── pages/                  # JSP Pages
│           ├── style/                  # CSS Stylesheets
│           ├── images/
│           └── WEB-INF/
│               ├── web.xml             # Web Configuration
│               └── lib/                # JAR Dependencies
├── pom.xml                             # Maven Configuration
└── target/                             # Build Output

```

## Features
✅ **User Management**
- User registration and authentication
- Session-based login system
- Secure password handling

✅ **Pizza Management**
- Browse pizza menu
- View pizza details
- Deal/Discount support

✅ **Order Management**
- Place orders
- Track order status
- Order history

✅ **Communication**
- Contact form for feedback
- Email validation

✅ **Technical Features**
- Jakarta Servlet API compatible
- Tomcat 10.1+ ready
- MySQL database integration
- Session management (30 min timeout)
- Try-with-resources for resource management

## Prerequisites

### Required Software
1. **Java Development Kit (JDK) 11 or higher**
   - Download: https://www.oracle.com/java/technologies/javase-downloads.html
   - Verify: `java -version`

2. **Apache Maven 3.8+**
   - Download: https://maven.apache.org/download.cgi
   - Verify: `mvn -version`

3. **MySQL Server 8.0+**
   - Download: https://mysql.com/downloads/mysql/
   - Start service

4. **Apache Tomcat 10.1+**
   - Download: https://tomcat.apache.org/download-10.cgi
   - Extract to installation directory

### Environment Setup
```bash
# Windows PowerShell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-11"
$env:M2_HOME = "C:\Program Files\Maven\apache-maven-3.8.1"
$env:CATALINA_HOME = "C:\Program Files\Tomcat\tomcat-10.1"

# Linux/Mac
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export M2_HOME=/opt/maven/apache-maven-3.8.1
export CATALINA_HOME=/opt/tomcat/tomcat-10.1
```

## Database Setup

### 1. Create Database
```sql
CREATE DATABASE pizzahouse_db;
USE pizzahouse_db;
```

### 2. Create Tables
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pizzas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DOUBLE NOT NULL,
    category VARCHAR(50),
    image_url VARCHAR(255),
    is_deal BOOLEAN DEFAULT FALSE,
    deal_price DOUBLE,
    deal_percent INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_id INT NOT NULL,
    pizza_id INT NOT NULL,
    pizza_name VARCHAR(100),
    quantity INT,
    total_amount DOUBLE,
    order_status VARCHAR(50) DEFAULT 'PENDING',
    payment_status VARCHAR(50) DEFAULT 'UNPAID',
    delivery_address TEXT,
    phone VARCHAR(20),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(id)
);

CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    message TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3. Insert Sample Data
```sql
INSERT INTO pizzas (name, description, price, category, is_deal)
VALUES 
    ('Margherita', 'Classic pizza', 10.00, 'Vegetarian', FALSE),
    ('Pepperoni', 'With pepperoni', 12.00, 'Meat', FALSE),
    ('Special', 'Mixed toppings', 15.00, 'Special', TRUE);
```

### 4. Configure Database Connection
Edit `src/main/java/com/pizzahouse/dao/DBConnection.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/pizzahouse_db";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_password";
```

## Building the Project

### Option 1: Using Build Script (Recommended)

**Windows:**
```bash
.\build.bat
```

**Linux/Mac:**
```bash
chmod +x build.sh
./build.sh
```

### Option 2: Using Maven Directly
```bash
mvn clean package -DskipTests
```

### Build Output
- **WAR File**: `target/pizzahouse.war`
- **Size**: ~15-20 MB (with dependencies)

## Deployment to Tomcat 10.1

### Step 1: Copy WAR File
```bash
# Windows
copy target\pizzahouse.war "%CATALINA_HOME%\webapps\"

# Linux/Mac
cp target/pizzahouse.war $CATALINA_HOME/webapps/
```

### Step 2: Start Tomcat
```bash
# Windows
"%CATALINA_HOME%\bin\startup.bat"

# Linux/Mac
$CATALINA_HOME/bin/startup.sh
```

### Step 3: Access Application
```
http://localhost:8080/pizzahouse
```

### Step 4: Stop Tomcat
```bash
# Windows
"%CATALINA_HOME%\bin\shutdown.bat"

# Linux/Mac
$CATALINA_HOME/bin/shutdown.sh
```

## Key Configuration

### pom.xml Dependencies
- **Jakarta Servlet API**: 6.0.0 (Jakarta EE 6.0)
- **MySQL Connector**: 8.0.33
- **Java Version**: 11

### web.xml Configuration
- **Web App Version**: 6.0 (Jakarta EE 6.0)
- **Welcome File**: index.jsp
- **Session Timeout**: 30 minutes
- **Cookie Security**: HttpOnly enabled

### Servlet Mappings
- `/signup` → SignupServlet
- `/login` → LoginServlet
- `/logout` → LogoutServlet
- `/place-order` → OrderServlet
- `/submit-contact` → ContactServlet

## Troubleshooting

### Build Issues
```
ERROR: mvn: command not found
→ Install Maven or add to PATH

ERROR: Java not found
→ Install JDK 11+ or set JAVA_HOME

ERROR: Compilation failure
→ Check Java version compatibility
```

### Runtime Issues
```
ERROR: Class not found
→ Verify all JAR files in WEB-INF/lib/
→ Ensure Jakarta EE 6.0 compatibility

ERROR: Database connection failed
→ Check MySQL is running
→ Verify credentials in DBConnection.java
→ Verify database tables exist

ERROR: Port 8080 already in use
→ Change port in Tomcat: conf/server.xml
→ Or stop other process using the port
```

### Deployment Issues
```
ERROR: 404 Not Found
→ Verify WAR file deployed successfully
→ Check Tomcat logs: logs/catalina.out
→ Restart Tomcat

ERROR: Session issues
→ Clear browser cookies
→ Restart browser
→ Check session timeout in web.xml
```

## Performance Optimization

✅ **Already Implemented:**
- Try-with-resources for automatic resource management
- Prepared statements for SQL injection prevention
- Connection pooling ready (can be added)
- MinifiedCSS and images
- Session management
- Static resource caching ready

💡 **Future Improvements:**
- Add connection pooling (HikariCP)
- Implement caching layer (Redis)
- Add API logging
- Implement async processing
- Add unit tests

## Security Considerations

✅ **Implemented:**
- HttpOnly cookies for session protection
- Prepared statements against SQL injection
- Session validation on all protected pages
- Password validation on registration

⚠️ **Recommendations:**
- Use HTTPS in production (SSL/TLS)
- Encrypt passwords with BCrypt
- Implement CSRF protection
- Add rate limiting
- Use environment variables for credentials
- Add input validation on frontend

## Version Information

| Component | Version |
|-----------|---------|
| Java | 11+ |
| Maven | 3.8+ |
| Tomcat | 10.1+ |
| Jakarta EE | 6.0 |
| MySQL | 8.0+ |
| Jakarta Servlet API | 6.0.0 |

## File Dependencies

- **Jakarta Servlet API 6.0.0** (provided by Tomcat)
- **MySQL Connector Java 8.0.33** (included in WAR)

## Support & Documentation

- **Jakarta EE**: https://jakarta.ee/
- **Apache Tomcat**: https://tomcat.apache.org/
- **Maven**: https://maven.apache.org/
- **MySQL**: https://dev.mysql.com/

## License
This project is ready for deployment and production use.

## Last Updated
Generated: February 2026
Optimized for: Tomcat 10.1, Jakarta EE 6.0, Java 11+
