# GIS and Geospatial Data Analysis

## Software Setup

For geospatial data analysis, we will require a basic python environment with a number of specific packages that will be loaded when necessary. Please follow the general instructions in this [document](../01_setup.pdf), and the following specific instructions.


```
conda create -n GEO -c conda-forge --strict-channel-priority python=3.10 osmnx jupyter
conda activate GEO

conda install geopandas=0.14.4
conda install datashader
conda install contextily==1.1.0
conda install plotly
(conda install esda)  - not needed  for Basic course!
(pip install h3) - not needed  for Basic course!
(conda install rtree pydeck) - not needed for Basic course! 
(conda install rioxarray spreg) - not needed for Basic course!
conda install statsmodels

jupyter lab
.
.
.
conda deactivate
```


## Basic Course

This material is considered to be a pre-requisite for the ML-PREP project and for the advanced training to follow. The objectices are to become acquainted with GIS tools and techniques:

- Connect geographic locations to data records, using `pandas` and `geopandas` for effective data manipulation and visualization.
- Learn techniques of spatial analytics: geocoding, spatial indexing.
- Explore both vector and raster data.

The following lessons are availabel:

1.  [Notebook 1](notebook1/) - *Geometries* -  use the powerful `shapely` library for creating, manipulating, and analyzing geometric objects.
2.  [Notebook 2](notebook2/) -  *Vector Data* -load vector data and learn to use the Python library `geopandas`, an extension of the popular data manipulation library `pandas`, combined with `shapely`'s geometry processing capabilities.
3. [Notebook 3](notebook3/) - *Visualizing Geospatial Data* - use `matplotmib` together with `geopandas`to create detailed, engaging, and insightful geospatial visualizations that can be applied to a wide range of data analysis tasks
4. [Notebook 4](notebook4/) - *Map Projections* - overview of map projections and how to effectively manage CRS (coordinate reference systems) in geospatial projects, ensuring that spatial analyses and visualizations are both accurate and meaningful.
5. [Notebook 5](notebook5/) - *Raster Data* - explore techniques and tools in Python to handle large raster datasets.
6. [Notebook 6](notebook6/) - *Introduction to OpenStreetMap Data* - download and visualize different types of OpenStreetMap data.


**Exercises**

At the end of each notebook, there is one or more exercises to perform.

** NOTE **

Notebook 5 (Raster Data) requires downloading the clipped data file:  [clipped data](https://www.dropbox.com/scl/fi/cmfxrxh2vjebrfmh8zbu3/clipped_raster_europe.tif?rlkey=vx2uu7gqyo6gc19yucl2dtwrw&dl=0).

## Advanced Course

Advanced topics: (Geospatial Data Science)

- spatial networks,
- geospatial statistics combined with machine learning,
- examples and applications

