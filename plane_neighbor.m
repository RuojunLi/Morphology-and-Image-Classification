% function  sel_cell=plane_neighbor()
% from char_fill_reduce to  kernel_neighbor maxin_plane
clear all;clc;tic;
tol=1e-5;
File_pathA=['W:\MNSIT\class_character\'];
File_struct=dir([File_pathA,'train_*']);
File_number=length(File_struct);

for loop=2:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
    plane_char=cell(size_power,File_number);
    plane_fill=cell(size_power,File_number);
    for Class=1:File_number        
        File_name=[File_pathH,'class_plane_',num2str(Class)];%char_fill_reduce to maxin_cell
        load(eval('File_name'),'set_plane');%char_fill_reduce to maxin_cell        
        for p=1:size_power
            plane_char{p,Class}=set_plane{p,1};
            plane_fill{p,Class}=set_plane{p,3};
        end
    end
    File_name=[File_pathH,'plane_char_fill'];%plane_neighbor to maxin_cell
    save(eval('File_name'),'plane_char','plane_fill');%plane_neighbor to maxin_cell 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for loop=2:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathB=['W:\MNSIT\char_train\char_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['W:\MNSIT\char_train\fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%plane_neighbor to maxin_density
    File_name=[File_pathH,'plane_char_fill'];%char_fill_reduce to maxin_cell
    load(eval('File_name'),'plane_char','plane_fill');%plane_neighbor to maxin_cell 
    File_struct=dir([File_pathB,'train_*']);
    diff_char=plane_char;
    diff_fill=plane_fill;
    for Class=1:File_number
        File_name=[File_pathH,'class_plane_',num2str(Class)];%char_fill_reduce to maxin_cell
        load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_cell        
        Class_name=File_struct(Class).name;
        Len_A=fix(File_struct(Class).bytes/(4*size_power));
        File_name=[File_pathB,Class_name];
        %matrix_class=readmtx(File_name,Len_A,size_power,'int32');
        File_name=[File_pathC,Class_name];
        size_fill=length(set_fill);
        if (size_fill>0)
            matrix_fill=zeros(size_power,size_fill);
            if size_fill~=2
                matrix_fill=readmtx(File_name,Len_A,size_power,'int32',set_fill,1:size_power);
            else
                matrix_fill(1,:)=readmtx(File_name,Len_A,size_power,'int32',set_fill(1),1:size_power);
                matrix_fill(2,:)=readmtx(File_name,Len_A,size_power,'int32',set_fill(2),1:size_power);
            end
        end        
        for p=1:size_power
            char_class=plane_char{p,Class};
            size_class=length(char_class);
            if (size_class>2)
                dist_kj=matrix_class(char_class,:)*matrix_class(char_class,:)';
                set_temp=[];
                for k=1:size_class
                    dist_kj(k,1:k)=0;
                    find_post=find(dist_kj(k,:)==p);
                    set_temp=union(set_temp,char_class(find_post));
                end
                diff_char{p,Class}=setdiff(diff_char{p,Class},set_temp);
            elseif (size_class==2)
                dist_kj=matrix_class(char_class(1),:)*matrix_class(char_class(2),:)';
                if (dist_kj==p)
                    diff_char{p,Class}=diff_char{p,Class}(1);
                end            
            end
            fill_class=plane_fill{p,Class};
            size_fill=length(fill_class);
            if (size_fill>2)
                dist_kj=matrix_fill(fill_class,:)*matrix_fill(fill_class,:)';
                set_temp=[];
                for k=1:size_fill
                    dist_kj(k,1:k)=0;
                    find_post=find(dist_kj(k,:)==p);
                    set_temp=union(set_temp,fill_class(find_post));
                end
                diff_fill{p,Class}=setdiff(diff_fill{p,Class},set_temp);
            elseif (size_fill==2)
                dist_kj=matrix_fill(fill_class(1),:)*matrix_fill(fill_class(2),:)';
                if (dist_kj==p)
                    diff_fill{p,Class}=diff_fill{p,Class}(1);
                end            
            end
            char_class=diff_char{p,Class};
            size_char=length(char_class);
            fill_class=diff_fill{p,Class};
            size_fill=length(fill_class);
            if (size_char>2)&&(size_fill>2)
                dist_kj=matrix_class(char_class,:)*matrix_fill(fill_class,:)';
                set_temp=[];
                for k=1:size_char
                    find_post=find(dist_kj(k,:)==p);
                    set_temp=union(set_temp,fill_class(find_post));
                end
                diff_fill{p,Class}=setdiff(diff_fill{p,Class},set_temp);                
            else
                set_temp=[];
                for k=1:size_char
                    for j=1:size_fill
                        dist_kj=matrix_class(char_class(k),:)*matrix_fill(fill_class(j),:)';
                        if (dist_kj==p)
                            set_temp=union(set_temp,fill_class(j));
                        end
                    end
                end
                diff_fill{p,Class}=setdiff(diff_fill{p,Class},set_temp);
            end 
            fprintf('end plane_chfill_diff Class=%d p=%d  time£º%6.1f s\n',Class,p,toc);
        end
        fprintf('end plane_chfill_diff Class=%d loop=%d  time£º%6.1f s\n',Class,loop,toc);
    end
    File_name=[File_pathH,'plane_chfill_diff'];%plane_neighbor to maxin_cell
    save(eval('File_name'),'diff_char','diff_fill');%plane_neighbor to maxin_cell    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for loop=5:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathB=['W:\MNSIT\char_train\char_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['W:\MNSIT\char_train\fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
    File_name=[File_pathH,'plane_chfill_diff'];%char_fill_reduce to maxin_cell
    load(eval('File_name'),'diff_char','diff_fill');%char_fill_reduce to maxin_cell
    File_struct=dir([File_pathB,'train_*']);
    kernel_char=diff_char;
    kernel_fill=diff_fill;
    for Class=1:File_number
        File_name=[File_pathH,'class_plane_',num2str(Class)];%char_fill_reduce to maxin_cell
        load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_cell        
        Class_name=File_struct(Class).name;
        Len_A=fix(File_struct(Class).bytes/(4*size_power));
        File_name=[File_pathB,Class_name];
        matrix_class=readmtx(File_name,Len_A,size_power,'int32');
        File_name=[File_pathC,Class_name];
        size_fill=length(set_fill);
        matrix_fill=[];
        if (size_fill>0)
            if size_fill~=2
                matrix_fill=readmtx(File_name,Len_A,size_power,'int32',set_fill,1:size_power);
            else
                matrix_fill(1,:)=readmtx(File_name,Len_A,size_power,'int32',set_fill(1),1:size_power);
                matrix_fill(2,:)=readmtx(File_name,Len_A,size_power,'int32',set_fill(2),1:size_power);
            end
        end        
        for Cla=1:File_number
            if (Class~=Cla)
                Cla_name=File_struct(Cla).name;
                Len_B=fix(File_struct(Cla).bytes/(4*size_power));
                File_name=[File_pathB,Cla_name];
                matrix_cla=readmtx(File_name,Len_B,size_power,'int32');
                for p=1:size_power                
                    char_class=diff_char{p,Class};
                    size_class=length(char_class);
                    char_cla=diff_char{p,Cla};
                    size_cla=length(char_cla);
                    union_class=[];
                    union_cla=[];
                    union_fill=[];
                    if (size_class>2)&&(size_cla>2)
                        dist_kj=matrix_cla(char_cla,:)*matrix_class(char_class,:)';
                        [maxrow,maxcolus]=find(dist_kj==p);
                        union_class=union([],char_class(maxcolus));
                        union_cla=union([],char_cla(maxrow));
                    elseif (size_class>0)&&(size_cla>0)
                        for k=1:size_class
                            for j=1:size_cla
                                dist_kj=matrix_class(char_class(k),:)*matrix_cla(char_cla(j),:)';
                                if (dist_kj==p)
                                    union_class=union(union_class,char_class(k));
                                    union_cla=union(union_cla,char_cla(j));
                                end
                            end
                        end
                    end
                    fill_class=diff_fill{p,Class};
                    size_fill=length(fill_class);
                    if (size_fill>2)&&(size_cla>2)
                        dist_kj=matrix_cla(char_cla,:)*matrix_fill(fill_class,:)';
                        [maxrow,maxcolus]=find(dist_kj==p);
                        union_fill=union([],fill_class(maxcolus));
                        union_cla=union(union_cla,char_cla(maxrow));
                    elseif (size_fill>0)&&(size_cla>0)
                        for k=1:size_fill
                            for j=1:size_cla
                                dist_kj=matrix_fill(fill_class(k),:)*matrix_cla(char_cla(j),:)';
                                if (dist_kj==p)
                                    union_fill=union(union_fill,fill_class(k));
                                    union_cla=union(union_cla,char_cla(j));
                                end
                            end                            
                        end
                    end
                    kernel_char{p,Class}=setdiff(kernel_char{p,Class},union_class);
                    kernel_char{p,Cla}=setdiff(kernel_char{p,Cla},union_cla);
                    kernel_fill{p,Class}=setdiff(kernel_fill{p,Class},union_fill);
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                File_name=[File_pathH,'class_plane_',num2str(Cla)];%char_fill_reduce to maxin_cell
                load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_cell
                File_name=[File_pathC,Cla_name];
                size_fill=length(set_fill);
                matrix_cla=[];
                if (size_fill>0)
                    if size_fill~=2
                        matrix_cla=readmtx(File_name,Len_B,size_power,'int32',set_fill,1:size_power);
                    else
                        matrix_cla(1,:)=readmtx(File_name,Len_B,size_power,'int32',set_fill(1),1:size_power);
                        matrix_cla(2,:)=readmtx(File_name,Len_B,size_power,'int32',set_fill(2),1:size_power);
                    end
                end
                for p=1:size_power                
                    char_class=diff_char{p,Class};
                    size_class=length(char_class);
                    char_cla=diff_fill{p,Cla};
                    size_cla=length(char_cla);
                    union_class=[];
                    union_cla=[];
                    union_fill=[];
                    if (size_class>2)&&(size_cla>2)
                        dist_kj=matrix_cla(char_cla,:)*matrix_class(char_class,:)';
                        [maxrow,maxcolus]=find(dist_kj==p);
                        union_class=union([],char_class(maxcolus));
                        union_cla=union([],char_cla(maxrow));
                    elseif (size_class>0)&&(size_cla>0)
                        for k=1:size_class
                            for j=1:size_cla
                                dist_kj=matrix_class(char_class(k),:)*matrix_cla(char_cla(j),:)';
                                if (dist_kj==p)
                                    union_class=union(union_class,char_class(k));
                                    union_cla=union(union_cla,char_cla(j));
                                end
                            end
                        end
                    end                    
                    fill_class=diff_fill{p,Class};
                    size_fill=length(fill_class);
                    if (size_fill>2)&&(size_cla>2)
                        dist_kj=matrix_cla(char_cla,:)*matrix_fill(fill_class,:)';
                        [maxrow,maxcolus]=find(dist_kj==p);
                        union_fill=union([],fill_class(maxcolus));
                        union_cla=union(union_cla,char_cla(maxrow));
                    elseif (size_fill>0)&&(size_cla>0)
                        for k=1:size_fill
                            for j=1:size_cla
                                dist_kj=matrix_fill(fill_class(k),:)*matrix_cla(char_cla(j),:)';
                                if (dist_kj==p)
                                    union_fill=union(union_fill,fill_class(k));
                                    union_cla=union(union_cla,char_cla(j));
                                end
                            end
                        end
                    end
                    kernel_char{p,Class}=setdiff(kernel_char{p,Class},union_class);
                    kernel_fill{p,Cla}=setdiff(kernel_fill{p,Cla},union_cla);
                    kernel_fill{p,Class}=setdiff(kernel_fill{p,Class},union_fill);
                end
            end
            fprintf('end kernel_char loop=%d  Class=%d Cla=%d  time£º%6.1f s\n',loop,Class,Cla,toc);
        end
        
    end
    File_name=[File_pathH,'kernel_plane'];%plane_neighbor to kernel_neighbor
    save(eval('File_name'),'kernel_char','kernel_fill');%plane_neighbor to kernel_neighbor
end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for loop=2:5
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathB=['W:\MNSIT\char_train\char_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['W:\MNSIT\char_train\fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
    File_struct=dir([File_pathB,'train_*']);
    
    File_name=[File_pathH,'plane_char_fill'];%char_fill_reduce to maxin_cell
    load(eval('File_name'),'plane_char','plane_fill');%char_fill_reduce to maxin_cell     
    File_name=[File_pathH,'kernel_plane'];%kernel_plane_ to maxin_cell
    load(eval('File_name'),'kernel_char','kernel_fill');%kernel_plane_ to maxin_cell
    edge_char=cell(size_power,File_number);
    edge_fill=cell(size_power,File_number);
    for Class=1:File_number
        for p=1:size_power 
            edge_char{p,Class}=setdiff(plane_char{p,Class},kernel_char{p,Class});
            edge_fill{p,Class}=setdiff(plane_fill{p,Class},kernel_fill{p,Class});
        end
    end
    File_name=[File_pathH,'edge_plane'];%plane_neighbor to maxin_cell
    save(eval('File_name'),'edge_char','edge_fill','plane_char','plane_fill','kernel_char','kernel_fill');%plane_neighbor to maxin_cell
    fprintf('end kernel_char loop=%d time£º%6.1f s\n',loop,toc);
end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_pathG=['W:\MNSIT\char_train\plane_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
mkdir(File_pathG);

for Class=1:File_number
    loop_char=cell(size_power,12);
    loop_fill=cell(size_power,12);
    for loop=2:5
        size_reduce=2^loop;
        size_power=size_reduce*size_reduce;
        File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
        File_name=[File_pathH,'edge_plane'];%plane_neighbor to maxin_cell
        load(eval('File_name'),'edge_char','edge_fill','plane_char','plane_fill','kernel_char','kernel_fill');%plane_neighbor to maxin_cell
        
        for p=1:size_power 
            loop_char{p,loop-1}=plane_char{p,Class};
            loop_fill{p,loop-1}=plane_fill{p,Class};
            loop_char{p,loop+3}=edge_char{p,Class};
            loop_fill{p,loop+3}=edge_fill{p,Class};
            loop_char{p,loop+7}=kernel_char{p,Class};
            loop_fill{p,loop+7}=kernel_fill{p,Class};
        end
    end
    File_name=[File_pathG,'plane_loop_',num2str(Class)];%plane_neighbor to maxin_cell
    save(eval('File_name'),'loop_char','loop_fill');%plane_neighbor to maxin_cell
    fprintf('end loop_char Class=%d time£º%6.1f s\n',Class,toc);
end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for loop=2:2
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathB=['W:\MNSIT\char_train\char_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['W:\MNSIT\char_train\fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
    File_struct=dir([File_pathB,'train_*']);
    
    File_name=[File_pathH,'edge_plane'];%kernel_plane_ to maxin_cell
    load(eval('File_name'),'edge_char','edge_fill','plane_char','plane_fill','kernel_char','kernel_fill');%kernel_plane_ to maxin_cell
    for Class=1:File_number
        for p=1:size_power 
            edge_char{p,Class}=setdiff(plane_char{p,Class},kernel_char{p,Class});
            edge_fill{p,Class}=setdiff(plane_fill{p,Class},kernel_fill{p,Class});
        end
    end
    File_name=[File_pathH,'edge_plane'];%kernel_plane_ to maxin_cell
    save(eval('File_name'),'edge_char','edge_fill','plane_char','plane_fill','kernel_char','kernel_fill');%kernel_plane_ to maxin_cell
    fprintf('end kernel_char loop=%d time£º%6.1f s\n',loop,toc);
end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%