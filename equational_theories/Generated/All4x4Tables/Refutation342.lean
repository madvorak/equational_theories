
import Mathlib.Data.Finite.Basic
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[2,0,1,3],[3,0,2,1],[2,1,3,0],[0,2,3,1]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[2,0,1,3],[3,0,2,1],[2,1,3,0],[0,2,3,1]]» : Magma (Fin 4) where
  op := memoFinOp fun x y => [[2,0,1,3],[3,0,2,1],[2,1,3,0],[0,2,3,1]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[2,0,1,3],[3,0,2,1],[2,1,3,0],[0,2,3,1]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [2743] [23, 99, 159, 211, 231, 280, 283, 323, 333, 378, 411, 616, 619, 622, 629, 632, 639, 679, 706, 713, 819, 822, 832, 835, 842, 872, 879, 906, 1028, 1035, 1048, 1085, 1109, 1238, 1248, 1251, 1278, 1288, 1322, 1428, 1431, 1441, 1451, 1454, 1478, 1488, 1491, 1515, 1518, 1631, 1634, 1637, 1644, 1681, 1721, 1728, 1834, 1837, 1847, 1857, 1887, 1897, 1924, 1931, 2035, 2240, 2243, 2246, 2253, 2266, 2290, 2300, 2330, 2340, 2443, 2456, 2466, 2469, 2493, 2503, 2506, 2530, 2533, 2543, 2646, 2649, 2652, 2659, 2662, 2669, 2696, 2699, 2746, 2849, 2852, 2855, 2862, 2865, 2872, 2899, 2909, 2912, 2939, 2946, 2949, 3052, 3055, 3065, 3068, 3078, 3105, 3115, 3139, 3149, 3255, 3258, 3268, 3309, 3316, 3343, 3458, 3461, 3464, 3481, 3509, 3512, 3519, 3546, 3661, 3664, 3667, 3674, 3677, 3684, 3712, 3725, 3752, 3759, 3864, 3867, 3870, 3877, 3890, 3918, 3925, 3928, 3952, 4067, 4070, 4090, 4093, 4121, 4128, 4155, 4165, 4269, 4272, 4284, 4291, 4396, 4399, 4406, 4445, 4473, 4480, 4584, 4587, 4590, 4599, 4606] :=
    ⟨Fin 4, «FinitePoly [[2,0,1,3],[3,0,2,1],[2,1,3,0],[0,2,3,1]]», Finite.of_fintype _, by decideFin!⟩
