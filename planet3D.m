% planet3D  Creates high-resolution renderings of the Earth and the major 
% celestial bodies in our solar system for space mechanics applications.
%
%   planet3D(planet,position,gmst,reference_plane,units,transparency) draws
%   a celestial body.
%    --> planet: Can be specified as 'Sun', 'Moon', 'Mercury', 'Venus',
%                'Earth', 'Earth Cloudy', 'Earth Night', 'Earth Night 
%                Cloudy', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune',
%                or 'Pluto'.
%    --> position: (OPTIONAL) Specifies the position of the celestial body.
%                  If "position" is not specified, the function defaults to
%                  [0,0,0]. NOTE: If you are also specifying "units", make
%                  sure you input "position" in the correct units (i.e. in
%                  the units you intend to use).
%    --> gmst: (OPTIONAL) Specifies the Greenwich mean sidereal time (the
%              angle from the direction of the vernal equinox to 0 degrees
%              longitude, measured in degrees).
%    --> reference_plane: (OPTIONAL) Specifies which reference plane the
%                         celestial body is drawn with respect to. If
%                         specified as 'equatorial', the reference plane is
%                         taken to be the equatorial plane of the celestial
%                         body. If specified as 'ecliptic', the celestial
%                         body will be tilted by the obliquity (i.e. the
%                         angle between the ecliptic plane and the
%                         equatorial plane).
%    --> units: (OPTIONAL) Specifies the units the celestial body should be
%               drawn in. Units available are 'km', 'AU', 'm', 'ft', 'mi',
%               and 'nmi'.
%    --> transparency: (OPTIONAL) Specifies how transparent the celestial
%                      body is (0 for 100% transparency, 1 for 100% solid).
%
%   NOTE: All parameters except for "planet" are optional. If you "skip 
%         over" parameters, you need to use empty bracket (i.e. "[]") as 
%         placeholders, otherwise you can emit parameters altogether. For 
%         example, if you don't want to specify "position", but do want to
%         specify "units", then you would use the syntax 
%          "planet3D(planet,[],[],[],units)". Alternatively, if we wanted 
%          to specify just the "position", we could use the syntax 
%          "planet3D(planet,position)".
%
%   NOTE: Use the "background" function included with download to set the
%         plot background. When using "background" to set the plot 
%         background, the function call on "background" must occur before
%         the function call on "planet3D", otherwise the background will be
%         plotted over the celestial body.
%
% MATLAB Central File Exchange: https://www.mathworks.com/matlabcentral/fileexchange/86483-3d-earth-and-celestial-bodies-planet3d
% GitHub: https://github.com/tamaskis/planet3D-MATLAB
%
% See "DOCUMENTATION.pdf" for additional documentation and examples. 
% Examples can also be found in EXAMPLES.m. Both of these files are 
% included with the download.
%
% Copyright (c) 2021 Tamas Kis
% Last Update: 2021-04-05



%% FUNCTION

