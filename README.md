# mNC
A tool for Oceanographers and Meteorologists to easily create their NetCDF files using Matlab

A tool for Oceanographers and Meteorologists to easily create their NetCDF files using Matlab.



Creates mytest.nc file from one-dimensional arrays of longitude and latitude

lon = [-38.5, -38, -37.5, -37, -36.5, -36, -35.5];

lat = [-1.5, -1, -0.5, 0, 0.5, 1, 1.5];

matlab:

create_NC('mytest.nc', [-38.5:0.5:-35.5], [-1.5:0.5:1.5]);

bash:

ncdump -v lon,lat mytest.nc

Result:

netcdf mytest {

dimensions:

	lon = 7 ;

	lat = 7 ;

variables:

	double lon(lon) ;

		lon:standard_name = "logitude" ;

		lon:long_name = "logitude" ;

		lon:units = "degrees_east" ;

		lon:axis = "X" ;

	double lat(lat) ;

		lat:standard_name = "latitude" ;

		lat:long_name = "latitude" ;

		lat:units = "degrees_north" ;

		lat:axis = "Y" ;


// global attributes:

		:creation_date = "13-Oct-2021 11:34:03" ;

		:Producer = "null text" ;

                :dataType = "2D Grid" ;

		:Comment = "no comments" ;

data:


 lon = -38.5, -38, -37.5, -37, -36.5, -36, -35.5 ;


 lat = -1.5, -1, -0.5, 0, 0.5, 1, 1.5 ;

}




Creates mytest_2.nc file from two-dimensional arrays of longitude and latitude


matlab:


lons = [-38.5, -38, -37.5, -37, -36.5, -36, -35.5];

lats = [-1.5, -1, -0.5, 0, 0.5];

[LATS, LONS] = meshgrid(lats, lons);

create_NC_2DCoordinates('mytest_2.nc', LONS, LATS);



bash:



ncdump -v lon,lat mytest.nc


Result:


netcdf mytest_2 {

dimensions:

	lon = 7 ;

	lat = 5 ;

variables:

	double lon(lat, lon) ;

		lon:standard_name = "longitude" ;

		lon:long_name = "longitude" ;

		lon:units = "degrees_east" ;

		lon:axis = "X" ;

	double lat(lat, lon) ;

		lat:standard_name = "latitude" ;

		lat:long_name = "latitude" ;

		lat:units = "degrees_north" ;

		lat:axis = "Y" ;


// global attributes:

		:creation_date = "13-Oct-2021 11:45:59" ;

		:Producer = "null text" ;

		:dataType = "2D Grid" ;

		:Comment = "no comments" ;


data:


 lon =
  -38.5, -38, -37.5, -37, -36.5, -36, -35.5,
  -38.5, -38, -37.5, -37, -36.5, -36, -35.5,
  -38.5, -38, -37.5, -37, -36.5, -36, -35.5,
  -38.5, -38, -37.5, -37, -36.5, -36, -35.5,
  -38.5, -38, -37.5, -37, -36.5, -36, -35.5 ;


 lat =
  -1.5, -1.5, -1.5, -1.5, -1.5, -1.5, -1.5,
  -1, -1, -1, -1, -1, -1, -1,
  -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5,
  0, 0, 0, 0, 0, 0, 0,
  0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5 ;

}



Inserts a 2D variable in the file mytest_2.nc

Example: a bathymetry where the depth ranges between -100 and -1 m


matlab:


[nLon, nLat] = size(LONS);


BathymetryRange = [-100:-1];

Bath = rand(nLon,nLat) * range(BathymetryRange) + BathymetryRange(1);


insertvariable2D_NC('mytest_2.nc', Bath, 'z', 'Bathymetry', 'Shallow water bathymetry', 'm')


bash:


ncdump -v lon,lat mytest_2.nc


Result:


