$(function () {
  $(".slider").slick({
    variableWidth: true,
    adaptiveHeight: true,
    centerMode: true,
    focusOnSelect: true,
    arrows: true,
    autoplay: true,
    autoplaySpeed: 2000,
    prevArrow: '<button type="button" class="slick-prev"><i class="fas fa-angle-left"></i></button>',
    nextArrow: '<button type="button" class="slick-next"><i class="fas fa-angle-right"></i></button>',
  });
});
