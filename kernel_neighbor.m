% function  sel_cell=kernel_neighbor()
% from plane_neighbor to  maxin_plane maxin_plane
clear all;clc;tic;
tol=1e-5;
File_pathA=['W:\MNSIT\class_character\'];
File_struct=dir([File_pathA,'train_*']);
File_number=length(File_struct);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for loop=3:3
    size_reduce=2^loop;
    size_power=size_reduce*size_reduce;
    File_pathB=['W:\MNSIT\char_train\char_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathC=['W:\MNSIT\char_train\fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
    File_pathH=['W:\MNSIT\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
    File_struct=dir([File_pathB,'train_*']);
    
    File_name=[File_pathH,'edge_plane'];%kernel_plane_ to maxin_cell
    load(eval('File_name'),'plane_char','plane_fill','kernel_char','kernel_fill');%kernel_plane_ to maxin_cell
    for Class=1:1File_number
        File_name=[File_pathH,'class_plane_',num2str(Class)];%char_fill_reduce to maxin_cell
        load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_cell
        Class_name=File_struct(Class).name;
        Len_A=fix(File_struct(Class).bytes/(4*size_power));
        File_name=[File_pathB,Class_name];
        matrix_class=readmtx(File_name,Len_A,size_power,'int32');
        File_name=[File_pathC,Class_name];
        size_fill=length(set_fill);
        if (size_fill>0)
            class_fill=zeros(size_power,size_fill);
            if size_fill~=2
                class_fill=readmtx(File_name,Len_A,size_power,'int32',set_fill,1:size_power);
            else
                class_fill(1,:)=readmtx(File_name,Len_A,size_power,'int32',set_fill(1),1:size_power);
                class_fill(2,:)=readmtx(File_name,Len_A,size_power,'int32',set_fill(2),1:size_power);
            end
        end
        value_char=cell(size_power,File_number);
        value_fill=cell(size_power,File_number);
        for Cla=1:File_number
            if (Class~=Cla)
                File_name=[File_pathH,'class_plane_',num2str(Cla)];%char_fill_reduce to maxin_cell
                load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_cell
                Cla_name=File_struct(Cla).name;
                Len_B=fix(File_struct(Cla).bytes/(4*size_power));
                File_name=[File_pathB,Cla_name];
                matrix_cla=readmtx(File_name,Len_B,size_power,'int32')';
                File_name=[File_pathC,Cla_name];
                size_fill=length(set_fill);
                if (size_fill>0)
                    cla_fill=zeros(size_power,size_fill);
                    if size_fill~=2
                        cla_fill=readmtx(File_name,Len_B,size_power,'int32',set_fill,1:size_power)';
                    else
                        cla_fill(:,1)=readmtx(File_name,Len_B,size_power,'int32',set_fill(1),1:size_power);
                        cla_fill(:,2)=readmtx(File_name,Len_B,size_power,'int32',set_fill(2),1:size_power);
                    end
                end
                for p=1:size_power
                    char_class=kernel_char{p,Class};
                    size_class=length(char_class);
                    if (size_class>0)                        
                        maxvalue=zeros(1,size_class);
                        maxclass=zeros(1,size_class);
                        maxpost=zeros(1,size_class);
                        maxchar=zeros(1,size_class);
                        rowchar=zeros(1,size_class);
                        if (size_class>2)&&(size_fill>1)
                            dist_kj=matrix_class(char_class,:)*matrix_cla;
                            [maxchar,rowchar]=max(dist_kj');
                        else
                            for k=1:size_class
                                dist_kj=matrix_class(char_class(k),:)*matrix_cla;
                                [maxchar(k),rowchar(k)]=max(dist_kj);
                            end
                        end
                        maxfill=zeros(1,size_class);
                        rowfill=zeros(1,size_class);
                        if (size_class>2)&&(size_fill>1)
                            dist_kj=matrix_class(char_class,:)*cla_fill;
                            [maxfill,rowfill]=max(dist_kj');
                        elseif (size_fill>0)
                            for k=1:size_class
                                dist_kj=matrix_class(char_class(k),:)*cla_fill;
                                [maxfill(k),rowfill(k)]=max(dist_kj);
                            end                        
                        end
                        [maxvalue,maxclass]=max([maxchar;maxfill]);
                        for k=1:size_class
                            if (maxclass(k)==1)
                                maxpost(k)=rowchar(k);
                            else
                                maxpost(k)=rowfill(k);
                            end
                        end
                        value_char{p,Cla}=[maxvalue;maxclass;maxpost];
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    char_class=kernel_fill{p,Class};
                    size_class=length(char_class);
                    if (size_class>0)   
                        maxvalue=zeros(1,size_class);
                        maxclass=zeros(1,size_class);
                        maxpost=zeros(1,size_class);
                        maxchar=zeros(1,size_class);
                        rowchar=zeros(1,size_class);
                        if (size_class>2)&&(size_fill>1)
                            dist_kj=class_fill(char_class,:)*matrix_cla;
                            [maxchar,rowchar]=max(dist_kj');
                        else
                            for k=1:size_class
                                dist_kj=class_fill(char_class(k),:)*matrix_cla;
                                [maxchar(k),rowchar(k)]=max(dist_kj);
                            end
                        end
                        maxfill=zeros(1,size_class);
                        rowfill=zeros(1,size_class);
                        if (size_class>2)&&(size_fill>1)
                            dist_kj=class_fill(char_class,:)*cla_fill;
                            [maxfill,rowfill]=max(dist_kj');
                        elseif (size_fill>0)
                            for k=1:size_class
                                dist_kj=class_fill(char_class(k),:)*cla_fill;
                                [maxfill(k),rowfill(k)]=max(dist_kj);
                            end
                        end
                        [maxvalue,maxclass]=max([maxchar;maxfill]);
                        for k=1:size_class
                            if (maxclass(k)==1)
                                maxpost(k)=rowchar(k);
                            else
                                maxpost(k)=rowfill(k);
                            end
                        end
                        value_fill{p,Cla}=[maxvalue;maxclass;maxpost];
                    end
                end
            end
            fprintf('end kernel_neighbor loop=%d  Class=%d Cla=%d  time£º%6.1f s\n',loop,Class,Cla,toc);
        end
        File_name=[File_pathH,'max_value_',num2str(Class)];%kernel_neighbor to maxin_cell
        save(eval('File_name'),'value_char','value_fill');%kernel_neighbor to maxin_cell
        fprintf('end kernel_neighbor loop=%d  Class=%d  time£º%6.1f s\n',loop,Class,toc);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for loop=2:5
%     size_reduce=2^loop;
%     size_power=size_reduce*size_reduce;
%     File_pathB=['E:\char_train\char_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
%     File_pathC=['E:\char_train\fill_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density project_base_class
%     File_pathH=['E:\char_train\matlab_set_',num2str(size_reduce),'\'];%char_fill_reduce to maxin_density
%     File_struct=dir([File_pathB,'train_*']);
%     
%     File_name=[File_pathH,'edge_plane'];%kernel_plane_ to maxin_cell
%     load(eval('File_name'),'plane_char','plane_fill','kernel_char','kernel_fill');%kernel_plane_ to maxin_cell
%     for Class=15:File_number
%         File_name=[File_pathH,'class_plane_',num2str(Class)];%char_fill_reduce to maxin_cell
%         load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_cell
%         Class_name=File_struct(Class).name;
%         Len_A=fix(File_struct(Class).bytes/(4*size_power));
%         File_name=[File_pathB,Class_name];
%         matrix_class=readmtx(File_name,Len_A,size_power,'int32');
%         File_name=[File_pathC,Class_name];
%         size_fill=length(set_fill);
%         if (size_fill>0)
%             class_fill=zeros(size_power,size_fill);
%             if size_fill~=2
%                 class_fill=readmtx(File_name,Len_A,size_power,'int32',set_fill,1:size_power);
%             else
%                 class_fill(1,:)=readmtx(File_name,Len_A,size_power,'int32',set_fill(1),1:size_power);
%                 class_fill(2,:)=readmtx(File_name,Len_A,size_power,'int32',set_fill(2),1:size_power);
%             end
%         end
%         plane_char=cell(size_power,File_number);
%         plane_fill=cell(size_power,File_number);
%         for Cla=1:File_number
%             if (Class~=Cla)
%                 File_name=[File_pathH,'class_plane_',num2str(Cla)];%char_fill_reduce to maxin_cell
%                 load(eval('File_name'),'set_fill');%char_fill_reduce to maxin_cell
%                 Cla_name=File_struct(Cla).name;
%                 Len_B=fix(File_struct(Cla).bytes/(4*size_power));
%                 File_name=[File_pathB,Cla_name];
%                 matrix_cla=readmtx(File_name,Len_B,size_power,'int32')';
%                 File_name=[File_pathC,Cla_name];
%                 size_fill=length(set_fill);
%                 if (size_fill>0)
%                     cla_fill=zeros(size_power,size_fill);
%                     if size_fill~=2
%                         cla_fill=readmtx(File_name,Len_B,size_power,'int32',set_fill,1:size_power)';
%                     else
%                         cla_fill(:,1)=readmtx(File_name,Len_B,size_power,'int32',set_fill(1),1:size_power);
%                         cla_fill(:,2)=readmtx(File_name,Len_B,size_power,'int32',set_fill(2),1:size_power);
%                     end
%                 end
%                 for p=1:size_power
%                     char_class=kernel_char{p,Class};
%                     size_class=length(char_class);                    
%                     if (size_class>0)
%                         char_cla=kernel_char{p,Cla};
%                         size_cla=length(char_cla);
%                         maxvalue=zeros(1,size_class);
%                         maxclass=zeros(1,size_class);
%                         maxpost=zeros(1,size_class);
%                         maxchar=zeros(1,size_class);
%                         rowchar=zeros(1,size_class);
%                         if (size_class>2)&&(size_cla>2)
%                             dist_kj=matrix_class(char_class,:)*matrix_cla(char_cla,:);
%                             [maxchar,temp]=max(dist_kj');
%                             rowchar=char_cla(temp);
%                         elseif (size_cla>1)
%                             for k=1:size_class
%                                 dist_kj=matrix_class(char_class(k),:)*matrix_cla(char_cla,:);
%                                 [maxchar(k),temp]=max(dist_kj);
%                                 rowchar(k)=char_cla(temp);
%                             end
%                         elseif (size_cla==1)
%                             for k=1:size_class
%                                 maxchar(k)=matrix_class(char_class(k),:)*matrix_cla(char_cla,:);
%                                 rowchar(k)=char_cla;
%                             end
%                         end
%                         maxfill=zeros(1,size_class);
%                         rowfill=zeros(1,size_class);
%                         char_cla=kernel_fill{p,Cla};
%                         size_cla=length(char_cla);
%                         if (size_class>2)&&(size_cla>2)
%                             dist_kj=matrix_class(char_class,:)*cla_fill(char_cla,:);
%                             [maxfill,temp]=max(dist_kj');
%                             rowfill=char_cla(temp);
%                         elseif (size_cla>1)
%                             for k=1:size_class
%                                 dist_kj=matrix_class(char_class(k),:)*cla_fill(char_cla,:);
%                                 [maxfill(k),temp]=max(dist_kj);
%                                 rowfill(k)=char_cla(temp);
%                             end
%                         elseif (size_cla==1)
%                             for k=1:size_class
%                                 maxfill(k)=matrix_class(char_class(k),:)*cla_fill(char_cla,:);
%                                 rowfill(k)=char_cla;
%                             end
%                         end   
%                         [maxvalue,maxclass]=max([maxchar;maxfill]);
%                         for k=1:size_class
%                             if (maxclass(k)==1)
%                                 maxpost(k)=rowchar(k);
%                             else
%                                 maxpost(k)=rowfill(k);
%                             end
%                         end
%                         plane_char{p,Cla}=[maxvalue;maxclass;maxpost];
%                     end
%                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     char_class=kernel_fill{p,Class};
%                     size_class=length(char_class);
%                     if (size_class>0)
%                         char_cla=kernel_char{p,Cla};
%                         size_cla=length(char_cla);
%                         maxvalue=zeros(1,size_class);
%                         maxclass=zeros(1,size_class);
%                         maxpost=zeros(1,size_class);
%                         maxchar=zeros(1,size_class);
%                         rowchar=zeros(1,size_class);
%                         if (size_class>2)&&(size_fill>1)
%                             dist_kj=matrix_class(char_class,:)*matrix_cla;
%                             [maxchar,rowchar]=max(dist_kj');
%                         else
%                             for k=1:size_class
%                                 dist_kj=matrix_class(char_class(k),:)*matrix_cla;
%                                 [maxchar(k),rowchar(k)]=max(dist_kj);
%                             end
%                         end
%                         maxfill=zeros(1,size_class);
%                         rowfill=zeros(1,size_class);
%                         if (size_class>2)&&(size_fill>1)
%                             dist_kj=matrix_class(char_class,:)*cla_fill;
%                             [maxfill,rowfill]=max(dist_kj');
%                         elseif (size_fill>0)
%                             for k=1:size_class
%                                 dist_kj=matrix_class(char_class(k),:)*cla_fill;
%                                 [maxfill(k),rowfill(k)]=max(dist_kj);
%                             end
%                         end
%                         [maxvalue,maxclass]=max([maxchar;maxfill]);
%                         for k=1:size_class
%                             if (maxclass(k)==1)
%                                 maxpost(k)=rowchar(k);
%                             else
%                                 maxpost(k)=rowfill(k);
%                             end
%                         end
%                         plane_fill{p,Cla}=[maxvalue;maxclass;maxpost];
%                     end
%                 end
%             end
%             fprintf('end kernel_neighbor loop=%d  Class=%d Cla=%d  time£º%6.1f s\n',loop,Class,Cla,toc);
%         end
%         File_name=[File_pathH,'max_plane_',num2str(Class)];%kernel_neighbor to maxin_cell
%         save(eval('File_name'),'plane_char','plane_fill');%kernel_neighbor to maxin_cell
%         fprintf('end kernel_neighbor loop=%d  Class=%d  time£º%6.1f s\n',loop,Class,toc);
%     end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
return;