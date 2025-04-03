import Mathlib.Algebra.DirectSum.Basic
import Mathlib.GroupTheory.FreeGroup.Basic
import Mathlib.Data.ZMod.Defs
import Mathlib.Data.Countable.Defs
import Mathlib.Data.DFinsupp.Encodable

import equational_theories.ForMathlib.GroupTheory.FreeGroup.ReducedWords
import equational_theories.Equations.All
import equational_theories.ManuallyProved.Equation1729.ExtensionTheorem

/- Constructs the small magma SM, basic properties of the additional set N, and sets out the axioms these objects need to satisfy -/

namespace Eq1729

/- SM is the abelian group generated by countably many generators E n of order 4 -/

abbrev SM := DirectSum ℕ (fun _ ↦ ZMod 4)

open AddToMagma -- makes SM a magma automatically

instance SM_countable : Countable SM := by
  convert instCountableDFinsupp
  . infer_instance
  infer_instance

abbrev E (n:ℕ) : SM := (DirectSum.of (fun _ ↦ ZMod 4) n) 1

@[simp]
lemma SM_op_eq_add (a b : SM) : a ◇ b = a + b := rfl

/- The squaring map on SM -/
def S (a : SM) := a ◇ a

@[simp]
lemma S_zero : S 0 = 0 := rfl

@[simp]
lemma SM_square_square_eq_zero (a : SM) : S (S a) = 0 := by
  simp only [S, SM_op_eq_add]
-- when we update Mathlib, one can switch to DirectSum.ext_component, or use the new version of DirectSum.ext
  apply DirectSum.ext ℤ
  intro i
  simp only [map_add, map_zero]
  abel_nf
  exact ZModModule.char_nsmul_eq_zero 4 _

lemma SM_square_eq_double (a : SM) : S a = a + a := rfl

lemma SM_obeys_1729 : Equation1729 SM := by
  intro x y
  simp only [SM_op_eq_add]
  abel_nf
-- when we update Mathlib, one can switch to DirectSum.ext_component, or use the new version of DirectSum.ext
  apply DirectSum.ext ℤ
  intro i
  simp only [map_add, map_smul, zsmul_eq_mul, Int.cast_ofNat, self_eq_add_left]
  apply zero_mul

def L (a:SM) : SM ≃ SM := {
  toFun := fun x ↦ x + a
  invFun := fun x ↦ x - a
  left_inv := leftInverse_sub_add_left a
  right_inv := by
    intro x
    simp only [sub_add_cancel]
}

def R (a:SM) : SM ≃ SM := L a

/- N is the free group generated by e_a for each a in SM -/

abbrev N := FreeGroup SM

instance N_countable : Countable N := Quotient.countable

abbrev e (a:SM) := FreeGroup.of a

def adjacent (x y : N) := ∃ a, x = (e a) * y ∨ y = (e a) * x

lemma not_adjacent_self (x:N) : ¬ adjacent x x := by
  by_contra this
  simp only [adjacent, self_eq_mul_left, FreeGroup.of_ne_one, or_self, exists_const] at this

/-- Impose an order on N: x ≤ y if x is a right subword of y  (or equivalently, x is on the unique
simple path from 1 to y).  The spelling may not be optimal. -/
instance N_LE : LE N where
  le x y := x.toWord <:+ y.toWord

theorem le_def (x y : N) : (x ≤ y) = (x.toWord <:+ y.toWord) := rfl

instance N_order : PartialOrder N where
  le := N_LE.le
  le_refl _ := List.suffix_rfl
  le_trans _ _ _ := List.IsSuffix.trans
  le_antisymm x y hxy hyx := FreeGroup.toWord_injective <|
    List.IsSuffix.eq_of_length_le hxy (List.IsSuffix.length_le hyx)

instance : LocallyFiniteOrderBot N := LocallyFiniteOrderBot.ofIic
  (finsetIic := fun x => (List.map (FreeGroup.mk) x.toWord.tails).toFinset)
  (mem_Iic := fun a x => by
    simp only [List.mem_toFinset, List.mem_map, List.mem_tails, le_def]
    constructor
    · rintro ⟨a, h, eq⟩
      rw [← eq, FreeGroup.toWord_mk, FreeGroup.Red.reduced_iff_eq_reduce.mp]
      · exact h
      · exact FreeGroup.Red.reduced_infix (FreeGroup.reduced_toWord) h.isInfix
    · intro h
      use x.toWord
      simp [h, FreeGroup.mk_toWord])

/-- the parent of x is defined to be the unique element adjacent to x whose reduced word is shorter, with the junk convention that the parent of the identity is itself -/
def parent (x : N) : N := FreeGroup.mk x.toWord.tail

