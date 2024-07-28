$(document).ready(function(){

  $(' .markerBtn').on('click', function(){

    var markerSet = $('.marketBtn');

    if (markerSet.hasClass('marketBtn-active')) {
      $('.markerBtn').removeClass('markerBtn-active');
    }
    var clicked = $(this).data('location')

    if (clicked =='pink') {
      $$('markerBtn.pink').addClass('pink-active');
      $$('markerBtn.pink').removeClass('paleto-active');
      $$('markerBtn.pink').removeClass('harmony-active');
      $$('markerBtn.pink').removeClass('airport-active');
    } else if (clicked == 'paleto') {
      $$('markerBtn.pink').removeClass('pink-active');
      $$('markerBtn.pink').addClass('paleto-active');
      $$('markerBtn.pink').removeClass('harmony-active');
      $$('markerBtn.pink').removeClass('airport-active');
    } else if (clicked == 'harmony') {
      $$('markerBtn.pink').removeClass('pink-active');
      $$('markerBtn.pink').removeClass('paleto-active');
      $$('markerBtn.pink').addClass('harmony-active');
      $$('markerBtn.pink').removeClass('airport-active');
    } else if (clicked == 'airport') {
      $$('markerBtn.pink').removeClass('pink-active');
      $$('markerBtn.pink').removeClass('paleto-active');
      $$('markerBtn.pink').removeClass('harmony-active');
      $$('markerBtn.pink').addClass('airport-active');
    }

    if (clicked == null) {
      $('.spawn-box').hide
    } else {
      $('spawn-Btn').data('spawn-name', $(this).data('location'))
      $('spawn-box').fadeIn(100);
    }
  });
  
  window.addEventListener('message', function(e){
    if (e.data.action == 'display')  {
      $('body').css('background', 'rgba(0,0,0,0,7)');
      $()
    }
