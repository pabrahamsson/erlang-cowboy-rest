-module(erlang_cowboy_rest_root).

-export([init/2]).

init(Req0=#{method := <<"GET">>}, State) ->
    Req = cowboy_req:reply(200, #{
        <<"content-type">> => <<"text/plain">>
    }, <<"Hello Openshift!\n">>, Req0),
    {ok, Req, State}.
