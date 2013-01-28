-module( client ).
-export( [ initialize/0, connect/2, leave/2, send/2, spawn_receiver/0, receive_loop/0 ] ).

initialize() ->
  spawn_receiver().

connect( Server, ReceiverPid ) ->
  Server ! { join, ReceiverPid }.

leave( Server, ReceiverPid ) ->
  Server ! { leave, ReceiverPid }.

send( Server, Message ) ->
  Server ! { message, Message }.

receive_loop() ->
  receive
    { message, Message } -> io:format( "~p~n", [ Message ] );
    Any -> io:format( "Client: Unknown Message received~p~n", [ Any ] )
  after infinity -> true
  end,
  receive_loop().

spawn_receiver() ->
  spawn( ?MODULE, receive_loop, [] ).
