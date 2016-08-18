jQuery(function() {
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
