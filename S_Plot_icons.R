# Script that shows how to add the icons to a dataframe in order to use them as
# points OR add them in a specified location on the plot

# Set-up -----------------------------------------------------------------------
### Load Libraries -------------------------------------------------------------
# Vector of the librarys used
libraries_used <- c("tidyverse", "ggimage", "patchwork", "tibble")

# Identify if any missing packages
missing_packages <- libraries_used[!(libraries_used %in% installed.packages()[,"Package"])]

# Install the missing ones
if(length(missing_packages)) {
  install.packages(missing_packages)
}

# Load all required packages
invisible(lapply(libraries_used, library, character.only = TRUE))

### Load in the functions ------------------------------------------------------
source("f_check_missing_icons.R")

### Load the Icon data ---------------------------------------------------------
# Set the species of interest - use the 4 letter codes
sp_int <- c("HUWH", "MIWH", "SEWH", "NARW")

# Check all the icons are available
f_check_missing_icons(sp_int)

# Create a data table that has the icon saved in the image file
species_emoji <- tibble(
  spp = sp_int,
  image = paste0("Cetacean_plotting_icons/", sp_int, ".png")
)

# You can use this as a look up table to add the images to any dataframe so can 
# then use them to plot in ggplot

# Example ----------------------------------------------------------------------
## Create the data -------------------------------------------------------------
# Create a dataframe that has information you want to plot
n <- 10
spp <- rep(sp_int, each=n)
year <- rep(2023:(2023+n-1), length(sp_int))
age <- rpois(length(spp), lambda = 5)

df <- data.frame(spp = spp,
                 year = factor(year),
                 age = age)

# Need to ensure there is a spp column in your df so can left join
df <- df %>% 
  left_join(species_emoji, by = "spp")

## 1. Using icons as points ----------------------------------------------------
# You need to do a main plot and then do a legend plot separetly so that the 
# legend has the icons in

# Main plot
main_plot <- ggplot(df)+
  # this plots the icons as the points
  geom_image(aes(x = year, y = age, image = image))+ 
  theme_bw()

# Create the legend
legend_df <- df %>%
  select(spp, image) %>%
  distinct() %>%
  mutate(x = 0, y = desc(row_number()))

legend_plot <- ggplot(legend_df, aes(x = x, y = y)) +
  geom_image(aes(image = image), size = 0.1) +
  geom_text(aes(label = spp), hjust = -1.2) +
  theme_void() +
  theme(legend.position = "none")+
  ggtitle("Species")+ 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 14))

# Plot them together
main_plot + legend_plot + 
  # set the proportions for the plot and legend
  plot_layout(ncol = 2, widths = c(4, 1)) 

## 2. Adding the icons to facets -----------------------------------------------

ggplot(df)+
  geom_point(aes(x = year, y = age))+
  # adds to top left corner change the x and y to change the location
  # change the size to change the image size
  geom_image(aes(x = "2032", y = 9, image = image), size = 0.25)+ 
  # set the y limit to be 1 more than the image position to ensure it all fits
  ylim(min(age), 9+1)+
  facet_wrap(~ spp)+
  ggtitle("Ages of 4 baleen species through time")+
  theme_bw()+
  theme(plot.title =  element_text( hjust = 0.5))
