%% Copyright (c) 2021 Tamas Kis

% Examples for using the planet3D function.



%% SCRIPT SETUP

% clears variables and command window, closes all figures
clear;
clc;
close all;



%% CELESTIAL BODIES ON MILKY WAY BACKGROUND

% initializes figure
figure;

% plots background
background('Milky Way');

% plots celestial body with shadow from sunlight (uncomment one at a time)
planet3D('Sun');
%planet3D('Moon');
%planet3D('Mercury');
%planet3D('Venus');
%planet3D('Earth');
%planet3D('Earth Cloudy');
%planet3D('Earth Night');
%planet3D('Earth Night Cloudy');
%planet3D('Mars');
%planet3D('Jupiter');
%planet3D('Saturn');
%planet3D('Uranus');
%planet3D('Neptune')
%planet3D('Pluto');

% light source
light('Position',[1,-1,0]);



%% SATURN IN ECLIPTIC PLANE ON WHITE BACKGROUND WITH GRID LINES

% plot
figure;
planet3D('Saturn',[],[],'ecliptic')
light('Position',[1,-1,0]);
grid on;



%% ELLIPTICAL TRAJECTORY AROUND EARTH ON BLACK BACKGROUND WITH GRID LINES

% sets orbit parameters
p = 15000; % semi-latus rectum [km]
e = 0.5; % eccentricity
i = 45; % inclination [deg]
Om = 245; % right ascension of the ascending node [deg]
w = 0; % argument of periapsis [deg]

% orbit in perifocal plane
nu = 0:0.01:(2*pi); % true anomaly [rad]
r_P = p*cos(nu)./(1+e*cos(nu));
r_Q = p*sin(nu)./(1+e*cos(nu));
r_W = zeros(size(nu));

% rotation matrix from perifocal frame to Earth-centererd inertial frame
sO = sind(Om);
cO = cosd(Om);
si = sind(i);
ci = cosd(i);
sw = sind(w);
cw = cosd(w);
R_PQW_to_IJK = [cO*cw-sO*ci*sw   -cO*sw-sO*ci*cw   sO*si;
                sO*cw+cO*ci*sw   -sO*sw+cO*ci*cw   -cO*si;
                si*sw            si*cw             ci];

% rotates coordinates of orbit to ECI frame
rI = zeros(size(nu));
rJ = zeros(size(nu));
rK = zeros(size(nu));
for j = 1:length(nu)
    new_coordinates = R_PQW_to_IJK*[r_P(j);r_Q(j);r_W(j)];
    rI(j) = new_coordinates(1);
    rJ(j) = new_coordinates(2);
    rK(j) = new_coordinates(3);
end

% plot
figure;
background('Black');
hold on;
planet3D('Earth Cloudy',[],[],[],[],0.25);
plot3(rI,rJ,rK,'color',[140,21,21]/255,'linewidth',1.5);
hold off;
grid on;
ax = gca;
ax.GridColor = [1,1,1];
ax.GridAlpha = 0.25;
xlabel("$I\;[\mathrm{km}]$",'interpreter','latex','fontsize',18);
ylabel("$J\;[\mathrm{km}]$",'interpreter','latex','fontsize',18);
zlabel("$K\;[\mathrm{km}]$",'interpreter','latex','fontsize',18);