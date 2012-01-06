Animations= 
  fadeInVideo: ->
    $('#video').delay(750).fadeIn(2000)

$(document).ready ->
  Animations.fadeInVideo()
  
# root = exports ? this
# root.onYouTubePlayerReady = (playerId) -> console.log ("Ready!")
