FROM tomcat:9-jdk11

# Installer Apache ODE (war) dans Tomcat
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/* \
  && curl -fSL https://archive.apache.org/dist/ode/apache-ode-war-1.3.8.zip -o /tmp/ode.zip \
  && unzip -q /tmp/ode.zip -d /tmp/ode \
  && unzip -q /tmp/ode/apache-ode-war-1.3.8/ode.war -d /usr/local/tomcat/webapps/ode \
  && curl -fSL https://repo1.maven.org/maven2/xalan/serializer/2.7.1/serializer-2.7.1.jar -o /usr/local/tomcat/webapps/ode/WEB-INF/lib/serializer-2.7.1.jar \
  && rm -rf /tmp/ode /tmp/ode.zip

# Dossier de déploiement des processus ODE (monté via volume)
RUN mkdir -p /usr/local/tomcat/webapps/ode/WEB-INF/processes

# Expose Tomcat/ODE
EXPOSE 8080

# Démarrage Tomcat
CMD ["catalina.sh", "run"]
