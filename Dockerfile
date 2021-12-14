FROM ruby:2.5

WORKDIR /emasser

COPY . .

RUN bundle install

ENTRYPOINT ["bundle", "exec", "exe/emasser"]
CMD ["-h"]
