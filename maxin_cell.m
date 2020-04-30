% function  sel_cell=maxin_cell()
% from char_fill_reduce to  maxin_plane maxin_plane
clear all;clc;tic;
tol=1e-5;
number_part=50;
File_pathA=['e:\class_character\'];
File_struct=dir([File_pathA,'train_*']);
% File_number=length(File_struct);
File_number=10;
File_pathH='e:\data_0719\';%char_fill_reduce to maxin_density
for loop=5:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathB=['e:\char_',num2str(size_reduce),'_',num2str(size_power),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['e:\fill_',num2str(size_reduce),'_',num2str(size_power),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathHh=[File_pathH,'fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density plane_project
    File_pathI=[File_pathH,'set_cell_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density plane_project
%     mkdir(File_pathI);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for Class=1:File_number
        File_name=[File_pathHh,'plane_norm_',num2str(Class)];%char_fill_reduce to maxin_cell
        load(eval('File_name'),'norm_class');%char_fill_reduce to maxin_density plane_neigth
        Len_A=size(norm_class,1);
        class_norm=norm_class;
        maxin_value=cell(4,2);
        num_fix=fix(Len_A/number_part);
        num_diff=Len_A-num_fix*number_part;
        File_namea=[File_pathB,File_struct(Class).name];
        temp_value=zeros(Len_A,File_number);
        temp_post=zeros(Len_A,File_number);
        for Cla=1:File_number
            if Class~=Cla
                File_name=[File_pathHh,'plane_norm_',num2str(Cla)];%char_fill_reduce to maxin_cell
                load(eval('File_name'),'norm_class');%char_fill_reduce to maxin_density plane_neigth
                Len_B=size(norm_class,1);
                matrix_cla=zeros(Len_B,size_power);
                File_name=[File_pathB,File_struct(Cla).name];
                matrix_cla=readmtx(File_name,Len_B,size_power,'double');
                matrix_temp=repmat(norm_class(:,1),[1,number_part]);
                for p=1:num_fix
                    matrix_class=readmtx(File_namea,Len_A,size_power,'double',(p-1)*number_part+1:p*number_part,1:size_power)';
                    dist_kj=matrix_temp-2*matrix_cla*matrix_class;
                    [min_value,min_post]=min(dist_kj);
                    temp_value((p-1)*number_part+1:p*number_part,Cla)=class_norm((p-1)*number_part+1:p*number_part,1)+min_value';
                    temp_post((p-1)*number_part+1:p*number_part,Cla)=min_post';
                    dist_kj=[];
                    fprintf('end maxin_class_10 char_char p=%d Cla=%d  time£º%6.1f s\n',p,Cla,toc);
                end
                if num_diff>0
                    matrix_class=readmtx(File_namea,Len_A,size_power,'double',num_fix*number_part+1:Len_A,1:size_power)';
                    matrix_temp=repmat(norm_class(:,1),[1,num_diff]);
                    dist_kj=matrix_temp-2*matrix_cla*matrix_class;
                    [min_value,min_post]=min(dist_kj);
                    temp_value(num_fix*number_part+1:end,Cla)=class_norm(num_fix*number_part+1:end,1)+min_value';
                    temp_post(num_fix*number_part+1:end,Cla)=min_post';
                end
                matrix_cla=[];
                matrix_class=[];
            end
            fprintf('end maxin_class_10 char_char Class=%d Cla=%d  time£º%6.1f s\n',Class,Cla,toc);
        end
        maxin_value{1,1}=temp_value;
        maxin_value{2,1}=temp_post;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        temp_value=zeros(Len_A,File_number);
        temp_post=zeros(Len_A,File_number);
        for Cla=1:File_number
            if Class~=Cla
                File_name=[File_pathHh,'plane_norm_',num2str(Cla)];%char_fill_reduce to maxin_cell
                load(eval('File_name'),'norm_class','set_fill');%char_fill_reduce to plane_neigth plane_neigth
                Len_B=size(norm_class,1);
                size_cla=length(set_fill);
                cla_norm=norm_class(set_fill,2);
                matrix_cla=zeros(size_cla,size_power);
                File_name=[File_pathC,File_struct(Cla).name];
                matrix_cla=readmtx(File_name,Len_B,size_power,'double',set_fill,1:size_power);
                matrix_temp=repmat(cla_norm,[1,number_part]);
                for p=1:num_fix
                    matrix_class=readmtx(File_namea,Len_A,size_power,'double',(p-1)*number_part+1:p*number_part,1:size_power)';
                    dist_kj=matrix_temp-2*matrix_cla*matrix_class;
                    [min_value,min_post]=min(dist_kj);
                    temp_value((p-1)*number_part+1:p*number_part,Cla)=class_norm((p-1)*number_part+1:p*number_part,1)+min_value';
                    temp_post((p-1)*number_part+1:p*number_part,Cla)=min_post';
                    dist_kj=[];
                    fprintf('end maxin_class_10 char_fill p=%d Cla=%d  time£º%6.1f s\n',p,Cla,toc);
                end
                if num_diff>0
                    matrix_class=readmtx(File_namea,Len_A,size_power,'double',num_fix*number_part+1:Len_A,1:size_power)';
                    matrix_temp=repmat(cla_norm,[1,num_diff]);
                    dist_kj=matrix_temp-2*matrix_cla*matrix_class;
                    [min_value,min_post]=min(dist_kj);
                    temp_value(num_fix*number_part+1:end,Cla)=class_norm(num_fix*number_part+1:end,1)+min_value';
                    temp_post(num_fix*number_part+1:end,Cla)=min_post';
                end
                matrix_cla=[];
            end
            fprintf('end maxin_class_10 char_fill Class=%d Cla=%d  time£º%6.1f s\n',Class,Cla,toc);
        end
        maxin_value{3,1}=temp_value;
        maxin_value{4,1}=temp_post;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        File_name=[File_pathHh,'plane_norm_',num2str(Class)];%char_fill_reduce to maxin_cell
        load(eval('File_name'),'norm_class','set_fill');%char_fill_reduce to maxin_density plane_neigth
        char_fill=set_fill;
        size_class=length(set_fill);
        num_fix=fix(size_class/number_part);
        num_diff=size_class-num_fix*number_part;
        class_norm=norm_class(set_fill,2);
        File_namea=[File_pathC,File_struct(Class).name];
        temp_value=zeros(size_class,File_number);
        temp_post=zeros(size_class,File_number);
        for Cla=1:File_number
            if Class~=Cla
                File_name=[File_pathHh,'plane_norm_',num2str(Cla)];%char_fill_reduce to maxin_cell
                load(eval('File_name'),'norm_class');%char_fill_reduce to plane_neigth plane_neigth
                Len_B=size(norm_class,1);
                matrix_cla=zeros(Len_B,size_power);
                File_name=[File_pathB,File_struct(Cla).name];
                matrix_cla=readmtx(File_name,Len_B,size_power,'double');
                matrix_temp=repmat(norm_class(:,1),[1,number_part]);
                for p=1:num_fix
                    matrix_class=readmtx(File_namea,Len_A,size_power,'double',char_fill((p-1)*number_part+1:p*number_part),1:size_power)';
                    dist_kj=matrix_temp-2*matrix_cla*matrix_class;
                    [min_value,min_post]=min(dist_kj);
                    temp_value((p-1)*number_part+1:p*number_part,Cla)=class_norm((p-1)*number_part+1:p*number_part,1)+min_value';
                    temp_post((p-1)*number_part+1:p*number_part,Cla)=min_post';
                    dist_kj=[];
                    fprintf('end maxin_class_10 fill_char p=%d Cla=%d  time£º%6.1f s\n',p,Cla,toc);
                end
                if num_diff>0
                    matrix_class=readmtx(File_namea,Len_A,size_power,'double',char_fill(num_fix*number_part+1:size_class),1:size_power)';
                    matrix_temp=repmat(norm_class(:,1),[1,num_diff]);
                    dist_kj=matrix_temp-2*matrix_cla*matrix_class;
                    [min_value,min_post]=min(dist_kj);
                    temp_value(num_fix*number_part+1:end,Cla)=class_norm(num_fix*number_part+1:end,1)+min_value';
                    temp_post(num_fix*number_part+1:end,Cla)=min_post';
                end
                matrix_cla=[];
            end
        end
        fprintf('end maxin_class_10 fill_char Class=%d Cla=%d  time£º%6.1f s\n',Class,Cla,toc);
        maxin_value{1,2}=temp_value;
        maxin_value{2,2}=temp_post;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        temp_value=zeros(size_class,File_number);
        temp_post=zeros(size_class,File_number);
        for Cla=1:File_number
            if Class~=Cla
                File_name=[File_pathHh,'plane_norm_',num2str(Cla)];%char_fill_reduce to maxin_cell
                load(eval('File_name'),'norm_class','set_fill');%char_fill_reduce to plane_neigth plane_neigth
                Len_B=size(norm_class,1);
                size_cla=length(set_fill);
                cla_norm=norm_class(set_fill,2);
                matrix_cla=zeros(size_cla,size_power);
                File_name=[File_pathC,File_struct(Cla).name];
                matrix_cla=readmtx(File_name,Len_B,size_power,'double',set_fill,1:size_power);
                matrix_temp=repmat(cla_norm,[1,number_part]);
                for p=1:num_fix
                    matrix_class=readmtx(File_namea,Len_A,size_power,'double',char_fill((p-1)*number_part+1:p*number_part),1:size_power)';
                    dist_kj=matrix_temp-2*matrix_cla*matrix_class;
                    [min_value,min_post]=min(dist_kj);
                    temp_value((p-1)*number_part+1:p*number_part,Cla)=class_norm((p-1)*number_part+1:p*number_part,1)+min_value';
                    temp_post((p-1)*number_part+1:p*number_part,Cla)=min_post';
                    dist_kj=[];
                    fprintf('end maxin_class_10 fill_fill p=%d Cla=%d  time£º%6.1f s\n',p,Cla,toc);
                end
                if num_diff>0
                    matrix_class=readmtx(File_namea,Len_A,size_power,'double',char_fill(num_fix*number_part+1:size_class),1:size_power)';
                    matrix_temp=repmat(cla_norm,[1,num_diff]);
                    dist_kj=matrix_temp-2*matrix_cla*matrix_class;
                    [min_value,min_post]=min(dist_kj);
                    temp_value(num_fix*number_part+1:end,Cla)=class_norm(num_fix*number_part+1:end,1)+min_value';
                    temp_post(num_fix*number_part+1:end,Cla)=min_post';
                end
                matrix_cla=[];
            end
            fprintf('end maxin_class_10 fill_fill Class=%d Cla=%d  time£º%6.1f s\n',Class,Cla,toc);
        end
        maxin_value{3,2}=temp_value;
        maxin_value{4,2}=temp_post;
        File_name=[File_pathI,'maxin_class_',num2str(Class)];%maxin_cell_top to maxin_cell
        save(eval('File_name'),'maxin_value');%maxin_cell_top to maxin_cell
        matrix_class=[];
        fprintf('end maxin_value Class=%d size_class=%d time£º%6.1f s\n',Class,size_class,toc);
    end
    temp_value=[];
    temp_post=[];
    maxin_value=[];
    fprintf('end maxin_class_10 loop=%d time£º%6.1f s\n',loop,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
tol=1e-6;
for loop=2:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathI=[File_pathH,'set_cell_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density plane_project
%     mkdir(File_pathI);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for Class=1:File_number
        File_name=[File_pathI,'maxin_class_',num2str(Class)];%maxin_cell_top to maxin_cell
        load(eval('File_name'),'maxin_value');%maxin_cell_top to maxin_cell
        maxin_class=cell(3,2);
        set_zeros=cell(2,5);
        value_char=maxin_value{1,1};
        value_char(:,Class)=inf;
        [set_a,set_b]=find(value_char<tol);
        set_zeros{1,1}=[set_a,set_b];
        set_zeros{1,2}=union(set_zeros{1,1}(:,1),[]);
        value_char(value_char<tol)=inf;
        value_fill=maxin_value{3,1};
        value_fill(:,Class)=inf;
        [set_a,set_b]=find(value_fill<tol);
        set_zeros{1,3}=[set_a,set_b];
        set_zeros{1,4}=union(set_zeros{1,3}(:,1),[]);
        set_zeros{1,5}=union(set_zeros{1,2},set_zeros{1,4});
        value_fill(value_fill<tol)=inf;
        post_char=maxin_value{2,1};
        post_fill=maxin_value{4,1};
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
        maxin_class{1,1}=temp_value;
        maxin_class{2,1}=temp_class;
        maxin_class{3,1}=temp_post;
        value_char=maxin_value{1,2};
        value_char(:,Class)=inf;
        [set_a,set_b]=find(value_char<tol);
        set_zeros{2,1}=[set_a,set_b];
        set_zeros{2,2}=union(set_zeros{2,1}(:,1),[]);
        value_char(value_char<tol)=inf;
        value_fill=maxin_value{3,2};
        value_fill(:,Class)=inf;
        [set_a,set_b]=find(value_fill<tol);
        set_zeros{2,3}=[set_a,set_b];
        set_zeros{2,4}=union(set_zeros{2,3}(:,1),[]);
        set_zeros{2,5}=union(set_zeros{2,2},set_zeros{2,4});
        value_fill(value_fill<tol)=inf;
        post_char=maxin_value{2,2};
        post_fill=maxin_value{4,2};
        size_fill=size(value_char,1);
        temp_value=zeros(size_fill,File_number);
        temp_class=zeros(size_fill,File_number);
        temp_post=zeros(size_fill,File_number);
        for Cla=1:File_number
            if Class~=Cla
                for k=1:size_fill
                    [temp_value(k,Cla),temp_class(k,Cla)]=min([value_char(k,Cla),value_fill(k,Cla)]);
                    if temp_class(k,Cla)==1
                        temp_post(k,Cla)=post_char(k,Cla);
                    else
                        temp_post(k,Cla)=post_fill(k,Cla);
                    end
                end
            end
        end
        maxin_class{1,2}=temp_value;
        maxin_class{2,2}=temp_class;
        maxin_class{3,2}=temp_post;
        File_name=[File_pathI,'set_maxin_',num2str(Class)];%maxin_cell_top to maxin_cell
        save(eval('File_name'),'maxin_class','set_zeros');%maxin_cell_top to neight_char_fill
        fprintf('end maxin_zeros Class=%d time£º%6.1f s\n', Class,toc);
    end
    maxin_class=[];
    zeros_class=[];
    fprintf('end set_zeros loop=%d time£º%6.1f s\n',loop,toc);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for loop=2:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathI=[File_pathH,'set_cell_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density plane_project
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for Class=1:File_number
        radius_char=[];
        radius_fill=[];
        File_name=[File_pathI,'set_maxin_',num2str(Class)];%maxin_cell_top to maxin_cell
        load(eval('File_name'),'maxin_class','set_zeros');%maxin_cell_top to neight_char_fill
        value_char=maxin_class{1,1};
        value_char(value_char==0)=inf;
        class_char=maxin_class{2,1};
        post_char=maxin_class{3,1};
        size_char=size(value_char,1);
        [min_value,min_class]=min(value_char(:,1:File_number)');
        temp_value=zeros(size_char,4);
        min_value(min_value==inf)=0;
        temp_value(:,1)=min_value';
        temp_value(:,2)=min_class';
        for k=1:size_char
            temp_cla=min_class(k);
            temp_value(k,3)=class_char(k,temp_cla);
            temp_value(k,4)=post_char(k,temp_cla);
        end
        radius_char=temp_value;
        value_fill=maxin_class{1,2};
        value_fill(value_fill==0)=inf;
        class_fill=maxin_class{2,2};
        post_fill=maxin_class{3,2};
        size_fill=size(value_fill,1);
        [min_value,min_class]=min(value_fill(:,1:File_number)');
        min_value(min_value==inf)=0;
        temp_value=zeros(size_fill,4);
        temp_value(:,1)=min_value';
        temp_value(:,2)=min_class';
        for k=1:size_fill
            temp_cla=min_class(k);
            temp_value(k,3)=class_fill(k,temp_cla);
            temp_value(k,4)=post_fill(k,temp_cla);
        end
        radius_fill=temp_value;
        File_name=[File_pathI,'radius_class_',num2str(Class)];%maxin_cell_top to maxin_cell
        save(eval('File_name'),'radius_char','radius_fill','set_zeros');%maxin_cell_top to neight_char_fill
    end
    temp_value=[];
    radius_char=[];
    radius_fill=[];
    zeros_class=[];
    fprintf('end radius_number_ loop=%d time£º%6.1f s\n',loop,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tol=1e-4;
data_count=100;
for loop=2:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathB=['e:\char_',num2str(size_reduce),'_',num2str(size_power),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['e:\fill_',num2str(size_reduce),'_',num2str(size_power),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathHh=[File_pathH,'fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density plane_project
    File_pathI=[File_pathH,'set_cell_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density plane_project
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    maxin_boot=cell(File_number,9);
    for Class=1:File_number
        File_name=[File_pathHh,'plane_norm_',num2str(Class)];%maxin_cell_top to maxin_cell
        load(eval('File_name'),'norm_class','set_fill');%char_fill_reduce to maxin_density plane_neigth
        File_name=[File_pathI,'radius_class_',num2str(Class)];%maxin_cell_top to maxin_cell
        load(eval('File_name'),'radius_char','radius_fill','set_zeros');%maxin_cell_top to neight_char_fill
        Len_A=size(norm_class,1);
        File_name=[File_pathB,File_struct(Class).name];
        matrix_char=readmtx(File_name,Len_A,size_power,'double');
        File_name=[File_pathC,File_struct(Class).name];
        matrix_fill=readmtx(File_name,Len_A,size_power,'double',set_fill,1:size_power);
        [max_char,post_char]=max(radius_char(:,1));
        [max_fill,post_fill]=max(radius_fill(:,1));
        [max_value,max_class]=max([max_char,max_fill]);
        if max_class==1
            maxin_boot{Class,1}=[max_class post_char radius_char(post_char,:)];
            matrix_vector=matrix_char(post_char,:)';
            norm_vector=norm_class(post_char,1);
        else
            maxin_boot{Class,1}=[max_class post_fill radius_fill(post_fill,:)];
            matrix_vector=matrix_fill(post_fill,:)';
            norm_vector=norm_class(set_fill(post_fill),2);
        end
        dist_kj=matrix_char*matrix_vector;
        dist_kj=norm_vector+norm_class(:,1)-2*dist_kj;
        maxin_boot{Class,2}=find(dist_kj<=max_value);
        dist_kj=matrix_fill*matrix_vector;
        dist_kj=norm_vector+norm_class(set_fill,2)-2*dist_kj;
        maxin_boot{Class,3}=find(dist_kj<=max_value);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        size_char=zeros(Len_A,2);
        max_size=0;
        size_temp=length(set_tol{Class,1});
        for k=1:size_temp
            post_k=set_tol{Class,1}(k);
            dist_kj=matrix_char*matrix_char(post_k,:)';
            dist_kj=norm_class(post_k,1)+norm_class(:,1)-2*dist_kj;
            cell_char=find(dist_kj<=radius_char(post_k,1));
            dist_kj=matrix_fill*matrix_char(post_k,:)';
            dist_kj=norm_class(post_k,1)+norm_class(set_fill,2)-2*dist_kj;
            cell_fill=find(dist_kj<=radius_char(post_k,1));
            size_char(post_k,1)=length(cell_char)+length(cell_fill);
            if size_char(post_k,1)>max_size
                max_size=size_char(post_k,1);
                maxin_boot{Class,4}=[1 post_k max_size radius_char(post_k,:)];
                maxin_boot{Class,5}=cell_char;
                maxin_boot{Class,6}=cell_fill;
            end
        end
        size_char(:,2)=radius_char(:,1);
        size_select=length(set_tol{Class,3});
        for k=1:size_select  
            post_k=set_tol{Class,3}(k);
            post_fill=set_fill(post_k);
            dist_kj=matrix_char*matrix_fill(post_k,:)';
            dist_kj=norm_class(post_fill,2)+norm_class(:,1)-2*dist_kj;
            cell_char=find(dist_kj<=radius_fill(post_k,1));
            dist_kj=matrix_fill*matrix_fill(post_k,:)';
            dist_kj=norm_class(post_fill,2)+norm_class(set_fill,2)-2*dist_kj;
            cell_fill=find(dist_kj<=radius_fill(post_k,1));
            size_temp=length(cell_char)+length(cell_fill);
            if size_temp>max_size
                max_size=size_temp;
                maxin_boot{Class,4}=[2 post_k max_size radius_fill(post_k,:)];
                maxin_boot{Class,5}=cell_char;
                maxin_boot{Class,6}=cell_fill;
            end
        end
        cell_char=cell(Len_A,2);
        size_fill=length(set_fill);
        cell_fill=cell(size_fill,2);        
        for k=1:Len_A
            dist_kj=matrix_char*matrix_char(k,:)';
            dist_kj=norm_class(k,1)+norm_class(:,1)-2*dist_kj;
            cell_temp=find(dist_kj<=radius_char(k,1));
            cell_char{k,1}=setdiff(cell_temp,maxin_boot{Class,5});
            dist_kj=matrix_fill*matrix_char(k,:)';
            dist_kj=norm_class(k,1)+norm_class(set_fill,2)-2*dist_kj;
            cell_temp=find(dist_kj<=radius_char(post_k,1));
            cell_char{k,2}=setdiff(cell_temp,maxin_boot{Class,6});
        end 
        for k=1:size_fill
            post_k=set_fill(k);
            dist_kj=matrix_char*matrix_fill(k,:)';
            dist_kj=norm_class(post_k,2)+norm_class(:,1)-2*dist_kj;
            cell_temp=find(dist_kj<=radius_fill(k,1));
            cell_fill{k,1}=setdiff(cell_temp,maxin_boot{Class,5});
            dist_kj=matrix_fill*matrix_fill(k,:)';
            dist_kj=norm_class(post_k,2)+norm_class(set_fill,2)-2*dist_kj;
            cell_temp=find(dist_kj<=radius_fill(k,1));
            cell_fill{k,2}=setdiff(cell_temp,maxin_boot{Class,6});
        end
        matrix_char=[];
        matrix_fill=[];                
        File_name=[File_pathI,'cell_reduce_',num2str(Class)];%maxin_cell_top to convex_cell
        save(eval('File_name'),'cell_char','cell_fill');%maxin_cell_top to convex_cell
        fprintf('end maxin_boot Class=%d time£º%6.1f s\n', Class,toc);
    end
    File_name=[File_pathI,'convex_boot_reduce'];%maxin_cell_top to convex_cell
    save(eval('File_name'),'set_tol','maxin_boot');%maxin_cell_top to convex_cell
    fprintf('end maxin_boot loop=%d time£º%6.1f s\n',loop,toc);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

return;