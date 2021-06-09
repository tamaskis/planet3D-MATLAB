# `planet3D` [![View 3D Planets and Celestial Bodies (planet3D) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/86483-3d-planets-and-celestial-bodies-planet3d)
Creates high-resolution renderings of the Earth and the major celestial bodies in our solar system for space mechanics applications.


## Syntax

`planet3D(planet,position,gmst,reference_plane,units,transparency)`

**NOTE:** All parameters except for `planet` are optional. If you "skip over" parameters, you need to use empty bracket (i.e. `[]`) as placeholders, otherwise you can emit parameters altogether. For example, if you don't want to specify `position`, but do want to specify `units`, then you would use the syntax `planet3D(planet,[],[],[],units)`. Alternatively, if we wanted to specify just the `position`, we could use the syntax `planet3D(planet,position)`.

**NOTE:** Use the `background` function (see below) to set the plot background. When using `background` to set the plot background, the function call on `background` must occur *before* the function call on `planet3D`, otherwise the background will be plotted *over* the celestial body.


## Description

`planet3D(planet,position,gmst,reference_plane,units,transparency)` draws a celestial body.
 - `planet`: Can be specified as `'Sun'`, `'Moon'`, `'Mercury'`, `'Venus'`, `'Earth'`, `'Earth Cloudy'`, `'Earth Night'`, `'Earth Night Cloudy'`, `'Mars'`, `'Jupiter'`, `'Saturn'`, `'Uranus'`, `'Neptune'`, or `'Pluto'`.
 - `position`: (OPTIONAL) Specifies the position of the celestial body. If `position` is not specified, the function defaults to `[0,0,0]`. NOTE: If you are also specifying `units`, make sure you input `position` in the correct units (i.e. in the units you intend to use).
 - `gmst`: (OPTIONAL) Specifies the Greenwich mean sidereal time (the angle from the direction of the vernal equinox to 0 degrees longitude, measured in degrees).
 - `reference_plane`: (OPTIONAL) Specifies which reference plane the celestial body is drawn with respect to. If specified as `equatorial`, the reference plane is taken to be the equatorial plane of the celestial body. If specified as `ecliptic`, the celestial body will be tilted by the obliquity (i.e. the angle between the ecliptic plane and the equatorial plane).
 - `units`: (OPTIONAL) Specifies the units the celestial body should be drawn in. Units available are `km`, `AU`, `m`, `ft`, `mi`, `nmi`.
 - `transparency`: (OPTIONAL) Specifies how transparent the celestial body is (0 for 100% transparency, 1 for 100% opacity).

<br/><br/> 
<br/><br/> 
# `background`
Sets the plot background for drawing celestial bodies in 3D.


## Syntax

`background(spec)`

**NOTE:** The function call on `background` must occur before the function call on `planet3D`.


## Description

`background(spec)` sets the plot background for drawing celestial bodies in 3D. `spec` refers to the specified background, and can be set to `'Black'`, `'Stars'`, or `'Milky Way'`.
