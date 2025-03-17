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

See [01basic_course](./01basic_course)


## Advanced Course

See [02advanced_course](./02advanced_course)



