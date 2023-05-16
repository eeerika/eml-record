library(EML)
library(emld)

# Starting our EML Record

# Set title

title <- "Observed value data set for: Developing a Geospatial Model for Kelp Forest Cultivation and Restoration, Santa Barbara Channel, 2014-2022"

# Describing the coverage (geographic and temporal)

geographicDescription <- "Santa Barbara Channel, Santa Barbara, California, United States"

coverage <- 
  set_coverage(begin = '2014-01-01', end = '2022-12-31',
               geographicDescription = geographicDescription,
               west = -120.65, east = -118.8, 
               north = 34.59, south = 33.85)

# Set methods file

methods_file <- "./methods.md"
methods <- set_methods(methods_file)

# Create parties

egg <- list(
  individualName = list(
    givenName = "Erika",
    surName = "Egg"),
  electronicMailAddress = "egg@bren.ucsb.edu")

french <- list(
  individualName = list(
    givenName = "Jessica",
    surName = "French"),
  electronicMailAddress = "jfrench@bren.ucsb.edu")

patron <- list(
  individualName = list(
    givenName = "Javier",
    surName = "Patrón"),
  electronicMailAddress = "jpatron@bren.ucsb.edu")

windschitl <- list(
  individualName = list(
    givenName = "Elke",
    surName = "Windschitl"),
  electronicMailAddress = "elke@bren.ucsb.edu")

# Set creators

creator <-
  list(
    egg, french, patron, windschitl
  )

# Create publisher

publisher <- "University of California, Santa Barbara"

# Create contact section

contact <-
  list(
    list(
      individualName = egg$individualName,
      electronicMailAddress = egg$electronicMailAddress,
      organizationName = "University of California, Santa Barbara"),
    list(
      individualName = french$individualName,
      electronicMailAddress = french$electronicMailAddress,
      organizationName = "University of California, Santa Barbara"),
    list(
      individualName = patron$individualName,
      electronicMailAddress = patron$electronicMailAddress,
      organizationName = "University of California, Santa Barbara"),
    list(
      individualName = windschitl$individualName,
      electronicMailAddress = windschitl$electronicMailAddress,
      organizationName = "University of California, Santa Barbara")
  )

# Set keywords

keywordSet <- list(     
  list(
    keyword = list("kelp",
                   "geospatial",
                   "cultivation",
                   "restoration",
                   "coast",
                   "ocean",
                   "nutrients",
                   "sea surface temperature",
                   "depth")
  ))

# Set publication date

pubDate <- "2023"


# Set abstract file

abstract_file <-  "./abstract.md"
abstract <- set_TextType(abstract_file)

# Set licensing and rights

intellectualRights <- "Creative Commons Attribution 4.0 International License"

# Create attribute table

attributes <- tibble::tribble(
  ~attributeName,    ~attributeDefinition,                                                                                           ~formatString,   ~definition, ~unit,                ~measurementScale, ~numberType,
  "lat",             "latitude of the original observation",                                                                         NA,              NA,          "degree",            "interval",         "real",
  "lon",             "longitude of the original observation",                                                                        NA,              NA,          "degree",            "interval",         "real",
  "year",            "year of the observation",                                                                                      "YYYY",          NA,          NA,                  "dateTime",         NA,
  "quarter",         "quarter that the observation was made in",                                                                     NA,              NA,          "dimensionless",     "ratio",            "whole",
  "temp",            "sea surface temperature from the nutrients data set: observed values that were measured out on the water",     NA,              NA,          "celsius",           "interval",         "real",
  "nitrate",         "observed nitrate value",                                                                                       NA,              NA,          "micromolePerLiter", "ratio",            "real",
  "nitrite",         "observed nitrite value",                                                                                       NA,              NA,          "micromolePerLiter", "ratio",            "real",
  "nitrate_nitrite", "observed nitrate_nitrite value",                                                                               NA,              NA,          "micromolePerLiter", "ratio",            "real",
  "phosphate",       "observed phosphate value",                                                                                     NA,              NA,          "micromolePerLiter", "ratio",            "real",
  "ammonium",        "observed ammonium or ammonia value",                                                                           NA,              NA,          "micromolePerLiter", "ratio",            "real",
  "sst",             "remotely sensed sea surface temperature from GRHSST.",                                                         NA,              NA,          "celsius",           "interval",         "real",
  "nutrient_source", "the source of the original observation for nutrients",                                                         NA,              "Any text",  NA,                  "nominal",          NA,
  "depth",           "depth measurement of the raster cell that the point intersects",                                               NA,              NA,          "meter",             "ratio",            "real",
  "kelp_area",       "kelp area measurement of the raster cell that the point intersects",                                           NA,              NA,          "meterSquared",      "ratio",            "whole",
  "kelp_biomass",    "kelp biomass of the raster cell that the point intersects",                                                    NA,              NA,          "kilogram",          "ratio",            "whole"
)    


attributeList <- set_attributes(attributes, col_classes = 
                                  c("numeric", "numeric", "Date", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "character", "numeric", "numeric", "numeric"))

# Set physical

physical <- set_physical("synthesized_dataset.csv")


# Assemble the dataTable

dataTable <- list(
  entityName = "synthesized_dataset.csv",
  entityDescription = "CSV containing observed point values for nutrients and SST, with depth and kelp area/biomass corresponding to the raster cell that the point intersects.",
  physical = physical,
  attributeList = attributeList)

dataset <- list(
  title = title,
  creator = creator,
  pubDate = pubDate,
  intellectualRights = intellectualRights,
  abstract = abstract,
  keywordSet = keywordSet,
  coverage = coverage,
  contact = contact,
  methods = methods,
  dataTable = dataTable)

eml <- list(
  packageId = uuid::UUIDgenerate(),
  system = "uuid", # type of identifier - Universally Unique Identifiers
  dataset = dataset)


# Write eml and check if valid

write_eml(eml, "kelpgeomod.xml")
eml_validate("kelpgeomod.xml")


# Get the JSON file for easier queries in R and linked data 

f <- "kelpgeomod.xml"
emld <- as_emld(f)
json <- as_json(emld)


json_kelpgeomod <- "kelpgeomod.json"
as_json(emld, json_kelpgeomod)

write(json_kelpgeomod)