%predicate to delete the first occurence of the minimum number from a
% list
% predicte to determine the minimum from two numbers
% min_numbers(A:number, B:number, R:number)
% min_numbers(i,i,o)
%
min_numbers(A,B,A):-A=<B.
min_numbers(A,B,B):-A>B.

%predicate to determine the minimum number from a list
%min_list(L:list, R:number)
%min-list(i,o)
minim_list([H],H).
minim_list([H|T],R):-
    minim_list(T,R1),
    min_numbers(H,R1,R).

%predicate to delete the first occurence of an element
%delete_first(L:list,M:number, R:list)
%delete_first(i,i,o)
delete_first([H|T],H,T):-!.
delete_first([H|T],M,[H|R]):- delete_first(T,M,R).

% predicate to detele the first occurence of the minimum number from a
% list
% delete_minim(L:list,R:list)
% delete_minim(i,o)
delete_minim(L,R):-
    minim_list(L,RM),
    delete_first(L,RM,R).

