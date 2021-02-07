# `planet3D` [![View 3D Planets and Celestial Bodies (planet3D) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/86483-3d-planets-and-celestial-bodies-planet3d)
Creates high-resolution renderings of the Earth and the major celestial bodies in our solar system for space mechanics applications.


## Syntax

`planet3D(planet)`\
`planet3D(planet,position)`\
`planet3D(planet,position,units)`

**NOTE:** If you don't want to specify `position`, for example, but do want to specify `units`, then you would use the syntax `planet3D(planet,[],units)`. The empty brackets are needed as placeholders, because `units` can only be read correctly if it is the third passed parameter. However, we don't need placeholders if we aren't "skipping over" parameters. For example, if we wanted to specify just the `position`, then we could use the syntax `planet3D(planet,position)`.

**NOTE:** Use the `background` function (see below) to set the plot background. When using `background` to set the plot background, the function call on `background` must occur *before* the function call on `planet3D`, otherwise the background will be plotted *over* the celestial body.


## Description

`planet3D(planet,position,units)` draws a celestial body.
 - `planet`: Can be specified as `'Sun'`, `'Moon'`, `'Mercury'`, `'Venus'`, `'Earth'`, `'Earth Cloudy'`, `'Earth Night'`, `'Earth Night Cloudy'`, `'Mars'`, `'Jupiter'`, `'Saturn'`, `'Uranus'`, `'Neptune'`, or `'Pluto'`.
 - `position`: (OPTIONAL) Specifies the position of the celestial body. If `position` is not specified, the function defaults to `[0,0,0]`. NOTE: If you are also specifying `units`, make sure you input `position` in the correct units (i.e. in the units you intend to use).
 - `units`: (OPTIONALS) Specifies the units the celestial body should be drawn in. Units available are `km`, `AU`, `m`, `ft`, `mi`, `nmi`.

<br/><br/> 
<br/><br/> 
# `background`
Sets the plot background for drawing celestial bodies in 3D.


## Syntax

`background(spec)`

**NOTE:** The function call on `background` must occur before the function call on `planet3D`.


## Description

`background(spec)` sets the plot background for drawing celestial bodies in 3D. `spec` refers to the specified background, and can be set to `'Black'`, `'Stars'`, or `'Milky Way'`.
