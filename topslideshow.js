var curIndex = 0,
    imgDuration = 4000,
    slider = document.getElementById("slider"),
    slides = slider.childNodes;
    imgArray = [
        'topslideshow/20wisteria.jpg',
        'topslideshow/02parterre.jpg',
        'topslideshow/01arialview.jpg',
        'topslideshow/09pinkflower.jpg',
        'topslideshow/mainImage.jpg',
        'topslideshow/lounge2.jpg',
        'topslideshow/10ivy.jpg',
        'topslideshow/14ivy.jpg',
        'topslideshow/15fern.jpg',
        'topslideshow/19wisteria.jpg'];


function buildSlideShow(arr) {
    for (i = 0; i < arr.length; i++) {
        var img = document.createElement('img');
        img.className = "sliderimg";
        img.src = arr[i];
        slider.appendChild(img);
    }
}


function slideShow() {
    function fadeIn(e) {
        e.className = "fadeIn";
    };
    function fadeOut(e) {
        e.className = "";
    };

    fadeOut(slides[curIndex]);

    curIndex++;
    if (curIndex == slides.length) {
        curIndex = 0;
    }

    fadeIn(slides[curIndex]);

    setTimeout(slideShow, imgDuration);
};


buildSlideShow(imgArray);
slideShow();
