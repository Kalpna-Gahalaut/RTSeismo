# RTSeismo
- [RTSeismo](#RTSeismo)
  - [Introduction](#introduction)
  - [How to run](#How-to-run)
  - [Licence](#licence)
  - [Step-by-Step Procedure on how to run the Software](#Step-by-Step-Procedure-on-how-to-run-the-Software)


## Introduction

This code is a MATLAB-based User interface application program which 
calculates stresses and pore pressure in poroelastic medium due to 
a finite time varying surface reservoir. Other than computing pore pressure, 
the software also has a module to resolve stresses on a fault plane to 
simulate the change in Coulomb stress due to reservoir impoundment with graphics. It 
helps in assessing the effect of reservoir impoundment on the seismogenic 
faults and its role in the occurrence of reservoir triggered seismicity

No such software based on analytical method seems to be available in 
which source is considered as surface load, particularly in the context 
of reservoir triggered seismicity.


## How to run

`RTSeismo` requires MATLAB. Install the Latest version of `MATLAB`. 

Download the RTSeimo folder in a directory. In RTSeismo, the computation begins by running the Main_Interface application program (Main_Interface.mlapp) by opening the current directory (RTSeismo) in MATLAB, which is designed and developed using the MATLAB App Designer wherein the main interface layer which is the main window pops up consisting of different panels with different programs running in the background where one can enter the required input, get the results and plots. Sample data files are also given in the same folder.

							or

Simply type in the Matlab command window:

 Main_Interface <Enter>
	    or 
Find Main_Interface in the APP tab of Matlab.


## Licence

MIT

## Step-by-Step Procedure on how to run the Software

**Title: RTSeismo: A new Matlab-based Graphical User Interface tool for analyzing triggered seismicity due to surface reservoir 			   impoundment**

**1. Details of all data files to be used by the software:**
                Coordinate system:  x axis points north, y axis points east and z axis vertically downward.
	        Origin of the system: origin of cuboid at dam site.
  1.1 The parameters and the format of the input data file are as follows and the file name should be saved as “Inp-Res-WL.dat”.
    The first row of the data file should contain the value of:
    
        i) N = Total Number of cuboids in which the reservoir water load is simulated.
       
    The second row should contain the following values:
    
        i) MM = Total number of time epochs of water load at dam site.
        ii) c1 = factor to convert days into seconds.
       
     From the third row it should contain the water level data in the following format till it reaches the total number of time epochs 
     of water load at the dam site:
     
        i) ntime = number of time epoch.
        ii) date = date of time epoch.
        iii) pk = reservoir water level from MSL (in meter) at a particular date of time epoch at dam site.
	
     After it reaches the MM value from the next row it should contain the information of the water load as below:
     
	  i) nn = Number of cuboids of reservoir water load.
	  ii) X0 = Dimension of the cuboid in x direction (in meter).
	  iii) Y0 = Dimension of the cuboid in y direction (in meter).
	  iv) XX1 = Distance between origin of the cuboid and origin of the system in x direction (in meter).
	  v) YY1 = Distance between origin of the cuboid and calculation point in y direction (in meter). 
	  vi) pf = maximum water column height in the cuboid (in meter).
   
 1.2 The following are data files necessary to do plotting must be included in the directory (RTSeismo) and the format of the data of 
    the particular files is as follows.
   
     “Reservoir.dat”
   
	 Longitude and latitude of origin of “N” cuboids

      “Waterlevel.dat”
      
	  Date and reservoir water level from MSL (in meter) of total number of time epochs at dam site

      “Earthquake.xls”
      
	  Longitude and latitude of earthquakes.

**2. Main Interface Layer:**

In RTSeismo, the computation begins by running the Main_Interface application program (Main_Interface.mlapp) by opening the current directory (RTSeismo) in MATLAB, which is designed and developed using the MATLAB App Designer wherein the main interface layer pops up consisting of different panels with different programs running in the background where one can enter the required input, get the results and plots (Fig. 2). The workflow of different panels is explained below in detail.

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/8098450f-00fc-45f4-80f6-ef288e057d33)

Figure 2: The Main Interface Layer Window.

