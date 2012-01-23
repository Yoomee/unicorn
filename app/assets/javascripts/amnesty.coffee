$(document).ready ->
  Tweets.init()
  $('#send_socks a').click ->
    event.preventDefault()
    InfoBox.showSendSocks()
  $('#buy_socks a').click ->
    event.preventDefault()
    InfoBox.showBuySocks()
  $('#buy_btn').click ->
    event.preventDefault()
    InfoBox.showBuySocksIframe()
  $('.info_box a.close_info_box').click ->
    event.preventDefault()
    InfoBox.hideAll()
  $('#header_content').delay(500).fadeIn 1000, ->
    $('#send_socks').fadeIn 500
    $('#buy_socks').delay(400).fadeIn 500
    $('#find_out_more').delay(800).fadeIn 500, ->
      $('#tweet_stream').animate {'margin-top':0, 'margin-bottom':0, height:80,'padding-top':12,'padding-bottom':12,'background-position-y':0,opacity:1}, ->
        $('#tweet_stream_content').fadeIn 1000, ->
          $('#footer').fadeIn 1000
    
InfoBox =
  hideAll: ->
    $('.info_box:visible').fadeOut 100, ->
      $('#video_wrapper').fadeIn(300)
  showBuySocks: ->
    if $('#buy_socks_info').is(':visible')
      InfoBox.hideAll()
    else
      $('#video_wrapper:visible, .info_box:visible').fadeOut 100, ->
        $('#buy_socks_info').fadeIn(300)
  showBuySocksIframe: ->
    $('#video_wrapper:visible, .info_box:visible').fadeOut 100, ->
      $('#buy_socks_iframe').fadeIn(300)
  showSendSocks: ->
    if $('#send_socks_info').is(':visible')
      InfoBox.hideAll()
    else
      $('#video_wrapper:visible, .info_box:visible').fadeOut 100, ->
        $('#send_socks_info').fadeIn(300)

window.Tweets =
  init: ->
    if $('.tweet').length > 1
      Tweets.tweetWidth = $('.tweet').outerWidth()
      $('#all_tweets').css('width', Tweets.tweetWidth * $('.tweet').length)
      Tweets.resetInterval()
      $('#next_tweet').show()
      $('#next_tweet').click (event) ->
        event.preventDefault()
        Tweets.next()
  resetInterval: ->
    if Tweets.interval != undefined
      window.clearInterval(Tweets.interval)
    Tweets.interval = window.setInterval("Tweets.next()", 5000)
  next: ->
    $('#all_tweets').animate {left: "-=#{Tweets.tweetWidth}"}, 500, ->
      $('#all_tweets').append($('.tweet:first').detach()).css('left', 0)
      Tweets.resetInterval()

Animations= 
  videoVisible: false
  fadeInVideo: ->
    if !Animations.videoVisible
      Animations.videoVisible = true
      $('#video').fadeIn 1500, => 
        $('#share_this').show().animate({left: '-20px'},'slow')

root = exports ? this
root.onYouTubePlayerReady = (playerId) -> Animations.fadeInVideo()
root.iframeOnload = -> setTimeout("onYouTubePlayerReady()", 2000)
