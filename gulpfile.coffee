gulp = require 'gulp'
loadPlugins = require 'gulp-load-plugins'
$ = loadPlugins()

paths = {
  sass_tree:   'scss/**/*.scss',
  sass:   'scss/application.scss',
  coffee: 'coffee/**/*.coffee',
  slim:   ['slim/**/*.slim', 'slim/pages']
}
dests = {
  sass: 'site/css'
  coffee: 'site/js'
  slim: 'site'
}
site = {
  css: 'site/css/application.css'
}

gulp.task 'default', ['coffee', 'sass', 'slim', 'watch']

gulp.task 'coffee', ->
  gulp.src paths.coffee
  .pipe $.coffee(bare: true)
  # .pipe $.minify
  #   noSource: true
  #   ext:
  #     src: '.full.js'
  #     min: '.js'
  .pipe gulp.dest dests.coffee

gulp.task 'slim', ->
  gulp.src paths.slim
  .pipe $.slim
    pretty: true
    sort_attrs: true
  .pipe gulp.dest 'site'

gulp.task 'sass', ->
  gulp.src paths.sass
  .pipe $.sass()
  # .pipe $.autoprefixer
  #   browsers: ['last 10 versions']
  .pipe $.csso()
  .pipe gulp.dest dests.sass

gulp.task 'minifycss', ->
  gulp.src site.css
  .pipe $.csso()
  .pipe gulp.dest './site/css/main.css'

gulp.task 'watch', ->
  gulp.watch paths.sass_tree,   ['sass']
  gulp.watch paths.coffee, ['coffee']
  gulp.watch paths.slim, ['slim']