netcdf mytest_2 {


dimensions:

	lon = 7 ;

	lat = 5 ;

variables:

	double lon(lat, lon) ;

		lon:standard_name = "longitude" ;

		lon:long_name = "longitude" ;

		lon:units = "degrees_east" ;

		lon:axis = "X" ;

	double lat(lat, lon) ;

		lat:standard_name = "latitude" ;

		lat:long_name = "latitude" ;

		lat:units = "degrees_north" ;

		lat:axis = "Y" ;

	double z(lat, lon) ;

		z:standard_name = "Bathymetry" ;

		z:long_name = "Shallow water bathymetry" ;

		z:units = "m" ;

		z:missing_value = NaN ;

		z:FillValue = NaN ;


// global attributes:

		:creation_date = "13-Oct-2021 11:45:59" ;

		:Producer = "null text" ;

		:dataType = "2D Grid" ;

		:Comment = "no comments" ;

data:


 z =
  -18.477674995598, -31.2119663253941, -68.6071514739748, -5.92801716500286,
    -96.589838030212, -56.5643083940166, -62.2257127477922,
  -24.2138379732488, -21.2752097874307, -81.4996121491165, -51.5133248169651,
    -55.886966129621, -36.0150119989848, -29.7728817450508,
  -25.2860184837463, -72.6735173771407, -32.7094349914862, -35.1452976065898,
    -83.9014382157316, -88.2192295257207, -50.6619588537678,
  -4.98534810690798, -66.3018130600528, -42.058492653002, -77.8426179903774,
    -25.6245611287404, -74.7455835695324, -49.9102518851509,
  -30.7914044569881, -11.8005779989559, -5.03014890466102, -45.8256625335835,
    -86.2761801599608, -85.2198934496533, -74.5066828417501 ;

}



Insert a three-dimensional static variable that is depth-dependent


BathymetryRange = [0, 10, 20, 30, 40, 50];


matlab:

BathymetryRange = [0:10:50];

TemperatureRange = [27:0.02:28];

[nLon, nLat] = size(LONS);

nDepth = length(BathymetryRange);

Temp = rand(nLon, nLat, nDepth) * range(TemperatureRange) + TemperatureRange(1);

% The depth values are inserted

insertdepth_NC('mytest_2.nc', BathymetryRange)

insertstaticvariable3D_NC('mytest_2.nc', Temp, 'pottemp', 'potential_temperature', 'Potential Temperature', 'Â°C', 999.99)


bash:


ncdump -v depth,pottemp mytest_2.nc


Result:


netcdf mytest_2 {

dimensions:

	lon = 7 ;

	lat = 5 ;

	depth = 6 ;

variables:

	double lon(lat, lon) ;

		lon:standard_name = "longitude" ;

		lon:long_name = "longitude" ;

		lon:units = "degrees_east" ;

		lon:axis = "X" ;

	double lat(lat, lon) ;

		lat:standard_name = "latitude" ;

		lat:long_name = "latitude" ;

		lat:units = "degrees_north" ;

		lat:axis = "Y" ;

	double z(lat, lon) ;

		z:standard_name = "Bathymetry" ;

		z:long_name = "Shallow water bathymetry" ;

		z:units = "m" ;

		z:missing_value = NaN ;

		z:FillValue = NaN ;

	double depth(depth) ;

		depth:standard_name = "Depth" ;

		depth:long_name = "Vertical axis" ;

		depth:units = "m" ;

		depth:axis = "Z" ;

	double pottemp(depth, lat, lon) ;

		pottemp:standard_name = "potential_temperature" ;

		pottemp:long_name = "Potential Temperature" ;

		pottemp:units = "Â°C" ;

		pottemp:missing_value = 999.99 ;

		pottemp:FillValue = 999.99 ;


// global attributes:

		:creation_date = "13-Oct-2021 11:45:59" ;

		:Producer = "null text" ;

		:dataType = "2D Grid" ;

		:Comment = "no comments" ;

data:


 depth = 0, 10, 20, 30, 40, 50 ;


 pottemp =
  27.8407172559837, 27.2542821789715, 27.8142848260688, 27.243524968725,
    27.9292636231872, 27.3499837659848, 27.1965952504312,
  27.251083857976, 27.6160446761466, 27.4732888489027, 27.351659507063,

  ...

  ...

  ...

    27.3341630527375, 27.6987458323348, 27.1978098266859 ;

}





Insert a three-dimensional dynamic variable that is time-dependent

Time range = Daily data from '2001-05-03' to '1900-01-01'

(The '-' as a field separator in the date is mandatory)

Base time = '1900-01-01'


matlab:


% Daily mean

% Base time '1900-01-01'

