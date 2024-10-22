
import Mathlib.Data.Finite.Basic
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following refutation as produced by
random generation of polynomials:
'(1 * x**2 + 2 * y**2 + 0 * x + 3 * y + 0 * x * y) % 4' (0, 22, 30, 410, 512, 1628, 1636, 1717, 1730, 1745, 2237, 2245, 2255, 2262, 2292, 2299, 2326, 2339, 2354, 2388, 2401, 2440, 2448, 2458, 2465, 2495, 2502, 2529, 2542, 2557, 2591, 2604, 2643, 2651, 2661, 2668, 2698, 2705, 2732, 2745, 2760, 2794, 2807, 2846, 2854, 2864, 2871, 2901, 2908, 2935, 2948, 2963, 2997, 3010, 3049, 3057, 3067, 3074, 3104, 3111, 3138, 3151, 3166, 3200, 3213, 3455, 3463, 3508, 3521, 3536, 3658, 3683, 3711, 3758, 3819, 3861, 3869, 3879, 3886, 3914, 3927, 3942, 3954, 3961, 3996, 4022, 4064, 4072, 4082, 4089, 4117, 4130, 4145, 4157, 4164, 4199, 4225, 4319, 4361, 4589, 4621, 4634, 4676)
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly x² + 2 * y² + 3 * y % 4» : Magma (Fin 4) where
  op := memoFinOp fun x y => x*x + 2 * y*y + 3 * y

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly x² + 2 * y² + 3 * y % 4» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [31, 513, 2355, 2389, 2402, 2558, 2592, 2808, 2964, 2998, 3011, 3201, 3214, 3943, 4023, 4146, 4200, 4677] [47, 99, 151, 203, 255, 359, 412, 413, 414, 416, 417, 419, 420, 426, 427, 429, 430, 436, 437, 439, 440, 463, 464, 466, 467, 473, 474, 476, 477, 500, 501, 503, 504, 510, 511, 614, 817, 1020, 1223, 1426, 1630, 1631, 1632, 1634, 1635, 1638, 1644, 1645, 1647, 1648, 1654, 1655, 1657, 1658, 1681, 1682, 1684, 1685, 1691, 1692, 1694, 1695, 1719, 1721, 1722, 1728, 1729, 1832, 2035, 2239, 2240, 2241, 2243, 2244, 2247, 2253, 2254, 2257, 2264, 2266, 2267, 2290, 2291, 2294, 2301, 2303, 2304, 2328, 2330, 2331, 2337, 2338, 2442, 2443, 2444, 2446, 2447, 2450, 2456, 2457, 2460, 2467, 2469, 2470, 2493, 2494, 2497, 2504, 2506, 2507, 2531, 2533, 2534, 2540, 2541, 2645, 2646, 2647, 2649, 2650, 2653, 2659, 2660, 2663, 2670, 2672, 2673, 2696, 2697, 2700, 2707, 2709, 2710, 2734, 2736, 2737, 2743, 2744, 2848, 2849, 2850, 2852, 2853, 2856, 2862, 2863, 2866, 2873, 2875, 2876, 2899, 2900, 2903, 2910, 2912, 2913, 2937, 2939, 2940, 2946, 2947, 3051, 3052, 3053, 3055, 3056, 3059, 3065, 3066, 3069, 3076, 3078, 3079, 3102, 3103, 3106, 3113, 3115, 3116, 3140, 3142, 3143, 3149, 3150, 3253, 3457, 3458, 3459, 3461, 3462, 3465, 3472, 3474, 3475, 3481, 3482, 3484, 3511, 3512, 3518, 3519, 3521, 3545, 3546, 3548, 3549, 3555, 3556, 3558, 3660, 3661, 3662, 3664, 3665, 3667, 3668, 3674, 3675, 3677, 3678, 3685, 3687, 3714, 3721, 3722, 3724, 3725, 3748, 3749, 3751, 3752, 3761, 3864, 3865, 3867, 3868, 3871, 3877, 3878, 3881, 3888, 3890, 3917, 3918, 3925, 3927, 3951, 3952, 3954, 3961, 3964, 4066, 4067, 4068, 4070, 4071, 4074, 4080, 4081, 4084, 4091, 4093, 4120, 4121, 4127, 4128, 4130, 4155, 4157, 4164, 4167, 4268, 4269, 4270, 4272, 4273, 4275, 4276, 4283, 4284, 4290, 4291, 4293, 4314, 4321, 4343, 4380, 4583, 4584, 4585, 4587, 4588, 4591, 4598, 4599, 4605, 4606, 4608, 4629, 4636, 4658] :=
    ⟨Fin 4, «FinitePoly x² + 2 * y² + 3 * y % 4», Finite.of_fintype _, by decideFin!⟩
