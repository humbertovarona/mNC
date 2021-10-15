function insertdynamicvariable4D_NC(Filename, Variable, VarName, StdName, LongName, Units, NULLValue)
    
    if exist('Units', 'var') == 0
        Units = 'dimensionless';
    end
    if exist('NULLValue', 'var') == 0
        NULLValue = NaN;
    end
    
    [lon_Dim, lat_Dim, depth_Dim, time_Dim]=size(Variable);
    nccreate(Filename, VarName,'Dimensions',{'lon', lon_Dim, 'lat', lat_Dim, 'depth', depth_Dim, 'time', time_Dim},'Format','classic')
    ncwriteatt(Filename,VarName,'standard_name',StdName);
    ncwriteatt(Filename,VarName,'long_name',LongName);
    ncwriteatt(Filename,VarName,'units',Units);
    ncwriteatt(Filename,VarName,'missing_value',NULLValue);
    ncwriteatt(Filename,VarName,'FillValue',NULLValue);

    ncwrite(Filename, VarName, Variable);

return
