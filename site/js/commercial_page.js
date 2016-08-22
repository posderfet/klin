jQuery(function() {
  var c_change_building, c_get_slider, cr_input, cr_slider;
  c_get_slider = function(building_key) {
    return $(".commercial-carousel[data-building='" + building_key + "']").slick({
      infinite: true,
      slidesToShow: 3,
      slidesToScroll: 1,
      variableWidth: true,
      focusOnSelect: false,
      centerMode: false,
      prevArrow: $(".commercial-carousel__prev-button"),
      nextArrow: $(".commercial-carousel__next-button")
    });
  };
  $(".commercial-input-phone").mask("+7(999)999-99-99");
  $("#commercial-request-form").validate({
    rules: {
      name: {
        required: true
      },
      phone: {
        required: true
      }
    }
  });
  cr_slider = document.getElementById("cr-slider");
  cr_input = document.getElementById("cr-input");
  noUiSlider.create(cr_slider, {
    start: [60],
    range: {
      'min': [30],
      'max': [300]
    },
    step: 1,
    tooltips: wNumb({
      decimals: 0,
      postfix: '<span>м<sup>2</sup></span>'
    }),
    format: wNumb({
      decimals: 0
    })
  });
  cr_slider.noUiSlider.on("update", function(values, handle) {
    return cr_input.value = values[handle];
  });
  cr_input.addEventListener('change', function() {
    cr_slider.noUiSlider.set(this.value);
  });
  $("html").on('mouseenter', ".commercial-legend__state-item", function() {
    var space_state;
    space_state = $(this).attr("data-state");
    return $(".commercial-space-group.space-" + space_state).addClass("state-hover");
  });
  $("html").on('mouseleave', ".commercial-legend__state-item", function() {
    var space_state;
    space_state = $(this).attr("data-state");
    return $(".commercial-space-group.space-" + space_state).removeClass("state-hover");
  });
  $("html").on('mouseenter', "commercial-space-path", function() {
    return $(this).find("polygon").attr("fill", "red");
  });
  $(window).resize(function() {
    return $(".commercial-building-scheme").width($(".commercial-image-map:visible").width());
  });
  $(".commercial-building-scheme-scroll").perfectScrollbar({
    suppressScrollY: true,
    scrollYMarginOffset: 50,
    theme: "yellow-scroll"
  });
  $("html").on("click", ".commercial-popup-button", function() {
    var building_key, crp_input, crp_slider;
    $(".commercial-request-popup").showPop();
    building_key = $(".commercial-popup-button").attr("data-building");
    $(".commercial-popup-input-hidden").val(building_key);
    $(".commercial-input-phone_popup").mask("+7(999)999-99-99");
    $("#commercial-request-form-popup").validate({
      rules: {
        name: {
          required: true
        },
        phone: {
          required: true
        }
      }
    });
    crp_slider = document.getElementById("crp-slider");
    crp_input = document.getElementById("crp-input");
    noUiSlider.create(crp_slider, {
      start: [60],
      range: {
        'min': [30],
        'max': [300]
      },
      step: 1,
      tooltips: wNumb({
        decimals: 0,
        postfix: '<span>м<sup>2</sup></span>'
      }),
      format: wNumb({
        decimals: 0
      })
    });
    crp_slider.noUiSlider.on("update", function(values, handle) {
      return crp_input.value = values[handle];
    });
    return crp_input.addEventListener('change', function() {
      crp_slider.noUiSlider.set(this.value);
    });
  });
  $("body").height($(".house-page-wrapper").height());
  c_change_building = function(building_key) {
    var header;
    header = $(".commecial-header").data("header-" + building_key);
    $(".commecial-header").html(header);
    $(".commercial-legend__svg-building").removeClass("state-active");
    $(".commercial-legend__svg-building[data-building='" + building_key + "']").addClass("state-active");
    $(".comercial-tab__item").removeClass("state-active");
    $(".comercial-tab__item[data-building='" + building_key + "']").addClass("state-active");
    $(".commercial-popup-button").attr("data-building", building_key);
    $(".commercial-input-hidden").val(building_key);
    $(".commercial-building-scheme").each(function() {
      var key;
      key = $(this).data("building");
      if (key === building_key) {
        return $(this).show();
      } else {
        return $(this).hide();
      }
    });
    $(".commercial-building-scheme").width($(".commercial-image-map:visible").width());
    $(".commercial-building-scheme-scroll").perfectScrollbar("update");
    $(".commercial-carousel").each(function() {
      var key;
      key = $(this).data("building");
      if (key === building_key) {
        return $(this).show();
      } else {
        $(this).hide();
        if ($(this).hasClass("slick-initialized")) {
          return $(this).slick("unslick");
        }
      }
    });
    return c_get_slider(building_key);
  };
  c_change_building(1);
  $("html").on("click", ".comercial-tab__item", function() {
    var building_key;
    building_key = $(this).data("building");
    return c_change_building(building_key);
  });
  $("html").on("click", ".commercial-legend__svg-building", function() {
    var building_key;
    building_key = $(this).data("building");
    return c_change_building(building_key);
  });
  return $("body").height($(".house-page-wrapper").height());
});
