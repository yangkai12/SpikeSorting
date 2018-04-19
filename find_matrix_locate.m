function  sparse_signal_locate=find_matrix_locate(how_large,j,m,params)
              % Finding the position of the spike corresponding to the
              % sparse signal I-th largest
if j==1
sparse_signal_locate=params.sparse_signal_class1_sort_locate(how_large,m);
else if j==2
sparse_signal_locate=params.sparse_signal_class2_sort_locate(how_large,m);
else if j==3
sparse_signal_locate=params.sparse_signal_class3_sort_locate(how_large,m);        
       end
    end
end












