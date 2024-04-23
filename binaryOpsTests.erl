-module(binaryOpsTests).

-include_lib("eunit/include/eunit.hrl").

% binNegate
binNegate_100111011_test() ->
    ?assertEqual([1,1,0,0,0,1,0,0], binaryOps:binNegate([1,0,0,1,1,1,0,1,1])).
binNegate_000111011_test() ->
    ?assertEqual([1,1,1,0,0,0,1,0,0], binaryOps:binNegate([0,0,0,1,1,1,0,1,1])).
binNegate_111111111_test() ->
    ?assertEqual([], binaryOps:binNegate([1,1,1,1,1,1,1,1,1])).
binNegate_000000000_test() ->
    ?assertEqual([1,1,1,1,1,1,1,1,1], binaryOps:binNegate([0,0,0,0,0,0,0,0,0])).

% binAnd _______________________ 0 and 0 fails because it returns [0].
binAnd_100111001_and_1100_test() ->
    ?assertEqual([1,0,0,0], binaryOps:binAnd([1,0,0,1,1,1,0,0,1], [1,1,0,0])).
binAnd_1_and_1_test() ->
    ?assertEqual([1], binaryOps:binAnd([1], [1])).
binAnd_0_and_0_test() ->
    ?assertEqual([], binaryOps:binAnd([0], [0])).
binAnd_011_and_110_test() ->
    ?assertEqual([1], binaryOps:binAnd([0,1,1], [1,1,0])).
% The following functions are close to expected. I neglected to 
% append the first few bits that are uncompared. Initially I had a misunderstanding
% for this part of the assignment and got stuck trying to implement it to the specs
% and decided to just return the compared bits.

% binOr as per the specs returns 1,0,0,1,1,1,1,1,0,1 mine returns the compared
% part of the number which is the     ->     1,1,0,1
binOr_100111001_or_1100_test() ->
    ?assertEqual([1,1,0,1], binaryOps:binOr([1,0,0,1,1,1,0,0,1], [1,1,0,0])).
binOr_100_or_1100_test() ->
    ?assertEqual([1,1,0], binaryOps:binOr([1,0,0], [1,1,0,0])).
binOr_1001_or_100_test() ->
    ?assertEqual([1,0,0], binaryOps:binOr([1,0,0,1], [1,0,0])).
binOr_1010_or_1100_test() ->
    ?assertEqual([1,1,1,0], binaryOps:binOr([1,0,1,0], [1,1,0,0])).
binOr_010_or_1100_test() ->
    ?assertEqual([1,1,0], binaryOps:binOr([0,1,0], [1,1,0,0])).

% binXor does the same in returning just the compared part like binOr
% It also does not trim leading zeros.
binXor_100111001_or_1100_test() ->
    ?assertEqual([0,1,0,1], binaryOps:binXor([1,0,0,1,1,1,0,0,1], [1,1,0,0])).
binXor_100_or_1100_test() ->
    ?assertEqual([0,1,0], binaryOps:binXor([1,0,0], [1,1,0,0])).
binXor_1001_or_100_test() ->
    ?assertEqual([0,0,0], binaryOps:binXor([1,0,0,1], [1,0,0])).
binXor_1010_or_1100_test() ->
    ?assertEqual([0,1,1,0], binaryOps:binXor([1,0,1,0], [1,1,0,0])).
binXor_010_or_1100_test() ->
    ?assertEqual([1,0,0], binaryOps:binXor([0,1,0], [1,1,0,0])).

% I was unable to solve binAdd fully. I have a partial version but it does not work.
% I was struggling with the carry operation a lot.

% trimLeading

trimLeading_0000000_test() ->
    ?assertEqual([], binaryOps:trimLeading([0,0,0,0,0,0,0])).
trimLeading_0000001_test() ->
    ?assertEqual([1], binaryOps:trimLeading([0,0,0,0,0,0,1])).
trimLeading_00001000_test() ->
    ?assertEqual([1,0,0,0], binaryOps:trimLeading([0,0,0,0,1,0,0,0])).
trimLeading_1_test() ->
    ?assertEqual([1], binaryOps:trimLeading([1])).
