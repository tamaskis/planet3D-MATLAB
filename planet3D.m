% planet3D  Creates high-resolution renderings of the Earth and the major 
% celestial bodies in our solar system for space mechanics applications.
%
%   planet3D(planet,position,units,background) draws a celestial body.
%    --> planet: Can be specified as 'Sun', 'Moon', 'Mercury', 'Venus',
%                'Earth', 'Earth Cloudy', 'Earth Night', 'Earth Night 
%                Cloudy', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune',
%                or 'Pluto'.
%    --> position: (OPTIONAL) Specifies the position of the celestial body.
%                  If "position" is not specified, the function defaults to
%                  [0,0,0]. NOTE: If you are also specifying "units", make
%                  sure you input "position" in the correct units (i.e. in
%                  the units you intend to use).
%    --> units: (OPTIONAL) Specifies the units the celestial body should be
%               drawn in. Units available are 'km', 'AU', 'm', 'ft', 'mi',
%               and 'nmi'.
%    --> background: (OPTIONAL) Specifies the background to use.
%                    Backgrounds available are 'Stars', 'Milky Way', and 
%                   'Black'.
%
%   NOTE: If you don't want to specify "position" or "units", for example,
%   but do want to specify "background", then you would use the syntax
%   "planet3D(planet,[],[],background)". The empty brackets are needed as
%   placeholders, because "background" can only be read correctly if it is
%   the fourth passed parameter. However, we don't need placeholders if we
%   aren't "skipping over" parameters. For example, if we wanted to specify
%   just the "position", then we could use the syntax 
%   "planet3D(planet,position)".
%
% See https://github.com/tamaskis/planet3D-MATLAB for additional 
% documentation and examples. Examples can also be found in EXAMPLES.m 
% (included with download).
%
% Copyright (c) 2021 Tamas Kis



%% FUNCTION

function planet3D(planet,position,units,background)
    
    % picture background
    if (nargin == 4) && (~strcmp(background,'Black'))
        
        % determines which image background to use
        if strcmp(background,'Milky Way')
            cdata_background = imread('Images/Milky Way.png');
        elseif strcmp(background,'Stars')
            cdata_background = imread('Images/Stars.png');
        end
        
        % axis for background
        axis;
        
        % renders background
        imshow(cdata_background);
        
        % starts new axes object on which planet will be rendered
        axes;
        
        % turns coordinate axes off
        axis off;
        
    % black background
    elseif (nargin == 4) && strcmp(background,'Black')
        axis;
        set(gca,'color','k');
    end
    
    % sets position of planet's center (at origin by default)
    if (nargin == 1) || isempty(position)
        position = [0;0;0];
    end
    
    % conversion factors
    factors = {'km'   1;
               'AU'   1/149597870;
               'm'    1000;
               'ft'   100000/30.48;
               'mi'   100000/160934.4;
               'nmi'  1/1.852};

    % determines conversion factor to use
    if (nargin < 3) || isempty(units)
        conversion_factor = 1;
    else
        conversion_factor = factors{strcmpi(factors(:,1),units),2};
    end
    
    % data
            % planet/body           % radius, R [km]  flattening, f
    data = {'Sun'                   696000            0.000009;
            'Moon'                  1738.0            0.0012;
            'Mercury'               2439.0            0.0000;
            'Venus'                 6052.0            0.000;
            'Earth'                 6378.1363         0.0033528131;
            'Earth Cloudy'          6378.1363         0.0033528131;
            'Earth Night'           6378.1363         0.0033528131;
            'Earth Night Cloudy'    6378.1363         0.0033528131;
            'Mars'                  3397.2            0.00647630;
            'Jupiter'               71492.0           0.0648744;
            'Saturn'                60268.0           0.0979624;
            'Uranus'                25559.0           0.0229273;
            'Neptune'               24764.0           0.0171;
            'Pluto'                 1151.0            0.0};
    
    % determines equatorial radius and flattening
    R = data{strcmpi(data(:,1),planet),2};
    f = data{strcmpi(data(:,1),planet),3};

    % determines semi-major and semi-minor axes of body
    a = conversion_factor*R;
    b = a*(1-f);

    % coordinates of ellipsoid (uses 400 panels)s
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
    DiffuseStrength = 1;
    SpecularStrength = 0;
    surface(x,y,z,'facecolor','texture','edgecolor','none','cdata',...
        flipud(cdata),'DiffuseStrength',DiffuseStrength,...
        'SpecularStrength',SpecularStrength);
    
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
            
            % plots the ith line in process of forming Saturns rings
            plot3(r*cos(theta),r*sin(theta),zeros(size(theta)),'color',...
                colors(i,:));
            
        end
        hold off;
        
    end
    
    % plot format
    axis equal;
    view(3);

end