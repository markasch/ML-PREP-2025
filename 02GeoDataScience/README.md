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

1. *Geometries* - [Notebook 1](notebook1/) - use the powerful `shapely` library for creating, manipulating, and analyzing geometric objects.
2. *Vector Data* - [Notebook 2](notebook2/) - load vector data and learn to use the Python library `geopandas`, an extension of the popular data manipulation library `pandas`, combined with `shapely`'s geometry processing capabilities.
3. *Visualizing Geospatial Data* - [Notebook 3](notebook3/) - use `matplotmib` together with `geopandas`to create detailed, engaging, and insightful geospatial visualizations that can be applied to a wide range of data analysis tasks
4. *Map Projections* - [Notebook 4](notebook4/) - overview of map projections and how to effectively manage CRS (coordinate reference systems) in geospatial projects, ensuring that spatial analyses and visualizations are both accurate and meaningful.
5. *Raster Data* - [Notebook 5](notebook5/) - explore techniques and tools in Python to handle large raster datasets.
6. *Introduction to OpenStreetMap Data* - [Notebook 6](notebook6/) - download and visualize different types of OpenStreetMap data.


**Exercises**

At the end of each notebook, there is one or more exercises to perform.



## Advanced Course

Advanced topics: (Geospatial Data Science)

- spatial networks,
- geospatial statistics combined with machine learning,
- examples and applications

