[filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '��ѡ��ͼƬ');                                                         %��ѡ��ͼƬ�ĶԻ��򣬷�����ѡͼƬ���ļ����Լ�·��
name=[pathname,filename];                                                 %ͼƬ����·��
try
    f=imread(name);                                                       %��ȡͼƬ

    [height, width,l]=size(f);                                             %��ȡͼƬ�Ĵ�С��layerΪͼƬ�Ĳ�ɫ����

    x=input('�������ĺ�����x\n:');                                       %�����ĺ�����
   
    while(x>width||x<0)                                                   %�жϺ������Ƿ���Ϸ�Χ�������������룬ֱ��������ȷ
        fprintf('��������Ч�ĺ����ꡣ\n');
        x=input('�������ĺ�����x\n:');
    end

    y=input('��������������y\n:');                                       %�ж��������Ƿ���Ϸ�Χ�������������룬ֱ��������ȷ
    while(y>height||y<0)
        fprintf('��������Ч�������ꡣ\n');
        y=input('��������������y\n:');
    end

    %��ȡ������ڽ�8�����rgbֵ����������ʱ���Ϊ8��������㴦��ͼƬ�߽��ϣ���Ϊ4������6���㣩
    for h=y-1:y+1                                    
        if(h<=height)                                                     %�жϵ���Χ��Ҫ��ȡrgbֵ�ĵ�ĸ߶��Ƿ񳬳�ͼƬ�߶ȣ��������������л�ȡrgb����
            for w=x-1:x+1
                if(w<=width)                                              %�жϵ���Χ��Ҫ��ȡrgbֵ�ĵ�ĸ߶��Ƿ񳬳�ͼƬ��ȣ��������������л�ȡrgb����
                    A=zeros(1);
                    for l=1:3
                        A(l)=f(h,w,l);
                    end
                    fprintf('(%d,%d):(%d,%d,%d);\n',w,h,A(1),A(2),A(3));  %��ӡ����ȡ������꼰��rgbֵ
                end
            end
        end
    end
catch                                                                    %�쳣����
    if name==0
        disp('ûѡ���ļ�');
    else
        disp('���򱨴�');
    end
end