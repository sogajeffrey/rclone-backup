FROM ubuntu:latest

RUN apt update && apt install -y cron fuse wget curl unzip 

# Install rclone
RUN sh -c 'curl -sL https://rclone.org/install.sh | bash -'

ADD backup.sh /backup.sh

ADD init.sh /init.sh

RUN chmod +x /backup.sh

RUN chmod +x /init.sh

ENTRYPOINT [ "/init.sh" ]