jQuery(function() {
  var get_content;
  $(".progreass-head-slider").slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    fade: true,
    focusOnSelect: false,
    prevArrow: $(".progress-head-slide__prev-button"),
    nextArrow: $(".progress-head-slide__next-button")
  });
  $(".progress-slider").slick({
    infinite: true,
    slidesToShow: 6,
    slidesToScroll: 2,
    variableWidth: true,
    focusOnSelect: false,
    centerMode: false,
    prevArrow: $(".progress-slide__prev-button"),
    nextArrow: $(".progress-slide__next-button")
  });
  get_content = function(index) {
    var slide, slide_date, slide_description, slide_header;
    slide = $(".progress-slider__item[data-slick-index='" + index + "']");
    slide_date = slide.find(".progress-slider__date").html();
    slide_header = slide.find(".progress-slider__header").html();
    slide_description = slide.find(".progress-slider__description").html();
    $(".progress-info__date").html(slide_date);
    $(".progress-info__header").html(slide_header);
    return $(".progress-info__description").html(slide_description);
  };
  $("html").on("click", ".progress-slider__item", function() {
    var slide_number;
    slide_number = $(this).data("slick-index");
    $(".progreass-head-slider").slick("slickGoTo", slide_number);
    return get_content(slide_number);
  });
  return $(".progreass-head-slider").on("afterChange", function(event, slick, currentSlide) {
    return get_content(currentSlide);
  });
});
