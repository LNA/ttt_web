$(function() {
  $('#player1_game_piece').on ('change', function(event){
    var $this = $(this);
    if (($this).val() == "X") {
      $('#player2_game_piece').val("O");
    }
    else{
      $('#player2_game_piece').val("X");

    }
  });
});
