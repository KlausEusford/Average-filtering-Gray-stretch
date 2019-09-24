[filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '��ѡ��ͼƬ');                                                                 %��ѡ��ͼƬ�ĶԻ��򣬷�����ѡͼƬ���ļ����Լ�·��
name=[pathname,filename];                                                         %ͼƬ����·��
try
    img=imread(name);
    [height,width,layer]=size(img); 
    imgNoise=imnoise(img,'salt & pepper',0.02);                                    %���뽷������

    %��ͼƬΪ��ɫͼƬ
    if(layer==3)    
        r=imgNoise(:,:,1);
        g=imgNoise(:,:,2);
        b=imgNoise(:,:,3);
        r1=medfilt2(r,[3 3]);                                                     %�Խ�������������ֵ�˲�
        g1=medfilt2(g,[3 3]);
        b1=medfilt2(b,[3 3]);
        imgMed = cat(3,r1,g1,b1);

        r2=filter2(fspecial('average',3),r)/255;                                  %�Խ����������о�ֵ�˲�
        g2=filter2(fspecial('average',3),g)/255; 
        b2=filter2(fspecial('average',3),b)/255; 
        imgAri=cat(3,r2,g2,b2);
        disp('color');
    %��ͼƬΪ�Ҷ�ͼƬ
    else
        imgMed=medfilt2(imgNoise);                                                %�Խ�������������ֵ�˲�
        imgAri=filter2(fspecial('average',3),imgNoise)/255;                       %�Խ����������о�ֵ�˲�
        disp('grey');
    end

    figure,
    subplot(1,3,1),imshow(imgNoise);title('��������');                             %��ʾ���뽷���������ͼƬЧ��
    subplot(1,3,2),imshow(imgAri);title('��ֵ�˲�');                               %��ʾ��ֵ�˲����ͼƬЧ��
    subplot(1,3,3),imshow(imgMed);title('��ֵ�˲�');                               %��ʾ��ֵ�˲����ͼƬЧ��
    imwrite(imgNoise,strrep(name,'.','_Noise.'));                                 %������ֲ������ͼƬ
    imwrite(imgAri,strrep(name,'.','_Ari.'));    
    imwrite(imgMed,strrep(name,'.','_Med.'));    
catch                                                                             %�쳣����
    if name==0
        disp('δѡ���ļ�');
    else
        disp('�������');
    end
end