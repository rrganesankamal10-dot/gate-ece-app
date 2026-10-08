// lib/data/papers_data.dart

class GatePaperQuestion {
  final String id;
  final int year;
  final int paperNumber;
  final String question;
  final List<String> options;
  final int answer; // 0-3
  final String explanation;
  final String topic;
  final int marks; // 1 or 2

  const GatePaperQuestion({
    required this.id,
    required this.year,
    required this.paperNumber,
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
    required this.topic,
    required this.marks,
  });
}

class GatePaper {
  final int year;
  final int paperNumber;
  final String organizingInstitute;
  final String officialPaperUrl;
  final String officialAnswerKeyUrl;
  final List<GatePaperQuestion> questions;

  const GatePaper({
    required this.year,
    required this.paperNumber,
    required this.organizingInstitute,
    required this.officialPaperUrl,
    required this.officialAnswerKeyUrl,
    required this.questions,
  });

  int get totalMarks => questions.fold(0, (sum, q) => sum + q.marks);
}

// ============================================================================
// GATE ECE 2024 (Organizing Institute: IISc Bangalore)
// ============================================================================
const List<GatePaperQuestion> _questions2024 = [
  GatePaperQuestion(
    id: 'p24_01',
    year: 2024,
    paperNumber: 1,
    question:
        'An LTI system has impulse response h(t) = e^(-2t) u(t). The step response s(t) for t >= 0 is:',
    options: [
      '0.5(1 - e^(-2t))',
      '0.5(1 + e^(-2t))',
      '(1 - e^(-2t))',
      '2(1 - e^(-2t))',
    ],
    answer: 0,
    explanation:
        'Step 1: The step response is the running integral of the impulse response:\n'
        's(t) = ∫₀ᵗ h(τ) dτ for t >= 0.\n'
        'Step 2: s(t) = ∫₀ᵗ e^(-2τ) dτ = [-e^(-2τ) / 2] from 0 to t.\n'
        'Step 3: = (-e^(-2t) / 2) - (-1 / 2) = 0.5 · (1 - e^(-2t)).\n'
        'Correct Answer: Option (A).',
    topic: 'Signals & Systems',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p24_02',
    year: 2024,
    paperNumber: 1,
    question:
        'A zero-mean Gaussian random variable X has variance σ² = 9. The probability P(X > 3) is approximately:',
    options: ['0.1587', '0.5000', '0.0228', '0.3413'],
    answer: 0,
    explanation:
        'Step 1: Standard deviation σ = √9 = 3.\n'
        'Step 2: Normalize to standard normal variable Z = (X - μ) / σ = (3 - 0) / 3 = 1.\n'
        'Step 3: P(X > 3) = P(Z > 1) = Q(1) ≈ 1 - 0.8413 = 0.1587.\n'
        'Correct Answer: Option (A).',
    topic: 'Engineering Mathematics',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p24_03',
    year: 2024,
    paperNumber: 1,
    question:
        'In an N-channel MOSFET operating in saturation, if the channel length L is doubled while keeping all voltages and width W constant, the drain current ID will:',
    options: [
      'Double',
      'Halve',
      'Remain unchanged',
      'Increase by 4 times',
    ],
    answer: 1,
    explanation:
        'Step 1: In saturation, ID = (1/2) · μn · Cox · (W/L) · (VGS - Vth)².\n'
        'Step 2: ID is inversely proportional to L (ID ∝ 1/L).\n'
        'Step 3: If L is doubled (2L), ID becomes ID / 2 (halved).\n'
        'Correct Answer: Option (B).',
    topic: 'Electronic Devices (EDC)',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p24_04',
    year: 2024,
    paperNumber: 1,
    question:
        'For a negative feedback control system with open-loop transfer function G(s)H(s) = K / [s(s + 2)(s + 4)], the angle of asymptotes of the root locus are:',
    options: [
      '±60°, 180°',
      '±45°, ±135°',
      '0°, 120°, 240°',
      '±90°, 270°',
    ],
    answer: 0,
    explanation:
        'Step 1: Number of poles P = 3 (s = 0, -2, -4). Number of zeros Z = 0.\n'
        'Step 2: Number of asymptotes = P - Z = 3 - 0 = 3.\n'
        'Step 3: Angle of asymptotes θ = (2q + 1) · 180° / (P - Z) for q = 0, 1, 2.\n'
        'For q = 0: θ₀ = 180° / 3 = 60°.\n'
        'For q = 1: θ₁ = 3 × 180° / 3 = 180°.\n'
        'For q = 2: θ₂ = 5 × 180° / 3 = 300° (or -60°).\n'
        'Hence angles are ±60° and 180°. Correct Answer: Option (A).',
    topic: 'Control Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p24_05',
    year: 2024,
    paperNumber: 1,
    question:
        'A plane electromagnetic wave propagating in free space has electric field E = 10 cos(ωt - βz) a_x V/m. The average Poynting vector is:',
    options: [
      '0.133 a_z W/m²',
      '0.265 a_z W/m²',
      '0.066 a_z W/m²',
      '1.33 a_z W/m²',
    ],
    answer: 0,
    explanation:
        'Step 1: Time-average Poynting vector P_avg = (1/2) · (E_peak² / η₀) a_k.\n'
        'Step 2: In free space, intrinsic impedance η₀ = 120π ≈ 377 Ω.\n'
        'Step 3: P_avg = (1/2) · (10² / 377) = 100 / 754 ≈ 0.1326 W/m² in +z direction (a_z).\n'
        'Correct Answer: Option (A).',
    topic: 'Electromagnetics',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p24_06',
    year: 2024,
    paperNumber: 1,
    question:
        'An ideal op-amp inverting amplifier has input resistor Rin = 10 kΩ and feedback resistor Rf = 100 kΩ. If input voltage Vin = 0.5 V, the output voltage Vout is:',
    options: ['-5.0 V', '+5.0 V', '-10.0 V', '+0.05 V'],
    answer: 0,
    explanation:
        'Step 1: Closed-loop gain Av = -Rf / Rin = -100 kΩ / 10 kΩ = -10.\n'
        'Step 2: Vout = Av · Vin = -10 × 0.5 V = -5.0 V.\n'
        'Correct Answer: Option (A).',
    topic: 'Analog Electronics',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p24_07',
    year: 2024,
    paperNumber: 1,
    question:
        'The minimum number of 2-to-1 multiplexers required to realize an arbitrary 4-input Boolean function is:',
    options: ['7', '8', '15', '3'],
    answer: 0,
    explanation:
        'Step 1: To implement a 4-variable function using only 2-to-1 MUXes:\n'
        'Step 2: Using Shannon expansion: 4 MUXes for the first stage, 2 for the second stage, 1 for the final stage.\n'
        'Step 3: Total = 4 + 2 + 1 = 7 multiplexers.\n'
        'Correct Answer: Option (A).',
    topic: 'Digital Circuits',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p24_08',
    year: 2024,
    paperNumber: 1,
    question:
        'In a BPSK digital communication system over AWGN with bit energy Eb and noise spectral density N0/2, the bit error probability is given by:',
    options: [
      'Q(√(2Eb / N0))',
      'Q(√(Eb / N0))',
      '0.5 · erfc(√(Eb / 2N0))',
      'Q(√(Eb / 2N0))',
    ],
    answer: 0,
    explanation:
        'Step 1: BPSK distance between constellation points d = 2√Eb.\n'
        'Step 2: Pe = Q(d / (2σ)) = Q(2√Eb / (2√(N0/2))) = Q(√(2Eb / N0)).\n'
        'Correct Answer: Option (A).',
    topic: 'Communications',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p24_09',
    year: 2024,
    paperNumber: 1,
    question:
        'For a series RLC circuit with R = 2 Ω, L = 1 H, and C = 1 F, the damping ratio ζ is:',
    options: ['1.0', '0.5', '2.0', '0.25'],
    answer: 0,
    explanation:
        'Step 1: Characteristic equation of series RLC: s² + (R/L)s + 1/(LC) = 0.\n'
        'Step 2: Comparing with s² + 2ζωn s + ωn² = 0:\n'
        'ωn = 1 / √(LC) = 1 / √(1 × 1) = 1 rad/s.\n'
        '2ζωn = R / L → 2ζ(1) = 2 / 1 = 2 → ζ = 1.0 (Critically damped).\n'
        'Correct Answer: Option (A).',
    topic: 'Networks & Circuits',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p24_10',
    year: 2024,
    paperNumber: 1,
    question:
        'The rank of the matrix A = [[1, 2, 3], [2, 4, 6], [3, 6, 9]] is:',
    options: ['1', '2', '3', '0'],
    answer: 0,
    explanation:
        'Step 1: Notice that Row 2 = 2 × Row 1, and Row 3 = 3 × Row 1.\n'
        'Step 2: Row operations R2 → R2 - 2R1, R3 → R3 - 3R1 yield [[1, 2, 3], [0, 0, 0], [0, 0, 0]].\n'
        'Step 3: Only 1 non-zero row remains, so Rank(A) = 1.\n'
        'Correct Answer: Option (A).',
    topic: 'Engineering Mathematics',
    marks: 1,
  ),
];

