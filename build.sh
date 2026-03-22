#!/bin/bash
# PizzaHouse Build Script for Linux/Mac
# This script builds the WAR file for Tomcat 10.1

echo ""
echo "========================================"
echo " PizzaHouse Project Builder"
echo "========================================"
echo ""

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "ERROR: Maven is not installed or not in PATH"
    echo "Please install Maven 3.8+ from https://maven.apache.org/download.cgi"
    exit 1
fi

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "ERROR: Java is not installed or not in PATH"
    echo "Please install Java 11+ from https://www.oracle.com/java/technologies/javase-downloads.html"
    exit 1
fi

echo "Versions detected:"
java -version
mvn -version

echo ""
echo "Building PizzaHouse..."
echo ""

# Clean and package
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo " BUILD SUCCESSFUL!"
    echo "========================================"
    echo ""
    echo "WAR file location: target/pizzahouse.war"
    echo ""
    echo "To deploy to Tomcat 10.1:"
    echo "1. Copy target/pizzahouse.war to \$TOMCAT_HOME/webapps/"
    echo "2. Restart Tomcat"
    echo "3. Access application at http://localhost:8080/pizzahouse"
    echo ""
else
    echo ""
    echo "========================================"
    echo " BUILD FAILED!"
    echo "========================================"
    echo ""
    echo "Please check the errors above and review:"
    echo "- Java version (must be 11 or higher)"
    echo "- Maven configuration"
    echo "- Project source files"
    echo ""
    exit 1
fi

# Open target directory if on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    open target/
fi
