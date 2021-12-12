%==========================================================================
%
% planet3D  Creates high-resolution renderings of the Earth and the major 
% celestial bodies in our solar system for space mechanics applications.
%
%   planet3D(planet)
%   planet3D(planet,opts)
%
% See also background, ground_track.
%
% Copyright © 2021 Tamas Kis
% Last Update: 2021-12-12
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/documentation/Visualizing_Celestial_Bodies_in_3D.pdf
%
% REFERENCES:
%   [1] https://mathworks.com/matlabcentral/fileexchange/27123-earth-sized-sphere-with-topography
%   [2] https://apps.dtic.mil/sti/pdfs/AD1000581.pdf
%   [3] https://www.mathworks.com/matlabcentral/fileexchange/13823-3d-earth-example
%   [4] https://nssdc.gsfc.nasa.gov/planetary/factsheet/mercuryfact.html
%   [5] https://en.wikipedia.org/wiki/Moon
%   [6] https://www.jpl.nasa.gov/images/pluto-color-map
%   [7] https://en.wikipedia.org/wiki/Rings_of_Saturn
%   [8] https://www.solarsystemscope.com/textures/
%   [9] https://en.wikipedia.org/wiki/Sun
%   [10] https://visibleearth.nasa.gov/images/57730/the-blue-marble-land-surface-ocean-color-and-sea-ice/57731l
%   [11] Vallado, "Fundamentals of Astrodynamics and Applications", 4th
%        Ed., Tables D-3, D-4, and D-5 (pp. 1041-1042)
%   [12] https://nssdc.gsfc.nasa.gov/planetary/factsheet/venusfact.html
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   planet  - (char) 'Sun', 'Moon', 'Mercury', 'Venus', 'Earth', 
%             'Earth Cloudy', 'Earth Coastlines', 'Earth Night', 
%             'Earth Night Cloudy', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 
%             'Neptune', or 'Pluto'
%   opts    - (OPTIONAL) (struct) plot options
%       • Clipping  - (char) 'on' or 'off' (defaults to 'off')
%                       --> if 'on', the surface will be "clipped" to fit
%                           the axes when zooming in
%       • Color     - (char or 1×3 double) line color (only relevant
%                     when drawing Earth coastlines)
%                       --> can be specified as a name, short name, or RGB
%                            triplet [rgb]
%       • FaceAlpha - (1×1 double) 0 for 100% transparency, 1 for 100%
%                     opacity
%       • LineWidth - (1×1 double) line width (only relevant when drawing
%                     Earth coastlines)
%       • LineStyle - (char) line style (only relevant when drawing Earth
%                     coastlines)
%       • Position  - (3×1 double) position of planet's geometric center
%       • RefPlane  - (char) 'equatorial' or 'ecliptic'
%       • RotAngle  - (1×1 double) rotation angle [deg]
%       • Units     - (char) 'AU', 'ft', 'km', 'm', 'mi', or 'nmi'
%
% -----
% NOTE:
% -----
%   --> All fields of "opts" do NOT have to be defined; when a field is
%       left undefined, the rest of the plot settings are set to default 
%       values.
%   --> Use the "background" function included with download to set the
%       plot background. When using "background" to set the plot
%       background, the function call on "background" must occur BEFORE the
%       function call on "planet3D", otherwise the background will be
%       plotted over the celestial body.
%
%==========================================================================
function planet_surface = planet3D(planet,opts)
    
    % ----------------------------
    % Conversion factors and data.
    % ----------------------------
    
    % conversion factors
    factors = {'AU'   1/149597870000;
               'ft'   100/30.48;
               'km'   0.001;
               'm'    1;
               'mi'   100/160934.4;
               'nmi'  1/1852};
           
            % planet/body          radius,       flattening,    obliquity,
            %                      R [m]         f [-]          obl [deg]
    data = {'Sun'                  696000e3      0.000009       0;
            'Moon'                 1738.0e3      0.0012         6.68;
            'Mercury'              2439.0e3      0.0000         0.0;
            'Venus'                6052.0e3      0.000          177.3;
            'Earth'                6378.1363e3   0.0033528131   23.45;
            'Earth Coastlines'     6378.1363e3   0.0033528131   23.45;
            'Earth Cloudy'         6378.1363e3   0.0033528131   23.45;
            'Earth Night'          6378.1363e3   0.0033528131   23.45;
            'Earth Night Cloudy'   6378.1363e3   0.0033528131   23.45;
            'Mars'                 3397.2e3      0.00647630     25.19;
            'Jupiter'              71492.0e3     0.0648744      3.12;
            'Saturn'               60268.0e3     0.0979624      26.73;
            'Uranus'               25559.0e3     0.0229273      97.86;
            'Neptune'              24764.0e3     0.0171         29.56;
            'Pluto'                1151.0e3      0.0            118.0};
    
    % ------------------------------------
    % Sets (or defaults) plotting options.
    % ------------------------------------
    
    % sets position of planet's geometric center (defaults to origin)
    if (nargin == 1) || ~isfield(opts,'Position')
        position = [0;0;0];
    else
        position = opts.Position;
    end
    
    % sets rotation angle (defaults to 0)
    if (nargin == 1) || ~isfield(opts,'RotAngle')
        theta = 0;
    else
        theta = opts.RotAngle;
    end
    
    % sets conversion factor (defaults to 1, assuming units of m)
    if (nargin == 1) || ~isfield(opts,'Units')
        units = 'm';
    else
        units = opts.Units;
    end
    
    % sets reference plane (defaults to equatorial plane)
    if (nargin == 1) || ~isfield(opts,'RefPlane')
        reference_plane = 'equatorial';
    else
        reference_plane = opts.RefPlane;
    end
    
    % sets transparency (defaults to 1 so celestial body is solid)
    if (nargin == 1) || ~isfield(opts,'FaceAlpha')
        FaceAlpha = 1;
    else
        FaceAlpha = opts.FaceAlpha;
    end
    
    % determines obliquity
    if strcmpi(reference_plane,'ecliptic')
        obl = data{strcmpi(data(:,1),planet),4};
    else
        obl = 0;
    end
    
    % sets clipping (defaults to 'off')
    if (nargin == 1) || ~isfield(opts,'Clipping')
        Clipping = 'off';
    else
        Clipping = opts.Clipping;
    end
    
    % sets line color (defaults to default MATLAB color)
    if (nargin == 1) || ~isfield(opts,'Color')
        Color = [0,0.4470,0.7410];
    else
        Color = opts.Color;
    end

    % sets line style (defaults to solid line)
    if (nargin == 1) || ~isfield(opts,'LineStyle')
        LineStyle = '-';
    else
        LineStyle = opts.LineStyle;
    end
    
    % sets line width (defaults to 0.5)
    if (nargin == 1) || ~isfield(opts,'LineWidth')
        LineWidth = 0.5;
    else
        LineWidth = opts.LineWidth;
    end
    
    % -------------------------------
    % Geometry of the celestial body.
    % -------------------------------
    
    % determines mean equatorial radius and flattening
    R = data{strcmpi(data(:,1),planet),2};
    f = data{strcmpi(data(:,1),planet),3};
    
    % conversion factor to use
    conversion_factor = factors{strcmpi(factors(:,1),units),2};
    
    % determines semi-major and semi-minor axes of body
    a = conversion_factor*R;
    b = a*(1-f);
    
    % coordinates of ellipsoid (uses 400 panels)
    [x,y,z] = ellipsoid(position(1),position(2),position(3),a,a,b,400);
    
    % ------------------------------------------------------------
    % Defining surfaces/coordinates needed to draw celestial body.
    % ------------------------------------------------------------
    
    % not drawing Earth coastlines 
    if ~strcmpi(planet,'Earth Coastlines')
        
        % loads image data
        if strcmpi(planet,'Earth Cloudy')
            cdata = imread('earth.png')+imread('clouds.png');
        elseif strcmpi(planet,'Earth Night Cloudy')
            cdata = imread('earthnight.png')+0.1*imread('clouds.png');
        else
            cdata = imread(strcat('',lower(planet),'.png'));
        end

        % draws planet
        planet_surface = surface(x,y,z,'FaceColor','texture',...
            'EdgeColor','none','CData',flipud(cdata),'DiffuseStrength',...
            1,'SpecularStrength',0,'FaceAlpha',FaceAlpha);

    end
    
    % drawing Earth coastlines
    if strcmpi(planet,'Earth Coastlines')
        
        % white surface (lines will be plotted on top of this)
        planet_surface = surface(x,y,z,'FaceColor','w','EdgeColor',...
            'none','DiffuseStrength',1,'SpecularStrength',0,...
            'FaceAlpha',FaceAlpha);
        
        % loads coastline data
        coastlines_data = struct2array(load('coastlines_data'));
        
        % extracts ECEF coordinates of coastlines
        x_coast = coastlines_data.X;
        y_coast = coastlines_data.Y;
        z_coast = coastlines_data.Z;
        
    end
    
    % -------------------
    % Performs rotations.
    % -------------------
    
    % transformation matrix for rotation
    R3 = [ cosd(theta)   sind(theta)   0;
          -sind(theta)   cosd(theta)   0;
           0             0             1];
       
    % transformation matrix for tilt
    R1 = [1   0            0;
          0   cosd(obl)   -sind(obl);
          0   sind(obl)    cosd(obl)];
      
    % axes for rotations (must be row vectors)
    alpha1 = [1,0,0];
    alpha2 = (R1*[0;0;1])';
    
    % tilts celestial body if referenced to ecliptic plane
    rotate(planet_surface,alpha1,obl);

    % rotates celestial body about its 3rd axis
    rotate(planet_surface,alpha2,theta);
    
    % rotates coordinates of coastlines
    if strcmpi(planet,'Earth Coastlines')
        new_coordinates = R3*R1*[x_coast';y_coast';z_coast'];
        x_coast = new_coordinates(1,:);
        y_coast = new_coordinates(2,:);
        z_coast = new_coordinates(3,:);
    end
    
    % --------------------------------------------------------------
    % Drawing additional lines (i.e. coastlines or rings of Saturn).
    % --------------------------------------------------------------
    
    % draws coastlines
    if strcmpi(planet,'Earth Coastlines')
        hold on;
        plot3(x_coast,y_coast,z_coast,'LineWidth',LineWidth,'LineStyle',...
            LineStyle,'Color',Color);
        hold off;
    end
    
    % draws rings of Saturn
    if strcmpi(planet,'Saturn')
        
        % reads in image
        cdata_rings = imread('saturnrings.png');
        
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
        % process is condensed from the reduced_data_points function (see 
        % https://www.mathworks.com/matlabcentral/fileexchange/86218-reduce
        % -number-of-data-points-reduce_data_points)
        n_new = 200;
        colors = colors(1:round(n/n_new):n,:);
        
        % scales colors to between 0 and 1 (currently between 0 and 255)
        colors = colors/255;
        
        % plots the rings
        theta = 0:0.001:2*pi;
        hold on;
        for i = 1:n_new
            
            % this comes from the fact that Saturns rings extend from 7000
            % to 80000 km (7,000,000 to 8,000,000 km) from the surface of
            % the planet s(https://en.wikipedia.org/wiki/Rings_of_Saturn)
            r = conversion_factor*(R+7000000+((80000000-7000000)/n_new)*i);
            
            % x, y, and z coordinates of Saturns rings in equatorial plane
            x_ring = position(1)+r*cos(theta);
            y_ring = position(2)+r*sin(theta);
            z_ring = position(3)*ones(size(theta));
            
            % rotates rings to equatorial plane (uses same rotation matrix
            % as tilting the planet earlier in code)
            new_coordinates = R1*[x_ring;y_ring;z_ring];
            x_ring = new_coordinates(1,:);
            y_ring = new_coordinates(2,:);
            z_ring = new_coordinates(3,:);
            
            % plots the jth ring
            plot3(x_ring,y_ring,z_ring,'Color',colors(i,:));
            
        end
        hold off;
        
    end
    
    % ----------------------
    % Basic plot formatting.
    % ----------------------
    
    % set axis clipping
    ax = gca;
    ax.Clipping = Clipping;
    
    % equal data unit lengths along each axis
    axis equal;
    
    % 3D view
    view(3);
    
end