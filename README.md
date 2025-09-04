## Description

This repository contains the cetacean icons and a brief example of how to use them in ggplot to create a couple of different types of plot.

### Cetacean_plotting_icons Folder

Folder that contains the icons saved as .png images using the 4 character codes. There are images for:

ASDO - Atlantic Spotted Dolphin

BODO - Bottlenose Dolphin

FIWH - Fin Whale

GRAM - Risso's Dolphin

HAPO - Harbour Porpoise

HUWH - Humpback Whale

MIWH - Minke Whale

NARW - North Atlantic Right Whale

SADO - Common Dolphin

SEWH - sei Whale

SPWH - Sperm Whale

WSDO - White Sided Dolphin

### f_check_mission_icons.R Function

Function to check that the chosen species have icons in the folder and so can be used.

### S_plot_icons.R Script

Script that loads the required libraries and then loads the cetacean icons into a data frame and shows a couple of options of how to plot them using ggplot.

1.  Option 1 - shows how to use the icons as points on a ggplot.
2.  Option 2 - shows how to add the icons to a location within a faceted ggplot.
