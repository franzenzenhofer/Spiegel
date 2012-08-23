#dependencies: jquery 1.8.0

errorCallback = (e) ->
  console.log e

successCallback = (v, stream) ->
  #window.document.body.appendChild video
  goFullscreen = (elem) ->
    elem.webkitRequestFullScreen?()
    elem.mozRequestFullScreen?()
    elem.requestFullScreen?()
  $(v).hide()
  $('#mirror').html(v)
  $(v).fadeIn(3500)
  #v=$('#vid').get(0)
  $('#fullscreen').fadeIn(2000).click(()->goFullscreen(v))
  #video.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT)
  v.addEventListener('click', ()->
    goFullscreen()
  )
  v.addEventListener('load', ()->
    goFullscreen()
  )

Sinne.getUserVideo successCallback, errorCallback,
  id: "vid"
  controls: false