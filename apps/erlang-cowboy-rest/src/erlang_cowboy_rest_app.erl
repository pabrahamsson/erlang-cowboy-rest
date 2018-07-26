%%%-------------------------------------------------------------------
%% @doc erlang-cowboy-rest public API
%% @end
%%%-------------------------------------------------------------------

-module(erlang_cowboy_rest_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    %%{ok, Pid} = 'erlang_cowboy_rest_sup':start_link(),
    Routes = [ {
        '_',
        [
            {"/", erlang_cowboy_rest_root, []}
        ]
    } ],
    Dispatch = cowboy_router:compile(Routes),
    NumAcceptors = 10,
    TransOpts = [ {ip, {0,0,0,0}}, {port, 8080} ],
    ProtoOpts = #{env => #{dispatch => Dispatch}},
    {ok, _} = cowboy:start_clear(my_http_listener,
        TransOpts,
        #{env => #{dispatch => Dispatch}}
    ),
    erlang_cowboy_rest_sup:start_link().
    %%{ok, _} = cowboy:start_clear(my_http_listener,
    %%    NumAcceptors, TransOpts, ProtoOpts),
    %%{ok, Pid}.

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
