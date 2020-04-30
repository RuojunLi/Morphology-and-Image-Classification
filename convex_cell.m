% function  sel_cell=convex_cell()
% from char_fill_reduce to  maxin_plane maxin_plane
%
clear all;clc;tic;
tol=1e-5;
number_part=300;
File_pathA=['P:\class_character\'];
File_struct=dir([File_pathA,'train_*']);
% File_number=length(File_struct);
File_number=10;
File_pathH='P:\data_0719\';%char_fill_reduce to maxin_density
% mkdir(File_pathD);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File_number=10;
tol=1e-2;
for loop=2:3
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathB=['p:\char_',num2str(size_reduce),'_',num2str(size_power),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['p:\fill_',num2str(size_reduce),'_',num2str(size_power),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathHh=[File_pathH,'fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density plane_project
    File_pathI=[File_pathH,'set_cell_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density plane_project
    File_name=[File_pathI,'convex_boot_reduce'];%maxin_cell_top to maxin_cell
    load(eval('File_name'),'set_tol','maxin_boot');%maxin_cell_top to neight_char_fill
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for Class=1:File_number
        File_name=[File_pathHh,'plane_norm_',num2str(Class)];%maxin_cell_top to maxin_cell
        load(eval('File_name'),'norm_class','set_fill');%char_fill_reduce to maxin_density plane_neigth
        File_name=[File_pathI,'radius_number_',num2str(Class)];%maxin_cell_top to maxin_cell
        load(eval('File_name'),'radius_char','radius_fill');%maxin_cell_top to neight_char_fill
        Len_A=size(norm_class,1);
        size_char=size(radius_char,1);
        size_fill=size(radius_fill,1);
        rad_char=sqrt(radius_char(:,1));
        rad_fill=sqrt(radius_fill(:,1));
        loop_p=1;
        cover_class=cell(1,9);
        set_convex=cell(1,4);
        diff_char=zeros(size_char,1);
        diff_fill=zeros(size_fill,1);
        set_convex{1,1}=maxin_boot{loop_p,4};
        set_convex{1,2}=maxin_boot{loop_p,5};
        cover_class{loop_p,1}=maxin_boot{loop_p,3};        
        cover_class{loop_p,2}=maxin_boot{loop_p,4};
        cover_class{loop_p,3}=maxin_boot{loop_p,5};
        for k=1:size_char
            cell_char{k,1}=setdiff(cell_char{k,1},char_max);
            cell_char{k,2}=setdiff(cell_char{k,2},fill_max);
            diff_char(k)=length(cell_char{k,1})+length(cell_char{k,2});
        end
        for k=1:size_fill
            cell_fill{k,1}=setdiff(cell_fill{k,1},char_max);
            cell_fill{k,2}=setdiff(cell_fill{k,2},fill_max);
            diff_fill(k)=length(cell_fill{k,1})+length(cell_fill{k,2});
        end
        densit_max=10;
        data_count=50;
        rad_char(rad_char<tol)=inf;
        rad_fill(rad_fill<tol)=inf;
        while densit_max>tol
            loop_p=loop_p+1;
            diff_char(diff_char<data_count)=0;
            diff_fill(diff_fill<data_count)=0;
            densit_char=diff_char./rad_char;
            densit_fill=diff_fill./rad_fill;
            [max_char,post_char]=max(densit_char);
            [max_fill,post_fill]=max(densit_fill);
            [densit_max,max_class]=max([max_char,max_fill]);
            if max_class==1
                char_max=cell_char{post_char,1};
                fill_max=cell_char{post_char,2};
                cover_class{loop_p,1}=[0 densit_max post_char radius_char(post_char,1)  diff_char(post_char) char_fill(post_char,1)];
            else
                char_max=cell_fill{post_fill,1};
                fill_max=cell_fill{post_fill,2};
                cover_class{loop_p,1}=[1 densit_max post_fill radius_fill(post_fill,1) diff_fill(post_fill) char_fill(set_fill(post_fill),2) set_fill(post_fill)];
            end
            for k=1:size_char
                cell_char{k,1}=setdiff(cell_char{k,1},char_max);
                cell_char{k,2}=setdiff(cell_char{k,2},fill_max);
                diff_char(k)=length(cell_char{k,1})+length(cell_char{k,2});
            end
            for k=1:size_fill
                cell_fill{k,1}=setdiff(cell_fill{k,1},char_max);
                cell_fill{k,2}=setdiff(cell_fill{k,2},fill_max);
                diff_fill(k)=length(cell_fill{k,1})+length(cell_fill{k,2});
            end
            set_convex{1,1}=union(set_convex{1,1},char_max);
            set_convex{1,2}=union(set_convex{1,2},fill_max);
            cover_class{loop_p,2}=char_max;
            cover_class{loop_p,3}=fill_max;
            fprintf('end plane_cell_cover Class=%d loop_p=%d time£º%6.1f s\n', Class,loop_p,toc);
        end
        File_name=[File_pathH,'cell_number'];%char_fill_reduce to maxin_density neigth_class_plane
        load(eval('File_name'),'cell_char','cell_fill');%maxin_cell_top to neight_char_fill
        for k=1:loop_p
            post_class=cover_class{k,1}(1);
            post_max=cover_class{k,1}(3);
            if post_class==0
                cover_class{k,4}=cell_char{post_max,1};
                cover_class{k,5}=cell_char{post_max,2};
            else
                cover_class{k,4}=cell_fill{post_max,1};
                cover_class{k,5}=cell_fill{post_max,2};
            end
            cover_class{k,6}=char_fill(cover_class{k,4},1);
            cover_class{k,7}=char_fill(set_fill(cover_class{k,5}),2);
            cover_class{k,8}=[min(cover_class{k,6}),max(cover_class{k,6})];
            cover_class{k,9}=[min(cover_class{k,7}),max(cover_class{k,7})];
        end
        set_convex{1,3}=setdiff(1:size_char,set_convex{1,1});
        set_convex{1,4}=setdiff(1:size_fill,set_convex{1,2});
        File_name=[File_pathH,'cover_cell'];%char_fill_reduce to maxin_density neigth_class_plane
        save(eval('File_name'),'cover_class','set_convex');%maxin_cell_top to neight_char_fill
        fprintf('end plane_cell_cover Class=%d time£º%6.1f s\n', Class,toc);
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File_number=10;
% for Class=1:File_number
%     File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
%     File_name=[File_pathH,'matrix_cover'];%char_fill_reduce to maxin_density neigth_class_plane
%     load(eval('File_name'),'center_matrix');%maxin_cell_top to neight_char_fill
%     class_matrix=center_matrix;
%     next_relate=cell(size_power,File_number);
%     for Cla=1:File_number
%         File_pathHc=[File_pathD,'plot_',num2str(Cla),'\'];%char_fill_reduce to maxin_density plane_project
%         File_name=[File_pathHc,'matrix_cover'];%char_fill_reduce to maxin_density neigth_class_plane
%         load(eval('File_name'),'center_matrix');%maxin_cell_top to neight_char_fill
%         for p=2:size_power-1
%             matrix_class=class_matrix{p,1};
%             size_class=size(matrix_class,1);
%             matrix_cla=center_matrix{p+1,1};
%             size_cla=size(matrix_cla,1);
%             if size_class>0&size_cla>0
%                 next_relate{p,Cla}=acos(matrix_class*matrix_cla')*180/pi;
%             end
%         end        
%         fprintf('end matrix_cover_relate Class=%d Cla=%d time£º%6.1f s\n', Class,Cla,toc);
%     end
%     File_name=[File_pathH,'matrix_next_relate'];%char_fill_reduce to maxin_density neigth_class_plane
%     save(eval('File_name'),'next_relate');%maxin_cell_top to neight_char_fill
%     fprintf('end matrix_cover_relate Class=%d time£º%6.1f s\n', Class,toc);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for Class=1:File_number
%     File_pathH=[File_pathD,'plot_',num2str(Class),'\'];%char_fill_reduce to maxin_density plane_project
%     File_name=[File_pathH,'set_norm'];%char_fill_reduce to maxin_density neigth_class_plane
%     load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_density plane_neigth
%     File_name=[File_pathH,'cell_number'];%maxin_cell_top to neight_char_fill
%     load(eval('File_name'),'cell_char','cell_fill');%maxin_cell_top to neight_char_fill
%     File_name=[File_pathH,'radius_plane'];%maxin_cell_top to neight_char_fill
%     load(eval('File_name'),'radius_class');%maxin_cell_top to neight_char_fill
%     File_name=[File_pathH,'radius_number'];%maxin_cell_top to maxin_cell
%     load(eval('File_name'),'radius_char','radius_fill');%maxin_cell_top to maxin_cell
%     cell_plane=cell(size_power,8);
%     for p=2:size_power-1        
%         cell_plane{p,1}=radius_class{p,1};
%         cell_plane{p,2}=radius_class{p,2};
%         cell_plane{p,3}=radius_char(cell_plane{p,1},:);
%         size_char=length(cell_plane{p,1});
%         cell_plane{p,4}=cell(size_char,3);
%         for k=1:size_char
%             post_temp=cell_plane{p,1}(k);            
%             cell_plane{p,4}{k,1}=cell_char{post_temp,1};
%             cell_plane{p,4}{k,2}=cell_char{post_temp,2};
%             cell_plane{p,4}{k,3}=set_fill(cell_plane{p,4}{k,2});
%             
%         end
%         cell_plane{p,5}=radius_class{p,3};
%         cell_plane{p,6}=radius_class{p,4};        
%         size_fill=length(cell_plane{p,5});
%         cell_plane{p,8}=cell(size_fill,3);
%         for k=1:size_fill
%             post_temp=find(cell_plane{p,5}(k)==set_fill);
%             cell_plane{p,7}=[cell_plane{p,7};radius_fill(post_temp,:)];
%             cell_plane{p,8}{k,1}=cell_fill{post_temp,1};
%             cell_plane{p,8}{k,2}=cell_fill{post_temp,2};
%             cell_plane{p,8}{k,3}=set_fill(cell_plane{p,8}{k,2});            
%         end
%     end
%     cell_plane{1,1}=radius_class{1,1};
%     cell_plane{1,5}=radius_class{1,3};
%     cell_plane{size_power,1}=radius_class{size_power,1};
%     cell_plane{size_power,5}=radius_class{size_power,3};
%     File_name=[File_pathH,'cell_plane_class'];%maxin_plane to neight_char_fill
%     save(eval('File_name'),'cell_plane');%maxin_plane to neight_char_fill
%     fprintf('end cell_plane_number Class=%d time£º%6.1f s\n', Class,toc);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

return;