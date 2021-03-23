ARG         nodever=13.8-alpine

FROM        node:$nodever

RUN         adduser -u 7777 -D cytube    

RUN         apk update && \
            apk add git python3 make gcc g++ ffmpeg && \
            cd /home/cytube && \
            git clone -b 3.0 https://github.com/calzoneman/sync && \
            chown -R cytube:cytube /home/cytube/sync && \
            su -l cytube -c 'cd /home/cytube/sync; npm install' && \
            apk del git python3 make gcc g++

USER        cytube
WORKDIR     /home/cytube/sync

CMD         [ "node", "index.js" ]