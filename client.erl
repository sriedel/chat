-module( client ).
-behavior( gen_event ).
-export( [ client_ref/0, subscribe_channel/2, unsubscribe_channel/2 ] ).
-export( [ init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3 ] ).

client_ref() ->
  make_ref().

subscribe_channel( ClientRef, ChannelName ) ->
  channel_router:subscribe_client( ClientRef, list_to_atom( ChannelName ) ).

unsubscribe_channel( ClientRef, ChannelName ) ->
  channel_router:unsubscribe_client( ClientRef, list_to_atom( ChannelName ) ).

% gen_event callbacks
init([ChannelName]) -> 
  {ok, [ChannelName]}.

handle_event( {message, Message}, State) -> 
  [Channel|_] = State,
  io:format( "~p: ~p~n", [ Channel, Message ] ),
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
