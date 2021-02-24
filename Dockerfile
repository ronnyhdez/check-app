FROM rocker/shiny:4.0.3

RUN apt-get update && apt-get install \
  libcurl4-openssl-dev \
  libv8-dev \
  curl -y \
  libpq-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libxml2-dev

RUN mkdir -p /var/lib/shiny-server/bookmarks/shiny

# Download and install library

RUN R -e 'install.packages("shiny", repos="http://cran.rstudio.com")'
RUN R -e 'install.packages("tm", repos="http://cran.rstudio.com")'
RUN R -e 'install.packages("SnowballC", repos="http://cran.rstudio.com")'
RUN R -e 'install.packages("wordcloud", repos="http://cran.rstudio.com")'
RUN R -e 'install.packages("RColorBrewer", repos="http://cran.rstudio.com")'
RUN R -e 'install.packages("shinydashboard", repos="http://cran.rstudio.com")'
RUN R -e 'install.packages("ggplot2", repos="http://cran.rstudio.com")'
RUN R -e 'install.packages("nycflights13", repos="http://cran.rstudio.com")'
RUN R -e 'install.packages("dplyr", repos="http://cran.rstudio.com")'

# copy the app to the image COPY shinyapps /srv/shiny-server/
COPY . /srv/shiny-server/
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

RUN chown shiny:shiny /srv/shiny-server/

EXPOSE 8080

USER shiny

CMD ["/usr/bin/shiny-server"]

