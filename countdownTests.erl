-module(countdownTests).

-include_lib("eunit/include/eunit.hrl").

% DiscoverBase -----------------------------------------------------
discoverBase_12321_test() ->
    ?assertEqual(4, countdown:discoverBase("12321")).
discoverBase_z_test() ->
    ?assertEqual(36, countdown:discoverBase("z")).
discoverBase_zasa_test() ->
    ?assertEqual(36, countdown:discoverBase("zasa")).
discoverBase_12412395_test() ->
    ?assertEqual(10, countdown:discoverBase("12412395")).
discoverBase_f_test() ->
    ?assertEqual(16, countdown:discoverBase("f")).

% Convert to binary
convertToBinary_12321_test() ->
    %441 -110111001
    F = countdown:generateBinaryConverter(countdown:discoverBase("12321")),
    ?assertEqual([1,0,0,1,1,1,0,1,1], F("12321")).
convertToBinary_abc_test() ->
    F = countdown:generateBinaryConverter(countdown:discoverBase("abc")),
    ?assertEqual([1,0,1,0,1,1,0,0,1,1,1], F("abc")).
convertToBinary_0_test() ->
    F = countdown:generateBinaryConverter(countdown:discoverBase("0")),
    ?assertEqual([], F("0")).
convertToBinary_12_test() ->
    F = countdown:generateBinaryConverter(countdown:discoverBase("12")),
    ?assertEqual([1,0,1], F("12")).
% "howLongDoWeHave" -----------------------------------------------------

howLong_test() ->
    ?assertEqual([1,0,0,1,1,1,0,1,1], countdown:howLongDoWeHave(countdown:readTransmission("sample.txt"))).
howLong_1_test() ->
    ?assertEqual([1], countdown:howLongDoWeHave(["1", "12z"])).
howLong_12_test() ->
    ?assertEqual([1,0,1], countdown:howLongDoWeHave(["12"])).
howLong_a_test() ->
    ?assertEqual([0,1,0,1], countdown:howLongDoWeHave(["a"])).
howLong_1c21_test() ->
    ?assertEqual([0,0,1,1,1,0,0,1,0,0,0,0,1], countdown:howLongDoWeHave(["1c21"])).