// ============================================================================
// GATE ECE 2023 (Organizing Institute: IIT Kanpur)
// ============================================================================
const List<GatePaperQuestion> _questions2023 = [
  GatePaperQuestion(
    id: 'p23_01',
    year: 2023,
    paperNumber: 1,
    question:
        'For a series circuit with R = 10 Ω, L = 0.1 H, and C = 10 μF, the resonant angular frequency ω0 is:',
    options: ['100 rad/s', '316.2 rad/s', '1000 rad/s', '3162 rad/s'],
    answer: 2,
    explanation:
        'Step 1: Resonant frequency ω0 = 1 / √(LC).\n'
        'Step 2: L = 0.1 H, C = 10 × 10^(-6) F → LC = 10^(-6) s².\n'
        'Step 3: √(LC) = √(10^(-6)) = 10^(-3) = 0.001.\n'
        'Step 4: ω0 = 1 / 0.001 = 1000 rad/s.\n'
        'Correct Answer: Option (C).',
    topic: 'Networks & Circuits',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p23_02',
    year: 2023,
    paperNumber: 1,
    question:
        'The Nyquist sampling rate for a signal x(t) = sinc(400t) · sinc(600t) is:',
    options: ['500 Hz', '1000 Hz', '2000 Hz', '400 Hz'],
    answer: 1,
    explanation:
        'Step 1: For sinc(2Bt), bandwidth is B. For sinc(400t), B1 = 200 Hz. For sinc(600t), B2 = 300 Hz.\n'
        'Step 2: Multiplication in time corresponds to convolution in frequency.\n'
        'Step 3: The maximum frequency of the product signal is fmax = B1 + B2 = 200 + 300 = 500 Hz.\n'
        'Step 4: Nyquist sampling rate fs = 2 · fmax = 2 × 500 Hz = 1000 Hz.\n'
        'Correct Answer: Option (B).',
    topic: 'Signals & Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p23_03',
    year: 2023,
    paperNumber: 1,
    question:
        'In a silicon pn junction at room temperature (300 K), the built-in potential Vbi for doping Na = 10^16 cm^-3 and Nd = 10^16 cm^-3 (with ni = 1.5 × 10^10 cm^-3, VT = 26 mV) is approximately:',
    options: ['0.70 V', '0.55 V', '0.35 V', '1.10 V'],
    answer: 0,
    explanation:
        'Step 1: Built-in potential formula: Vbi = VT · ln((Na · Nd) / ni²).\n'
        'Step 2: Na · Nd / ni² = (10^16 × 10^16) / (2.25 × 10^20) = 10^32 / (2.25 × 10^20) = 4.44 × 10^11.\n'
        'Step 3: ln(4.44 × 10^11) ≈ 26.8.\n'
        'Step 4: Vbi = 0.026 × 26.8 ≈ 0.697 V ≈ 0.70 V.\n'
        'Correct Answer: Option (A).',
    topic: 'Electronic Devices (EDC)',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p23_04',
    year: 2023,
    paperNumber: 1,
    question:
        'The closed-loop transfer function of a unity feedback system is T(s) = 25 / (s² + 6s + 25). The peak overshoot Mp for a unit step input is approximately:',
    options: ['9.5%', '16.3%', '25.0%', '4.3%'],
    answer: 0,
    explanation:
        'Step 1: Standard form: ωn² = 25 → ωn = 5 rad/s. 2ζωn = 6 → 2ζ(5) = 6 → ζ = 0.6.\n'
        'Step 2: Peak overshoot Mp = e^(-πζ / √(1 - ζ²)) × 100%.\n'
        'Step 3: For ζ = 0.6: √(1 - 0.36) = 0.8.\n'
        'Step 4: πζ / √(1 - ζ²) = π × 0.6 / 0.8 = 0.75π ≈ 2.356.\n'
        'Step 5: Mp = e^(-2.356) ≈ 0.0948 = 9.48% ≈ 9.5%.\n'
        'Correct Answer: Option (A).',
    topic: 'Control Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p23_05',
    year: 2023,
    paperNumber: 1,
    question:
        'A lossless transmission line with characteristic impedance Z0 = 50 Ω is terminated with load ZL = (25 + j0) Ω. The Voltage Standing Wave Ratio (VSWR) is:',
    options: ['2.0', '1.5', '3.0', '0.5'],
    answer: 0,
    explanation:
        'Step 1: Reflection coefficient Γ = (ZL - Z0) / (ZL + Z0) = (25 - 50) / (25 + 50) = -25 / 75 = -1/3.\n'
        'Step 2: Magnitude |Γ| = 1/3.\n'
        'Step 3: VSWR = (1 + |Γ|) / (1 - |Γ|) = (1 + 1/3) / (1 - 1/3) = (4/3) / (2/3) = 2.0.\n'
        'Correct Answer: Option (A).',
    topic: 'Electromagnetics',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p23_06',
    year: 2023,
    paperNumber: 1,
    question:
        'If an analog signal with bandwidth 3.5 kHz is sampled at 8 kHz and encoded using an 8-bit PCM system, the transmission bit rate is:',
    options: ['64 kbps', '56 kbps', '28 kbps', '32 kbps'],
    answer: 0,
    explanation:
        'Step 1: Bit rate Rb = n · fs, where n = number of bits per sample, fs = sampling frequency.\n'
        'Step 2: n = 8 bits, fs = 8000 samples/s.\n'
        'Step 3: Rb = 8 × 8000 = 64,000 bps = 64 kbps.\n'
        'Correct Answer: Option (A).',
    topic: 'Communications',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p23_07',
    year: 2023,
    paperNumber: 1,
    question:
        'A Mod-16 ripple counter uses flip-flops each having propagation delay of 25 ns. The maximum clock frequency at which the counter can operate reliably is:',
    options: ['10 MHz', '40 MHz', '20 MHz', '4 MHz'],
    answer: 0,
    explanation:
        'Step 1: Mod-16 requires N = log₂(16) = 4 flip-flops.\n'
        'Step 2: In a ripple (asynchronous) counter, delays add up: T_total = N · t_pd = 4 × 25 ns = 100 ns.\n'
        'Step 3: Maximum clock frequency fmax = 1 / T_total = 1 / (100 × 10^-9) = 10 × 10^6 Hz = 10 MHz.\n'
        'Correct Answer: Option (A).',
    topic: 'Digital Circuits',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p23_08',
    year: 2023,
    paperNumber: 1,
    question:
        'The value of the line integral ∫_C (y dx + x dy) along the unit circle C traversed counter-clockwise is:',
    options: ['0', 'π', '2π', '1'],
    answer: 0,
    explanation:
        'Step 1: By Green\'s Theorem: ∮_C (P dx + Q dy) = ∬_R (∂Q/∂x - ∂P/∂y) dA.\n'
        'Step 2: Here P = y → ∂P/∂y = 1. Q = x → ∂Q/∂x = 1.\n'
        'Step 3: ∂Q/∂x - ∂P/∂y = 1 - 1 = 0.\n'
        'Step 4: The integral is identically 0. Correct Answer: Option (A).',
    topic: 'Engineering Mathematics',
    marks: 1,
  ),
];

