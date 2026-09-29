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
  final List<GatePaperQuestion> questions;

  const GatePaper({
    required this.year,
    required this.paperNumber,
    required this.questions,
  });

  int get totalMarks => questions.fold(0, (sum, q) => sum + q.marks);
}

// ─── 2023 GATE ECE PAPER ────────────────────────────────────────────────────
const List<GatePaperQuestion> _questions2023 = [
  GatePaperQuestion(
    id: 'p23_01',
    year: 2023,
    paperNumber: 1,
    question:
        'For the circuit with R = 10 Ω, L = 0.1 H, C = 100 μF connected in series, the resonant frequency ω₀ is:',
    options: ['100 rad/s', '316.2 rad/s', '1000 rad/s', '31.62 rad/s'],
    answer: 2,
    explanation:
        'Step 1: Resonant frequency formula is ω₀ = 1/√(LC).\n'
        'Step 2: L = 0.1 H, C = 100 μF = 100 × 10⁻⁶ F.\n'
        'Step 3: LC = 0.1 × 100 × 10⁻⁶ = 10⁻⁵.\n'
        'Step 4: √(LC) = √(10⁻⁵) = 10⁻²·⁵ ≈ 3.162 × 10⁻³.\n'
        'Step 5: ω₀ = 1/3.162×10⁻³ ≈ 1000 rad/s. Answer: (c).',
    topic: 'Networks & Circuits',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p23_02',
    year: 2023,
    paperNumber: 1,
    question:
        'The Nyquist sampling rate for a signal with maximum frequency component of 8 kHz is:',
    options: ['4 kHz', '8 kHz', '16 kHz', '32 kHz'],
    answer: 2,
    explanation:
        'Step 1: Nyquist theorem states fs ≥ 2 × fmax to avoid aliasing.\n'
        'Step 2: Here fmax = 8 kHz.\n'
        'Step 3: Minimum sampling rate = 2 × 8000 = 16,000 Hz = 16 kHz.\n'
        'Step 4: Sampling below this rate causes aliasing distortion.\n'
        'Step 5: Therefore the Nyquist rate is 16 kHz. Answer: (c).',
    topic: 'Signals & Systems',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p23_03',
    year: 2023,
    paperNumber: 1,
    question:
        'For an N-MOSFET with VTH = 1 V, μnCox(W/L) = 2 mA/V², operating in saturation with VGS = 3 V, the drain current ID is:',
    options: ['2 mA', '4 mA', '8 mA', '16 mA'],
    answer: 1,
    explanation:
        'Step 1: In saturation, ID = (μnCox/2)(W/L)(VGS − VTH)².\n'
        'Step 2: Note: The given kn = μnCox(W/L) = 2 mA/V², so kn/2 = 1 mA/V².\n'
        'Step 3: VGS − VTH = 3 − 1 = 2 V.\n'
        'Step 4: ID = 1 × (2)² = 1 × 4 = 4 mA.\n'
        'Step 5: Verify VDS > VGS − VTH for saturation: Answer is 4 mA. Answer: (b).',
    topic: 'Electronic Devices',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p23_04',
    year: 2023,
    paperNumber: 1,
    question:
        'An inverting op-amp amplifier has Rf = 100 kΩ and Rin = 10 kΩ. If the input is 0.5 V, the output voltage is:',
    options: ['5 V', '−5 V', '50 V', '−50 V'],
    answer: 1,
    explanation:
        'Step 1: The voltage gain of an inverting amplifier is Av = −Rf/Rin.\n'
        'Step 2: Av = −100 kΩ / 10 kΩ = −10.\n'
        'Step 3: Output Vout = Av × Vin = −10 × 0.5 = −5 V.\n'
        'Step 4: The negative sign indicates phase inversion.\n'
        'Step 5: Output is −5 V (assuming no saturation). Answer: (b).',
    topic: 'Analog Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p23_05',
    year: 2023,
    paperNumber: 1,
    question:
        'The closed-loop transfer function T(s) = G(s) / [1 + G(s)H(s)]. For G(s) = 10/(s+2) and unity feedback H(s)=1, the DC gain of the closed-loop system is:',
    options: ['10', '5', '10/12', '5/6'],
    answer: 3,
    explanation:
        'Step 1: T(s) = G(s)/(1 + G(s)H(s)) with H(s)=1.\n'
        'Step 2: T(s) = [10/(s+2)] / [1 + 10/(s+2)] = 10 / (s + 2 + 10) = 10/(s+12).\n'
        'Step 3: DC gain = T(0) = 10/12 = 5/6.\n'
        'Step 4: As s→0, T(s) = 10/(0+12) = 10/12.\n'
        'Step 5: DC gain = 5/6 ≈ 0.833. Answer: (d).',
    topic: 'Control Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p23_06',
    year: 2023,
    paperNumber: 1,
    question:
        'An AM signal has carrier power Pc and modulation index μ = 0.5. The total power of the AM signal is:',
    options: ['1.125 Pc', '1.25 Pc', '1.5 Pc', '2 Pc'],
    answer: 0,
    explanation:
        'Step 1: Total AM power P = Pc(1 + μ²/2).\n'
        'Step 2: μ = 0.5, so μ² = 0.25, μ²/2 = 0.125.\n'
        'Step 3: P = Pc(1 + 0.125) = 1.125 Pc.\n'
        'Step 4: Sideband power = μ²Pc/2 = 0.125Pc (each sideband carries Pc × μ²/4).\n'
        'Step 5: Total power = 1.125 Pc. Answer: (a).',
    topic: 'Communications',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p23_07',
    year: 2023,
    paperNumber: 1,
    question:
        'The Thevenin resistance seen from the load terminals of a circuit, when a 12 V source is short-circuited, is measured by applying a 1 V test source that draws 0.25 A. Rth is:',
    options: ['1 Ω', '2 Ω', '4 Ω', '48 Ω'],
    answer: 2,
    explanation:
        'Step 1: Thevenin resistance is found by deactivating independent sources.\n'
        'Step 2: Apply test voltage Vt = 1 V and measure test current It = 0.25 A.\n'
        'Step 3: Rth = Vt / It = 1 V / 0.25 A = 4 Ω.\n'
        'Step 4: This is the standard procedure: Rth = Voc/Isc or Vtest/Itest.\n'
        'Step 5: Rth = 4 Ω. Answer: (c).',
    topic: 'Networks & Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p23_08',
    year: 2023,
    paperNumber: 1,
    question:
        'In a Shannon channel with bandwidth B = 4 kHz and SNR = 15, the channel capacity C is:',
    options: ['8 kbps', '16 kbps', '32 kbps', '64 kbps'],
    answer: 1,
    explanation:
        'Step 1: Shannon capacity formula: C = B log₂(1 + SNR).\n'
        'Step 2: B = 4000 Hz, SNR = 15.\n'
        'Step 3: 1 + SNR = 16.\n'
        'Step 4: log₂(16) = 4 (since 2⁴ = 16).\n'
        'Step 5: C = 4000 × 4 = 16,000 bps = 16 kbps. Answer: (b).',
    topic: 'Communications',
    marks: 2,
  ),
];

