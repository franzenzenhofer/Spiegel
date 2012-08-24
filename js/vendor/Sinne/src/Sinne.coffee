###
V 1.0 - Sinne.coffe 
MIT License
(c) Franz Enzenhofer
###
Sinne = {}

#Sinne is global
#future save for node.js style exports
(window ? module.exports).Sinne = Sinne

Sinne.getUserMedia = (config, success, error) ->
  #success and error event handler are mandatory
  until success then return false
  until error then return false
  navigator.getUserMedia_ = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);
  if !!navigator.getUserMedia_
    config_object = {}
    config_string = ''
    if config.video is true
      config_object.video = true; config_string='video'
    if config.audio is true
      config_object.audio = true
      if config_string isnt '' then config_string = config_string+', '
      config_string = config_string+'audio'

    try
      r = navigator.getUserMedia_(config_object, success, error)
    catch e
      try
        r = navigator.getUserMedia_(config_string, success, error)
      catch e2 #neither of the config approchrs worked
        error({
          name:'configuration_syntax_not_supported'
          message:'could not configure getUserMedia'
          sinne_error_id: 1
          })
        return false
    return r
  else #no support for getUserMedia
    error({
      name:'getUsereMedia_not_supported'
      message:'getUsereMedia is not supported'
      sinne_error_id: 0
      })


getUserX = (video_support=false, audio_support=false, success, error, options={}) ->
  if video_support is true
    element = document.createElement('video')
  else if audio_support is true
    element = document.createElement('audio')
  else
    error({
      name:'neither_audio_nor_video'
      message:'neither audio nor video support is requested'
      sinne_error_id: 3
      })
    return false
  success_ = (stream) ->
    if MediaStream? and stream instanceof MediaStream #FF
      element.src = stream
    else
      vendorURL = window.URL ? window.webkitURL
      element.src = if vendorURL then vendorURL.createObjectURL(stream) else stream
    success(element, stream)
  default_options = {
    autoplay: true
    controls:true
    init: (element) -> 
      element.play()
      element.addEventListener('error', (e)->error({
        name:'init_didnt_work'
        message:'initialzing the '+e.srcElement+' didn\'t work out'
        sinne_error_id: 4
        }))
  }
  #merge options with default options
  options_ = {}
  options_[key] = val for key, val of default_options
  options_[key] = val for key, val of options


  #loop through the options and assign to the element
  element[key] = value for key,value of options_

  #init
  options_.init?(element)

  Sinne.getUserMedia({video:video_support, audio:audio_support}, success_, error)

Sinne.getUserVideo = (success, error, options) ->
  audio_support = false
  if options?.audio is true then audio_support = true
  getUserX(true, audio_support, success, error, options)

#now works in FF nightly, kinda
Sinne.getUserAudio = (success, error, options) ->
  getUserX(false, true, success, error, options)
