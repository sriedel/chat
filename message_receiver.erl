-module( message_receiver ).
-behavior( gen_server ).
-export( [ start_link/0, message/2 ] ).
-export( [ init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3 ] ).

%% interface methods
start_link() ->
  gen_server:start_link( {local, ?MODULE}, ?MODULE, [], [] ).

message( ChannelName, Message ) ->
  gen_server:call( ?MODULE, { message, list_to_atom( ChannelName ), Message } ).

%% gen_server callbacks
init([]) ->
  { ok, [] }.

handle_call( {message, Channel, Message}, _From, State ) ->
  MessageRef = make_ref(),
  try gen_event:notify( Channel, { message, MessageRef, Message } ) of
    ok -> { reply, { message, ok, MessageRef }, State }
    catch error:badarg -> { reply, { message, error, nosuchchannel }, State }
  end.

handle_cast( _Msg, State ) -> { noreply, State }.

handle_info( _Info, State ) -> { noreply, State }.

terminate( _Reason, _State ) -> ok.

code_change( _OldVersion, State, _Extra ) -> { ok, State }.

