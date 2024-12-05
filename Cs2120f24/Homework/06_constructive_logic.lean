namespace cs2120f24.constructiveLogic

/-! HOMEWORK #6. COUNTS FOR TWO ASSIGNMENTS.

This is an important homework. It gives you an
opportunity to work out many of the kinks in your
understanding of predicate logic and deductive
proofs in type theory. With P, Q, and R accepted
as propositions, you are to give proofs of all of
the identities from Library/propLogic/identities,
which I've rewritten in Lean for you. There's one
of these axioms that has no constructive proof (in
just one direction). You can just identify it.
-/


-- Suppse P, Q, and R are arbitrary propositions
axiom P : Prop
axiom Q : Prop
axiom R : Prop

/-!
Give proofs in Lean that each of the following identities
is valid. We already know they're classically valid as we
validated their propositional logic analogics semantically
using our model / validity checker. To get you started with
a concrete example, we prove the first one for you and give
a little English explanation after. You should od the same
for each proposition you prove.
-/


def andIdempotent   : P ↔ (P ∧ P) :=
Iff.intro
  -- forward direction: P → P ∧ P
  -- assume p : P, show P ∧ P
  (fun (p : P) => (And.intro p p))
  -- backwards direction: P ∧ P → P
  (fun (h : And P P) => (h.right))

/-!
In English: To prove P ↔ P ∧ P it will suffice
by iff intro, to have proofs, (fw : P → (P ∧ P))
and (bw : (P ∧ P) → P). Each is proved by giving
an argument to result proof construction.

Forward direction:

To prove P → P ∧ P, we show (by defining one) that
there is a function that turns any proof of P into
a proof of P ∧ P. There just one answer: ⟨ p, p ⟩.

Backward direction:

To prove P ∧ P → P, we assume a proof, (h : P ∧ P),
and are to show P. Either h.left or h.right will do.

Summary: Whether in formal logic or English language,
you have to know that to prove any equivance, P ↔ Q,
it is both sufficient and necessary that you have or
obtain proofs (fw : P → Q) and (bw: Q → P). With these
values, the term, (Iff.intro fw bw), is a proof of the
equivalence.
-/

-- What we are to prove is that ∨ is idemponent
-- That is, that for any P, P ↔ (P ∨ P).
def orIdempotent    : P ↔ (P ∨ P) :=
-- Proof: The inference/axiom of iff introduction
-- tells us that it sufficies to have proofs of




Iff.intro
-- fw: P → P ∨ P
  (fun (h : P) => (Or.inl h))
-- bw: P ∨ P → P
  (fun (h : P \/ P) => _)


/-!
Prove: P ↔ (P ∨ P)

Proof: By the rule of iff introduction it will
suffice to have proofs of the forwards and backwards
implications. Our proof is therefore completed
but for the construction of these two smaller
proofs. Let's take each one at a time.

Forwards: Prove P → P ∨ P
Proof: By → introduction. Assume P, show P ∨ P.
By or introduction (on the left or right) we can
deduce P \/ P from our assumed proof of P.


-- Backwards: P ∨ P → P
Proof: By → introduction: assume P ∨ P, show P.
The proof by case analysis on P \/ P. There are
only two ways this proof could exist. Case 1: Or
intro on left applied a proof of P. Case 2: Or
intro on the right applied to a proof of P. In
either case (and there are only two cases) we
show that if P \/ P is true then  so is P.

Having prove both P → P ∨ P and P ∨ P → P we can
deduce (construct of proof of) P ↔ P ∨ P.
-/




def andCommutative  : (P ∧ Q) ↔ (Q ∧ P) :=
_

def orCommutative   : (P ∨ Q) ↔ (Q ∨ P) :=
_

def identityAnd     : (P ∧ True) ↔ P :=
_

def identityOr      : (P ∨ False) ↔ P :=
/-
Goal Prove: (P ∨ False) ↔ P
Proof. To prove this equivalence we need to prove
the implications in each direction:

Forwards: (P ∨ False) → P
The proof of this is by → introduction. That
is to say, we'll assume we have a proof of
P \/ False and we'll show that, by Or elimination,
P is true in either case.

-/
Iff.intro
  -- forwards
  (fun (h : (P ∨ False)) =>
    (Or.elim
      h
      (fun (p : P) => p)
      (fun (h : False) => (False.elim h))
    )
  )
  -- Backwards: P →  (P ∨ False)
  (_)

def noContradiction : ¬(P ∧ ¬P) :=
-- proof by → introduction, assume h show False
fun (h : (P ∧ ¬P)) =>
  let (p : P) := h.left
  let (np : ¬P) := h.right
  let (f : False) := (np p)
  f

def noContradiction' : ¬(P ∧ ¬P) :=
-- proof by negation: assume (P ∧ ¬P), show false, conclude ¬(P ∧ ¬P)
fun (h : (P ∧ ¬P)) => False.elim (h.right h.left)



def annhilateAnd    : (P ∧ False) ↔ False  :=
_

def annhilateOr     : (P ∨ True) ↔ True :=
_

def orAssociative   : ((P ∨ Q) ∨ R) ↔ (P ∨ (Q ∨ R)) :=
_

def andAssociative  : ((P ∧ Q) ∧ R) ↔ (P ∧ (Q ∧ R)) :=
_

def distribAndOr    : (P ∧ (Q ∨ R)) ↔ ((P ∧ Q) ∨ (P ∧ R)) :=
Iff.intro
  (_)
  (_)

