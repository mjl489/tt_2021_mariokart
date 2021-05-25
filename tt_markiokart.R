# data
records <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-05-25/records.csv')
drivers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-05-25/drivers.csv')

# libraries
library(tidyverse)
library(dplyr)
library(png)
library(jpg)
library(magick)
library(grid)
library(gridExtra)
library(ggimage)

#sortdata. Rainbow road is my nemesis, so lets look at that.
threelapsrainbow <- filter(records, track == "Rainbow Road" & type == "Three Lap")

# add image as icon for point
threelapsrainbow = threelapsrainbow %>% mutate(star = "https://static.wikia.nocookie.net/ultimatepopculture/images/8/8a/New_Super_Mario_Bros._U_Deluxe_Super_Star.png/revision/latest?cb=20190920204221")

#set background image
backgroundrainbow <- image_read("https://www.wallpaperup.com/uploads/wallpapers/2014/04/01/318535/025b1b0063cd6848976ced7026bd6f31-1000.jpg") 

#plot geom_point, facet wrap shortcut
mainplot <- ggplot(threelapsrainbow, aes(x= date, y = time, image = star))  + facet_wrap(~shortcut) + ylab("Time (seconds)") + xlab("Date record set") + labs(title = "Time well spent - Records for Fastest Three Lap Race on Rainbow Road",
                                                                                                                                                              subtitle = "Plots arranged by whether a shortcut was used",
                                                                                                                                                              caption = "Data source: github.com/benediktclaus") + theme_classic() + theme(plot.background = element_rect(fill = "grey")) +  annotation_custom(rasterGrob(backgroundrainbow,width = unit(1,"npc"),height = unit(1,"npc")), -Inf, Inf, -Inf, Inf) + geom_point() + geom_image(aes(image = star))
#plot it
mainplot