LABEL maintainer="Combiz Khozoie, Ph.D. FullName@hotmail.com"

FROM rocker/ropensci

RUN apt-get update

# install packages 
RUN apt-get -y install libcurl4-openssl-dev
RUN apt-get -y install libssl-dev
# these next two lines are new
RUN apt-get -y install build-dep
RUN apt-get -y install r-cran-rmpi

RUN R CMD INSTALL Rmpi --configure-args=--with-mpi=/usr/lib/openmpi

## Install extra R packages using requirements.R
## Specify requirements as R install commands e.g.
##  
## install.packages("<myfavouritepacakge>") or
## devtools::install("SymbolixAU/googleway")

COPY ./requirements.R /tmp/requirements.R 
RUN Rscript /tmp/requirements.R

# create an R user
ENV USER rstudio

## uncomment to include shiny server
# #RUN export ADD=shiny && bash /etc/cont-init.d/add

#cleanup
RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds


EXPOSE 8787


CMD ["/usr/lib/rstudio-server/bin/rserver", "--server-daemonize=0", "--server-app-armor-enabled=0"]
