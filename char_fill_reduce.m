%  function  sel_cell=char_fill_reduce()
 % star to plane_dist inter_outer extract_inouter plane_curve_24 
clear all;clc;tic;
tol=1e-5;
max_size=32;
msqul=max_size*max_size;
File_pathA=['W:\MNSIT\class_character\'];
File_struct=dir([File_pathA,'train_*']);
File_number=length(File_struct);
% File_number=62;

for loop=2:5    
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
    File_pathB=['W:\MNSIT\char_train\char_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['W:\MNSIT\char_train\fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    mkdir(File_pathB);
    mkdir(File_pathC);
    mkdir(File_pathH);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for Class = 62:File_number
        Class_name=File_struct(Class).name;
        File_name=[File_pathA,Class_name];
        Len_A=fix(File_struct(Class).bytes/msqul);
        fid_a=fopen([File_pathB,Class_name],'w');
        fid_b=fopen([File_pathC,Class_name],'w');
        pip_fill=cell(Len_A,2);
        char_fill=zeros(Len_A,2);
        fileID = fopen(File_name);
        file_vector=fread(fileID,'uint8=>uint8');
        for k=4:Len_A
            vector_line = file_vector((k-1)*1024+1:k*1024);
            %vector_line=read(File_name,Len_A,msqul,'uint8',k,1:msqul);
            line_image=reshape(vector_line,[max_size max_size]);
            subplot(121)
            imshow(line_image);
            [line_image,pip_foreg]=connectivity_8(line_image,max_size,size_reduce,1);
            line_image(line_image>0)=1;
            subplot(122)
            imshow(line_image);
            norm_vector=int32(line_image(:));
            char_fill(k,1)=sum(norm_vector);
            fwrite(fid_a,norm_vector,'int32');
            [line_image,pip_fill{k,1},pip_fill{k,2}]=fill_norm_4(line_image,size_reduce,0);
            line_image(line_image>0)=1;
            norm_vector=int32(line_image(:));
            char_fill(k,2)=sum(norm_vector);
            fwrite(fid_b,norm_vector,'int32');
        end
        fclose all;        
        File_name=[File_pathH,'set_fill_',num2str(Class)];%char_fill_reduce to maxin_cell
        save(eval('File_name'),'char_fill','pip_fill');%char_fill_reduce to maxin_cell
        fprintf('end Class=%d Len_A=%d computing time£º%6.1f s\n',Class,Len_A,toc);
    end
    char_fill=[];
    pip_fill=[];
    fprintf('end set_fill_ loop=%d time£º%6.1f s\n',loop,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plane_loop=cell(4,3);
for loop=2:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    plane_loop{loop-1,1}=cell(size_power,File_number);
    plane_loop{loop-1,2}=cell(size_power,File_number);
    plane_loop{loop-1,3}=cell(size_power,File_number);
    File_pathB=['W:\MNSIT\char_train\char_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['W:\MNSIT\char_train\fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
    File_pathE=['W:\MNSIT\char_train\char_plane_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathF=['W:\MNSIT\char_train\fill_plane_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    mkdir(File_pathE);
    mkdir(File_pathF);
    File_struct=dir([File_pathB,'train_*']);
    vector_ones=ones(1,size_power);
    for Class=1:File_number
        Class_name=File_struct(Class).name;
        File_namea=[File_pathB,Class_name];
        File_nameb=[File_pathC,Class_name];
        Len_A=fix(File_struct(Class).bytes/(4*size_power));
        plane_class=zeros(Len_A,2);
        fid_a=fopen([File_pathE,Class_name],'w');
        fid_b=fopen([File_pathF,Class_name],'w');
        fileID = fopen(File_namea);
        file_vector=fread(fileID);
        fileIDb = fopen(File_nameb);
        line_vector=fread(fileIDb);
        for k=1:Len_A
            line_image = file_vector((k-1)*size_power+1:k*size_power);
            %line_image=readmtx(File_namea,Len_A,size_power,'int32',k,1:size_power);
            sum_value=sum(line_image)/size_power;
            norm_vector=line_image'-sum_value*vector_ones;
            fwrite(fid_a,norm_vector,'double');
            plane_class(k,1)=norm_vector*norm_vector';
            line_image = line_vector((k-1)*size_power+1:k*size_power);
            %line_image=readmtx(File_nameb,Len_A,size_power,'int32',k,1:size_power);
            sum_value=sum(line_image)/size_power;
            norm_vector=line_image'-sum_value*vector_ones;
            fwrite(fid_b,norm_vector,'double');
            plane_class(k,2)=norm_vector*norm_vector';
        end
        fclose all;
        File_name=[File_pathH,'set_fill_',num2str(Class)];%char_fill_reduce to maxin_cell
        load(eval('File_name'),'char_fill');%char_fill_reduce to maxin_cell
        set_diff=char_fill(:,2)-char_fill(:,1);
        set_fill=find(set_diff>0);
        set_plane=cell(size_power,3);
        value_temp=char_fill(set_fill,2);
        for k=1:size_power
            set_plane{k,1}=find(char_fill(:,1)==k);
            set_plane{k,2}=setdiff(find(char_fill(:,2)==k),find(char_fill(:,1)==k));
            set_plane{k,3}=find(value_temp==k);
            plane_loop{loop-1,1}{k,Class}=set_plane{k,1};
            plane_loop{loop-1,2}{k,Class}=set_plane{k,2};
            plane_loop{loop-1,3}{k,Class}=set_plane{k,3};
        end
        File_name=[File_pathH,'class_plane_',num2str(Class)];%char_fill_reduce to maxin_cell
        save(eval('File_name'),'plane_class','set_fill','set_plane');%char_fill_reduce to maxin_cell
        fprintf('end norm_class loop=%d Len_A=%d Class=%d computing time£º%6.1f s\n',loop,Len_A,Class,toc);
    end
end
File_name=['W:\MNSIT\code\set_plane_loop'];%char_fill_reduce to maxin_cell
save(eval('File_name'),'plane_loop');%char_fill_reduce to maxin_cell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
return;