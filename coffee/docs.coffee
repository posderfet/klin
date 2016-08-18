jQuery ->

  # link hover
  $("html").on "mouseover", ".docs-item__link", ->
    $(@).parent().addClass("state-hover")

  $("html").on "mouseout", ".docs-item__link", ->
    $(@).parent().removeClass("state-hover")


  # select
  $("html").on "click", ".progress-select__dropdown-item", ->
    section = $(@).data("value")
    $(".docs-section").each ->
      if section == "all"
        $(@).show()
        return
      $(".docs-section:not([data-section='"+section+"'])").hide()
      $(".docs-section[data-section='"+section+"']").show()
    $("body").height( $(".house-page-wrapper").height() )
    