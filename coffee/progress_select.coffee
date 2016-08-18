jQuery ->
  
  #progress select
  $("html").on "click", ".progress-select__picked", ->
    select = $(@).parents(".progress-select")
    if select.hasClass("state-open")
      select.removeClass("state-open")
    else
      $(".progress-select").removeClass("state-open")
      select.addClass("state-open")

  $("html").on "click", ".progress-select__dropdown-item", ->
    text = $(@).html()
    value = $(@).data("value")
    select = $(@).parents(".progress-select")

    select.find(".progress-select__picked-lable").html(text)
    select.find(".progress-select__input").val(value)
    select.removeClass("state-open")

  $(document).click (e) ->
    if $(e.target).closest(".progress-select").length
      return
    $(".progress-select").removeClass("state-open")