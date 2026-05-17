# Use an official Tomcat 11 runtime with JDK 21 support
FROM tomcat:11.0-jdk21-openjdk-slim

# Clean out the default Tomcat sample web apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your exported ROOT.war file directly into Tomcat's webapps directory
COPY ./ROOT.war /usr/local/tomcat/webapps/

# Expose Tomcat's default port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]