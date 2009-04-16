// Common JavaScript code across your application goes here.
$(document).ready(function(){
    $('.vote-up').click(function(){
      if ( $(this).hasClass('voted') == true ) {
        return false
      }
      $(this).addClass('voted')
      $('.vote-down').removeClass('voted');
      var story = $(this).parent().parent();
      $.post('/votes/create', {'vote' : '+1', 'article_id' : 1}, null, 'script')
    });

    $('.vote-down').click(function(){
      if ( $(this).hasClass('voted') == true ) {
        return false
      }
      $(this).addClass('voted')
      $('.vote-up').removeClass('voted');
      var story = $(this).parent().parent();
      $.post('/votes/new', {}, null, 'script')
    });
});