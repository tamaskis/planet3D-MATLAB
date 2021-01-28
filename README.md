# `planet3D`
Creates high-resolution renderings (in the “Figure” environment) of the planetary bodies in our solar system (includes Sun, Moon, &amp; Pluto).

Lightens or darkens an RGB color by a specified proportion.


## Syntax

`c_new = lighten_darken(c,p,'lighten')`\
`c_new = lighten_darken(c,p,'darken')`


## Description

`c_new = lighten_darken(c,p,'lighten')` lightens the input color, `c`, by `p`<img src="https://latex.codecogs.com/svg.latex?\times&space;100\%" title="\times 100\%" />. `c` and `c_new` are RGB triplets, while `p` is a number between 0 and 1.

`c_new = lighten_darken(c,p,'darken')` darkens the input color, `c`, by `p`<img src="https://latex.codecogs.com/svg.latex?\times&space;100\%" title="\times 100\%" />. `c` and `c_new` are RGB triplets, while `p` is a number between 0 and 1.

## Examples

Let's draw 2 rows of 5 squares, where the first square in each row is green. In the first row, the remaining four squares will get progressively lighter, while in the second row, the remaining four squares will get progressively darker. Defining the original color (green),

    c = [0,1,0];
    
Creating four colors that get progressively lighter,

    c1_light = lighten_darken_RGB(c,0.25,'lighten');
    c2_light = lighten_darken_RGB(c,0.5,'lighten');
    c3_light = lighten_darken_RGB(c,0.75,'lighten');
    c4_light = lighten_darken_RGB(c,1,'lighten');

Creating four colors that get progressively darker,

    c1_dark = lighten_darken_RGB(c,0.25,'darken');
    c2_dark = lighten_darken_RGB(c,0.5,'darken');
    c3_dark = lighten_darken_RGB(c,0.75,'darken');
    c4_dark = lighten_darken_RGB(c,1,'darken');

Initializing the figure and drawing the first row of squares,

    figure;
    hold on;
    rectangle('Position',[1,8,2,2],'facecolor',c);
    rectangle('Position',[4,8,2,2],'facecolor',c1_light);
    rectangle('Position',[7,8,2,2],'facecolor',c2_light);
    rectangle('Position',[10,8,2,2],'facecolor',c3_light);
    rectangle('Position',[13,8,2,2],'facecolor',c4_light);

Drawing the second row of squares and formatting the plot,

    rectangle('Position',[1,1,2,2],'facecolor',c);
    rectangle('Position',[4,1,2,2],'facecolor',c1_dark);
    rectangle('Position',[7,1,2,2],'facecolor',c2_dark);
    rectangle('Position',[10,1,2,2],'facecolor',c3_dark);
    rectangle('Position',[13,1,2,2],'facecolor',c4_dark);
    hold off;
    axis equal;
    xlim([0,16]);
    ylim([0,12]);
    axis off;
