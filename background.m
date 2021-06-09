%==========================================================================
%
% background  Sets the plot background for drawing celestial bodies in 3D.
%
%   background(spec)
%
% Copyright © 2021 Tamas Kis
% Last Update: 2021-06-09
%
%--------------------------------------------------------------------------
%
% MATLAB Central File Exchange: https://www.mathworks.com/matlabcentral/fileexchange/86483-3d-earth-and-celestial-bodies-planet3d
%   --> Pick of the Week: https://blogs.mathworks.com/pick/2021/05/31/visualizing-earth-and-celestial-bodies/
% GitHub: https://github.com/tamaskis/planet3D-MATLAB
%
% See EXAMPLES.mlx for examples and "DOCUMENTATION.pdf" for additional 
% documentation. Both of these files are included with the download.
%
% Copyright © 2021 Tamas Kis
% Last Update: 2021-06-09
%
%--------------------------------------------------------------------------
%
% -------
% INPUTS:
% -------
%   spec    - 'Black', 'Stars', or 'Milky Way'
%
% -----
% NOTE:
% -----
%   --> The function call on "background" MUST occur before the function
%       call on "planet3D".
%
%==========================================================================
function background(spec)
    
    % picture background
    if (~strcmp(spec,'Black'))
        
        % determines which image background to use
        if strcmp(spec,'Milky Way')
            cdata_background = imread('Images/Milky Way.png');
        elseif strcmp(spec,'Stars')
            cdata_background = imread('Images/Stars.png');
        end
        
        % axis for background
        axis;
        
        % renders background
        imshow(cdata_background);
        
        % starts new axes object on which planet can be rendered
        axes;
        
        % turns coordinate axes off
        axis off;
        
    % black background
    elseif strcmp(spec,'Black')
        axis;
        set(gca,'color','k');
    end
    
end