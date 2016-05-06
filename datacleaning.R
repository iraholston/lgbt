---
  title: "LGBT Rights"
author: "Ryan Burge"
date: "April 22, 2016"
output: html_document
---
  
library(ggplot2)
library(foreign)
library(dplyr)
library(Rcolorbrewer)
library(XML)
library(rvest)

setwd("D:/")

ideo <- read.csv("state_ideo.csv", stringsAsFactors = FALSE)
lgbt <- read.csv("lgbt.csv", stringsAsFactors = FALSE)
census <- read.dta("relcensus.dta", convert.factors = FALSE)

df2 <- aggregate(census$evanrate, list(census$stname), mean, na.rm = TRUE)

stateFromLower <-function(x) {
  #read 52 state codes into local variable [includes DC (Washington D.C. and PR (Puerto Rico)]
  st.codes<-data.frame(
    state=as.factor(c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA",
                      "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME",
                      "MI", "MN", "MO", "MS",  "MT", "NC", "ND", "NE", "NH", "NJ", "NM",
                      "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN",
                      "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY")),
    full=as.factor(c("alaska","alabama","arkansas","arizona","california","colorado",
                     "connecticut","district of columbia","delaware","florida","georgia",
                     "hawaii","iowa","idaho","illinois","indiana","kansas","kentucky",
                     "louisiana","massachusetts","maryland","maine","michigan","minnesota",
                     "missouri","mississippi","montana","north carolina","north dakota",
                     "nebraska","new hampshire","new jersey","new mexico","nevada",
                     "new york","ohio","oklahoma","oregon","pennsylvania","puerto rico",
                     "rhode island","south carolina","south dakota","tennessee","texas",
                     "utah","virginia","vermont","washington","wisconsin",
                     "west virginia","wyoming"))
  )
  #create an nx1 data.frame of state codes from source column
  st.x<-data.frame(state=x)
  #match source codes with codes from 'st.codes' local variable and use to return the full state name
  refac.x<-st.codes$full[match(st.x$state,st.codes$state)]
  #return the full state names in the same order in which they appeared in the original source
  return(refac.x)
  
}

lgbt$statename<-stateFromLower(lgbt$state)
df2$statename <- tolower(df2$Group.1)
df <- merge(lgbt, df2, by=c("statename"))
ideo <- subset(ideo, year==2014)
ideo$statename <- tolower(ideo$statename)

df3 <- merge(df, ideo, by=c("statename"))
df <- select(df3, statename, state.x, orientation, identity, overall, totalpop, popper, inst6014_nom, x)
df$ideology <- df$inst6014_nom
df$evanrate <- df$x
df$inst6014_nom <- NULL
df$x <- NULL

elect <- read.csv("D:/lgbt/elec12.csv", stringsAsFactors = FALSE)

elect$obama <- gsub(',', '', elect$obama)
elect$romney <- gsub(',', '', elect$romney)
elect$others <- gsub(',', '', elect$others)
elect$total <- gsub(',', '', elect$total)
elect$obama <- as.numeric(elect$obama)
elect$romney <- as.numeric(elect$romney)
elect$others <- as.numeric(elect$others)
elect$total <- as.numeric(elect$total)
elect$obama_share <- elect$obama/elect$total
elect$romney_share <- elect$romney/elect$total

elect <- elect[-c(9),]
elect <- select(elect, obama_share, romney_share)
df <- cbind(df, elect)

html = read_html("https://en.wikipedia.org/wiki/List_of_U.S._states_by_African-American_population")
aa = html_table(html_nodes(html, "table")[[3]])

aa$percent_AA <- aa$`% African-American`
aa$percent_AA <- as.numeric(sub("%", "", aa$percent_AA))

aa <- select(aa, percent_AA)

df <- cbind(df, aa)

html = read_html("https://en.wikipedia.org/wiki/List_of_U.S._states_by_Hispanic_and_Latino_population")
hisp = html_table(html_nodes(html, "table")[[4]])
hisp$percent_hisp<-hisp$`2012`
hisp <- hisp[-c(1),]
hisp <- hisp[-c(9),]
hisp <- hisp[-c(51),]

hisp <- select(hisp, percent_hisp)
hisp$percent_hisp <- as.numeric(sub("%", "", hisp$percent_hisp))

df <- cbind(df, hisp)

