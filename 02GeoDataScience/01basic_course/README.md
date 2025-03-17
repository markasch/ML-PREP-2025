## Basic Course

This material is considered to be a pre-requisite for the ML-PREP project and for the advanced training to follow. The objectives are to become acquainted with GIS tools and techniques:

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
7. [Lecture 7](geostatistics/01_geostat_intro.pdf) - *Introduction to Geostatistics* - review the fundamental tools of geostatistics, including random variables and fields, variograms and kriging.
   - Intro  [Notebook](geostatistics/01geostat_INTRO.ipynb)
   - Kriging [Notebook](geostatistics/02geostat_KRIGING.ipynb)
 

**Exercises**

At the end of each Notebooks 1 to 6, there are exercises to perform.

**NOTE**

- Notebook 5 (Raster Data) requires downloading the clipped data file:  [clipped data](https://www.dropbox.com/scl/fi/cmfxrxh2vjebrfmh8zbu3/clipped_raster_europe.tif?rlkey=vx2uu7gqyo6gc19yucl2dtwrw&dl=0).
- Lecture 7 and its notebooks have some advanced material that will be reviewed in the Advanced Course.