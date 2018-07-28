$(document).on("turbolinks:load", function () {
  $('#new-word').click(function() {
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

  $('form').on('click', '.remove_record', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('div.single_answer').remove();
    event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields').append($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });

  // $('#users_search input').keyup(function(){
  //   $.get($('#users_search').attr('action'), $('#users_search').serialize(), null, 'script');
  //   return false;
  // });

  $('#search').keyup(function() {
    var value = $(this).val();
    $.ajax({
      type: 'get',
      url: '/users',
      data: {search: value},
      dataType: 'text',
      success: function() {
        $('#search').serialize();
      }
    });
  });

  $('.table').on('click', '.destroy', function() {
    var id = $(this).data('id');
    var childTr = $(this);
    if (confirm(I18n.t('you_sure'))) {
      $.ajax({
        url: '/admin/users/' + id,
        method: 'DELETE',
        success: function() {
          childTr.closest('tr').fadeOut();
        }
      })
      return false;
    }
  });

  $('.table').on('click', '.lesson-option', function() {
    var id = $(this).data('id');
    var category_id = $(this).data('category');
    var child = $(this);
    if (confirm(I18n.t('you_sure'))) {
      $.ajax({
        url: '/admin/categories/' + category_id + '/lessons/' + id,
        method: 'DELETE',
        success: function() {
          child.closest('tr').fadeOut();
        }
      })
      return false;
    }
  });

  $('.word-list').on('click', '.destroy-word', function() {
    var id = $(this).data('id');
    var lesson_id = $(this).data('lesson_id');
    var category_id = $(this).data('category_id');
    var child = $(this);
    if (confirm(I18n.t('you_sure'))) {
      $.ajax({
        url: '/admin/categories/' + category_id + '/lessons/' + lesson_id +
          '/words/' + id,
        method: 'DELETE',
        success: function() {
          child.closest('li').fadeOut();
        }
      })
      return false;
    }
  });
});
