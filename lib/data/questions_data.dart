import '../models/models.dart';

// ─── AUTHENTIC GATE ECE PRACTICE & MOCK QUESTIONS ───────────────────────────
// Rigorously verified with step-by-step mathematical solutions and GATE traps.
const List<GateQuestion> gateQuestions = [

  // ═══════════════════════════════════════════════════════════════════════════
  // 1. NETWORKS & CIRCUIT THEORY
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_net_01',
    topicId: 'networks',
    question: 'In a series RLC resonant circuit, the Quality Factor (Q) is defined as:',
    options: [
      'Q = R / (ω₀L)',
      'Q = (ω₀L) / R = 1 / (ω₀CR)',
      'Q = (ω₀C) / R',
      'Q = R × (ω₀C)',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: In a series RLC circuit at resonance, Q = Reactive Power / Average Power = (I²·ω₀L)/(I²·R) = ω₀L / R = 1 / (ω₀CR) = (1/R)√(L/C).\n\n'
        '📝 [Step-by-Step Calculation]: At resonance, ω₀ = 1/√(LC). Substituting ω₀ into ω₀L/R gives (1/√(LC))·L / R = (1/R)√(L/C).\n\n'
        '⚠️ [GATE Exam Trap]: In parallel RLC circuits, the formula is inverted: Q_parallel = R / (ω₀L) = R√(C/L). Do not confuse series with parallel!\n\n'
        '✅ [Final Verdict]: Option B is the correct and official definition for series RLC.',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_net_02',
    topicId: 'networks',
    question: 'A practical DC voltage source has Thevenin equivalent V_th = 10 V and R_th = 5 Ω. What load resistance R_L absorbs maximum power, and what is that maximum power?',
    options: [
      'R_L = 10 Ω, P_max = 2.5 W',
      'R_L = 5 Ω, P_max = 5.0 W',
      'R_L = 5 Ω, P_max = 2.5 W',
      'R_L = 2.5 Ω, P_max = 10.0 W',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: By the Maximum Power Transfer Theorem, for a resistive source network, maximum power is delivered to the load when R_L = R_th.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. Set R_L = R_th = 5 Ω.\n'
        '2. Current I = V_th / (R_th + R_L) = 10 / (5 + 5) = 1.0 A.\n'
        '3. P_max = I² · R_L = (1.0)² × 5 = 5.0 W (or using P_max = V_th² / (4·R_th) = 100 / (4 × 5) = 100 / 20 = 5.0 W).\n\n'
        '⚠️ [GATE Exam Trap]: Students frequently divide by 2·R_th instead of 4·R_th, or confuse load power with total power delivered by V_th (which is 10 W at 50% efficiency).\n\n'
        '✅ [Final Verdict]: R_L = 5 Ω and P_max = 5.0 W (Option B).',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_net_03',
    topicId: 'networks',
    question: 'In nodal analysis of a planar or non-planar circuit with N principal nodes and no floating voltage sources, how many independent KCL equations are required?',
    options: [
      'N equations',
      'N - 1 equations',
      'N + 1 equations',
      'N/2 equations',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: In nodal analysis, one node is selected as the global reference (ground, 0 V). Each of the remaining (N - 1) nodes has an independent node voltage.\n\n'
        '📝 [Step-by-Step Calculation]: Total nodes = N. Choosing 1 reference node leaves exactly (N - 1) unknown essential node voltages requiring (N - 1) independent KCL equations.\n\n'
        '⚠️ [GATE Exam Trap]: If floating independent/dependent voltage sources exist between two non-reference nodes, a supernode is formed, but the total number of system equations remains (N - 1).\n\n'
        '✅ [Final Verdict]: Exactly N - 1 independent equations (Option B).',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_net_04',
    topicId: 'networks',
    question: 'A capacitor of capacitance C = 100 μF is charged from 0 V to 10 V by a DC current source. The total energy stored in the electric field of the capacitor is:',
    options: [
      '50 mJ',
      '5.0 mJ',
      '10.0 mJ',
      '1.0 mJ',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: The electrostatic energy stored in a linear capacitor is E = (1/2)·C·V².\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'E = 0.5 × (100 × 10⁻⁶ F) × (10 V)² = 0.5 × 10⁻⁴ × 100 = 5 × 10⁻³ J = 5.0 mJ.\n\n'
        '⚠️ [GATE Exam Trap]: Watch the units! 5 × 10⁻³ Joules is 5 mJ, NOT 50 mJ. Also remember that if charged by a constant voltage source, the total energy supplied is C·V² (10 mJ), of which 50% is dissipated as heat in line resistance and 50% is stored in the capacitor.\n\n'
        '✅ [Final Verdict]: Stored energy = 5.0 mJ (Option B).',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_net_05',
    topicId: 'networks',
    question: 'A two-port network is characterized by impedance parameters [Z]. The network is reciprocal if and only if:',
    options: [
      'Z₁₁ = Z₂₂',
      'Z₁₂ = Z₂₁',
      'Z₁₁·Z₂₂ - Z₁₂·Z₂₁ = 1',
      'Z₁₂ = -Z₂₁',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Reciprocity theorem states that the ratio of excitation to response is invariant when the positions of excitation and response are interchanged.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '• In Z-parameters: Reciprocity condition is Z₁₂ = Z₂₁.\n'
        '• Symmetry condition is Z₁₁ = Z₂₂.\n'
        '• In ABCD parameters: Reciprocity is AD - BC = 1; Symmetry is A = D.\n'
        '• In h-parameters: Reciprocity is h₁₂ = -h₂₁; Symmetry is Δh = 1.\n\n'
        '⚠️ [GATE Exam Trap]: Confusing reciprocity (Z₁₂ = Z₂₁) with symmetry (Z₁₁ = Z₂₂) is one of the most common negative mark errors in GATE!\n\n'
        '✅ [Final Verdict]: Z₁₂ = Z₂₁ is the condition for reciprocity (Option B).',
    difficulty: 'Medium',
    year: 2024,
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // 2. SIGNALS & SYSTEMS
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_sig_01',
    topicId: 'signals',
    question: 'A continuous-time signal x(t) = cos(2000πt) + 3·cos(6000πt) is sampled uniformly. The minimum sampling rate (Nyquist rate) required to avoid aliasing is:',
    options: [
      '2000 Hz',
      '3000 Hz',
      '6000 Hz',
      '12000 Hz',
    ],
    correctIndex: 2,
    explanation:
        '🎯 [Concept & Formula]: By the Nyquist-Shannon Sampling Theorem, the minimum sampling frequency to avoid spectral overlap (aliasing) is f_s(min) = 2 · f_max.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. Component 1: ω₁ = 2000π rad/s ➔ f₁ = ω₁ / (2π) = 1000 Hz.\n'
        '2. Component 2: ω₂ = 6000π rad/s ➔ f₂ = ω₂ / (2π) = 3000 Hz.\n'
        '3. Maximum frequency component f_max = 3000 Hz.\n'
        '4. Nyquist rate f_N = 2 × f_max = 2 × 3000 Hz = 6000 Hz.\n\n'
        '⚠️ [GATE Exam Trap]: Do not add the two frequencies (1000 + 3000 = 4000 ➔ 8000 Hz). Nyquist rate depends only on the highest frequency present in the bandlimited signal.\n\n'
        '✅ [Final Verdict]: Minimum sampling frequency = 6000 Hz (Option C).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_sig_02',
    topicId: 'signals',
    question: 'The Laplace transform of x(t) = e^(-2t)·u(t) and its corresponding Region of Convergence (ROC) are:',
    options: [
      '1 / (s - 2), with Re(s) > 2',
      '1 / (s + 2), with Re(s) > -2',
      's / (s + 2), with Re(s) < -2',
      '2 / (s + 2), with Re(s) > 0',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: L{e^(-at)·u(t)} = ∫₀^∞ e^(-at)·e^(-st) dt = ∫₀^∞ e^(-(s+a)t) dt = 1 / (s + a), provided Re(s + a) > 0 ➔ Re(s) > -a.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Here a = 2. Therefore, X(s) = 1 / (s + 2) with ROC: Re(s) > -2 (the right half-plane to the right of pole at s = -2).\n\n'
        '⚠️ [GATE Exam Trap]: An anti-causal signal -e^(-2t)·u(-t) has the exact same algebraic transform 1/(s+2), but with ROC Re(s) < -2. The ROC is indispensable to uniquely specify the signal!\n\n'
        '✅ [Final Verdict]: 1 / (s + 2) with Re(s) > -2 (Option B).',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_sig_03',
    topicId: 'signals',
    question: 'A discrete-time sequence x[n] = aⁿ·u[n]. The Z-transform X(z) and its Region of Convergence (ROC) for a stable, causal system are:',
    options: [
      'X(z) = 1 / (1 - a·z), |z| < |a|',
      'X(z) = z / (z - a), |z| > |a|',
      'X(z) = 1 / (z - a), |z| = |a|',
      'X(z) = z / (z + a), |z| > 1',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: For a causal exponential sequence x[n] = aⁿ·u[n], X(z) = ∑_{n=0}^∞ (a·z⁻¹)ⁿ = 1 / (1 - a·z⁻¹) = z / (z - a).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'The geometric series converges if |a·z⁻¹| < 1 ➔ |z| > |a|. For the system to be BIBO stable, the ROC must include the unit circle (|z| = 1), requiring |a| < 1.\n\n'
        '⚠️ [GATE Exam Trap]: Anti-causal sequence -aⁿ·u[-n-1] has the same expression z/(z-a), but its ROC is |z| < |a|.\n\n'
        '✅ [Final Verdict]: X(z) = z / (z - a) with ROC |z| > |a| (Option B).',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_sig_04',
    topicId: 'signals',
    question: 'The linear convolution of two discrete sequences x[n] of length 5 and h[n] of length 7 results in an output sequence y[n] of length:',
    options: [
      '12',
      '11',
      '35',
      '10',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: If sequence x[n] has length L₁ and sequence h[n] has length L₂, the linear convolution y[n] = x[n] * h[n] has length N = L₁ + L₂ - 1.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'N = 5 + 7 - 1 = 11.\n\n'
        '⚠️ [GATE Exam Trap]: Circular convolution of length N requires N ≥ L₁ + L₂ - 1 to avoid time-domain aliasing when performing convolution via DFT/FFT.\n\n'
        '✅ [Final Verdict]: Length = 11 (Option B).',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_sig_05',
    topicId: 'signals',
    question: 'The continuous Fourier transform of a rectangular pulse x(t) = 1 for |t| ≤ T/2 and 0 elsewhere is:',
    options: [
      'T · sinc(f·T) = T · [sin(πfT) / (πfT)]',
      'sinc(f·T) / T',
      'T² · sinc²(f·T)',
      '(2/T) · cos(ωT/2)',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: F{rect(t/T)} = ∫_{-T/2}^{T/2} 1 · e^(-j2πft) dt = [e^(-j2πft) / (-j2πf)]_{-T/2}^{T/2} = [e^(jπfT) - e^(-jπfT)] / (j2πf) = sin(πfT) / (πf) = T · sinc(fT).\n\n'
        '📝 [Step-by-Step Calculation]: In radian frequency ω: X(jω) = T · sin(ωT/2) / (ωT/2) = T · Sa(ωT/2).\n\n'
        '⚠️ [GATE Exam Trap]: The first zero crossings of the spectrum occur at f = ±1/T (or ω = ±2π/T). The main lobe bandwidth is 2/T Hz.\n\n'
        '✅ [Final Verdict]: T · sinc(fT) (Option A).',
    difficulty: 'Medium',
    year: 2024,
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // 3. ELECTRONIC DEVICES (EDC)
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_dev_01',
    topicId: 'devices',
    question: 'An NPN bipolar junction transistor operates in forward-active mode with β = 100. If the base current I_B = 50 μA, what is the collector current I_C and emitter current I_E?',
    options: [
      'I_C = 500 μA, I_E = 550 μA',
      'I_C = 5.0 mA, I_E = 5.05 mA',
      'I_C = 5.0 mA, I_E = 4.95 mA',
      'I_C = 0.5 mA, I_E = 0.55 mA',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: In forward active mode, I_C = β · I_B and by KCL on the transistor, I_E = I_B + I_C = (1 + β) · I_B.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. I_C = 100 × (50 × 10⁻⁶ A) = 5000 μA = 5.0 mA.\n'
        '2. I_E = I_C + I_B = 5.0 mA + 0.05 mA = 5.05 mA.\n\n'
        '⚠️ [GATE Exam Trap]: Notice that I_E is always strictly greater than I_C in a BJT (I_E = I_C / α, where α = β/(1+β) < 1). Option C is physically impossible.\n\n'
        '✅ [Final Verdict]: I_C = 5.0 mA and I_E = 5.05 mA (Option B).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_dev_02',
    topicId: 'devices',
    question: 'An NMOS transistor has threshold voltage V_th = 1.0 V and process parameter μ_n·C_ox·(W/L) = 1.0 mA/V². If V_GS = 3.0 V and V_DS = 5.0 V, the drain current I_D is:',
    options: [
      '4.0 mA',
      '2.0 mA',
      '1.0 mA',
      '8.0 mA',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: First verify operating region. Overdrive voltage V_ov = V_GS - V_th = 3.0 - 1.0 = 2.0 V. Since V_DS (5.0 V) ≥ V_ov (2.0 V), the MOSFET operates in the SATURATION (pinch-off) region.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Saturation current formula: I_D = (1/2) · [μ_n·C_ox·(W/L)] · (V_GS - V_th)²\n'
        'I_D = 0.5 × (1.0 mA/V²) × (3.0 - 1.0)² = 0.5 × 1.0 × 4.0 = 2.0 mA.\n\n'
        '⚠️ [GATE Exam Trap]: Forgetting the 1/2 factor yields 4.0 mA (Option A), which is the most frequent student error in MOSFET DC calculations!\n\n'
        '✅ [Final Verdict]: I_D = 2.0 mA (Option B).',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_dev_03',
    topicId: 'devices',
    question: 'The built-in potential (contact potential) V_bi of a silicon step p-n junction with N_A = 10¹⁶ cm⁻³ and N_D = 10¹⁶ cm⁻³ at T = 300 K (given n_i = 1.5 × 10¹⁰ cm⁻³ and V_t = 26 mV) is approximately:',
    options: [
      '0.36 V',
      '0.70 V',
      '1.12 V',
      '0.026 V',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: V_bi = V_t · ln[ (N_A · N_D) / n_i² ].\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. (N_A · N_D) / n_i² = (10¹⁶ × 10¹⁶) / (1.5 × 10¹⁰)² = 10³² / (2.25 × 10²⁰) = 4.44 × 10¹¹.\n'
        '2. ln(4.44 × 10¹¹) = ln(4.44) + 11 · ln(10) = 1.49 + 11 × 2.3026 ≈ 1.49 + 25.33 = 26.82.\n'
        '3. V_bi = 0.026 V × 26.82 ≈ 0.697 V ≈ 0.70 V.\n\n'
        '⚠️ [GATE Exam Trap]: 1.12 V is the silicon bandgap energy (E_g = 1.12 eV), not the built-in potential. V_bi can never exceed the bandgap potential E_g/q.\n\n'
        '✅ [Final Verdict]: V_bi ≈ 0.70 V (Option B).',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_dev_04',
    topicId: 'devices',
    question: 'The Einstein relation connecting carrier diffusivity D and mobility μ in a nondegenerate semiconductor at absolute temperature T is:',
    options: [
      'D / μ = (k·T) / q',
      'D · μ = (k·T) / q',
      'D / μ = q / (k·T)',
      'D · q = μ / (k·T)',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: The Einstein relation establishes thermal equilibrium balance between diffusion current and drift current: D_n / μ_n = D_p / μ_p = V_t = (k·T) / q.\n\n'
        '📝 [Step-by-Step Calculation]: At T = 300 K, thermal voltage V_t = k·T / q ≈ 25.86 mV ≈ 26 mV. Thus, D / μ has dimensions of volts [V].\n\n'
        '⚠️ [GATE Exam Trap]: Check dimensions! D has units cm²/s and μ has units cm²/(V·s). Dividing D / μ gives [cm²/s] / [cm²/(V·s)] = Volts. Therefore D/μ must equal k·T/q (thermal voltage).\n\n'
        '✅ [Final Verdict]: D / μ = (k·T) / q (Option A).',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_dev_05',
    topicId: 'devices',
    question: 'In an abrupt p⁺-n junction under reverse bias voltage V_R, the depletion region width W varies with reverse bias as:',
    options: [
      'W ∝ (V_bi + V_R)',
      'W ∝ √(V_bi + V_R)',
      'W ∝ (V_bi + V_R)²',
      'W is independent of V_R',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: By solving Poisson\'s equation, total depletion width W = √[ (2·ε_s / q) · (1/N_A + 1/N_D) · (V_bi + V_R) ].\n\n'
        '📝 [Step-by-Step Calculation]: For a one-sided p⁺-n junction (N_A >> N_D), W ≈ √[ (2·ε_s·(V_bi + V_R)) / (q·N_D) ]. Therefore, W is directly proportional to √(V_bi + V_R).\n\n'
        '⚠️ [GATE Exam Trap]: The junction capacitance C_j = ε_s·A / W ∝ 1 / √(V_bi + V_R). Plotting 1/C_j² vs V_R gives a straight line whose slope yields doping N_D and intercept yields V_bi.\n\n'
        '✅ [Final Verdict]: W ∝ √(V_bi + V_R) (Option B).',
    difficulty: 'Easy',
    year: 2024,
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // 4. ANALOG CIRCUITS
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_ana_01',
    topicId: 'analog',
    question: 'An ideal op-amp inverting amplifier has input resistor R_in = 1.0 kΩ and feedback resistor R_f = 47.0 kΩ. What is the closed-loop voltage gain A_v and input resistance R_in(cl)?',
    options: [
      'A_v = +47.0, R_in(cl) = ∞',
      'A_v = -47.0, R_in(cl) = 1.0 kΩ',
      'A_v = +48.0, R_in(cl) = 47.0 kΩ',
      'A_v = -47.0, R_in(cl) = 0 Ω',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: For an ideal inverting op-amp configuration with negative feedback, the non-inverting terminal is at 0 V (ground). By virtual ground, V⁻ = V⁺ = 0 V.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. Closed-loop voltage gain A_v = -R_f / R_in = -47 kΩ / 1 kΩ = -47.0.\n'
        '2. Input resistance seen by signal source: Since V⁻ is a virtual ground, R_in(cl) = V_in / I_in = R_in = 1.0 kΩ.\n\n'
        '⚠️ [GATE Exam Trap]: The op-amp itself has infinite input impedance, but the inverting amplifier circuit has input resistance equal to R_in! In contrast, a non-inverting amplifier has R_in(cl) ≈ ∞.\n\n'
        '✅ [Final Verdict]: A_v = -47.0 and R_in(cl) = 1.0 kΩ (Option B).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ana_02',
    topicId: 'analog',
    question: 'An RC low-pass passive filter has resistance R = 10 kΩ and capacitance C = 10 nF. What is the -3 dB cutoff frequency f_c?',
    options: [
      '159.2 Hz',
      '1.592 kHz (≈ 1592 Hz)',
      '15.92 kHz',
      '100.0 kHz',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: The half-power (-3 dB) cutoff frequency occurs when R = X_C ➔ ω_c·R·C = 1 ➔ f_c = 1 / (2π·R·C).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'f_c = 1 / [2 × π × (10 × 10³ Ω) × (10 × 10⁻⁹ F)] = 1 / [2π × 10⁻⁴] = 10⁴ / (2π) = 10,000 / 6.2832 ≈ 1591.55 Hz ≈ 1.592 kHz.\n\n'
        '⚠️ [GATE Exam Trap]: Missing the 2π factor calculates radian frequency ω_c = 10,000 rad/s. GATE questions strictly distinguish between Hz and rad/s!\n\n'
        '✅ [Final Verdict]: f_c ≈ 1592 Hz = 1.592 kHz (Option B).',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ana_03',
    topicId: 'analog',
    question: 'A BJT is biased at DC collector current I_C = 2.0 mA. Assuming thermal voltage V_T = 26 mV at room temperature, what is its small-signal transconductance g_m?',
    options: [
      '26.0 mA/V',
      '76.9 mA/V (≈ 0.0769 A/V)',
      '52.0 mA/V',
      '13.0 mA/V',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: The small-signal transconductance of a BJT is g_m = ∂I_C / ∂V_BE = I_C / V_T.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'g_m = (2.0 × 10⁻³ A) / (26 × 10⁻³ V) = 2 / 0.026 = 76.92 mA/V = 0.0769 A/V.\n\n'
        '⚠️ [GATE Exam Trap]: For a MOSFET, g_m = 2·I_D / V_ov = √(2·k_n·I_D), which is proportional to √I_D. For a BJT, g_m is strictly linearly proportional to I_C, giving the BJT vastly superior transconductance at equivalent bias currents.\n\n'
        '✅ [Final Verdict]: g_m ≈ 76.9 mA/V (Option B).',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_ana_04',
    topicId: 'analog',
    question: 'In a standard 555 timer connected in astable multivibrator mode with timing resistors R_A, R_B and timing capacitor C, the oscillation frequency f is:',
    options: [
      'f = 1.44 / [(R_A + R_B)·C]',
      'f = 1.44 / [(R_A + 2·R_B)·C]',
      'f = 0.693 / [(2·R_A + R_B)·C]',
      'f = 1 / [2π·(R_A + R_B)·C]',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Charging time t_high = ln(2) · (R_A + R_B) · C ≈ 0.693 · (R_A + R_B) · C. Discharging time t_low = ln(2) · R_B · C ≈ 0.693 · R_B · C.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Total period T = t_high + t_low = 0.693 · (R_A + 2·R_B) · C.\n'
        'Frequency f = 1 / T = 1 / [0.693 · (R_A + 2·R_B) · C] ≈ 1.44 / [(R_A + 2·R_B) · C].\n\n'
        '⚠️ [GATE Exam Trap]: The duty cycle D = t_high / T = (R_A + R_B) / (R_A + 2·R_B) is always > 50%. A 50% square wave requires a diode across R_B to bypass it during charging.\n\n'
        '✅ [Final Verdict]: f = 1.44 / [(R_A + 2·R_B)·C] (Option B).',
    difficulty: 'Medium',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_ana_05',
    topicId: 'analog',
    question: 'An op-amp has Slew Rate SR = 1.0 V/μs. The maximum peak amplitude V_m of an undistorted 100 kHz sinusoidal output signal is:',
    options: [
      '1.59 V',
      '3.18 V',
      '10.0 V',
      '0.50 V',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: Slew Rate is the maximum rate of change of output voltage: SR = max|dv_out / dt| = 2π·f·V_m.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. SR = 1.0 V/μs = 1.0 × 10⁶ V/s.\n'
        '2. 2π · f · V_m ≤ SR ➔ V_m ≤ SR / (2π·f).\n'
        '3. V_m = 10⁶ / [2π × 100 × 10³] = 10 / (2π) = 5 / π ≈ 1.5915 V.\n\n'
        '⚠️ [GATE Exam Trap]: If peak voltage exceeds 1.59 V, the output distorts into a triangular waveform due to slew rate limiting.\n\n'
        '✅ [Final Verdict]: V_m ≈ 1.59 V (Option A).',
    difficulty: 'Medium',
    year: 2024,
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // 5. DIGITAL CIRCUITS
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_dig_01',
    topicId: 'digital',
    question: 'A 4-bit binary ripple up-counter is initially reset to 0000. After 27 input clock pulses, what is the binary state (Q₃ Q₂ Q₁ Q₀)?',
    options: [
      '1011 (11 in decimal)',
      '1100 (12 in decimal)',
      '0101 (5 in decimal)',
      '1111 (15 in decimal)',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: An n-bit binary counter has modulus M = 2ⁿ states (from 0 to 2ⁿ - 1). For n = 4, M = 2⁴ = 16 states (0 to 15).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'After N clock pulses, the counter state is N mod M.\n'
        '27 mod 16 = 27 - 16 = 11.\n'
        'Converting 11 to 4-bit binary: 11 = 8 + 2 + 1 = 1011₂.\n\n'
        '⚠️ [GATE Exam Trap]: Remember that on the 16th pulse, the counter rolls over back to 0000. 27 pulses = 1 full rollover (16 pulses) + 11 pulses.\n\n'
        '✅ [Final Verdict]: State is 1011₂ (Option A).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_dig_02',
    topicId: 'digital',
    question: 'Using De Morgan\'s laws, the Boolean complement of the logic function F = A·B + C̄·D is:',
    options: [
      '(Ā + B̄) · (C + D̄)',
      '(Ā · B̄) + (C · D̄)',
      '(A + B) · (C̄ + D)',
      'Ā·B̄ · C·D̄',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: De Morgan\'s laws state: (X + Y)\' = X\' · Y\' and (X · Y)\' = X\' + Y\'.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. F\' = (A·B + C̄·D)\'\n'
        '2. Apply sum complement: F\' = (A·B)\' · (C̄·D)\'\n'
        '3. Apply product complement: (A·B)\' = (Ā + B̄) and (C̄·D)\' = (C̄\' + D̄) = (C + D̄).\n'
        '4. Thus, F\' = (Ā + B̄) · (C + D̄).\n\n'
        '⚠️ [GATE Exam Trap]: Watch double negation: (C̄)\' = C. Do not leave it as C̄ in the parentheses!\n\n'
        '✅ [Final Verdict]: F\' = (Ā + B̄) · (C + D̄) (Option A).',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_dig_03',
    topicId: 'digital',
    question: 'The minimum number of 2-input NAND gates required to implement a 2-input XOR gate is:',
    options: [
      '3',
      '4',
      '5',
      '6',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: A XOR B = Ā·B + A·B̄. Using universal NAND logic, this requires 4 gates:\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '• Gate 1: G₁ = NAND(A, B) = (A·B)\' = Ā + B̄\n'
        '• Gate 2: G₂ = NAND(A, G₁) = [A · (A·B)\']\' = Ā + A·B = Ā + B\n'
        '• Gate 3: G₃ = NAND(B, G₁) = [B · (A·B)\']\' = B̄ + A·B = B̄ + A\n'
        '• Gate 4: G₄ = NAND(G₂, G₃) = (G₂ · G₃)\' = A·B̄ + Ā·B = A XOR B.\n\n'
        '⚠️ [GATE Exam Trap]: To build a 2-input XNOR gate using NAND gates requires 5 NAND gates. To build XOR using NOR gates requires 5 NOR gates!\n\n'
        '✅ [Final Verdict]: Exactly 4 NAND gates (Option B).',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_dig_04',
    topicId: 'digital',
    question: 'In a synchronous sequential circuit, the clock period T_clk must satisfy which timing constraint to prevent setup-time violations (where t_cq is clock-to-Q delay, t_comb is combinational logic delay, and t_setup is flip-flop setup time)?',
    options: [
      'T_clk ≥ t_cq + t_comb + t_setup',
      'T_clk ≤ t_cq - t_hold',
      'T_clk ≥ t_comb - t_setup',
      'T_clk = t_cq + t_hold',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: The setup constraint requires data to arrive at the input of the destination flip-flop at least t_setup before the next active clock edge.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Maximum path delay: T_data = t_cq(max) + t_comb(max).\n'
        'Clock period condition: T_clk ≥ T_data + t_setup ➔ T_clk ≥ t_cq + t_comb + t_setup.\n'
        'The maximum clock frequency is f_max = 1 / T_clk(min).\n\n'
        '⚠️ [GATE Exam Trap]: Hold time constraint is independent of clock period: t_cq(min) + t_comb(min) ≥ t_hold + t_skew. Setup time determines maximum operating frequency, while hold time determines functional correctness at any frequency.\n\n'
        '✅ [Final Verdict]: T_clk ≥ t_cq + t_comb + t_setup (Option A).',
    difficulty: 'Medium',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_dig_05',
    topicId: 'digital',
    question: 'An 8-bit Successive Approximation Register (SAR) Analog-to-Digital Converter (ADC) operates with a clock frequency of 1 MHz. The conversion time for any input voltage is:',
    options: [
      '8 μs',
      '256 μs',
      '1 μs',
      '128 μs',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: In an n-bit SAR ADC, the conversion tests one bit per clock cycle from MSB down to LSB, requiring exactly n clock cycles (or n + 1 cycles depending on register latching).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. Clock period T = 1 / (1 MHz) = 1 μs.\n'
        '2. Number of bits n = 8.\n'
        '3. Conversion time T_conv = n × T = 8 × 1 μs = 8 μs.\n\n'
        '⚠️ [GATE Exam Trap]: A counter-ramp ADC requires up to 2ⁿ clock cycles (256 μs), and Flash ADC requires only 1 clock cycle (1 μs). SAR conversion time is fixed and independent of the input analog voltage level.\n\n'
        '✅ [Final Verdict]: Conversion time = 8 μs (Option A).',
    difficulty: 'Medium',
    year: 2024,
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // 6. CONTROL SYSTEMS
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_ctrl_01',
    topicId: 'control',
    question: 'A second-order feedback control system has closed-loop transfer function T(s) = 25 / (s² + 6s + 25). The damping ratio ζ and undamped natural frequency ω_n are:',
    options: [
      'ζ = 0.5, ω_n = 5 rad/s',
      'ζ = 0.6, ω_n = 5 rad/s',
      'ζ = 0.6, ω_n = 25 rad/s',
      'ζ = 0.3, ω_n = 5 rad/s',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Standard second-order characteristic equation: s² + 2·ζ·ω_n·s + ω_n² = 0.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. Compare constant terms: ω_n² = 25 ➔ ω_n = 5 rad/s.\n'
        '2. Compare coefficient of s: 2·ζ·ω_n = 6 ➔ 2·ζ·(5) = 6 ➔ 10·ζ = 6 ➔ ζ = 0.6.\n\n'
        '⚠️ [GATE Exam Trap]: Since 0 < ζ < 1, the system is underdamped. The peak percentage overshoot is M_p = e^(-πζ/√(1-ζ²)) × 100% = e^(-1.8π/0.8) ≈ 9.5%.\n\n'
        '✅ [Final Verdict]: ζ = 0.6 and ω_n = 5 rad/s (Option B).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ctrl_02',
    topicId: 'control',
    question: 'The characteristic equation of a unity feedback system is s³ + 6s² + 11s + 6 = 0. Using Routh\'s criterion, the number of roots in the right half of the s-plane (RHP) is:',
    options: [
      '1',
      '2',
      '0 (System is stable)',
      '3',
    ],
    correctIndex: 2,
    explanation:
        '🎯 [Concept & Formula]: Routh-Hurwitz criterion states that the number of RHP poles equals the number of sign changes in the first column of the Routh array.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Row s³:  1   11\n'
        'Row s²:  6    6\n'
        'Row s¹:  [(6 × 11) - (1 × 6)] / 6 = (66 - 6) / 6 = 60 / 6 = 10\n'
        'Row s⁰:  6\n'
        'First column elements: {1, 6, 10, 6}.\n'
        'All elements are strictly positive ➔ 0 sign changes ➔ 0 roots in RHP.\n\n'
        '⚠️ [GATE Exam Trap]: In fact, the roots are s = -1, -2, -3, all lying in the open Left Half Plane (LHP). The system is asymptotically stable.\n\n'
        '✅ [Final Verdict]: 0 roots in RHP (Option C).',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ctrl_03',
    topicId: 'control',
    question: 'For a unity negative feedback system with open-loop transfer function G(s) = K / [s·(s + 2)·(s + 4)], the angle of asymptotes of the root locus as K → ∞ are:',
    options: [
      '±90°, 180°',
      '±60°, 180°',
      '0°, 120°, 240°',
      '±45°, ±135°',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Angle of asymptotes θ_q = [(2q + 1) × 180°] / (P - Z), where P is number of poles, Z is number of zeros, and q = 0, 1, ..., (P - Z - 1).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Poles: s = 0, -2, -4 ➔ P = 3. Zeros: Z = 0.\n'
        'P - Z = 3 - 0 = 3 asymptotes.\n'
        '• q = 0: θ₀ = (1 × 180°) / 3 = 60°\n'
        '• q = 1: θ₁ = (3 × 180°) / 3 = 180°\n'
        '• q = 2: θ₂ = (5 × 180°) / 3 = 300° (or -60°).\n'
        'Angles are ±60° and 180°.\n\n'
        '⚠️ [GATE Exam Trap]: The centroid σ_A = (∑Poles - ∑Zeros) / (P - Z) = (0 - 2 - 4 - 0) / 3 = -6 / 3 = -2.0 on the real axis.\n\n'
        '✅ [Final Verdict]: Angles are ±60° and 180° (Option B).',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_ctrl_04',
    topicId: 'control',
    question: 'A unity feedback system has open-loop transfer function G(s) = 100 / [s·(s + 10)]. For a unit ramp input r(t) = t·u(t), the steady-state error e_ss is:',
    options: [
      '0.10',
      '0',
      '1.0',
      '∞',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: For a unit ramp input, steady-state error e_ss = 1 / K_v, where velocity error constant K_v = lim_{s→0} [s · G(s)].\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. K_v = lim_{s→0} [s · 100 / (s·(s + 10))] = lim_{s→0} [100 / (s + 10)] = 100 / 10 = 10 sec⁻¹.\n'
        '2. e_ss = 1 / K_v = 1 / 10 = 0.10.\n\n'
        '⚠️ [GATE Exam Trap]: System type is Type-1 (single pole at origin). For Type-1: step input error = 0, ramp input error = 1/K_v, parabolic input error = ∞.\n\n'
        '✅ [Final Verdict]: e_ss = 0.10 (Option A).',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_ctrl_05',
    topicId: 'control',
    question: 'The phase lead compensator D(s) = (s + z) / (s + p) provides a positive phase angle contribution if and only if:',
    options: [
      'z < p (zero is closer to origin than pole)',
      'z > p (pole is closer to origin than zero)',
      'z = p',
      'z and p are complex conjugates',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: A lead network has transfer function (1 + a·T·s) / (1 + T·s) with a > 1, meaning pole p = 1/T and zero z = 1/(aT). Since a > 1, |z| < |p|.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Phase angle φ(ω) = tan⁻¹(ω/z) - tan⁻¹(ω/p). For φ(ω) > 0, we require ω/z > ω/p ➔ z < p. The maximum lead phase φ_m = sin⁻¹[(p - z)/(p + z)] occurs at ω_m = √(z·p).\n\n'
        '⚠️ [GATE Exam Trap]: Lead compensator increases system bandwidth and improves transient response (speed, stability). Lag compensator has pole closer to origin (p < z) to boost low-frequency gain and eliminate steady-state error.\n\n'
        '✅ [Final Verdict]: z < p (Option A).',
    difficulty: 'Medium',
    year: 2024,
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // 7. COMMUNICATIONS
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_com_01',
    topicId: 'comms',
    question: 'A sinusoidal carrier is amplitude-modulated (AM) with modulation index μ = 1.0 (100% modulation). What fraction of the total transmitted power is contained in the information-bearing sidebands?',
    options: [
      '50.0%',
      '33.33% (1/3)',
      '66.67% (2/3)',
      '25.0%',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Total AM power P_t = P_c · [1 + μ² / 2]. Sideband power P_sb = P_c · (μ² / 2).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Power efficiency η = P_sb / P_t = (μ² / 2) / [1 + μ² / 2] = μ² / (2 + μ²).\n'
        'For μ = 1.0: η = 1² / (2 + 1²) = 1 / 3 ≈ 33.33%.\n\n'
        '⚠️ [GATE Exam Trap]: The carrier wave consumes 66.67% (2/3) of total power despite carrying zero information! This severe inefficiency led to the development of DSB-SC and SSB-SC transmission.\n\n'
        '✅ [Final Verdict]: Efficiency = 33.33% (Option B).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_com_02',
    topicId: 'comms',
    question: 'A telephone channel has bandwidth B = 4.0 kHz and Signal-to-Noise Ratio SNR = 255 (linear). By the Shannon-Hartley theorem, the channel capacity C is:',
    options: [
      '32 kbps',
      '64 kbps',
      '16 kbps',
      '128 kbps',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: Shannon channel capacity C = B · log₂(1 + SNR) bits per second.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. 1 + SNR = 1 + 255 = 256.\n'
        '2. log₂(256) = log₂(2⁸) = 8.\n'
        '3. C = 4000 Hz × 8 bits = 32,000 bps = 32 kbps.\n\n'
        '⚠️ [GATE Exam Trap]: Notice SNR was given as linear ratio 255. If given in dB (e.g. 24 dB), first convert to linear: SNR = 10^(24/10) ≈ 251.2.\n\n'
        '✅ [Final Verdict]: C = 32 kbps (Option A).',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_com_03',
    topicId: 'comms',
    question: 'In a pulse code modulation (PCM) system, if the number of quantization levels is increased from 64 to 256, by how many decibels does the Signal-to-Quantization-Noise Ratio (SQNR) improve?',
    options: [
      '6 dB',
      '12 dB',
      '18 dB',
      '24 dB',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: For an n-bit uniform PCM quantizer, SQNR_dB = 6.02·n + 1.76 dB. Each additional bit increases SQNR by approximately 6 dB.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. Number of levels L₁ = 64 = 2⁶ ➔ n₁ = 6 bits.\n'
        '2. Number of levels L₂ = 256 = 2⁸ ➔ n₂ = 8 bits.\n'
        '3. Additional bits Δn = 8 - 6 = 2 bits.\n'
        '4. Improvement in SQNR = Δn × 6.02 dB ≈ 2 × 6.02 dB = 12.04 dB ≈ 12 dB.\n\n'
        '⚠️ [GATE Exam Trap]: Bandwidth of PCM is B ≥ n·f_m. Increasing bits from 6 to 8 increases transmission bandwidth by 33.3%, showcasing the classic trade-off between SNR and bandwidth.\n\n'
        '✅ [Final Verdict]: Improvement = 12 dB (Option B).',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_com_04',
    topicId: 'comms',
    question: 'A frequency modulated (FM) signal has peak frequency deviation Δf = 75 kHz and message frequency f_m = 15 kHz. By Carson\'s rule, the transmission bandwidth is:',
    options: [
      '90 kHz',
      '180 kHz',
      '150 kHz',
      '300 kHz',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Carson\'s bandwidth rule: BW = 2 · (Δf + f_m) = 2 · f_m · (β + 1), where modulation index β = Δf / f_m.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. β = 75 kHz / 15 kHz = 5.\n'
        '2. BW = 2 × (75 kHz + 15 kHz) = 2 × 90 kHz = 180 kHz.\n\n'
        '⚠️ [GATE Exam Trap]: Narrowband FM (β << 1) has BW ≈ 2·f_m, while Wideband FM (β >> 1) has BW ≈ 2·Δf. Carson\'s rule accurately bridges both regimes.\n\n'
        '✅ [Final Verdict]: BW = 180 kHz (Option B).',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_com_05',
    topicId: 'comms',
    question: 'In digital modulation, what is the spectral efficiency (bits/second/Hz) and constellation symbol distance advantage of QPSK compared to BPSK?',
    options: [
      'QPSK has 2× bit rate for the same RF bandwidth as BPSK',
      'QPSK requires half the power for the same bit error rate',
      'QPSK transmits 4 bits per symbol',
      'BPSK has higher spectral efficiency than QPSK',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: BPSK carries 1 bit per symbol (M = 2). QPSK carries 2 bits per symbol (M = 4, using I & Q quadrature carriers).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'For a given null-to-null bandwidth BW = 2·R_s, BPSK transmits R_b = R_s bps, while QPSK transmits R_b = 2·R_s bps. Therefore, QPSK doubles the bit rate in the exact same channel bandwidth.\n\n'
        '⚠️ [GATE Exam Trap]: QPSK achieves the exact same Bit Error Rate (BER) curve as BPSK as a function of E_b/N_0, because the I and Q channels are orthogonal and do not interfere!\n\n'
        '✅ [Final Verdict]: QPSK transmits 2× the bit rate for the same RF bandwidth (Option A).',
    difficulty: 'Medium',
    year: 2024,
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // 8. ELECTROMAGNETICS (EMT)
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_em_01',
    topicId: 'emt',
    question: 'A lossless transmission line with characteristic impedance Z₀ = 50 Ω is terminated in a load impedance Z_L = 100 Ω. What is the voltage reflection coefficient Γ and Voltage Standing Wave Ratio (VSWR)?',
    options: [
      'Γ = 0.50, VSWR = 3.0',
      'Γ = +1/3 (≈ 0.333), VSWR = 2.0',
      'Γ = -1/3, VSWR = 2.0',
      'Γ = 0.25, VSWR = 1.5',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Voltage reflection coefficient Γ = (Z_L - Z₀) / (Z_L + Z₀). VSWR = (1 + |Γ|) / (1 - |Γ|).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. Γ = (100 - 50) / (100 + 50) = 50 / 150 = +1/3 ≈ 0.333.\n'
        '2. VSWR = (1 + 1/3) / (1 - 1/3) = (4/3) / (2/3) = 4 / 2 = 2.0.\n\n'
        '⚠️ [GATE Exam Trap]: VSWR is always a real number ≥ 1.0. A perfectly matched line has Γ = 0 and VSWR = 1.0. Short or open circuit has |Γ| = 1 and VSWR = ∞.\n\n'
        '✅ [Final Verdict]: Γ = +1/3 and VSWR = 2.0 (Option B).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_em_02',
    topicId: 'emt',
    question: 'Maxwell\'s equation ∇·B = 0 is a mathematical statement of which fundamental physical law?',
    options: [
      'Faraday\'s Law of Induction',
      'Absence of isolated magnetic monopoles (magnetic field lines form continuous closed loops)',
      'Ampere\'s Circuital Law with Maxwell\'s displacement current',
      'Coulomb\'s Electrostatic Law',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Gauss\'s Law for Magnetism: ∇·B = 0 states that the net magnetic flux out of any closed surface is identically zero.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'By Divergence Theorem: ∮_S B·dS = ∫_V (∇·B) dV = 0. Hence, magnetic lines of force have neither beginning nor end — isolated magnetic charges (monopoles) do not exist in classical electromagnetism.\n\n'
        '⚠️ [GATE Exam Trap]: Compare with ∇·D = ρ_v (Gauss\'s law for electrostatics), where electric charges DO exist as sources and sinks of electric displacement lines.\n\n'
        '✅ [Final Verdict]: Non-existence of magnetic monopoles (Option B).',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_em_03',
    topicId: 'emt',
    question: 'The skin depth δ in a good conductor with conductivity σ and permeability μ at frequency f is given by:',
    options: [
      'δ = √(π·f·μ·σ)',
      'δ = 1 / √(π·f·μ·σ)',
      'δ = 2π / √(f·μ·σ)',
      'δ = σ / (2π·f·μ)',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Skin depth δ is the depth at which the amplitude of an electromagnetic wave attenuates to 1/e (≈ 36.8%) of its surface value.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Attenuation constant for a good conductor (σ >> ωε): α = √(ω·μ·σ / 2) = √(2πf·μ·σ / 2) = √(πf·μ·σ).\n'
        'Skin depth δ = 1 / α = 1 / √(π·f·μ·σ).\n\n'
        '⚠️ [GATE Exam Trap]: Note that δ ∝ 1/√f. At microwave frequencies (e.g. 10 GHz in copper), skin depth is less than 1 μm, meaning current flows exclusively in a razor-thin surface layer.\n\n'
        '✅ [Final Verdict]: δ = 1 / √(π·f·μ·σ) (Option B).',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_em_04',
    topicId: 'emt',
    question: 'An air-filled rectangular waveguide has broader internal dimension a = 3.0 cm and narrow dimension b = 1.5 cm. The cutoff frequency for the dominant TE₁₀ mode is (c = 3 × 10⁸ m/s):',
    options: [
      '2.5 GHz',
      '5.0 GHz',
      '10.0 GHz',
      '1.5 GHz',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: For TE_mn or TM_mn mode in rectangular waveguide: f_c(m,n) = (c / 2) · √[ (m/a)² + (n/b)² ]. For dominant mode TE₁₀ (m=1, n=0): f_c(1,0) = c / (2·a).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'f_c(1,0) = (3 × 10⁸ m/s) / [2 × 0.03 m] = (3 × 10⁸) / 0.06 = 5 × 10⁹ Hz = 5.0 GHz.\n\n'
        '⚠️ [GATE Exam Trap]: Cutoff wavelength λ_c = 2·a = 2 × 3 cm = 6 cm. Frequencies below 5.0 GHz attenuate exponentially and cannot propagate down this waveguide.\n\n'
        '✅ [Final Verdict]: f_c = 5.0 GHz (Option B).',
    difficulty: 'Medium',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_em_05',
    topicId: 'emt',
    question: 'A uniform plane electromagnetic wave propagates in free space (intrinsic impedance η₀ ≈ 377 Ω). If the electric field peak amplitude is E_m = 37.7 V/m, what is the time-average Poynting vector magnitude S_avg?',
    options: [
      '1.885 W/m²',
      '3.77 W/m²',
      '0.50 W/m²',
      '0.05 W/m²',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: Time-average power density S_avg = (1/2) · (E_m² / η₀) = (1/2) · E_m · H_m.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '1. S_avg = 0.5 × (37.7)² / 377 = 0.5 × 1421.29 / 377 = 0.5 × 3.77 = 1.885 W/m².\n\n'
        '⚠️ [GATE Exam Trap]: Remember the 1/2 factor for time-average sinusoidal power! Without it, you get 3.77 W/m² (instantaneous peak, not time-average).\n\n'
        '✅ [Final Verdict]: S_avg = 1.885 W/m² (Option A).',
    difficulty: 'Medium',
    year: 2024,
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // 9. ENGINEERING MATHEMATICS
  // ═══════════════════════════════════════════════════════════════════════════
  GateQuestion(
    id: 'q_math_01',
    topicId: 'math',
    question: 'The eigenvalues of the 2 × 2 matrix A = [[2, 1], [0, 3]] are:',
    options: [
      'λ = 1, 2',
      'λ = 2, 3',
      'λ = 0, 5',
      'λ = -2, -3',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: For any triangular (upper, lower) or diagonal matrix, the eigenvalues are simply the elements along the main diagonal.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Characteristic equation: det(A - λ·I) = (2 - λ)·(3 - λ) - (1 × 0) = 0\n'
        '➔ (2 - λ)·(3 - λ) = 0 ➔ λ₁ = 2, λ₂ = 3.\n'
        'Check properties:\n'
        '• Trace(A) = 2 + 3 = 5 = λ₁ + λ₂ ✓\n'
        '• Det(A) = (2)(3) - (1)(0) = 6 = λ₁ × λ₂ ✓\n\n'
        '⚠️ [GATE Exam Trap]: Always verify using Trace and Determinant shortcuts — saves immense time in GATE!\n\n'
        '✅ [Final Verdict]: λ = 2 and 3 (Option B).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_math_02',
    topicId: 'math',
    question: 'A continuous random variable X follows a Gaussian (normal) distribution X ~ N(μ, σ²). What is the probability that X lies within one standard deviation of the mean, P(μ - σ ≤ X ≤ μ + σ)?',
    options: [
      '50.0%',
      '68.27% (≈ 68.3%)',
      '95.45% (≈ 95.5%)',
      '99.73% (≈ 99.7%)',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: The empirical 68-95-99.7 rule for standard normal distribution:\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '• P(μ - 1σ ≤ X ≤ μ + 1σ) = 2 · Φ(1) - 1 = 2(0.8413) - 1 = 0.6826 = 68.27%\n'
        '• P(μ - 2σ ≤ X ≤ μ + 2σ) = 95.45%\n'
        '• P(μ - 3σ ≤ X ≤ μ + 3σ) = 99.73%.\n\n'
        '⚠️ [GATE Exam Trap]: In communication systems, error probability Q(x) = 1 - Φ(x). For x = 1, Q(1) ≈ 0.1587, so total two-sided tail area is 2 × 0.1587 ≈ 0.3174, leaving central area 1 - 0.3174 = 0.6826.\n\n'
        '✅ [Final Verdict]: 68.27% (Option B).',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_math_03',
    topicId: 'math',
    question: 'For a complex function f(z) = u(x,y) + j·v(x,y) to be analytic at a point, which Cauchy-Riemann equations must be satisfied?',
    options: [
      '∂u/∂x = ∂v/∂y  and  ∂u/∂y = -∂v/∂x',
      '∂u/∂x = -∂v/∂y  and  ∂u/∂y = ∂v/∂x',
      '∂u/∂x = ∂v/∂x  and  ∂u/∂y = ∂v/∂y',
      '∂²u/∂x² + ∂²v/∂y² = 0',
    ],
    correctIndex: 0,
    explanation:
        '🎯 [Concept & Formula]: The necessary condition for complex differentiability (analyticity) of f(z) = u + jv is that u and v satisfy the Cauchy-Riemann (C-R) equations: u_x = v_y and u_y = -v_x.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        'Taking derivative along real axis: f\'(z) = ∂u/∂x + j·∂v/∂x.\n'
        'Taking derivative along imaginary axis: f\'(z) = -j·∂u/∂y + ∂v/∂y = ∂v/∂y - j·∂u/∂y.\n'
        'Equating real and imaginary parts gives: ∂u/∂x = ∂v/∂y and ∂u/∂y = -∂v/∂x.\n\n'
        '⚠️ [GATE Exam Trap]: Watch the negative sign! The minus sign belongs with ∂v/∂x (or ∂u/∂y), NOT with ∂v/∂y.\n\n'
        '✅ [Final Verdict]: ∂u/∂x = ∂v/∂y and ∂u/∂y = -∂v/∂x (Option A).',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_math_04',
    topicId: 'math',
    question: 'According to the Rank-Nullity Theorem, for any real m × n matrix A, the rank of A and the dimension of its null space (nullity) satisfy:',
    options: [
      'Rank(A) + Nullity(A) = m (number of rows)',
      'Rank(A) + Nullity(A) = n (number of columns)',
      'Rank(A) - Nullity(A) = n',
      'Rank(A) × Nullity(A) = m × n',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: The Fundamental Theorem of Linear Algebra states that for a linear mapping T: Rⁿ → Rᵐ represented by m × n matrix A, dim(Range(A)) + dim(Kernel(A)) = n.\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '• Rank(A) = dim(Column Space)\n'
        '• Nullity(A) = dim(Solution space to Ax = 0)\n'
        '• Sum = n = total number of variables (columns).\n\n'
        '⚠️ [GATE Exam Trap]: Confusing m (rows) with n (columns). The null space consists of vectors in the domain Rⁿ, so the sum equals n.\n\n'
        '✅ [Final Verdict]: Rank(A) + Nullity(A) = n (Option B).',
    difficulty: 'Medium',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_math_05',
    topicId: 'math',
    question: 'In numerical integration using Simpson\'s 1/3 rule over interval [a, b] divided into n subintervals of step size h = (b - a)/n, the rule is applicable if and only if n is:',
    options: [
      'Any positive integer',
      'An even number',
      'An odd number',
      'A multiple of 3',
    ],
    correctIndex: 1,
    explanation:
        '🎯 [Concept & Formula]: Simpson\'s 1/3 rule approximates the integrand using second-order parabolas across pairs of subintervals (requiring 2 intervals per parabola).\n\n'
        '📝 [Step-by-Step Calculation]:\n'
        '∫_a^b f(x) dx ≈ (h/3) · [f(x₀) + 4·∑f(x_odd) + 2·∑f(x_even) + f(x_n)].\n'
        'Because each parabolic segment spans 2 consecutive subintervals, the total number of subintervals n must be EVEN.\n\n'
        '⚠️ [GATE Exam Trap]: Simpson\'s 3/8 rule requires n to be a multiple of 3. Trapezoidal rule works for ANY integer n.\n\n'
        '✅ [Final Verdict]: n must be an even number (Option B).',
    difficulty: 'Easy',
    year: 2024,
  ),
];

// ─── FULL-LENGTH & TOPIC MOCK TESTS ──────────────────────────────────────────
const List<MockTest> mockTests = [
  MockTest(
    id: 'mock_01',
    title: 'GATE ECE 2024 — Full Grand Mock Test',
    description: '45 high-yield verified questions · 180 mins · Full syllabus',
    durationMinutes: 180,
    questionIds: [
      'q_net_01', 'q_net_02', 'q_net_03', 'q_net_04', 'q_net_05',
      'q_sig_01', 'q_sig_02', 'q_sig_03', 'q_sig_04', 'q_sig_05',
      'q_dev_01', 'q_dev_02', 'q_dev_03', 'q_dev_04', 'q_dev_05',
      'q_ana_01', 'q_ana_02', 'q_ana_03', 'q_ana_04', 'q_ana_05',
      'q_dig_01', 'q_dig_02', 'q_dig_03', 'q_dig_04', 'q_dig_05',
      'q_ctrl_01', 'q_ctrl_02', 'q_ctrl_03', 'q_ctrl_04', 'q_ctrl_05',
      'q_com_01', 'q_com_02', 'q_com_03', 'q_com_04', 'q_com_05',
      'q_em_01', 'q_em_02', 'q_em_03', 'q_em_04', 'q_em_05',
      'q_math_01', 'q_math_02', 'q_math_03', 'q_math_04', 'q_math_05',
    ],
    totalMarks: 100,
  ),
  MockTest(
    id: 'mock_02',
    title: 'Networks & Signals — Mastery Test',
    description: '10 verified questions · 30 minutes · Circuit & Signals Core',
    durationMinutes: 30,
    questionIds: [
      'q_net_01', 'q_net_02', 'q_net_03', 'q_net_04', 'q_net_05',
      'q_sig_01', 'q_sig_02', 'q_sig_03', 'q_sig_04', 'q_sig_05',
    ],
    totalMarks: 25,
  ),
  MockTest(
    id: 'mock_03',
    title: 'Electronic Devices & Analog Circuits',
    description: '10 verified questions · 30 minutes · Solid-state & Op-Amps',
    durationMinutes: 30,
    questionIds: [
      'q_dev_01', 'q_dev_02', 'q_dev_03', 'q_dev_04', 'q_dev_05',
      'q_ana_01', 'q_ana_02', 'q_ana_03', 'q_ana_04', 'q_ana_05',
    ],
    totalMarks: 25,
  ),
  MockTest(
    id: 'mock_04',
    title: 'Digital Circuits & Control Systems',
    description: '10 verified questions · 30 minutes · Logic design & Stability',
    durationMinutes: 30,
    questionIds: [
      'q_dig_01', 'q_dig_02', 'q_dig_03', 'q_dig_04', 'q_dig_05',
      'q_ctrl_01', 'q_ctrl_02', 'q_ctrl_03', 'q_ctrl_04', 'q_ctrl_05',
    ],
    totalMarks: 25,
  ),
  MockTest(
    id: 'mock_05',
    title: 'Communications, EMT & Engineering Math',
    description: '15 verified questions · 45 minutes · High-weightage sections',
    durationMinutes: 45,
    questionIds: [
      'q_com_01', 'q_com_02', 'q_com_03', 'q_com_04', 'q_com_05',
      'q_em_01', 'q_em_02', 'q_em_03', 'q_em_04', 'q_em_05',
      'q_math_01', 'q_math_02', 'q_math_03', 'q_math_04', 'q_math_05',
    ],
    totalMarks: 35,
  ),
];
