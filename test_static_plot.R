# stand alone static map example
# remotes::install_github("vlizbe/imis")
# remotes::install_github("lifewatch/eurobis")

library(eurobis)
library(ggplot2)
library('rnaturalearth')

world <- ne_countries(scale = "medium", returnclass = "sf")
points <- getEurobisPoints(aphiaid = 107451)

plot_points <- ggplot() +
  geom_sf(data = world) +
  geom_sf(data = points, color = 'red') +
  coord_sf(crs = 3035,
           xlim = c(2426378.0132, 7093974.6215),
           ylim = c(1308101.2618, 5446513.5222)) +
  theme_bw() +
  ggtitle("Eriocheir sinensis",
          subtitle = paste0('AphiaID = ', 107451))

plot_points



grid <- getEurobisGrid(aphiaid = 126436,
                       gridsize = '30m')

plot_grid <- ggplot() +
  geom_sf(data = world) +
  geom_sf(data = grid, aes(fill = RecordCount), size = 0.05) +
  coord_sf(crs = 3035, xlim = c(2426378.0132, 7093974.6215), ylim = c(1308101.2618, 5446513.5222)) +
  scale_fill_viridis_c(alpha = 0.8) +
  theme_bw() +
  ggtitle('Gadus morhua',
          subtitle = paste0('AphiaID = ', '126436'))

plot_grid
