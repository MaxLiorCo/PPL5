:- module('ex5',
        [author/2,
         genre/2,
         book/4
        ]).

/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).
:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).



author(1, "Isaac Asimov").
author(2, "Frank Herbert").
author(3, "William Morris").
author(4, "J.R.R Tolkein").


genre(1, "Science").
genre(2, "Literature").
genre(3, "Science Fiction").
genre(4, "Fantasy").

book("Inside The Atom", 1, 1, 500).
book("Asimov's Guide To Shakespeare", 1, 2, 400).
book("I, Robot", 1, 3, 450).
book("Dune", 2, 3, 550).
book("The Well at the World's End", 3, 4, 400).
book("The Hobbit", 4, 4, 250).
book("The Lord of the Rings", 4, 4, 1250).

% You can add more facts.
% Fill in the Purpose, Signature as requested in the instructions here

emptyList([]).

len([], Length) :-
    Length is 0.
len([_ | T], Length) :-
    len(T, L0),
    Length is L0 + 1.
    
    
% Signature: authorOfGenre(GenreName, AuthorName)
% Purpose: Check if 'AuthorName' have written any books of genre 'GenreName'.
authorOfGenre(GenreName, AuthorName) :-
    genre(GenreId, GenreName),
    author(AuthorId, AuthorName),
    book(_, AuthorId, GenreId, _).


% Signature: longestBook(AuthorId, BookName)
% Purpose: Checks if 'BookName' of 'AuthorId' is the longest book this author have written.
longestBook(AuthorId, BookName) :-
    book(BookName, AuthorId, _, Length),
    findall(X, (getLength(_, AuthorId, _, X), X > Length), Bag),
    emptyList(Bag).

% Signature: versatileAuthor(AuthorName)
% Purpose: Checks whether Author 'AuthorName' has written at least 3 books from 3 different genres.
versatileAuthor(AuthorName) :-
    author(_, AuthorName),
    findall(Genre, authorOfGenre(Genre, AuthorName), Genres),
    len(Genres, L),
    L >= 3.
        