// ─── 2022 GATE ECE PAPER ────────────────────────────────────────────────────
const List<GatePaperQuestion> _questions2022 = [
  GatePaperQuestion(
    id: 'p22_01',
    year: 2022,
    paperNumber: 1,
    question:
        'In a BJT (NPN) with β = 100, if the base current IB = 20 μA, the collector current IC and emitter current IE are respectively:',
    options: [
      'IC = 2 mA, IE = 2.02 mA',
      'IC = 20 mA, IE = 20.2 mA',
      'IC = 200 μA, IE = 220 μA',
      'IC = 2 mA, IE = 1.98 mA',
    ],
    answer: 0,
    explanation:
        'Step 1: BJT relation: IC = β × IB = 100 × 20 μA = 2000 μA = 2 mA.\n'
        'Step 2: IE = IC + IB = 2 mA + 0.02 mA = 2.02 mA.\n'
        'Step 3: Alternatively, IE = (β + 1) × IB = 101 × 20 μA = 2.02 mA.\n'
        'Step 4: Verify KCL at BJT: IE = IB + IC ✓.\n'
        'Step 5: IC = 2 mA, IE = 2.02 mA. Answer: (a).',
    topic: 'Electronic Devices',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_02',
    year: 2022,
    paperNumber: 1,
    question:
        'The Z-transform of x[n] = aⁿu[n] is X(z) = z/(z−a) with ROC: |z| > |a|. For a = 0.5, the pole of X(z) is at:',
    options: ['z = 0', 'z = 0.5', 'z = 2', 'z = −0.5'],
    answer: 1,
    explanation:
        'Step 1: X(z) = z/(z − a). The pole occurs where denominator = 0.\n'
        'Step 2: z − a = 0 → z = a = 0.5.\n'
        'Step 3: There is also a zero at z = 0 (numerator = 0).\n'
        'Step 4: ROC is |z| > 0.5 (outside the pole circle) for causal sequence.\n'
        'Step 5: The pole is at z = 0.5. Answer: (b).',
    topic: 'Signals & Systems',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_03',
    year: 2022,
    paperNumber: 1,
    question:
        'A D flip-flop has D input and clock. The output Q follows D at the:',
    options: [
      'Rising or falling edge of D',
      'Rising edge of clock (in positive-edge triggered FF)',
      'High level of clock (level-sensitive)',
      'Falling edge of D',
    ],
    answer: 1,
    explanation:
        'Step 1: A D flip-flop (edge-triggered) samples D at the clock edge.\n'
        'Step 2: For positive-edge triggered: Q captures D at the rising edge of CLK.\n'
        'Step 3: Between clock edges, Q holds its previous value regardless of D.\n'
        'Step 4: This is different from D latch which is level-sensitive.\n'
        'Step 5: Q follows D at the rising clock edge. Answer: (b).',
    topic: 'Digital Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_04',
    year: 2022,
    paperNumber: 1,
    question:
        'The characteristic equation of a control system is s³ + 2s² + 4s + 8 = 0. Applying Routh-Hurwitz criterion, the system is:',
    options: [
      'Stable',
      'Marginally stable',
      'Unstable with 2 RHP poles',
      'Unstable with 1 RHP pole',
    ],
    answer: 1,
    explanation:
        'Step 1: Routh array: Row 1: 1, 4; Row 2: 2, 8.\n'
        'Step 2: Row 3: (2×4 − 1×8)/2 = (8−8)/2 = 0 → entire row of zeros.\n'
        'Step 3: A row of zeros indicates marginal stability (roots on jω axis).\n'
        'Step 4: Auxiliary equation from Row 2: 2s² + 8 = 0 → s² = −4 → s = ±j2.\n'
        'Step 5: Purely imaginary roots → marginally stable. Answer: (b).',
    topic: 'Control Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p22_05',
    year: 2022,
    paperNumber: 1,
    question:
        'The VSWR of a transmission line with Z₀ = 50 Ω and ZL = 100 Ω is:',
    options: ['1', '2', '3', '0.5'],
    answer: 1,
    explanation:
        'Step 1: Reflection coefficient Γ = (ZL − Z₀)/(ZL + Z₀).\n'
        'Step 2: Γ = (100 − 50)/(100 + 50) = 50/150 = 1/3.\n'
        'Step 3: |Γ| = 1/3.\n'
        'Step 4: VSWR = (1 + |Γ|)/(1 − |Γ|) = (1 + 1/3)/(1 − 1/3) = (4/3)/(2/3) = 2.\n'
        'Step 5: VSWR = 2. Answer: (b).',
    topic: 'Electromagnetics',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_06',
    year: 2022,
    paperNumber: 1,
    question:
        'A 4-bit ripple counter uses JK flip-flops. The maximum frequency of the counter output at the MSB (Q3) when clock frequency is 16 kHz is:',
    options: ['16 kHz', '8 kHz', '2 kHz', '1 kHz'],
    answer: 3,
    explanation:
        'Step 1: A 4-bit ripple counter divides clock by 2 at each stage.\n'
        'Step 2: Q0 toggles at fclock/2, Q1 at fclock/4, Q2 at fclock/8, Q3 at fclock/16.\n'
        'Step 3: MSB = Q3, frequency = 16 kHz / 16 = 1 kHz.\n'
        'Step 4: Each JK flip-flop stage divides frequency by 2.\n'
        'Step 5: MSB frequency = 1 kHz. Answer: (d).',
    topic: 'Digital Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p22_07',
    year: 2022,
    paperNumber: 1,
    question:
        'For an FM signal with message frequency fm = 1 kHz and frequency deviation Δf = 5 kHz, the modulation index β and bandwidth by Carson\'s rule are:',
    options: [
      'β = 0.2, BW = 2.4 kHz',
      'β = 5, BW = 12 kHz',
      'β = 5, BW = 10 kHz',
      'β = 0.2, BW = 12 kHz',
    ],
    answer: 1,
    explanation:
        'Step 1: FM modulation index β = Δf/fm = 5000/1000 = 5.\n'
        'Step 2: Carson\'s rule: BW = 2(Δf + fm) = 2(5 + 1) kHz = 12 kHz.\n'
        'Step 3: Alternatively, BW = 2fm(1 + β) = 2 × 1 × (1 + 5) = 12 kHz.\n'
        'Step 4: High β indicates wideband FM.\n'
        'Step 5: β = 5, BW = 12 kHz. Answer: (b).',
    topic: 'Communications',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p22_08',
    year: 2022,
    paperNumber: 1,
    question:
        'The eigenvalues of matrix A = [[3, 1], [0, 3]] are:',
    options: [
      '3 and 1',
      '3 and 3 (repeated)',
      '0 and 3',
      '1 and 1',
    ],
    answer: 1,
    explanation:
        'Step 1: For an upper triangular matrix, eigenvalues are the diagonal elements.\n'
        'Step 2: Diagonal of [[3,1],[0,3]] is {3, 3}.\n'
        'Step 3: Characteristic equation: (3−λ)(3−λ) = 0 → (λ−3)² = 0.\n'
        'Step 4: Both eigenvalues = 3 (a repeated eigenvalue).\n'
        'Step 5: The matrix is defective (not diagonalizable). Eigenvalues: 3, 3. Answer: (b).',
    topic: 'Engineering Mathematics',
    marks: 2,
  ),
];