// ============================================================================
// GATE ECE 2022 (Organizing Institute: IIT Kharagpur)
// ============================================================================
const List<GatePaperQuestion> _questions2022 = [
  GatePaperQuestion(
    id: 'p22_01',
    year: 2022,
    paperNumber: 1,
    question:
        'The maximum power that can be transferred from a source with open-circuit voltage 20 V and internal resistance 5 Ω to a variable load is:',
    options: ['20 W', '40 W', '10 W', '80 W'],
    answer: 0,
    explanation:
        'Step 1: Maximum Power Transfer Theorem: Load RL = Rth = 5 Ω.\n'
        'Step 2: Pmax = Vth² / (4 · Rth) = (20)² / (4 × 5) = 400 / 20 = 20 W.\n'
        'Correct Answer: Option (A).',
    topic: 'Networks & Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_02',
    year: 2022,
    paperNumber: 1,
    question:
        'The Fourier transform of the signal x(t) = e^(-3|t|) is:',
    options: [
      '6 / (9 + ω²)',
      '3 / (9 + ω²)',
      '1 / (3 + jω)',
      '2 / (3 + ω²)',
    ],
    answer: 0,
    explanation:
        'Step 1: Standard Fourier transform pair: e^(-a|t|) ↔ 2a / (a² + ω²).\n'
        'Step 2: Here a = 3.\n'
        'Step 3: X(jω) = 2(3) / (3² + ω²) = 6 / (9 + ω²).\n'
        'Correct Answer: Option (A).',
    topic: 'Signals & Systems',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_03',
    year: 2022,
    paperNumber: 1,
    question:
        'An AM signal is generated with carrier power Pc = 100 W and modulation index μ = 0.8. The total transmitted power is:',
    options: ['132 W', '164 W', '140 W', '100 W'],
    answer: 0,
    explanation:
        'Step 1: Total AM power Pt = Pc · (1 + μ² / 2).\n'
        'Step 2: μ = 0.8 → μ² = 0.64 → μ² / 2 = 0.32.\n'
        'Step 3: Pt = 100 · (1 + 0.32) = 132 W.\n'
        'Correct Answer: Option (A).',
    topic: 'Communications',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_04',
    year: 2022,
    paperNumber: 1,
    question:
        'The gain margin of a feedback system with loop transfer function G(s)H(s) = 2 / [s(s + 1)(s + 2)] is:',
    options: ['9.54 dB', '6.02 dB', '12.04 dB', '3.01 dB'],
    answer: 0,
    explanation:
        'Step 1: Phase crossover frequency ω_pc: Phase angle = -90° - arctan(ω) - arctan(ω/2) = -180°.\n'
        'Step 2: arctan(ω) + arctan(ω/2) = 90° → ω · (ω/2) = 1 → ω² = 2 → ω_pc = √2 rad/s.\n'
        'Step 3: Magnitude at ω_pc: |G(j√2)H(j√2)| = 2 / [√2 · √(1+2) · √(4+2)] = 2 / [√2 · √3 · √6] = 2 / 6 = 1/3.\n'
        'Step 4: Gain Margin GM = 1 / |G(jω_pc)| = 3.\n'
        'Step 5: In dB: GM = 20 log₁₀(3) ≈ 20 × 0.4771 = 9.54 dB.\n'
        'Correct Answer: Option (A).',
    topic: 'Control Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p22_05',
    year: 2022,
    paperNumber: 1,
    question:
        'The Boolean function F = A B + A B\' C + A\' B C simplifies to:',
    options: [
      'A C + B C',
      'A B + B C',
      'A C + A B',
      'A + B C',
    ],
    answer: 2,
    explanation:
        'Step 1: F = A B + A B\' C + A\' B C.\n'
        'Step 2: Combine terms: A B + A B\' C = A (B + B\' C) = A (B + C) = A B + A C.\n'
        'Step 3: F = A B + A C + A\' B C = A C + B (A + A\' C) = A C + B (A + C) = A C + A B + B C.\n'
        'Step 4: By consensus theorem, B C is redundant because A C and A B cover it.\n'
        'Hence F = A B + A C = A C + A B. Correct Answer: Option (C).',
    topic: 'Digital Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_06',
    year: 2022,
    paperNumber: 1,
    question:
        'A silicon sample has donor concentration Nd = 10^17 cm^-3 and mobility μn = 1000 cm²/(V·s). The resistivity ρ of the sample (with q = 1.6 × 10^-19 C) is approximately:',
    options: ['0.0625 Ω·cm', '0.625 Ω·cm', '0.016 Ω·cm', '6.25 Ω·cm'],
    answer: 0,
    explanation:
        'Step 1: Conductivity σ ≈ q · Nd · μn (electrons are majority carriers).\n'
        'Step 2: σ = (1.6 × 10^-19 C) × (10^17 cm^-3) × (1000 cm²/V·s) = 1.6 × 10 = 16 (Ω·cm)^-1.\n'
        'Step 3: Resistivity ρ = 1 / σ = 1 / 16 = 0.0625 Ω·cm.\n'
        'Correct Answer: Option (A).',
    topic: 'Electronic Devices (EDC)',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p22_07',
    year: 2022,
    paperNumber: 1,
    question:
        'An op-amp circuit with R1 = 1 kΩ, Rf = 10 kΩ, and input offset voltage Vio = 2 mV will produce an output offset voltage of:',
    options: ['22 mV', '20 mV', '2 mV', '11 mV'],
    answer: 0,
    explanation:
        'Step 1: Output offset voltage Vo_offset = Vio · (1 + Rf / R1).\n'
        'Step 2: Gain = 1 + 10 kΩ / 1 kΩ = 1 + 10 = 11.\n'
        'Step 3: Vo_offset = 2 mV × 11 = 22 mV.\n'
        'Correct Answer: Option (A).',
    topic: 'Analog Electronics',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_08',
    year: 2022,
    paperNumber: 1,
    question:
        'The eigenvalues of a 2×2 matrix are 3 and 5. The determinant and trace of the matrix are, respectively:',
    options: ['15 and 8', '8 and 15', '15 and 2', '2 and 15'],
    answer: 0,
    explanation:
        'Step 1: Trace = sum of eigenvalues = 3 + 5 = 8.\n'
        'Step 2: Determinant = product of eigenvalues = 3 × 5 = 15.\n'
        'Correct Answer: Option (A).',
    topic: 'Engineering Mathematics',
    marks: 1,
  ),
];

