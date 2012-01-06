Animations= 
  videoVisible: false
  fadeInVideo: ->
    if !Animations.videoVisible
      Animations.videoVisible = true
      $('#video').fadeIn 2000, => 
        $('#share_this').show().animate({left: '-20px'},'slow')

root = exports ? this
root.onYouTubePlayerReady = (playerId) -> Animations.fadeInVideo()
root.iframeOnload = -> setTimeout("onYouTubePlayerReady()", 1000)