theorem parent_toWord (x : N) : (parent x).toWord = x.toWord.tail := by
  rw [parent, FreeGroup.toWord_mk, FreeGroup.Red.reduced_iff_eq_reduce.mp]
  exact FreeGroup.Red.reduced_infix (FreeGroup.reduced_toWord) (List.tail_suffix _).isInfix

@[simp]
lemma parent_one : parent 1 = 1 := by
  simp only [parent, FreeGroup.toWord_one, List.tail_nil]
  rfl

theorem parent_le (x : N) : parent x ≤ x := by
  rw [le_def, parent_toWord]
  exact List.tail_suffix _

theorem lt_iff_le_parent {x y : N} (h : y ≠ 1) : x < y ↔ x ≤ parent y := by
  rw [lt_iff_le_and_ne, le_def, le_def, parent_toWord]
  cases h' : y.toWord
  case nil =>
    simp only [List.suffix_nil, FreeGroup.toWord_eq_nil_iff, ne_eq, List.tail_nil,
    and_iff_left_iff_imp]
    intro eq1 eq2
    exact h (eq2 ▸ eq1)
  case cons head tail =>
    simp only [List.tail_cons, List.suffix_cons_iff]
    constructor
    · rintro ⟨(eq | h'), ineq⟩
      · exfalso
        apply ineq
        apply FreeGroup.toWord_injective
        rw [eq, h']
      · assumption
    · intro h''
      constructor
      · right
        exact h''
      · intro eq'
        rw [eq', h'] at h''
        simpa using h''.length_le

instance : OrderBot N where
  bot := 1
  bot_le x := by simp [le_def]

theorem bot_eq_one : (⊥ : N) = 1 := rfl

instance : PredOrder N where
  pred := parent
  pred_le := parent_le
  min_of_le_pred hap := by
    rw [isMin_iff_eq_bot]
    rw [le_def, parent_toWord] at hap
    have := hap.length_le
    simp only [List.length_tail] at this
    rw [bot_eq_one, ← FreeGroup.toWord_eq_nil_iff, ← List.length_eq_zero]
    omega
  le_pred_of_lt {a} {b} hab := (lt_iff_le_parent hab.ne_bot).mp hab

theorem parent_adjacent {x : N} (h : x ≠ 1) : adjacent x (parent x) := by
  cases h' : x.toWord
  case nil =>
    simp only [FreeGroup.toWord_eq_nil_iff] at h'
    exact (h h').elim
  case cons head tail =>
    have eq : x = FreeGroup.mk [head] * parent x := by
      rw [← FreeGroup.mk_toWord (x := parent x), parent_toWord, h', ← FreeGroup.mk_toWord (x := x),
      h']
      rfl
    nth_rw 1 [eq]
    rcases head with ⟨a,⟨⟩⟩
    · use a
      right
      have eq_inv : FreeGroup.mk [(a, false)] = (e a)⁻¹ := by
        simp only [e, FreeGroup.of, FreeGroup.inv_mk]
        rfl
      simp [eq_inv]
    · use a
      left
      rfl

theorem parent_lt {x : N} (h : x ≠ 1) : parent x < x := by
  rw [lt_iff_le_and_ne]
  constructor
  . exact parent_le x
  . intro eq
    have := parent_adjacent h
    rw [eq] at this
    exact not_adjacent_self x this

theorem adjacent_comm (x y : N) : adjacent x y ↔ adjacent y x := exists_congr (by tauto)

theorem parent_of_adjacent {x y : N} (h : adjacent x y) : x = parent y ∨ y = parent x := by
  obtain ⟨a, h⟩ := h
  wlog l : x = e a * y generalizing x y
  · rcases h with h | h
    · tauto
    exact or_comm.mp (this (.inl h) h)
  cases h : y.toWord
  case nil =>
    right
    simp only [FreeGroup.toWord_eq_nil_iff] at h
    rw [l,h]
    simp only [parent, mul_one, FreeGroup.toWord_of, List.tail_cons]
    rfl
  case cons head tail =>
    by_cases eq : head = ⟨a, false⟩
    · left
      have eq' : y = FreeGroup.mk [head] * parent y := by
        rw [← FreeGroup.mk_toWord (x := parent y), parent_toWord, h, ← FreeGroup.mk_toWord (x := y),
        h]
        rfl
      rw [l]
      nth_rw 1 [eq']
      have eq_inv : FreeGroup.mk [head] = (e a)⁻¹ := by
        simp only [eq, e, FreeGroup.of, FreeGroup.inv_mk]
        rfl
      simp [eq_inv]
    · right
      have eq' : x.toWord = (a, true) :: y.toWord := by
        rw [l, FreeGroup.toWord_mul, FreeGroup.Red.reduced_iff_eq_reduce.mp]
        · rfl
        · rw [h]
          apply FreeGroup.Red.reduced_cons.mpr
          rw [← h]
          simp only [FreeGroup.reduced_toWord, and_true]
          cases head
          simp only [Bool.not_true, Bool.false_eq, not_and, Bool.not_eq_false]
          intro eq'
          simpa [eq'] using eq
      apply FreeGroup.toWord_injective
      simp [parent_toWord, eq']



/- Right-multiplication by an element of SM on N is defined via the group action. -/

def R' (a:SM) : N ≃ N := {
  toFun := fun x ↦ (e a) * x
  invFun := fun x ↦ (e a)⁻¹ * x
  left_inv := by
    intro x
    simp only [inv_mul_cancel_left]
  right_inv := by
    intro x
    simp only [mul_inv_cancel_left]
}

lemma R'_axiom_iia (a b : SM) (y:N) (h: a ≠ b): R' a y ≠ R' b y := by
  contrapose! h
  simp only [R', Equiv.coe_fn_mk, mul_left_inj] at h
  exact FreeGroup.of_injective h

lemma R'_axiom_iib (a : SM) (y:N) : R' a y ≠ y := by
  by_contra! h
  simp only [R', Equiv.coe_fn_mk, mul_left_eq_self, FreeGroup.of_ne_one] at h

lemma R'_adjacent (a : SM) (y:N) : adjacent y (R' a y) := by
  use a
  simp only [R', Equiv.coe_fn_mk, or_true]


/- Now we rewrite the axioms using a single transformation L₀' instead of many transformations L' -/

/- Not sure if this is the best spelling for this axiom -/
def axiom_i' (L₀' : N → N) : Prop := L₀' ∘ L₀' = (R' 0).symm

lemma L₀'_R'0_L₀'_eq_id {L₀' : N → N} (h: axiom_i' L₀') : L₀' ∘ R' 0 ∘ L₀' = id := by
  unfold axiom_i' at h
  calc
    _ = L₀' ∘ R' 0 ∘ L₀' ∘ ((L₀' ∘ L₀') ∘ R' 0) := by aesop
    _ = (L₀' ∘ (R' 0 ∘ (L₀' ∘ L₀')) ∘ L₀') ∘ R' 0 := rfl
    _ = _ := by simp only [h, Equiv.self_comp_symm, CompTriple.comp_eq, Equiv.symm_comp_self]

def L' {L₀' : N → N} (h: axiom_i' L₀') (a:SM) : N ≃ N := {
  toFun := (R' a).symm ∘ L₀' ∘  R' (S a)
  invFun := (R' (S a)).symm ∘ L₀' ∘ (R' 0) ∘  (R' a)
  left_inv := by
    rw [Function.leftInverse_iff_comp]
    calc
      _ = (R' (S a)).symm ∘ L₀' ∘ R' 0 ∘ (R' a ∘ (R' a).symm) ∘ L₀' ∘ R' (S a) := rfl
      _ = (R' (S a)).symm ∘ (L₀' ∘ R' 0 ∘ L₀') ∘ R' (S a) := by aesop
      _ = _ := by simp only [L₀'_R'0_L₀'_eq_id h, CompTriple.comp_eq, Equiv.symm_comp_self]
  right_inv := by
    unfold axiom_i' at h
    rw [Function.rightInverse_iff_comp]
    calc
      _ = (R' a).symm ∘ ((L₀' ∘ (R' (S a) ∘ (R' (S a)).symm) ∘ L₀') ∘ R' 0) ∘ R' a := rfl
      _ = _ := by simp only [Equiv.self_comp_symm, CompTriple.comp_eq, h, Equiv.symm_comp_self]
}

lemma L'_0_eq_L₀' {L₀' : N → N} (h: axiom_i' L₀') : L' h 0 = L₀' := by
  unfold L'
  unfold axiom_i' at h
  simp only [← h, SM_square_eq_double, add_zero, Equiv.coe_fn_mk]
  rw [Function.comp_assoc, <- Function.comp_assoc _ _ (R' 0), h]
  simp only [Equiv.symm_comp_self, CompTriple.comp_eq]

abbrev M := SM ⊕ N

variable (f g h : ℕ → ℕ)

example : ℕ := f $ g $ h 0

abbrev axiom_iii' (S': N → SM) (L₀' : N → N)  := ∀ (a : SM) (x y : N), R' a x = y → ((R' (S' y)).symm $ L₀' $ R' (S (S' y)) $ (R' (a - S' x)).symm $ L₀' $ R' (S (a - S' x)) y) = x

abbrev axiom_iv' (S': N → SM) (L₀' : N → N) := ∀ x : N, ((R' (S' x)).symm $ L₀' $ R' (S (S' x)) $ (R' (S' x)).symm $ L₀' $ R' (S (S' x)) $ x) = x

abbrev axiom_v (S': N → SM) (op: N → N → M) := ∀ x : N, op x x = Sum.inl (S' x)

abbrev axiom_vi' (S': N → SM) (op: N → N → M) := ∀ (y : N) (a : SM), op (R' a y) y = Sum.inl (a - S' y)

abbrev axiom_vii' (S': N → SM) (L₀' : N → N) (op: N → N → M) := ∀ x y : N, x ≠ y → (∀ a : SM, x ≠ R' a y) → ∃ z : N, op x y = Sum.inr z ∧ op z x = Sum.inr ((R' (S (S' x))).symm $ L₀' $ R' 0 $ R' (S' x) $ y)

lemma reduce_to_new_axioms {S': N → SM} {L₀' : N → N} {op: N → N → M} (h_i': axiom_i' L₀') (h_iii': axiom_iii' S' L₀') (h_iv': axiom_iv' S' L₀') (h_v: axiom_v S' op) (h_vi': axiom_vi' S' op) (h_vii': axiom_vii' S' L₀' op) : ∃ (G: Type) (_: Magma G), Equation1729 G ∧ ¬ Equation817 G := by
  suffices : ExtOpsWithProps SM N
  . exact ⟨ M, extMagmaInst this, ExtMagma_sat_eq1729 this, ExtMagma_unsat_eq817 this ⟩
  exact
   {
    S := S
    L := fun x ↦ (fun y ↦ x ◇ y)
    R := fun x ↦ (fun y ↦ y ◇ x)
    S' := S'
    L' := (fun a ↦ L' h_i' a)
    R' := (fun a ↦ R' a)
    rest_map := op
    squaring_prop_SM := by intros; rfl
    left_map_SM := by intros; rfl
    right_map_SM := by intros; rfl
    sqN_extends_sqM := by intro _; aesop -- this is a tautology
    L_inv := by
      intro a
      exact {
        inv := fun y ↦ y - a
        inv_left := by
          ext y
          simp only [SM_op_eq_add, Function.comp_apply, add_sub_cancel_left, id_eq]
        inv_right := by
          ext y
          simp only [SM_op_eq_add, Function.comp_apply, add_sub_cancel, id_eq]
        bij := sorry -- redundant given the other data
      }
    L'_inv := by
      intro a
      exact {
        inv := (L' h_i' a).symm
        inv_left := Equiv.symm_comp_self _
        inv_right := Equiv.self_comp_symm _
        bij := sorry -- redundant given the other data
      }
    R_inv := by
      intro a
      exact {
        inv := fun y ↦ y - a
        inv_left := by
          ext y
          simp only [SM_op_eq_add, Function.comp_apply, add_sub_cancel_right, id_eq]
        inv_right := by
          ext y
          simp only [SM_op_eq_add, Function.comp_apply, sub_add_cancel, id_eq]
        bij := sorry -- redundant given the other data
      }
    R'_inv := by
      intro a
      exact {
        inv := (R' a).symm
        inv_left := Equiv.symm_comp_self _
        inv_right := Equiv.self_comp_symm _
        bij := sorry -- redundant given the other data
      }
    SM_sat_1729 := SM_obeys_1729
    axiom_1 := by
      intro a
      simp only [L', SM_square_square_eq_zero, Equiv.coe_fn_mk]
      calc
        _ = (R' (S a)).symm ∘ (L₀' ∘ (R' 0) ∘ ((R' a) ∘ (R' a).symm) ∘ L₀') ∘ (R' (S a))  := rfl
        _ = _ := by simp [L₀'_R'0_L₀'_eq_id h_i']
    axiom_21 := by
      intro a b y h
      simp only [ne_eq, R'_axiom_iia a b y h, not_false_eq_true]
    axiom_22 := by
      intro a x
      simp only [ne_eq, R'_axiom_iib a x, not_false_eq_true]
    axiom_3 := by
      intro x y a h
      simp only [L', Equiv.coe_fn_mk, Function.comp_apply, h_iii' a x y h]
    axiom_4 := by
      intro x
      simp only [L', Equiv.coe_fn_mk, Function.comp_apply, h_iv' x]
    axiom_5 := by
      intro x
      simp [L', h_v x]
    axiom_6 := by
      intro y a
      simp [L', h_vi' y a]
   }

-- Remark: a lot of the definitions and API below could be restated more abstractly using the quotient space construction on groups.  This might be worth doing in order to locate some further contributions to Mathlib in this area.

instance rel : Setoid N := {
  r := fun x y => ∃ n : ℤ, y = (e 0)^n * x
  iseqv := by
    constructor
    . intro x
      use 0
      simp only [zpow_zero, one_mul]
    . intro x y ⟨ n, h1 ⟩
      use -n
      rw [h1, <-mul_assoc, ←zpow_add, neg_add_cancel, zpow_zero, one_mul]
    . intro x y z ⟨ n, h1 ⟩ ⟨ m, h2 ⟩
      use n+m
      rw [h2, h1, <-mul_assoc, add_comm, zpow_add]
}

lemma rel_iff (x y:N): x ≈ y ↔ ∃ n : ℤ, y = (e 0)^n * x := by rfl

lemma rel_def {x y:N} (h: x ≈ y) : ∃ n : ℤ, y = (e 0)^n * x := (rel_iff x y).mp h

lemma rel_of_mul (x:N) (n:ℤ) : x ≈ (e 0)^n * x := by
  use n

lemma rel_of_R0 (x:N) : x ≈ R' 0 x := rel_of_mul x 1


/-- `fill D` is the set of elements of the form (e 0)^n x with x in D and n an integer. -/

def fill (D: Finset N) : Set N := { y | ∃ x, x ≈ y ∧ x ∈ D }

@[simp]
lemma fill_empty : fill Finset.empty = ∅ := by
  ext y
  simp [fill, Set.mem_setOf_eq, Set.mem_empty_iff_false, iff_false, not_exists, not_and]
  intro _ _
  exact Finset.not_mem_empty _

lemma fill_mono {D₁ D₂ : Finset N} (h : D₁ ⊆ D₂) : fill D₁ ⊆ fill D₂ := by
  intro y hy
  rcases hy with ⟨x, hx, hD⟩
  exact ⟨x, hx, h hD⟩

@[simp]
lemma fill_union {D₁ D₂ : Finset N} : fill (D₁ ∪ D₂) = (fill D₁) ∪ (fill D₂) := by
  ext y
  simp [fill]
  aesop

lemma fill_invar (D: Finset N) {x y : N} (h : x ≈ y) : x ∈ fill D ↔ y ∈ fill D := by
  constructor
  . intro h
    simp only [fill, Set.mem_setOf_eq] at h ⊢
    obtain ⟨ z, hz, hD ⟩ := h
    exact ⟨ z, Setoid.trans hz h, hD ⟩
  intro h
  simp only [fill, Set.mem_setOf_eq] at h ⊢
  obtain ⟨ z, hz, hD ⟩ := h
  exact ⟨ z, Setoid.trans hz (Setoid.symm h), hD ⟩

@[simp]
lemma fill_invar' (D: Finset N) (x:N) (n:ℤ) : (e 0)^n * x ∈ fill D ↔ x ∈ fill D := (fill_invar D (rel_of_mul x n)).symm

lemma subset_fill (D: Finset N) : D.toSet ⊆ fill D := by
  intro x hx
  simp only [fill, Set.mem_setOf_eq]
  exact ⟨ x, Setoid.refl x, hx ⟩

lemma mem_fill {D: Finset N} {x:N} (hx: x ∈ D) : x ∈ fill D :=  subset_fill D hx

@[simp]
lemma R0_mem_fill_iff (D: Finset N) (x:N) : R' 0 x ∈ fill D ↔ x ∈ fill D := (fill_invar D (rel_of_R0 x)).symm






-- `generators A` are all the indices in ℕ involved in a finite set `A` of elements of `SM`
abbrev generators (A : Finset SM) : Finset ℕ := A.biUnion DFinsupp.support ∪ {0}

lemma generators_mono {A B : Finset SM} (h: A ⊆ B) : generators A ⊆ generators B := by
  unfold generators
  gcongr
  exact Finset.biUnion_subset_biUnion_of_subset_left DFinsupp.support h

/-- For Mathlib? -/
lemma Finset.biUnion_union {α : Type*} {β : Type*} {s s' : Finset α} {t : α → Finset β} [DecidableEq β] [DecidableEq α]  :
(s ∪ s').biUnion t = (s.biUnion t) ∪ (s'.biUnion t) := by
  ext _
  simp only [Finset.mem_biUnion, Finset.mem_union]
  aesop

lemma generators_union (A B : Finset SM) : generators (A ∪ B) = generators A ∪ generators B := calc
  _ = A.biUnion DFinsupp.support ∪ B.biUnion DFinsupp.support ∪ ({0} ∪ {0}) := by
    simp [generators]
    rw [←Finset.union_assoc]
    congr 1
    exact Finset.biUnion_union
  _ = (A.biUnion DFinsupp.support ∪ {0}) ∪ (B.biUnion DFinsupp.support ∪ {0}) := by ac_rfl
  _ = _ := rfl

abbrev in_generators (A : Finset SM) (a : SM) := a.support ⊆ generators A

lemma zero_in_generators (A : Finset SM): 0 ∈ generators A := Finset.mem_union_right _ (Finset.mem_singleton.mpr rfl)

lemma zero_in_generators' (A : Finset SM): in_generators A 0 := Finset.inter_eq_left.mp rfl

lemma generators_subset_iff {A B : Finset SM} : generators A ⊆ generators B ↔ ∀ a ∈ A, in_generators B a := by
  constructor
  . intro h a ha n hn
    exact h $ Finset.mem_union_left _ $ Finset.subset_biUnion_of_mem DFinsupp.support ha hn
  intro h n hn
  simp only [generators, Finset.mem_union,
    Finset.mem_singleton, Finset.mem_biUnion] at hn
  rcases hn with ⟨ a, ha, han ⟩ | hn
  . exact h a ha han
  rw [hn]
  exact zero_in_generators B

@[simp]
lemma support_E (d:ℕ) : (E d).support = {d} := by
  rw [DirectSum.support_of]
  exact Ne.symm (ne_of_beq_false rfl)

lemma E_in_generators {A : Finset SM} {d: ℕ} (h: d ∈ generators A) : in_generators A (E d) := by
  rwa [in_generators, support_E, Finset.singleton_subset_iff]

@[simp]
lemma E_in_generators_iff (A:Finset SM) (d: ℕ) :  in_generators A (E d) ↔ d ∈ generators A := by
  constructor
  . intro h
    rwa [in_generators, support_E, Finset.singleton_subset_iff] at h
  exact E_in_generators


lemma not_in_generators {A : Finset SM} {a : SM} (h: in_generators A a) {n:ℕ} (hn: ¬ n ∈ generators A): a n = 0 := by
  contrapose! hn
  rw [← DFinsupp.mem_support_toFun] at hn
  exact Finset.mem_of_subset h hn

lemma generators_nonempty (A : Finset SM): (generators A).Nonempty := ⟨ 0, zero_in_generators A ⟩

lemma mem_in_generators {A : Finset SM} {a : SM} (h: a ∈ A) : in_generators A a := by
  exact (Finset.subset_biUnion_of_mem _ h).trans Finset.subset_union_left

lemma sum_in_generators {A : Finset SM} {a b : SM} (ha: in_generators A a) (hb: in_generators A b) : in_generators A (a+b) := by
  intro n hn
  simp only [DFinsupp.mem_support_toFun, DirectSum.add_apply, ne_eq] at hn
  contrapose! hn
  simp only [not_in_generators ha hn, not_in_generators hb hn, add_zero]

lemma S_in_generators {A : Finset SM} {a : SM} (ha: in_generators A a) : in_generators A (S a) := sum_in_generators ha ha

lemma diff_in_generators {A : Finset SM} {a b : SM} (ha: in_generators A a) (hb: in_generators A b) : in_generators A (a-b) := by
  intro n hn
  simp only [DFinsupp.mem_support_toFun, DirectSum.sub_apply, ne_eq] at hn
  contrapose! hn
  simp only [not_in_generators ha hn, not_in_generators hb hn, sub_zero]

-- a fresh generator that does not appear in A
abbrev fresh (A: Finset SM) (n:ℕ) : ℕ := ((generators A).max' (generators_nonempty A)) + (n + 1)

lemma fresh_ne_fresh (A: Finset SM) (n m:ℕ) (h: n ≠ m) : fresh A n ≠ fresh A m := by
  contrapose! h
  rwa [add_right_inj, add_left_inj] at h

lemma fresh_ne_generator (A: Finset SM) (n:ℕ) : ¬ (fresh A n) ∈ generators A := by
  by_contra! h
  linarith [Finset.le_max' _ _ h]

lemma fresh_not_in_generators (A: Finset SM) (n:ℕ) : ¬ in_generators A (E (fresh A n)) := by
  simp only [in_generators, support_E, Finset.singleton_subset_iff]
  exact fresh_ne_generator A n

lemma fresh_injective (A: Finset SM) : Function.Injective (fresh A) := by
  intros n m h
  unfold fresh at h
  linarith

abbrev basis_elements (x:N) : Finset SM := Finset.image (fun (a, _) ↦ a) x.toWord.toFinset ∪ {0}

abbrev basis_elements' (x:M) : Finset SM := match x with
  | Sum.inl a => {a}
  | Sum.inr x => basis_elements x

@[simp]
lemma basis_elements_of_id : basis_elements 1 = {0} := by
  simp only [Finset.union_eq_right, FreeGroup.toWord_one, List.toFinset_nil, Finset.image_empty,
    Finset.subset_singleton_iff, true_or]

@[simp]
lemma basis_elements_of_generator (a: SM) : basis_elements (e a) = {a,0} := by
  simp only [basis_elements, FreeGroup.toWord_of, List.toFinset_cons, List.toFinset_nil,
    insert_emptyc_eq, Finset.image_singleton]
  rfl

/-- For Mathlib? -/
lemma List.replicate_toFinset {α : Type*} [DecidableEq α] (a : α) {n : Nat} (hn: n ≠ 0) : (List.replicate n a).toFinset = {a} := by
  ext _
  simp only [List.mem_toFinset, List.mem_replicate, ne_eq, hn, not_false_eq_true, true_and,
    Finset.mem_singleton]

@[simp]
lemma basis_elements_of_generator_pow (a: SM) {n:ℕ} (hn: n ≠  0): basis_elements ((e a)^n) = {a,0} := by
  unfold basis_elements
  classical
  simp only [FreeGroup.toWord_of_pow, List.replicate_toFinset (a,true) hn]
  change Finset.image (fun x ↦ x.1) {(a,true)} ∪ {0} = {a} ∪ {0}
  congr

/-- For mathlib? -/
@[simp]
theorem FreeGroup.mk_of_single_true {α : Type* } (a : α) : FreeGroup.mk [(a,true)] = FreeGroup.of a := rfl

/-- For mathlib? -/
@[simp]
theorem FreeGroup.mk_of_single_false {α : Type*} (a : α) : FreeGroup.mk [(a,false)] = (FreeGroup.of a)⁻¹  := rfl

lemma basis_elements_of_prod_gen (a b:SM) : a ∈ basis_elements ((e b)⁻¹ * (e a)^2) := by
  by_cases h : b = a
  . rw [← h]
    group
    simp only [basis_elements_of_generator, Finset.mem_insert, Finset.mem_singleton, true_or]
  simp only [basis_elements, Finset.mem_union, Finset.mem_image, List.mem_toFinset, Prod.exists,
    exists_and_right, Bool.exists_bool, exists_eq_right, Finset.mem_singleton]
  left; right
  have : (e b)⁻¹ * (e a)^2  = FreeGroup.mk ([(b, false)] ++ [(a,true)] ++ [(a,true)]) := by
    simp only [← FreeGroup.mul_mk, FreeGroup.mk_of_single_true, FreeGroup.mk_of_single_false, e]
    rw [mul_assoc]
    congr
-- weirdly, the simp below breaks when using the recommend simp?
  simp [this, h]

lemma div_eq (a b : SM) : (e b)⁻¹ * (e a)  = FreeGroup.mk ([(b, false)] ++ [(a,true)]) := by
    simp only [← FreeGroup.mul_mk, FreeGroup.mk_of_single_true, FreeGroup.mk_of_single_false, e]

lemma square_mul (a b : SM) : (e b) * (e a)^2 = FreeGroup.mk ([(b, true)] ++ [(a,true)] ++ [(a,true)]) := by
    simp only [← FreeGroup.mul_mk, FreeGroup.mk_of_single_true,  e]
    rw [mul_assoc]
    congr

lemma basis_elements_of_prod_gen' (a b:SM) : a ∈ basis_elements ((e b) * (e a)^2) := by
  by_cases h : b = a
  . rw [← h]
    group
    change b ∈ basis_elements (e b ^ (3:ℕ))
    have : 3 ≠ 0 := by norm_num
    simp only [basis_elements_of_generator_pow b this, Finset.mem_insert, Finset.mem_singleton, true_or]
  simp only [basis_elements, Finset.mem_union, Finset.mem_image, List.mem_toFinset, Prod.exists,
    exists_and_right, Bool.exists_bool, exists_eq_right, Finset.mem_singleton]
  left; right
  simp [square_mul a b, h]

lemma FreeGroup.div_ne_square (a b c:SM) : (e b)⁻¹ * (e a) ≠ (e c)^2 := by
  by_contra h
  apply_fun (fun x ↦ x.toWord) at h
  rw [div_eq a b] at h
  simp only [List.singleton_append, FreeGroup.toWord_mk, FreeGroup.reduce.cons, Bool.true_eq,
    Bool.not_eq_eq_eq_not, Bool.not_true, Bool.false_eq, Bool.not_false, FreeGroup.reduce_nil,
    and_true, e, FreeGroup.toWord_of_pow, List.reduceReplicate] at h
  by_cases h1 : b=a
  . simp only [h1, ↓reduceIte, List.nil_eq, reduceCtorEq] at h
  simp only [h1, ↓reduceIte, List.cons.injEq, Prod.mk.injEq, Bool.false_eq_true, and_false,
    and_true, false_and] at h


lemma FreeGroup.div_ne_square_mul (a b c d:SM) : (e b)⁻¹ * (e a) ≠ (e d) * (e c)^2 := by
  by_contra h
  rw [square_mul c d, div_eq a b] at h
  apply_fun (fun x ↦ x.toWord) at h
  simp at h
  by_cases h1 : b = a
  . simp only [h1, ↓reduceIte, List.nil_eq, reduceCtorEq] at h
  simp only [h1, ↓reduceIte, List.cons.injEq, Prod.mk.injEq, Bool.false_eq_true, and_false,
    and_true, List.ne_cons_self, and_self] at h


lemma basis_elements_of_mul (x y:N): basis_elements (x * y) ⊆ basis_elements x ∪ basis_elements y := by
  unfold basis_elements
  simp only [Finset.union_assoc]
  rw [Finset.union_comm {0} _, Finset.union_assoc, Finset.union_idempotent, ← Finset.union_assoc, ← Finset.image_union]
  gcongr
  apply Finset.image_subset_image
  intro n hn
  simp at hn ⊢
  replace hn := List.Sublist.mem hn (FreeGroup.toWord_mul_sublist x y)
  rwa [List.mem_append] at hn

/-- For Mathlib? -/
@[simp]
lemma List.toFinset_map {α β: Type*} [DecidableEq α] [DecidableEq β] (l: List α) (f : α → β) : (List.map f l).toFinset = Finset.image f l.toFinset := by
  ext a
  simp_all only [List.mem_toFinset, List.mem_map, Finset.mem_image]


@[simp]
lemma basis_elements_of_inv (x:N) : basis_elements x⁻¹ = basis_elements x := by
  unfold basis_elements
  congr 1
  simp only [FreeGroup.toWord_inv, FreeGroup.invRev, List.toFinset_reverse, List.toFinset_map, Finset.image_image]
  congr

@[simp]
lemma basis_elements_of_genzero_pow' (n: ℕ) : basis_elements ((e 0)^n) = {0} := by
  unfold basis_elements
  classical
  simp only [FreeGroup.toWord_of_pow, Finset.union_eq_right, Finset.subset_singleton_iff,
    Finset.image_eq_empty, List.toFinset_eq_empty_iff, List.replicate_eq_nil_iff]
  rw [Decidable.or_iff_not_imp_left]
  intro hn
  ext m
  simp only [Finset.mem_image, List.mem_toFinset, List.mem_replicate, ne_eq, hn, not_false_eq_true,
    true_and, eq_comm, exists_eq_left, Finset.mem_singleton]

@[simp]
lemma basis_elements_of_genzero_pow (n: ℤ) : basis_elements ((e 0)^n) = {0} := match n with
 | Int.ofNat m => by
    simp only [Int.ofNat_eq_coe, zpow_natCast, basis_elements_of_genzero_pow']
 | Int.negSucc m => by
    rw [Int.negSucc_coe, zpow_neg, basis_elements_of_inv, zpow_natCast, basis_elements_of_genzero_pow']

lemma basis_elements_of_rel' {x y:N} (h: x ≈ y) : basis_elements x ⊆ basis_elements y := by
  obtain ⟨ n, hn ⟩ := rel_def (Setoid.symm h)
  rw [hn]
  apply (basis_elements_of_mul _ _).trans
  rw [basis_elements_of_genzero_pow]
  simp only [Finset.union_subset_iff, Finset.subset_union_right, subset_refl, and_self]

lemma basis_elements_of_rel {x y:N} (h: x ≈ y) : basis_elements x = basis_elements y := by
  ext a
  constructor
  . intro h2
    exact basis_elements_of_rel' h h2
  intro h2
  exact basis_elements_of_rel' (Setoid.symm h) h2

end Eq1729
