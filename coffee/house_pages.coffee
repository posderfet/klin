# background building resize and position
MIN_HEIGHT = null
MIN_WIDTH  = null
MAX_LEFT   = null
MAX_TOP    = null

window.onresize= ->
  MIN_HEIGHT = parseInt $(".house-page-wrapper").css("min-height").replace("px", "")
  MIN_WIDTH = parseInt $(".house-page-wrapper").css("min-width").replace("px", "")
  
  
  width = $(window).width()
  height = $(window).height()
  width = MIN_WIDTH if width < MIN_WIDTH
  height= MIN_HEIGHT if height < MIN_HEIGHT
  
  img = $(".house-canvas__background-image")
  try
    MAX_LEFT||= parseInt($(img).attr("data-max-left")) / 100.0
  catch
  try
    MAX_TOP||= parseInt($(img).attr("data-max-top")) / 100.0
  catch

  img =img[0]

  img_width  = img.naturalWidth
  img_height = img.naturalHeight
  aspect_ratio = 1.0*img_width/img_height
  window_aspect_ratio = 1.0*width/height
  wrapper = $(".house-canvas-wrapper")
  debug=$(".debug")
  if debug.length > 0
    debug.html( "#{$(window).width()}x#{$(window).height()}" + "<br/>" +
      "#{width}x#{height}: #{window_aspect_ratio.toFixed(2)}"+ "<br/>" +
      "#{img_width}x#{img_height}: #{aspect_ratio.toFixed(2)}")
  [wrapper_height, wrapper_width] = [0, 0]

  if window_aspect_ratio < aspect_ratio
    wrapper_height= height
    wrapper_width= height*aspect_ratio
  else
    wrapper_width=width
    wrapper_height=width/aspect_ratio
  wrapper.css width: wrapper_width, height: wrapper_height
  if wrapper_width - width > 0
    if MAX_LEFT
      wrapper.css left: "#{Math.max(-MAX_LEFT*width, width - wrapper_width)}px"
    else
      wrapper.css left: "#{width - wrapper_width}px"

  else
    wrapper.css left: 0
  if wrapper_height - height > 0
    if MAX_TOP
      wrapper.css top: "#{Math.max(-MAX_TOP*height, height - wrapper_height)}px"
    else
      wrapper.css top: "#{height - wrapper_height}px"
  else
    wrapper.css top: 0

  wrapper.show()

jQuery ->
  $(window).resize onresize
  img = $(".house-canvas__background-image")[0]

  # choice house section and position
  $(".choice-house-section").css("left", $(".site-header__logo").offset().left)
  $(window).resize ->
    $(".choice-house-section").css("left", $(".site-header__logo").offset().left)

  close_section = ->
    if $("#house-canvas").hasClass("open-section")
      $("#house-canvas").removeClass "open-section"
      $("#house-canvas .house-section.selected").removeClass "selected"
      $(".choice-house__section-slide").hide()
      $(".choice-house__apartment").show()
  $("html").click (e)->
    if $(e.target).hasClass("house-canvas__background-image") or $(e.target).hasClass("main-container")
      close_section()

  $("html").on "click", "#house-canvas.open-section .house-section:not(.selected)", (e)->
      close_section()

  $("html").on "click", ".slide-prev", ->
    ps= $("#house-canvas .house-section.selected").prev()
    unless ps.length == 0
      $("#house-canvas .house-section.selected").removeClass("selected")
      open_section(ps)

  $("html").on "click", ".slide-next", ->
    ns= $("#house-canvas .house-section.selected").next()
    unless ns.length == 0
      $("#house-canvas .house-section.selected").removeClass("selected")
      open_section(ns)

  $("html").on "click", "#house-canvas:not(.open-section) .house-section", (e)->
    open_section $(@)
  open_section= (s)->
    $("#house-canvas").addClass("open-section")
    $("#house-canvas .house-section").removeClass("selected")
    $(s).addClass "selected"
    section_no = if $(s).hasClass "one-section"
      1
    else if $(s).hasClass "two-section"
      2
    else if $(s).hasClass "three-section"
      3
    else
      4
    sslide = $ ".choice-house__section-slide"
    sslide.find(".slide-count__number").html section_no
    $(".choice-house__apartment").hide()
    sslide.show()

  $("html").on "click", ".choice-house__ago", ->
    $("#house-canvas .house-section.selected").removeClass("selected")
    $("#house-canvas.open-section").removeClass("open-section")
    $(".choice-house__section-slide").hide()
    $(".choice-house__apartment").show()