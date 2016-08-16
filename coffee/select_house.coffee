jQuery ->

  $("html").on "mouseover", ".select-house__building-hover", ->
    if $("html").hasClass("no-touchevents")
      if $(@).hasClass("select-house__building-gp1")
        $(".select-house__info-gp1").addClass("bind-hover")
      if $(@).hasClass("select-house__building-gp2")
        $(".select-house__info-gp2").addClass("bind-hover")
      if $(@).hasClass("select-house__building-gp3")
        $(".select-house__info-gp3").addClass("bind-hover")

  $("html").on "mouseout", ".select-house__building-hover", ->
    if $("html").hasClass("no-touchevents")
      $(@).removeClass("bind-hover")
      $(".select-house__info-building").removeClass("bind-hover")


  $("html").on "mouseover", ".select-house__info-building", ->
    if $("html").hasClass("no-touchevents")
      $(@).addClass("bind-hover")
      if $(@).hasClass("select-house__info-gp1")
        $(".select-house__building-gp1").addClass("bind-hover")
      if $(@).hasClass("select-house__info-gp2")
        $(".select-house__building-gp2").addClass("bind-hover")
      if $(@).hasClass("select-house__info-gp3")
        $(".select-house__building-gp3").addClass("bind-hover")

  $("html").on "mouseout", ".select-house__info-building", ->
    if $("html").hasClass("no-touchevents")
      $(@).removeClass("bind-hover")
      $(".select-house__building-hover").removeClass("bind-hover")


  $("html").on "mouseover", ".select-house__badge", ->
    if $("html").hasClass("no-touchevents")
      $(@).addClass("bind-hover")

  $("html").on "mouseout", ".select-house__badge", ->
    if $("html").hasClass("no-touchevents")
      $(@).removeClass("bind-hover")

  # mobile exp
  $("html").on "click touchstart", ".select-house__badge-ico", ->
    if $("html").hasClass("touchevents")
      $(".select-house__badge").removeClass("bind-hover")
      $(@).parents(".select-house__badge").addClass("bind-hover")

  $("html").on "click touchstart", ".select-house__badge-title", ->


  $("html").on "click", ".select-house__building-hover", ->
    if $("html").hasClass("touchevents")
      $(".select-house__info-building").removeClass("bind-event")
      if $(@).hasClass("select-house__building-gp1")
        $(".select-house__info-gp1").addClass("bind-event")
      if $(@).hasClass("select-house__building-gp2")
        $(".select-house__info-gp2").addClass("bind-event")
      if $(@).hasClass("select-house__building-gp3")
        $(".select-house__info-gp3").addClass("bind-event")
      if $(@).hasClass("bind-event")
        return
      $(".select-house__building-hover").removeClass("bind-event")
      $(@).addClass("bind-event")
      return false


  $("html").on "click", ".select-house__info-building", ->
    if $("html").hasClass("touchevents")
      $(".select-house__building-hover").removeClass("bind-event")
      if $(@).hasClass("select-house__info-gp1")
        $(".select-house__building-gp1").addClass("bind-event")
      if $(@).hasClass("select-house__info-gp2")
        $(".select-house__building-gp2").addClass("bind-event")
      if $(@).hasClass("select-house__info-gp3")
        $(".select-house__building-gp3").addClass("bind-event")
      if $(@).hasClass("bind-event")
        return
      $(".select-house__info-building").removeClass("bind-event")
      $(@).addClass("bind-event")
      return false