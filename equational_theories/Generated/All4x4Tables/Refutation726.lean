
import Mathlib.Data.Finite.Basic
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[2,3,0,4,0,10,0,10,0,7,7],[1,5,6,1,8,1,8,8,6,1,6],[2,9,6,2,2,2,2,2,9,2,6],[2,3,3,2,3,9,3,9,3,7,7],[4,5,4,4,8,4,5,8,4,4,4],[2,5,5,2,5,9,5,2,5,5,5],[6,5,6,6,8,6,5,8,6,6,6],[4,3,7,4,5,4,5,8,7,7,7],[8,9,6,8,8,8,8,8,9,8,6],[2,9,9,2,9,9,9,9,9,4,4],[2,9,9,2,10,10,10,10,9,2,6]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[2,3,0,4,0,10,0,10,0,7,7],[1,5,6,1,8,1,8,8,6,1,6],[2,9,6,2,2,2,2,2,9,2,6],[2,3,3,2,3,9,3,9,3,7,7],[4,5,4,4,8,4,5,8,4,4,4],[2,5,5,2,5,9,5,2,5,5,5],[6,5,6,6,8,6,5,8,6,6,6],[4,3,7,4,5,4,5,8,7,7,7],[8,9,6,8,8,8,8,8,9,8,6],[2,9,9,2,9,9,9,9,9,4,4],[2,9,9,2,10,10,10,10,9,2,6]]» : Magma (Fin 11) where
  op := memoFinOp fun x y => [[2,3,0,4,0,10,0,10,0,7,7],[1,5,6,1,8,1,8,8,6,1,6],[2,9,6,2,2,2,2,2,9,2,6],[2,3,3,2,3,9,3,9,3,7,7],[4,5,4,4,8,4,5,8,4,4,4],[2,5,5,2,5,9,5,2,5,5,5],[6,5,6,6,8,6,5,8,6,6,6],[4,3,7,4,5,4,5,8,7,7,7],[8,9,6,8,8,8,8,8,9,8,6],[2,9,9,2,9,9,9,9,9,4,4],[2,9,9,2,10,10,10,10,9,2,6]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[2,3,0,4,0,10,0,10,0,7,7],[1,5,6,1,8,1,8,8,6,1,6],[2,9,6,2,2,2,2,2,9,2,6],[2,3,3,2,3,9,3,9,3,7,7],[4,5,4,4,8,4,5,8,4,4,4],[2,5,5,2,5,9,5,2,5,5,5],[6,5,6,6,8,6,5,8,6,6,6],[4,3,7,4,5,4,5,8,7,7,7],[8,9,6,8,8,8,8,8,9,8,6],[2,9,9,2,9,9,9,9,9,4,4],[2,9,9,2,10,10,10,10,9,2,6]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [854] [105, 108, 360, 361, 414, 426, 427, 429, 436, 437, 439, 440, 819, 820, 846, 1023, 1038, 1048, 1238, 1834, 1847, 1850, 3255, 3935, 4269] :=
    ⟨Fin 11, «FinitePoly [[2,3,0,4,0,10,0,10,0,7,7],[1,5,6,1,8,1,8,8,6,1,6],[2,9,6,2,2,2,2,2,9,2,6],[2,3,3,2,3,9,3,9,3,7,7],[4,5,4,4,8,4,5,8,4,4,4],[2,5,5,2,5,9,5,2,5,5,5],[6,5,6,6,8,6,5,8,6,6,6],[4,3,7,4,5,4,5,8,7,7,7],[8,9,6,8,8,8,8,8,9,8,6],[2,9,9,2,9,9,9,9,9,4,4],[2,9,9,2,10,10,10,10,9,2,6]]», Finite.of_fintype _, by decideFin!⟩
