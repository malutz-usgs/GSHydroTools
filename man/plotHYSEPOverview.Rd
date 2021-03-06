\name{plotHYSEPOverview}
\alias{plotHYSEPOverview}
\title{Plot 3 baseflow/event plots from hysep output}
\usage{
plotHYSEPOverview(sampleDates, Daily, INFO, site, HYSEPReturn,
  baseflowColumns = c("flowConditionHYSEP_localMin",
  "flowConditionHYSEP_Fixed", "flowConditionHYSEP_Sliding"),
  HYSEPcolNames = c("LocalMin", "Fixed", "Sliding"))
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

  \item{baseflowColumns}{sting vector length of 3. Names of
  columns with "Baseflow" or "Event" indicators.}

  \item{HYSEPReturn}{dataframe with one column Dates, and 3
  columns of baseflow as defined by HYSEPcolNames}

  \item{HYSEPcolNames}{sting vector length of 3. Names of
  columns in HYSEPReturn}
}
\value{
sampleDates dataframe
}
\description{
Plot sliding, fixed, and local_min output of flow, with
daily and instantaneous flow (when available).
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
plotHYSEPOverview(sampleDates,Daily,INFO,site,HYSEPReturn)
}

