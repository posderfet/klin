jQuery ->
  
  #progress slider init
  $(".progreass-head-slider").slick
    infinite: true
    slidesToShow: 1
    slidesToScroll: 1
    fade: true
    focusOnSelect: false
    # asNavFor: ".progress-slider"
    prevArrow: $(".progress-head-slide__prev-button")
    nextArrow: $(".progress-head-slide__next-button")

  $(".progress-slider").slick
    infinite: true
    slidesToShow: 6
    slidesToScroll: 2
    variableWidth: true
    focusOnSelect: false
    centerMode: false
    # asNavFor: ".progreass-head-slider"
    prevArrow: $(".progress-slide__prev-button")
    nextArrow: $(".progress-slide__next-button")

  get_content=(index) ->
    slide = $(".progress-slider__item[data-slick-index='"+index+"']")
    slide_date = slide.find(".progress-slider__date").html()
    slide_header = slide.find(".progress-slider__header").html()
    slide_description = slide.find(".progress-slider__description").html()
    $(".progress-info__date").html(slide_date)
    $(".progress-info__header").html(slide_header)
    $(".progress-info__description").html(slide_description)


  $("html").on "click", ".progress-slider__item", ->
    slide_number = $(@).data("slick-index")
    $(".progreass-head-slider").slick("slickGoTo", slide_number)
    get_content(slide_number)

  $(".progreass-head-slider").on "afterChange", (event, slick, currentSlide) ->
    get_content(currentSlide)


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