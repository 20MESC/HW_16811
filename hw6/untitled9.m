L_lower = [7 7 7 5 5; 4 6 5 1 4]

L_lower_new = [];
i=1;
while i <= size(L_lower,2)
    j=i+1
    firstrun = 1;
    temp = [];
    while (j<=size(L_lower,2)) && (L_lower(1,j-1) == L_lower(1,j))
        if firstrun
            temp = [temp L_lower(:,j-1)]
        end
        firstrun = 0;
        temp = [temp L_lower(:,j)]
        j = j+1;
    end
    
    [y_sorted, idx_sort] = sort(temp(2,:),'descend');   
    x_sorted = temp(1,idx_sort);
    sorted_temp = [x_sorted; y_sorted];
    
    nTemp = size(temp,2);
    L_lower_new = [L_lower_new sorted_temp];
    
    i=j
    disp('test')
end