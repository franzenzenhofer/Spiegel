#Sinne - getUsereMedia(...) made simple

note: "Sinne" is the german word for senses. 

Sinne is a small, cross-browser CoffeeScript/JS library for making getUsereMedia really simple. 


**Sinne** it introduces two hihg-level functions

`Sinne.getUserVideo(success, error[, options])` and `Sinne.getUserAudio(success, error[, options])`

these functions give you easy access to the camera and/or microphone of your users.

**Sinne** also introduces a not so simple function, but very useful function, called

`Sinne.getUserMedia(options, success, error)` 

which basically is a cross-browser implementation of `navigator.getUserMedia(…)` (see <a href="http://dev.w3.org/2011/webrtc/editor/getusermedia.html">W3C draft</a>).

##TL;DR
`Sinne.getUserVideo(success, error[, options])` takes the users camera as the input, then callbacks to `success(videoEl, stream)` which gives you a ready to use HTML5 video element as the output.

please see the demos for <a href="https://github.com/franzenzenhofer/Sinne/blob/master/demo/video.html">getUserVideo</a> and <a href="https://github.com/franzenzenhofer/Sinne/blob/master/demo/audio.html">getUserAudio</a>

##where does it work?

a the current state of cross-browser compatibility is a very sad and disturbing affair, cross  in this case means

 * no flash fallback 
 * only works in browsers that support some kind of `getUsereMedia`
 * works in google chrome 21 and up
 * works in google chrome canary
 * works in current firefox nightly builds, if you have <a href="http://www.browsomatic.com/2012/07/firefox-16-now-supports-html5.html">enabled getUsereMedia</a>
 * works in opera next

tested on a macbook air with lion

##what works?

`Sinne.getUserVideo(success, error[, options])` works great over all tested platforms.

`Sinne.getUserAudio(success, error[, options])` works in the FF nightly builds. ok, to be honestit works sometimes (for details see your error callback). and in the cases where it works, it works in a very disturbing way (think echo of an echo of an echo … echo all the way down).

why does it not work in other browsers? well, because it <a href="http://code.google.com/p/chromium/issues/detail?id=112367">isn't implemented yet</a>.

but `Sinne.getUserVideo(…)` is a fine, good working function that believes in a days pay for a days work, so there is no reason not to use it. 


##finally: how does it work?

the whole idea behind `Sinne.getUserVideo(success, error[, options])` is, if i want to access the camera, i want a video. 

and similar if i want to access the microphone, i want an audio back.

so `Sinne.getUserVideo(success, error[, options])` calls the `success` callback with these parameters `success(videoEl, stream)` where videoEL is an HTML5 video element, and `stream` is some kind of low level MediaStream object (or based on the browser-implementation some kind of different stream, god knows why….)

so basically you can do your fancy stuff with `videoEl` element, if you want to go low-level, just use `stream`

the same goes for `Sinne.getUserAudio(success, error[, options])` but guess what, instead of an video you get a fresh new HTML5 audio element. (yeah)

`Sinne.getUserVideo(success, error[, options])` the `option` part of is basically a config object that get copied upon the video (or audio) element. 

ok, the option object can do a little bit more, i.e. see the default option object

```coffeescript
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
``` 

the options also include an `init` function that gets called after the video/audio element was created. (and via the default_options create another useful error listener to catch even more error)

**note**: if you provide your own options object please note, that your options and the default_options gets merged, not replaced.

**note**: another special case is the option `audio:true`, if you provide the `Sinne.getUserVideo` with this option, it will enable both camera and microphone.

**note**: please note, **the success and error handlers are not optional**. especially mind the error handler, `getUserMedia` will throw errors, a lot of them, you need to have proper error handling in place, that's why i made the error handler mandatory. if you refuse to call any of the three methods without proper a proper error callback, the method will just `return false`

## people stuff
thx to <a href="https://github.com/addyosmani/getUserMedia.js">addy osmani</a> for his <a href="https://github.com/addyosmani/getUserMedia.js">getUserMedia shim</a>, i did reuse his code heavily (but not the flash part, once you go down the flash road there is no hope, and what are we without hope?)


me, <a href="http://www.franz-enzenhofer.com/">Franz Enzenhofer</a>, follow me **not** on <a href="https://twitter.com/enzenhofer">twitter</a>.

oh, by the way, i'm at <a href="http://2012.lxjs.org/">LXJS 2012</a> and <a href="http://fronteers.nl/congres/2012">fronteers 2012</a>, talk to me!

##LICENSE

Copyright (c) 2012 Franz Enzenhofer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.








