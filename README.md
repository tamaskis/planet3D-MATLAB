# `planet3D` [![View 3D Planets and Celestial Bodies (planet3D) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/86483-3d-planets-and-celestial-bodies-planet3d)
Creates high-resolution renderings of the Earth and the major celestial bodies in our solar system for space mechanics applications.


## Syntax

`planet3D(planet)`\
`planet3D(planet,position)`\
`planet3D(planet,position,units)`\
`planet3D(planet,position,units,background)`

**NOTE:** If you don't want to specify `position` or `units`, for example, but do want to specify `background`, then you would use the syntax `planet3D(planet,[],[],background)`. The empty brackets are needed as placeholders, because `background` can only be read correctly if it is the fourth passed parameter. However, we don't need placeholders if we aren't "skipping over" parameters. For example, if we wanted to specify just the `position`, then we could use the syntax `planet3D(planet,position)`.


## Description

`planet3D(planet,position,units,background)` draws a celestial body.
 - `planet`: Can be specified as `'Sun'`, `'Moon'`, `'Mercury'`, `'Venus'`, `'Earth'`, `'Earth Cloudy'`, `'Earth Night'`, `'Earth Night Cloudy'`, `'Mars'`, `'Jupiter'`, `'Saturn'`, `'Uranus'`, `'Neptune'`, or `'Pluto'`.
 - `position`: (OPTIONAL) Specifies the position of the celestial body. If `position` is not specified, the function defaults to `[0,0,0]`. NOTE: If you are also specifying `units`, make sure you input `position` in the correct units (i.e. in the units you intend to use).
 - `units`: (OPTIONALS) Specifies the units the celestial body should be drawn in. Units available are `km`, `AU`, `m`, `ft`, `mi`, `nmi`.
 - `background`: (OPTIONAL) Specifies the background to use. Backgrounds available are `Stars`, `Milky Way`, and `Black`.
