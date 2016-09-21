FROM ruby:2.3

WORKDIR /tmp

RUN apt-get update

RUN apt-get install -y python3-dev libzmq3-dev python3-pip
RUN pip3 install 'ipython[notebook]'

ADD Gemfile /tmp
ADD daru-plotly.gemspec /tmp
RUN mkdir -p /tmp/lib/daru
ADD lib/daru/version.rb /tmp/lib/daru
RUN apt-get install -y libtool-bin uuid-dev
RUN bundle install

RUN apt-get install -y vim
WORKDIR /root
EXPOSE 8888
CMD iruby notebook --ip 0.0.0.0
