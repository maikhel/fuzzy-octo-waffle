(function(course_groups_code) {

  // The global jQuery object is passed as a parameter
  course_groups_code(window.jQuery, window, document);

  }(function($, window, document) {
  // The $ is now locally scoped

  // Listen for the jQuery ready event on the document
   $(function(){

    // The DOM is ready here

     $(function () {
      $('.modal_button_parent').on("click", '#show_modal', function() {
        var modalName = $(this).data('modal');
        showModal($(this)).done(function(data){
          $('#modal_placeholder').html(data);
          $('#' + modalName).modal();
        });
      });
     });

  });


  // The DOM may not be ready

  function showModal(button) {
    var url = button.data('url');

    return $.ajax({
      url: url,
      dataType: 'html',
      type: 'POST'
    });
  }

}));