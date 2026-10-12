#!/bin/sh

# s6-overlay v3 работает только первым процессом контейнера (pid 1): запущенный в фоне /init
# сразу завершается, и службы образа (Xvfb и другие) не стартуют. Поэтому jenkins-agent
# запускается основной командой s6-overlay: сначала поднимаются службы, затем агент,
# а когда агент завершается, s6-overlay останавливает контейнер.
if [ -f "/init" ]; then
    exec /init /usr/local/bin/jenkins-agent "$@"
fi

exec /usr/local/bin/jenkins-agent "$@"