timeRange = [datenum('2001-05-03'):datenum('2001-05-21')] - datenum('1900-01-01');

TemperatureRange = [27:0.02:28];

[nLon, nLat] = size(LONS);

nTime = length(timeRange);

Temp = rand(nLon, nLat, nTime) * range(TemperatureRange) + TemperatureRange(1);

inserttime_NC('mytest_2.nc', timeRange, 'days since 1900-01-01');

insertdynamicvariable3D_NC('mytest_2.nc', Temp, 'temp', 'temperature', 'SST', 'Â°C', 999.99)


bash:


ncdump -v temp,time -t mytest_2.nc


Result:


netcdf mytest_2 {

dimensions:

	lon = 7 ;

	lat = 5 ;

	depth = 6 ;

	time = UNLIMITED ; // (19 currently)

variables:

	double lon(lat, lon) ;

		lon:standard_name = "longitude" ;

		lon:long_name = "longitude" ;

		lon:units = "degrees_east" ;

		lon:axis = "X" ;

	double lat(lat, lon) ;

		lat:standard_name = "latitude" ;

		lat:long_name = "latitude" ;

		lat:units = "degrees_north" ;

		lat:axis = "Y" ;

	double z(lat, lon) ;

		z:standard_name = "Bathymetry" ;

		z:long_name = "Shallow water bathymetry" ;

		z:units = "m" ;

		z:missing_value = NaN ;

		z:FillValue = NaN ;

	double depth(depth) ;

		depth:standard_name = "Depth" ;

		depth:long_name = "Vertical axis" ;

		depth:units = "m" ;

		depth:axis = "Z" ;

	double pottemp(depth, lat, lon) ;

		pottemp:standard_name = "potential_temperature" ;

		pottemp:long_name = "Potential Temperature" ;

		pottemp:units = "Â°C" ;

		pottemp:missing_value = 999.99 ;

		pottemp:FillValue = 999.99 ;

	double time(time) ;

		time:standard_name = "time" ;

		time:long_name = "time" ;

		time:units = "days since 1900-01-01" ;

		time:calendar = "standard" ;

		time:axis = "T" ;

	double temp(time, lat, lon) ;

		temp:standard_name = "temperature" ;

		temp:long_name = "SST" ;

		temp:units = "Â°C" ;

		temp:missing_value = 999.99 ;

		temp:FillValue = 999.99 ;


// global attributes:

		:creation_date = "13-Oct-2021 13:46:11" ;

		:Producer = "null text" ;

		:dataType = "2D Grid" ;

		:Comment = "no comments" ;

data:


 time = "2001-05-03", "2001-05-04", "2001-05-05", "2001-05-06", "2001-05-07",
    "2001-05-08", "2001-05-09", "2001-05-10", "2001-05-11", "2001-05-12",
    "2001-05-13", "2001-05-14", "2001-05-15", "2001-05-16", "2001-05-17",
    "2001-05-18", "2001-05-19", "2001-05-20", "2001-05-21" ;


 temp =
  27.3130274882277, 27.0764394578121, 27.7914151469637, 27.3653839792903,
    27.5850993892254, 27.1833367061834, 27.076918942246,
  27.1536627665307, 27.826875990171, 27.3009567426333, 27.3838844900057,

  ...

  ...

  ...

    27.3341630527375, 27.6987458323348, 27.1978098266859 ;

}




Inserting a depth and time dependent variable.

Functions insertdepth_NC and inserttime_NC must be used previously.


matlab:

depthRange = [0:10:50];

timeRange = [datenum('2001-05-03'):datenum('2001-05-21')] - datenum('1900-01-01');

SaltRange = [35.5:0.1:36.5];

[nLon, nLat] = size(LONS);

nDepth = length(depthRange);

nTime = length(timeRange);

Salt = rand(nLon, nLat, nDepth, nTime) * range(SaltRange) + SaltRange(1);

insertdynamicvariable4D_NC('mytest_2.nc', Salt, 'salt', 'SSS', 'Sea Surface Salinity', 'psu', -999.0)


bash:


ncdump -v salt mytest_2.nc


Result:


