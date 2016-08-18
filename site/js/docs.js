jQuery(function() {
  $("html").on("mouseover", ".docs-item__link", function() {
    return $(this).parent().addClass("state-hover");
  });
  $("html").on("mouseout", ".docs-item__link", function() {
    return $(this).parent().removeClass("state-hover");
  });
  return $("html").on("click", ".progress-select__dropdown-item", function() {
    var section;
    section = $(this).data("value");
    $(".docs-section").each(function() {
      if (section === "all") {
        $(this).show();
        return;
      }
      $(".docs-section:not([data-section='" + section + "'])").hide();
      return $(".docs-section[data-section='" + section + "']").show();
    });
    return $("body").height($(".house-page-wrapper").height());
  });
});
