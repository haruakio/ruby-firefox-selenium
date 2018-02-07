FROM selenium/standalone-firefox

RUN sudo apt update && \
sudo apt install -y software-properties-common && \
sudo add-apt-repository -y ppa:brightbox/ruby-ng-experimental && \
sudo apt update && \
sudo apt install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs ruby2.4 && \
sudo gem install bundler && \
sudo curl -L -o geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz && \
sudo tar -xvzf geckodriver.tar.gz && \
sudo chmod +x geckodriver && \
sudo mv geckodriver /usr/local/bin && \
sudo rm geckodriver.tar.gz

USER root
RUN export DISPLAY=:99.0 && \
start-stop-daemon --start --quiet --pidfile /tmp/xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -screen 0 1024x768x24 -ac +extension GLX +render -noreset && \
sleep 3


