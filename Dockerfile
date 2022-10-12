FROM tomcat:9
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/
# Take the war and copy to webapps of tomcat
COPY target/newapp.war /usr/local/tomcat/webapps/
