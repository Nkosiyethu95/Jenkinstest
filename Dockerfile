# Use the official Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root to install packages
USER root

# Install latest Java (already included but ensure latest JDK), Python 3, and pip
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Optional: Set environment variables (not strictly necessary)
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
# Switch back to the Jenkins user (security best practice)
USER jenkins
