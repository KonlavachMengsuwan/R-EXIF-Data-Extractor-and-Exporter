# Load necessary libraries
library(exifr)
library(writexl)

# List of folders and corresponding filenames
folders <- list(
  "Corridor_1_1" = ".../Thermo Pins/Corridor 1 Pins-20240827T074137Z-001/Corridor 1 Pins/Corridor 1",
  "Corridor_1_2" = ".../Thermo Pins/Corridor 1 Pins-20240827T074137Z-001/Corridor 1 Pins/Corridor 1_2",
  "Corridor_2_1" = ".../Thermo Pins/Corridor 2 Pins-20240827T074219Z-001/Corridor 2 Pins/Corridor 2",
  "Corridor_2_2" = ".../Thermo Pins/Corridor 2 Pins-20240827T074219Z-001/Corridor 2 Pins/Corridor 2_2",
  "Corridor_4_1" = ".../Thermo Pins/Corridor 4 Pins-20240827T074307Z-001/Corridor 4 Pins/Corridor 4",
  "Corridor_4_2" = ".../Thermo Pins/Corridor 4 Pins-20240827T074307Z-001/Corridor 4 Pins/Corridor 4_2",
  "Corridor_5_1" = ".../Thermo Pins/Corridor 5 Pins-20240827T075212Z-001/Corridor 5 Pins/Corridor 5",
  "Corridor_5_2" = ".../Thermo Pins/Corridor 5 Pins-20240827T075212Z-001/Corridor 5 Pins/Corridor 5_2",
  "Corridor_7_1" = ".../Thermo Pins/Corridor 7 Pins-20240827T075238Z-001/Corridor 7 Pins/Corridor 7",
  "Corridor_7_2" = ".../Thermo Pins/Corridor 7 Pins-20240827T075238Z-001/Corridor 7 Pins/Corridor 7_2"
)

# Base directory to save the output files
output_dir <- ".../Thermo Pins"

# Loop through each folder and process the EXIF data
for (name in names(folders)) {
  
  # Get the folder path
  folder_path <- folders[[name]]
  
  # Read EXIF data from all JPG files in the directory
  exif_data <- read_exif(list.files(folder_path, pattern = "\\.JPG$", full.names = TRUE))
  
  # Select the specified columns
  selected_columns <- exif_data[, c("GPSAltitude", "GPSLatitude", "GPSLongitude", 
                                    "FOV", "FocalLength35efl", "GPSPosition", 
                                    "HyperfocalDistance", "ExposureTime", "ShutterSpeedValue",
                                    "GPSMapDatum", "ImageSource", "AbsoluteAltitude", 
                                    "RelativeAltitude", "GimbalYawDegree", 
                                    "GimbalPitchDegree", "FlightXSpeed", 
                                    "FlightYSpeed", "FlightZSpeed", "FileSize",
                                    "FileName", "Make", "Model", "FNumber", 
                                    "ImageWidth", "ImageHeight")]
  
  # Define the output file paths
  output_csv <- file.path(output_dir, paste0(name, ".csv"))
  output_excel <- file.path(output_dir, paste0(name, ".xlsx"))
  
  # Write the selected EXIF data to a CSV file
  write.csv(selected_columns, output_csv, row.names = FALSE)
  
  # Write the selected EXIF data to an Excel file
  write_xlsx(selected_columns, output_excel)
  
  # Notify user of completion for each folder
  cat("Processed and exported EXIF data for", name, "\n")
}

cat("All folders have been processed and files exported to", output_dir)
