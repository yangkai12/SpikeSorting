function [spike_times]=get_spike_times(segment_centers_cl,assignments,Toeplitz_matrix_locate,neuron1_central,neuron2_central,neuron3_central)
%% Get Spike time
clear a; 
sc_cs_spike_times=zeros(3,length(assignments));
for i=1:length(assignments) 
   a=find(Toeplitz_matrix_locate(:,i));
   if (length(a)==1)&&(a==1)
    sc_cs_spike_times(a(1),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(1),i)-neuron1_central);
   else if (length(a)==1)&&(a==2)
    sc_cs_spike_times(a(1),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(1),i)-neuron2_central);
   else if (length(a)==1)&&(a==3)
    sc_cs_spike_times(a(1),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(1),i)-neuron3_central);
   else if (length(a)==2)&&((a(1)==1)&&(a(2)==2))
    sc_cs_spike_times(a(1),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(1),i)-neuron1_central);       
    sc_cs_spike_times(a(2),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(2),i)-neuron2_central); 
   else if (length(a)==2)&&((a(1)==1)&&(a(2)==3))
    sc_cs_spike_times(a(1),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(1),i)-neuron1_central);       
    sc_cs_spike_times(a(2),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(2),i)-neuron3_central); 
   else if (length(a)==2)&&((a(1)==2)&&(a(2)==3))
    sc_cs_spike_times(a(1),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(1),i)-neuron2_central);       
    sc_cs_spike_times(a(2),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(2),i)-neuron3_central);  
   else if length(a)==3
    sc_cs_spike_times(a(1),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(1),i)-neuron1_central);       
    sc_cs_spike_times(a(2),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(2),i)-neuron2_central); 
    sc_cs_spike_times(a(3),i)=segment_centers_cl(i,1)+(Toeplitz_matrix_locate(a(3),i)-neuron3_central); 
                 end
               end
             end
           end   
         end
       end
   end
end

clear a;
spike_times=cell(3,1);   
for j=1:3
   a=find(sc_cs_spike_times(j,:));
spike_times{j}=sc_cs_spike_times(j,a);
end

end