function createtimeserie_NC(Filename, time_Vals, time_Reference, sProducer, sComment)

    if exist('time_Reference', 'var') == 0
        time_Reference = 'days since 1-1-1 00:00:00';
    end
    if exist('sProducer', 'var') == 0
        sProducer = 'null text';
    end
    if exist('sComment', 'var') == 0
        sComment = 'no comments';
    end

    nccreate(Filename,'time','Dimensions',{'time', netcdf.getConstant('NC_UNLIMITED')},'Datatype','double','Format','classic')
    ncwriteatt(Filename,'time','standard_name','time');
    ncwriteatt(Filename,'time','long_name','time');
    ncwriteatt(Filename,'time','units', time_Reference);
    ncwriteatt(Filename,'time','calendar','standard');
    ncwriteatt(Filename,'time','axis','T');
    ncwrite(Filename,'time', time_Vals);
    
    %Global attributes
    ncwriteatt(Filename,'/','creation_date',datestr(now));
    ncwriteatt(Filename,'/','Producer',sProducer);
    ncwriteatt(Filename,'/','dataType', 'Time series only');
    ncwriteatt(Filename,'/','Comment', sComment);
    
return
