FROM continuumio/miniconda3

# JAVA
RUN apt-add-repository ppa:webupd8team/java \
 && apt-get update \
 && apt-get install oracle-java8-installer