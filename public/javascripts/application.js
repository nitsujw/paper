// Common JavaScript code across your application goes here.
$(document).ready(function(){
    $('.vote-up').click(function(){
	  if (user != true) {
		$.get('/votes', null, null, 'script')
		return false;
	  }
      var story_attr = $(this).parent().attr('id');
      var voted = 0;
      if ( $(this).hasClass('voted') == true ) {
        $(this).removeClass('voted');
        $.post('/votes/delete_vote', {'article_id' : story_attr}, null, 'script')
        return false;
      }
      $(this).addClass('voted');
      if ($('.vote-down').hasClass('voted')) {
        $('.vote-down').removeClass('voted');
        var voted = 1;
      }
      $('.vote-down').removeClass('voted');
      $.post('/votes/create', {'vote' : '+1', 'article_id' : story_attr, 'voted' : voted}, null, 'script')
      return false
    });

    $('.vote-down').click(function(){
      var story_attr = $(this).parent().attr('id');
      var voted = 0;
      if ( $(this).hasClass('voted') == true ) {
        $(this).removeClass('voted');
        $.post('/votes/delete_vote', {'article_id' : story_attr}, null, 'script')
        return false;
      }
      $(this).addClass('voted');
      if ($('.vote-up').hasClass('voted')) {
        $('.vote-up').removeClass('voted');
        var voted = 1;
      }
      $('.vote-up').removeClass('voted');
      $.post('/votes/create', {'vote' : '-1', 'article_id' : story_attr, 'voted' : voted}, null, 'script')
      return false
    });

});