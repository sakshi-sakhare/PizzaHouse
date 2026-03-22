@echo off
REM PizzaHouse Build Script for Windows
REM This script builds the WAR file for Tomcat 10.1

echo.
echo ========================================
echo  PizzaHouse Project Builder
echo ========================================
echo.

REM Check if Maven is installed
where mvn >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Maven is not installed or not in PATH
    echo Please install Maven 3.8+ from https://maven.apache.org/download.cgi
    echo And add Maven bin directory to your system PATH
    pause
    exit /b 1
)

REM Check if Java is installed
where java >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install Java 11+ from https://www.oracle.com/java/technologies/javase-downloads.html
    pause
    exit /b 1
)

echo Versions detected:
java -version
mvn -version

echo.
echo Building PizzaHouse...
echo.

REM Clean and package
mvn clean package -DskipTests

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo  BUILD SUCCESSFUL!
    echo ========================================
    echo.
    echo WAR file location: target\pizzahouse.war
    echo.
    echo To deploy to Tomcat 10.1:
    echo 1. Copy target\pizzahouse.war to %%TOMCAT_HOME%%\webapps\
    echo 2. Restart Tomcat
    echo 3. Access application at http://localhost:8080/pizzahouse
    echo.
) else (
    echo.
    echo ========================================
    echo  BUILD FAILED!
    echo ========================================
    echo.
    echo Please check the errors above and review:
    echo - Java version (must be 11 or higher)
    echo - Maven configuration
    echo - Project source files
    echo.
    pause
    exit /b 1
)

REM Optionally open file explorer to target directory
if exist "target" (
    echo Opening target directory...
    start "" "target"
)
