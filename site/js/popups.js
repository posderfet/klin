var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

jQuery(function() {
  var PopupBackground, PopupController, popup;
  PopupBackground = (function() {
    PopupBackground.prototype.background = function() {
      return $(".popup-background");
    };

    PopupBackground.prototype.body = function() {
      return $("body");
    };

    PopupBackground.prototype.scrollbarWidth = void 0;

    PopupBackground.prototype.wrapper = function() {
      return $(".popup-wrapper");
    };

    PopupBackground.prototype.bg_on = function() {
      var padright;
      this.background().css('opacity', 0).show().fadeTo('normal', 0.5);
      padright = 0;
      if (this.body().height() > $(window).height()) {
        padright = this.scrollbarWidth;
      }
      this.body().css("padding-right", padright).css("overflow", "hidden");
      if ($(".house-page-wrapper").length >= 1) {
        $(".house-page-wrapper").css("padding-right", padright);
      }
      return this.wrapper().show();
    };

    PopupBackground.prototype.bg_off = function() {
      this.background().css('opacity', 0).hide();
      this.body().css("padding-right", 0).css("overflow", "auto");
      if ($(".house-page-wrapper").length >= 1) {
        $(".house-page-wrapper").css("padding-right", 0);
      }
      return this.wrapper().hide();
    };

    PopupBackground.prototype.is_bg_on = function() {
      return this.background().is(':visible');
    };

    PopupBackground.prototype.calc_sbw = function() {
      var div;
      div = document.createElement("div");
      div.style.overflow = "scroll";
      div.style.visibility = "hidden";
      div.style.position = 'absolute';
      div.style.width = '100px';
      div.style.height = '100px';
      document.body.appendChild(div);
      this.scrollbarWidth = div.offsetWidth - div.clientWidth;
      return document.body.removeChild(div);
    };

    function PopupBackground() {
      this.calc_sbw();
    }

    return PopupBackground;

  })();
  PopupController = (function(superClass) {
    extend(PopupController, superClass);

    PopupController.prototype.layer = function() {
      return $(".popup-layer");
    };

    PopupController.prototype.stack = function() {
      return $(".popup-stack");
    };

    function PopupController() {
      PopupController.__super__.constructor.apply(this, arguments);
      this.layer().css('top', "12%");
    }

    PopupController.prototype.stack_push = function() {
      var child, children, i, len, results;
      children = this.layer().children();
      results = [];
      for (i = 0, len = children.length; i < len; i++) {
        child = children[i];
        results.push($(child).detach().appendTo(this.stack()));
      }
      return results;
    };

    PopupController.prototype.stack_pop = function() {
      var child, children, i, results;
      children = this.stack().children();
      results = [];
      for (i = children.length - 1; i >= 0; i += -1) {
        child = children[i];
        this.layer().width($(child).innerWidth());
        $(child).detach().appendTo(this.layer());
        this.bg_on();
        break;
      }
      return results;
    };

    PopupController.prototype.pushPop = function(orphan_box) {
      this.stack_push();
      this.layer().append(orphan_box);
      return this.layer().width(orphan_box.innerWidth());
    };

    PopupController.prototype.hidePop = function(box) {
      var onclose, replace;
      replace = $(box).attr("data-replace");
      onclose = $(box).attr("data-onclose");
      if (onclose) {
        eval(onclose);
      }
      if (replace) {
        $(replace, ".static_popups").replaceWith(box);
      } else {
        $(box).remove();
      }
      this.bg_off();
      return this.stack_pop();
    };

    PopupController.prototype.showPop = function(box) {
      return this.bg_on();
    };

    PopupController.prototype.escPop = function() {
      return this.layer().children().hidePop();
    };

    return PopupController;

  })(PopupBackground);
  popup = new PopupController;
  $.fn.pushPop = function() {
    popup.pushPop($(this));
    return popup.showPop();
  };
  $.fn.showPop = function() {
    var node;
    if ($(this).parents('.static_popups').length > 0) {
      node = $(this).clone();
      popup.pushPop(node);
      return popup.showPop();
    } else {
      return popup.showPop($(this));
    }
  };
  $.fn.hidePop = function() {
    return popup.hidePop($(this));
  };
  $.fn.escPop = function() {
    if ($(".popup-layer").find(".noclose").length > 0) {
      return;
    }
    return popup.escPop();
  };
  $.fn.hasScrollBar = function() {
    return this.get(0).scrollHeight > this.height();
  };
  $("html").on("submit", ".popup_form", function() {
    var data, success, type, url;
    url = $(this).attr('action');
    type = $(this).attr('method');
    data = $(this).serialize();
    success = function(html) {
      var node;
      node = $(html);
      popup.pushPop(node);
      return node.showPop();
    };
    $.ajax({
      type: type,
      data: data,
      url: url,
      success: success
    });
    return false;
  });
  $("html").on("click", ".popup_link", function() {
    var url;
    url = $(this).attr('data-url');
    return $.get(url, null, function(html) {
      var node;
      node = $(html);
      popup.pushPop(node);
      return node.showPop();
    });
  });
  $("html").on('click', ".popup-wrapper .close-this", function() {
    $(this).parents(".popup-window").hidePop();
    $(this).parents(".popup-window").addClass("qwerty");
    return false;
  });
  $("html").on('click', ".popup-wrapper", function(e) {
    var chld;
    if (e.target.className === 'popup-wrapper') {
      if ($(".popup-layer").find(".noclose").length > 0) {
        return;
      }
      return chld = $(".popup-layer").children().hidePop();
    }
  });
  $(window).off('keydown', null);
  $(window).on('keydown', null, function(e) {
    if (e.which === 27) {
      return $(window).escPop();
    }
  });
  $("html").on('click', ".house-section.selected .house-floor", function() {
    var building, floor, popup_token, section;
    floor = $(this).data("building-floor");
    section = $(this).closest(".house-section").data("building-section");
    building = $(this).closest(".building-wrapper").data("building");
    popup_token = "gp" + building + "_s" + section;
    if ($(this).hasClass("bind-hover")) {
      $('[data-popup-token="' + popup_token + '"]').showPop();
    }
    $(".house-floor").removeClass("bind-hover");
    if ($("html").hasClass("no-touchevents")) {
      $('[data-popup-token="' + popup_token + '"]').showPop();
    }
    if ($("html").hasClass("touchevents")) {
      return $(this).addClass("bind-hover");
    }
  });
  $("html").on('click', ".map-floor__apartment", function() {
    var apartment_info, apartment_token, area, price, room;
    apartment_token = $(this).data("apartment-token");
    room = $(this).data("apartment-room");
    area = $(this).data("apartment-area");
    price = $(this).data("apartment-price");
    apartment_info = $(".popup-apartment__info");
    if ($(this).hasClass("sold")) {

    } else {
      $(".img-apartment-map").attr("src", "images/" + apartment_token + ".png");
      apartment_info.find(".room-count").html(room);
      apartment_info.find(".area-count").html(area);
      apartment_info.find(".price-count").html(price);
      return $(".popup-apartment").showPop();
    }
  });
  $("html").on('mousemove', ".map-floor__apartment", function(e) {
    var area, client_x, client_y, color, price, room, tooltip;
    tooltip = $(".floor-map__tooltip");
    room = $(this).data("apartment-room");
    area = $(this).data("apartment-area");
    price = $(this).data("apartment-price");
    color = $(this).css("fill");
    client_x = e.clientX;
    client_y = e.clientY;
    if ($(this).hasClass("sold")) {
      tooltip.addClass("sold");
    } else {
      tooltip.find(".tooltip-room__count").html(room);
      tooltip.find(".tooltip-area__count").html(area);
      tooltip.find(".tooltip-price__count").html(price);
      tooltip.removeClass("sold");
    }
    tooltip.css("top", client_y - 50).css("left", client_x - 15).show();
    return console.log(color);
  });
  $("html").on('mouseout', ".map-floor__apartment", function() {
    return $(".floor-map__tooltip").hide();
  });
  $("html").on('click', ".map-floor__apartment", function() {
    $(".floor-map__tooltip").hide();
    return console.log("123");
  });
  $("html").on('mouseenter', ".floor-map__legend-item", function() {
    var apartment_type;
    apartment_type = $(this).attr("data-legend-apartment");
    return $(".map-floor__apartment-" + apartment_type).addClass("map-show-apartment");
  });
  return $("html").on('mouseleave', ".floor-map__legend-item", function() {
    var apartment_type;
    apartment_type = $(this).attr("data-legend-apartment");
    return $(".map-floor__apartment-" + apartment_type).removeClass("map-show-apartment");
  });
});
