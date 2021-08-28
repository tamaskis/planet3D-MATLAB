clear; clc; close all;

opts_example2.reference_plane = 'ecliptic';
opts_example2.units = 'ft';
figure;
planet3D('Saturn',opts_example2);
light('position',[1,-1,0]);
grid on;
view(-70,10)