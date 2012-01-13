$(document).ready ->
  Tweets.init()
  $('#send_socks a').click ->
    InfoBox.showSendSocks()
  $('#buy_socks a').click ->
    InfoBox.showBuySocks()    
  $('.info_box a.close_info_box').click ->
    InfoBox.hideAll()

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
  showSendSocks: ->
    if $('#send_socks_info').is(':visible')
      InfoBox.hideAll()
    else
      $('#video_wrapper:visible, .info_box:visible').fadeOut 100, ->
        $('#send_socks_info').fadeIn(300)

window.Tweets =
  init: ->
    Tweets.tweetWidth = $('.tweet').outerWidth()
    $('#all_tweets').css('width', Tweets.tweetWidth * $('.tweet').length)
    Tweets.resetInterval()
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