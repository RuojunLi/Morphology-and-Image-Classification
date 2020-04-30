% function  sel_cell=maxin_plane()
% from char_fill_reduce to  maxin_plane maxin_plane
%%
clear all;clc;tic;
tol=8*1e-3;
size_reduce=24;
size_power=size_reduce*size_reduce;
File_pathA=['W:\MNSIT\class_character\'];
File_struct=dir([File_pathA,'train_*']);
File_number=length(File_struct);
File_number=10;
File_pathB=['W:\MNSIT\plane_char\'];%char_fill_reduce to maxin_cell
File_pathC=['W:\MNSIT\plane_fill\'];%char_fill_reduce to maxin_cell
File_pathD='W:\MNSIT\data_0422\';%char_fill_reduce to maxin_density
mkdir(File_pathD);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'norm_class','set_plane');%char_fill_reduce to maxin_cell
    Len_A=size(norm_class,1);
    class_norm=norm_class;
    class_plane=set_plane;
    maxin_value=cell(size_power,8);
    File_name=[File_pathB,File_struct(Class).name];
    matrix_class=zeros(size_power,Len_A);
    matrix_class=readmtx(File_name,Len_A,size_power,'double')';
    for p=2:size_power-1
        char_class=class_plane{p,1};
        size_class=length(char_class);
        if size_class>0
            temp_class=zeros(size_power,size_class);
            if size_class~=2
                temp_class=matrix_class(:,char_class);
            else
                temp_class(:,1)=matrix_class(:,char_class(1));
                temp_class(:,2)=matrix_class(:,char_class(2));
            end
            char_value=zeros(size_class,File_number);
            char_post=zeros(size_class,File_number);
            fill_value=zeros(size_class,File_number);
            fill_post=zeros(size_class,File_number);
            for Cla=1:File_number
                if Class~=Cla
                    File_pathH=[File_pathD,'plot_',num2str(Cla),'\'];%char_fill_reduce to maxin_density plane_project
                    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
                    load(eval('File_name'),'norm_class','set_plane');%char_fill_reduce to maxin_density plane_neigth
                    Len_B=size(norm_class,1);
                    char_cla=set_plane{p,1};
                    size_cla=length(char_cla);
                    if size_cla>0
                        File_name=[File_pathB,File_struct(Cla).name];
                        matrix_cla=zeros(size_cla,size_power);
                        if size_cla~=2
                            matrix_cla=readmtx(File_name,Len_B,size_power,'double',char_cla,1:size_power);
                        else
                            matrix_cla(1,:)=readmtx(File_name,Len_B,size_power,'double',char_cla(1),1:size_power);
                            matrix_cla(2,:)=readmtx(File_name,Len_B,size_power,'double',char_cla(2),1:size_power);
                        end
                        dist_kj=repmat(norm_class(char_cla,1),[1,size_class])-2*matrix_cla*temp_class;
                        if size_cla>1
                            [min_value,min_post]=min(dist_kj);
                            char_value(:,Cla)=class_norm(char_class,1)+min_value';
                            char_post(:,Cla)=min_post';
                        else
                            char_value(:,Cla)=class_norm(char_class,1)+dist_kj';
                            char_post(:,Cla)=ones(size_class,1);                            
                        end
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    fill_cla=set_plane{p,2};
                    size_cla=length(fill_cla);
                    if size_cla>0
                        File_name=[File_pathC,File_struct(Cla).name];
                        matrix_cla=zeros(size_cla,size_power);
                        if size_cla~=2
                            matrix_cla=readmtx(File_name,Len_B,size_power,'double',fill_cla,1:size_power);
                        else
                            matrix_cla(1,:)=readmtx(File_name,Len_B,size_power,'double',fill_cla(1),1:size_power);
                            matrix_cla(2,:)=readmtx(File_name,Len_B,size_power,'double',fill_cla(2),1:size_power);
                        end
                        dist_kj=repmat(norm_class(fill_cla,2),[1,size_class])-2*matrix_cla*temp_class;
                        if size_cla>1
                            [min_value,min_post]=min(dist_kj);
                            fill_value(:,Cla)=class_norm(char_class,1)+min_value';
                            fill_post(:,Cla)=min_post';
                        else
                            fill_value(:,Cla)=class_norm(char_class,1)+dist_kj';
                            fill_post(:,Cla)=ones(size_class,1);                            
                        end
                    end
                end
%                 fprintf('end maxin_plane_char Class=%d p=%d Cla=%d  time£º%6.1f s\n',Class,p,Cla,toc);
            end
            maxin_value{p,1}=char_value;
            maxin_value{p,2}=char_post;
            maxin_value{p,3}=fill_value;
            maxin_value{p,4}=fill_post;            
        end
        matrix_cla=[];
        fprintf('end maxin_plane_char Class=%d p=%d  time£º%6.1f s\n',Class,p,toc);
    end
    matrix_class=[];
    temp_class=[];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for p=2:size_power-1
        fill_class=class_plane{p,2};
        size_class=length(fill_class);
        if size_class>0
            File_name=[File_pathC,File_struct(Class).name];
            temp_class=zeros(size_power,size_class);
            if size_class~=2                
                temp_class=read(File_name,Len_A,size_power,'double',fill_class,1:size_power)';
            else
                temp_class(:,1)=readmtx(File_name,Len_A,size_power,'double',fill_class(1),1:size_power)';
                temp_class(:,2)=readmtx(File_name,Len_A,size_power,'double',fill_class(2),1:size_power)';
            end
            char_value=zeros(size_class,File_number);
            char_post=zeros(size_class,File_number);
            fill_value=zeros(size_class,File_number);
            fill_post=zeros(size_class,File_number);
            for Cla=1:File_number
                if Class~=Cla
                    File_pathH=[File_pathD,'plot_',num2str(Cla),'\'];%char_fill_reduce to maxin_density plane_project
                    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
                    load(eval('File_name'),'norm_class','set_plane');%char_fill_reduce to maxin_density plane_neigth
                    Len_B=size(norm_class,1);
                    char_cla=set_plane{p,1};
                    size_cla=length(char_cla);
                    if size_cla>0
                        File_name=[File_pathB,File_struct(Cla).name];
                        matrix_cla=zeros(size_cla,size_power);
                        if size_cla~=2
                            matrix_cla=readmtx(File_name,Len_B,size_power,'double',char_cla,1:size_power);
                        else
                            matrix_cla(1,:)=readmtx(File_name,Len_B,size_power,'double',char_cla(1),1:size_power);
                            matrix_cla(2,:)=readmtx(File_name,Len_B,size_power,'double',char_cla(2),1:size_power);
                        end
                        dist_kj=repmat(norm_class(char_cla,1),[1,size_class])-2*matrix_cla*temp_class;
                        if size_cla>1
                            [min_value,min_post]=min(dist_kj);
                            char_value(:,Cla)=class_norm(fill_class,2)+min_value';
                            char_post(:,Cla)=min_post';
                        else
                            char_value(:,Cla)=class_norm(fill_class,2)+dist_kj';
                            char_post(:,Cla)=ones(size_class,1);                            
                        end
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    fill_cla=set_plane{p,2};
                    size_cla=length(fill_cla);
                    if size_cla>0
                        File_name=[File_pathC,File_struct(Cla).name];
                        matrix_cla=zeros(size_cla,size_power);
                        if size_cla~=2
                            matrix_cla=readmtx(File_name,Len_B,size_power,'double',fill_cla,1:size_power);
                        else
                            matrix_cla(1,:)=readmtx(File_name,Len_B,size_power,'double',fill_cla(1),1:size_power);
                            matrix_cla(2,:)=readmtx(File_name,Len_B,size_power,'double',fill_cla(2),1:size_power);
                        end
                        dist_kj=repmat(norm_class(fill_cla,2),[1,size_class])-2*matrix_cla*temp_class;
                        if size_cla>1
                            [min_value,min_post]=min(dist_kj);
                            fill_value(:,Cla)=class_norm(fill_class,2)+min_value';
                            fill_post(:,Cla)=min_post';
                        else
                            fill_value(:,Cla)=class_norm(fill_class,2)+dist_kj';
                            fill_post(:,Cla)=ones(size_class,1);                            
                        end
                    end
                end
%                 fprintf('end maxin_plane_fill Class=%d p=%d Cla=%d  time£º%6.1f s\n',Class,p,Cla,toc);
            end
            maxin_value{p,5}=char_value;
            maxin_value{p,6}=char_post;
            maxin_value{p,7}=fill_value;
            maxin_value{p,8}=fill_post;            
        end
        matrix_cla=[];
        fprintf('end maxin_plane_fill Class=%d p=%d  time£º%6.1f s\n',Class,p,toc);
    end
    temp_class=[];
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'maxin_plane_10'];%maxin_cell_top to maxin_cell
    save(eval('File_name'),'maxin_value');%maxin_cell_top to maxin_cell
    fprintf('end maxin_plane Class=%d time£º%6.1f s\n',Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=length(File_struct);
File_number=10;
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'maxin_plane_10'];%maxin_cell_top to maxin_cell
    load(eval('File_name'),'maxin_value');%maxin_cell_top to maxin_cell
    maxin_class=cell(size_power,6);
    for p=2:size_power-1
        value_char=maxin_value{p,1};
        value_char(value_char==0)=inf;
        value_fill=maxin_value{p,3};
        value_fill(value_char==0)=inf;
        post_char=maxin_value{p,2};
        post_fill=maxin_value{p,4};
        size_char=size(value_char,1);
        temp_value=zeros(size_char,File_number);
        temp_class=zeros(size_char,File_number);
        temp_post=zeros(size_char,File_number);
        for Cla=1:File_number
            if Class~=Cla
                for k=1:size_char
                    [temp_value(k,Cla),temp_class(k,Cla)]=min([value_char(k,Cla),value_fill(k,Cla)]);
                    if temp_class(k,Cla)==1
                        temp_post(k,Cla)=post_char(k,Cla);
                    else
                        temp_post(k,Cla)=post_fill(k,Cla);
                    end
                end
            end
        end
        maxin_class{p,1}=temp_value;
        maxin_class{p,2}=temp_class;
        maxin_class{p,3}=temp_post;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        value_char=maxin_value{p,5};
        value_char(value_char==0)=inf;
        value_fill=maxin_value{p,7};
        value_fill(value_char==0)=inf;
        post_char=maxin_value{p,6};
        post_fill=maxin_value{p,8};
        size_char=size(value_char,1);
        temp_value=zeros(size_char,File_number);
        temp_class=zeros(size_char,File_number);
        temp_post=zeros(size_char,File_number);
        for Cla=1:File_number
            if Class~=Cla
                for k=1:size_char
                    [temp_value(k,Cla),temp_class(k,Cla)]=min([value_char(k,Cla),value_fill(k,Cla)]);
                    if temp_class(k,Cla)==1
                        temp_post(k,Cla)=post_char(k,Cla);
                    else
                        temp_post(k,Cla)=post_fill(k,Cla);
                    end
                end
            end
        end
        maxin_class{p,4}=temp_value;
        maxin_class{p,5}=temp_class;
        maxin_class{p,6}=temp_post;
    end
    File_name=[File_pathH,'class_plane'];%maxin_cell_top to neight_char_fill
    save(eval('File_name'),'maxin_class');%maxin_cell_top to neight_char_fill
    fprintf('end class_plane Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'class_plane'];%maxin_cell_top to neight_char_fill 
    load(eval('File_name'),'maxin_class');%maxin_cell_top to neight_char_fill
    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'norm_class','set_plane');%char_fill_reduce to maxin_cell
    radius_class=cell(size_power,6);
    for p=2:size_power-1
        radius_class{p,1}=set_plane{p,1};
        size_char=length(set_plane{p,1});
        radius_class{p,3}=set_plane{p,2};
        radius_class{p,4}=set_plane{p,3};
        size_fill=length(set_plane{p,2});
        if size_char>0
            value_char=maxin_class{p,1};
            value_char(value_char==0)=inf;
            class_char=maxin_class{p,2};
            post_char=maxin_class{p,3};
            [min_value,min_class]=min(value_char(:,1:File_number)');
            temp_value=zeros(size_char,4);
            temp_value(:,1)=min_value';
            temp_value(:,2)=min_class';
            for k=1:size_char
                temp_cla=min_class(k);
                temp_value(k,3)=class_char(k,temp_cla);
                temp_value(k,4)=post_char(k,temp_cla);
            end
            radius_class{p,2}=temp_value;
            radius_class{p,5}=norm_class(set_plane{p,1}(1),1);
        end
        if size_fill>0
            value_fill=maxin_class{p,4};
            value_fill(value_fill==0)=inf;
            class_fill=maxin_class{p,5};
            post_fill=maxin_class{p,6};
            [min_value,min_class]=min(value_fill(:,1:File_number)');
            temp_value=zeros(size_fill,4);
            temp_value(:,1)=min_value';
            temp_value(:,2)=min_class';
            for k=1:size_fill
                temp_cla=min_class(k);
                temp_value(k,3)=class_fill(k,temp_cla);
                temp_value(k,4)=post_fill(k,temp_cla);
            end
            radius_class{p,5}=temp_value;
            radius_class{p,6}=norm_class(set_plane{p,2}(1),2);
        end
    end
    radius_class{1,1}=set_plane{1,1};
    radius_class{1,3}=set_plane{1,2};
    radius_class{size_power,1}=set_plane{size_power,1};
    radius_class{size_power,3}=set_plane{size_power,2};
    File_name=[File_pathH,'radius_plane'];%maxin_cell_top to neight_char_fill
    save(eval('File_name'),'radius_class');%maxin_cell_top to neight_char_fill
    fprintf('end radius_plane Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'norm_class');%char_fill_reduce to maxin_density plane_neigth
    File_name=[File_pathH,'radius_plane'];%maxin_cell_top to neight_char_fill
    load(eval('File_name'),'radius_class');%maxin_cell_top to neight_char_fill
    Len_A=size(norm_class,1);
    File_nameb=[File_pathB,File_struct(Class).name];
    File_namec=[File_pathC,File_struct(Class).name];
    cell_plane=cell(size_power,2);
    size_cell=cell(size_power,4);
    for p=2:size_power-1
        char_class=radius_class{p,1};
        size_char=length(char_class);
        if size_char>0
            radius_char=radius_class{p,2}(:,1);
            size_cell{p,1}=radius_char;
            size_cell{p,2}=zeros(size_char,1);
            cell_plane{p,1}=cell(size_char,2);
            norm_char=norm_class(char_class,1);
            matrix_char=zeros(size_char,size_power);
            if size_char~=2
                matrix_char=readmtx(File_nameb,Len_A,size_power,'double',char_class,1:size_power);
            else
                matrix_char(1,:)=readmtx(File_nameb,Len_A,size_power,'double',char_class(1),1:size_power);
                matrix_char(2,:)=readmtx(File_nameb,Len_A,size_power,'double',char_class(2),1:size_power);
            end
            for k=1:size_char
                dist_kj=matrix_char*matrix_char(k,:)';
                dist_kj=norm_char(k)+norm_char-2*dist_kj;
                cell_plane{p,1}{k,1}=char_class(find(dist_kj<=radius_char(k,1)));
                size_cell{p,2}(k)=length(cell_plane{p,1}{k,1});
            end            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        fill_class=radius_class{p,3};
        size_fill=length(fill_class);
        if size_fill>0
            radius_fill=radius_class{p,5}(:,1);
            size_cell{p,3}=radius_fill;
            size_cell{p,4}=zeros(size_fill,1);
            cell_plane{p,2}=cell(size_fill,2);
            norm_fill=norm_class(fill_class,2);
            File_name=[File_pathC,File_struct(Class).name];
            matrix_fill=zeros(size_fill,size_power);
            if size_fill~=2
                matrix_fill=readmtx(File_namec,Len_A,size_power,'double',fill_class,1:size_power);
            else
                matrix_fill(1,:)=readmtx(File_namec,Len_A,size_power,'double',fill_class(1),1:size_power);
                matrix_fill(2,:)=readmtx(File_namec,Len_A,size_power,'double',fill_class(2),1:size_power);
            end
            for k=1:size_fill
                dist_kj=matrix_fill*matrix_fill(k,:)';
                dist_kj=norm_fill(k)+norm_fill-2*dist_kj;
                cell_plane{p,2}{k,2}=fill_class(find(dist_kj<=radius_fill(k,1)));
                size_cell{p,4}(k)=length(cell_plane{p,2}{k,2});
            end
            if size_char>0
                for k=1:size_fill
                    dist_kj=matrix_char*matrix_fill(k,:)';
                    dist_kj=norm_fill(k)+norm_char-2*dist_kj;
                    cell_plane{p,2}{k,1}=char_class(find(dist_kj<=radius_fill(k,1)));
                    size_cell{p,4}(k)=size_cell{p,4}(k)+length(cell_plane{p,2}{k,1});
                end
                for k=1:size_char
                    dist_kj=matrix_fill*matrix_char(k,:)';
                    dist_kj=norm_char(k)+norm_fill-2*dist_kj;
                    cell_plane{p,1}{k,2}=fill_class(find(dist_kj<=radius_char(k,1)));
                    size_cell{p,2}(k)=size_cell{p,2}(k)+length(cell_plane{p,1}{k,2});
                end
            end
        end
    end
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'plane_cell_',num2str(File_number)];%char_fill_reduce to maxin_density neigth_class_plane
    save(eval('File_name'),'cell_plane','size_cell');%maxin_cell_top to neight_char_fill
    cell_plane=[];
    matrix_char=[];
    matrix_fill=[];
    fprintf('end plane_cell_ Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
data_count=8;

for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'set_plane');%char_fill_reduce to maxin_density plane_neigth
    File_name=[File_pathH,'plane_cell_',num2str(File_number)];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'cell_plane','size_cell');%maxin_cell_top to neight_char_fill
    cover_plane=cell(size_power,2);
    isolat_plane=cell(size_power,4);
    for p=2:size_power-1
        set_char=set_plane{p,1};
        set_fill=set_plane{p,2};
        size_char=length(set_char);
        size_fill=length(set_fill);
        radius_char=size_cell{p,1};
        radius_fill=size_cell{p,3};
        diff_char=zeros(size_char,1);
        diff_fill=zeros(size_fill,1);
        loop_p=1;
        if size_char>0&size_fill>0
            [max_char,post_char]=max(radius_char);
            [max_fill,post_fill]=max(radius_fill);
            [max_value,max_class]=max([max_char,max_fill]);
            if max_class==1
                char_max=cell_plane{p,1}{post_char,1};
                fill_max=cell_plane{p,1}{post_char,2};
                cover_plane{p,1}=[cover_plane{p,1};[0 post_char set_char(post_char) length(char_max) length(fill_max)]];
            else
                char_max=cell_plane{p,2}{post_fill,1};
                fill_max=cell_plane{p,2}{post_fill,2};
                cover_plane{p,1}=[cover_plane{p,1};[1 post_fill set_fill(post_fill) length(char_max) length(fill_max)]];                
            end
            for k=1:size_char
                cell_plane{p,1}{k,1}=setdiff(cell_plane{p,1}{k,1},char_max);
                cell_plane{p,1}{k,2}=setdiff(cell_plane{p,1}{k,2},fill_max);
                diff_char(k)=length(cell_plane{p,1}{k,1})+length(cell_plane{p,1}{k,2});
            end
            for k=1:size_fill
                cell_plane{p,2}{k,1}=setdiff(cell_plane{p,2}{k,1},char_max);
                cell_plane{p,2}{k,2}=setdiff(cell_plane{p,2}{k,2},fill_max);
                diff_fill(k)=length(cell_plane{p,2}{k,1})+length(cell_plane{p,2}{k,2});
            end
            cover_plane{p,2}{loop_p,1}=char_max;
            cover_plane{p,2}{loop_p,2}=fill_max;
        elseif size_char>0
            [max_char,post_char]=max(radius_char);
            char_max=cell_plane{p,1}{post_char,1};
            fill_max=cell_plane{p,1}{post_char,2};
            cover_plane{p,1}=[cover_plane{p,1};[0 post_char set_char(post_char) length(char_max) length(fill_max)]];
            for k=1:size_char
                cell_plane{p,1}{k,1}=setdiff(cell_plane{p,1}{k,1},char_max);
                cell_plane{p,1}{k,2}=setdiff(cell_plane{p,1}{k,2},fill_max);
                diff_char(k)=length(cell_plane{p,1}{k,1})+length(cell_plane{p,1}{k,2});
            end
            cover_plane{p,2}{loop_p,1}=char_max;
            cover_plane{p,2}{loop_p,2}=fill_max;
        elseif size_fill>0
            [max_fill,post_fill]=max(radius_fill);
            char_max=cell_plane{p,2}{post_fill,1};
            fill_max=cell_plane{p,2}{post_fill,2};
            cover_plane{p,1}=[cover_plane{p,1};[1 post_fill set_fill(post_fill) length(char_max) length(fill_max)]];
            for k=1:size_fill
                cell_plane{p,2}{k,1}=setdiff(cell_plane{p,2}{k,1},char_max);
                cell_plane{p,2}{k,2}=setdiff(cell_plane{p,2}{k,2},fill_max);
                diff_fill(k)=length(cell_plane{p,2}{k,1})+length(cell_plane{p,2}{k,2});
            end
            cover_plane{p,2}{loop_p,1}=char_max;
            cover_plane{p,2}{loop_p,2}=fill_max;
        end
        densit_max=1;
        while densit_max>tol&(size_char>0||size_fill>0)
            if size_char>0&size_fill>0
                densit_char=diff_char./radius_char;
                densit_char(diff_char<data_count)=0;
                densit_fill=diff_fill./radius_fill;
                densit_fill(diff_fill<data_count)=0;
                [max_char,post_char]=max(densit_char);
                [max_fill,post_fill]=max(densit_fill);
                [densit_max,max_class]=max([max_char,max_fill]);
                if max_class==1
                    char_max=cell_plane{p,1}{post_char,1};
                    fill_max=cell_plane{p,1}{post_char,2};
                    cover_plane{p,1}=[cover_plane{p,1};[0 post_char set_char(post_char) length(char_max) length(fill_max)]];
                else
                    char_max=cell_plane{p,2}{post_fill,1};
                    fill_max=cell_plane{p,2}{post_fill,2};
                    cover_plane{p,1}=[cover_plane{p,1};[1 post_fill set_fill(post_fill) length(char_max) length(fill_max)]];
                end
                for k=1:size_char
                    cell_plane{p,1}{k,1}=setdiff(cell_plane{p,1}{k,1},char_max);
                    cell_plane{p,1}{k,2}=setdiff(cell_plane{p,1}{k,2},fill_max);
                    diff_char(k)=length(cell_plane{p,1}{k,1})+length(cell_plane{p,1}{k,2});
                end
                for k=1:size_fill
                    cell_plane{p,2}{k,1}=setdiff(cell_plane{p,2}{k,1},char_max);
                    cell_plane{p,2}{k,2}=setdiff(cell_plane{p,2}{k,2},fill_max);
                    diff_fill(k)=length(cell_plane{p,2}{k,1})+length(cell_plane{p,2}{k,2});
                end
            elseif size_char>0
                densit_char=diff_char./radius_char;
                densit_char(diff_char<data_count)=0;
                [densit_max,post_char]=max(densit_char);
                char_max=cell_plane{p,1}{post_char,1};
                fill_max=cell_plane{p,1}{post_char,2};
                cover_plane{p,1}=[cover_plane{p,1};[0 post_char set_char(post_char) length(char_max) length(fill_max)]];
                for k=1:size_char
                    cell_plane{p,1}{k,1}=setdiff(cell_plane{p,1}{k,1},char_max);
                    cell_plane{p,1}{k,2}=setdiff(cell_plane{p,1}{k,2},fill_max);
                    diff_char(k)=length(cell_plane{p,1}{k,1})+length(cell_plane{p,1}{k,2});
                end
            elseif size_fill>0
                densit_fill=diff_fill./radius_fill;
                densit_fill(diff_fill<data_count)=0;
                [densit_max,post_fill]=max(densit_fill);
                char_max=cell_plane{p,2}{post_fill,1};
                fill_max=cell_plane{p,2}{post_fill,2};
                cover_plane{p,1}=[cover_plane{p,1};[1 post_fill set_fill(post_fill) length(char_max) length(fill_max)]];
                for k=1:size_fill
                    cell_plane{p,2}{k,1}=setdiff(cell_plane{p,2}{k,1},char_max);
                    cell_plane{p,2}{k,2}=setdiff(cell_plane{p,2}{k,2},fill_max);
                    diff_fill(k)=length(cell_plane{p,2}{k,1})+length(cell_plane{p,2}{k,2});
                end
            end
            loop_p=loop_p+1;
            cover_plane{p,2}{loop_p,1}=char_max;
            cover_plane{p,2}{loop_p,2}=fill_max;
        end
        loop_p=0;
        for k=1:size_char
            size_temp=length(cell_plane{p,1}{k,1})+length(cell_plane{p,1}{k,2});
            if size_temp>0
                loop_p=loop_p+1;
                isolat_plane{p,1}=[isolat_plane{p,1};[k,set_char(k)]];
                isolat_plane{p,2}{loop_p,1}=cell_plane{p,1}{k,1};
                isolat_plane{p,2}{loop_p,2}=cell_plane{p,1}{k,2};
            end
        end
        loop_p=0;
        for k=1:size_fill
            size_temp=length(cell_plane{p,2}{k,1})+length(cell_plane{p,2}{k,2});
            if size_temp>0
                loop_p=loop_p+1;
                isolat_plane{p,3}=[isolat_plane{p,1};[k,set_fill(k)]];
                isolat_plane{p,4}{loop_p,1}=cell_plane{p,2}{k,1};
                isolat_plane{p,4}{loop_p,2}=cell_plane{p,2}{k,2};
            end
        end
        fprintf('end plane_cell_cover Class=%d p=%d time£º%6.1f s\n', Class,p,toc);
    end
    File_name=[File_pathH,'plane_cell_cover'];%char_fill_reduce to maxin_density neigth_class_plane
    save(eval('File_name'),'cover_plane');%maxin_cell_top to neight_char_fill
    fprintf('end plane_cell_cover Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'norm_class');%char_fill_reduce to maxin_density plane_neigth
    File_name=[File_pathH,'plane_cell_cover'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'cover_plane');%maxin_cell_top to neight_char_fill
    Len_A=size(norm_class,1);
    center_matrix=cell(size_power,1);
    for p=2:size_power-1
        set_cover=cover_plane{p,1};
        size_cover=size(set_cover,1);
        if size_cover>0
            matrix_cover=zeros(size_cover,size_power);
            for k=1:size_cover
                if set_cover(k,1)==0
                    File_name=[File_pathB,File_struct(Class).name];
                else
                    File_name=[File_pathC,File_struct(Class).name];
                end
                matrix_cover(k,:)=readmtx(File_name,Len_A,size_power,'double',set_cover(k,3),1:size_power);
            end
            len_count=matrix_cover(1,:)*matrix_cover(1,:)';
            center_matrix{p,1}=matrix_cover./sqrt(len_count);
        end        
        fprintf('end matrix_cover Class=%d p=%d time£º%6.1f s\n', Class,p,toc);
    end
    File_name=[File_pathH,'matrix_cover'];%char_fill_reduce to maxin_density neigth_class_plane
    save(eval('File_name'),'center_matrix');%maxin_cell_top to neight_char_fill
    fprintf('end plane_cell_cover Class=%d time£º%6.1f s\n', Class,toc);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'matrix_cover'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'center_matrix');%maxin_cell_top to neight_char_fill
    class_matrix=center_matrix;
    matrix_relate=cell(size_power,File_number);
    for Cla=1:File_number
        File_pathHc=[File_pathD,'plot_',num2str(Cla),'\'];%char_fill_reduce to maxin_density plane_project
        File_name=[File_pathHc,'matrix_cover'];%char_fill_reduce to maxin_density neigth_class_plane
        load(eval('File_name'),'center_matrix');%maxin_cell_top to neight_char_fill
        for p=2:size_power-1
            matrix_class=class_matrix{p,1};
            size_class=size(matrix_class,1);
            matrix_cla=center_matrix{p,1};
            size_cla=size(matrix_cla,1);
            if size_class>0&size_cla>0
                matrix_relate{p,Cla}=acos(matrix_class*matrix_cla')*180/pi;
            end
        end        
        fprintf('end matrix_cover_relate Class=%d Cla=%d time£º%6.1f s\n', Class,Cla,toc);
    end
    File_name=[File_pathH,'matrix_cover_relate'];%char_fill_reduce to maxin_density neigth_class_plane
    save(eval('File_name'),'matrix_relate');%maxin_cell_top to neight_char_fill
    fprintf('end matrix_cover_relate Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'matrix_cover'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'center_matrix');%maxin_cell_top to neight_char_fill
    class_matrix=center_matrix;
    next_relate=cell(size_power,File_number);
    for Cla=1:File_number
        File_pathHc=[File_pathD,'plot_',num2str(Cla),'\'];%char_fill_reduce to maxin_density plane_project
        File_name=[File_pathHc,'matrix_cover'];%char_fill_reduce to maxin_density neigth_class_plane
        load(eval('File_name'),'center_matrix');%maxin_cell_top to neight_char_fill
        for p=2:size_power-1
            matrix_class=class_matrix{p,1};
            size_class=size(matrix_class,1);
            matrix_cla=center_matrix{p+1,1};
            size_cla=size(matrix_cla,1);
            if size_class>0&size_cla>0
                next_relate{p,Cla}=acos(matrix_class*matrix_cla')*180/pi;
            end
        end        
        fprintf('end matrix_cover_relate Class=%d Cla=%d time£º%6.1f s\n', Class,Cla,toc);
    end
    File_name=[File_pathH,'matrix_next_relate'];%char_fill_reduce to maxin_density neigth_class_plane
    save(eval('File_name'),'next_relate');%maxin_cell_top to neight_char_fill
    fprintf('end matrix_cover_relate Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'matrix_cover_relate'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'matrix_relate');%maxin_cell_top to neight_char_fill
    File_name=[File_pathH,'matrix_next_relate'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'next_relate');%maxin_cell_top to neight_char_fill
    class_matrix=center_matrix;
    next_relate=cell(size_power,File_number);
    for Cla=1:File_number
        File_pathHc=[File_pathD,'plot_',num2str(Cla),'\'];%char_fill_reduce to maxin_density plane_project
        File_name=[File_pathHc,'matrix_cover'];%char_fill_reduce to maxin_density neigth_class_plane
        load(eval('File_name'),'center_matrix');%maxin_cell_top to neight_char_fill
        for p=2:size_power-1
            matrix_class=class_matrix{p,1};
            size_class=size(matrix_class,1);
            matrix_cla=center_matrix{p+1,1};
            size_cla=size(matrix_cla,1);
            if size_class>0&size_cla>0
                next_relate{p,Cla}=matrix_class*matrix_cla';
            end
        end        
        fprintf('end plane_cell_cover Class=%d Cla=%d time£º%6.1f s\n', Class,Cla,toc);
    end
    File_name=[File_pathH,'matrix_next_relate'];%char_fill_reduce to maxin_density neigth_class_plane
    save(eval('File_name'),'next_relate');%maxin_cell_top to neight_char_fill
    fprintf('end matrix_cover_relate Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
for Class=9:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'norm_class','set_fill');%char_fill_reduce to maxin_density plane_neigth
    File_name=[File_pathH,'radius_number'];%maxin_cell_top to neight_char_fill
    load(eval('File_name'),'radius_char','radius_fill');%maxin_cell_top to neight_char_fill
    Len_A=size(norm_class,1);
    cell_char=cell(Len_A,2);
    norm_char=norm_class(:,1)';
    File_name=[File_pathB,File_struct(Class).name];
    matrix_char=zeros(size_power,Len_A);
    matrix_char=readmtx(File_name,Len_A,size_power,'double')';
    for k=1:Len_A
        dist_kj=matrix_char(:,k)'*matrix_char;
        dist_kj=norm_char(k)+norm_char-2*dist_kj;
        cell_char{k,1}=find(dist_kj<=radius_char(k,1));
    end
    fprintf('end cell_char_ Class=%d time£º%6.1f s\n', Class,toc);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    size_fill=length(set_fill);
    cell_fill=cell(1,2);
    if size_fill>0
        cell_fill=cell(size_fill,2);
        norm_fill=norm_class(set_fill,2)';
        File_name=[File_pathC,File_struct(Class).name];
        matrix_fill=zeros(size_power,size_fill);
        if size_fill~=2
            matrix_fill=readmtx(File_name,Len_A,size_power,'double',set_fill,1:size_power)';
        else
            matrix_fill(:,1)=readmtx(File_name,Len_A,size_power,'double',set_fill(1),1:size_power)';
            matrix_fill(:,2)=readmtx(File_name,Len_A,size_power,'double',set_fill(2),1:size_power)';
        end
        for k=1:size_fill
            dist_kj=matrix_fill(:,k)'*matrix_char;
            dist_kj=norm_fill(k)+norm_char-2*dist_kj;
            cell_fill{k,1}=find(dist_kj<=radius_fill(k,1));
            dist_kj=matrix_fill(:,k)'*matrix_fill;
            dist_kj=norm_fill(k)+norm_fill-2*dist_kj;
            cell_fill{k,2}=find(dist_kj<=radius_fill(k,1));
        end
        for k=1:Len_A
            dist_kj=matrix_char(:,k)'*matrix_fill;
            dist_kj=norm_char(k)+norm_fill-2*dist_kj;
            cell_char{k,2}=find(dist_kj<=radius_char(k,1));
        end
    end
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'cell_number'];%char_fill_reduce to maxin_density neigth_class_plane
    save(eval('File_name'),'cell_char','cell_fill');%maxin_cell_top to neight_char_fill
    cell_char=[];cell_fill=[];
    matrix_char=[];
    matrix_fill=[];
    fprintf('end cell_number Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
    load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_density plane_neigth
    File_name=[File_pathH,'cell_number'];%maxin_cell_top to neight_char_fill
    load(eval('File_name'),'cell_char','cell_fill');%maxin_cell_top to neight_char_fill
    File_name=[File_pathH,'radius_plane'];%maxin_cell_top to neight_char_fill
    load(eval('File_name'),'radius_class');%maxin_cell_top to neight_char_fill
    File_name=[File_pathH,'radius_number'];%maxin_cell_top to maxin_cell
    load(eval('File_name'),'radius_char','radius_fill');%maxin_cell_top to maxin_cell
    cell_plane=cell(size_power,8);
    for p=2:size_power-1        
        cell_plane{p,1}=radius_class{p,1};
        cell_plane{p,2}=radius_class{p,2};
        cell_plane{p,3}=radius_char(cell_plane{p,1},:);
        size_char=length(cell_plane{p,1});
        cell_plane{p,4}=cell(size_char,3);
        for k=1:size_char
            post_temp=cell_plane{p,1}(k);            
            cell_plane{p,4}{k,1}=cell_char{post_temp,1};
            cell_plane{p,4}{k,2}=cell_char{post_temp,2};
            cell_plane{p,4}{k,3}=set_fill(cell_plane{p,4}{k,2});
            
        end
        cell_plane{p,5}=radius_class{p,3};
        cell_plane{p,6}=radius_class{p,4};        
        size_fill=length(cell_plane{p,5});
        cell_plane{p,8}=cell(size_fill,3);
        for k=1:size_fill
            post_temp=find(cell_plane{p,5}(k)==set_fill);
            cell_plane{p,7}=[cell_plane{p,7};radius_fill(post_temp,:)];
            cell_plane{p,8}{k,1}=cell_fill{post_temp,1};
            cell_plane{p,8}{k,2}=cell_fill{post_temp,2};
            cell_plane{p,8}{k,3}=set_fill(cell_plane{p,8}{k,2});            
        end
    end
    cell_plane{1,1}=radius_class{1,1};
    cell_plane{1,5}=radius_class{1,3};
    cell_plane{size_power,1}=radius_class{size_power,1};
    cell_plane{size_power,5}=radius_class{size_power,3};
    File_name=[File_pathH,'cell_plane_class'];%maxin_plane to neight_char_fill
    save(eval('File_name'),'cell_plane');%maxin_plane to neight_char_fill
    fprintf('end cell_plane_number Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for Class=1:File_number
    File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathH,'cell_plane_class'];%maxin_plane to neight_char_fill
    load(eval('File_name'),'cell_plane');%maxin_plane to neight_char_fill
    model_class=cell(size_power,8);
    for p=2:size_power-1        
        cell_plane{p,1}=radius_class{p,1};
        cell_plane{p,2}=radius_class{p,2};
        cell_plane{p,3}=radius_char(cell_plane{p,1},:);
        size_char=length(cell_plane{p,1});
        cell_plane{p,4}=cell(size_char,3);
        for k=1:size_char
            post_temp=cell_plane{p,1}(k);            
            cell_plane{p,4}{k,1}=cell_char{post_temp,1};
            cell_plane{p,4}{k,2}=cell_char{post_temp,2};
            cell_plane{p,4}{k,3}=set_fill(cell_plane{p,4}{k,2});
            
        end
        cell_plane{p,5}=radius_class{p,3};
        cell_plane{p,6}=radius_class{p,4};        
        size_fill=length(cell_plane{p,5});
        cell_plane{p,8}=cell(size_fill,3);
        for k=1:size_fill
            post_temp=find(cell_plane{p,5}(k)==set_fill);
            cell_plane{p,7}=[cell_plane{p,7};radius_fill(post_temp,:)];
            cell_plane{p,8}{k,1}=cell_fill{post_temp,1};
            cell_plane{p,8}{k,2}=cell_fill{post_temp,2};
            cell_plane{p,8}{k,3}=set_fill(cell_plane{p,8}{k,2});            
        end
    end
    cell_plane{1,1}=radius_class{1,1};
    cell_plane{1,5}=radius_class{1,3};
    cell_plane{size_power,1}=radius_class{size_power,1};
    cell_plane{size_power,5}=radius_class{size_power,3};
    File_name=[File_pathH,'model_plane'];%maxin_plane to neight_char_fill
    save(eval('File_name'),'model_class');%maxin_plane to neight_char_fill
    fprintf('end model_plane Class=%d time£º%6.1f s\n', Class,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
return;