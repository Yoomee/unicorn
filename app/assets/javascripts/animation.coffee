Animations= 
  fadeInVideo: ->
    $('#video').delay(1000).fadeIn(2000)

$(document).ready ->
  Animations.fadeInVideo()
