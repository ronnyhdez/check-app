FROM rocker/shiny:4.0.3

RUN apt-get update && apt-get install \
  libcurl4-openssl-dev \
  libv8-dev \
  curl -y \
  libpq-dev

RUN mkdir -p /var/lib/shiny-server/bookmarks/shiny

# Download and install library
RUN R -e "install.packages(c('tm', 'SnowballC', 'wordcloud'))"
RUN R -e "install.packages(c('RColorBrewer', 'shiny', 'shinydashboard'))"
RUN R -e "install.packages(c('ggplot2', 'nycflights13', 'dplyr'))"

# copy the app to the image COPY shinyapps /srv/shiny-server/
COPY . /srv/shiny-server/
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# copy the app to the image COPY shinyapps /srv/shiny-server/
COPY . /srv/shiny-server/
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

RUN chown shiny:shiny /srv/shiny-server/

# Fix permissions in case this was deployed from Windows
RUN chmod -R 755 /srv/shiny-server/

EXPOSE 8080

