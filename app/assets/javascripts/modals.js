$(document).ready(function () {

  $('.modal_button_parent').on("click", '#show_modal', function() {
    var modalName = $(this).data('modal');
    showModal($(this)).done(function(data){
      $('#modal_placeholder').html(data);
      $('#' + modalName).modal();
    });
  });

  function showModal(button) {
    var url = button.data('url');

    return $.ajax({
      url: url,
      dataType: 'html',
      type: 'POST'
    });
  }

});