jQuery ->

  # idex slider init
  swiper = new Swiper(".index-slider-container",
    pagination: ".swiper-pagination"
    paginationClickable: true
    effect: 'fade'
    autoplay: 5000
    speed: 2000)