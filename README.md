# Test-Family-Tree

A minimal Prolog family tree: a handful of `parent/2` facts plus the usual derived
relations, with a plunit test suite covering both the facts and the rules.

## The tree

```
              alice
             /     \
          bob      diana
         /   \        \
    charlie  emma    frank
       |
     grace
```

## Files

| File | Contents |
| --- | --- |
| `family_tree.pl` | `parent/2` facts and the `grandparent/2`, `sibling/2`, `ancestor/2` rules |
| `family_tree_tests.pl` | [plunit](https://www.swi-prolog.org/pldoc/man?section=plunit) suite, 7 tests over predicates and relations |

## Requirements

[SWI-Prolog](https://www.swi-prolog.org/) 8.0 or newer (developed and verified on
10.0.2, x64-win64).

Install on Windows: `winget install SWI-Prolog.SWI-Prolog`, or download from
<https://www.swi-prolog.org/download/stable>.

## Usage

Load the facts and rules interactively:

```
$ swipl family_tree.pl
?- parent(alice, bob).
true.

?- grandparent(alice, charlie).
true.

?- ancestor(alice, X).
X = bob ;
X = diana ;
X = charlie ;
X = emma ;
X = grace ;
X = frank.
```

Every descendant of `alice`, run headless:

```
$ swipl -q -g "consult('family_tree.pl'), (ancestor(alice,X), writeln(X), fail ; true)" -t halt
bob
diana
charlie
emma
grace
frank
```

`sibling/2` is symmetric and excludes the person themselves (`dif/2`), so it yields
both directions:

```
$ swipl -q -g "consult('family_tree.pl'), findall(P-S, sibling(P,S), L), writeln(L)" -t halt
[bob-diana,diana-bob,charlie-emma,emma-charlie]
```

## Predicates

| Predicate | Meaning |
| --- | --- |
| `parent(?Parent, ?Child)` | Facts: Alice is Bob's and Diana's parent, Bob is Charlie's and Emma's, Diana is Frank's, Charlie is Grace's. |
| `grandparent(?Grandparent, ?Grandchild)` | Two consecutive `parent/2` steps. |
| `sibling(?Person, ?Sibling)` | Two people sharing a parent, with `dif/2` keeping `Person` and `Sibling` distinct. |
| `ancestor(?Ancestor, ?Descendant)` | Transitive closure of `parent/2` (direct parent case first, then recursive). |

## Tests

```
$ swipl -q -g run_tests -t halt family_tree_tests.pl
% [1/7] family_tree:alice_is_parent_of_bob .......... passed (0.096 sec)
% [2/7] family_tree:alice..ndparent_of_charlie ...... passed (0.000 sec)
% [3/7] family_tree:bob_and_diana_are_siblings ...... passed (0.016 sec)
% [4/7] family_tree:alice..ancestor_of_charlie ...... passed (0.000 sec)
% [5/7] family_tree:bob_is_parent_of_emma ........... passed (0.000 sec)
% [6/7] family_tree:diana_is_parent_of_frank ........ passed (0.000 sec)
% [7/7] family_tree:charlie_is_parent_of_grace ...... passed (0.000 sec)
```

All 7 pass on SWI-Prolog 10.0.2. `run_tests/0` exits non-zero when a test fails, so
the command works as a CI check as-is.

## Extending

Add `parent/2` facts to `family_tree.pl` — `grandparent/2`, `sibling/2` and
`ancestor/2` pick them up automatically. Add a `test(Name) :- Goal.` clause inside the
same `begin_tests`/`end_tests` block in `family_tree_tests.pl` to cover it.

Note: the `.pl` sources use CRLF line endings (originally created on Windows).