**2.1 Import Data File Panel:**

The input data file panel has an edit field and a browse button (coded as uigetfile ({'*.*'}, 'File Selector')) where one can browse for the “Input file” ( Fig. 3). In this application, the main file needed is Inp-Res-WL.dat (details of all the data entries are given in Supplementary material). Reservoir data (Reservoir.dat) related to reservoir geometry, time history of maximum reservoir water level data (Waterlevel.dat) at the dam site, and earthquake data (Earthquake.xls) are additional data files needed for plotting. The same folder (RTSeismo) which contains the codes should include all these data files.

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/9568262c-71aa-4f22-b156-c3ce129fd587)

Figure 3: Figure shows the highlighted panel for importing input data file into the program.

**2.2 Module 1 Panel:** 

This panel consists of two links one is “PE Components in Planview” and the other is “PE Components in Timeseries” (Fig. 4). Details of the background process of these two links are explained below.

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/9a698c2d-e1c8-410b-8075-b48f191c29b4)

Figure 4: Figure shows the highlighted panel for calculating PE components.

**2.3 Module 2 Panel:**

The Module 2 panel consists of two links: “Fault Stability in Planview and Plotting” and “Fault Stability in Timeseries and Plotting”.

**3. Illustrative example:**

Here, to demonstrate how the application software is implemented, we will use a sample dataset same as used in [13].

**3.1 PE Components in Planview:** 

The equations to simulate the spatial variation of PE- components at a particular time epoch have been coded in MATLAB and the codes have been linked to the “PE Components in Planview”. Whenever the user clicks the link it prompts with a window “Input Arguments for Plan View” (Fig. 5).

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/9d685acd-fd4f-48cc-a272-f181947ab28b)

Figure 5: Figure shows the Input Argument window which appears after clicking the highlighted link.

Description of Input arguments are as below:

L – Number of calculation points in x direction 

M – Number of calculation points in y direction

Z – Depth of Calculation (in meter) 

C – Hydraulic diffusivity (in m2/s)

Tdisc – Discretization in water level time series at dam site (in days)

SC – Skempton’s coefficient

Xobs – Distance between origin of system and southmost calculation point in x direction (in meter) 

Yobs – Distance between origin of system and westmost calculation point in y direction (in meter) 

Xdisc – Discretization in calculation grid in x direction (in meter) 

Ydisc – Discretization in calculation grid in y direction (in meter) 

Damhmsl – Height from MSL at the origin of the system (in meter)

nt – time epoch of calculation (corresponding to “ntime” in data file in Supplementary material) 

After entering the parameters, by clicking the buttons “STRESS”, DIFFUSION PP” and STRESSINDUCED PP”, the codes stress_p.m and ppdiffusion_p.m and ppstressinduced_p.m will be executed in the background, to calculate stress, diffusion pore pressure and stressinduced pore pressure.

The obtained results of stress (Fig. 6) and diffusion pore pressure (Fig. 7) will be displayed in the result panel, and will be saved in the RTSeismo directory as stress_result_p.dat (six components of stress) and ppdiffusion_result_p.dat (diffusion pore pressure).

The code ppstressinduced_p.m takes a long time to execute. It will be updated further to speed up the process in the future.

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/1a0182e1-3994-4360-97a9-980b00cf9afe)

Figure 6: Figure shows the sample result of six stress components (Eqs.1a-1f in Manuscript) in Planview

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/391a340f-8b64-4ae9-808e-c20d4b257554)

Figure 7: Figure shows the sample result of diffusion pore pressure (Eqs. 2 in Manuscript) in Planview.

**3.2 PE Components in Timeseries:**

Programs related to temporal variations of the components at a particular location are linked to the “PE Components in Timeseries”. When the user clicks the link, a popup “Input Arguments for Timeseries” appears to enter the necessary parameters (Fig. 8).

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/f2298a84-1b59-45c0-85c4-4f09560af883)

Figure 8: Figure shows the Input Argument window which appears after clicking the highlighted link.

Description of Input arguments are as below:

L – 1 (As number of observation points in x direction will always be one) 

