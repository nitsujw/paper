// Common JavaScript code across your application goes here.
$(document).ready(function(){
    /* man this code really blows.  but it works, damnit, and i don't feel like refactoring */
    $('.arrow.up').click(function(){
      if (user == 2) {
        window.location.replace("http://localhost:4000/login");
        return false;
      }
      var story_attr = $(this).parent().attr('id');
      var other_arrow = 0;
      var score = 0;
      if ( $(this).hasClass('voted') == true ) {
        $(this).removeClass('voted');
        score = -1;
        $.post('/votes/delete_vote', {'article_id' : story_attr, 'score' : score}, null, 'script');
        return false;
      }
      $(this).addClass('voted');
      if ($('.arrow.down').hasClass('voted')) {
        $('.arrow.down').removeClass('voted');
        score = 2;
        other_arrow = 1;
      }
      else {
        score = 1;
      }
      $.post('/votes/create', {'vote' : '1', 'article_id' : story_attr, 'score' : score, 'other_arrow' : other_arrow}, null, 'script')
      return false;
    });

    $('.arrow.down').click(function(){
      if (user == 2) {
        window.location.replace("http://localhost:4000/login");
        return false;
      }
      var points = $(this).parent().find('.points').text();
      var story_attr = $(this).parent().attr('id');
      var other_arrow = 0;
      var score = 0;
      if ( $(this).hasClass('voted') == true ) {
        $(this).parent().find('.points').text(parseInt(points) + 1);
        $(this).removeClass('voted');
        score = 1;
        $.post('/votes/delete_vote', {'article_id' : story_attr, 'score' : 1}, null, 'script')
        return false;
      }
      $(this).addClass('voted');
      if ($('.arrow.up').hasClass('voted')) {
        $(this).parent().find('.points').text(parseInt(points) - 2);
        $('.arrow.up').removeClass('voted');
        other_arrow = 1;
        score = -2;
      }
      else {
        $(this).parent().find('.points').text(parseInt(points) - 1);
        score = -1;
      }
      $.post('/votes/create', {'vote' : '-1', 'article_id' : story_attr, 'score' : score, 'other_arrow' : other_arrow}, null, 'script')
      return false;
    });
    
    $('.writeit').click(function(){
      if ($(this).hasClass('written')) {
        $('.write').hide();
        $(this).text("Write it").removeClass("written");
      }
      else {
        $('.write').show();
        $(this).addClass('written').text("don't write it");
      }
    })

});