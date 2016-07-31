var MAX_LEFT, MAX_TOP, MIN_HEIGHT, MIN_WIDTH;

MIN_HEIGHT = null;

MIN_WIDTH = null;

MAX_LEFT = null;

MAX_TOP = null;

window.onresize = function() {
  var aspect_ratio, debug, error, error1, height, img, img_height, img_width, ref, width, window_aspect_ratio, wrapper, wrapper_height, wrapper_width;
  MIN_HEIGHT || (MIN_HEIGHT = parseInt($(".house-page-wrapper").css("min-height").replace("px", "")));
  MIN_WIDTH || (MIN_WIDTH = parseInt($(".house-page-wrapper").css("min-width").replace("px", "")));
  width = $(window).width();
  height = $(window).height();
  if (width < MIN_WIDTH) {
    width = MIN_WIDTH;
  }
  if (height < MIN_HEIGHT) {
    height = MIN_HEIGHT;
  }
  img = $(".house-canvas__background-image");
  try {
    MAX_LEFT || (MAX_LEFT = parseInt($(img).attr("data-max-left")) / 100.0);
  } catch (error) {

  }
  try {
    MAX_TOP || (MAX_TOP = parseInt($(img).attr("data-max-top")) / 100.0);
  } catch (error1) {

  }
  img = img[0];
  img_width = img.naturalWidth;
  img_height = img.naturalHeight;
  aspect_ratio = 1.0 * img_width / img_height;
  window_aspect_ratio = 1.0 * width / height;
  wrapper = $(".house-canvas-wrapper");
  debug = $(".debug");
  if (debug.length > 0) {
    debug.html((($(window).width()) + "x" + ($(window).height())) + "<br/>" + (width + "x" + height + ": " + (window_aspect_ratio.toFixed(2))) + "<br/>" + (img_width + "x" + img_height + ": " + (aspect_ratio.toFixed(2))));
  }
  ref = [0, 0], wrapper_height = ref[0], wrapper_width = ref[1];
  if (window_aspect_ratio < aspect_ratio) {
    wrapper_height = height;
    wrapper_width = height * aspect_ratio;
  } else {
    wrapper_width = width;
    wrapper_height = width / aspect_ratio;
  }
  wrapper.css({
    width: wrapper_width,
    height: wrapper_height
  });
  if (wrapper_width - width > 0) {
    if (MAX_LEFT) {
      wrapper.css({
        left: (Math.max(-MAX_LEFT * width, width - wrapper_width)) + "px"
      });
    } else {
      wrapper.css({
        left: (width - wrapper_width) + "px"
      });
    }
  } else {
    wrapper.css({
      left: 0
    });
  }
  if (wrapper_height - height > 0) {
    if (MAX_TOP) {
      wrapper.css({
        top: (Math.max(-MAX_TOP * height, height - wrapper_height)) + "px"
      });
    } else {
      wrapper.css({
        top: (height - wrapper_height) + "px"
      });
    }
  } else {
    wrapper.css({
      top: 0
    });
  }
  return wrapper.show();
};

jQuery(function() {
  var close_section, img, open_section;
  $(window).resize(onresize);
  img = $(".house-canvas__background-image")[0];
  $(".choice-house-section").css("left", $(".site-header__logo").offset().left);
  $(window).resize(function() {
    return $(".choice-house-section").css("left", $(".site-header__logo").offset().left);
  });
  close_section = function() {
    if ($("#house-canvas").hasClass("open-section")) {
      $("#house-canvas").removeClass("open-section");
      $("#house-canvas .house-section.selected").removeClass("selected");
      $(".choice-house__section-slide").hide();
      return $(".choice-house__apartment").show();
    }
  };
  $("html").click(function(e) {
    if ($(e.target).hasClass("house-canvas__background-image") || $(e.target).hasClass("main-container")) {
      return close_section();
    }
  });
  $("html").on("click", "#house-canvas.open-section .house-section:not(.selected)", function(e) {
    return close_section();
  });
  $("html").on("click", ".slide-prev", function() {
    var ps;
    ps = $("#house-canvas .house-section.selected").prev();
    if (ps.length !== 0) {
      $("#house-canvas .house-section.selected").removeClass("selected");
      return open_section(ps);
    }
  });
  $("html").on("click", ".slide-next", function() {
    var ns;
    ns = $("#house-canvas .house-section.selected").next();
    if (ns.length !== 0) {
      $("#house-canvas .house-section.selected").removeClass("selected");
      return open_section(ns);
    }
  });
  $("html").on("click", "#house-canvas:not(.open-section) .house-section", function(e) {
    return open_section($(this));
  });
  open_section = function(s) {
    var section_no, sslide;
    $("#house-canvas").addClass("open-section");
    $("#house-canvas .house-section").removeClass("selected");
    $(s).addClass("selected");
    section_no = $(s).hasClass("one-section") ? 1 : $(s).hasClass("two-section") ? 2 : $(s).hasClass("three-section") ? 3 : 4;
    sslide = $(".choice-house__section-slide");
    sslide.find(".slide-count__number").html(section_no);
    $(".choice-house__apartment").hide();
    return sslide.show();
  };
  $("html").on("click", ".choice-house__ago", function() {
    $("#house-canvas .house-section.selected").removeClass("selected");
    $("#house-canvas.open-section").removeClass("open-section");
    $(".choice-house__section-slide").hide();
    return $(".choice-house__apartment").show();
  });
  $("body").off("click", ".top-menu__button");
  return $("body").on("click", ".top-menu__button", function() {
    $(".top-menu-wrapper").toggleClass("open-top-menu");
    if ($(".top-menu-wrapper").hasClass("open-top-menu")) {
      $(this).attr("title", "свернуть меню");
      return setTimeout(function() {
        return $(".top-menu-wrapper").addClass("overflow-visible");
      }, 800);
    } else {
      $(".top-menu-wrapper").removeClass("overflow-visible");
      return $(this).attr("title", "открыть меню");
    }
  });
});
