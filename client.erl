-module( client ).
-export( [ initialize/0, receive_loop/0 ] ).

initialize() ->
  spawn( ?MODULE, receive_loop, [] ).
  

receive_loop() ->
  receive
    { message, Message } -> io:format( "~p~n", [ Message ] );
    Any -> io:format( "Client: Unknown Message received~p~n", [ Any ] )
  after infinity -> true
  end,
  receive_loop().
