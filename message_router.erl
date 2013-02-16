-module( message_router ).
-behavior( gen_event ).
-export( [ start_link/1 ] ).
-export( [ init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3 ] ).

start_link( Channel ) ->
  gen_event:start_link( { global, Channel } ).

%% gen_event callbacks

init(ChannelName) -> 
  process_flag( trap_exit, true ),
  {ok, ChannelName}.

handle_event( {message, Channel, MessageRef, Message}, State) -> 
  gen_server:abcast( nodes(), message_proxy, { message, Channel, MessageRef, Message } ),
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
