FROM ruby:2.5

# the base ruby image is based off of debian + utilities which include wget
RUN wget -O /usr/local/share/ca-certificates/MITRE-BA-Root.crt http://pki.mitre.org/MITRE%20BA%20Root.crt
RUN wget -O /usr/local/share/ca-certificates/MITRE-BA-NPE-CA-3.crt http://pki.mitre.org/MITRE%20BA%20NPE%20CA-3(1).crt
RUN update-ca-certificates

WORKDIR /emasser

COPY . .

RUN bundle install

ENTRYPOINT ["bundle", "exec", "exe/emasser"]
CMD ["-h"]
