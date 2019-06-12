### This code is associated with the paper from Wehnekamp et al., "Nanoresolution real-time 3D orbital tracking for studying mitochondrial trafficking in vertebrate axons in vivo". eLife, 2019. http://dx.doi.org/10.7554/eLife.46059

# Zebrafish-Paper
This Matlab script including functions is not programmed to be published software. It is supposed to help the reader analyzing the data. Hence, we do not guarantee execution without crashes nor do we take any responsibilities for any damages on your hardware.

For any questions, please contact the research group of Prof. Don C. Lamb, Ludwig-Maximilians Universität München.

In the following, the structure of the custom data files (.txt) is described

Rows 1 - 11: File Header with general informatiion about measurement
From row 13 on:
Columns 1 and 2: voltage of XY-mirrors (scaling factor: 17.3 µm/V)
Column 3: voltage of z-Piezo (scaling factor: 10.0 µm/V)  
Column 4: number of performed orbit
Column 5: calculated orbit time of performed orbit
Columns 6 and 7: intensieties of APD pair
Column 8: number of camera frame
Column 9: Boolean of tracked particle of corresponding orbit (0: no particle tracked; 1: particle tracked)  
Columns 10 and 11: values for long rage tracking in X and Y
