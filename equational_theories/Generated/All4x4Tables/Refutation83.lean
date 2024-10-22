
import Mathlib.Data.Finite.Basic
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[0,2,1,3],[2,0,3,1],[3,1,2,0],[1,3,0,2]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[0,2,1,3],[2,0,3,1],[3,1,2,0],[1,3,0,2]]» : Magma (Fin 4) where
  op := memoFinOp fun x y => [[0,2,1,3],[2,0,3,1],[3,1,2,0],[1,3,0,2]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[0,2,1,3],[2,0,3,1],[3,1,2,0],[1,3,0,2]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [264, 562, 633, 1452, 1793, 3724, 4436] [47, 99, 151, 211, 261, 413, 414, 416, 419, 420, 426, 427, 436, 437, 440, 466, 619, 620, 622, 623, 629, 632, 639, 640, 643, 669, 676, 817, 1023, 1026, 1028, 1035, 1039, 1046, 1048, 1049, 1075, 1082, 1109, 1122, 1223, 1427, 1428, 1429, 1431, 1434, 1435, 1441, 1445, 1451, 1454, 1488, 1515, 1631, 1634, 1637, 1638, 1644, 1648, 1655, 1657, 1691, 1833, 1834, 1837, 1840, 1841, 1847, 1851, 1857, 1858, 1860, 1887, 1894, 1921, 2035, 2238, 2441, 2644, 2847, 3050, 3253, 3456, 3660, 3661, 3662, 3664, 3665, 3667, 3677, 3684, 3712, 3714, 3721, 3725, 3752, 3759, 3862, 4065, 4268, 4269, 4270, 4275, 4283, 4284, 4293, 4314, 4320, 4396, 4398, 4399, 4433, 4435, 4442, 4472, 4473, 4480, 4583, 4584, 4585, 4590, 4598, 4599, 4606, 4608, 4629, 4635, 4636] :=
    ⟨Fin 4, «FinitePoly [[0,2,1,3],[2,0,3,1],[3,1,2,0],[1,3,0,2]]», Finite.of_fintype _, by decideFin!⟩
