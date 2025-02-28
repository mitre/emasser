# Buld from ruby 2.7.5 image
FROM ruby:3.2.5 as build

LABEL name="emasser" \
      vendor="MITRE" \
      version="${EMASSER_VERSION}" \
      release="1" \
      url="https://github.com/mitre/emasser" \
      description="Emasser is a command-line interface (CLI) that aims to automate routine business use-cases and provide utility surrounding the Enterprise Mission Assurance Support Service (eMASS) by leveraging its representational state transfer (REST) application programming interface (API)." \
      docs="https://mitre.github.io/emasser/" \
      run="docker run -d --name ${NAME} ${IMAGE} <args>"

# Set the base directory that will be used from now on
WORKDIR /emasser

# Install dependency (old bundler was 2.3.5)
RUN gem install bundler -v '2.6.5'
RUN apt update && apt install -y build-essential
COPY . .
RUN bundle install
# WORKDIR /emasser/emass_client/ruby_client
# RUN gem build emass_client.gemspec
WORKDIR /emasser
RUN gem build emasser.gemspec
RUN mkdir gems
# RUN mv emass_client/ruby_client/emass_client*.gem gems/emass_client.gem
RUN mv emasser*.gem gems/emasser.gem


# FROM ruby:2-alpine
# Updated to ruby:3-alpine
FROM ruby:3-alpine

# Use the line below when testing creating the container locally
# RUN sed -i 's/https/http/g' /etc/apk/repositories
COPY --from=build /emasser/gems /emass-gems

# RUN apk add build-base libcurl && gem install /emass-gems/emass_client.gem && gem install /emass-gems/emasser.gem
RUN apk add build-base libcurl && gem install /emass-gems/emasser.gem

VOLUME [ "/data" ]
WORKDIR /data

ENTRYPOINT ["emasser"]

CMD ["-h"]
