jQuery(function() {
  $(".truncate").dotdotdot();
  $(".news-slider").slick({
    infinite: false,
    slidesToShow: 3,
    slidesToScroll: 1,
    variableWidth: true,
    focusOnSelect: false,
    prevArrow: $(".news-slider__prev-button"),
    nextArrow: $(".news-slider__next-button")
  });
  $("html").on("click", ".open-this-news", function() {
    var news_date, news_header, news_image, news_text;
    news_text = $(this).parent().find(".news-slider__full-text").html();
    news_header = $(this).parent().find(".news-slider__item-header").attr("title");
    news_date = $(this).parent().find(".news-slider__item-time").html();
    news_image = $(this).parent().find(".news-slider__item-image").data("src");
    $(".news-popup__image-block").css("background", "url(" + news_image + ")");
    $(".news-popup__content-header").html(news_header);
    $(".news-popup__content-body").html(news_text);
    $(".news-popup__content-time").html(news_date);
    if (news_image === "") {
      $(".news-popup").addClass("without-image");
    } else {
      $(".news-popup").removeClass("without-image");
    }
    $(".news-content").addClass("open-news");
    return $(".popup__scroll-block").perfectScrollbar();
  });
  return $("html").on("click", ".close-news-popup", function() {
    $(".news-content").removeClass("open-news");
    return $(".popup__scroll-block").perfectScrollbar("destroy");
  });
});
