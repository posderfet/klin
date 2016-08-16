jQuery(function() {
  $("html").on("mouseover", ".select-house__building-hover", function() {
    if ($("html").hasClass("no-touchevents")) {
      if ($(this).hasClass("select-house__building-gp1")) {
        $(".select-house__info-gp1").addClass("bind-hover");
      }
      if ($(this).hasClass("select-house__building-gp2")) {
        $(".select-house__info-gp2").addClass("bind-hover");
      }
      if ($(this).hasClass("select-house__building-gp3")) {
        return $(".select-house__info-gp3").addClass("bind-hover");
      }
    }
  });
  $("html").on("mouseout", ".select-house__building-hover", function() {
    if ($("html").hasClass("no-touchevents")) {
      $(this).removeClass("bind-hover");
      return $(".select-house__info-building").removeClass("bind-hover");
    }
  });
  $("html").on("mouseover", ".select-house__info-building", function() {
    if ($("html").hasClass("no-touchevents")) {
      $(this).addClass("bind-hover");
      if ($(this).hasClass("select-house__info-gp1")) {
        $(".select-house__building-gp1").addClass("bind-hover");
      }
      if ($(this).hasClass("select-house__info-gp2")) {
        $(".select-house__building-gp2").addClass("bind-hover");
      }
      if ($(this).hasClass("select-house__info-gp3")) {
        return $(".select-house__building-gp3").addClass("bind-hover");
      }
    }
  });
  $("html").on("mouseout", ".select-house__info-building", function() {
    if ($("html").hasClass("no-touchevents")) {
      $(this).removeClass("bind-hover");
      return $(".select-house__building-hover").removeClass("bind-hover");
    }
  });
  $("html").on("mouseover", ".select-house__badge", function() {
    if ($("html").hasClass("no-touchevents")) {
      return $(this).addClass("bind-hover");
    }
  });
  $("html").on("mouseout", ".select-house__badge", function() {
    if ($("html").hasClass("no-touchevents")) {
      return $(this).removeClass("bind-hover");
    }
  });
  $("html").on("click touchstart", ".select-house__badge-ico", function() {
    if ($("html").hasClass("touchevents")) {
      $(".select-house__badge").removeClass("bind-hover");
      return $(this).parents(".select-house__badge").addClass("bind-hover");
    }
  });
  $("html").on("click touchstart", ".select-house__badge-title", function() {});
  $("html").on("click", ".select-house__building-hover", function() {
    if ($("html").hasClass("touchevents")) {
      $(".select-house__info-building").removeClass("bind-event");
      if ($(this).hasClass("select-house__building-gp1")) {
        $(".select-house__info-gp1").addClass("bind-event");
      }
      if ($(this).hasClass("select-house__building-gp2")) {
        $(".select-house__info-gp2").addClass("bind-event");
      }
      if ($(this).hasClass("select-house__building-gp3")) {
        $(".select-house__info-gp3").addClass("bind-event");
      }
      if ($(this).hasClass("bind-event")) {
        return;
      }
      $(".select-house__building-hover").removeClass("bind-event");
      $(this).addClass("bind-event");
      return false;
    }
  });
  return $("html").on("click", ".select-house__info-building", function() {
    if ($("html").hasClass("touchevents")) {
      $(".select-house__building-hover").removeClass("bind-event");
      if ($(this).hasClass("select-house__info-gp1")) {
        $(".select-house__building-gp1").addClass("bind-event");
      }
      if ($(this).hasClass("select-house__info-gp2")) {
        $(".select-house__building-gp2").addClass("bind-event");
      }
      if ($(this).hasClass("select-house__info-gp3")) {
        $(".select-house__building-gp3").addClass("bind-event");
      }
      if ($(this).hasClass("bind-event")) {
        return;
      }
      $(".select-house__info-building").removeClass("bind-event");
      $(this).addClass("bind-event");
      return false;
    }
  });
});
