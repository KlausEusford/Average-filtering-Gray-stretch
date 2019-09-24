[filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '请选择图片');                                                         %打开选择图片的对话框，返回所选图片的文件名以及路径
name=[pathname,filename];                                                 %图片完整路径
try
    f=imread(name);                                                       %读取图片

    [height, width,l]=size(f);                                             %获取图片的大小，layer为图片的彩色分量

    x=input('请输入点的横坐标x\n:');                                       %输入点的横坐标
   
    while(x>width||x<0)                                                   %判断横坐标是否符合范围，否则重新输入，直至输入正确
        fprintf('请输入有效的横坐标。\n');
        x=input('请输入点的横坐标x\n:');
    end

    y=input('请输入点的纵坐标y\n:');                                       %判断纵坐标是否符合范围，否则重新输入，直至输入正确
    while(y>height||y<0)
        fprintf('请输入有效的纵坐标。\n');
        y=input('请输入点的纵坐标y\n:');
    end

    %获取输入点邻近8个点的rgb值并输出（输出时最多为8，若输入点处于图片边界上，则为4个或者6个点）
    for h=y-1:y+1                                    
        if(h<=height)                                                     %判断点周围需要获取rgb值的点的高度是否超出图片高度，若超出，不进行获取rgb动作
            for w=x-1:x+1
                if(w<=width)                                              %判断点周围需要获取rgb值的点的高度是否超出图片宽度，若超出，不进行获取rgb动作
                    A=zeros(1);
                    for l=1:3
                        A(l)=f(h,w,l);
                    end
                    fprintf('(%d,%d):(%d,%d,%d);\n',w,h,A(1),A(2),A(3));  %打印所获取点的坐标及其rgb值
                end
            end
        end
    end
catch                                                                    %异常处理
    if name==0
        disp('没选择文件');
    else
        disp('程序报错');
    end
end