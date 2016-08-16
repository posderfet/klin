jQuery ->

  # body popup fix
  if $(".house-page-wrapper").length >= 1
    $("body").height( $(".house-page-wrapper").height() )
  $(window).resize ->
    if $(".house-page-wrapper").length >= 1
      $("body").height( $(".house-page-wrapper").height() )


  # top menu toggle
  $("body").off "click", ".top-menu__button"
  $("body").on "click", ".top-menu__button", -> 
    $(".top-menu-wrapper").toggleClass("open-top-menu")
    if $(".top-menu-wrapper").hasClass("open-top-menu")
      $(@).attr("title", "Свернуть меню")
      setTimeout ->
        $(".top-menu-wrapper").addClass("overflow-visible")
      , 600
    else
      $(".top-menu-wrapper").removeClass("overflow-visible")
      $(@).attr("title", "Открыть меню")


  # mobile detect
  md = new MobileDetect(window.navigator.userAgent)
  if md.mobile()
    $("html").addClass("mobile")


  #input placeholder
  $("html").on "focusin", ".text-input", ->
    $(@).parent(".input-field").find(".input-placeholder").hide()
  $("html").on "blur", ".text-input", ->
    if $(@).val() != "" && $(@).val() != "+7(___)___-__-__"
      $(@).parent(".input-field").find(".input-placeholder").hide()
    else
      $(@).parent(".input-field").find(".input-placeholder").show()

  # test