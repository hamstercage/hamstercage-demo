FROM nginx

RUN apt update && apt install -y python3 python3-pip && pip install hamstercage && apt clean

COPY entrypoint.sh /

WORKDIR /hamstercage-demo

ENTRYPOINT [ "/entrypoint.sh" ]
