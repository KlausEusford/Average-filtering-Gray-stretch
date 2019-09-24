[filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '��ѡ��ͼƬ');                                                                  %��ѡ��ͼƬ�ĶԻ��򣬷�����ѡͼƬ���ļ����Լ�·��
name=[pathname,filename];                                                          %ͼƬ����·��
try   
    imgrgb = imread(name);
    [h,w,l]=size(imgrgb);   
    img1 = im2double(imgrgb);                                                      %��ͼƬת��Ϊ˫��������
    imggray= zeros(h,w);                                                           %�Ҷ�ֻ��Ҫ��ά����͹��ˣ���Ϊֻ��һ��ͨ��
    sum=0;                                                                         %ͼƬ�������ص�ĻҶ�ֵ֮�ͣ���ʼֵΪ0

    for i=1:h
        for j=1:w
           imggray(i,j)=0.299*img1(i,j,1)+0.587*img1(i,j,2)+0.114*img1(i,j,3);     %���ݹ�ʽ�Ը������ؽ��д���
           sum=sum+imggray(i,j);                                                   %���
        end
    end
    namegray=strrep(name,'.','_�Ҷ�.');                                             %ת����ĻҶ�ͼƬ����
    imwrite(imggray,namegray);                                                     %�����ؽ����ͼƬ

    vari=0;
    avg = sum/(i*j);                                                               %��ͼƬ�������ص�Ҷȵ�ƽ��ֵ
    for i=1:h
        for j=1:w
           vari=vari+(imggray(i,j)-avg)^2;                                         %��������ص�Ҷ�ֵ��ƽ��ֵ�Ĳ��ƽ����
        end
    end
    vari=vari/(w*h);                                                               %�󷽲�
    disp(vari);                                                                    %�������
catch                                                                              %�쳣����
    if name==0
        disp('δѡ���ļ�');
    else
        disp('�������');
    end
end

