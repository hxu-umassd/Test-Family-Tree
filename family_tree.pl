parent(alice, bob).
parent(alice, diana).
parent(bob, charlie).
parent(bob, emma).
parent(diana, frank).
parent(charlie, grace).

grandparent(Grandparent, Grandchild) :-
    parent(Grandparent, Parent),
    parent(Parent, Grandchild).

sibling(Person, Sibling) :-
    dif(Person, Sibling),
    parent(Parent, Person),
    parent(Parent, Sibling).

ancestor(Ancestor, Descendant) :-
    parent(Ancestor, Descendant).
ancestor(Ancestor, Descendant) :-
    parent(Ancestor, Intermediate),
    ancestor(Intermediate, Descendant).
