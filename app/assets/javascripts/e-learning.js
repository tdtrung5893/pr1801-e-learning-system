$(document).on("turbolinks:load", function () {
  $('#newword').click(function() {
    var count = $('input#correctness:checked').length;
    if (count == 0) {
      alert(I18n.t('e_learning.alert.warning_1'));
      return false;
    }
    else if (count >= 2) {
      alert(I18n.t('e_learning.alert.warning_2'));
      return false;
    }
  });

  var word_correct = $('.completed').data('word-correct');
  $('.completed').css('width', word_correct);
  $('.completed').html(word_correct);

  var word_correct_2 = $('.completed-2').data('word-correct');
  $('.completed-2').css('width', word_correct_2);
  $('.completed-2').html(word_correct_2);

  var word_wrong = $('.wrong').data('word-wrong');
  $('.wrong').css('width', word_wrong);
  $('.wrong').html(word_wrong);

  var word_wrong_2 = $('.wrong-2').data('word-wrong');
  $('.wrong-2').css('width', word_wrong_2);
  $('.wrong-2').html(word_wrong_2);
});