netcdf mytest_2 {

dimensions:

	lon = 7 ;

	lat = 5 ;

	depth = 6 ;

	time = UNLIMITED ; // (19 currently)

variables:

...

...

...

	double depth(depth) ;

		depth:standard_name = "Depth" ;

		depth:long_name = "Vertical axis" ;

		depth:units = "m" ;

		depth:axis = "Z" ;

	double pottemp(depth, lat, lon) ;

		pottemp:standard_name = "potential_temperature" ;

		pottemp:long_name = "Potential Temperature" ;

		pottemp:units = "Â°C" ;

		pottemp:missing_value = 999.99 ;

		pottemp:FillValue = 999.99 ;

	double time(time) ;

		time:standard_name = "time" ;

		time:long_name = "time" ;

		time:units = "days since 1900-01-01" ;

		time:calendar = "standard" ;

		time:axis = "T" ;

	double temp(time, lat, lon) ;

		temp:standard_name = "temperature" ;

		temp:long_name = "SST" ;

		temp:units = "Â°C" ;

		temp:missing_value = 999.99 ;

		temp:FillValue = 999.99 ;

	double salt(time, depth, lat, lon) ;

		salt:standard_name = "SSS" ;

		salt:long_name = "Sea Surface Salinity" ;

		salt:units = "psu" ;

		salt:missing_value = -999. ;

		salt:FillValue = -999. ;


// global attributes:

                :creation_date = "13-Oct-2021 15:01:43" ;

		:Producer = "null text" ;

		:dataType = "2D Grid" ;

		:Comment = "no comments" ;

}




Insert a time series

To insert a time series the functions inserttime_NC has to be used previously


matlab:

LHF_Range = [-150:10:-80];

timeRange = [datenum('2001-05-03'):datenum('2001-05-21')] - datenum('1900-01-01');

nTime = length(timeRange);

LHF = rand(1, nTime) * range(LHF_Range) + LHF_Range(1);

inserttimeserie_NC('mytest_2.nc', LHF, 'lhf', 'LHF', 'Latent Heat Flux', 'W/m^2', 1.e+20)


bash:


ncdump -v lhf mytest_2.nc


Result:


netcdf mytest_2 {

dimensions:

	lon = 7 ;

	lat = 5 ;

	depth = 6 ;

	time = UNLIMITED ; // (19 currently)

variables:

	double lon(lat, lon) ;

		lon:standard_name = "longitude" ;

		lon:long_name = "longitude" ;

		lon:units = "degrees_east" ;

		lon:axis = "X" ;

	double lat(lat, lon) ;

		lat:standard_name = "latitude" ;

		lat:long_name = "latitude" ;

		lat:units = "degrees_north" ;

		lat:axis = "Y" ;

	double z(lat, lon) ;

		z:standard_name = "Bathymetry" ;

		z:long_name = "Shallow water bathymetry" ;

		z:units = "m" ;

		z:missing_value = NaN ;

		z:FillValue = NaN ;

	double depth(depth) ;

		depth:standard_name = "Depth" ;

		depth:long_name = "Vertical axis" ;

		depth:units = "m" ;

		depth:axis = "Z" ;

	double pottemp(depth, lat, lon) ;

		pottemp:standard_name = "potential_temperature" ;

		pottemp:long_name = "Potential Temperature" ;

		pottemp:units = "Â°C" ;

		pottemp:missing_value = 999.99 ;

		pottemp:FillValue = 999.99 ;

	double time(time) ;

		time:standard_name = "time" ;

		time:long_name = "time" ;

		time:units = "days since 1900-01-01" ;

		time:calendar = "standard" ;

		time:axis = "T" ;

	double temp(time, lat, lon) ;

		temp:standard_name = "temperature" ;

		temp:long_name = "SST" ;

		temp:units = "Â°C" ;

		temp:missing_value = 999.99 ;

		temp:FillValue = 999.99 ;

	double salt(time, depth, lat, lon) ;

		salt:standard_name = "SSS" ;

		salt:long_name = "Sea Surface Salinity" ;

		salt:units = "psu" ;

		salt:missing_value = -999. ;

		salt:FillValue = -999. ;

	double lhf(time) ;

		lhf:standard_name = "LHF" ;

		lhf:long_name = "Latent Heat Flux" ;

		lhf:units = "W/m^2" ;

		lhf:missing_value = 1.e+20 ;

		lhf:FillValue = 1.e+20 ;


// global attributes:

		:creation_date = "13-Oct-2021 15:01:43" ;

		:Producer = "null text" ;

		:dataType = "2D Grid" ;

		:Comment = "no comments" ;

data:


 lhf = -125.379955123903, -123.719684788329, -129.544507133169,
    -126.458305049462, -91.5692549892492, -84.8326305071334,
    -103.772336089214, -93.9690344680875, -129.713354851269,
    -81.3917310092116, -84.5737397899491, -132.297764636527,
    -100.859013831388, -134.095709492856, -100.818057038615,
    -123.932837199952, -96.494980684739, -109.482836080872, -125.736495459038 ;

}





