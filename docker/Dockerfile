FROM nginx

RUN sh -c 'mkdir -p ~/.config/pip; printf "[global]\nbreak-system-packages = true" >~/.config/pip/pip.conf'
RUN apt update && apt install -y python3 python3-pip joe git && pip install hamstercage && apt clean

COPY entrypoint.sh /

WORKDIR /hamstercage-demo

ENTRYPOINT [ "/entrypoint.sh" ]
