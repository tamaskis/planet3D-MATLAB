# `planet3D` [![View 3D Planets and Celestial Bodies (planet3D) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/86483-3d-planets-and-celestial-bodies-planet3d)
Creates high-resolution renderings of the Earth and the major celestial bodies in our solar system for astrodynamics applications.


## Syntax

`planet3D`\
`planet3D(planet)`\
`planet3D(planet,opts)`\
`planet_surface = planet3D(__)`


## Description

`planet3D` draws the Earth with clouds. Units are in meters by default.

`planet3D(planet)` draws the celestial body specified by `planet`, which can be input as `'Sun'`, `'Moon'`, `'Mercury'`, `'Venus'`, `'Earth'`, `'Earth Cloudy'`, `'Earth Night'`, `'Earth Night Cloudy'`, `'Earth Coastlines'`, `'Mars'`, `'Jupiter'`, `'Saturn'`, `'Uranus'`, `'Neptune'`, or `'Pluto'`. Units are in meters by default.

`planet3D(planet,opts)` does the same as the syntax above, but allows for the specification of optional plotting parameters. `opts` is a struct that has the following fields:
   - `Clipping` &rightarrow; `'on'` if surfaces should be "[clipped](https://www.mathworks.com/help/matlab/creating_plots/clipping-in-plots-and-graphs.html)" to fit axes, `'off'` otherwise (defaults to `off`)
   - `Color` &rightarrow; specifies line color
   - `FaceAlpha` &rightarrow; specifies how transparent the celestial body is (0 for 100% transparency, 1 for 100% opacity)
   - `LineWidth` &rightarrow; specifies line width
   - `LineStyle` &rightarrow; specifies line style
   - `Position` &rightarrow; specifies the position of the center of the celestial body 
   - `RefPlane` &rightarrow; specifies which reference plane the celestial body is drawn with respect to. If specified as `equatorial`, the reference plane is taken to be the equatorial plane of the celestial body. If specified as `ecliptic`, the celestial body will be tilted by the obliquity (i.e. the angle between the ecliptic plane and the equatorial plane).
   - `RotAngle` &rightarrow; specifies the rotation angle about the 3rd axis of the celestial body (in degrees)
   - `Units` &rightarrow; specifies the units the celestial body should be drawn in. Units available are `'AU'`, `'ft'`, `'km'`, `'m'`, `'mi'`, and `'nmi'`.

`planet_surface = planet3D(__)` does the same as the previous two syntaxes, but also returns the `Surface` object defining the planet.


## Note
   - Use the `background` function (see below) to set the plot background. When using `background` to set the plot background, the function call on `background` must occur *before* the function call on `planet3D`, otherwise the background will be plotted *over* the celestial body.
   - If you want to produce separate plots on separate figures using the `planet3D` function, always use the [`drawnow`](https://www.mathworks.com/help/matlab/ref/drawnow.html) command before initializing a new figure to ensure that the correct plots are drawn on the correct figures.
   - All fields of `opts` do NOT have to be defined; when a field is left undefined, the rest of the plot settings are set to default values. Additionally, `Color`, `LineWidth`, and `LineStyle` are only relevant when plotting the Earth's coastlines.




<br><br><br><br>




# `background`
Sets the plot background for drawing celestial bodies in 3D.


## Syntax

`background(spec)`


## Description

`background(spec)` sets the plot background for drawing celestial bodies in 3D. `spec` refers to the specified background, and can be set to `'Black'`, `'Stars'`, or `'Milky Way'`.


## Note
   - The function call on `background` must occur before the function call on `planet3D`.




<br><br><br><br>




# Examples and Additional Documentation

   -  See `EXAMPLES.mlx` or the "Examples" tab on the File Exchange page for examples.
   -  See [Visualizing Celestial Bodies in 3D.pdf](https://tamaskis.github.io/files/Visualizing_Celestial_Bodies_in_3D.pdf) (also included with download) for additional documentation.




<br><br><br><br> 




# Installation

   - Open `3D Earth and Celestial Bodies (planet3D).mltbx` in the `INSTALL` folder to install as a toolbox. MATLAB will automatically perform the installation and add all the functions, images, and data to the MATLAB search path.
   - Alternatively, the "planet3D" folder can be copy and pasted into the folder containing the script that you want to use the functions in. At the beginning of the script, include `addpath('planet3D')` to add all functions, images, and data to the MATLAB search path.
