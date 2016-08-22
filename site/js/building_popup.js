jQuery(function() {
  var FLOOR, MAX_FLOOR, average_payment, deposit_calculation, floor_slider_check, payment_format, payment_install;
  MAX_FLOOR = null;
  FLOOR = null;
  $("html").on('click', ".house-section.selected .house-floor", function() {
    var building, floor, popup_token, section;
    MAX_FLOOR = $(this).parent().data("max-floor");
    floor = $(this).data("building-floor");
    section = $(this).closest(".house-section").data("building-section");
    building = $(this).closest(".building-wrapper").data("building");
    popup_token = "gp" + building + "_s" + section;
    if ($(this).hasClass("bind-hover")) {
      $('[data-popup-token="' + popup_token + '"]').showPop();
      $('[data-popup-token="' + popup_token + '"]').attr("data-floor-section", floor).find(".popup-floor-slider__count-number").html(floor);
      floor_slider_check();
    }
    $(".house-floor").removeClass("bind-hover");
    if ($("html").hasClass("no-touchevents")) {
      $('[data-popup-token="' + popup_token + '"]').showPop();
      $('[data-popup-token="' + popup_token + '"]').attr("data-floor-section", floor).find(".popup-floor-slider__count-number").html(floor);
      floor_slider_check();
    }
    if ($("html").hasClass("touchevents")) {
      return $(this).addClass("bind-hover");
    }
  });
  $("html").on('click', ".map-floor__apartment", function() {
    var apartment_info, apartment_token, area, building, floor, price, room;
    apartment_token = $(this).data("apartment-token");
    building = apartment_token.slice(0, 2);
    floor = $(this).parents(".popup-floor").attr("data-floor-section");
    room = $(this).data("apartment-room");
    area = $(this).data("apartment-area");
    price = $(this).data("apartment-price");
    apartment_info = $(".popup-apartment__info");
    if ($(this).hasClass("sold")) {

    } else {
      $(".popup-apartment").showPop();
      $(".img-apartment-map").attr("src", "images/" + apartment_token + ".png");
      apartment_info.find(".room-count").html(room);
      apartment_info.find(".area-count").html(area);
      apartment_info.find(".price-count").html(price);
      $(".popup-apartment").attr("data-floor-apartment", floor).find(".popup-floor-slider__count-number").html(floor);
      floor_slider_check();
      if (building !== "b3") {
        $("#open-repair-option").hide();
        return $(".popup-apartment__menu").css("height", "25.104rem");
      }
    }
  });
  floor_slider_check = function() {
    var count, slider;
    slider = $(".popup-floor-slider");
    count = parseInt(slider.find(".popup-floor-slider__count-number").html(), 10);
    if (count === MAX_FLOOR) {
      slider.find(".popup-floor-slider__up").addClass("floor-slider-disable");
      slider.find(".popup-floor-slider__down").removeClass("floor-slider-disable");
    }
    if (count === 2) {
      slider.find(".popup-floor-slider__down").addClass("floor-slider-disable");
      slider.find(".popup-floor-slider__up").removeClass("floor-slider-disable");
    }
    if (FLOOR !== null) {
      return slider.find(".popup-floor-slider__count-number").html(FLOOR);
    }
  };
  $("html").on("click", ".popup-floor-slider__up", function() {
    var floor, floor_el, parent_popup;
    $(".popup-floor-slider__down").removeClass("floor-slider-disable");
    floor_el = $(this).parent().find(".popup-floor-slider__count-number");
    floor = parseInt(floor_el.html(), 10);
    parent_popup = $(this).parents(".popup-window");
    if (floor === MAX_FLOOR) {

    } else {
      floor_el.html(floor + 1);
      FLOOR = floor + 1;
      $(this).parents(".popup-apartment").attr("data-floor-apartment", FLOOR);
      $(this).parents(".popup-floor").attr("data-floor-section", FLOOR);
      if (FLOOR === MAX_FLOOR) {
        $(this).addClass("floor-slider-disable");
      }
      if (parent_popup.hasClass("popup-apartment")) {
        floor_slider_check();
        return parent_popup.hidePop();
      }
    }
  });
  $("html").on("click", ".popup-floor-slider__down", function() {
    var floor, floor_el, parent_popup;
    $(".popup-floor-slider__up").removeClass("floor-slider-disable");
    floor_el = $(this).parent().find(".popup-floor-slider__count-number");
    floor = parseInt(floor_el.html(), 10);
    parent_popup = $(this).parents(".popup-window");
    if (floor === 2) {

    } else {
      floor_el.html(floor - 1);
      FLOOR = floor - 1;
      $(this).parents(".popup-apartment").attr("data-floor-apartment", FLOOR);
      $(this).parents(".popup-floor").attr("data-floor-section", FLOOR);
      if (FLOOR === 2) {
        $(this).addClass("floor-slider-disable");
      }
      if (parent_popup.hasClass("popup-apartment")) {
        floor_slider_check();
        return parent_popup.hidePop();
      }
    }
  });
  $("html").on('mousemove', ".map-floor__apartment", function(e) {
    var area, client_x, client_y, price, room, tooltip;
    tooltip = $(".floor-map__tooltip");
    room = $(this).data("apartment-room");
    area = $(this).data("apartment-area");
    price = $(this).data("apartment-price");
    client_x = e.clientX;
    client_y = e.clientY;
    if ($(this).hasClass("sold")) {
      tooltip.addClass("sold");
    } else {
      tooltip.find(".tooltip-room__count").html(room);
      tooltip.find(".tooltip-area__count").html(area);
      tooltip.find(".tooltip-price__count").html(price);
      if (room === 1) {
        tooltip.find(".tooltip-room__lable").html("комната");
      } else {
        tooltip.find(".tooltip-room__lable").html("комнаты");
      }
      tooltip.removeClass("sold");
    }
    return tooltip.css("top", client_y - 50).css("left", client_x - 15).show();
  });
  $("html").on('mouseout', ".map-floor__apartment", function() {
    return $(".floor-map__tooltip").hide();
  });
  $("html").on('click', ".map-floor__apartment", function() {
    return $(".floor-map__tooltip").hide();
  });
  $("html").on('mouseenter', ".floor-map__legend-item", function() {
    var apartment_type;
    apartment_type = $(this).attr("data-legend-apartment");
    return $(".map-floor__apartment-" + apartment_type).addClass("map-show-apartment");
  });
  $("html").on('mouseleave', ".floor-map__legend-item", function() {
    var apartment_type;
    apartment_type = $(this).attr("data-legend-apartment");
    return $(".map-floor__apartment-" + apartment_type).removeClass("map-show-apartment");
  });
  $("html").on('click', "#choice-house-button", function() {
    var ca_area_input_low, ca_area_input_up, ca_area_slider, ca_floor_input_low, ca_floor_input_up, ca_floor_slider, ca_price_input_low, ca_price_input_up, ca_price_slider, ca_room_input_low, ca_room_input_up, ca_room_slider;
    $(".popup-choice-apartment").showPop();
    $(".popup__scroll-block").perfectScrollbar();
    ca_room_slider = document.getElementById("ca-room-slider");
    ca_floor_slider = document.getElementById("ca-floor-slider");
    ca_area_slider = document.getElementById("ca-area-slider");
    ca_price_slider = document.getElementById("ca-price-slider");
    ca_room_input_low = document.getElementById("ca-input-room-low");
    ca_room_input_up = document.getElementById("ca-input-room-up");
    ca_floor_input_low = document.getElementById("ca-input-floor-low");
    ca_floor_input_up = document.getElementById("ca-input-floor-up");
    ca_area_input_low = document.getElementById("ca-input-area-low");
    ca_area_input_up = document.getElementById("ca-input-area-up");
    ca_price_input_low = document.getElementById("ca-input-price-low");
    ca_price_input_up = document.getElementById("ca-input-price-up");
    noUiSlider.create(ca_room_slider, {
      start: [1, 4],
      range: {
        'min': [1],
        'max': [4]
      },
      step: 1,
      margin: 0,
      connect: true,
      behaviour: 'tap-drag',
      format: wNumb({
        decimals: 0
      })
    });
    ca_room_slider.noUiSlider.on("update", function(values, handle) {
      return (handle ? ca_room_input_up : ca_room_input_low).value = values[handle];
    });
    ca_room_input_low.addEventListener('change', function() {
      return ca_room_slider.noUiSlider.set([this.value, null]);
    });
    ca_room_input_up.addEventListener('change', function() {
      return ca_room_slider.noUiSlider.set([null, this.value]);
    });
    noUiSlider.create(ca_floor_slider, {
      start: [2, 15],
      range: {
        'min': [2],
        'max': [15]
      },
      step: 1,
      margin: 1,
      connect: true,
      behaviour: 'tap-drag',
      format: wNumb({
        decimals: 0
      })
    });
    ca_floor_slider.noUiSlider.on("update", function(values, handle) {
      return (handle ? ca_floor_input_up : ca_floor_input_low).value = values[handle];
    });
    ca_floor_input_low.addEventListener('change', function() {
      return ca_floor_slider.noUiSlider.set([this.value, null]);
    });
    ca_floor_input_up.addEventListener('change', function() {
      return ca_floor_slider.noUiSlider.set([null, this.value]);
    });
    noUiSlider.create(ca_area_slider, {
      start: [29.10, 79.90],
      range: {
        'min': [29.10],
        'max': [79.90]
      },
      step: 0.05,
      margin: 5,
      connect: true,
      behaviour: 'tap-drag',
      format: wNumb({
        decimals: 2,
        mark: ','
      })
    });
    ca_area_slider.noUiSlider.on("update", function(values, handle) {
      return (handle ? ca_area_input_up : ca_area_input_low).value = values[handle];
    });
    ca_area_input_low.addEventListener('change', function() {
      return ca_area_slider.noUiSlider.set([this.value, null]);
    });
    ca_area_input_up.addEventListener('change', function() {
      return ca_area_slider.noUiSlider.set([null, this.value]);
    });
    noUiSlider.create(ca_price_slider, {
      start: [1300000, 5000000],
      range: {
        'min': [1300000],
        'max': [5000000]
      },
      step: 1000,
      margin: 100000,
      connect: true,
      behaviour: 'tap-drag',
      format: wNumb({
        decimals: 0,
        thousand: ' '
      })
    });
    ca_price_slider.noUiSlider.on("update", function(values, handle) {
      return (handle ? ca_price_input_up : ca_price_input_low).value = values[handle];
    });
    ca_price_input_low.addEventListener('change', function() {
      return ca_price_slider.noUiSlider.set([this.value, null]);
    });
    return ca_price_input_up.addEventListener('change', function() {
      return ca_price_slider.noUiSlider.set([null, this.value]);
    });
  });
  payment_format = wNumb({
    decimals: 0,
    thousand: ' '
  });
  deposit_calculation = function() {
    var dc_deposit, dc_price, dc_total;
    dc_price = parseInt($("#hc-input-price").val().replace(/ /gi, ""), 10);
    dc_deposit = parseInt($("#hc-input-deposit").val(), 10);
    dc_total = dc_price * dc_deposit / 100;
    $("#hypothec_calc_deposit_total").html(dc_total);
    return dc_total;
  };
  average_payment = function(rate) {
    var month_payment, month_rate, pc_deposit, pc_period, pc_price, pc_price_true;
    pc_price = parseInt($("#hc-input-price").val().replace(/ /gi, ""), 10);
    pc_deposit = deposit_calculation();
    pc_price_true = pc_price - pc_deposit;
    pc_period = parseInt($("#hc-input-period").val().replace(/ /gi, ""), 10);
    month_rate = rate / 100 / 12;
    month_payment = pc_price_true * (month_rate / (1 - Math.pow(1 + month_rate, -pc_period)));
    return month_payment;
  };
  payment_install = function() {
    var bankm_bank, bankm_payment, bankm_rate, dkb_bank, dkb_payment, dkb_rate, mib_bank, mib_payment, mib_rate, rsb_bank, rsb_payment, rsb_rate, sber_bank, sber_payment, sber_rate, vtb_bank, vtb_payment, vtb_rate;
    dkb_rate = 11.5;
    vtb_rate = 11.9;
    sber_rate = 11.9;
    bankm_rate = 11.9;
    mib_rate = 11.99;
    rsb_rate = 11.9;
    dkb_bank = $(".dkb-bank-item");
    vtb_bank = $(".vtb-bank-item");
    sber_bank = $(".sber-bank-item");
    bankm_bank = $(".bankm-bank-item");
    mib_bank = $(".mib-bank-item");
    rsb_bank = $(".rsb-bank-item");
    dkb_payment = payment_format.to(average_payment(dkb_rate));
    vtb_payment = payment_format.to(average_payment(vtb_rate));
    sber_payment = payment_format.to(average_payment(sber_rate));
    bankm_payment = payment_format.to(average_payment(bankm_rate));
    mib_payment = payment_format.to(average_payment(mib_rate));
    rsb_payment = payment_format.to(average_payment(rsb_rate));
    dkb_bank.find(".hypothec-calc__list-body-payment").html(dkb_payment);
    vtb_bank.find(".hypothec-calc__list-body-payment").html(vtb_payment);
    sber_bank.find(".hypothec-calc__list-body-payment").html(sber_payment);
    bankm_bank.find(".hypothec-calc__list-body-payment").html(bankm_payment);
    mib_bank.find(".hypothec-calc__list-body-payment").html(mib_payment);
    return rsb_bank.find(".hypothec-calc__list-body-payment").html(rsb_payment);
  };
  $("html").on('click', "#open_hypotec_calc", function() {
    var hc_deposit_input, hc_deposit_slider, hc_period_input, hc_period_slider, hc_price_input, hc_price_slider;
    $(".popup-hypothec-calc").showPop();
    $("#hypothec_calc_form").validate({
      rules: {
        email: {
          required: true,
          email: true
        }
      }
    });
    hc_price_slider = document.getElementById("hc-price-slider");
    hc_deposit_slider = document.getElementById("hc-deposit-slider");
    hc_period_slider = document.getElementById("hc-period-slider");
    hc_price_input = document.getElementById("hc-input-price");
    hc_deposit_input = document.getElementById("hc-input-deposit");
    hc_period_input = document.getElementById("hc-input-period");
    noUiSlider.create(hc_price_slider, {
      start: [3000000],
      range: {
        'min': [1300000],
        'max': [5005000]
      },
      step: 1000,
      connect: 'lower',
      format: wNumb({
        decimals: 0,
        thousand: ' '
      })
    });
    hc_price_slider.noUiSlider.on("update", function(values, handle) {
      hc_price_input.value = values[handle];
      deposit_calculation();
      return payment_install();
    });
    hc_price_input.addEventListener('change', function() {
      hc_price_slider.noUiSlider.set(this.value);
      deposit_calculation();
      payment_install();
    });
    noUiSlider.create(hc_deposit_slider, {
      start: [40],
      range: {
        'min': [20],
        'max': [99]
      },
      step: 1,
      connect: 'lower',
      format: wNumb({
        decimals: 0,
        postfix: '%'
      })
    });
    hc_deposit_slider.noUiSlider.on("update", function(values, handle) {
      hc_deposit_input.value = values[handle];
      deposit_calculation();
      return payment_install();
    });
    hc_deposit_input.addEventListener('change', function() {
      hc_deposit_slider.noUiSlider.set(this.value);
      deposit_calculation();
      payment_install();
    });
    noUiSlider.create(hc_period_slider, {
      start: [24],
      range: {
        'min': [12],
        'max': [360]
      },
      step: 1,
      connect: 'lower',
      format: wNumb({
        decimals: 0
      })
    });
    hc_period_slider.noUiSlider.on("update", function(values, handle) {
      hc_period_input.value = values[handle];
      return payment_install();
    });
    hc_period_input.addEventListener('change', function() {
      hc_period_slider.noUiSlider.set(this.value);
      payment_install();
    });
    deposit_calculation();
    return payment_install();
  });
  $("html").on('click', ".repair-option__photo-prev", function() {
    var image_src;
    image_src = $(this).attr("src").replace("prev_", "");
    $(".repair-option__big-photo-block").css("background", "url(" + image_src + ")");
    return $(".repair-option__big-photo").attr("src", image_src);
  });
  $("html").on('click', "#open-repair-option", function() {
    var image_src;
    $(".popup-repair-option").showPop();
    image_src = $(".repair-option__photo-item.first-open").find(".repair-option__photo-prev").attr("src").replace("prev_", "");
    $(".repair-option__big-photo-block").css("background", "url(" + image_src + ")");
    return $(".repair-option__big-photo").attr("src", image_src);
  });
  $("html").on('click', "#open_track_price", function() {
    $(".popup-track-price").showPop();
    return $("#track-price-form").validate({
      rules: {
        price: {
          required: true,
          digits: true
        },
        email: {
          required: true,
          email: true
        }
      }
    });
  });
  $("html").on('click', "#open_get_planing", function() {
    $(".popup-get-planing").showPop();
    $(".get-planing__input-phone").mask("+7(999)999-99-99");
    return $("#get-planing-form").validate({
      rules: {
        email: {
          required: true,
          email: true
        }
      }
    });
  });
  return $("html").on('click', "#open_reserv_request", function() {
    $(".popup-reserv-request").showPop();
    $(".reserv-request__input-phone").mask("+7(999)999-99-99");
    return $("#reserv-request-form").validate({
      rules: {
        email: {
          required: true,
          email: true
        },
        phone: {
          required: true
        }
      }
    });
  });
});
