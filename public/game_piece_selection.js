$(function() {
  $('#player1_game_piece').on ('change', function(event){
      if ($(this).val() == 'X') $('#player2_game_piece').val("O");
        else $('#player2_game_piece').val("X");   // will select the non-selected option
  });
});