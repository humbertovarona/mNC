function inserttime_NC(Filename, time_Vals, time_Reference)

    if exist('time_Reference', 'var') == 0
        time_Reference = 'days since 1-1-1 00:00:00';
    end

    nccreate(Filename,'time','Dimensions',{'time', netcdf.getConstant('NC_UNLIMITED')},'Datatype','double','Format','classic')
    ncwriteatt(Filename,'time','standard_name','time');
    ncwriteatt(Filename,'time','long_name','time');
    ncwriteatt(Filename,'time','units', time_Reference);
    ncwriteatt(Filename,'time','calendar','standard');
    ncwriteatt(Filename,'time','axis','T');
    ncwrite(Filename,'time',time_Vals);

return
