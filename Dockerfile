FROM ruby:3.3.6

# add user
RUN useradd developer
# create folder developer
RUN mkdir -p /home/developer
#set folder
WORKDIR /home
#set permissions to folder
RUN chown -R developer:developer developer
RUN chmod 755 developer
# set user
USER developer
# create folder app
RUN mkdir -p /home/developer/app
# use folder app
WORKDIR /home/developer/app
# copy files
COPY ./Gemfile .
# COPY ./Gemfile.lock .
# install gems
RUN bundle install
# copy main app
COPY ./ .
#expose port
EXPOSE 3000
# run server
ENTRYPOINT [ "./entrypoints/docker-entrypoint.sh" ]
