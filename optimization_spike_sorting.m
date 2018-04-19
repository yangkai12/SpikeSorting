function Toeplitz_matrix_locate=optimization_spike_sorting(params)
overlapping_location=params.overlapping_location;
Short_window_length=params.Short_window_length;
Toeplitz_matrix_locate=params.Toeplitz_matrix_locate;
classes=params.classes;
assignments=params.assignments;
loc_star_disc1=params.loc_star_disc1; 
loc_end_disc1=params.loc_end_disc1;
loc_star_disc2=params.loc_star_disc2;
loc_end_disc2=params.loc_end_disc2; 
loc_star_disc3=params.loc_star_disc3;
loc_end_disc3=params.loc_end_disc3;


%% After removing the peak potential fragments of two time lengths less than Short_window_length, the overlap spike is recalculated.
for i=1:length(overlapping_location)
    Short_window=find(Toeplitz_matrix_locate(:,Short_window_length(find(overlapping_location(1,i)==Short_window_length),1)));
    %Find overlapping fragments, and the time interval between the fragment and the center point of the last segment is less than Short_window_length.
    if (~isempty(Short_window))&&length(Short_window)<3                                                                            
    Short_window(3,1)=0;
    end
    before1_classes=Short_window_length(find(overlapping_location(1,i)==Short_window_length),1)-1;%Find out the last spike of two fragments whose center time is less than Short_window_length.
    [a,b]=max(Toeplitz_matrix_locate(:,before1_classes));
     if (~isempty(Short_window))&&(Short_window(1,1)==b)...%At present, spike has the same class as the previous spike, and the current spike is closer to the previous one.
 &&(Toeplitz_matrix_locate(Short_window(1,1),overlapping_location(1,i))<Toeplitz_matrix_locate(Short_window(2,1),overlapping_location(1,i)))
        classes(1,overlapping_location(1,i))=0;
    else if (~isempty(Short_window))&&(Short_window(2,1)==b)...%At present, spike has the same class as the previous spike, and the current spike is closer to the previous one.
 &&(Toeplitz_matrix_locate(Short_window(1,1),overlapping_location(1,i))>Toeplitz_matrix_locate(Short_window(2,1),overlapping_location(1,i)))
        classes(2,overlapping_location(1,i))=0;
    else if (~isempty(Short_window))&&(Short_window(3,1)==b)...%At present, spike has the same class as the previous spike, and the current spike is closer to the previous one.
 &&((Toeplitz_matrix_locate(Short_window(1,1),overlapping_location(1,i))>Toeplitz_matrix_locate(Short_window(3,1),overlapping_location(1,i)))...
 &(Toeplitz_matrix_locate(Short_window(2,1),overlapping_location(1,i))>Toeplitz_matrix_locate(Short_window(3,1),overlapping_location(1,i))))
        classes(3,overlapping_location(1,i))=0; 
        end
     end
  end
end
 
classes_single1=zeros(1,length(assignments));
classes_two_overlap1=zeros(2,length(assignments));
classes_three_overlap1=zeros(3,length(assignments));
classes1=zeros(3,length(assignments));
for i=1:length(assignments)
    if length(find(classes(:,i)))==1
       classes_single1(1,i)=classes(find(classes(:,i)),i);
    else if length(find(classes(:,i)))==2
       classes_two_overlap1(:,i)=classes(find(classes(:,i)),i);
    else if length(find(classes(:,i)))==3
       classes_three_overlap1(:,i)=classes(find(classes(:,i)),i);
           end
        end
    end
end
 
classes1(1,:)=classes_single1+classes_two_overlap1(1,:)+classes_three_overlap1(1,:);
classes1(2,:)=classes_two_overlap1(2,:)+classes_three_overlap1(2,:);
classes1(3,:)=classes_three_overlap1(3,:);

%%  
clear a;
clear b;
for i=1:length(assignments) 
  a=find(classes1(:,i)); 
  for j=1:3
      if j==1 
          m=loc_star_disc1;%The position less than m or greater than n will be abandoned
          n=loc_end_disc1;
      else if j==2
          m=loc_star_disc2;
          n=loc_end_disc2;
      else if j==3
          m=loc_star_disc3;
          n=loc_end_disc3;
          end
      end
  end
  b=(find(((Toeplitz_matrix_locate(j,i)>0)&(Toeplitz_matrix_locate(j,i)<m))||(Toeplitz_matrix_locate(j,i)>n)));
   if ~isempty(b)
      b=j;
      Toeplitz_matrix_locate(b,i)=0;
   end
 end
if (length(a)==1)&&(classes1(a(1,1),i)==1)
  Toeplitz_matrix_locate(2,i)=0;  
  Toeplitz_matrix_locate(3,i)=0;
else if (length(a)==1)&&(classes1(a(1,1),i)==2)
  Toeplitz_matrix_locate(1,i)=0;  
  Toeplitz_matrix_locate(3,i)=0;
else if (length(a)==1)&&(classes1(a(1,1),i)==3)
  Toeplitz_matrix_locate(1,i)=0;  
  Toeplitz_matrix_locate(2,i)=0;
else if (length(a)==2)&&((classes1(a(1,1),i)==1)&&(classes1(a(2,1),i)==2)...
            ||(classes1(a(1,1),i)==2)&&(classes1(a(2,1),i)==1))
  Toeplitz_matrix_locate(3,i)=0;
else if (length(a)==2)&&((classes1(a(1,1),i)==1)&&(classes1(a(2,1),i)==3)...
            ||(classes1(a(1,1),i)==3)&&(classes1(a(2,1),i)==1))
  Toeplitz_matrix_locate(2,i)=0; 
else if (length(a)==2)&&((classes1(a(1,1),i)==2)&&(classes1(a(2,1),i)==3)...
            ||(classes1(a(1,1),i)==3)&&(classes1(a(2,1),i)==2))
  Toeplitz_matrix_locate(1,i)=0;  
            end
          end 
        end
      end
    end
  end
end
