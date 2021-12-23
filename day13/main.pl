:- use_module(library(charsio)).
:- use_module(library(dcgs)).
:- use_module(library(lists)).
:- use_module(library(pio)).
:- use_module(library(clpz)).
:- use_module(library(ordsets)).
:- use_module(library(format)).

paper(Map, Instructions) -->
    map(Map),
    "\n",
    instructions(Instructions).

map([dot(X,Y)|Xs]) -->
    integer(X),
    ",",
    integer(Y),
    "\n",
    map(Xs).
map([]) --> [].

instructions([fold(x, X)|Xs]) -->
    "fold along x=",
    integer(X),
    "\n",
    instructions(Xs).

instructions([fold(y, Y)|Xs]) -->
    "fold along y=",
    integer(Y),
    "\n",
    instructions(Xs).

instructions([]) --> [].

integer(D) --> 
    integer_(Cs),
    {
        number_chars(D, Cs)
    }.
integer_([D|Ds]) --> digit(D), integer_(Ds).
integer_([D])    --> digit(D).

digit(D) --> [D], { char_type(D, decimal_digit) }.

map_instruction(_, [], []).
map_instruction(fold(x, X), [dot(DotX, DotY)|Map0], [dot(DotX, DotY)|Map1]) :-
    DotX =< X,
    map_instruction(fold(x, X), Map0, Map1).
map_instruction(fold(x, X), [dot(DotX, DotY)|Map0], [dot(NewDotX, DotY)|Map1]) :-
    DotX > X,
    NewDotX #= DotX - (DotX-X)*2,
    map_instruction(fold(x, X), Map0, Map1).
map_instruction(fold(y, Y), [dot(DotX, DotY)|Map0], [dot(DotX, DotY)|Map1]) :-
    DotY =< Y,
    map_instruction(fold(y, Y), Map0, Map1).
map_instruction(fold(y, Y), [dot(DotX, DotY)|Map0], [dot(DotX, NewDotY)|Map1]) :-
    DotY >= Y,
    NewDotY #= DotY - (DotY-Y)*2,
    map_instruction(fold(y, Y), Map0, Map1).

map_instructions([], X, X).
map_instructions([X|Xs], Map0, Map2) :-
    map_instruction(X, Map0, Map1),
    map_instructions(Xs, Map1, Map2).

map_points(Map, N) :-
    list_to_ord_set(Map, Set),
    length(Set, N).

star1(N) :-
    phrase_from_file(paper(Map, [X|_]), "input"),
    map_instruction(X, Map, MapFinal),
    map_points(MapFinal, N).

star2 :-
    phrase_from_file(paper(Map, Instructions), "input"),
    map_instructions(Instructions, Map, MapFinal),
    phrase_to_file(map_svg(MapFinal), "map.svg").

map_svg(Map) -->
    svg(dot_svg(Map)).

svg(Body) -->
    format_("<svg width=\"800\" height=\"110\">", []),
    Body,
    format_("</svg>", []).

dot_svg([dot(X, Y)|Xs]) -->
    {
        SvgX is X * 16 + 10,
        SvgY is Y * 16 + 10
    },
    format_("<rect width=\"16\" height=\"16\" x=\"~d\" y=\"~d\" fill=\"black\"/>", [SvgX, SvgY]),
    dot_svg(Xs).
dot_svg([]) --> [].