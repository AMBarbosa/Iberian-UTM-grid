## UTM 10x10-km^2^ grid of the Iberian Peninsula

This repository contains [FlatGeobuf](https://flatgeobuf.org/) files of UTM 10x10-km^2^ spatial vector grid layers of the Iberian Peninsula, whether or not cropped with a land polygon, as well as the R code used for generating them. The original pre-cropped layers, presented in several separate files jointly covering the entire Europe, were described in the paper "*A Geoplatform for improving accessibility to environmental cartography*" by Pablo Sastre, Pere Roca, Jorge M. Lobo & EDIT co-workers (<https://doi.org/10.1111/j.1365-2699.2008.02070.x>). The maps are in unprojected longitude-latitude coordinates in the WGS84 datum (EPSG:4326).

Please **cite the sources / authors** in any use you make of these materials!

You can import the files directly from this online GitHub repository, e.g.:

```         
library(terra)

utm <- vect("https://github.com/AMBarbosa/Iberian-UTM-grid/raw/refs/heads/main/utm10_ib_crop.fgb")

plot(utm)
```

<img src="https://github.com/user-attachments/assets/571c0a8d-ca4e-48f4-ae85-d26da6f3cd5c" alt="image" width="1197" height="1038"/>
