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
      if $(".house-page-wrapper").length >= 1
        $(".house-page-wrapper").css("padding-right", padright)
      @wrapper().show()

    bg_off: ->
      @background().css('opacity',0).hide()
      @body().css("padding-right", 0).css("overflow", "auto")
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



  

  # poupus floor
  MAX_FLOOR = null
  FLOOR = null
  $("html").on 'click', ".house-section.selected .house-floor", ->
    MAX_FLOOR = $(@).parent().data("max-floor")
    floor = $(@).data("building-floor")
    section = $(@).closest(".house-section").data("building-section")
    building = $(@).closest(".building-wrapper").data("building")
    popup_token = "gp"+building+"_s"+section
    if $(@).hasClass("bind-hover")
      $('[data-popup-token="'+popup_token+'"]').showPop()
      $('[data-popup-token="'+popup_token+'"]').attr("data-floor-section", floor)
      .find(".popup-floor-slider__count-number").html(floor)
      floor_slider_check()
    $(".house-floor").removeClass("bind-hover")
    if $("html").hasClass("no-touchevents")
      $('[data-popup-token="'+popup_token+'"]').showPop()
      $('[data-popup-token="'+popup_token+'"]').attr("data-floor-section", floor)
      .find(".popup-floor-slider__count-number").html(floor)
      floor_slider_check()
    if $("html").hasClass("touchevents")
      $(@).addClass("bind-hover")

  # popup apartment
  $("html").on 'click', ".map-floor__apartment", ->
    apartment_token = $(@).data("apartment-token")
    building = apartment_token.slice(0,2)
    floor = $(@).parents(".popup-floor").attr("data-floor-section")
    room = $(@).data("apartment-room")
    area = $(@).data("apartment-area")
    price = $(@).data("apartment-price")
    apartment_info = $(".popup-apartment__info")
    if $(@).hasClass("sold")
      return
    else
      $(".popup-apartment").showPop()
      $(".img-apartment-map").attr("src", "images/"+apartment_token+".png")
      apartment_info.find(".room-count").html(room)
      apartment_info.find(".area-count").html(area)
      apartment_info.find(".price-count").html(price)
      $(".popup-apartment").attr("data-floor-apartment", floor)
      .find(".popup-floor-slider__count-number").html(floor)
      floor_slider_check()
      if building != "b3"
        $("#open-repair-option").hide()
        $(".popup-apartment__menu").css("height", "25.104rem")

  # floor slider
  floor_slider_check= ->
    slider = $(".popup-floor-slider")
    count = parseInt(slider.find(".popup-floor-slider__count-number").html(), 10)
    if count == MAX_FLOOR
      slider.find(".popup-floor-slider__up").addClass("floor-slider-disable")
      slider.find(".popup-floor-slider__down").removeClass("floor-slider-disable")
    if count == 2
      slider.find(".popup-floor-slider__down").addClass("floor-slider-disable")
      slider.find(".popup-floor-slider__up").removeClass("floor-slider-disable")

  $("html").on "click", ".popup-floor-slider__up", ->
    $(".popup-floor-slider__down").removeClass("floor-slider-disable")
    floor_el = $(@).parent().find(".popup-floor-slider__count-number")
    floor = parseInt(floor_el.html(), 10)
    parent_popup = $(@).parents(".popup-window")
    if parent_popup.hasClass("popup-apartment")
      console.log "123"
    if floor == MAX_FLOOR
      return
    else
      floor_el.html(floor + 1)
      FLOOR = floor + 1
      $(@).parents(".popup-apartment").attr("data-floor-apartment", FLOOR)
      $(@).parents(".popup-floor").attr("data-floor-section", FLOOR)
      if FLOOR == MAX_FLOOR
        $(@).addClass("floor-slider-disable")

  $("html").on "click", ".popup-floor-slider__down", ->
    $(".popup-floor-slider__up").removeClass("floor-slider-disable")
    floor_el = $(@).parent().find(".popup-floor-slider__count-number")
    floor = parseInt(floor_el.html(), 10)
    parent_popup = $(@).parents(".popup-window")
    if floor == 2
      return
    else
      floor_el.html(floor - 1)
      FLOOR = floor - 1
      $(@).parents(".popup-apartment").attr("data-floor-apartment", FLOOR)
      $(@).parents(".popup-floor").attr("data-floor-section", FLOOR)
      if FLOOR == 2
        $(@).addClass("floor-slider-disable")


  # apartment tooltip
  $("html").on 'mousemove', ".map-floor__apartment", (e) ->
    tooltip = $(".floor-map__tooltip")
    room = $(@).data("apartment-room")
    area = $(@).data("apartment-area")
    price = $(@).data("apartment-price")
    client_x = e.clientX
    client_y = e.clientY
    if $(@).hasClass("sold")
      tooltip.addClass("sold")
    else
      tooltip.find(".tooltip-room__count").html(room)
      tooltip.find(".tooltip-area__count").html(area)
      tooltip.find(".tooltip-price__count").html(price)
      if room == 1
        tooltip.find(".tooltip-room__lable").html("комната")
      else
        tooltip.find(".tooltip-room__lable").html("комнаты")
      # tooltip.find(".floor-map__tooltip-ico").css("background-color", color)
      tooltip.removeClass("sold")
    tooltip.css( "top", client_y - 50 ).css( "left", client_x - 15 ).show()
  $("html").on 'mouseout', ".map-floor__apartment", ->
    $(".floor-map__tooltip").hide()
  $("html").on 'click', ".map-floor__apartment", ->
    $(".floor-map__tooltip").hide()

  # popup legend floor
  $("html").on 'mouseenter', ".floor-map__legend-item", ->
    apartment_type = $(@).attr("data-legend-apartment")
    $(".map-floor__apartment-"+apartment_type).addClass("map-show-apartment")

  $("html").on 'mouseleave', ".floor-map__legend-item", ->
    apartment_type = $(@).attr("data-legend-apartment")
    $(".map-floor__apartment-"+apartment_type).removeClass("map-show-apartment")


  # choice apartment
  $("html").on 'click', "#choice-house-button", ->
    $(".popup-choice-apartment").showPop()
    $(".popup__scroll-block").perfectScrollbar()

    ca_room_slider = document.getElementById("ca-room-slider")
    ca_floor_slider = document.getElementById("ca-floor-slider")
    ca_area_slider = document.getElementById("ca-area-slider")
    ca_price_slider = document.getElementById("ca-price-slider")

    ca_room_input_low = document.getElementById("ca-input-room-low")
    ca_room_input_up = document.getElementById("ca-input-room-up")

    ca_floor_input_low = document.getElementById("ca-input-floor-low")
    ca_floor_input_up = document.getElementById("ca-input-floor-up")

    ca_area_input_low = document.getElementById("ca-input-area-low")
    ca_area_input_up = document.getElementById("ca-input-area-up")

    ca_price_input_low = document.getElementById("ca-input-price-low")
    ca_price_input_up = document.getElementById("ca-input-price-up")

    noUiSlider.create ca_room_slider,
      start: [
        1
        4
      ]
      range:
        'min': [ 1 ]
        'max': [ 4 ]
      step: 1
      margin: 0
      connect: true
      behaviour: 'tap-drag'
      format: wNumb
        decimals: 0
    ca_room_slider.noUiSlider.on "update", (values, handle) ->
      (if handle then ca_room_input_up else ca_room_input_low).value = values[handle]
    ca_room_input_low.addEventListener 'change', ->
      ca_room_slider.noUiSlider.set [
        @value
        null
      ]
    ca_room_input_up.addEventListener 'change', ->
      ca_room_slider.noUiSlider.set [
        null
        @value
      ]

    noUiSlider.create ca_floor_slider,
      start: [
        2
        15
      ]
      range:
        'min': [ 2 ]
        'max': [ 15 ]
      step: 1
      margin: 1
      connect: true
      behaviour: 'tap-drag'
      format: wNumb
        decimals: 0
    ca_floor_slider.noUiSlider.on "update", (values, handle) ->
      (if handle then ca_floor_input_up else ca_floor_input_low).value = values[handle]
    ca_floor_input_low.addEventListener 'change', ->
      ca_floor_slider.noUiSlider.set [
        @value
        null
      ]
    ca_floor_input_up.addEventListener 'change', ->
      ca_floor_slider.noUiSlider.set [
        null
        @value
      ]

    noUiSlider.create ca_area_slider,
      start: [
        29.10
        79.90
      ]
      range:
        'min': [ 29.10 ]
        'max': [ 79.90 ]
      step: 0.05
      margin: 5
      connect: true
      behaviour: 'tap-drag'
      format: wNumb
        decimals: 2
        mark: ','
    ca_area_slider.noUiSlider.on "update", (values, handle) ->
      (if handle then ca_area_input_up else ca_area_input_low).value = values[handle]
    ca_area_input_low.addEventListener 'change', ->
      ca_area_slider.noUiSlider.set [
        @value
        null
      ]
    ca_area_input_up.addEventListener 'change', ->
      ca_area_slider.noUiSlider.set [
        null
        @value
      ]

    noUiSlider.create ca_price_slider,
      start: [
        1300000
        5000000
      ]
      range:
        'min': [ 1300000 ]
        'max': [ 5000000 ]
      step: 1000
      margin: 100000
      connect: true
      behaviour: 'tap-drag'
      format: wNumb
        decimals: 0
        thousand: ' '
    ca_price_slider.noUiSlider.on "update", (values, handle) ->
      (if handle then ca_price_input_up else ca_price_input_low).value = values[handle]
    ca_price_input_low.addEventListener 'change', ->
      ca_price_slider.noUiSlider.set [
        @value
        null
      ]
    ca_price_input_up.addEventListener 'change', ->
      ca_price_slider.noUiSlider.set [
        null
        @value
      ]

  # hypothec calc popup
  payment_format = wNumb(
    decimals: 0
    thousand: ' '
  )

  deposit_calculation= ->
    dc_price = parseInt($("#hc-input-price").val().replace(/ /gi,""), 10)
    dc_deposit = parseInt($("#hc-input-deposit").val(), 10)
    dc_total = dc_price*dc_deposit/100
    $("#hypothec_calc_deposit_total").html(dc_total)
    return dc_total

  average_payment= (rate)->
    pc_price = parseInt($("#hc-input-price").val().replace(/ /gi,""), 10)
    pc_deposit = deposit_calculation()
    pc_price_true = pc_price - pc_deposit
    pc_period = parseInt($("#hc-input-period").val().replace(/ /gi,""), 10)
    month_rate = rate/100/12
    month_payment = pc_price_true*(month_rate/(1-(1+month_rate)**-pc_period))
    return month_payment

  payment_install= ->
    dkb_rate = 11.5
    vtb_rate = 11.9
    sber_rate = 11.9
    bankm_rate = 11.9
    mib_rate = 11.99
    rsb_rate = 11.9

    dkb_bank = $(".dkb-bank-item")
    vtb_bank = $(".vtb-bank-item")
    sber_bank = $(".sber-bank-item")
    bankm_bank = $(".bankm-bank-item")
    mib_bank = $(".mib-bank-item")
    rsb_bank = $(".rsb-bank-item")

    dkb_payment = payment_format.to(average_payment(dkb_rate))
    vtb_payment = payment_format.to(average_payment(vtb_rate))
    sber_payment = payment_format.to(average_payment(sber_rate))
    bankm_payment = payment_format.to(average_payment(bankm_rate))
    mib_payment = payment_format.to(average_payment(mib_rate))
    rsb_payment = payment_format.to(average_payment(rsb_rate))

    dkb_bank.find(".hypothec-calc__list-body-payment").html(dkb_payment)
    vtb_bank.find(".hypothec-calc__list-body-payment").html(vtb_payment)
    sber_bank.find(".hypothec-calc__list-body-payment").html(sber_payment)
    bankm_bank.find(".hypothec-calc__list-body-payment").html(bankm_payment)
    mib_bank.find(".hypothec-calc__list-body-payment").html(mib_payment)
    rsb_bank.find(".hypothec-calc__list-body-payment").html(rsb_payment)

  $("html").on 'click', "#open_hypotec_calc", ->
    $(".popup-hypothec-calc").showPop()

    $("#hypothec_calc_form").validate
      rules:
        email:
          required: true,
          email: true

    hc_price_slider = document.getElementById("hc-price-slider")
    hc_deposit_slider = document.getElementById("hc-deposit-slider")
    hc_period_slider = document.getElementById("hc-period-slider")
    hc_price_input = document.getElementById("hc-input-price")
    hc_deposit_input = document.getElementById("hc-input-deposit")
    hc_period_input = document.getElementById("hc-input-period")

    noUiSlider.create hc_price_slider,
        start: [ 3000000 ]
        range:
          'min': [ 1300000 ]
          'max': [ 5005000 ]
        step: 1000
        connect: 'lower'
        format: wNumb
          decimals: 0
          thousand: ' '
    hc_price_slider.noUiSlider.on "update", (values, handle) ->
      hc_price_input.value = values[handle]
      deposit_calculation()
      payment_install()
    hc_price_input.addEventListener 'change', ->
      hc_price_slider.noUiSlider.set @value
      deposit_calculation()
      payment_install()
      return

    noUiSlider.create hc_deposit_slider,
        start: [ 40 ]
        range:
          'min': [ 20 ]
          'max': [ 99 ]
        step: 1
        connect: 'lower'
        format: wNumb
          decimals: 0
          postfix: '%'
    hc_deposit_slider.noUiSlider.on "update", (values, handle) ->
      hc_deposit_input.value = values[handle]
      deposit_calculation()
      payment_install()
    hc_deposit_input.addEventListener 'change', ->
      hc_deposit_slider.noUiSlider.set @value
      deposit_calculation()
      payment_install()
      return

    noUiSlider.create hc_period_slider,
        start: [ 24 ]
        range:
          'min': [ 12 ]
          'max': [ 360 ]
        step: 1
        connect: 'lower'
        format: wNumb
          decimals: 0
    hc_period_slider.noUiSlider.on "update", (values, handle) ->
      hc_period_input.value = values[handle]
      payment_install()
    hc_period_input.addEventListener 'change', ->
      hc_period_slider.noUiSlider.set @value
      payment_install()
      return

    deposit_calculation()
    payment_install()


  # repair option popup
  $("html").on 'click', ".repair-option__photo-prev", ->
    image_src = $(@).attr("src").replace("prev_","")
    $(".repair-option__big-photo-block").css("background", "url("+image_src+")")
    $(".repair-option__big-photo").attr("src", image_src)

  $("html").on 'click', "#open-repair-option", ->
    $(".popup-repair-option").showPop()
    image_src = $(".repair-option__photo-item.first-open").find(".repair-option__photo-prev").attr("src").replace("prev_","")
    $(".repair-option__big-photo-block").css("background", "url("+image_src+")")
    $(".repair-option__big-photo").attr("src", image_src)


  # service popups
  $("html").on 'click', "#open_track_price", ->
    $(".popup-track-price").showPop()
    $("#track-price-form").validate
      rules:
        price:
          required: true,
          digits: true
        email:
          required: true,
          email: true
  $("html").on 'click', "#open_get_planing", ->
    $(".popup-get-planing").showPop()
    $(".get-planing__input-phone").mask("+7(999)999-99-99")
    $("#get-planing-form").validate
      rules:
        email:
          required: true,
          email: true
  $("html").on 'click', "#open_reserv_request", ->
    $(".popup-reserv-request").showPop()
    $(".reserv-request__input-phone").mask("+7(999)999-99-99")
    $("#reserv-request-form").validate
      rules:
        email:
          required: true,
          email: true
        phone:
          required: true