FROM mcr.microsoft.com/devcontainers/java:17

# Install Maven
ARG MAVEN_VERSION=3.9.6
RUN su vscode -c "umask 0002 && . /usr/local/sdkman/bin/sdkman-init.sh && sdk install maven \"${MAVEN_VERSION}\""

# Install Tomcat
ARG TOMCAT_VERSION=9.0.85
RUN mkdir -p /opt/tomcat
WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && tar xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat --strip-components=1 \
    && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

# Set Tomcat environment variables
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# Create Tomcat user
RUN groupadd -r tomcat && \
    useradd -r -g tomcat -d $CATALINA_HOME -s /bin/false tomcat && \
    chown -R tomcat:tomcat $CATALINA_HOME

EXPOSE 8080