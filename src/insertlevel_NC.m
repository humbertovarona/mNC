function insertlevel_NC(Filename, level_Vals)

    level_Dim=length(level_Vals);
    nccreate(Filename,'level','Dimensions',{'depth',level_Dim},'Datatype','double','Format','classic')
    ncwriteatt(Filename,'level','standard_name','Depth');
    ncwriteatt(Filename,'level','long_name','Vertical axis');
    ncwriteatt(Filename,'level','units','m');
    ncwriteatt(Filename,'level','axis','Z');
    ncwrite(Filename,'level',level_Vals);

return
