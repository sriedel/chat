-module( message_receiver ).
-export([initialize/0, join/1, leave/1, send_message/1]).

initialize() ->
  ets:new( connected_clients, [ set, named_table ] ),
  receive_loop().

join( ClientPid ) ->
  ets:insert( connected_clients, { ClientPid } ).

leave( ClientPid ) ->
  ets:delete( connected_clients, { ClientPid } ).

send_message( Message ) ->
  Clients = ets:match( connected_clients, '$1' ),
  lists:foreach( fun([{Client}]) ->
                    Client ! { message, Message }
                 end, 
                Clients ).

receive_loop() ->
  receive
    { join, ClientPid } -> join( ClientPid );
    { leave, ClientPid } -> leave( ClientPid );
    { message, Message } -> send_message( Message );
    Any -> io:format( "Server received unexpected message: ~p~n", [ Any ] )
  after infinity -> true
  end,
  receive_loop().
