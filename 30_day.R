library(sf)
library(tidyverse)
library(tmap)
library(tmaptools)
library(conflicted)
library(mapview)
library(remotes)

install_github("r-tmap/tmap")

conflicts_prefer(dplyr::filter())

ch <- st_read("/Users/dabanto/Downloads/kontur_boundaries_CH_20220407.gpkg")

wat_ch <- st_read("/Users/dabanto/Downloads/export(7).geojson")

zuri <- ch %>% filter(name_en == "Zurich" & admin_level == 4)

zuri_wat <- st_filter(wat_ch, zuri)

#mapview(list(zuri, zuri_wat))


ger <- st_read("/Users/dabanto/Downloads/kontur_boundaries_DE_20220407.gpkg(1)")

ber <- ger %>% filter(name_en == "Berlin")

wat_ber <- st_read("/Users/dabanto/Downloads/export(6).geojson")

ber_wat <- st_filter(wat_ber, ber)

#mapview(list(ber, ber_wat))

tmap::providers$CartoDB.Positron

map_swiss <- tm_basemap("Esri.WorldGrayCanvas") + 
  tm_shape(zuri) +
  tm_borders()
map_swiss

map_swiss_wat <- map_swiss  +
  tm_shape(zuri_wat) +
  tm_dots(size = 0.2) +
  tm_scalebar(breaks = c(0, 5, 10), text.size = 1) +
  tm_credits("n = 2846, Data: OpenStreetMap, Basemap: Esri",
             position = c("LEFT", "BOTTOM")) +
  tm_title_in("Drinking Fountains in Zürich", position = tm_pos_in("left", "top"))



map_berlin <- tm_basemap("Esri.WorldGrayCanvas") + 
  tm_shape(ber) +
  tm_borders()


map_berlin_wat <- map_berlin  +
  tm_shape(ber_wat) +
  tm_dots(size = 0.2) +
  tm_scalebar(breaks = c(0, 5, 10), text.size = 1) +
  tm_credits("n = 223, Data: OpenStreetMap, Basemap: Esri",
             position = c("LEFT", "BOTTOM")) +
  tm_title_in("Drinking Fountains in Berlin", position = tm_pos_in("left", "top"))



fin <- tmap_arrange(map_swiss_wat, map_berlin_wat)
fin


tmap_save(fin, "/Users/dabanto/Downloads/water_f.png", dpi = 600)






