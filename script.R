library(terra)
library(geodata)


# the 'utm' files imported below were previously downloaded
# from a platform that was meanwhile discontinued
# described in the paper "A Geoplatform for improving accessibility to environmental cartography"
# by Pablo Sastre, Pere Roca, Jorge M. Lobo & EDIT co-workers
# https://doi.org/10.1111/j.1365-2699.2008.02070.x

utm2930 <- terra::vect("/home/marcia/Documents/dadosExternos/OGUs/EDIT_geoplatform/utm10_27-32/utm10km-europe-29_30.shp")

utm3132 <- terra::vect("/home/marcia/Documents/dadosExternos/OGUs/EDIT_geoplatform/utm10_27-32/utm10km-europe-31_32.shp")

utm2932 <- utm2930 + utm3132

terra::crs(utm2932)

terra::set.crs(utm2932, "EPSG:4326")

terra::plot(utm2932, "HUSO", lwd = 0.1)


# the code below downloads a world countries map
# then selects Portugal and Spain:

countries <- geodata::world(path = tempdir())

ptes <- terra::subset(countries, countries$NAME_0 %in% (c("Portugal", "Spain")))

terra::plot(ptes, y = "NAME_0", lwd = 0.5)


# the code below loads a function to extract the mainland part, i.e. the Iberian Peninsula:

source("https://raw.githubusercontent.com/AMBarbosa/unpackaged/refs/heads/master/selectLargest")

iberia <- selectLargest(ptes, dissolve = TRUE)

terra::plot(iberia)


# next, the UTM grids are joined and selected / cropped with the Iberian Peninsula:

utmib_full <- terra::subset(utm2932, iberia)

utmib_crop <- terra::crop(utm2932, iberia)

terra::plot(utmib_full, lwd = 0.1)
terra::polys(utmib_crop, lwd = 0.1, col = "darkblue")


# finally, the output UTM grids are exported:

terra::writeVector(utmib_full, "utm10_ib_full.fgb", filetype = "FlatGeobuf")
terra::writeVector(utmib_crop, "utm10_ib_crop.fgb", filetype = "FlatGeobuf")
