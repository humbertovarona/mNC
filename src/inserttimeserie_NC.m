function inserttimeserie_NC(Filename, Variable, VarName, StdName, LongName, Units, NULLValue)
    
    if exist('Units', 'var') == 0
        Units = 'dimensionless';
    end
    if exist('NULLValue', 'var') == 0
        NULLValue = NaN;
    end

    time_Dim=length(Variable);
    nccreate(Filename, VarName,'Dimensions',{'time', time_Dim},'Format','classic')
    ncwriteatt(Filename,VarName,'standard_name',StdName);
    ncwriteatt(Filename,VarName,'long_name',LongName);
    ncwriteatt(Filename,VarName,'units',Units);
    ncwriteatt(Filename,VarName,'missing_value',NULLValue);
    ncwriteatt(Filename,VarName,'FillValue',NULLValue);

    ncwrite(Filename, VarName, Variable);

return
