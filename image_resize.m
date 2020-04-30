function  extract_image=image_resize(set_max,max_size,size_reduce)
%refers to sel_cell=char_conver()foreg_eigen_eight
%save datar;
%%
% clear;clc;load datar;
tol=0.5;
size_set=size(set_max,1);
extract_image=zeros(max_size,max_size);
for k=1:size_set
    extract_image(set_max(k,1),set_max(k,2))=1;
end
sum_row=sum(extract_image');
sum_arrange=sum(extract_image);
while sum_row(1)==0|sum_row(end)==0|sum_arrange(1)==0|sum_arrange(end)==0
    find_row=find(sum_row>0);
    find_arrange=find(sum_arrange>0);
    temp_image=extract_image(find_row(1):find_row(end),find_arrange(1):find_arrange(end));
    extract_image=imresize(temp_image,[size_reduce size_reduce]);
    extract_image(extract_image>0.1)=1;
    extract_image(extract_image<0.2)=0;    
    sum_row=sum(extract_image');
    sum_arrange=sum(extract_image);
end
return;