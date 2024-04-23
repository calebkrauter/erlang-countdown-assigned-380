-module(binaryOps).
-export([binNegate/1, binAnd/2, binOr/2, binXor/2, binAdd/2, trimLeading/1]).

binNegate(BinL) -> binNegate(BinL, 0, false).
binNegate([], _, _) -> [];
binNegate([H | T], IncrementWhenFirstFlipTo1, _) when (H =:= 0) -> ['1' | binNegate(T, IncrementWhenFirstFlipTo1, true)];
binNegate([H | T], IncrementWhenFirstFlipTo1, false) when (H =:= 1) -> binNegate(T, IncrementWhenFirstFlipTo1, false);
binNegate([H | T], IncrementWhenFirstFlipTo1, true) when (H =:= 1) -> ['0' | binNegate(T, IncrementWhenFirstFlipTo1, true)].
% [1,0,0,1,1,1,0,0,1], [1,1,0,0]
% Output: [1,0,0,0]
% Check head of both lists and compare them to see if they are both 1. any other situation just add 0 and move on.

binAnd([], _) -> [];
binAnd(_, []) -> [];
binAnd([H1 | T1], [H2 | T2]) when (H1 =:= 1 andalso H2 =:= H1) -> ['1' | binAnd(T1, T2)];
binAnd([_ | T1], [_ | T2]) -> ['0' | binAnd(T1, T2)].

binOr([], _) -> [];
binOr(_, []) -> [];
binOr([H1 | T1], [H2 | T2]) when (H1 =:= 1 andalso H2 =:= H1) -> ['1' | binOr(T1, T2)];
binOr([H1 | T1], [H2 | T2]) when (H1 =:= 1 orelse H2 =:= 1) -> ['1' | binOr(T1, T2)];
binOr([_ | T1], [_ | T2]) -> ['0' | binOr(T1, T2)].


% binXor([H1 | T1], BinL2) when (H1 =:= 1 andalso BinL2 =/= []) -> [H1 | binXor(T1, BinL2)];
% binXor(BinL1, [H2 | T2]) when (H2 =:= 1 andalso BinL1 =/= [])-> [H2 | binXor(BinL1, T2)];
% binXor([H1 | T1], BinL2) when (H1 =:= 0 andalso BinL2 =/= []) -> [H1 | binXor(T1, BinL2)];
% binXor(BinL1, [H2 | T2]) when (H2 =:= 0 andalso BinL1 =/= [])-> [H2 | binXor(BinL1, T2)];
% 
% 
% 

binXor([], _) -> [];
binXor(_, []) -> [];
binXor([H1 | T1], [H2 | T2]) when (H1 =:= 1 andalso H2 =/= H1) -> [1 | binXor(T1, T2)];
binXor([H1 | T1], [H2 | T2]) when (H2 =:= 1 andalso H1 =/= H2) -> [1 | binXor(T1, T2)];
binXor([_ | T1], [_ | T2]) -> [0 | binXor(T1, T2)].

% INCOMPLETE
% add:
% [1,1,0,0,1], [1,1,0,0]
% [1,0,0,1,0,1]
% 
% 11001
%  1100
% +____
% 
% 1. reverse
% 10011
% 0011 +
% 2. Add 1 + 0, result: 1
% 3. 0 + 0 result in 0
% 4. 0 + 1 result in 1
% 5. 1 + 1 result in 0 and carry 1 to bottom list
% 6. 1 + 1 result in 0 carry 1 to end.
binAdd([], []) -> [];
binAdd(_, []) -> [];
binAdd([], _) -> [];
binAdd([H1, T1], [H2, T2]) when (H1 =:= 0 andalso H2 =:= 1) -> [H2 | binAdd(T1, T2)];
binAdd([H1, T1], [H2, T2]) when (H1 =:= 1 andalso H2 =:= 0) -> [H1 | binAdd(T1, T2)];
binAdd([H1, T1], [H2, T2]) when (H1 =:= 1 andalso H2 =:= 1) -> [0 | binAdd(T1, [1 | T2])].

trimLeading(BinL) -> trimLeading(BinL, false).
trimLeading([], _) -> [];
trimLeading([H | T], false) when (H =:= 0) -> trimLeading(T, false);
trimLeading([H | T], _) when (H =:= 1) -> [H | trimLeading(T, true)];
trimLeading([H | T], true) when (H =:= 0) -> [H | trimLeading(T, true)].  