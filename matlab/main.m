
while 1
    f_path='E:\�ֶ�\200113_164155_cen_6300_00_000_00.raw';
    %f_path='C:\Users\86188\Desktop\�����㷨��ȡѵ����\ǰ�մ���һ��\190401_093553_cen_6000_00_000_00.raw';       
    %�޸��ļ�Ŀ¼
    bb=char('��ѡ��Ҫ���еĲ�����','0--��ʾԭʼͼƬ   1--rawתjpg    2----�и����ݼ��� 3----��ʾԤ���  ');
    choice=inputdlg(bb);
    switch lower(choice{1})  
        case '0'           
            clc
            clear all;
            close all;
            f_path='E:\�ֶ�\200113_164155_cen_6300_00_000_00.raw';           
            I=fopen(f_path);
            A=fread(I,[7920 6004],'uint16');    %��ȡraw��ʽ��Ƭ
            A = uint8(A/16);      %����ת����unit8
            A=A';      %����ת��
            A=flipud(A);    %�ú���flipud�����ǽ�����ߵ����������һ�б�ɵ�һ�У���һ�б�����һ��     
            figure(1),imshow(A,'border','tight','initialmagnification','fit'),title('RGBԭͼ');
                         
            
        case '1'  
%%%%%%%%%%%%%%%%%%%%%����ü��õ����ݼ�
            clc
            clear all;
            close all;
            f_path='E:\�ֶ�\200113_164155_cen_6300_00_000_00.raw';
            I=fopen(f_path);
            A=fread(I,[7920 6004],'uint16');    %��ȡraw��ʽ��Ƭ
            A = uint8(A/16);      %����ת����unit8
            A=A';      %����ת��
            A=flipud(A);    %�ú���flipud�����ǽ�����ߵ����������һ�б�ɵ�һ�У���һ�б�����һ��     
          
            %���RGB��ʽ
            [rows,cols]=size(A);
             r=zeros(rows,cols);
             g=zeros(rows,cols);
             b=zeros(rows,cols);
             r=double(A);
             g=double(A);
             b=double(A);
             A=cat(3,r,g,b);
             A = uint8(A);      %����ת����unit8
             
             imwrite(A,strcat('E:\000',num2str(3),'.jpg'));  %�õ����ݼ�ԭͼjpg��ʽ
             
        case '2'
            clc
            clear all;
            close all;
            f_path='E:\�ֶ�\200113_164155_cen_6300_00_000_00.raw';
            I=fopen(f_path);
            A=fread(I,[7920 6004],'uint16');    %��ȡraw��ʽ��Ƭ
            A = uint8(A/16);      %����ת����unit8
            A=A';      %����ת��
            A=flipud(A);    %�ú���flipud�����ǽ�����ߵ����������һ�б�ɵ�һ�У���һ�б�����һ��     
           
            %���RGB��ʽ
            [rows,cols]=size(A);
             r=zeros(rows,cols);
             g=zeros(rows,cols);
             b=zeros(rows,cols);
             r=double(A);
             g=double(A);
             b=double(A);
             A=cat(3,r,g,b);
             A = uint8(A);      %����ת����unit8
             
            for i= 1:999
                x = 1600 + 4.5* randperm(1200,999)
                y = 2000 + 3 * randperm(1100,999)
                h = 180 + 400*rand() 
                w = 180 + 400*rand()
                roi_img = imcrop(A,[x(i) y(i) h w]);%figure;imshow(roi_img)
                %%%����
                if (i < 10)
                    imwrite(roi_img,strcat('E:\����\00000',num2str(i),'.jpg'));
                end
                if 10<=i && i<100
                    imwrite(roi_img,strcat('E:\����\0000',num2str(i),'.jpg'));
                end
                if 100<=i && i<1000
                    imwrite(roi_img,strcat('E:\����\000',num2str(i),'.jpg'));
                end
                print('���ݼ��и����');
            end

        case '3'
            clc
            clear all;
            close all;

            f_path='C:\Users\86188\Desktop\�����㷨��ȡѵ����\ǰ�մ���һ��\190401_093553_cen_6000_00_000_00.raw';
            I=fopen(f_path);
            A=fread(I,[7920 6004],'uint16');    %��ȡraw��ʽ��Ƭ
            A = uint8(A/16);      %����ת����unit8
            A=A';      %����ת��
            A=flipud(A);    %�ú���flipud�����ǽ�����ߵ����������һ�б�ɵ�һ�У���һ�б�����һ��     
           
            %���RGB��ʽ
            [rows,cols]=size(A);
             r=zeros(rows,cols);
             g=zeros(rows,cols);
             b=zeros(rows,cols);
             r=double(A);
             g=double(A);
             b=double(A);
             A=cat(3,r,g,b);
             A = uint8(A);      %����ת����unit8
             figure(2),imshow(A,'border','tight','initialmagnification','fit'),title('RGBԭͼ');
%%%%%%%%%%%%%%��ԭͼ�л���Ԥ���
             filename = 'C:\Users\86188\Desktop\fiber\bboxes.txt';
            [data1,data2,data3,data4] = textread(filename,'%n%n%n%n', 'delimiter' , ',');
            size = size(data1, 1);
            for i = 1:size
                data1(i,1);
                rectangle('Position',[data2(i,1),data1(i,1),data4(i,1)-data2(i,1),data3(i,1)-data1(i,1)],'LineWidth',2,'EdgeColor','r');
            end
             
    end
end