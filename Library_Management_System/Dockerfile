# Downgrade to Tomcat 9 which perfectly supports javax.servlet specifications
FROM tomcat:9.0-jdk11-openjdk-slim

# Clear out default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your ROOT.war file into Tomcat's webapps directory
COPY ./ROOT.war /usr/local/tomcat/webapps/

# Expose Tomcat's default port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]