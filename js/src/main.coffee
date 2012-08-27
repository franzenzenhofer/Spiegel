#dependencies: jquery 1.8.0

errorCallback = (e) ->
  console.log e
  tec_error = (e.message ? e.name) ? e
  $('#mirror').html('<div id="error"><h1>Uh oh....</h1><p>Things don\'t always turn out the way they should! Something happened, and instead of seeing yourself in this awesome HTML5 mirror, you just see this error message. I\'m so sorry, i really am. Ok, ok, lets work together here. How can we fix this? To make this HTML5 mirror work you need:
  <ul>
    <li>a webcam</li>
    <li>a modern HTML5 browser</li>
    <li>that supports your webcam</li>
    <li>currently this means (more or less): <a href="https://www.google.com/chrome" target="_blank">Google Chrome</a></li>
  </ul>
  Oh yeah, and when your browser asks you to access your webcam, you have to click "Allow".
  <br>If this does not solve your problem, and you think it\'s the code and not your browser, just go to <a href="https://github.com/franzenzenhofer/Spiegel">github</a> and start forking - it\'s open source!<p>
  <code>ERROR: '+tec_error+'</code>
  </div>')

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