def distribAndOr'    : (P ∧ (Q ∨ R)) ↔ ((P ∧ Q) ∨ (P ∧ R)) :=

    -- let fw be a proof of the forward implication
    -- proof is by → introduction: assume premise, show conclusion (use a function)
    let (fw : (P ∧ (Q ∨ R)) → ((P ∧ Q) ∨ (P ∧ R))) :=
    (
      -- assume premise
      fun h =>
      (
        -- by And elim left we conclude P
        let p := h.left
        -- by and elim right we conclude Q \/ R
        let qorr := h.right
        -- the remaining is by case analysis on Q \/ R
        Or.elim
          qorr
          -- In the first case Q is true, thus so is P /\ Q, and so by Or intro left ((P ∧ Q) ∨ (P ∧ R)))
          (fun (q : Q) => Or.inl (And.intro p q))
          -- We then consider the second case, and show ((P ∧ Q) ∨ (P ∧ R))) is true because P ∧ R is true
          (fun (r : R) => _)
      )
    )
    -- Having shown that both implications hold, the equivalence also holds. QED.


    let (bw : ((P ∧ Q) ∨ (P ∧ R)) → (P ∧ (Q ∨ R))) := _
    Iff.intro fw bw

def distribOrAnd    : (P ∨ (Q ∧ R)) ↔ ((P ∨ Q) ∧ (P ∨ R)) :=


def equivalence     : (P ↔ Q) ↔ ((P → Q) ∧ (Q → P)) :=
_

def implication     : (P → Q) ↔ (¬P ∨ Q) :=
Iff.intro
  (fun (h : P → Q) =>
    (Or.inr _))
  (fun (h : (¬P ∨ Q)) =>
    (fun (p : P) =>
      Or.elim
      h
      (fun (k : ¬P) => False.elim (k p))
      (fun q => q)
    )
  )


def exportation     : ((P ∧ Q) → R) ↔ (P → Q → R) :=
_

def absurdity       : (P → Q) ∧ (P → ¬Q) → ¬P :=
_

def distribNotAnd   : ¬(P ∧ Q) ↔ (¬P ∨ ¬Q) :=
_

def distribNotOr    : ¬(P ∨ Q) ↔ (¬P ∧ ¬Q) :=
_


/-!
EXTRA CREDIT: apply the axiom of the excluded middle
to give a classical proof of any propositions that you
identified as having no constructive proof. The axiom
is available as Classical.em (p : Prop) : p ∨ ¬p.
-/

#check Classical.em
-- Classical.em (p : Prop) : p ∨ ¬p

/-!
Given nothing but a proposition, excluded middle gives
you a proof of A ∨ ¬A 'for free". By "free" we mean that
you can have a proof of A ∨ ¬A without providing a proof
of either A or of ¬A. We call such a proof of (A ∨ ¬A)
non-constructive.
-/
def pfAorNA (A : Prop) : A ∨ ¬A := Classical.em A


/-!
The next insight you want is that with a proof of A ∨ ¬A,
you can do a case analysis on that disjunction. In one
case, you'll have the assumption A is true (with a proof
(a : A)). In the other case, you'll have the assumption
that ¬A is true (with a proof (na : ¬A)). The other case
assumes ¬A is true, with a proof, (na : ¬A).

In other words, the axiom of the excluded middle forces
every proposition to be either true or false, with no
indeterminate "middle" state where you don't have a proof
either way. (Recall that in the constructive logic of Lean
you can construct a proof of A ∨ ¬A if and only if you have
a proof one way or the other. Now we see why they call it
the "law of the excluded middle." But really it's just an
axiom.

Indeed, excluded middle is one of several non-constructive
axioms that can be added to Lean simply by stating that they
are axioms. Negation elimination, ¬¬A → A, also called proof
by contradiction, is equivalent to excluded middle (can you
prove it), so if you adopt one you get the other as well.

Additional axioms that you might need to include in Lean
for some purposes include the following:

- functional extensionality (simplified), ∀ a, f a = g a → f = g
- propositional extensionality, (P ↔ Q) ↔ P = Q
- choice: Nonempty A → A
-/

#check funext
#check propext
#check Classical.choice

/-!
The first axiom let's you conclude (and have a proof) that two
functions are equal if they return the same results on all of
their inputs. The second let's you replace bi-implication with
equality of propositions, and vice versal.

The third? It requires an understanding that when you construct
a proof of ∃ x, P x, E.g., (Exists.intro 4 (Ev 4)) the value you
provided (here 4) is forgotten. You can never get a specific value
back out of a proof of ∃. This fact mirrors the idea that all that
a proof of an existential proposition tells you is that there is
*some* value out there in the universe that satisifes the given
predicate, but not what it is. What this axiom says is that if
you can provide there's some "witness/value", then you can get
an actual value. To prove some theorems in mathematics, you need
this. The tradeoff is that Lean marks the value as non-computable,
which means you can't actually compute anything with it.

All you need to know for this class is that the axioms of the
excluded middle, and equivalently negation elimination (thus also
proof by contradiction), are not constructive and thus not in the
axioms of the *constructive* logic of Lean. However, you can add
them to the logic without making it inconsistent (introducing any
contradictions) in cases where you want to "reason classically."

So, finally, let's see in Lean what it actually looks like to use
"em" (excluded middle). Remember: from a proposition, A, first use
em to get a proof of A ∨ ¬A, then do case analysis on that proof,
yielding on case where A is true and another case where it's false,
and where there are no other possible states of affairs, e.g., not
having a proof either way.
-/

#check P                -- a proposition
#check Classical.em P   -- a proof of P or ¬P

-- And here's a partial proof showing exactly how to use em
example : P → Q :=
  match (Classical.em P) with
  | Or.inl p =>  _      -- P is true, with p a proof you can use
  | Or.inr np => _      -- P is false, with np a proof you can use

/-!
If you're interested in learning more, you might want to read
https://lean-lang.org/theorem_proving_in_lean4/axioms_and_computation.html
-/