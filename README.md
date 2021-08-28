# `planet3D` [![View 3D Planets and Celestial Bodies (planet3D) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/86483-3d-planets-and-celestial-bodies-planet3d)
Creates high-resolution renderings of the Earth and the major celestial bodies in our solar system for space mechanics applications.


## Syntax

`planet3D(planet)`\
`planet3D(planet,opts)`

**NOTE:** Use the `background` function (see below) to set the plot background. When using `background` to set the plot background, the function call on `background` must occur *before* the function call on `planet3D`, otherwise the background will be plotted *over* the celestial body.


## Description

`planet3D(planet)` draws the celestial body specified by `planet`, which can be input as `'Sun'`, `'Moon'`, `'Mercury'`, `'Venus'`, `'Earth'`, `'Earth Cloudy'`, `'Earth Night'`, `'Earth Night Cloudy'`, `'Earth Coastlines'`, `'Mars'`, `'Jupiter'`, `'Saturn'`, `'Uranus'`, `'Neptune'`, or `'Pluto'`.

`planet3D(planet,opts)` does the same as the syntax above, but allows for the specification of optional plotting parameters. `opts` is a struct that has the following fields:
   - `color` &rightarrow; specifies line color
   - `line_width` &rightarrow; specifies line width
   - `line_style` &rightarrow; specifies line style
   - `position` &rightarrow; specifies the position of the center of the celestial body 
   - `reference_plane` &rightarrow; specifies which reference plane the celestial body is drawn with respect to. If specified as `equatorial`, the reference plane is taken to be the equatorial plane of the celestial body. If specified as `ecliptic`, the celestial body will be tilted by the obliquity (i.e. the angle between the ecliptic plane and the equatorial plane).
   - `theta` &rightarrow; specifies the rotation angle about the 3rd axis of the celestial body (in degrees)
   - `units` &rightarrow; specifies the units the celestial body should be drawn in. Units available are `km`, `AU`, `m`, `ft`, `mi`, `nmi`.
   - `transparency` &rightarrow; specifies how transparent the celestial body is (1 for 100% transparency, 0 for 100% opacity)


<br/><br/> 
<br/><br/> 
# `background`
Sets the plot background for drawing celestial bodies in 3D.


## Syntax

`background(spec)`

**NOTE:** The function call on `background` must occur before the function call on `planet3D`.


## Description

`background(spec)` sets the plot background for drawing celestial bodies in 3D. `spec` refers to the specified background, and can be set to `'Black'`, `'Stars'`, or `'Milky Way'`.


<br/><br/> 
<br/><br/> 
# Examples and Additional Documentation

   -  See "EXAMPLES.mlx" or the "Examples" tab on the File Exchange page for examples.
   -  See [Visualizing Celestial Bodies in 3D.pdf](https://tamaskis.github.io/documentation/Visualizing_Celestial_Bodies_in_3D.pdf) (also included with download) for additional documentation.
