f([],[]).
f([H|T],[H|Rez]):-H mod 2=:=0,
 !,
 f(T,Rez).
f([_|T],Rez):-f(T,Rez).


%returns the last el of the list
%my_last[E: element, L:list)
%flow: my_last(o,i)
my_last(X,[X]).
my_last(X, [_|L]):-my_last(X,L).


%antelast el of the list
%another_last(X:element, L:list)
%flow: another_last(o,i)
another_last(X,[X,_]).
another_last(X,[_,Y|Ys]):-another_last(X,[Y|Ys]).


%k-th element of a list
%k_el(X: element, L:list)
%flow: (o,i)
k_el(X,[X|_],1).
k_el(X,[_|L],K):- K > 1, K1 is K-1, k_el(X,L,K1).

%nr of elements in a list
%nr_el(L:list, N: number)
%flow: (i,o)
nr_el([],0).
nr_el([_|L],N):-nr_el(L,N1), N is N1+1.

%reverse_list
%reverse_list(L:list, R:list)
%flow(i,o)
%
my_reverse(L1,L2) :- my_rev(L1,L2,[]).

my_rev([],L2,L2) :- !.
my_rev([X|Xs],L2,Acc) :- my_rev(Xs,L2,[X|Acc]).

%eliminate consecutive duplicates in a list
%delete(L:list, R:list)
%flow: (i,o)
delete([],[]).
delete([H],[H]).
delete([H,H|T],R):-delete([H|T],R).
delete([H,H1|T1],[H|R]):-H \= H1, delete([H1|T1],R).

%duplicate the elements of a list
%duplicate(L:list, R:list)
%flow: i,o
duplicate([],[]).
duplicate([H|T],[H,H|R]):-duplicate(T,R).

%duplicate the list of a certain nr of times
%duplcicate(L:list, N:number, R:list) (i,i,o)
duplicate2(L,N,R):-duplicate2(L,N,R,N).

duplicate2([],_,[],_).
duplicate2([_|T],N,R,0):-duplicate2(T,N,R,N).
duplicate2([H|T],N,[H|R],K):-K>0,K1 is K-1, duplicate2([H|T],N,R,K1).

%delete nth el
delete_n(L,N,R):-drop(L,N,R,N).

drop([],_,[],_).
drop([_|T],N,R,1):-drop(T,N,R,N).
drop([H|T],N,[H|R],K):-K>1,K1 is K-1, drop(T,N,R,K1).



%extract a slice from a list
slice([H|_],1,1,[H]).
slice([H|T],1,K,[H|R]):-K>1,K1 is K-1, slice(T,1,K1,R).
slice([_|T],I,K,R):-I>1,I1 is I-1, K1 is K-1, slice(T,I1,K1,R).


%delete n-th element from the list
%delete_nth(X:number, L:list, R:list,K:th el)

remove_at(X,[X|Xs],1,Xs).
remove_at(X,[Y|Xs],K,[Y|Ys]) :- K > 1,
   K1 is K - 1, remove_at(X,Xs,K1,Ys).

%insert at a given position
insert_at(X,L,K,R):-remove_at(X,R,K,L).

%create a list containing all the elements from a given range
%create_list(A:number, B:number, L:list) (i,i,o)
create_list(A,A,[A]).
create_list(A,B,[A|L]):-A<B, A1 is A+1, create_list(A1,B,L).

% generate the combinations of k distinct numbers from the n elements of
% a list
% combinations(K,L,C) - C is alist of K distinct objects chosen from the
% list L
%
combination(0,_,[]).
combination(K,L,[X|Xs]) :- K > 0,
   el(X,L,R), K1 is K-1, combination(K1,R,Xs).

el(X,[X|L],L).
el(X,[_|L],R) :- el(X,L,R).


%determine if a number is prime
%prime(N:number)

prime(2).
prime(3).
prime(N):-integer(N),N>3, N mod 2 =\=0, \+has_factor(N,3).

%has_factor: N has an off factor
has_factor(N,L):-N mod L =:= 0.
has_factor(N,L):-L*L<N,L2 is L+2, has_factor(N,L2).


%gcd
gcd(X,0,X) :- X > 0.
gcd(X,Y,G) :- Y > 0, Z is X mod Y, gcd(Y,Z,G).

%2 numbers are coprime
coprime(X,Y):-gcd(X,Y,1).

%prime factors a number

% prime_factors(N, L) :- N is the list of prime factors of N.
%    (integer,list) (+,?)

prime_factors(N,L) :- N > 0,  prime_factors(N,L,2).

% prime_factors(N,L,K) :- L is the list of prime factors of N. It is
% known that N does not have any prime factors less than K.

prime_factors(1,[],_) :- !.
prime_factors(N,[F|L],F) :-                           % N is multiple of F
   R is N // F, N =:= R * F, !, prime_factors(R,L,F).
prime_factors(N,L,F) :-
   next_factor(N,F,NF), prime_factors(N,L,NF).        % N is not multiple of F


% next_factor(N,F,NF) :- when calculating the prime factors of N
%    and if F does not divide N then NF is the next larger candidate to
%    be a factor of N.

next_factor(_,2,3) :- !.
next_factor(N,F,NF) :- F * F < N, !, NF is F + 2.
next_factor(N,_,N).
% F > sqrt(N


%list o prime numbers from an interval
%
prime_list(A,B,L) :- A =< 2, !, p_list(2,B,L).
prime_list(A,B,L) :- A1 is (A // 2) * 2 + 1, p_list(A1,B,L).

p_list(A,B,[]) :- A > B, !.
p_list(A,B,[A|L]) :- prime(A), !,
   next(A,A1), p_list(A1,B,L).
p_list(A,B,L) :-
   next(A,A1), p_list(A1,B,L).

next(2,3) :- !.
next(A,A1) :- A1 is A + 2.
