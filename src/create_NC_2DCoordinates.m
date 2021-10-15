function create_NC_2DCoordinates(Filename, lon_Vals, lat_Vals, sProducer, sComment)

    if exist('sProducer', 'var') == 0
        sProducer = 'null text';
    end
    if exist('sComment', 'var') == 0
        sComment = 'no comments';
    end

    [lon_Dim, lat_Dim]=size(lon_Vals);
    nccreate(Filename,'lon','Dimensions',{'lon',lon_Dim,'lat',lat_Dim},'Datatype','double','Format','classic')
    ncwriteatt(Filename,'lon','standard_name','longitude');
    ncwriteatt(Filename,'lon','long_name','longitude');
    ncwriteatt(Filename,'lon','units','degrees_east');
    ncwriteatt(Filename,'lon','axis','X');
    ncwrite(Filename,'lon',lon_Vals);
    
    nccreate(Filename,'lat','Dimensions',{'lon',lon_Dim,'lat',lat_Dim},'Datatype','double','Format','classic')
    ncwriteatt(Filename,'lat','standard_name','latitude');
    ncwriteatt(Filename,'lat','long_name','latitude');
    ncwriteatt(Filename,'lat','units','degrees_north');
    ncwriteatt(Filename,'lat','axis','Y');
    ncwrite(Filename,'lat',lat_Vals);
    
    %Global attributes
    ncwriteatt(Filename,'/','creation_date',datestr(now));
    ncwriteatt(Filename,'/','Producer',sProducer);
    ncwriteatt(Filename,'/','dataType', '2D Grid');
    ncwriteatt(Filename,'/','Comment', sComment);
    
return
