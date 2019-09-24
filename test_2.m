[filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '请选择图片');                                                                  %打开选择图片的对话框，返回所选图片的文件名以及路径
name=[pathname,filename];                                                          %图片完整路径
try   
    imgrgb = imread(name);
    [h,w,l]=size(imgrgb);   
    img1 = im2double(imgrgb);                                                      %将图片转换为双精度类型
    imggray= zeros(h,w);                                                           %灰度只需要二维数组就够了，因为只有一个通道
    sum=0;                                                                         %图片各个像素点的灰度值之和，起始值为0

    for i=1:h
        for j=1:w
           imggray(i,j)=0.299*img1(i,j,1)+0.587*img1(i,j,2)+0.114*img1(i,j,3);     %根据公式对各个像素进行处理
           sum=sum+imggray(i,j);                                                   %求和
        end
    end
    namegray=strrep(name,'.','_灰度.');                                             %转化后的灰度图片命名
    imwrite(imggray,namegray);                                                     %保存重建后的图片

    vari=0;
    avg = sum/(i*j);                                                               %求图片各个像素点灰度的平均值
    for i=1:h
        for j=1:w
           vari=vari+(imggray(i,j)-avg)^2;                                         %求各个像素点灰度值与平均值的差的平方和
        end
    end
    vari=vari/(w*h);                                                               %求方差
    disp(vari);                                                                    %输出方差
catch                                                                              %异常处理
    if name==0
        disp('未选择文件');
    else
        disp('程序出错');
    end
end

