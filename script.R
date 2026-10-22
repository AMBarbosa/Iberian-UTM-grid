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


# the code below downloads a low-resolution world countries map
# then selects Portugal and Spain:

countries <- geodata::world(path = tempdir())

ptes_lowres <- terra::subset(countries, countries$NAME_0 %in% (c("Portugal", "Spain")))

terra::plot(ptes_lowres, y = "NAME_0", lwd = 0.5)


# the code below downloads the Portugal and Spain outlines with higher resolution:

ptes_hires <- geodata::gadm(country = c("Portugal", "Spain"), path = tempdir())

terra::lines(ptes_hires, col = "royalblue", lwd = 0.5)


# the code below loads a function to extract the mainland part, i.e. the Iberian Peninsula:

source("https://raw.githubusercontent.com/AMBarbosa/unpackaged/refs/heads/master/selectLargest")

iberia_lowres <- selectLargest(ptes_lowres, dissolve = TRUE)

iberia_hires <- selectLargest(ptes_hires, dissolve = TRUE)


terra::plot(iberia_lowres, lwd = 0.5, border = "grey", ext = c(-10, -8, 42, 44))

terra::lines(iberia_hires, lwd = 0.3, col = "darkblue")


# next, the UTM grids are joined and selected / cropped with the Iberian Peninsula:

utmib_full_lowres <- terra::subset(utm2932, iberia_lowres)

utmib_crop_lowres <- terra::crop(utm2932, iberia_lowres)


terra::plot(utmib_full_lowres, lwd = 0.1)

terra::polys(utmib_crop_lowres, lwd = 0.1, col = "darkblue")


utmib_full_hires <- terra::subset(utm2932, iberia_hires)

utmib_crop_hires <- terra::crop(utm2932, iberia_hires)


terra::plot(utmib_full_hires, lwd = 0.1)

terra::polys(utmib_crop_hires, lwd = 0.1, col = "darkblue")

nrow(utmib_full_lowres)
nrow(utmib_full_hires)

nrow(utmib_crop_lowres)
nrow(utmib_crop_hires)


# finally, the output UTM grids are exported:

terra::writeVector(utmib_full_lowres, "utm10_ib_full_lowres.fgb", filetype = "FlatGeobuf", overwrite = TRUE)
terra::writeVector(utmib_crop_lowres, "utm10_ib_crop_lowres.fgb", filetype = "FlatGeobuf", overwrite = TRUE)

terra::writeVector(utmib_full_hires, "utm10_ib_full_hires.fgb", filetype = "FlatGeobuf", overwrite = TRUE)
terra::writeVector(utmib_crop_hires, "utm10_ib_crop_hires.fgb", filetype = "FlatGeobuf", overwrite = TRUE)
