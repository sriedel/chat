-module( client ).
-behavior( gen_event ).
-export( [ client_ref/0, subscribe_channel/2, unsubscribe_channel/2, send_message/2 ] ).
-export( [ init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3 ] ).

client_ref() ->
  make_ref().

send_message( ChannelName, Message ) ->
  message_proxy:message( list_to_atom( ChannelName ), Message ).

subscribe_channel( ClientRef, ChannelName ) ->
  Channel = list_to_atom( ChannelName ),
  channel_proxy:subscribe_client( ClientRef, Channel ).

unsubscribe_channel( ClientRef, ChannelName ) ->
  Channel = list_to_atom( ChannelName ),
  channel_proxy:unsubscribe_client( ClientRef, Channel ).

% gen_event callbacks
init([ChannelName]) -> 
  {ok, [ChannelName]}.

handle_event( {message, Channel, MessageRef, Message}, State) -> 
  io:format( "~p/~p: ~p~n", [ Channel, MessageRef, Message ] ),
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
