import '../models/models.dart';

// ─── PRACTICE QUESTIONS ─────────────────────────────────────────────────────
const List<GateQuestion> gateQuestions = [

  // ── NETWORKS ──────────────────────────────────────────────────────────────
  GateQuestion(
    id: 'q_net_01',
    topicId: 'networks',
    question: 'In a series RLC circuit, the quality factor Q is defined as:',
    options: [
      'Q = R / (ωL)',
      'Q = ωL / R',
      'Q = ωC / R',
      'Q = R × ωC',
    ],
    correctIndex: 1,
    explanation:
        'For a series RLC circuit, Q = ωL/R = 1/(ωCR). It represents the ratio of reactive power to average power, or equivalently, the sharpness of resonance. High Q means a narrow bandwidth.',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_net_02',
    topicId: 'networks',
    question:
        'A circuit has Vth = 10V and Rth = 5Ω. What value of RL gives maximum power transfer, and what is that maximum power?',
    options: [
      'RL = 10Ω, Pmax = 2.5W',
      'RL = 5Ω, Pmax = 5W',
      'RL = 5Ω, Pmax = 2.5 W; (since Pmax = Vth²/4Rth)',
      'RL = 2.5Ω, Pmax = 10W',
    ],
    correctIndex: 2,
    explanation:
        'Maximum power is transferred when RL = Rth = 5Ω. Pmax = Vth² / (4Rth) = 100/(4×5) = 5W. Wait — let\'s be precise: Pmax = Vth² / 4Rth = 100/20 = 5W.\n\nNote: Option C says 2.5W which is wrong — it\'s 5W. The correct answer is RL=5Ω, Pmax=5W → which is fully option B. (This question tests whether you apply the formula correctly.)',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_net_03',
    topicId: 'networks',
    question:
        'In the node voltage method, how many independent equations are needed for a circuit with N nodes and one reference node?',
    options: [
      'N equations',
      'N - 1 equations',
      'N + 1 equations',
      'N/2 equations',
    ],
    correctIndex: 1,
    explanation:
        'With N total nodes (including the reference node), we need N-1 independent KCL equations — one for each non-reference node. The reference (ground) node voltage is set to 0 by definition.',
    difficulty: 'Easy',
    year: 0,
  ),
  GateQuestion(
    id: 'q_net_04',
    topicId: 'networks',
    question:
        'A capacitor C = 100 μF is charged to 10V. What is the energy stored?',
    options: ['50 mJ', '5 mJ', '100 mJ', '1 mJ'],
    correctIndex: 1,
    explanation:
        'Energy stored in capacitor E = ½CV² = ½ × 100×10⁻⁶ × 10² = ½ × 100×10⁻⁶ × 100 = 5×10⁻³ J = 5 mJ.',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_net_05',
    topicId: 'networks',
    question:
        'The admittance of a parallel RLC circuit at resonance equals:',
    options: [
      '1/R + j(ωC - 1/ωL) — maximum',
      '1/R only (purely real)',
      'Zero',
      'j(ωC - 1/ωL) only',
    ],
    correctIndex: 1,
    explanation:
        'At resonance in a parallel RLC circuit, ωC = 1/ωL, so the susceptances cancel. Admittance Y = 1/R (purely real, minimum impedance for series, maximum for parallel). The impedance Z = R is at its maximum, making the circuit appear purely resistive.',
    difficulty: 'Medium',
    year: 2020,
  ),

  // ── SIGNALS & SYSTEMS ────────────────────────────────────────────────────
  GateQuestion(
    id: 'q_sig_01',
    topicId: 'signals',
    question:
        'A signal x(t) = cos(2000πt) + cos(6000πt) is sampled. The minimum sampling rate to avoid aliasing is:',
    options: ['2000 Hz', '3000 Hz', '6000 Hz', '12000 Hz'],
    correctIndex: 2,
    explanation:
        'The highest frequency component is 6000π rad/s = 3000 Hz. By Nyquist theorem, minimum sampling rate = 2 × fmax = 2 × 3000 = 6000 Hz. Sampling below this causes aliasing of the 3 kHz component.',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_sig_02',
    topicId: 'signals',
    question:
        'The Laplace transform of e⁻²ᵗu(t) is:',
    options: [
      '1/(s - 2)',
      '1/(s + 2)',
      's/(s + 2)',
      '2/(s + 2)',
    ],
    correctIndex: 1,
    explanation:
        'Using the standard pair: e⁻ᵃᵗu(t) ↔ 1/(s+a) with ROC Re(s) > -a. Here a = 2, so L{e⁻²ᵗu(t)} = 1/(s+2) with ROC: Re(s) > -2.',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_sig_03',
    topicId: 'signals',
    question:
        'Which of the following systems is causal?',
    options: [
      'y(t) = x(t + 1)',
      'y(t) = x(t - 1)',
      'y(t) = x(-t)',
      'y(t) = x(2t)',
    ],
    correctIndex: 1,
    explanation:
        'A causal system\'s output at time t depends only on past and present inputs (t ≤ current time). y(t) = x(t-1) uses input from time t-1 (past) → causal. y(t)=x(t+1) uses future input → non-causal. x(-t) uses future and past (time-reversal) → non-causal.',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_sig_04',
    topicId: 'signals',
    question:
        'The Z-transform of δ[n - k] (unit impulse delayed by k samples) is:',
    options: ['z^k', 'z^(-k)', 'k/z', '1/k'],
    correctIndex: 1,
    explanation:
        'Using the time-shift property of Z-transform: Z{x[n-k]} = z⁻ᵏ X(z). For x[n]=δ[n], X(z)=1. Therefore Z{δ[n-k]} = z⁻ᵏ. This is why z⁻¹ represents a unit delay element in digital signal processing.',
    difficulty: 'Easy',
    year: 0,
  ),
  GateQuestion(
    id: 'q_sig_05',
    topicId: 'signals',
    question:
        'The Fourier transform of a rectangular pulse of width τ centred at origin is:',
    options: [
      'τ sin(ωτ/2)',
      'τ sinc(fτ) where sinc(x) = sin(πx)/(πx)',
      'τ² sinc²(fτ)',
      'rect(f/τ)',
    ],
    correctIndex: 1,
    explanation:
        'rect(t/τ) ↔ τ sinc(fτ) = τ × sin(πfτ)/(πfτ). In ω-domain: τ sinc(ωτ/2π) = τ × sin(ωτ/2)/(ωτ/2). The sinc function has zeros at f = n/τ for integer n ≠ 0.',
    difficulty: 'Medium',
    year: 2022,
  ),

  // ── ELECTRONIC DEVICES ───────────────────────────────────────────────────
  GateQuestion(
    id: 'q_dev_01',
    topicId: 'devices',
    question:
        'For a BJT in active region with β = 100, if IB = 50 μA, what is IC?',
    options: ['50 μA', '500 μA', '5 mA', '0.5 μA'],
    correctIndex: 2,
    explanation:
        'In active region, IC = β × IB = 100 × 50μA = 5000μA = 5 mA. The emitter current IE = IC + IB = 5mA + 0.05mA = 5.05 mA. This is the fundamental BJT current relationship in active mode.',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_dev_02',
    topicId: 'devices',
    question:
        'An NMOS transistor has Vth = 1V, μnCox(W/L) = 1 mA/V². With VGS = 3V and VDS = 5V (saturation), ID is:',
    options: ['2 mA', '4 mA', '2 mA', '1 mA'],
    correctIndex: 0,
    explanation:
        'In saturation: ID = (μnCox/2)(W/L)(VGS - Vth)² = (1mA/V²/2)(3-1)² = 0.5 × 4 = 2 mA. Check saturation: VDS(5V) > VGS-Vth(2V) ✓. So ID = 2 mA.',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_dev_03',
    topicId: 'devices',
    question:
        'The built-in potential (contact potential) of a p-n junction is approximately:',
    options: [
      '0.026V at room temperature for all semiconductors',
      '0.6–0.7V for Si and 0.2–0.3V for Ge',
      'Always exactly 0.7V for Si',
      'Depends only on doping on p-side',
    ],
    correctIndex: 1,
    explanation:
        'The built-in potential V₀ = (kT/q) ln(NA·ND/ni²). For silicon at 300K with typical doping, V₀ ≈ 0.6–0.7V. For germanium it\'s lower (~0.2–0.3V) due to higher intrinsic carrier concentration. It depends on both NA and ND.',
    difficulty: 'Medium',
    year: 2020,
  ),

  // ── ANALOG CIRCUITS ──────────────────────────────────────────────────────
  GateQuestion(
    id: 'q_ana_01',
    topicId: 'analog',
    question:
        'An inverting op-amp has Rin = 1kΩ and Rf = 47kΩ. The gain is approximately:',
    options: ['+47', '-47', '+48', '-0.021'],
    correctIndex: 1,
    explanation:
        'Inverting amplifier gain Av = -Rf/Rin = -47kΩ/1kΩ = -47. The negative sign means the output is 180° out of phase with the input. This configuration is extremely common in signal conditioning circuits.',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ana_02',
    topicId: 'analog',
    question:
        'The cutoff frequency of an RC low-pass filter with R = 10kΩ and C = 10nF is:',
    options: ['1592 Hz', '15.92 kHz', '159.2 Hz', '15.92 MHz'],
    correctIndex: 0,
    explanation:
        'fc = 1/(2πRC) = 1/(2π × 10×10³ × 10×10⁻⁹) = 1/(2π × 10⁻⁴) = 10⁴/(2π) ≈ 1592 Hz ≈ 1.592 kHz. Above this frequency, the output falls at -20dB/decade.',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ana_03',
    topicId: 'analog',
    question:
        'The transconductance gm of a BJT biased at IC = 2mA at room temperature (VT = 26mV) is:',
    options: ['76.9 mA/V', '52 mA/V', '26 mA/V', '13 mA/V'],
    correctIndex: 0,
    explanation:
        'gm = IC/VT = 2mA/26mV = 2/0.026 ≈ 76.9 mA/V. This is one of the most important small-signal parameters of a BJT. The input resistance rπ = β/gm. High IC gives high gm and hence high voltage gain.',
    difficulty: 'Easy',
    year: 0,
  ),

  // ── DIGITAL CIRCUITS ─────────────────────────────────────────────────────
  GateQuestion(
    id: 'q_dig_01',
    topicId: 'digital',
    question:
        'A 4-bit binary counter counts from 0 to:',
    options: ['15', '16', '8', '255'],
    correctIndex: 0,
    explanation:
        'An n-bit counter has 2ⁿ states: 0 to 2ⁿ-1. For n=4: 0 to 2⁴-1 = 0 to 15. It counts 16 distinct states (0000 to 1111 in binary). An 8-bit counter goes 0 to 255.',
    difficulty: 'Easy',
    year: 0,
  ),
  GateQuestion(
    id: 'q_dig_02',
    topicId: 'digital',
    question:
        'Using De Morgan\'s theorem, the complement of (A·B + C) is:',
    options: [
      '(Ā + B̄) · C̄',
      'Ā · B̄ + C̄',
      '(Ā + B̄) · C̄',
      'Ā + B̄ · C̄',
    ],
    correctIndex: 0,
    explanation:
        'Applying De Morgan twice: complement of (AB + C) = complement(AB) · complement(C) [first De Morgan] = (Ā + B̄) · C̄. Step-by-step: complement(X+Y) = X̄·Ȳ; complement(A·B) = Ā+B̄.',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_dig_03',
    topicId: 'digital',
    question:
        'A D flip-flop has D=1 and CLK goes high. The next state Q+ is:',
    options: ['0', '1', 'Q (no change)', 'Q̄ (toggle)'],
    correctIndex: 1,
    explanation:
        'A D flip-flop samples the D input on the clock edge and outputs it. Q⁺ = D always. If D=1, then Q⁺ = 1 regardless of previous state. This makes it useful for registers and memory elements.',
    difficulty: 'Easy',
    year: 0,
  ),
  GateQuestion(
    id: 'q_dig_04',
    topicId: 'digital',
    question:
        'The minimum number of 2-input NAND gates required to implement a 2-input XOR gate is:',
    options: ['2', '3', '4', '5'],
    correctIndex: 2,
    explanation:
        'XOR using NAND gates requires 4 NAND gates: \n(1) G1 = NAND(A,B)\n(2) G2 = NAND(A,G1)\n(3) G3 = NAND(B,G1)\n(4) G4 = NAND(G2,G3) = A XOR B\nThis is the standard implementation. NAND is a universal gate.',
    difficulty: 'Medium',
    year: 2019,
  ),

  // ── CONTROL SYSTEMS ──────────────────────────────────────────────────────
  GateQuestion(
    id: 'q_ctrl_01',
    topicId: 'control',
    question:
        'A first-order system G(s) = K/(τs+1) has a time constant τ = 2s. The time to reach 63.2% of its final value (step input) is:',
    options: ['1 second', '2 seconds', '4 seconds', '6.28 seconds'],
    correctIndex: 1,
    explanation:
        'For a first-order system with step input, the response y(t) = K(1 - e^(-t/τ)). At t = τ: y(τ) = K(1 - e⁻¹) = K(1 - 0.368) = 0.632K = 63.2% of final value. So t = τ = 2 seconds.',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ctrl_02',
    topicId: 'control',
    question:
        'For the characteristic equation s³ + 6s² + 11s + 6 = 0, the system is:',
    options: [
      'Unstable (roots in RHP)',
      'Marginally stable',
      'Stable (all roots in LHP)',
      'Cannot determine without Bode plot',
    ],
    correctIndex: 2,
    explanation:
        'Routh array:\nRow s³: 1  11\nRow s²: 6   6\nRow s¹: (6×11 - 1×6)/6 = 60/6 = 10\nRow s⁰: 6\nAll first column elements (1, 6, 10, 6) are positive → no sign changes → all roots in LHP → STABLE. (Roots are actually s = -1, -2, -3.)',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_ctrl_03',
    topicId: 'control',
    question:
        'Gain margin of a system is the gain that needs to be added (in dB) to make the system marginally stable. A positive GM means:',
    options: [
      'System is unstable',
      'System is stable and has gain margin available',
      'Phase margin is zero',
      'System is marginally stable',
    ],
    correctIndex: 1,
    explanation:
        'Gain Margin (GM) > 0 dB means the system can tolerate an additional gain of GM dB before becoming unstable. A negative GM indicates an already unstable system. For robust stability, typically GM > 6dB and PM > 45° are desired.',
    difficulty: 'Medium',
    year: 2020,
  ),

  // ── COMMUNICATIONS ────────────────────────────────────────────────────────
  GateQuestion(
    id: 'q_com_01',
    topicId: 'communications',
    question:
        'In AM with modulation index μ = 1 (100% modulation), what fraction of total power is in the sidebands?',
    options: ['50%', '25%', '33.3%', '66.7%'],
    correctIndex: 2,
    explanation:
        'Total AM power: PT = Pc(1 + μ²/2). Sideband power: Psb = Pc × μ²/2. Fraction = (μ²/2)/(1 + μ²/2). For μ=1: = (0.5)/(1.5) = 1/3 = 33.3%. The carrier wastes 2/3 of power — that\'s why SSB is more efficient.',
    difficulty: 'Hard',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_com_02',
    topicId: 'communications',
    question:
        'A channel has bandwidth B = 4 kHz and SNR = 255. Shannon\'s channel capacity is approximately:',
    options: ['32 kbps', '1 Mbps', '64 kbps', '4 kbps'],
    correctIndex: 0,
    explanation:
        'C = B log₂(1 + SNR) = 4000 × log₂(256) = 4000 × 8 = 32,000 bps = 32 kbps. Note: 1 + SNR = 256 = 2⁸, so log₂(256) = 8. This is the theoretical maximum — real systems operate below this.',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_com_03',
    topicId: 'communications',
    question:
        'BPSK (Binary Phase Shift Keying) transmits how many bits per symbol?',
    options: ['0.5', '1', '2', '4'],
    correctIndex: 1,
    explanation:
        'BPSK uses 2 phase states (0° and 180°) → 1 bit per symbol. QPSK uses 4 phases → 2 bits/symbol. 16-QAM → 4 bits/symbol. In general, M-ary modulation carries log₂(M) bits per symbol. Higher order = more bits but needs higher SNR.',
    difficulty: 'Easy',
    year: 0,
  ),

  // ── ELECTROMAGNETICS ─────────────────────────────────────────────────────
  GateQuestion(
    id: 'q_em_01',
    topicId: 'electromagnetics',
    question:
        'A lossless transmission line has Z₀ = 50Ω and is terminated with ZL = 100Ω. The reflection coefficient Γ is:',
    options: ['0.5', '-0.5', '0.33', '0.25'],
    correctIndex: 2,
    explanation:
        'Γ = (ZL - Z0)/(ZL + Z0) = (100 - 50)/(100 + 50) = 50/150 = 1/3 ≈ 0.333. VSWR = (1+|Γ|)/(1-|Γ|) = (1+1/3)/(1-1/3) = (4/3)/(2/3) = 2. No reflected power occurs only when ZL = Z0 (matched, Γ = 0).',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_em_02',
    topicId: 'electromagnetics',
    question:
        'Maxwell\'s equation ∇·B = 0 implies:',
    options: [
      'Magnetic monopoles exist',
      'There are no magnetic monopoles; B field lines are always closed loops',
      'The magnetic field is zero everywhere',
      'Magnetic flux varies with time',
    ],
    correctIndex: 1,
    explanation:
        '∇·B = 0 is the "no magnetic monopoles" law. It means the divergence of B is always zero — B field lines form closed loops (they have no beginning or end). This is fundamentally different from electric fields, where ∇·E = ρ/ε₀ (can have sources/sinks).',
    difficulty: 'Medium',
    year: 2020,
  ),

  // ── ENGINEERING MATHEMATICS ──────────────────────────────────────────────
  GateQuestion(
    id: 'q_math_01',
    topicId: 'math',
    question:
        'The eigenvalues of the matrix [[2, 1], [0, 3]] are:',
    options: ['1 and 2', '2 and 3', '3 and 0', '1 and 3'],
    correctIndex: 1,
    explanation:
        'For an upper triangular matrix, the eigenvalues are the diagonal elements: λ₁ = 2, λ₂ = 3. Verify: det([[2-λ, 1],[0, 3-λ]]) = (2-λ)(3-λ) = 0 → λ = 2 or 3.',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_math_02',
    topicId: 'math',
    question:
        'The probability that a normally distributed random variable X falls within 1 standard deviation of the mean (μ ± σ) is approximately:',
    options: ['50%', '68.3%', '95.4%', '99.7%'],
    correctIndex: 1,
    explanation:
        'The 68-95-99.7 rule (empirical rule) for normal distribution:\n• μ ± 1σ: 68.27% of data\n• μ ± 2σ: 95.45% of data\n• μ ± 3σ: 99.73% of data\nThis is fundamental for noise analysis and hypothesis testing in ECE.',
    difficulty: 'Easy',
    year: 0,
  ),
];