Create a NetCDF file with time series only


matlab:


timeRange = [datenum('2001-05-03'):datenum('2001-05-21')] - datenum('1900-01-01');

createtimeserie_NC('mytest_3.nc', timeRange, '1900-01-01')

SWR_Range = [180:10:250];

LWR_Range = [-100:10:-50];

nTime = length(timeRange);

SWR = rand(1, nTime) * range(SWR_Range) + SWR_Range(1);

LWR = rand(1, nTime) * range(LWR_Range) + LWR_Range(1);

inserttimeserie_NC('mytest_3.nc', SWR, 'swr', 'SWR', 'Short Wave Radiation', 'W/m^2', 1.e+20)

inserttimeserie_NC('mytest_3.nc', LWR, 'lwr', 'LWR', 'Long Wave Radiation', 'W/m^2', 1.e+20)


bash:


ncdump -v lwr,swr,time -t mytest_3.nc


Result:


netcdf mytest_3 {

dimensions:

	time = UNLIMITED ; // (19 currently)

variables:

	double time(time) ;

		time:standard_name = "time" ;

		time:long_name = "time" ;

		time:units = "days since 1900-01-01" ;

		time:calendar = "standard" ;

		time:axis = "T" ;

	double swr(time) ;

		swr:standard_name = "SWR" ;

		swr:long_name = "Short Wave Radiation" ;

		swr:units = "W/m^2" ;

		swr:missing_value = 1.e+20 ;

		swr:FillValue = 1.e+20 ;

	double lwr(time) ;

		lwr:standard_name = "LWR" ;

		lwr:long_name = "Long Wave Radiation" ;

		lwr:units = "W/m^2" ;

		lwr:missing_value = 1.e+20 ;

		lwr:FillValue = 1.e+20 ;


// global attributes:

		:creation_date = "13-Oct-2021 15:59:17" ;

		:Producer = "null text" ;

		:dataType = "Time series only" ;

		:Comment = "no comments" ;

data:



 time = "2001-05-03", "2001-05-04", "2001-05-05", "2001-05-06", "2001-05-07",
    "2001-05-08", "2001-05-09", "2001-05-10", "2001-05-11", "2001-05-12",
    "2001-05-13", "2001-05-14", "2001-05-15", "2001-05-16", "2001-05-17",
    "2001-05-18", "2001-05-19", "2001-05-20", "2001-05-21" ;


 swr = 209.679376465332, 249.097068762438, 210.909769744377,
    235.104545828219, 218.205895421282, 240.182234958772, 243.346623294593,
    235.004205938925, 241.68268679656, 186.877429186821, 195.80290627705,
    225.488124656128, 213.019894526324, 229.115843377746, 190.362983352515,
    194.062437958129, 206.378626897567, 203.281329439278, 204.329633483502 ;


 lwr = -69.3865225685708, -74.6937604966374, -87.2313991934547,
    -50.3519323423257, -73.3152709634012, -84.355922245511,
    -79.7881506368443, -60.5495796817233, -98.9336126754137,
    -94.0063895900241, -85.5835296256372, -54.8947746739663,
    -74.6499192070357, -54.4607958681041, -86.5101360896428,
    -58.297106644226, -68.9318597650484, -70.7001552939819, -68.9116708557565 ;

}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The function insertlevel_NC is equivalent to insertdepth_NC,
the function insertstaticvariable3DAtmosphere_NC is equivalent to insertstaticvariable3D_NC
and the function insertdynamicvariable4DAtmosphere_NC is equivalent to insertdynamicvariable4D_NC,
with the only difference that they write the "level" parameter instead of the "depth" parameter.