// ============================================================================
// GATE ECE 2021 (Organizing Institute: IIT Bombay)
// ============================================================================
const List<GatePaperQuestion> _questions2021 = [
  GatePaperQuestion(
    id: 'p21_01',
    year: 2021,
    paperNumber: 1,
    question:
        'The two-port impedance parameters Z11 and Z21 of a symmetric T-network with series arms Ra = 10 Ω, Rb = 10 Ω and shunt arm Rc = 20 Ω are:',
    options: [
      'Z11 = 30 Ω, Z21 = 20 Ω',
      'Z11 = 20 Ω, Z21 = 30 Ω',
      'Z11 = 10 Ω, Z21 = 20 Ω',
      'Z11 = 40 Ω, Z21 = 20 Ω',
    ],
    answer: 0,
    explanation:
        'Step 1: In a T-network with series arm Ra at port 1 and shunt arm Rc:\n'
        'Z11 = V1 / I1 when I2 = 0 → Z11 = Ra + Rc = 10 + 20 = 30 Ω.\n'
        'Step 2: Z21 = V2 / I1 when I2 = 0 → V2 is the voltage across Rc = I1 · Rc.\n'
        'Thus Z21 = Rc = 20 Ω.\n'
        'Correct Answer: Option (A).',
    topic: 'Networks & Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_02',
    year: 2021,
    paperNumber: 1,
    question:
        'A continuous-time signal x(t) = 5 cos(100πt) + 10 sin(300πt). The fundamental period T0 of x(t) is:',
    options: ['0.02 s', '0.01 s', '0.04 s', '0.05 s'],
    answer: 0,
    explanation:
        'Step 1: Frequency 1: ω1 = 100π → f1 = 50 Hz → T1 = 1/50 = 0.02 s.\n'
        'Step 2: Frequency 2: ω2 = 300π → f2 = 150 Hz → T2 = 1/150 s.\n'
        'Step 3: Fundamental frequency f0 = GCD(f1, f2) = GCD(50, 150) = 50 Hz.\n'
        'Step 4: Fundamental period T0 = 1 / f0 = 1 / 50 = 0.02 s.\n'
        'Correct Answer: Option (A).',
    topic: 'Signals & Systems',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_03',
    year: 2021,
    paperNumber: 1,
    question:
        'The characteristic equation of a feedback control system is s³ + 2s² + 4s + K = 0. For the system to remain stable, the range of K is:',
    options: ['0 < K < 8', 'K > 8', '0 < K < 4', 'K < 0'],
    answer: 0,
    explanation:
        'Step 1: Construct Routh array:\n'
        'Row s³: 1   4\n'
        'Row s²: 2   K\n'
        'Row s¹: (2×4 - 1×K) / 2 = (8 - K) / 2\n'
        'Row s⁰: K\n'
        'Step 2: For stability, all 1st column entries must be > 0:\n'
        '• (8 - K) / 2 > 0 → K < 8\n'
        '• K > 0\n'
        'Hence 0 < K < 8. Correct Answer: Option (A).',
    topic: 'Control Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p21_04',
    year: 2021,
    paperNumber: 1,
    question:
        'In frequency modulation (FM), Carson\'s rule gives the transmission bandwidth as:',
    options: [
      '2 · (Δf + fm)',
      '2 · Δf',
      '2 · fm',
      'Δf + 2 · fm',
    ],
    answer: 0,
    explanation:
        'Step 1: Carson\'s rule approximates FM bandwidth containing 98% of signal power.\n'
        'Step 2: BW = 2 · (Δf + fm) = 2 · fm · (1 + β), where β = Δf / fm is the modulation index.\n'
        'Correct Answer: Option (A).',
    topic: 'Communications',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_05',
    year: 2021,
    paperNumber: 1,
    question:
        'A uniform plane wave in good conductor (conductivity σ, permeability μ, frequency ω) has skin depth δ given by:',
    options: [
      '√(2 / (ωμσ))',
      '√(ωμ / (2σ))',
      '2 / √(ωμσ)',
      '1 / (ωμσ)',
    ],
    answer: 0,
    explanation:
        'Step 1: Skin depth δ is the distance over which wave amplitude decays by a factor of 1/e.\n'
        'Step 2: For a good conductor: δ = 1 / α = √(2 / (ωμσ)).\n'
        'Correct Answer: Option (A).',
    topic: 'Electromagnetics',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_06',
    year: 2021,
    paperNumber: 1,
    question:
        'The minimum number of 2-input NAND gates required to implement a 2-input XOR gate is:',
    options: ['4', '5', '3', '6'],
    answer: 0,
    explanation:
        'Step 1: An XOR gate A ⊕ B = A\'B + AB\' can be realized with exactly 4 two-input NAND gates.\n'
        'Step 2: Gate 1: G1 = NAND(A, B). Gate 2: NAND(A, G1). Gate 3: NAND(B, G1). Gate 4: NAND(Gate2, Gate3) = A ⊕ B.\n'
        'Correct Answer: Option (A).',
    topic: 'Digital Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_07',
    year: 2021,
    paperNumber: 1,
    question:
        'A common-emitter amplifier with load resistor RC = 2 kΩ and collector quiescent current IC = 2 mA has small-signal transconductance gm (at VT = 25 mV) equal to:',
    options: ['80 mA/V', '40 mA/V', '50 mA/V', '100 mA/V'],
    answer: 0,
    explanation:
        'Step 1: Transconductance formula: gm = IC / VT.\n'
        'Step 2: gm = (2 × 10^-3 A) / (25 × 10^-3 V) = 2 / 25 A/V = 0.08 A/V = 80 mA/V.\n'
        'Correct Answer: Option (A).',
    topic: 'Analog Electronics',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p21_08',
    year: 2021,
    paperNumber: 1,
    question:
        'The solution of the initial value problem dy/dx + 2y = 0 with y(0) = 5 is:',
    options: [
      'y(x) = 5 e^(-2x)',
      'y(x) = 5 e^(2x)',
      'y(x) = 2 e^(-5x)',
      'y(x) = 5 - 2x',
    ],
    answer: 0,
    explanation:
        'Step 1: First-order linear ODE: dy/y = -2 dx.\n'
        'Step 2: Integrating both sides: ln|y| = -2x + C → y(x) = A e^(-2x).\n'
        'Step 3: Initial condition y(0) = 5 → A = 5.\n'
        'Step 4: y(x) = 5 e^(-2x). Correct Answer: Option (A).',
    topic: 'Engineering Mathematics',
    marks: 1,
  ),
];