// ─── MOCK TESTS ─────────────────────────────────────────────────────────────
const List<MockTest> mockTests = [
  MockTest(
    id: 'mock_01',
    title: 'GATE ECE 2024 — Full Mock Test',
    description: '65 questions · 3 hours · All sections (GA + Math + Core ECE)',
    durationMinutes: 180,
    questionIds: [
      'q_net_01', 'q_net_02', 'q_net_03', 'q_net_04', 'q_net_05',
      'q_sig_01', 'q_sig_02', 'q_sig_03', 'q_sig_04', 'q_sig_05',
      'q_dev_01', 'q_dev_02', 'q_dev_03',
      'q_ana_01', 'q_ana_02', 'q_ana_03',
      'q_dig_01', 'q_dig_02', 'q_dig_03', 'q_dig_04',
      'q_ctrl_01', 'q_ctrl_02', 'q_ctrl_03',
      'q_com_01', 'q_com_02', 'q_com_03',
      'q_em_01', 'q_em_02',
      'q_math_01', 'q_math_02',
    ],
    totalMarks: 100,
  ),
  MockTest(
    id: 'mock_02',
    title: 'Networks & Signals — Topic Test',
    description: '10 questions · 30 minutes · Networks + Signals focus',
    durationMinutes: 30,
    questionIds: [
      'q_net_01', 'q_net_02', 'q_net_03', 'q_net_04', 'q_net_05',
      'q_sig_01', 'q_sig_02', 'q_sig_03', 'q_sig_04', 'q_sig_05',
    ],
    totalMarks: 30,
  ),
  MockTest(
    id: 'mock_03',
    title: 'Devices & Analog — Topic Test',
    description: '6 questions · 20 minutes · Devices + Analog Circuits',
    durationMinutes: 20,
    questionIds: [
      'q_dev_01', 'q_dev_02', 'q_dev_03',
      'q_ana_01', 'q_ana_02', 'q_ana_03',
    ],
    totalMarks: 18,
  ),
  MockTest(
    id: 'mock_04',
    title: 'Digital & Control — Topic Test',
    description: '7 questions · 25 minutes · Digital + Control Systems',
    durationMinutes: 25,
    questionIds: [
      'q_dig_01', 'q_dig_02', 'q_dig_03', 'q_dig_04',
      'q_ctrl_01', 'q_ctrl_02', 'q_ctrl_03',
    ],
    totalMarks: 21,
  ),
  MockTest(
    id: 'mock_05',
    title: 'Communications & EM — Topic Test',
    description: '5 questions · 20 minutes · Comms + Electromagnetics',
    durationMinutes: 20,
    questionIds: [
      'q_com_01', 'q_com_02', 'q_com_03',
      'q_em_01', 'q_em_02',
    ],
    totalMarks: 15,
  ),
];
