$(document).ready(function() {
  var copyTextareaBtn = document.querySelector('.js-copy-btn');

  if (copyTextareaBtn != null){
    copyTextareaBtn.addEventListener('click', function(event) {
      $('input.js-copy-text').data('toggle', 'tooltip');
      var copyTextarea = document.querySelector('.js-copy-text');
      copyTextarea.select();

      try {
        var successful = document.execCommand('copy');
        if(successful){
          alert("Text copied!");
        }
        var msg = successful ? 'successful' : 'unsuccessful';
        console.log('Copying text command was ' + msg);
      } catch (err) {
        console.log('Oops, unable to copy');
      }
    });
  }

});