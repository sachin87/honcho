// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(function() {

  $('#selectAll').click(function() {
    if (this.checked) {
      $(':checkbox').each(function() {
        this.checked = true;
      });
    } else {
      $(':checkbox').each(function() {
        this.checked = false;
      });
    }
  });

  $('form#search').on('click', '.remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.ui.form').hide();
    event.preventDefault();
  });

  $('form#search').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });

})
