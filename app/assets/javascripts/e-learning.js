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
});
