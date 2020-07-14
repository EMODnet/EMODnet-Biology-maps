# stand alone static map example
# remotes::install_github("vlizbe/imis")
# remotes::install_github("lifewatch/eurobis")

library(eurobis)
library(ggplot2)
library('rnaturalearth')
library(magick)

# Show countries
world <- ne_countries(scale = "medium", returnclass = "sf")

# EMODnet colors
emodnetColor <- list(
  # First palette
  blue = "#0A71B4",
  yellow = "#F8B334",
  darkgrey = "#333333",
  # Secondary palette,
  darkblue = "#012E58",
  lightblue = "#61AADF",
  white = "#FFFFFF",
  lightgrey = "#F9F9F9"
)

# EMODnet logo
logo_raw <- image_read("https://www.emodnet-biology.eu/sites/emodnet-biology.eu/files/public/logos/logo-footer.png") 

# Example 1: Points map
points <- getEurobisPoints(aphiaid = 107451)

plot_points <- ggplot() +
  geom_sf(data = world, 
          fill = emodnetColor$darkgrey, 
          color = emodnetColor$lightgrey, 
          size = 0.1) +
  geom_sf(data = points, 
          color = emodnetColor$yellow) +
  coord_sf(crs = 3035,
           xlim = c(2426378.0132, 7093974.6215),
           ylim = c(1308101.2618, 5446513.5222)) +
  ggtitle("Eriocheir sinensis",
          subtitle = paste0('AphiaID ', 107451)) +
  theme(
    panel.background = element_rect(fill = emodnetColor$lightgrey),
    plot.title = element_text(color= emodnetColor$darkgrey, size = 14, face="bold.italic", hjust = 0.5),
    plot.subtitle = element_text(color= emodnetColor$darkgrey, face="bold", size=10, hjust = 0.5)
  )

# Inspect plot
plot_points

# Save plot
ggsave(filename = file.path("maps", "map1.png"),
       width = 198.4375, height = 121.70833333, dpi = 300, units = "mm")
# Add emodnet logo
plot <- image_read(file.path("maps", "map1.png"))
logo <- logo_raw %>% image_scale("200")
final_plot <- image_composite(plot, logo, gravity = "northeast", offset = "+500+220")
image_write(final_plot, file.path("maps", "map1.png"))


# Example2: Grid map
grid <- getEurobisGrid(aphiaid = 126436, gridsize = '30m')

plot_grid <- ggplot() +
  geom_sf(data = world, 
          fill = emodnetColor$darkgrey, 
          color = emodnetColor$lightgrey, 
          size = 0.1) +
  geom_sf(data = grid, aes(fill = RecordCount), size = 0.05) +
  coord_sf(crs = 3035, xlim = c(2426378.0132, 7093974.6215), ylim = c(1308101.2618, 5446513.5222)) +
  scale_fill_viridis_c(alpha = 0.8) +
  ggtitle('Gadus morhua',
          subtitle = paste0('AphiaID ', '126436')) +
  theme(
    panel.background = element_rect(fill = emodnetColor$lightgrey),
    plot.title = element_text(color= emodnetColor$darkgrey, size = 14, face="bold.italic", hjust = 0.5),
    plot.subtitle = element_text(color= emodnetColor$darkgrey, face="bold", size=10, hjust = 0.5)
  )

# Inspect plot
plot_grid

# Save plot
ggsave(filename = file.path("maps", "map2.png"),
       width = 198.4375, height = 121.70833333, dpi = 300, units = "mm")

# Add emodnet logo
plot <- image_read(file.path("maps", "map2.png"))
logo <- logo_raw %>% image_scale("200")
final_plot <- image_composite(plot, logo, gravity = "northeast", offset = "+680+220")
image_write(final_plot, file.path("maps", "map2.png"))