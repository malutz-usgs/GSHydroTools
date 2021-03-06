\name{plotBaseflow}
\alias{plotBaseflow}
\title{Plot baseflow/event plot}
\usage{
plotBaseflow(sampleDates, Daily, INFO, site, HYSEPReturn,
  baseflowColumns = "flowConditionHYSEP_localMin",
  HYSEPcolNames = "LocalMin", xlabel = TRUE, showLegend = TRUE,
  plotTitle = TRUE, instantFlow = NA, whatDischarge)
}
\arguments{
  \item{sampleDates}{dataframe with two columns
  "Discharge_cubic_feet_per_second" and "maxSampleTime"}

  \item{Daily}{dataframe from getDVData function in the
  dataRetrieval package}

  \item{INFO}{dataframe from getMetaData function in
  dataRetrieval package. Alternatively, a dataframe with a
  column "station.nm"}

  \item{site}{string USGS site identification}

  \item{baseflowColumns}{string. Names of columns in the
  sampleDates dataframe with "Baseflow" or "Event"
  indicators.}

  \item{HYSEPReturn}{dataframe with one column Dates, and
  at least 1 column of baseflow}

  \item{HYSEPcolNames}{string. Name of column in
  HYSEPReturn.}

  \item{xlabel}{logical. Whether or not to print x label}

  \item{showLegend}{logical. Whether or not to print
  legend}

  \item{plotTitle}{logical. Whether or not to print title}

  \item{instantFlow}{dataframe returned from
  retrieveUnitNWISData. If none available, NA.}

  \item{whatDischarge}{dataframe returned from
  getDataAvailability}
}
\description{
Plot output of flow, with daily and instantaneous flow
(when available).
}
\examples{
site <- "04085427"
sampleDates <- sampleDates
Start_extend <- as.character(as.Date(min(sampleDates$ActivityStartDateGiven, na.rm=TRUE))-60)
End_extend <- as.character(as.Date(max(sampleDates$ActivityStartDateGiven, na.rm=TRUE))+60)
Daily <- getDVData(site,'00060', Start_extend, End_extend,convert=FALSE)
sampleDates <- findSampleQ(site, sampleDates, Daily)
startEnd <- getMaxStartEnd(Daily)
Start <- startEnd$Start
End <- startEnd$End
naFreeDaily <- Daily[!is.na(Daily$Q),]
INFO <- getSiteFileData(site)
DA_mi <- as.numeric(INFO$drain.area.va)
HYSEPReturn <- exampleHYSEP
sampleDates <- determineHYSEPEvents(HYSEPReturn, sampleDates,0.8)
whatDischarge <- getDataAvailability(site)
whatDischarge <-  whatDischarge[whatDischarge$parameter_cd == "00060", ]
Start <- as.character(as.Date(min(sampleDates$ActivityStartDateGiven, na.rm=TRUE)))
End <- as.character(as.Date(max(sampleDates$ActivityStartDateGiven, na.rm=TRUE)))

if ("uv" \%in\% whatDischarge$service){
  if(whatDischarge$startDate[whatDischarge$service == "uv"] < End){
    instantFlow <- retrieveUnitNWISData(site,"00060",Start,End)
    instantFlow <- renameColumns(instantFlow)
    instantFlow$dateTime <- as.POSIXct(strptime(instantFlow$dateTime, format="\%Y-\%m-\%d \%H:\%M:\%S"), tz="UTC")
  }
}
plotBaseflow(sampleDates,Daily,INFO,site,HYSEPReturn,
             baseflowColumns="flowConditionHYSEP_localMin",
             HYSEPcolNames = "LocalMin",plotTitle=TRUE,
             instantFlow=instantFlow,whatDischarge=whatDischarge,xlabel=FALSE)
}

