my_theme <- function() {
  # Define colors for the chart
  palette <- brewer.pal("Greys", n=9)
  color.background = palette[2]
  color.grid.major = palette[4]
  color.panel = palette[3]
  color.axis.text = palette[9]
  color.axis.title = palette[9]
  color.title = palette[9]
  # Create basic construction of chart
  theme_bw(base_size=9, base_family="Georgia") +
    # Set the entire chart region to a light gray color
    theme(panel.background=element_rect(fill=color.panel, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    # Format grid
    theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    theme(axis.ticks=element_blank()) +
    # Format legend
    theme(legend.position="right") +
    theme(legend.background = element_rect(fill=color.panel)) +
    theme(legend.text = element_text(size=10,color=color.axis.title)) +
    # Format title and axes labels these and tick marks
    theme(plot.title=element_text(color=color.title, size=20, vjust=0.5, hjust=0, face="bold")) +
    theme(axis.text.x=element_text(size=10,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=10,color=color.axis.text)) +
    theme(axis.title.x=element_text(size=12,color=color.axis.title, vjust=-1, face="italic")) +
    theme(axis.title.y=element_text(size=12,color=color.axis.title, vjust=1.8, face="italic")) +
    # Plot margins
    theme(plot.margin = unit(c(.5, .5, .5, .5), "cm"))
}

ggplot(df, aes(x=overall, y=evanrate))+
  my_theme()+
  geom_point(shape=1) +
  geom_smooth(method=lm)+
  labs(title= "", x="Support for LGBT Rights", y="Evangelical Adhererence Rate")+
  ggtitle(expression(atop(bold("Evangelicals and LGBT Rights"))))+
  geom_text(aes(label=state.x), vjust=-1, hjust=0.5, size=2)+
  theme(plot.title = element_text(size = 16, face = "bold", colour = "black", vjust = 0.5, hjust=0.5)) + geom_point(data = subset(df, statename == "arizona"), size = 5, colour = "maroon")


reg1 <- lm(overall ~ totalpop + popper + ideology + evanrate, data =df)