M – 1 (As Number of observation points in y direction will always be one)

Z – Depth of Calculation (in meter)

C – Hydraulic diffusivity (in m2/s)

Tdisc – Discretization in water level time series at dam site (in days)

SC – Skempton’s coefficient

Xobs – Distance between origin of the system and calculation point in x direction (in meter)

Yobs – Distance between origin of the system and calculation point in y direction (in meter)

Damhmsl – Height from MSL at the origin of the system (in meter)

After entering the parameters, the codes stress_t.m, ppdiffusion_t.m, and ppstressinduced_t.m, which are linked to the respective "STRESS", "DIFFUSION PP," and "STRESSINDUCED PP" buttons will be executed in order to calculate stress, diffusion pore pressure, and stress-induced pore pressure. The results of stress (Fig. 9), diffusion pore pressure (Fig. 10), and stress induced pore pressure (Fig. 11) will be displayed in the result panel and saved in the RTSeismo directory as stress _result_t.dat (six stress components), ppdiffusion_result_t.dat (diffusion pore pressure), and ppstressinduced_result_t.dat (stressinduced pore pressure).

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/a220f8d8-e78d-46d6-b2ec-54bf91485a43)

Figure 9: Figure shows the sample result of six stress components (Eqs 1a-1f in Manuscript) in Timeseries.

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/462097cc-2f23-475d-a3b2-248afa79a482)

 Figure 10: Figure shows the sample result of diffusion pore pressure (Eqs. 2 in Manuscript) in Timeseries.
 
![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/36ef2d51-d80b-4412-9c87-3375584899f7)

Figure 11: Figure shows the sample result of stress-induced pore pressure (Eqs. 4 in Manuscript) in Timeseries.

**3.3 Fault Stability in Planview and Plotting:** 

To compute and plot spatial variation of fault Stability the user has to click on “Fault stability in Planview and Plotting” and needs to provide parameters in popped-up window (Fig. 12). 

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/3481ce12-45f2-41b8-8c6b-63acbf785a7b)

Figure 12:  Input Argument window which appears after clicking the highlighted link.

Description of Input parameters are as below:

Th – Dip of the fault

ALAM – Dip direction of the fault

Shi – Rake of the fault

Mu – Coefficient of friction

Olat – latitude of origin of the system (in km)

Olon – longitude of origin of the system (in km)

Olatd – distance between 1° latitude in reservoir region (in km)

Olond – distance between 1° longitude in reservoir region (in km)

Once “Plot” button is clicked (Fig. 12), the program (FS_p.m) will use these parameters to compute the resolved shear and normal stress on the fault plane (Δτ and Δσ), and fault stability (ΔS and ΔSP) in Planview. These results are stored as FS_Planview_results.dat file in RTSeismo directory and will be plotted through Matlab code Planview_Plot.m as illustrated in Fig. (13 a-e).

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/44601efd-7bb7-4317-8cf5-6f805f6300fa)

Figure 13: Panels (a) to (e) show plot of sample results using MATLAB code Planview_Plot.m.

**3.4 Fault Stability in Timeseries and Plotting:**

The computation and plotting of temporal variation of fault stability results will be performed after clicking the button “Fault stability in time series and plotting” for the parameters as shown in (Fig. 14). 

![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/2ddcdaa6-1402-42c3-897e-4b1f9e3ed500)

Figure 14: Input Argument window which appears after clicking highlighted link.

Description of Input parameters are as below:

Th – Dip of the fault.

ALAM – Dip direction of the fault.

Shi – Rake of the fault.

Mu – Coefficient of friction.


![image](https://github.com/Kalpna-Gahalaut/RTSeismo/assets/139765781/5dbefc20-bc19-4a9b-b065-4d04819021dd)

Figure 15: Panels (a) - (b) show plot of sample results using MATLAB code Timeseries Plot.m with water level Timeseries.

Matlab code (FS t.m) performs the computations, and the results of temporal variation of fault stability are saved in the FS_Timeseries_results.dat file. These results will be plotted (as shown in (Fig. 15(a-b)) using the MATLAB code "Timeseries Plot.m".



        
