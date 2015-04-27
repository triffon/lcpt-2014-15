/* Γ ⊢ M@N : ρ */
/* ⊢(Γ,:(M,ρ)) */
/* i = λ(x,x), k = λ(x,λ(y,x)), s = λ(x,λ(y,λ(z,x@z@(y@z)))) */
/* x@y = @(x,y) */
/* α ⇒ β ⇒ α */
:- set_prolog_flag(occurs_check, true).
:- op(160, fx, ⊢).
:- op(150, xfx, ⊢).
:- op(146, xfx, ≡).
:- op(145, yfx, @@).
:- op(140, xfx, :).
:- op(120, xfy, ⇒).
:- op(100, yfx, @).
:- op(100, xfx, #).

i(λ(x,x)).
k(λ(x,λ(y,x))).
s(λ(x,λ(y,λ(z,x@z@(y@z))))).
f(λ(x,λ(y,x@(y@x)))).
ω(λ(x,x@x)).

/* Γ ⊢ Function : Τ @@ TypedTerms ≡ Result : Σ */
_ ⊢ M : Τ @@ [] ≡ M : Τ.
Γ # V ⊢ M : Ρ ⇒ Σ @@ [ N : Ρ | TypedTerms ] ≡ Term : Τ
                   :- Γ # V ⊢ (M @ N) : Σ @@ TypedTerms ≡ Term : Τ, Γ # V ⊢ N : Ρ.

/* Γ ⊢ M : T */
/* Γ е списък от типови съждения */
/*Γ ⊢ App : Σ          :- member(X : T, Γ), App = X @@ ML, Γ ⊢ M1 : Ρ1, ..., Γ ⊢ Mn : Ρn, T = Ρ1 ⇒ Ρ2 ⇒ … ⇒ Σ*/
_ # V ⊢ _ : Σ           :- member(Σ, V), !, fail. 
Γ # V ⊢ λ(X, M) : Ρ ⇒ Σ :- [ X : Ρ | Γ ] # V ⊢ M : Σ.
Γ # V ⊢ App : Σ          :- member(X : T, Γ), Γ # [ Σ | V ] ⊢ X : T @@ _ ≡ App : Σ.

⊢ M : T  :- [] # [] ⊢ M : T.
