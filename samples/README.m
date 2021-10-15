
% % % 
create_NC('mytest.nc', [-38.5:0.5:-35.5], [-1.5:0.5:1.5]);




% % % 
lons = [-38.5, -38, -37.5, -37, -36.5, -36, -35.5];
lats = [-1.5, -1, -0.5, 0, 0.5]; 
[LATS, LONS] = meshgrid(lats, lons);

create_NC_2DCoordinates('mytest_2.nc', LONS, LATS);



% % % 
[nLon, nLat] = size(LONS);

depthRange = [-100:-1]; 
Bath = rand(nLon,nLat) * range(depthRange) + depthRange(1);

insertvariable2D_NC('mytest_2.nc', Bath, 'z', 'Bathymetry', 'Shallow water bathymetry', 'm')




% % % 
depthRange = [0:10:50]; 
TemperatureRange = [27:0.02:28];
[nLon, nLat] = size(LONS);
nDepth = length(depthRange);

Temp = rand(nLon, nLat, nDepth) * range(TemperatureRange) + TemperatureRange(1);

insertdepth_NC('mytest_2.nc', depthRange)

insertstaticvariable3D_NC('mytest_2.nc', Temp, 'pottemp', 'potential_temperature', 'Potential Temperature', '°C', 999.99)



% % % 
% Daily mean
% Base time '1900-01-01'
timeRange = [datenum('2001-05-03'):datenum('2001-05-21')] - datenum('1900-01-01'); 

TemperatureRange = [27:0.02:28];
[nLon, nLat] = size(LONS);
nTime = length(timeRange);

Temp = rand(nLon, nLat, nTime) * range(TemperatureRange) + TemperatureRange(1);

inserttime_NC('mytest_2.nc', timeRange, 'days since 1900-01-01');

insertdynamicvariable3D_NC('mytest_2.nc', Temp, 'temp', 'temperature', 'SST', '°C', 999.99);





% % % 
depthRange = [0:10:50];
timeRange = [datenum('2001-05-03'):datenum('2001-05-21')] - datenum('1900-01-01'); 
SaltRange = [35.5:0.1:36.5];

[nLon, nLat] = size(LONS);
nDepth = length(depthRange);
nTime = length(timeRange);
Salt = rand(nLon, nLat, nDepth, nTime) * range(SaltRange) + SaltRange(1);

insertdynamicvariable4D_NC('mytest_2.nc', Salt, 'salt', 'SSS', 'Sea Surface Salinity', 'psu', -999.0)




% % % 
LHF_Range = [-150:10:-80];
timeRange = [datenum('2001-05-03'):datenum('2001-05-21')] - datenum('1900-01-01'); 
nTime = length(timeRange);

LHF = rand(1, nTime) * range(LHF_Range) + LHF_Range(1);

inserttimeserie_NC('mytest_2.nc', LHF, 'lhf', 'LHF', 'Latent Heat Flux', 'W/m^2', 1.e+20)





% % % 
timeRange = [datenum('2001-05-03'):datenum('2001-05-21')] - datenum('1900-01-01'); 

createtimeserie_NC('mytest_3.nc', timeRange, 'days since 1900-01-01')


SWR_Range = [180:10:250];
LWR_Range = [-100:10:-50];

nTime = length(timeRange);

SWR = rand(1, nTime) * range(SWR_Range) + SWR_Range(1);
LWR = rand(1, nTime) * range(LWR_Range) + LWR_Range(1);

inserttimeserie_NC('mytest_3.nc', SWR, 'swr', 'SWR', 'Short Wave Radiation', 'W/m^2', 1.e+20)
inserttimeserie_NC('mytest_3.nc', LWR, 'lwr', 'LWR', 'Long Wave Radiation', 'W/m^2', 1.e+20)


