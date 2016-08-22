jQuery ->

  # commercial slider init
  c_get_slider=(building_key) ->
    $(".commercial-carousel[data-building='"+building_key+"']").slick
      infinite: true
      slidesToShow: 3
      slidesToScroll: 1
      variableWidth: true
      focusOnSelect: false
      centerMode: false
      prevArrow: $(".commercial-carousel__prev-button")
      nextArrow: $(".commercial-carousel__next-button")


  # commercial form
  $(".commercial-input-phone").mask("+7(999)999-99-99")
  $("#commercial-request-form").validate
      rules:
        name:
          required: true
        phone:
          required: true


  cr_slider = document.getElementById("cr-slider")
  cr_input = document.getElementById("cr-input")
  noUiSlider.create cr_slider,
      start: [ 60 ]
      range:
        'min': [ 30 ]
        'max': [ 300 ]
      step: 1
      tooltips:
        wNumb(decimals: 0, postfix: '<span>м<sup>2</sup></span>')
      format: wNumb
        decimals: 0
  cr_slider.noUiSlider.on "update", (values, handle) ->
    cr_input.value = values[handle]
  cr_input.addEventListener 'change', ->
    cr_slider.noUiSlider.set @value
    return


  # commercial legend
  $("html").on 'mouseenter', ".commercial-legend__state-item", ->
    space_state = $(@).attr("data-state")
    $(".commercial-space-group.space-"+space_state).addClass("state-hover")

  $("html").on 'mouseleave', ".commercial-legend__state-item", ->
    space_state = $(@).attr("data-state")
    $(".commercial-space-group.space-"+space_state).removeClass("state-hover")


  # commercial scheme
  $("html").on 'mouseenter', "commercial-space-path", ->
    $(@).find("polygon").attr("fill", "red")


  # scroll ini
  # $(".commercial-building-scheme").width($(".commercial-image-map:visible").naturalWidth)
  $(window).resize ->
    $(".commercial-building-scheme").width($(".commercial-image-map:visible").width())

  $(".commercial-building-scheme-scroll").perfectScrollbar
    suppressScrollY: true
    scrollYMarginOffset: 50
    theme: "yellow-scroll"

  # # $("html").on "mousedown", ".commercial-building-scheme-scroll", ->
  # $("html").on "mousemove", ".commercial-building-scheme-scroll",(e) ->
  #   client_x = e.clientX


  # commercial popup
  $("html").on "click", ".commercial-popup-button", ->
    $(".commercial-request-popup").showPop()

    building_key = $(".commercial-popup-button").attr("data-building")
    $(".commercial-popup-input-hidden").val(building_key)

    $(".commercial-input-phone_popup").mask("+7(999)999-99-99")

    $("#commercial-request-form-popup").validate
      rules:
        name:
          required: true
        phone:
          required: true

    crp_slider = document.getElementById("crp-slider")
    crp_input = document.getElementById("crp-input")
    noUiSlider.create crp_slider,
        start: [ 60 ]
        range:
          'min': [ 30 ]
          'max': [ 300 ]
        step: 1
        tooltips:
          wNumb(decimals: 0, postfix: '<span>м<sup>2</sup></span>')
        format: wNumb
          decimals: 0
    crp_slider.noUiSlider.on "update", (values, handle) ->
      crp_input.value = values[handle]
    crp_input.addEventListener 'change', ->
      crp_slider.noUiSlider.set @value
      return
  $("body").height( $(".house-page-wrapper").height() )


  # change building
  c_change_building=(building_key) ->
    header = $(".commecial-header").data("header-"+building_key)
    $(".commecial-header").html(header)
    $(".commercial-legend__svg-building").removeClass("state-active")
    $(".commercial-legend__svg-building[data-building='"+building_key+"']").addClass("state-active")
    $(".comercial-tab__item").removeClass("state-active")
    $(".comercial-tab__item[data-building='"+building_key+"']").addClass("state-active")
    $(".commercial-popup-button").attr("data-building", building_key)
    $(".commercial-input-hidden").val(building_key)
    $(".commercial-building-scheme").each ->
      key = $(@).data("building")
      if key == building_key
        $(@).show()
      else
        $(@).hide()
    $(".commercial-building-scheme").width($(".commercial-image-map:visible").width())
    $(".commercial-building-scheme-scroll").perfectScrollbar("update")
    $(".commercial-carousel").each ->
      key = $(@).data("building")
      if key == building_key
        $(@).show()
      else
        $(@).hide()
        if $(@).hasClass("slick-initialized")
          $(@).slick("unslick")
    c_get_slider(building_key)
    
  

  c_change_building(1)

  $("html").on "click", ".comercial-tab__item", ->
    building_key = $(@).data("building")
    c_change_building(building_key)

  $("html").on "click", ".commercial-legend__svg-building", ->
    building_key = $(@).data("building")
    c_change_building(building_key)

  $("body").height( $(".house-page-wrapper").height() )