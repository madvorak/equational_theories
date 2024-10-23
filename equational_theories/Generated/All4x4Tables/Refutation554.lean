
import Mathlib.Data.Finite.Basic
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[2,0,1,1],[3,1,1,1],[3,2,2,2],[3,3,3,3]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[2,0,1,1],[3,1,1,1],[3,2,2,2],[3,3,3,3]]» : Magma (Fin 4) where
  op := memoFinOp fun x y => [[2,0,1,1],[3,1,1,1],[3,2,2,2],[3,3,3,3]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[2,0,1,1],[3,1,1,1],[3,2,2,2],[3,3,3,3]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [621] [3660, 3862, 4065, 4598, 4599] :=
    ⟨Fin 4, «FinitePoly [[2,0,1,1],[3,1,1,1],[3,2,2,2],[3,3,3,3]]», Finite.of_fintype _, by decideFin!⟩
