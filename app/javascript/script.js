$(document).ready(function() {
  // スクロールトップボタンをクリックしたときの処理
  $('.scroll-top-btn').click(function(e) {
    e.preventDefault();
    $('html, body').animate({ scrollTop: 0 }, 'slow'); // ページトップへスクロール
  });

  // ページが20ピクセルまでスクロールされたらボタンを表示
  $(window).scroll(function() {
    if ($(this).scrollTop() > 20) {
      $('.scroll-top-btn').fadeIn();
    } else {
      $('.scroll-top-btn').fadeOut();
    }
  });
});