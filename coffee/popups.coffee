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
      $("footer").css("padding-right", padright)
      if $(".house-page-wrapper").length >= 1
        $(".house-page-wrapper").css("padding-right", padright)
      @wrapper().show()

    bg_off: ->
      @background().css('opacity',0).hide()
      @body().css("padding-right", 0).css("overflow", "auto")
      $("footer").css("padding-right", 0)
      if $(".house-page-wrapper").length >= 1
        $(".house-page-wrapper").css("padding-right", 0)
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
      if $(box).hasClass("popup-with-sroll")
        $(".popup__scroll-block").perfectScrollbar("destroy")
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
    false


  $("html").on 'click', ".popup-wrapper", (e)->
    if e.target.className == 'popup-wrapper'
      return if $(".popup-layer").find(".noclose").length > 0
      chld = $(".popup-layer").children().hidePop()

  $(window).off 'keydown', null
  $(window).on 'keydown', null, (e) ->
    if e.which == 27
      $(window).escPop()