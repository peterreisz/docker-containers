FROM openjdk:8u102-jre
MAINTAINER Peter Reisz <peter@reisz.tk>

RUN wget https://download.jetbrains.com/charisma/youtrack-6.5.17105.jar

EXPOSE 8080

VOLUME ["/root/teamsysdata"]

CMD ["java", "-Xmx1g", "-jar", "youtrack-6.5.17105.jar", "8080"]

#docker run -it --rm -p 8080:8080 -v $PWD/data:/root/teamsysdata peterreisz/youtrack