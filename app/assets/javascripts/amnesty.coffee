$(document).ready ->
  $('#send_socks a').click ->
    Application.showSendSocksInfo()
  $('#buy_socks a').click ->
    Application.showBuySocksInfo()    
  $('.info_box a.close_info_box').click ->
    Application.hideInfoBox()

Application =
  hideInfoBox: ->
    $('.info_box:visible').hide()
    $('#video_wrapper').fadeIn(100)
  showBuySocksInfo: ->
    if $('#buy_socks_info').is(':visible')
      Application.hideInfoBox()
    else
      $('#video_wrapper:visible, .info_box:visible').hide()
      $('#buy_socks_info').fadeIn(100)
  showSendSocksInfo: ->
    if $('#send_socks_info').is(':visible')
      Application.hideInfoBox()
    else
      $('#video_wrapper:visible, .info_box:visible').hide()
      $('#send_socks_info').fadeIn(100)