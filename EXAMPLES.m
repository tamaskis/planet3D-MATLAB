%% Copyright (c) 2021 Tamas Kis

% Examples for using the planet3D function.



%% SCRIPT SETUP

% clears variables and command window, closes all figures
clear;
clc;
close all;



%% EXAMPLES (UNCOMMENT TO TEST)

% initializes figure
figure;

% plots background
background('Milky Way');
%background('Stars');
%background('Black');

% plots celestial body
%planet3D('Sun');
%planet3D('Moon');
%planet3D('Mercury');
%planet3D('Venus');
%planet3D('Earth');
%planet3D('Earth Cloudy');
%planet3D('Earth Night');
%planet3D('Earth Night Cloudy');
%planet3D('Mars');
%planet3D('Jupiter');
planet3D('Saturn');
%planet3D('Uranus');
%planet3D('Neptune')
%planet3D('Pluto');

% sets lighting
light('Position',[1 -1 0]);