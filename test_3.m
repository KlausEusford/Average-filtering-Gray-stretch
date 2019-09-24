l=-1;
while(l~=1)                                                                             %ѡ��һ�ŻҶ�ͼƬ����Ϊ�ǻҶ�ͼƬ������ѡ��
    if(l~=-1)
        fprintf('�ǻҶ�ͼƬ��������ѡ��\n');
    end
    [filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '��ѡ��Ҷ�ͼƬ');                                                                    %��ѡ��ͼƬ�ĶԻ��򣬷�����ѡͼƬ���ļ����Լ�·��
    name=[pathname,filename];                                                            %ͼƬ����·��
    try
        img = imread(name);
        [h,w,l]=size(img); 
    catch
        disp('δѡ���ļ�');
        return;
    end
end

try
    img_double = im2double(img);
    sp=img_double(:,:,1);
    maxDN=max(max(sp));
    minDN=min(min(sp));

    if(maxDN-minDN==1)
        minDN=0.2;
        maxDN=0.6;
    end
    imgStretch=imadjust(img,[minDN maxDN], []);                                         %���лҶ�����

    nameStretch=strrep(name,'.','_�Ҷ�����.');  
    imwrite(imgStretch,nameStretch);                                                    %���Ҷ�������������imgStretch��

    %ֱ��ͼ���⻯  

    imgHisteq=histeq(img);
    nameHisteq=strrep(name,'.','_ֱ��ͼ���⻯.');  
    imwrite(imgHisteq,nameHisteq);                                                      %��ֱ��ͼ���⻯���������imgHisteq��

    figure,                                                                             %��ʾԭͼ���Ҷ������Լ�ֱ��ͼ���⻯���ͼƬ��Ч���Աȡ�
    subplot(3,1,1),imshow(img);title('ԭͼ'); 
    subplot(3,1,2),imshow(imgStretch);title('�Ҷ�����');
    subplot(3,1,3),imshow(imgHisteq);title('ֱ��ͼ���⻯');

    figure,                                                                             %��ʾ���ֲ�����ĻҶ�ֵ�ֲ�ֱ��ͼ���Աȡ�
    subplot(3,1,1),imhist(img);title('ԭͼ'); 
    subplot(3,1,2),imhist(imgStretch);title('�Ҷ�����');
    subplot(3,1,3),imhist(imgHisteq);title('ֱ��ͼ���⻯');
catch                                                                                   %�쳣����
    if name~=0
        disp('�������');
    end
end
