# Advanced Course

Advanced topics: (Geospatial Data Science)

- advanced geostatistics,
- spatial networks,
- geospatial statistics combined with machine learning,
- examples and applications

The material for this part is under construction, and will be made available progressively.

## Lectures

1. Review of geostatistical theory - [lecture notes](../01basic_course/geostatistics/01_geostat.pdf)
2. Geospatial data analysis and Machine learning  - [lecture notes](./01lectures/02_geostat_ML.pdf)


## Examples

1. Examples of geostatistical theory:
 
   - Intro - [Notebook](../01basic_course/geostatistics/01geostat_INTRO.ipynb)
   - Kriging - [Notebook](../01basic_course/geostatistics/02geostat_KRIGING.ipynb)
   - Kriging + CV - [Notebook](./02examples/08_krige_cv.ipynb)
   - Kriging + ML - [Notebook](./02examples/03geostat_ML.ipynb)
   
2. Raster analysis of slopes and slope stability:

  - Version using `rioxarray` - [notebook](./02examples/03slope_raster.ipynb)
  - Version, generated by LLM, using only `rasterio` - [notebook](./02examples/03slope_raster_DS.ipynb)
  - More detailed raster operations (optional) - [notebooks](./02examples/AutoGIS_Lesson7)


3. Spatial CV:
 
  - Spatial resampling with k-fold clustering - [notebook](./02examples/spatialkfold.ipynb), data [file](./02examples/ames.geojson)

4. Use-cases:

  - Ecuador landslide susceptibility analyis (in R) using spatial CV and spatial tuning: [directory](./02examples/ecuador-landslide), [Rmd file](./02examples/ecuador-landslide/Ecuador-landslides.Rmd)
  - Domestic violence with spatial CV and random forest: [notebook](./02examples/spatialCV/spatialCV_DV.ipynb), [data](./02examples/spatialCV/Data/DV),  [paper](./02examples/spatialCV/2023_GeoAIHandbook_SpatialCV.pdf)
  - Obesity prevalence with spatial CV and MLP neural network: [notebook](./02examples/spatialCV/spatialCV_Obesity.ipynb), [data](./02examples/spatialCV/Data/Obesity),  [paper](./02examples/spatialCV/2023_GeoAIHandbook_SpatialCV.pdf)