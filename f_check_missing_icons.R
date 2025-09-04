# Function to check the species of interest have icons in the folder
# Takes in:
#   The vector of species
# Returns:
#   Message to explain if all present or not and which are missing


f_check_missing_icons <- function(species_codes, 
                                  icon_folder = "Cetacean_plotting_icons") {
  
  file_paths <- file.path(icon_folder, paste0(species_codes, ".png"))
  
  missing <- file_paths[!file.exists(file_paths)]
  
  if (length(missing) == 0) {
    message("✅ All icons are present.")
    return(invisible(TRUE))
  } else {
    message("❌ Missing the following icon files:")
    print(missing)
    
  }
}