(add-pvar-name "A" (make-arity))
(add-pvar-name "B" (make-arity))
(add-pvar-name "C" (make-arity))

(set-goal (pf "A -> A"))
(assume "u")
(use "u")

(set-goal (pf "A -> B -> A"))
(assume "u")
(assume "v")
(use "u")

(set-goal (pf "A & B -> B & A"))
(assume "u")
(split)
(use "u")
(use "u")

(set-goal (pf "(A -> B -> C) -> (A -> B) -> A -> C"))
(assume "u" "v" "w")
(use "u")
(use "w")
(use "v")
(use "w")

(set-goal (pf "((A ord B) -> bot) -> (A -> bot) & (B -> bot)"))
(assume "u")
(split)

(assume "v")
(use "u")
(intro 0)
(use "v")

(assume "v")
(use "u")
(intro 1)
(use "v")

(set-goal (pf "(A -> bot) & (B -> bot) -> A ord B -> bot"))
(assume "1" "4")
(elim "4")
(use "1")
(use "1")

(add-var-name "x" (py "alpha"))
(add-pvar-name "D" (make-arity (py "alpha")))

(set-goal (pf "ex x (D(x) -> bot) -> all x D(x) -> bot"))
(assume "u" "w")
(ex-elim "u")
(assume "x" "v")
(use "v")
(use "w")

(set-goal (pf "(all x D(x) -> F) -> ex x (D(x) -> F)"))
(assume "u")
(use "Stab")
(assume "v")
(use "u")
(assume "x")
(use "Stab")
(assume "w")
(use "v")
(ex-intro (pt "x"))
(use "w")


