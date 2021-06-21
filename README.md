# Ranscombe Holiday Cottage

This repository contains the source code for the website of Ranscombe Manor House, which is a self-catering cottage in Devon.

The site is hosted on Github pages.

All you need to do to edit the site is to use ```git clone``` to download the code, edit it as you wish and then push it back to Github with ```git push```.

I tend to push the code to Github using HTTP, and enter a password, rather than using SSH. Github will not allow the same SSH key to be used for multiple accounts. I work with multiple websites, each in their own Github account. There is probably some way to use multiple SSH keys, but it is less trouble to just type the password.

All the assets are hosted in one place, except the video on the home page, which is hosted on Youtube. I tried hosting the video on Github Pages with the rest, using an HTML <video> tag, but it was stuttery. I think Youtube have fancy software that can deliver the right quality for the connection. Or perhaps Github Pages is just not very good and can't cope with large files.

# Code structure

There is an HTML document for each page. All the CSS styles are in 'styles.css'. The site is handcoded HTML, CSS, Javascript and Elm.

Elm is a statically-typed functional programming language that compiles to Javascript. See [here](https://guide.elm-lang.org/install/elm.html) for installation instructions and documentation.

I used Elm for the slideshow on the main page, because it was getting complicated to do it in Javascript. Elm has a UI library called elm-ui which greatly simplifies layout, removing the need to write CSS. It also has a very good type system that catches most errors at compile time.

The Elm code is in the directory ```elmSlideshow/src```. To build the javascript file run the build script at ```elmSlideshow/build.sh```. This generates a minified Javascript file at the root called ```manualslideshow.js```.

The slideshow contains a lot of relatively large images. These are loaded in a hidden div at the bottom of the main page, so that they are in the browser cache as soon as possible. Then there is a Javascript function in a <script> tag on the home page that sends a message through a port to the Elm code when the page has loaded. All the images are then in the browser cache, so the slideshow works smoothly. When the Elm code receives the message that the images have loaded it enables the slideshow.

# Fonts

The site uses two web fonts from Google Fonts. It was found that loading them from Google took a long time on a slow connection, so I downloaded the font style files and the woff files they link to, and hosted them with the site, in the 'fonts' directory.
