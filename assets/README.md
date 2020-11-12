Use this command to remap every images to the colormap

```find . -type f -exec mogrify -remap colormap.png {} \;```