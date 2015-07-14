FROM haskell:7.10.1
MAINTAINER Andy Oakley <ao@ao.vc>

RUN adduser --quiet jenkins
RUN echo "jenkins:jenkins" | chpasswd

RUN apt-get update

RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd

RUN apt-get -y install git
RUN apt-get -y install openjdk-7-jdk

# Create /usr/bin symlinks for all haskell binaries in the opt/.../bin directories 
#RUN for f in `find /opt -type d -name bin`; do find $f -type f -executable -exec sh -c 'ln -s $1 /usr/bin/`basename $1`' _ {} \;; done

RUN echo "export PATH=$PATH" >> /home/jenkins/.profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]