Our data products were derived from publicly available data sources:

SST: https://podaac.jpl.nasa.gov/dataset/MUR-JPL-L4-GLOB-v4.1?ids=Keywords&values=Oceans:Ocean%20Temperature&provider=POCLOUD 

Depth: 
https://www.ncei.noaa.gov/products/etopo-global-relief-model 

Kelp:
https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.74

Nutrients:
LTER Bottle:	https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.10

LTER Waves: https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.144 

CalCOFI: https://calcofi.org/data/oceanographic-data/bottle-database/ 

USGS:https://www.sciencebase.gov/catalog/item/62a7ac5ad34ec53d2770c81f and https://www.sciencebase.gov/catalog/item/62aa40bad34ec53d277115ce

Plumes and Blooms: http://www.oceancolor.ucsb.edu/plumes_and_blooms/



This link provides a list all files contained in the dataset, with a brief description of their content.

Link: https://docs.google.com/spreadsheets/d/1HR_xrE1kTqQGN9MN0-n7XIuDMotM1v1e56kE6-YUFT4/edit#gid=0



**METHODOLOGICAL INFORMATION**

Description of methods used for collection/generation of data:

See links above and information below on how data were joined.

Methods for processing the data: 

SST: 
1. Use a for loop to create a raster brick that calculates the mean temperature for each quarter. This for loop does:
a. Read in each image. 
b. Convert the temperature values from Kelvin to Celsius. 
c. Stack the images into a raster stack. 
d. Calculate the mean temperature value for each pixel.
2. Create a function that takes the values of the quarters and years of interest. Use the function to create a raster brick with all 36 rasters (4 quarters per 9 years from 2014-2022). 
3. Create a function that splits and categorizes the quarters so that we can calculate the mean temperature for each category.


DEPTH: 
1. Wrangled into a tidy format
2. Filtered to time frame of 2014-2022
3. Mask applied to meet 0.008° x 0.008° spatial resolution, 33.85°- 34.59°N, 118.8°- 120.65°W extent & position, coordinate reference system WGS 84

KELP AREA & BIOMASS:
1. Get area and biomass information from the raw netCDF using a for loop, limiting to our time period and area of interest
2. Generate a data frame with both variables’ information
3. Turn this into a spatial data frame and rasterize area and biomass separately into two rasterStacks
4. Aggregate these two rasterStacks closer to the correct resolution by summing, and then resample so that the mask can be applied
5. Mask applied to meet 0.008° x 0.008° spatial resolution, 33.85°- 34.59°N, 118.8°- 120.65°W extent & position, coordinate reference system WGS 84


NUTRIENTS:
1. Wrangled into a tidy format
2. Filtered to time frame of 2014-2022
3. Joined into one data frame
4. Interpolated using inverse distance weighting with an inverse distance power of 1 and maximum distance parameter of 0.08°  (approx. 10 km)  on phosphate, ammonium, and combined nitrate and nitrite point data.  The scope of interpolation was limited to 5 km off the Santa Barbara Coast to ensure dense enough data coverage.
5. Mask applied to meet 0.008° x 0.008° spatial resolution, 33.85°- 34.59°N, 118.8°- 120.65°W  extent & position, coordinate reference system WGS 84


Instrument- or software-specific information needed to interpret the data: 

R version 4.2.2
RStudio Version: 2023.03.0+386 \"Cherry Blossom\" Release (3c53477afb13ab959aeb5b34df1f10c237b256c3, 2023-03-09) for macOS
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)
AppleWebKit/537.36 (KHTML, like Gecko)
RStudio/2023.03.0+386 
Chrome/108.0.5359.179 
Electron/22.0.3 
Safari/537.36
QGIS Version: 3.28.3-Firenze

R-packages used: 
 [1] naniar_1.0.0    lubridate_1.8.0 terra_1.6-17   
 [4] stars_0.5-6     abind_1.4-5     tmap_3.3-3     
 [7] janitor_2.1.0   raster_3.6-3    sf_1.0-8       
[10] sp_1.6-0        ncdf4_1.21      forcats_0.5.2  
[13] stringr_1.5.0   dplyr_1.1.0     purrr_1.0.1    
[16] readr_2.1.3     tidyr_1.3.0     tibble_3.2.1   
[19] ggplot2_3.4.1   tidyverse_1.3.2


Standards and calibration information, if appropriate: NA


Environmental/experimental conditions: NA



Describe any quality-assurance procedures performed on the data: 
See original data sources for individual quality-assurance procedures.


People involved with sample collection, processing, analysis and/or submission:
See original data sources for individual sample collection information. For data retrieval and synthesis, the following were involved:
Erika Egg (UCSB)
Jessica French (UCSB)
Javier Patron (UCSB)
Elke Windschitl (UCSB)
