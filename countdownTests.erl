-module(countdownTests).

-include_lib("eunit/include/eunit.hrl").

% "12321" -----------------------------------------------------
discoverBase_12321_test() ->
    ?assertEqual(4, countdown:discoverBase("12321")).

convertToBinary_12321_test() ->
    %441 -110111001
    F = countdown:generateBinaryConverter(countdown:discoverBase("12321")),
    ?assertEqual([1,1,0,1,1,1,0,0,1], F("12321")).

% "howLongDoWeHave" -----------------------------------------------------

howLong_test() ->
    ?assertEqual([1,0,0,1,1,1,0,1,1], countdown:howLongDoWeHave(countdown:readTransmission("sample.txt"))).
