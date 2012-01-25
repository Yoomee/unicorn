$(document).ready ->
  Tweets.init()
  $('#send_socks a').click (event) ->
    event.preventDefault()
    InfoBox.showSendSocks()
  $('#buy_socks a').click (event) ->
    event.preventDefault()
    InfoBox.showBuySocks()
  $('#buy_btn').click (event) ->
    event.preventDefault()
    InfoBox.showBuySocksIframe()
  $('.info_box a.close_info_box').click (event) ->
    event.preventDefault()
    InfoBox.hideAll()
  setTimeout("Animations.header()", 500)
  setTimeout("Animations.sendSocks()", 1500)
  setTimeout("Animations.buySocks()", 1900)
  setTimeout("Animations.findOutMore()", 2300)
  setTimeout("Animations.tweetStream()", 2800)
  setTimeout("Animations.tweetStreamContent()", 3400)
  setTimeout("Animations.footer()", 4400)
  
    #   $('#tweet_stream').animate {'margin-top':0, 'margin-bottom':0, height:80,'padding-top':12,'padding-bottom':12,'background-position-y':0,opacity:1}, 'slow', ->
    #     $('#tweet_stream_content').fadeIn 1000, ->
    #       $('#footer').fadeIn 1000

Animations= 
  header: ->
    $('#header_content').fadeIn 1000
  sendSocks: ->
    $('#send_socks').fadeIn 500
  buySocks: ->
    $('#buy_socks').fadeIn 500
  findOutMore: ->
    $('#find_out_more').fadeIn 500
  tweetStream: ->
    $('#tweet_stream').animate {'margin-top':0, 'margin-bottom':0, height:80,'padding-top':12,'padding-bottom':12,'background-position-y':0,opacity:1}, 600
  tweetStreamContent: ->
     $('#tweet_stream_content').fadeIn 1000
  footer: ->
    $('#footer').fadeIn 1000
  videoVisible: false
  fadeInVideo: ->
    if !Animations.videoVisible
      Animations.videoVisible = true
      $('#video').animate {opacity:1}, 2000, => 
        $('#share_this').show().animate({left: '-20px'},'slow')

    
InfoBox =
  hideAll: ->
    $('.info_box:visible,.close_info_box').fadeOut 100, ->
      $('#video_wrapper').fadeIn(300)
  showBuySocks: ->
    if $('#buy_socks_info').is(':visible')
      InfoBox.hideAll()
    else
      $('#video_wrapper:visible, .info_box:visible').fadeOut 100, ->
        $('#buy_socks_info,.close_info_box').fadeIn(300)
  showBuySocksIframe: ->
    $('#video_wrapper:visible, .info_box:visible').fadeOut 100, ->
      $('#buy_socks_iframe').fadeIn 300, ->
        $('#buy_socks_iframe .close_info_box').fadeIn 300
      
  showSendSocks: ->
    if $('#send_socks_info').is(':visible')
      InfoBox.hideAll()
    else
      $('#video_wrapper:visible, .info_box:visible').fadeOut 100, ->
        $('#send_socks_info').fadeIn 300, ->
          $('#send_socks_info .close_info_box').fadeIn 300

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

root = exports ? this
root.onYouTubePlayerReady = (playerId) -> Animations.fadeInVideo()
root.iframeOnload = -> setTimeout("onYouTubePlayerReady()", 2000)
root.Animations = Animations
