jQuery ->
  class PopupBackground
    background: -> $(".popup-background")
    body: -> $("body")
    scrollbarWidth: undefined
    wrapper: -> $(".popup-wrapper")

    bg_on:  ->
      @background().css('opacity',0).show().fadeTo('normal', 0.5)
      padright = 0
      padright = @scrollbarWidth if @body().height() > $(window).height() #@body.hasScrollBar()
      @body().css("padding-right", padright).css("overflow", "hidden")
      @wrapper().show()

    bg_off: ->
      @background().css('opacity',0).hide()
      @body().css("padding-right", 0).css("overflow", "auto")
      @wrapper().hide()

    is_bg_on: -> @background().is(':visible')

    calc_sbw: ->
      div = document.createElement("div")
      div.style.overflow = "scroll"
      div.style.visibility = "hidden"
      div.style.position = 'absolute'
      div.style.width = '100px'
      div.style.height = '100px'
      document.body.appendChild(div)
      @scrollbarWidth = div.offsetWidth - div.clientWidth
      document.body.removeChild(div)
    constructor: ->
      @calc_sbw()

  class PopupController extends PopupBackground
    layer: -> $(".popup-layer")
    stack: -> $(".popup-stack")

    constructor: ->
      super
      @layer().css('top', "12%")

    stack_push: ->
      children = @layer().children()
      for child in children
        $(child).detach().appendTo(@stack())

    stack_pop: ->
      children = @stack().children()
      for child in children by -1
        @layer().width $(child).innerWidth()
        $(child).detach().appendTo(@layer())
        @bg_on()
        break

    pushPop: (orphan_box)->
      @stack_push()
      @layer().append(orphan_box)
      @layer().width orphan_box.innerWidth()

    hidePop: (box)->
      replace= $(box).attr "data-replace"
      onclose = $(box).attr "data-onclose"
      eval(onclose) if onclose
      if replace
        $(replace, ".static_popups").replaceWith box
      else
        $(box).remove()
      @bg_off()
      @stack_pop()

    showPop: (box)->
      @bg_on()

    escPop: ->
      @layer().children().hidePop()

  popup = new PopupController

  $.fn.pushPop= ->
    popup.pushPop $(@)
    popup.showPop()

  $.fn.showPop= ->
    if $(@).parents('.static_popups').length > 0
      node=$(@).clone()
      popup.pushPop node
      popup.showPop()
    else
      popup.showPop($(@))

  $.fn.hidePop= ->
    popup.hidePop($(@))

  $.fn.escPop= ->
    return if $(".popup-layer").find(".noclose").length > 0
    popup.escPop()

  $.fn.hasScrollBar= ->
    return @.get(0).scrollHeight > @.height()


  $("html").on "submit", ".popup_form", ->
    url = $(@).attr 'action'
    type = $(@).attr 'method'
    data = $(@).serialize()
    success= (html)->
      node=$(html)
      popup.pushPop node
      node.showPop()
    $.ajax {type, data, url, success}
    false

  $("html").on "click", ".popup_link", ->
    url = $(@).attr 'data-url'
    $.get url, null, (html)->
      node=$(html)
      popup.pushPop node
      node.showPop()

  $("html").on 'click', ".popup-wrapper .close-this", ->
    $(@).parents(".popup-window").hidePop()
    $(@).parents(".popup-window").addClass("qwerty")
    false


  $("html").on 'click', ".popup-wrapper", (e)->
    if e.target.className == 'popup-wrapper'
      return if $(".popup-layer").find(".noclose").length > 0
      chld = $(".popup-layer").children().hidePop()

  $(window).off 'keydown', null
  $(window).on 'keydown', null, (e) ->
    if e.which == 27
      $(window).escPop()



  # poupus floor
  $("html").on 'click', ".house-section.selected .house-floor", ->
    floor = $(@).data("building-floor")
    section = $(@).closest(".house-section").data("building-section")
    building = $(@).closest(".building-wrapper").data("building")
    popup_token = "gp"+building+"_s"+section
    console.log popup_token
    $('[data-popup-token="'+popup_token+'"]').showPop()

  # popup apartment
  $("html").on 'click', ".map-floor__apartment", ->
    apartment_token = $(@).data("apartment-token")
    $(".img-apartment-map").attr("src", "images/"+apartment_token+".png")
    $(".popup-apartment").showPop()


  # popup legend floor
  $("html").on 'mouseenter', ".floor-map__legend-item", ->
    if $(@).attr("data-legend-apartment") == "1p"
      $(".map-floor__apartment-1p").addClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "1s"
      $(".map-floor__apartment-1s").addClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "2"
      $(".map-floor__apartment-2").addClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "2p"
      $(".map-floor__apartment-2p").addClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "3"
      $(".map-floor__apartment-3").addClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "3p"
      $(".map-floor__apartment-3p").addClass("map-show-apartment")

  $("html").on 'mouseleave', ".floor-map__legend-item", ->
    if $(@).attr("data-legend-apartment") == "1p"
      $(".map-floor__apartment-1p").removeClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "1s"
      $(".map-floor__apartment-1s").removeClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "2"
      $(".map-floor__apartment-2").removeClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "2p"
      $(".map-floor__apartment-2p").removeClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "3"
      $(".map-floor__apartment-3").removeClass("map-show-apartment")
    if $(@).attr("data-legend-apartment") == "3p"
      $(".map-floor__apartment-3p").removeClass("map-show-apartment")