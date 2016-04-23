library(choroplethr)
library(choroplethrMaps)
library(viridis)

df$region<-df$statename
df$value <- df$popper

choro = StateChoropleth$new(df)
choro$title = "Percentage of LGBT"
choro$set_num_colors(1)
myPalette <- colorRampPalette(brewer.pal(9, "Reds"))
choro$ggplot_polygon = geom_polygon(aes(fill = value), color = NA)
choro$ggplot_scale = scale_fill_gradientn(name = "Percent", colours = viridis(32))
choro$render()
