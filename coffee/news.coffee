jQuery ->

  # ytqs truncate header
  $(".truncate").dotdotdot()

  # news slider init
  # swiper = new Swiper('.news-slider',
  #   nextButton: '.news-slider__next-button'
  #   prevButton: '.news-slider__prev-button'
  #   slidesPerView: 3
  #   freeMode: true
  #   offsetPxAfter: 50

  #   speed: 800)

  $(".news-slider").slick
    infinite: false
    slidesToShow: 3
    slidesToScroll: 1
    variableWidth: true
    focusOnSelect: false
    prevArrow: $(".news-slider__prev-button")
    nextArrow: $(".news-slider__next-button")

  # news popup
  $("html").on "click", ".open-this-news", ->
    news_text = $(@).parent().find(".news-slider__full-text").html()
    news_header = $(@).parent().find(".news-slider__item-header").attr("title")
    news_date = $(@).parent().find(".news-slider__item-time").html()
    news_image = $(@).parent().find(".news-slider__item-image").data("src")

    $(".news-popup__image-block").css("background", "url("+news_image+")")
    $(".news-popup__content-header").html(news_header)
    $(".news-popup__content-body").html(news_text)
    $(".news-popup__content-time").html(news_date)

    if news_image == ""
      $(".news-popup").addClass("without-image")
    else
      $(".news-popup").removeClass("without-image")

    $(".news-content").addClass("open-news")

    $(".popup__scroll-block").perfectScrollbar()

  $("html").on "click", ".close-news-popup", ->
    $(".news-content").removeClass("open-news")
    $(".popup__scroll-block").perfectScrollbar("destroy")



