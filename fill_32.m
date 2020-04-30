function  [line_image,inter_blank,outer_blank]=fill_32(line_image,size_reduce,value_select)
%refers to sel_cell=char_reduce_fill()
% save datab;
% clear;clc;load datab;
%1 1 1 1 1
%1 1 1 1 1
%1 1 1 1 1
%1 1 1 1 1
%1 1 1 1 1
inter_blank=[];
outer_blank=[];
sum_shape=0;
select_size=[];
select_cell=cell(1);
line_image=image_resize(select_cell{max_post},max_size,size_reduce);
line_image(line_image<30)=0;
line_image(line_image>20)=1;
save_image=line_image;
value_contra=~value_select;
[set_row,set_arrange]=find(save_image==value_select);
while ~isempty(set_row)    
    set_bound=[set_row(1),set_arrange(1)];
    save_image(set_row(1),set_arrange(1))=value_contra;    
    shape_temp=set_bound;
    while ~isempty(set_bound)
        center_row=set_bound(1,1);
        center_arrange=set_bound(1,2);
        temp_row=max(center_row-1,1);
        temp_arrange=center_arrange;
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
        temp_arrange=min(center_arrange+1,size_reduce);
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end        
        temp_row=min(center_row+1,size_reduce);
        temp_arrange=center_arrange;
        if save_image(temp_row,temp_arrange)==value_select
            set_bound=[set_bound;[temp_row,temp_arrange]];
            shape_temp=[shape_temp;[temp_row,temp_arrange]];
            save_image(temp_row,temp_arrange)=value_contra;
        end
        set_bound(1,:)=[];
    end
    sum_shape=sum_shape+1;
    select_size(sum_shape)=size(shape_temp,1);
    select_cell{sum_shape}=shape_temp;
    [set_row,set_arrange]=find(save_image==value_select);
end
[sort_size,sort_post]=sort(select_size,'descend');
max_post=sort_post(1);

for k=1:sum_shape
    temp_post=sort_post(k);
    temp_size=sort_size(k);
    set_temp=select_cell{temp_post};
    if temp_size>1
        max_row=max(set_temp);
        min_row=min(set_temp);
    else
        max_row=set_temp;
        min_row=set_temp;
    end
    value_flag=(min_row(1)>1)&(min_row(2)>1)&(max_row(1)<size_reduce)&(max_row(2)<size_reduce);
    if ~value_flag
        outer_blank=[outer_blank;[set_temp(1,:),min_row,max_row,temp_size]];
    else
        inter_blank=[inter_blank;[set_temp(1,:),min_row,max_row,temp_size]];
        for p=1:temp_size
            line_image(set_temp(p,1),set_temp(p,2))=value_contra;
        end
    end
end
return;