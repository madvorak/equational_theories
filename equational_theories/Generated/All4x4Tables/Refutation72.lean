
import Mathlib.Data.Finite.Basic
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[2,2,2,3],[2,3,2,3],[0,1,2,3],[0,1,2,3]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[2,2,2,3],[2,3,2,3],[0,1,2,3],[0,1,2,3]]» : Magma (Fin 4) where
  op := memoFinOp fun x y => [[2,2,2,3],[2,3,2,3],[0,1,2,3],[0,1,2,3]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[2,2,2,3],[2,3,2,3],[0,1,2,3],[0,1,2,3]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [2420, 2536] [3255, 3261, 3271, 3481, 3677, 4131, 4269, 4320] :=
    ⟨Fin 4, «FinitePoly [[2,2,2,3],[2,3,2,3],[0,1,2,3],[0,1,2,3]]», Finite.of_fintype _, by decideFin!⟩
