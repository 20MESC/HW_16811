function [sorted] = sortByYDescend(sortedByX)
% Extremely hacky, poor implenetation of a sorting function which takes in
% a list sorted (MUST BE PRESORTED ONCE!) by X and subsorts the Y values in 
% descending order for each group of identical Xs


    sorted = [];
    i=1;
    while i <= size(sortedByX,2)
        j=i+1;
        firstrun = 1;
        temp = [];
        while (j<=size(sortedByX,2)) && (sortedByX(1,j-1) == sortedByX(1,j))
            if firstrun
                temp = [temp sortedByX(:,j-1)];
            end
            firstrun = 0;
            temp = [temp sortedByX(:,j)];
            j = j+1;
        end

        [y_sorted, idx_sort] = sort(temp(2,:),'descend');   
        x_sorted = temp(1,idx_sort);
        sorted_temp = [x_sorted; y_sorted];

        nTemp = size(temp,2);
        sorted = [sorted sorted_temp];

        i=j;
    end
    
end