// ============================================================================
// ALL GATE PAPERS LIST
// ============================================================================
const GatePaper gatePaper2024 = GatePaper(
  year: 2024,
  paperNumber: 1,
  organizingInstitute: 'IISc Bangalore',
  officialPaperUrl: 'https://gate2024.iisc.ac.in',
  officialAnswerKeyUrl: 'https://gate2024.iisc.ac.in',
  questions: _questions2024,
);

const GatePaper gatePaper2023 = GatePaper(
  year: 2023,
  paperNumber: 1,
  organizingInstitute: 'IIT Kanpur',
  officialPaperUrl: 'https://gate.iitk.ac.in',
  officialAnswerKeyUrl: 'https://gate.iitk.ac.in',
  questions: _questions2023,
);

const GatePaper gatePaper2022 = GatePaper(
  year: 2022,
  paperNumber: 1,
  organizingInstitute: 'IIT Kharagpur',
  officialPaperUrl: 'https://gate.iitkgp.ac.in',
  officialAnswerKeyUrl: 'https://gate.iitkgp.ac.in',
  questions: _questions2022,
);

const GatePaper gatePaper2021 = GatePaper(
  year: 2021,
  paperNumber: 1,
  organizingInstitute: 'IIT Bombay',
  officialPaperUrl: 'https://gate.iitb.ac.in',
  officialAnswerKeyUrl: 'https://gate.iitb.ac.in',
  questions: _questions2021,
);

const List<GatePaper> allGatePapers = [
  gatePaper2024,
  gatePaper2023,
  gatePaper2022,
  gatePaper2021,
];