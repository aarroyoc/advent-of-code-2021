:- use_module(library(dcgs)).
:- use_module(library(lists)).
:- use_module(library(pio)).
:- use_module(library(tabling)).

:- table pair_count/3.

star(1, X) :-
    phrase_from_file(polymer_template(String, Rules), "input"),
    maplist(assertz, Rules),
    repeat(10, step, String, Polymer),
    count(Polymer, Counts),
    max_and_min(Counts, Max, Min),
    X is Max - Min.

star(2, X) :-
    phrase_from_file(polymer_template(String, Rules), "input"),
    maplist(assertz, Rules),
    list_of_pairs(String, Pairs),
    append([_|RestString], [_], String),
    maplist(minus_letter, RestString, MinusLetters),
    maplist(pair_count(40), Pairs, Counts),
    foldl(merge_count, Counts, MinusLetters, FinalCount),
    max_and_min(FinalCount, Max, Min),
    X is Max - Min.

minus_letter(X, X-(-1)).

list_of_pairs([_], []).
list_of_pairs([X,Y|Xs], [X-Y|Ps]) :-
    list_of_pairs([Y|Xs], Ps).

pair_count(N, X-Y, Count) :-
    N > 0,
    rule(X, Y, Z),
    N1 is N - 1,
    pair_count(N1, X-Z, C0),
    pair_count(N1, Z-Y, C1),
    merge_count(C0, C1, C2),
    merge_count(C2, [Z-(-1)], Count).

pair_count(N, X-Y, Count) :-
    N > 0,
    \+ rule(X, Y, _),
    merge_count([X-1], [Y-1], Count),
    portray_clause(pair(X, Y, Count)).

pair_count(0, X-Y, Count) :-
    merge_count([X-1], [Y-1], Count).

merge_count(C0, C1, Count) :-
    append(C0, C1, C2),
    keysort(C2, C3),
    merge_sum(C3, Count).

merge_sum([X-N0,X-N1|Xs], Cs) :-
    N is N0 + N1,
    merge_sum([X-N|Xs], Cs).

merge_sum([X-N0, Y-N1|Xs], [X-N0|Cs]) :-
    X \= Y,
    merge_sum([Y-N1|Xs], Cs).

merge_sum([X-N], [X-N]).

step([X,Y|Rest], [X,Char|Final]) :-
    setof(Z, rule(X, Y, Z), Zs),
    Zs = [Char],
    step([Y|Rest], Final).
step([X,Y|Rest], [X|Final]) :-
    step([Y|Rest], Final).
step([X], [X]).

repeat(0, _, X, X).
repeat(N0, Predicate, X, Z) :-
    N0 > 0,
    call(Predicate, X, Y),
    N is N0 - 1,
    repeat(N, Predicate, Y, Z).

count([], []).
count([X|Xs], Count) :-
    count(Xs, Count0),
    ( select(X-N, Count0, Count1) ->
      ( N1 is N + 1, Count = [X-N1|Count1] )
    ; ( Count = [X-1|Count0] )
    ).

max_and_min([_-N], N, N).
max_and_min([_-N|Xs], Max, Min) :-
    max_and_min(Xs, Max0, Min0),
    Max is max(N, Max0),
    Min is min(N, Min0).

polymer_template(String, Rules) -->
    seq(String),"\n",
    "\n",
    rules(Rules).

rules([]) --> [].
rules([rule(X, Y, Z)|Rules]) -->
    [X,Y],
    " -> ",
    [Z],
    "\n",
    rules(Rules).
