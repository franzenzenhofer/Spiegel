fs     = require 'fs'
{exec} = require 'child_process'

#change patho to your personal closure and yui directory
path_to_special_bin = '/Users/franzseo/bin/'

task 'build', 'Build project from src/*.coffee to lib/*.js', ->
  exec 'coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
    
task 'watch', 'Watch build project from src/*.coffee to lib/*.js', ->
  exec 'coffee --watch --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
    
task 'minjs', 'Minify Js', ->
  exec 'java -jar '+path_to_special_bin+'"compiler.jar" --compilation_level SIMPLE_OPTIMIZATIONS --js lib/Sinne.js  --js_output_file lib/Sinne.min.js', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

#task 'minhtml', 'Minify HTML', ->
#      exec 'java -jar '+path_to_special_bin+'htmlcompressor.jar -o index.html index.src.html', (err, stdout, stderr) ->
#        throw err if err
#        console.log stdout + stderr

#task 'mincss', 'Minify CSS', ->
#  exec 'java -jar '+path_to_special_bin+'yui.jar -o css/min.css css/style.css', (err, stdout, stderr) ->
#    throw err if err
#    console.log stdout + stderr