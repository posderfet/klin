jQuery(function() {
  var md;
  if ($(".house-page-wrapper").length >= 1) {
    $("body").height($(".house-page-wrapper").height());
  }
  $(window).resize(function() {
    if ($(".house-page-wrapper").length >= 1) {
      return $("body").height($(".house-page-wrapper").height());
    }
  });
  $("body").off("click", ".top-menu__button");
  $("body").on("click", ".top-menu__button", function() {
    $(".top-menu-wrapper").toggleClass("open-top-menu");
    if ($(".top-menu-wrapper").hasClass("open-top-menu")) {
      $(this).attr("title", "Свернуть меню");
      return setTimeout(function() {
        return $(".top-menu-wrapper").addClass("overflow-visible");
      }, 600);
    } else {
      $(".top-menu-wrapper").removeClass("overflow-visible");
      return $(this).attr("title", "Открыть меню");
    }
  });
  md = new MobileDetect(window.navigator.userAgent);
  if (md.mobile()) {
    $("html").addClass("mobile");
  }
  $("html").on("focusin", ".text-input", function() {
    return $(this).parent(".input-field").find(".input-placeholder").hide();
  });
  return $("html").on("blur", ".text-input", function() {
    if ($(this).val() !== "" && $(this).val() !== "+7(___)___-__-__") {
      return $(this).parent(".input-field").find(".input-placeholder").hide();
    } else {
      return $(this).parent(".input-field").find(".input-placeholder").show();
    }
  });
});
