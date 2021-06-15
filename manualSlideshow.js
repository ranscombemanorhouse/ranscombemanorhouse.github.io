(function () {
const images = [
    [ '03.jpg', 'Fern bedroom'],
    [ '05.jpg', 'Rose bedroom'],
    [ '06.jpg', 'Wisteria bedroom'],
    [ '07.jpg', 'Wisteria bedroom'],
    [ '08.jpg', 'Wisteria bedroom'],
    [ '09.jpg', 'Iris bedroom'],
    [ '10.jpg', 'View from Rose bathroom window'],
    [ '11.jpg', 'Sitting room'],
    [ '12.jpg', 'Dining room'],
    [ '13.jpg', 'View of parterre from front door'],
    [ '14.jpg', 'Front porch'],
    [ '15.jpg', 'Front of house'],
    [ '16.jpg', 'Builder\'s engraving on stone'],
    [ '17.jpg', 'Seating area outside front of house'],
    [ '18.jpg', 'Ornamental parterre in front of house'],
    [ '19.jpg', 'View of house from behind barns'],
    [ '20.jpg', 'Arial view of house and barns'],
    [ '21.jpg', 'Arial view of house and surroundings'],
    [ '23.jpg', 'View of nearby fields'],
    [ '24.jpg', 'Pink flower on iron railing'],
    [ '25.jpg', 'Pigeon flying from fountain'],
    [ '26.jpg', 'View of pond'],
    [ '27.jpg', 'Swings on lawn'],
    [ '28.jpg', 'Picnic by the pond'],
    [ '29.jpg', 'Stove in kitchen and living area'],
    [ '30.jpg', 'Kitchen and living area'],
    [ '31.jpg', 'White flowers in kitchen'],
    [ '32.jpg', 'Breakfast in Ivy bedroom'],
    [ '33.jpg', 'Iris bedroom'],
    [ '34.jpg', 'Upstairs hallway'],
    [ '35.jpg', 'Rose bathroom'],
    [ '36.jpg', 'Rose bedroom'],
    [ '37.jpg', 'Ivy bedroom'],
    [ '38.jpg', 'Ivy bathroom'],
    [ '39.jpg', 'Wisteria bedroom'],
    [ '40.jpg', 'Wisteria bathroom'],
    [ '41.jpg', 'Sofas in kitchen and living area'],
    [ '42.jpg', 'Sitting room'],
    [ '43.jpg', 'Kitchen and living area'],
    [ '44.jpg', 'Arial view of house and surroundings'],
    [ '45.jpg', 'High arial view, including distant sea view']
    ]

function view(i) {
    const container = document.getElementById("manualslideshow")
    container.removeChild("image")
    container.appendChild(makeChild(i))
}

let imageNumber = 0 

function makeChild(i) {
    const mySlides = document.createElement("div")
    const numberText = document.createElement("div")
    numberText.innerHtml = (i + 1).toString() + " / " + images.length.toString()
    mySlides.appendChild(numberText)

    const imageDiv = document.createElement("div")
    const image = document.createElement("img")
    image.src = 'clickslideshow/' + images[i][0]
    image.alt = images[i][1]
    imageDiv.appendChild(image)
    mySlides.appendChild(imageDiv)

    return mySlides
}

const container = document.getElementById("manualslideshow")
container.class = "slideshow-container"

const imagesDiv = document.createElement("div")
imagesDiv.appendChild(makeChild(0))
container.appendChild(imagesDiv)

const dotsDiv = document.createElement("div")
dotsDiv.style = "text-align:center"
for (i = 0; i < images.length; i++) {
    const dotDiv = document.createElement("div")
    dotDiv.onclick = function() {
        view(i)
    }
    dotDiv.class = "dot"
}

function incrementImage(i) {
    if (i === images.length - 1) {
        return 0
    }
    return i + 1
}

const leftButton = document.createElement("button")
leftButton.onclick = function() {
    imageNumber = incrementImage(imageNumber)
    view(imageNumber)
}
leftButton.innerHtml = "<"
container.appendChild(leftButton)

const rightButton = document.createElement("button")
rightButton.onclick = function() {
    imageNumber = decrementImage(imageNumber)
    view(imageNumber)
}

})()

// var slideIndex = 1;
// showSlides(slideIndex);
// 
// // Next/previous controls
// function plusSlides(n) {
//     showSlides(slideIndex += n);
// }
// 
// // Thumbnail image controls
// function currentSlide(n) {
//     showSlides(slideIndex = n);
// }
// 
// function showSlides(n) {
//     var i;
//     var slides = document.getElementsByClassName("mySlides");
//     var dots = document.getElementsByClassName("dot");
//     if (n > slides.length) {slideIndex = 1}
//     if (n < 1) {slideIndex = slides.length}
//     for (i = 0; i < slides.length; i++) {
//         slides[i].style.display = "none";
//     }
//     for (i = 0; i < dots.length; i++) {
//         dots[i].className = dots[i].className.replace(" active", "");
//     }
//     slides[slideIndex-1].style.display = "block";
//     dots[slideIndex-1].className += " active";
// } 