// ─── 2021 GATE ECE PAPER ────────────────────────────────────────────────────
const List<GatePaperQuestion> _questions2021 = [
  GatePaperQuestion(
    id: 'p21_01',
    year: 2021,
    paperNumber: 1,
    question:
        'The impulse response of an LTI system is h(t) = e^(−2t)u(t). The system transfer function H(s) is:',
    options: [
      '1/(s+2), ROC: Re(s) > −2',
      '1/(s−2), ROC: Re(s) > 2',
      '2/(s+2), ROC: Re(s) > −2',
      's/(s+2), ROC: Re(s) > −2',
    ],
    answer: 0,
    explanation:
        'Step 1: H(s) = L{h(t)} = L{e^(−2t)u(t)}.\n'
        'Step 2: Laplace transform pair: e^(−at)u(t) ↔ 1/(s+a), ROC: Re(s) > −a.\n'
        'Step 3: Here a = 2, so H(s) = 1/(s+2).\n'
        'Step 4: ROC is Re(s) > −2 (right half-plane from the pole).\n'
        'Step 5: H(s) = 1/(s+2). Answer: (a).',
    topic: 'Signals & Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p21_02',
    year: 2021,
    paperNumber: 1,
    question:
        'A 3-input NAND gate has inputs A=1, B=1, C=0. The output is:',
    options: ['0', '1', 'Undefined', 'High impedance'],
    answer: 1,
    explanation:
        'Step 1: NAND gate output = NOT(A AND B AND C).\n'
        'Step 2: First compute AND: A·B·C = 1·1·0 = 0.\n'
        'Step 3: Apply NOT: NOT(0) = 1.\n'
        'Step 4: For a NAND gate, output is 0 ONLY when all inputs are 1.\n'
        'Step 5: Since C=0, output = 1. Answer: (b).',
    topic: 'Digital Circuits',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_03',
    year: 2021,
    paperNumber: 1,
    question:
        'In a p-n junction diode at room temperature (VT = 26 mV), if the forward bias voltage is VD = 0.6 V and η = 1, the ratio ID/IS is approximately:',
    options: ['e^23.1 ≈ 1.08×10^10', 'e^0.6 ≈ 1.82', 'e^46.2', 'e^12'],
    answer: 0,
    explanation:
        'Step 1: Shockley equation: ID = IS(e^(VD/ηVT) − 1) ≈ IS × e^(VD/VT) for forward bias.\n'
        'Step 2: VD/(ηVT) = 0.6/(1 × 0.026) = 0.6/0.026 ≈ 23.08.\n'
        'Step 3: ID/IS ≈ e^23.08 ≈ 1.08 × 10^10.\n'
        'Step 4: This shows exponential increase of current with voltage in forward bias.\n'
        'Step 5: ID/IS ≈ e^23.1. Answer: (a).',
    topic: 'Electronic Devices',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_04',
    year: 2021,
    paperNumber: 1,
    question:
        'A 12-bit ADC has a reference voltage Vref = 5 V. The resolution (LSB voltage) is approximately:',
    options: ['1.22 mV', '12.2 mV', '0.61 mV', '5 mV'],
    answer: 0,
    explanation:
        'Step 1: Resolution of n-bit ADC = Vref / 2ⁿ (approximate).\n'
        'Step 2: n = 12 bits, 2¹² = 4096.\n'
        'Step 3: ΔV = 5 V / 4096 ≈ 0.001221 V = 1.221 mV.\n'
        'Step 4: Exact formula uses (2ⁿ − 1) in denominator, giving ≈ 1.221 mV.\n'
        'Step 5: Resolution ≈ 1.22 mV. Answer: (a).',
    topic: 'Digital Circuits',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p21_05',
    year: 2021,
    paperNumber: 1,
    question:
        'Maxwell\'s equation ∇ × H = J + ∂D/∂t represents:',
    options: [
      'Faraday\'s law of electromagnetic induction',
      'Ampere\'s law with Maxwell\'s displacement current',
      'Gauss\'s law for magnetic fields',
      'Gauss\'s law for electric fields',
    ],
    answer: 1,
    explanation:
        'Step 1: The four Maxwell\'s equations in differential form are well-known.\n'
        'Step 2: ∇ × H = J + ∂D/∂t is the modified Ampere\'s law.\n'
        'Step 3: J is the conduction current density; ∂D/∂t is Maxwell\'s displacement current.\n'
        'Step 4: Maxwell added ∂D/∂t to make the equations consistent (completing EM theory).\n'
        'Step 5: This represents Ampere\'s law with displacement current. Answer: (b).',
    topic: 'Electromagnetics',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_06',
    year: 2021,
    paperNumber: 1,
    question:
        'The gain margin of a system is defined at which frequency?',
    options: [
      'Gain crossover frequency (ωgc) where |G(jω)| = 1',
      'Phase crossover frequency (ωpc) where ∠G(jω) = −180°',
      'Natural frequency ωn',
      'Bandwidth frequency ωbw',
    ],
    answer: 1,
    explanation:
        'Step 1: Gain margin (GM) = −20 log|G(jω)| evaluated at the phase crossover frequency.\n'
        'Step 2: Phase crossover frequency ωpc is where the phase of G(jω) = −180°.\n'
        'Step 3: GM = 1/|G(jωpc)| in linear scale or −20 log|G(jωpc)| in dB.\n'
        'Step 4: For stable minimum-phase systems, GM > 0 dB means stable.\n'
        'Step 5: GM is defined at phase crossover frequency ωpc. Answer: (b).',
    topic: 'Control Systems',
    marks: 1,
  ),
  GatePaperQuestion(
    id: 'p21_07',
    year: 2021,
    paperNumber: 1,
    question:
        'If x(t) ↔ X(jω) in the Fourier transform, then x(t − t₀) corresponds to:',
    options: [
      'X(jω − jω₀)',
      'e^(jωt₀) X(jω)',
      'e^(−jωt₀) X(jω)',
      'X(jω) × t₀',
    ],
    answer: 2,
    explanation:
        'Step 1: Time shifting property of Fourier Transform: if x(t) ↔ X(jω),\n'
        'Step 2: then x(t − t₀) ↔ e^(−jωt₀) X(jω).\n'
        'Step 3: A time delay of t₀ in time domain causes a linear phase shift of −ωt₀ in frequency domain.\n'
        'Step 4: The magnitude |X(jω)| is unchanged; only phase changes.\n'
        'Step 5: x(t − t₀) ↔ e^(−jωt₀)X(jω). Answer: (c).',
    topic: 'Signals & Systems',
    marks: 2,
  ),
  GatePaperQuestion(
    id: 'p21_08',
    year: 2021,
    paperNumber: 1,
    question:
        'In a non-inverting op-amp configuration with R1 = 10 kΩ and Rf = 40 kΩ, the voltage gain is:',
    options: ['4', '−4', '5', '−5'],
    answer: 2,
    explanation:
        'Step 1: Non-inverting op-amp gain formula: Av = 1 + Rf/R1.\n'
        'Step 2: Av = 1 + 40 kΩ / 10 kΩ = 1 + 4 = 5.\n'
        'Step 3: The output is in phase with the input (positive gain).\n'
        'Step 4: High input impedance makes it ideal for sensor interfacing.\n'
        'Step 5: Av = +5. Answer: (c).',
    topic: 'Analog Circuits',
    marks: 1,
  ),
];

// ─── GATE PAPERS ─────────────────────────────────────────────────────────────
const GatePaper gatePaper2023 = GatePaper(
  year: 2023,
  paperNumber: 1,
  questions: _questions2023,
);

const GatePaper gatePaper2022 = GatePaper(
  year: 2022,
  paperNumber: 1,
  questions: _questions2022,
);

const GatePaper gatePaper2021 = GatePaper(
  year: 2021,
  paperNumber: 1,
  questions: _questions2021,
);

const List<GatePaper> allGatePapers = [
  gatePaper2023,
  gatePaper2022,
  gatePaper2021,
];
