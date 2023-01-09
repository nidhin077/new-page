FROM alpine
EXPOSE 80
RUN apk add wget
RUN apk add ca-certificates
RUN apk update && apk add nodejs
RUN apk add npm
RUN apk add yarn
RUN apk add git
COPY oauth2-authorized-users.conf /opt/
RUN git clone https://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@github.com/nidhin077/new-page.git
#RUN cd  new-page/
WORKDIR new-page
RUN npm i
RUN npm run build
RUN cd /opt && wget https://github.com/pusher/oauth2_proxy/releases/download/v3.1.0/oauth2_proxy-v3.1.0.linux-amd64.go1.11.tar.gz
RUN cd /opt && tar -xvf oauth2_proxy-v3.1.0.linux-amd64.go1.11.tar.gz
RUN mv /opt/release/oauth2_proxy-linux-amd64 /bin/oauth2_proxy && rm -rf /opt/oauth2_proxy-v3.1.0.linux-amd64.go1.11.tar.gz /opt/release
CMD /bin/oauth2_proxy -upstream=file:///new-page/build/#/ -http-address=0.0.0.0:80  -authenticated-emails-file=/opt/oauth2-authorized-users.conf \
   -cookie-secure=false -cookie-secret=FNAh5PedsfadUJZc2 -client-id=4cd5ba07ab5e956f443f  -client-secret=91414bab845f671bccff53427652c99b15a3b4a4 \
   -provider=github

