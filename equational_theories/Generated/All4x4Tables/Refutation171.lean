
import Mathlib.Data.Finite.Basic
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[0,0,0,1],[1,1,0,1],[2,0,2,0],[3,3,0,3]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[0,0,0,1],[1,1,0,1],[2,0,2,0],[3,3,0,3]]» : Magma (Fin 4) where
  op := memoFinOp fun x y => [[0,0,0,1],[1,1,0,1],[2,0,2,0],[3,3,0,3]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[0,0,0,1],[1,1,0,1],[2,0,2,0],[3,3,0,3]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [1027] [826, 1029, 1226, 1229, 1232, 1632, 2449, 3459, 3721, 3927, 4120, 4127, 4131, 4472, 4598] :=
    ⟨Fin 4, «FinitePoly [[0,0,0,1],[1,1,0,1],[2,0,2,0],[3,3,0,3]]», Finite.of_fintype _, by decideFin!⟩
