:- begin_tests(family_tree).

:- consult(family_tree).

test(alice_is_parent_of_bob) :-
    parent(alice, bob).

test(alice_is_grandparent_of_charlie) :-
    once(grandparent(alice, charlie)).

test(bob_and_diana_are_siblings) :-
    sibling(bob, diana).

test(alice_is_ancestor_of_charlie) :-
    once(ancestor(alice, charlie)).

test(bob_is_parent_of_emma) :-
    parent(bob, emma).

test(diana_is_parent_of_frank) :-
    parent(diana, frank).

test(charlie_is_parent_of_grace) :-
    parent(charlie, grace).

:- end_tests(family_tree).
