X911 <- read.csv("C:/Users/Nishank/Desktop/SNU/RStuff/911.csv", stringsAsFactors = FALSE)
str(X911)
library(tidyverse)
library(ggmap)
library(scales)
library(maps)

X911$date <- lubridate::date(X911$timeStamp)
str(X911$date)
summary(X911$date)
map <- ggmap(get_map("PA"))

ggplot(data = map, mapping = aes(x = lat, y = lng)) + geom_point()
plot(X911$lng,X911$lat)

#Finally got the correct location
map <- get_map(location = "King of Prussia",zoom=10)
str(map)
#ggmap(map) + geom_point(data = X911, mapping = aes(x = lng, y = lat))
table(round(X911$lat,2))
table(round(X911$lng,2))

LatLonCountsPA <- as.data.frame(table(round(X911$lng,2),round(X911$lat,2)))
str(LatLonCountsPA)
LatLonCountsPA <- filter(LatLonCountsPA,Freq>0)
LatLonCountsPA$Long <- as.numeric(as.character(LatLonCountsPA$Var1))
LatLonCountsPA$Lat <- as.numeric(as.character(LatLonCountsPA$Var2))


#LatLonCountsPA <- filter(LatLonCountsPA,Long>0, Lat>0)
#ggmap(map) + geom_point(data = LatLonCountsPA,mapping = aes(x = Long, y = Lat, color = Freq, size = Freq)) + scale_color_gradient(low = "yellow",high = "red")

#using tiles
ggmap(map) + geom_tile(data = LatLonCountsPA, mapping = aes(x = Long, y = Lat, alpha = Freq),fill ="red")



#summary(X911$lat)
#summary(X911$lng)
#plot(X911$lng,X911$lat)
