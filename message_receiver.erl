-module( message_receiver ).
-behavior( gen_server ).
-export( [ start_link/0, connect/1, disconnect/1, message/1 ] ).
-export( [ init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3 ] ).

%% interface methods
start_link() ->
  gen_server:start_link( {local, ?MODULE}, ?MODULE, [], [] ).

connect( ReceiverPid ) ->
  gen_server:call( ?MODULE, { connect, ReceiverPid } ).

disconnect( ReceiverPid ) ->
  gen_server:call( ?MODULE, { disconnect, ReceiverPid } ).

message( Message ) ->
  gen_server:call( ?MODULE, { message, Message } ).

%% gen_server callbacks
init([]) ->
  { ok, ets:new( connected_clients, [ set, named_table ] ) }.

handle_call( {connect, ClientPid}, _From, Table ) ->
  ets:insert( connected_clients, { ClientPid } ),
  { reply, connect, Table };

handle_call( {disconnect, ClientPid}, _From, Table ) ->
  ets:delete( connected_clients, ClientPid ),
  { reply, disconnect, Table };

handle_call( {message, Message}, _From, Table ) ->
  Clients = ets:match( connected_clients, '$1' ),
  lists:foreach( fun([{Client}]) ->
                    Client ! { message, Message }
                 end, 
                Clients ),
  { reply, message, Table }.

handle_cast( _Msg, State ) -> { noreply, State }.

handle_info( _Info, State ) -> { noreply, State }.

terminate( _Reason, _State ) -> ok.

code_change( _OldVersion, State, _Extra ) -> { ok, State }.

