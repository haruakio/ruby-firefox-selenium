FROM selenium/standalone-firefox

RUN sudo apt update && \
sudo apt install -y software-properties-common && \
sudo add-apt-repository -y ppa:brightbox/ruby-ng-experimental && \
sudo apt update && \
sudo apt install -y build-essential patch zlib1g-dev liblzma-dev git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs 
# ruby2.4-dev ruby2.4 && \
USER root
ENV ruby_ver="2.5.1"
RUN curl -O http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-${ruby_ver}.tar.gz && \
    tar -zxvf ruby-${ruby_ver}.tar.gz && \
    cd ruby-${ruby_ver} && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-${ruby_ver} ruby-${ruby_ver}.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrc
RUN gem install bundler
RUN curl -L -o geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.20.0/geckodriver-v0.20.0-linux64.tar.gz && \
tar -xvzf geckodriver.tar.gz && \
chmod +x geckodriver && \
mv geckodriver /usr/local/bin && \
rm geckodriver.tar.gz

RUN export DISPLAY=:99.0 && \
start-stop-daemon --start --quiet --pidfile /tmp/xvfb_99.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -screen 0 1024x768x24 -ac +extension GLX +render -noreset && \
sleep 3


