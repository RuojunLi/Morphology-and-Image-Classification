function  [line_image,shape_pip]=connectivity_8(line_image,max_size,size_reduce,value_select)
%refers to sel_cell=char_reduce_fill()
% save data;
% clear;clc;load data;
%1 1 1
%1 ? 1
%1 1 1
sum_shape=0;
select_size=[];
select_cell=cell(1);
line_image(line_image>20)=1;
line_image(line_image<0.9)=0;
value_contra=~value_select;
save_image=line_image;
[set_row,set_arrange]=find(save_image==value_select);
while ~isempty(set_row)
    set_bound=[set_row(1),set_arrange(1)];
    center_row=set_row(1);
    center_arrange=set_arrange(1);
    save_image(center_row,center_arrange)=value_contra;    
    shape_temp=set_bound;
    sum_shape=sum_shape+1;
    while ~isempty(set_bound)
        center_row=set_bound(1,1);
        center_arrange=set_bound(1,2);
        temp_row=max(center_row-1,1);       
        temp_arrange=max(center_arrange-1,1);
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end
        temp_arrange=center_arrange;
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end
        temp_arrange=min(center_arrange+1,max_size);
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end
        temp_row=center_row;
        temp_arrange=max(center_arrange-1,1);
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end        
        temp_arrange=min(center_arrange+1,max_size);
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end
        temp_row=min(center_row+1,max_size);
        temp_arrange=max(center_arrange-1,1);
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end
        temp_arrange=center_arrange;
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end
        temp_arrange=min(center_arrange+1,max_size);
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end
        set_bound(1,:)=[];
    end
    select_size(sum_shape)=size(shape_temp,1);
    select_cell{sum_shape}=shape_temp;
    [set_row,set_arrange]=find(save_image==value_select);
end
[sort_size,sort_post]=sort(select_size,'descend');
shape_pip=[];
for k=1:sum_shape
    temp_post=sort_post(k);
    temp_size=sort_size(k);
    shape_pip=[shape_pip;[select_cell{temp_post}(1,:),temp_size]];
end
if value_select==1
    max_post=sort_post(1);
    line_image=image_resize(select_cell{max_post},max_size,size_reduce);    
end
return;