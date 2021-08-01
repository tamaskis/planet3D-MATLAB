%==========================================================================
%
% background  Sets the plot background for drawing celestial bodies in 3D.
%
%   background(spec)
%
% See also planet3D, ground_track.
%
% Copyright © 2021 Tamas Kis
% Last Update: 2021-08-01
% Website: tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% REFERENCES:
%   [1] https://tamaskis.github.io/documentation/Visualizing%20Celestial%20Bodies%20in%203D.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
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
    if (~strcmpi(spec,'Black'))
        
        % determines which image background to use
        if strcmpi(spec,'Milky Way')
            cdata_background = imread('images/milkyway.png');
        elseif strcmpi(spec,'Stars')
            cdata_background = imread('images/stars.png');
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
    elseif strcmpi(spec,'Black')
        axis;
        set(gca,'color','k');
    end
    
end
