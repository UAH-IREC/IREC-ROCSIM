%% Liquid Rocket Script with Simulink
% Model LRSim1D
clc,clear
startup % run startup script for CEA and Coolprop
runsim() % Uses default parameters
%Changes temperature (K), pressure (Pa), MR, area ratio, and chamber
%pressure (psi)
runsim(305, 86200, 8.2, 4.5, 325) 