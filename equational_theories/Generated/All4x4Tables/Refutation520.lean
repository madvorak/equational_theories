import equational_theories.AllEquations
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[0,2,3,1,6,4,5],[1,4,5,2,0,3,6],[2,3,6,4,1,5,0],[3,6,1,5,4,0,2],[4,5,0,3,2,6,1],[5,0,2,6,3,1,4],[6,1,4,0,5,2,3]]
-/
set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[0,2,3,1,6,4,5],[1,4,5,2,0,3,6],[2,3,6,4,1,5,0],[3,6,1,5,4,0,2],[4,5,0,3,2,6,1],[5,0,2,6,3,1,4],[6,1,4,0,5,2,3]]» : Magma (Fin 7) where
  op := memoFinOp fun x y => [[0,2,3,1,6,4,5],[1,4,5,2,0,3,6],[2,3,6,4,1,5,0],[3,6,1,5,4,0,2],[4,5,0,3,2,6,1],[5,0,2,6,3,1,4],[6,1,4,0,5,2,3]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[0,2,3,1,6,4,5],[1,4,5,2,0,3,6],[2,3,6,4,1,5,0],[3,6,1,5,4,0,2],[4,5,0,3,2,6,1],[5,0,2,6,3,1,4],[6,1,4,0,5,2,3]]» :
  ∃ (G : Type) (_ : Magma G), Facts G [1313,1315,1322] [99,104,117,127,138,151,159,166,179,194,411,419,429,436,466,473,500,513,528,562,575,1020,1085,1109,1228,1238,1248,1258,1278,1288,1299,1325,1336,1353,1370,1387,1405,2035,2043,2050,2063,2078,2087,2100,2115,2124,2137,2152,2161,2182,2203,2227,3659,3675,3687,3715,3722,3748,3862,3867,3868,3877,3881,3887,3897,3915,3925,3935,3951,3952,3962,3972,3973,3989,4006,4023,4040,4065,4071,4084,4118,4130,4164,4275,4307,4320,4321,4362,4380,4409,4435,4443,4470,4479,4587,4605,4606,4615,4635,4636,4645,4666,4677,4684,4689] :=
    ⟨Fin 7, «FinitePoly [[0,2,3,1,6,4,5],[1,4,5,2,0,3,6],[2,3,6,4,1,5,0],[3,6,1,5,4,0,2],[4,5,0,3,2,6,1],[5,0,2,6,3,1,4],[6,1,4,0,5,2,3]]», by decideFin!⟩