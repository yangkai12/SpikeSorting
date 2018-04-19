function [overlapping_location,Toeplitz_matrix_locate,classes]=MAP_spike_sorting(params,Toeplitz_matrix)
assignments=params.assignments;
search_matrix=params.search_matrix;
length_X=params.length_X;
X=params.X;
length_template1=params.length_template1;
length_template2=params.length_template2;

classes_single=zeros(1,length(assignments));
classes_two_overlap=zeros(2,length(assignments));
classes_three_overlap=zeros(3,length(assignments));

%%  Maximum a posteriori for spike sorting
for m=1:length(assignments)
 for i=1:length(search_matrix)
  for j=1:3
 how_large=search_matrix(i,j); 
 if how_large>0
 sparse_signal_locate=find_matrix_locate(how_large,j,m,params);% Find out the spike position corresponding to the I-th largest of the sparse signal
 matrix_locate(j,i)=sparse_signal_locate;
 I_spike=Toeplitz_matrix(:,sparse_signal_locate);%the spike corresponding to the I-th largest of the sparse signal
 j_I_spike(:,j)=I_spike;%the j-th neuronal spike of the I-th largest of the sparse signal
 else if how_large==0
 j_I_spike(:,j)=zeros(length_X,1);  %The spike segment to be classified does not contain j-th neuron                          
     end
  end
end
All_I_spike=j_I_spike(:,1)+j_I_spike(:,2)+j_I_spike(:,3);%The sum of 3 types of neuron spike
clear j_I_spike;
mean_disstance(:,i)=mean(abs(X(:,m)-All_I_spike));%Calculating the distance, corresponding to the equation(11) in the paper 
 end  
[min_values_per_col,min_values_locate(:,m)]=min(mean_disstance);
Dictionaries_locate(:,m)=matrix_locate(:,min_values_locate(:,m));
 if length(find(search_matrix((min_values_locate(:,m)),:)))==1 %There are a superimposed spike in the unclassified spike segment
classes_single(:,m)=find(search_matrix((min_values_locate(:,m)),:));
 else if  length(find(search_matrix((min_values_locate(:,m)),:)))==2 %There are two superimposed spike in the unclassified spike segment
a=find(search_matrix((min_values_locate(:,m)),:));
classes_two_overlap(1,m)=a(1,1);
classes_two_overlap(2,m)=a(1,2);
 else if  length(find(search_matrix((min_values_locate(:,m)),:)))==3 %There are three superimposed spike in the unclassified spike segment
b=find(search_matrix((min_values_locate(:,m)),:));
classes_three_overlap(1,m)=b(1,1);
classes_three_overlap(2,m)=b(1,2);
classes_three_overlap(3,m)=b(1,3);
        end
     end
  end
end

overlapping_location=find(classes_single==0);  
classes(1,:)=classes_single+classes_two_overlap(1,:)+classes_three_overlap(1,:);
classes(2,:)=classes_two_overlap(2,:)+classes_three_overlap(2,:);
classes(3,:)=classes_three_overlap(3,:);

Toeplitz_matrix_locate(1,:)=Dictionaries_locate(1,:);
Toeplitz_matrix_locate(2,:)=Dictionaries_locate(2,:)-length_template1;
Toeplitz_matrix_locate(2,find(Toeplitz_matrix_locate(2,:)<0))=0;
Toeplitz_matrix_locate(3,:)=Dictionaries_locate(3,:)-(length_template1+length_template2);
Toeplitz_matrix_locate(3,find(Toeplitz_matrix_locate(3,:)<0))=0; 