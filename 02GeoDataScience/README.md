# GIS and Geospatial Data Analysis

## Software Setup

For geospatial data analysis, we will require a basic python environment with a number of specific packages that will be loaded when necessary. Please follow the general instructions in this [document](../01_setup.pdf), and the following specific instructions. You can change the name `geo_env` to aything you might prefer.


```
conda create -n geo_env 
conda activate geo_env

conda config --env --add channels conda-forge
conda config --env --set channel_priority strict

conda install python=3 geopandas geodatasets
conda install plotly rasterio osmnx contextily
conda install jupyter

jupyter lab
.
.
.
conda deactivate
```

A more simple approach is to download and use the [environment.yml](environment.yml) file as follows:

```
conda env create -f environment.yml
conda activate geo_env

jupyter lab
.
.
.
conda deactivate

```

**NOTE:** You can change the name of the environment from `geo_env` to anything you prefer, by simply modifying the first line of [environment.yml](environment.yml). 

## Basic Course

This material is considered to be a pre-requisite for the ML-PREP project and for the advanced training to follow. The objectices are to become acquainted with GIS tools and techniques:

- Connect geographic locations to data records, using `pandas` and `geopandas` for effective data manipulation and visualization.
- Learn techniques of spatial analytics: geocoding, spatial indexing.
- Explore both vector and raster data.

The following lessons are provided:

0.  [Notebook 0](notebook_00_geodata.ipynb) - *Data* - loading vector data with `geopandas`
1.  [Notebook 1](notebook_01_geometries.ipynb) - *Geometries* -  use the powerful `shapely` library for creating, manipulating, and analyzing geometric objects.
2.  [Notebook 2](notebook_02_geopandas.ipynb) -  *Vector Data* -load vector data and learn to use the Python library `geopandas`, an extension of the popular data manipulation library `pandas`, combined with `shapely`'s geometry processing capabilities.
3. [Notebook 3](notebook_03_visualization.ipynb) - *Visualizing Geospatial Data* - use `matplotlib` together with `geopandas`to create detailed, engaging, and insightful geospatial visualizations that can be applied to a wide range of data analysis tasks
4. [Notebook 4](notebook_04_map_projections.ipynb) - *Map Projections* - overview of map projections and how to effectively manage CRS (coordinate reference systems) in geospatial projects, ensuring that spatial analyses and visualizations are both accurate and meaningful.
5. [Notebook 5](notebook_05_raster_data.ipynb) - *Raster Data* - explore techniques and tools in Python to handle large raster datasets. Clipped data file:  [clipped data](https://www.dropbox.com/scl/fi/cmfxrxh2vjebrfmh8zbu3/clipped_raster_europe.tif?rlkey=vx2uu7gqyo6gc19yucl2dtwrw&dl=0).
6. [Notebook 6](notebook_06_osm.ipynb) - *Introduction to OpenStreetMap Data* - download and visualize different types of OpenStreetMap data.
7. [Lecture 7](geostatistics/01_geostat.pdf) - *Introduction to Geostatistics* - review the fundamental tools of geostatistics, including variograms and kriging.


**Exercises**

At the end of each notebook, there are exercises to perform.

**NOTE**

- Notebook 5 (Raster Data) requires downloading the clipped data file:  [clipped data](https://www.dropbox.com/scl/fi/cmfxrxh2vjebrfmh8zbu3/clipped_raster_europe.tif?rlkey=vx2uu7gqyo6gc19yucl2dtwrw&dl=0).
- Lecture 7 has some advanced material that will be reviewed in the Advanced Course.

## Advanced Course

Advanced topics: (Geospatial Data Science)

- advanced geostatistics,
- spatial networks,
- geospatial statistics combined with machine learning,
- examples and applications

The material for this part will be available shortly.

