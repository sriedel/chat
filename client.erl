-module( client ).
-behavior( gen_event ).
-export( [ subscribe/1 ] ).
-export( [ init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3 ] ).

subscribe( ChannelHandlerPid ) ->
  gen_event:add_handler( ChannelHandlerPid, ?MODULE, [] ).

% gen_event callbacks
init([]) -> 
  {ok, []}.

handle_event( {message, Message}, State) -> 
  io:format( "~p~n", [ Message ] ),
  {ok, State}.

handle_call(_Request, State) -> 
  Reply = [],
  {ok, Reply, State}.

handle_info(_Info, State) -> 
  {ok, State}.

terminate( _Reason, _State) -> 
  ok.

code_change(_OldVsn, State, _Extra) -> 
  {ok, State}.
