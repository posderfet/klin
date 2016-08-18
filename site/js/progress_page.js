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
  $(".progreass-head-slider").on("afterChange", function(event, slick, currentSlide) {
    return get_content(currentSlide);
  });
  $("html").on("click", ".progress-select__picked", function() {
    var select;
    select = $(this).parents(".progress-select");
    if (select.hasClass("state-open")) {
      return select.removeClass("state-open");
    } else {
      $(".progress-select").removeClass("state-open");
      return select.addClass("state-open");
    }
  });
  $("html").on("click", ".progress-select__dropdown-item", function() {
    var select, text, value;
    text = $(this).html();
    value = $(this).data("value");
    select = $(this).parents(".progress-select");
    select.find(".progress-select__picked-lable").html(text);
    select.find(".progress-select__input").val(value);
    return select.removeClass("state-open");
  });
  return $(document).click(function(e) {
    if ($(e.target).closest(".progress-select").length) {
      return;
    }
    return $(".progress-select").removeClass("state-open");
  });
});
