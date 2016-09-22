FROM ruby:2.3

WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y vim

RUN apt-get install -y python3-dev libzmq3-dev python3-pip
RUN pip3 install 'ipython[notebook]'

RUN apt-get install -y libtool-bin uuid-dev
ADD Gemfile /tmp
ADD daru_plotting_plotly.gemspec /tmp
RUN mkdir -p /tmp/lib/daru_plotting_plotly
ADD lib/daru_plotting_plotly/version.rb /tmp/lib/daru_plotting_plotly
RUN bundle install

WORKDIR /root
EXPOSE 8888
CMD iruby notebook --ip 0.0.0.0
