# GIS and Geospatial Data Analysis

## Software Setup

For geospatial data analysis, we will require a basic python environment with a number of specific packages that will be loaded when necessary. Please follow the instructions in this [document](../01_setup.pdf). 


```
conda create -n GEO -c conda-forge --strict-channel-priority python=3.10 osmnx jupyter
conda activate GEO

conda install geopandas=0.14.4
conda install datashader
conda install contextily==1.1.0
conda install esda 
pip install h3
conda install rtree plotly pydeck 
conda install rioxarray spreg
conda install statsmodels

jupyter lab
.
.
.
conda deactivate
```


## Basic Course

This material is considered to be a pre-requisite for the ML-PREP project.

- Connect geographic locations to data records, using `pandas` and `geopandas` for effective data manipulation and visualization.
- Techniques of spatial analytics: geocoding, spatial indexing.
- Explore both vector and raster data.



## Advanced Course

Advanced topics: (Geospatial Data Science)

- spatial networks,
- geospatial statistics combined with machine learning.