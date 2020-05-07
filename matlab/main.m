
while 1
    f_path='E:\分度\200113_164155_cen_6300_00_000_00.raw';
    %f_path='C:\Users\86188\Desktop\霍夫算法提取训练集\前照处理一张\190401_093553_cen_6000_00_000_00.raw';       
    %修改文件目录
    bb=char('请选择要进行的操作：','0--显示原始图片   1--raw转jpg    2----切割数据集　 3----显示预测框  ');
    choice=inputdlg(bb);
    switch lower(choice{1})  
        case '0'           
            clc
            clear all;
            close all;
            f_path='E:\分度\200113_164155_cen_6300_00_000_00.raw';           
            I=fopen(f_path);
            A=fread(I,[7920 6004],'uint16');    %读取raw格式照片
            A = uint8(A/16);      %数据转换成unit8
            A=A';      %矩阵转置
            A=flipud(A);    %该函数flipud作用是将矩阵颠倒过来，最后一行变成第一行，第一行变成最后一行     
            figure(1),imshow(A,'border','tight','initialmagnification','fit'),title('RGB原图');
                         
            
        case '1'  
%%%%%%%%%%%%%%%%%%%%%随机裁剪得到数据集
            clc
            clear all;
            close all;
            f_path='E:\分度\200113_164155_cen_6300_00_000_00.raw';
            I=fopen(f_path);
            A=fread(I,[7920 6004],'uint16');    %读取raw格式照片
            A = uint8(A/16);      %数据转换成unit8
            A=A';      %矩阵转置
            A=flipud(A);    %该函数flipud作用是将矩阵颠倒过来，最后一行变成第一行，第一行变成最后一行     
          
            %变成RGB格式
            [rows,cols]=size(A);
             r=zeros(rows,cols);
             g=zeros(rows,cols);
             b=zeros(rows,cols);
             r=double(A);
             g=double(A);
             b=double(A);
             A=cat(3,r,g,b);
             A = uint8(A);      %数据转换成unit8
             
             imwrite(A,strcat('E:\000',num2str(3),'.jpg'));  %得到数据集原图jpg格式
             
        case '2'
            clc
            clear all;
            close all;
            f_path='E:\分度\200113_164155_cen_6300_00_000_00.raw';
            I=fopen(f_path);
            A=fread(I,[7920 6004],'uint16');    %读取raw格式照片
            A = uint8(A/16);      %数据转换成unit8
            A=A';      %矩阵转置
            A=flipud(A);    %该函数flipud作用是将矩阵颠倒过来，最后一行变成第一行，第一行变成最后一行     
           
            %变成RGB格式
            [rows,cols]=size(A);
             r=zeros(rows,cols);
             g=zeros(rows,cols);
             b=zeros(rows,cols);
             r=double(A);
             g=double(A);
             b=double(A);
             A=cat(3,r,g,b);
             A = uint8(A);      %数据转换成unit8
             
            for i= 1:999
                x = 1600 + 4.5* randperm(1200,999)
                y = 2000 + 3 * randperm(1100,999)
                h = 180 + 400*rand() 
                w = 180 + 400*rand()
                roi_img = imcrop(A,[x(i) y(i) h w]);%figure;imshow(roi_img)
                %%%保存
                if (i < 10)
                    imwrite(roi_img,strcat('E:\剪切\00000',num2str(i),'.jpg'));
                end
                if 10<=i && i<100
                    imwrite(roi_img,strcat('E:\剪切\0000',num2str(i),'.jpg'));
                end
                if 100<=i && i<1000
                    imwrite(roi_img,strcat('E:\剪切\000',num2str(i),'.jpg'));
                end
                print('数据集切割完毕');
            end

        case '3'
            clc
            clear all;
            close all;

            f_path='C:\Users\86188\Desktop\霍夫算法提取训练集\前照处理一张\190401_093553_cen_6000_00_000_00.raw';
            I=fopen(f_path);
            A=fread(I,[7920 6004],'uint16');    %读取raw格式照片
            A = uint8(A/16);      %数据转换成unit8
            A=A';      %矩阵转置
            A=flipud(A);    %该函数flipud作用是将矩阵颠倒过来，最后一行变成第一行，第一行变成最后一行     
           
            %变成RGB格式
            [rows,cols]=size(A);
             r=zeros(rows,cols);
             g=zeros(rows,cols);
             b=zeros(rows,cols);
             r=double(A);
             g=double(A);
             b=double(A);
             A=cat(3,r,g,b);
             A = uint8(A);      %数据转换成unit8
             figure(2),imshow(A,'border','tight','initialmagnification','fit'),title('RGB原图');
%%%%%%%%%%%%%%在原图中绘制预测框
             filename = 'C:\Users\86188\Desktop\fiber\bboxes.txt';
            [data1,data2,data3,data4] = textread(filename,'%n%n%n%n', 'delimiter' , ',');
            size = size(data1, 1);
            for i = 1:size
                data1(i,1);
                rectangle('Position',[data2(i,1),data1(i,1),data4(i,1)-data2(i,1),data3(i,1)-data1(i,1)],'LineWidth',2,'EdgeColor','r');
            end
             
    end
end