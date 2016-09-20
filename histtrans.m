%Maps a pixelLevel to an equalizedPixelLevel
function equalizedPixelLevel = histtrans(histogram, pixelLevel, numPixels)
    equalizedPixelLevel = 255 * sum(histogram(1:pixelLevel))/numPixels;