\name{getMaxStartEnd}
\alias{getMaxStartEnd}
\title{Find maximum start and end dates from Daily dataframe}
\usage{
getMaxStartEnd(localDaily)
}
\arguments{
  \item{localDaily}{dataframe returned from dataRetrieval}
}
\value{
named list with Start and End values
}
\description{
Function to find the longest continuous start and end dates
from the Daily dataframe. Primary use case is to find input
value to use in a call to HYSEP (from package DVStats). If
there are gaps in the data, the function will look for the
largest continous gap.
}
\examples{
site <- "04085427"
sampleDates <- sampleDates
Start_extend <- as.character(as.Date(min(sampleDates$ActivityStartDateGiven, na.rm=TRUE))-60)
End_extend <- as.character(as.Date(max(sampleDates$ActivityStartDateGiven, na.rm=TRUE))+60)
Daily <- getDVData(site,'00060', Start_extend, End_extend,convert=FALSE)
startEnd <- getMaxStartEnd(Daily)
Start <- startEnd$Start
End <- startEnd$End
}

