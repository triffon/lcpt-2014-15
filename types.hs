i = \x -> x
k = \x y -> x

type Numeral t = (t -> t) -> (t -> t)
c0 :: Numeral t
c0 = \f x -> x

c1 = \f x -> f x
c2 = \f x -> f (f x)
c3 = \f x -> f (f (f x))

s = \x y z -> x z (y z)

f = \x y -> x (y x)
