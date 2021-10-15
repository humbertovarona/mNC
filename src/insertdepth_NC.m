function insertdepth_NC(Filename, depth_Vals)

    depth_Dim=length(depth_Vals);
    nccreate(Filename,'depth','Dimensions',{'depth',depth_Dim},'Datatype','double','Format','classic')
    ncwriteatt(Filename,'depth','standard_name','Depth');
    ncwriteatt(Filename,'depth','long_name','Vertical axis');
    ncwriteatt(Filename,'depth','units','m');
    ncwriteatt(Filename,'depth','axis','Z');
    ncwrite(Filename,'depth',depth_Vals);

return
