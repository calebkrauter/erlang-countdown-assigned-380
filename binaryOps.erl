-module(binaryOps).
-export([binNegate/1, binAnd/2, binOr/2, binXor/2]).

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

binXor([], _) -> [];
binXor(_, []) -> [];
binXor([H1 | T1], [H2 | T2]) when (H1 =:= 1 andalso H2 =/= H1) -> ['1' | binXor(T1, T2)];
binXor([H1 | T1], [H2 | T2]) when (H2 =:= 1 andalso H1 =/= H2) -> ['1' | binXor(T1, T2)];
binXor([_ | T1], [_ | T2]) -> ['0' | binXor(T1, T2)].
% binXor([H1 | T1], BinL2) -> [H1 | binXor(T1, BinL2)];
% binXor(BinL1, [H2 | T2]) -> [H2 | binXor(BinL1, T2)].
% 
% binXor(BinL1, BinL2) -> binXor([], [], getLengthOfList(BinL1, 0), getLengthOfList(BinL2, 0), 0).

% binXor([], [], _, _, _) -> [];
% % binXor(_, []) -> [];
% binXor([H1 | T1], BinL2, List1Length, List2Length, Index) when (Index < List1Length)-> [H1 | binXor(T1, BinL2, List1Length, List2Length, Index + 1)];
% binXor(BinL1, [H2 | T2], List1Length, List2Length, Index) when (Index < List2Length) -> [H2 | binXor(BinL1, T2, List1Length, List2Length, Index + 1)];
% binXor([H1 | T1], [H2 | T2], List1Length, List2Length, Index) when (H1 =:= 1 andalso H2 =/= H1) -> [1 | binXor(T1, T2, List1Length, List2Length, Index + 1)];
% binXor([H1 | T1], [H2 | T2], List1Length, List2Length, Index) when (H2 =:= 1 andalso H1 =/= H2) -> [1 | binXor(T1, T2, List1Length, List2Length, Index + 1)];
% binXor([_ | T1], [_ | T2], List1Length, List2Length, Index) -> [0 | binXor(T1, T2, List1Length, List2Length, Index + 1)].

% getLengthOfList([_ | T], Index) -> getLengthOfList(T, Index + 1);
% getLengthOfList([], Index) -> Index.