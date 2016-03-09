#Principal Component Analysis on 2 different datasets describing Knee Motion Angles

##Which group is which? and how can you justify your choice?

**The z1 data set is the age-matched control group, while the z2 data set is the group with arthritis.**

I came to this conclusion by first analyzing how the graph of one signal changes while incrementing the k value
in both the z1 and z2 datasets. I therefore concluded that because the z1 data was most similar to the original signal
after the reconstructions, it should be the control group which should have the less variance. 

I then confirmed this by analyzing the sums of the signal reconstruction errors in a graph. Calculating the sum of the average differences for
z1 and z2 I discover that the z1 reconstruction error < z2 reconstruction error which therefore supports my answer that z2 has more variance and is the arthritis group. 
