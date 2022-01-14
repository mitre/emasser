# Buld from ruby 2.7.5 image
FROM ruby:2.7.5

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
VOLUME ["/emasser"]

# Copy - source (.) destination (.)
COPY . .

# Don't install development or test dependencies
RUN bundle config set without 'development test'
# Install dependency
RUN gem install bundler -v '2.3.5'
RUN bundle install

ENTRYPOINT ["bundle", "exec", "exe/emasser"]

CMD ["-h"]
