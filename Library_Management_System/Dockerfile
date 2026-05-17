# Use an official Tomcat 11 runtime with JDK 21+ support (Tomcat 11 officially targets modern Java versions)
FROM tomcat:11.0-jdk21-openjdk-slim

# Clean out the default Tomcat sample apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your web source folder into Tomcat's ROOT directory
COPY ./webapp /usr/local/tomcat/webapps/ROOT

# Expose Tomcat's default port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]