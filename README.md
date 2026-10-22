This repository contains [FlatGeobuf](https://flatgeobuf.org/) files of the UTM 10x10-km2 spatial vector grid of the Iberian Peninsula, as well as the R code used for generating them, from files described in the paper "*A Geoplatform for improving accessibility to environmental cartography*" by Pablo Sastre, Pere Roca, Jorge M. Lobo & EDIT co-workers (<https://doi.org/10.1111/j.1365-2699.2008.02070.x>).

Please **cite the sources / authors** in any use you make of these materials!
You can import the files directly from this online GitHub repository, e.g.:

```
library(terra)

utm <- vect("https://github.com/AMBarbosa/Iberian-UTM-grid/raw/refs/heads/main/utm10_ib_crop.fgb")

plot(utm)
```
<img width="1197" height="1038" alt="image" src="https://github.com/user-attachments/assets/571c0a8d-ca4e-48f4-ae85-d26da6f3cd5c" />
