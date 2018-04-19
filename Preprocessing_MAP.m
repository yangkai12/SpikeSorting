function Short_window_length=Preprocessing_MAP(segment_centers_cl,win_len_less,assignments)
% Segment_centers_cl represents the time of the center point of each spike segment
% Assignments represent results of k-means clustering
spike_sampling_length(1,1)=segment_centers_cl(1,1);
for i=2:length(assignments)
    spike_sampling_length(i,1)=segment_centers_cl(i,1)-segment_centers_cl(i-1,1);
end          % The difference between the center point of the current segment and the center point of the last segment.
[Short_window_length,b]=find(spike_sampling_length<win_len_less);
             % We find that segment with distance difference less than win_len_less may overlap from the last segment.