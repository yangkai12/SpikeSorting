=====================================================================================
||  Sparsecoding and CompressivesensingSpikesortDemo ==========================================================================================

This package contains matlab code for sorting/estimating spikes of
 neurons recorded with one or more extracellular electrodes.  Unlike
commonly used clustering methods, this method can recover temporally 
overlapping spikes through use of a sparse representation algorithm known as 
Sparse coding and Compressive Sensing.The method is described in this paper:Sparse Coding and Compressive Sensing for Overlapping Neural Spike Sorting. In this paper, the source code for solving the sparse signal of equation (9) can be downloaded from  https://sites.google.com/site/sparsereptool/home/tutorial-and-code, http://ivpl.ece.northwestern.edu/content/research-projects/16195,respectively.The CBP algorithm code in the paper comes from https://github.com/chinasaur/CBPSpikesortDemo.

=====================================================================================
OUTLINE OF METHOD: (0)Load raw data, stored in an array containing electrode voltages (each row is a separate electrode). Sampling rate should be at least 5kHz.PRE-PROCESSING:(1) Filter. Purpose is to eliminate low and high frequency noise (increasing the signal-to-noise ratio of the data) and to allow isolation of noise regions (for whitening, step 2) by thresholding.(2) Covariance over time and electrodes is computed on low-amplitude portions of data. The entire data array is then (separably) whitened by linearly transforming across electrodes, and filtering over time. (3)Select number of cells, and initialize spike templates. Initial templates are obtained from the centroids of k-means clustering in a principal components space. Note: this NOT used to identify/estimate spikes - it is only used to determine the number of cells, and to obtain initial estimates of their waveforms.(4)By peak detection method, the filtered and whiten voltage trace is segmented into some chips containing the peaks. The segmented spikes are just what we need to sort.SPARSE CODING AND COMPRESSIVE SENSING:(5)Sparse coding and compressed sensing algorithm are used to get sparse signal respectively.The code to implement this process is Toeplitz_matrix.m,KSRSC.m,example.m,respectively.Where KSRSC.m and example.m are sparse coding and compressive sensing codes, respectively, which can be found on the previous website.(6)Maximum a posteriori for spike sorting.The code to implement this process is Preprocessing_MAP.m,TenToN.m,MAP_spike_sorting.m,find_matrix_locate.m,optimization_spike_sorting.m.(7)Get the spike time.The code to implement this process is get_spike_times.m

 POST-PROCESSING:

(8) Compare sparse coding and compressive sensing results to CBP,Clustering, and ground truth (true spikes,if available).

====================================================================================Note that the code for steps (0)-(4) and step (8) is consistent with the K-means clustering implementation process, and its code can be found from https://github.com/chinasaur/CBPSpikesortDemo.
 




