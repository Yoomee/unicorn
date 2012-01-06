$(document).ready ->
  $('#send_socks a').click ->
    Application.showSendSocksInfo()
  $('#buy_socks a').click ->
    Application.showBuySocksInfo()    
  $('.info_box a.close_info_box').click ->
    Application.hideInfoBox()

Application =
  hideInfoBox: ->
    $('.info_box:visible').fadeOut 100, ->
      $('#video').fadeIn(100)
  showBuySocksInfo: ->
    if $('#buy_socks_info').is(':visible')
      Application.hideInfoBox()
    else
      $('#video:visible, .info_box:visible').fadeOut 100, ->
        $('#buy_socks_info').fadeIn(100)
  showSendSocksInfo: ->
    if $('#send_socks_info').is(':visible')
      Application.hideInfoBox()
    else
      $('#video:visible, .info_box:visible').fadeOut 100, ->
        $('#send_socks_info').fadeIn(100)