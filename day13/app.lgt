:- use_module(library(readutil)).
:- use_module(library(dcg/basics)).
:- set_prolog_flag(double_quotes, chars).

:- object(dot, instantiates(dot)).

    :- public([
        new/3,
        x/1,
        y/1
    ]).
    new(Instance, X, Y) :-
        self(Class),
        create_object(Instance, [instantiates(Class)], [], [x(X), y(Y)]).

    :- public(mirror_x/2).
    mirror_x(Instance, X) :-
        ::x(DotX),
        DotX =< X,
        self(Instance).

    mirror_x(Instance, X) :-
        ::x(DotX),
        ::y(DotY),
        DotX > X,
        NewDotX is DotX - (DotX-X)*2,
        create_object(Instance, [instantiates(dot)], [], [x(NewDotX), y(DotY)]).

    :- public(mirror_y/2).
    mirror_y(Instance, Y) :-
        ::y(DotY),
        DotY =< Y,
        self(Instance).

    mirror_y(Instance, Y) :-
        ::x(DotX),
        ::y(DotY),
        DotY > Y,
        NewDotY is DotY - (DotY-Y)*2,
        create_object(Instance, [instantiates(dot)], [], [x(DotX), y(NewDotY)]).

:- end_object.

:- object(paper).

    :- public(paper/4).
    paper(Map, Instructions) -->
        map(Map),
        "\n",
        instructions(Instructions).

    map([Dot|Xs]) -->
        dcg_basics:integer(X),
        ",",
        dcg_basics:integer(Y),
        "\n",
        {
            dot::new(Dot, X, Y)
        },
        map(Xs).
    map([]) --> [].

    instructions([fold(x, X)|Xs]) -->
        "fold along x=",
        dcg_basics:integer(X),
        "\n",
        instructions(Xs).

    instructions([fold(y, Y)|Xs]) -->
        "fold along y=",
        dcg_basics:integer(Y),
        "\n",
        instructions(Xs).

    instructions([]) --> [].

:- end_object.

:- object(map_svg).

    :- public(map_svg/3).
    map_svg(Map) -->
        svg(dot_svg(Map)).

    svg(Body) -->
        "<svg width=\"800\" height=\"110\">",
        Body,
        "</svg>".

    dot_svg([Dot|Xs]) -->
        {
            Dot::x(X),
            Dot::y(Y),
            SvgX is X * 16 + 10,
            SvgY is Y * 16 + 10,
            number_chars(SvgX, SvgXChars),
            number_chars(SvgY, SvgYChars)
        },
        "<rect width=\"16\" height=\"16\" x=\"",
        SvgXChars,
        "\" y=\"",
        SvgYChars,
        "\" fill=\"black\"/>",
        dot_svg(Xs).
    dot_svg([]) --> [].

:- end_object.

:- object(app).
    :- public([
        star1/1,
        star2/0
    ]).
    star1(N) :-
        read_file(Map, [X|_]),
        map_instruction(X, Map, MapFinal),
        map_points(MapFinal, N).

    star2 :-
        read_file(Map, Instructions),
        map_instructions(Instructions, Map, MapFinal),
        phrase(map_svg::map_svg(MapFinal), SVG),
        string_chars(SVGString, SVG),
        open('map_logtalk.svg', write, Stream),
        write(Stream, SVGString),
        close(Stream).

    map_instruction(_, [], []).
    map_instruction(fold(x, X), [Dot|Map0], [NewDot|Map1]) :-
        Dot::mirror_x(NewDot, X),
        map_instruction(fold(x, X), Map0, Map1).
    
    map_instruction(fold(y, Y), [Dot|Map0], [NewDot|Map1]) :-
        Dot::mirror_y(NewDot, Y),
        map_instruction(fold(y, Y), Map0, Map1).

    map_instructions([], X, X).
    map_instructions([X|Xs], Map0, Map2) :-
        map_instruction(X, Map0, Map1),
        map_instructions(Xs, Map1, Map2).

    map_points(Map, N) :-
        meta::map(map_dot, Map, MapDot),
        set::as_set(MapDot, Set),
        set::size(Set, N).

    map_dot(Dot, dot(X, Y)) :-
        Dot::x(X),
        Dot::y(Y).

    read_file(Map, Instructions) :-
        readutil:read_file_to_string(input, String, []),
        string_chars(String, Chars),
        phrase(paper::paper(Map, Instructions), Chars).

:- end_object.