% INPUT: planet - name of celestial body
%        position - (OPTIONAL) position of planet's geometric center
%        gmst - (OPTIONAL) Greenwich mean sidereal time [deg]
%        reference_plane - (OPTIONAL) 'equatorial' or 'ecliptic'
%        units - (OPTIONAL) units for drawing planet
%        transparency - (OPTIONAL) 0 for 100% transparent, 1 for 100% solid
% OUTPUT: 3D plot of specified celestial body 
function planet3D(planet,position,gmst,reference_plane,units,transparency)
    
    % conversion factors
    factors = {'km'   1;
               'AU'   1/149597870;
               'm'    1000;
               'ft'   100000/30.48;
               'mi'   100000/160934.4;
               'nmi'  1/1.852};

    % sets default position (origin) of planet's geometric center
    if (nargin == 1) || isempty(position)
        position = [0;0;0];
    end
    
    % sets default rotation angle to 0
    if (nargin < 3) || isempty(gmst)
        gmst = 0;
    end
    
    % determines conversion factor to use
    if (nargin < 5) || isempty(units)
        conversion_factor = 1;
    else
        conversion_factor = factors{strcmpi(factors(:,1),units),2};
    end
    
    % sets default reference plane to equatorial plane
    if (nargin < 4) || isempty(reference_plane)
        reference_plane = 'equatorial';
    end
    
    % sets default transparency to 1 (so celestial body is solid)
    if (nargin < 6) || isempty(transparency)
        transparency = 1;
    end
    
            % planet/body           % radius, R [km]  flattening, f   obliquity, obliquity [deg]
    data = {'Sun'                   696000            0.000009        0;
            'Moon'                  1738.0            0.0012          6.68;
            'Mercury'               2439.0            0.0000          0.0;
            'Venus'                 6052.0            0.000           177.3;
            'Earth'                 6378.1363         0.0033528131    23.45;
            'Earth Cloudy'          6378.1363         0.0033528131    23.45;
            'Earth Night'           6378.1363         0.0033528131    23.45;
            'Earth Night Cloudy'    6378.1363         0.0033528131    23.45;
            'Mars'                  3397.2            0.00647630      25.19;
            'Jupiter'               71492.0           0.0648744       3.12;
            'Saturn'                60268.0           0.0979624       26.73;
            'Uranus'                25559.0           0.0229273       97.86;
            'Neptune'               24764.0           0.0171          29.56;
            'Pluto'                 1151.0            0.0             118.0};
    
    % determines mean equatorial radius and flattening
    R = data{strcmpi(data(:,1),planet),2};
    f = data{strcmpi(data(:,1),planet),3};
    
    % determines obliquity
    if strcmp(reference_plane,'ecliptic')
        obliquity = data{strcmpi(data(:,1),planet),4};
    else
        obliquity = 0;
    end

    % determines semi-major and semi-minor axes of body
    a = conversion_factor*R;
    b = a*(1-f);

    % coordinates of ellipsoid (uses 400 panels)
    [x,y,z] = ellipsoid(position(1),position(2),position(3),a,a,b,400);
    
    % reads in image
    if strcmp(planet,'Earth Cloudy')
        cdata = imread('Images/Earth.png')+imread('Images/Clouds.png');
    elseif strcmp(planet,'Earth Night Cloudy')
        cdata = imread('Images/Earth Night.png')+...
            0.1*imread('Images/Clouds.png');
    else
        cdata = imread(strcat('Images/',planet,'.png'));
    end

    % draws planet
    planet_surface = surface(x,y,z,'facecolor','texture','edgecolor',...
        'none','cdata',flipud(cdata),'DiffuseStrength',1,...
        'SpecularStrength',0,'FaceAlpha',transparency);
    
    % tilts celestial body if referenced to ecliptic plane
    rotate(planet_surface,[1,0,0],-obliquity);
    
    % obtains new K axis
    rotation_matrix = [1,0,0;0,cosd(obliquity),sind(obliquity);0,...
        -sind(obliquity),cosd(obliquity)];
    K = rotation_matrix*[0;0;1];
    
    % rotates celestial body about its axis
    rotate(planet_surface,K',gmst);
    
    % draws rings of Saturn if drawing Saturn
    if strcmp(planet,'Saturn')
        
        % reads in image
        cdata_rings = imread('Images/Saturn Rings.png');
        
        % determines number of different colors in ring (if you look at the
        % image, the way it is formatted just looks like horizontal bands
        % of colors)
        n = size(cdata_rings,2);
        
        % preallocates array to store colors
        colors = zeros(n,3);
        
        % extracts rgb values from image data
        for i = 1:n
            colors(i,:) = cdata_rings(1,i,:);
        end
        
        % shrinks the data set of colors down to only 200 (this is for
        % speed - we plot the bands of Saturns rings as individual lines
        % and don't want to plot thousands of lines) - this shrinking
        % process is condensed from the shrink_data_set function (see 
        % https://www.mathworks.com/matlabcentral/fileexchange/86218-reduce
        % -number-of-data-points-shrink_data_set)
        n_new = 200;
        colors = colors(1:round(n/n_new):n,:);
        
        % scales colors to between 0 and 1 (currently have values between 0
        % and 255)
        colors = colors/255;
        
        % plots the rings
        theta = 0:0.001:2*pi;
        hold on;
        for i = 1:n_new
            
            % this comes from the fact that Saturns rings extend from 7000
            % to 80000 km from the surface of the planet
            % (https://en.wikipedia.org/wiki/Rings_of_Saturn)
            r = R+conversion_factor*(7000+((80000-7000)/n_new)*i);
            
            % x, y, and z coordinates of Saturns rings in equatorial plane
            x_ring = position(1)+r*cos(theta);
            y_ring = position(2)+r*sin(theta);
            z_ring = position(3)*ones(size(theta));
            
            % rotates ring to equatorial plane (uses same rotation matrix
            % as tilting the planet earlier in code)
            for j = 1:length(x_ring)
                new_coordinates = rotation_matrix*[x_ring(j);y_ring(j);...
                    z_ring(j)];
                x_ring(j) = new_coordinates(1);
                y_ring(j) = new_coordinates(2);
                z_ring(j) = new_coordinates(3);
            end
            
            % plots the ith line in process of forming Saturns rings
            plot3(x_ring,y_ring,z_ring,'color',colors(i,:));
            
        end
        hold off;
        
    end
    
    % plot format
    axis equal;
    view(3);

end