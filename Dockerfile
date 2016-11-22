FROM ubuntu:latest

COPY image /data

CMD ["./data/bin/com.greetings"]
