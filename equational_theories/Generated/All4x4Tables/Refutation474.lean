
import Mathlib.Data.Finite.Basic
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[0,2,3,4,1],[1,4,0,3,2],[2,3,1,0,4],[3,1,4,2,0],[4,0,2,1,3]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[0,2,3,4,1],[1,4,0,3,2],[2,3,1,0,4],[3,1,4,2,0],[4,0,2,1,3]]» : Magma (Fin 5) where
  op := memoFinOp fun x y => [[0,2,3,4,1],[1,4,0,3,2],[2,3,1,0,4],[3,1,4,2,0],[4,0,2,1,3]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[0,2,3,4,1],[1,4,0,3,2],[2,3,1,0,4],[3,1,4,2,0],[4,0,2,1,3]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [452, 467, 2127, 2134, 2707, 2743, 2903, 2937, 2939] [47, 105, 107, 151, 203, 255, 413, 416, 419, 420, 426, 436, 437, 466, 476, 477, 501, 503, 504, 511, 614, 817, 1020, 1223, 1426, 1629, 1832, 2036, 2037, 2038, 2040, 2041, 2043, 2044, 2050, 2060, 2063, 2087, 2091, 2124, 2125, 2128, 2238, 2441, 2646, 2647, 2650, 2652, 2659, 2660, 2662, 2669, 2670, 2672, 2697, 2700, 2709, 2710, 2736, 2744, 2746, 2849, 2852, 2853, 2855, 2863, 2865, 2866, 2872, 2873, 2875, 2900, 2902, 2910, 2912, 2940, 2946, 2947, 2949, 3050, 3253, 3456, 3659, 3862, 4065, 4268, 4269, 4270, 4272, 4275, 4276, 4283, 4284, 4290, 4291, 4293, 4314, 4320, 4321, 4380, 4583, 4584, 4585, 4587, 4588, 4590, 4599, 4605, 4606, 4608, 4629, 4635, 4636, 4658] :=
    ⟨Fin 5, «FinitePoly [[0,2,3,4,1],[1,4,0,3,2],[2,3,1,0,4],[3,1,4,2,0],[4,0,2,1,3]]», Finite.of_fintype _, by decideFin!⟩
