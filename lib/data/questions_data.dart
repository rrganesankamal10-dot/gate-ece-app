import '../models/models.dart';

// ============================================================================
// GATE ECE Master v2.0 - 80+ Verified Questions with Step-by-Step Solutions
// Proper Unicode encoding. Verified against GATE ECE textbooks.
// ============================================================================
const List<GateQuestion> gateQuestions = [

  // ===========================================================================
  // 1. NETWORKS & CIRCUIT THEORY (10 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_net_01',
    topicId: 'networks',
    question: 'In a series RLC resonant circuit, the Quality Factor (Q) is defined as:',
    options: [
      'Q = R / (\u03c9\u2080L)',
      'Q = (\u03c9\u2080L) / R = 1 / (\u03c9\u2080CR)',
      'Q = (\u03c9\u2080C) / R',
      'Q = R \u00d7 (\u03c9\u2080C)',
    ],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Concept: In a series RLC circuit at resonance, Q = \u03c9\u2080L / R = 1 / (\u03c9\u2080CR) = (1/R)\u221a(L/C).\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. At resonance, \u03c9\u2080 = 1/\u221a(LC)\n'
        '2. Substituting: \u03c9\u2080L/R = [1/\u221a(LC)] x L / R = (1/R)\u221a(L/C)\n'
        '3. Also equals 1/(\u03c9\u2080CR)\n\n'
        '\u26a0\ufe0f Trap: In parallel RLC, Q = R/(\u03c9\u2080L). Do not confuse!\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_net_02',
    topicId: 'networks',
    question: 'A DC source has Vth = 10 V and Rth = 5 \u03a9. What load RL absorbs maximum power, and what is Pmax?',
    options: [
      'RL = 10 \u03a9, Pmax = 2.5 W',
      'RL = 5 \u03a9, Pmax = 5.0 W',
      'RL = 5 \u03a9, Pmax = 2.5 W',
      'RL = 2.5 \u03a9, Pmax = 10.0 W',
    ],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Concept: Maximum Power Transfer Theorem - Pmax when RL = Rth.\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. Set RL = Rth = 5 \u03a9\n'
        '2. I = Vth / (Rth + RL) = 10 / 10 = 1.0 A\n'
        '3. Pmax = I\u00b2 x RL = 1 x 5 = 5.0 W\n'
        '   Or: Pmax = Vth\u00b2 / (4 x Rth) = 100/20 = 5.0 W\n\n'
        '\u26a0\ufe0f Trap: Total power from source is 10 W (50% efficiency).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_net_03',
    topicId: 'networks',
    question: 'Nodal analysis with N principal nodes (no floating sources) needs how many KCL equations?',
    options: ['N', 'N - 1', 'N + 1', 'N/2'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Concept: One node is chosen as ground, leaving N-1 unknowns.\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. Total nodes = N\n'
        '2. Choose 1 reference node (ground)\n'
        '3. N-1 independent KCL equations needed\n\n'
        '\u2705 Answer: Option B (N - 1)',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_net_04',
    topicId: 'networks',
    question: 'A capacitor C = 100 \u00b5F charged to 10 V stores energy:',
    options: ['50 mJ', '5.0 mJ', '10.0 mJ', '1.0 mJ'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Concept: E = (1/2)CV\u00b2\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. E = 0.5 x 100x10\u207b\u2076 x (10)\u00b2\n'
        '2. E = 0.5 x 10\u207b\u2074 x 100 = 5.0 x 10\u207b\u00b3 J\n'
        '3. E = 5.0 mJ\n\n'
        '\u26a0\ufe0f Trap: Do not forget the 1/2 factor.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_net_05',
    topicId: 'networks',
    question: 'For b branches, n nodes, independent loops l = ?',
    options: ['l = b - n', 'l = b - n + 1', 'l = b + n - 1', 'l = n - b + 1'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Concept: Graph theory for network topology.\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. Spanning tree has n-1 branches\n'
        '2. Links = b - (n-1) = b - n + 1\n'
        '3. Each link forms one independent loop\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2019,
  ),
  GateQuestion(
    id: 'q_net_06',
    topicId: 'networks',
    question: 'Time constant of series RL with R = 10 \u03a9, L = 50 mH is:',
    options: ['0.5 ms', '5 ms', '50 ms', '500 ms'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Concept: \u03c4 = L/R for RL circuits.\n\n'
        '\ud83d\udcdd \u03c4 = 50x10\u207b\u00b3 / 10 = 5x10\u207b\u00b3 s = 5 ms\n\n'
        '\u26a0\ufe0f Trap: For RC: \u03c4 = RC (not R/C).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_net_07',
    topicId: 'networks',
    question: 'Balanced Wheatstone: R1=100\u03a9, R2=200\u03a9, R3=150\u03a9. R4=?',
    options: ['75 \u03a9', '300 \u03a9', '250 \u03a9', '200 \u03a9'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Concept: Balance condition R1/R2 = R3/R4\n\n'
        '\ud83d\udcdd R4 = R2 x R3 / R1 = 200 x 150 / 100 = 300 \u03a9\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_net_08',
    topicId: 'networks',
    question: 'Superposition theorem applies to:',
    options: ['Non-linear elements only', 'Linear bilateral elements only', 'Both linear and non-linear', 'Active elements only'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Superposition works only for linear bilateral networks.\n'
        'Cannot use for power calculations (P = I\u00b2R is non-linear).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_net_09',
    topicId: 'networks',
    question: 'Two 10 \u03a9 resistors in parallel = ?',
    options: ['20 \u03a9', '5 \u03a9', '10 \u03a9', '2.5 \u03a9'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc 1/Req = 1/10 + 1/10 = 2/10. Req = 5 \u03a9.\n'
        'Shortcut for equal resistors: R/n = 10/2 = 5 \u03a9\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 0,
  ),
  GateQuestion(
    id: 'q_net_10',
    topicId: 'networks',
    question: 'Norton current for Vth=20V, Rth=4\u03a9 is:',
    options: ['80 A', '5 A', '4 A', '0.2 A'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc IN = Vth / Rth = 20/4 = 5 A. RN = Rth = 4 \u03a9.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),

  // ===========================================================================
  // 2. SIGNALS & SYSTEMS (10 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_sig_01',
    topicId: 'signals',
    question: 'Nyquist sampling rate for x(t) = 5cos(2000\u03c0t) + 3sin(6000\u03c0t) is:',
    options: ['1 kHz', '3 kHz', '6 kHz', '4 kHz'],
    correctIndex: 2,
    explanation:
        '\ud83d\udccc Concept: fs = 2 x fmax\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. f1 = 2000\u03c0/(2\u03c0) = 1000 Hz\n'
        '2. f2 = 6000\u03c0/(2\u03c0) = 3000 Hz\n'
        '3. fmax = 3000 Hz\n'
        '4. fs = 2 x 3000 = 6000 Hz = 6 kHz\n\n'
        '\u2705 Answer: Option C',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_sig_02',
    topicId: 'signals',
    question: 'Laplace transform of u(t) is:',
    options: ['s', '1/s', '1/s\u00b2', '1'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc L{u(t)} = 1/s, Re(s) > 0\n\n'
        '\ud83d\udcdd L{u(t)} = integral from 0 to inf of e^(-st) dt = 1/s\n\n'
        '\u26a0\ufe0f Trap: L{\u03b4(t)} = 1, not 1/s.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_sig_03',
    topicId: 'signals',
    question: 'System with h(t) = e^(-2t)u(t) is:',
    options: ['Unstable and non-causal', 'Stable and causal', 'Stable but non-causal', 'Unstable and causal'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc BIBO stability: integral of |h(t)| dt < infinity. Causal: h(t) = 0 for t < 0.\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. Causal: h(t) = 0 for t < 0 (due to u(t))\n'
        '2. Integral from 0 to inf of e^(-2t) dt = 1/2 < infinity => Stable\n\n'
        '\u26a0\ufe0f Trap: e^(+2t)u(t) is UNSTABLE (integral diverges).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_sig_04',
    topicId: 'signals',
    question: 'Z-transform of x[n] = a^n u[n] is:',
    options: ['z/(z+a)', 'z/(z-a)', 'a/(z-a)', '1/(z-a)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Z{a^n u[n]} = z/(z-a), |z| > |a|\n\n'
        '\ud83d\udcdd X(z) = sum of (a/z)^n = 1/(1-a/z) = z/(z-a)\n'
        'ROC: |z| > |a|\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_sig_05',
    topicId: 'signals',
    question: 'Fourier transform of rect(t/T) is:',
    options: ['T sinc(\u03c9T/\u03c0)', 'T sinc(fT)', 'sinc(\u03c9/T)', 'T\u00b2 sinc\u00b2(fT)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc FT{rect(t/T)} = T sinc(fT)\n'
        'sinc(x) = sin(\u03c0x)/(\u03c0x)\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_sig_06',
    topicId: 'signals',
    question: 'x(t) convolved with \u03b4(t - t0) gives:',
    options: ['x(t0)', 'x(t - t0)', 'x(t + t0)', '\u03b4(t - t0)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Sifting property: x(t) * \u03b4(t-t0) = x(t-t0).\n'
        'The impulse shifts the signal by t0.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_sig_07',
    topicId: 'signals',
    question: 'ROC of Z-transform for a causal signal is:',
    options: ['Interior of circle', 'Exterior of circle', 'Ring region', 'Entire z-plane'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Causal (right-sided) signal: ROC is |z| > r.\n'
        'Anti-causal: |z| < r. Two-sided: ring.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_sig_08',
    topicId: 'signals',
    question: 'LTI system is BIBO stable iff (continuous-time):',
    options: ['All poles in RHP', 'All poles in left half of s-plane', 'Pole on jw axis', 'No poles exist'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc BIBO stability: all poles must have Re(s) < 0 (LHP).\n'
        'For discrete: all poles inside unit circle |z| < 1.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_sig_09',
    topicId: 'signals',
    question: 'Energy of x(t) = e^(-t)u(t) is:',
    options: ['1', '0.5', '2', 'infinity'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc E = integral of |x(t)|^2 dt\n\n'
        '\ud83d\udcdd E = integral from 0 to inf of e^(-2t) dt = 1/2 = 0.5\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_sig_10',
    topicId: 'signals',
    question: 'x(t) = 3cos(5t) + 2sin(7t) has fundamental period:',
    options: ['2\u03c0/5', '2\u03c0', '2\u03c0/35', 'Not periodic'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc T = LCM of individual periods (if ratio is rational).\n\n'
        '\ud83d\udcdd T1 = 2\u03c0/5, T2 = 2\u03c0/7. Ratio = 7/5 (rational).\n'
        'LCM gives T = 2\u03c0.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Hard',
    year: 2021,
  ),

  // ===========================================================================
  // 3. ELECTRONIC DEVICES & CIRCUITS (10 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_edc_01',
    topicId: 'edc',
    question: 'At 300K, thermal voltage VT = kT/q equals:',
    options: ['52 mV', '26 mV', '13 mV', '0.7 V'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc VT = kT/q\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. k = 1.38x10\u207b\u00b2\u00b3 J/K\n'
        '2. T = 300 K\n'
        '3. q = 1.6x10\u207b\u00b9\u2079 C\n'
        '4. VT = (1.38x10\u207b\u00b2\u00b3 x 300)/(1.6x10\u207b\u00b9\u2079) = 25.875 mV \u2248 26 mV\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_edc_02',
    topicId: 'edc',
    question: 'NMOS saturation drain current is proportional to:',
    options: ['(VGS - Vth)', '(VGS - Vth)\u00b2', '(VDS - Vth)\u00b2', 'VDS'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc ID = (kn/2)(W/L)(VGS - Vth)\u00b2 in saturation.\n'
        'ID is proportional to the SQUARE of (VGS - Vth).\n\n'
        '\u26a0\ufe0f Trap: Linear region ID is proportional to VDS.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_edc_03',
    topicId: 'edc',
    question: 'BJT with \u03b2=100, IB=20\u00b5A. IC and IE are:',
    options: ['IC=0.2mA, IE=0.22mA', 'IC=2mA, IE=2.02mA', 'IC=20mA, IE=20.02mA', 'IC=2mA, IE=2.2mA'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc IC = \u03b2 x IB, IE = (\u03b2+1) x IB\n\n'
        '\ud83d\udcdd IC = 100 x 20\u00b5A = 2 mA\n'
        'IE = 101 x 20\u00b5A = 2.02 mA\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_edc_04',
    topicId: 'edc',
    question: 'PN junction depletion width increases with:',
    options: ['Forward bias', 'Reverse bias', 'Temperature only', 'Doping decrease only'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc W is proportional to sqrt(Vbi + VR).\n'
        'Reverse bias increases (Vbi + VR), widening depletion.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_edc_05',
    topicId: 'edc',
    question: 'Zener VZ=5.6V, Vin 8-12V, Rs=220\u03a9, RL=1k\u03a9. IZ range:',
    options: ['5.1-23.5 mA', '5.3-23.5 mA', '10.9-29.1 mA', '5.3-29.1 mA'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc IZ = Is - IL where Is = (Vin-VZ)/Rs, IL = VZ/RL\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. IL = 5.6/1000 = 5.6 mA (constant)\n'
        '2. Vin=8V: Is = (8-5.6)/220 = 10.9 mA, IZ = 10.9-5.6 = 5.3 mA\n'
        '3. Vin=12V: Is = (12-5.6)/220 = 29.1 mA, IZ = 29.1-5.6 = 23.5 mA\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Hard',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_edc_06',
    topicId: 'edc',
    question: 'Drift current in a semiconductor is proportional to:',
    options: ['Concentration gradient', 'Electric field', 'Temperature gradient', 'Magnetic field'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Drift current Jdrift = \u03c3E = nq\u03bcE (proportional to E-field).\n'
        'Diffusion current is proportional to concentration gradient.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_edc_07',
    topicId: 'edc',
    question: 'In an intrinsic semiconductor at thermal equilibrium, n = p = ni. The value of ni:',
    options: ['Increases with temperature', 'Decreases with temperature', 'Remains constant', 'Depends on doping'],
    correctIndex: 0,
    explanation:
        '\ud83d\udccc ni = B x T^(3/2) x exp(-Eg/2kT). As T increases, ni increases exponentially.\n\n'
        '\u2705 Answer: Option A',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_edc_08',
    topicId: 'edc',
    question: 'The built-in potential of a silicon PN junction at 300K with NA=10^16 and ND=10^17 is approximately:',
    options: ['0.3 V', '0.757 V', '1.1 V', '0.5 V'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Vbi = VT x ln(NA x ND / ni\u00b2)\n\n'
        '\ud83d\udcdd Step-by-Step:\n'
        '1. VT = 26 mV at 300K\n'
        '2. ni = 1.5x10\u00b9\u2070 /cm\u00b3 for Si\n'
        '3. Vbi = 0.026 x ln(10\u00b9\u2076 x 10\u00b9\u2077 / (1.5x10\u00b9\u2070)\u00b2)\n'
        '4. = 0.026 x ln(10\u00b3\u00b3 / 2.25x10\u00b2\u2070)\n'
        '5. = 0.026 x ln(4.44x10\u00b9\u00b2) = 0.026 x 29.12 = 0.757 V\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_edc_09',
    topicId: 'edc',
    question: 'A MOSFET operates in linear region when:',
    options: ['VDS > VGS - Vth', 'VDS < VGS - Vth', 'VGS < Vth', 'VDS = 0'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc MOSFET regions:\n'
        '- Cutoff: VGS < Vth\n'
        '- Linear (Triode): VDS < VGS - Vth (and VGS > Vth)\n'
        '- Saturation: VDS >= VGS - Vth\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_edc_10',
    topicId: 'edc',
    question: 'The Early effect in BJT causes:',
    options: ['Decrease in IC with VCE', 'Increase in IC with VCE in active region', 'No change in IC', 'Decrease in beta'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Early effect (base-width modulation): As VCE increases, base-collector depletion widens, effective base narrows, IC slightly increases.\n'
        'IC = IC0(1 + VCE/VA) where VA is Early voltage.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2021,
  ),

  // ===========================================================================
  // 4. ANALOG ELECTRONICS (10 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_ana_01',
    topicId: 'analog',
    question: 'Inverting amp with Rf=100k\u03a9, Rin=10k\u03a9 has gain:',
    options: ['10', '-10', '-100', '11'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Av = -Rf/Rin = -100k/10k = -10.\n'
        'Negative sign indicates 180 degree phase inversion.\n\n'
        '\u26a0\ufe0f Trap: Non-inverting = 1 + Rf/R1 = +11.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ana_02',
    topicId: 'analog',
    question: 'CMRR with Ad=10^5, Acm=0.1 is:',
    options: ['10^4 (80 dB)', '10^6 (120 dB)', '10^5 (100 dB)', '10^3 (60 dB)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc CMRR = |Ad/Acm| = 10^5 / 0.1 = 10^6.\n'
        'In dB: 20 x log10(10^6) = 120 dB.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ana_03',
    topicId: 'analog',
    question: 'CE amplifier voltage gain is approximately:',
    options: ['gm x RC', '-gm x RC', '\u03b2/RC', 'RC/r\u03c0'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Av = -gm x RC (negative = phase inversion).\n'
        'gm = IC/VT = IC/(26 mV) at room temperature.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ana_04',
    topicId: 'analog',
    question: 'RC LPF cutoff with R=10k\u03a9, C=1\u00b5F:',
    options: ['1.59 Hz', '15.9 Hz', '159 Hz', '1.59 kHz'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc fc = 1/(2\u03c0RC)\n\n'
        '\ud83d\udcdd fc = 1/(2\u03c0 x 10x10\u00b3 x 1x10\u207b\u2076) = 1/(0.06283) = 15.9 Hz\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ana_05',
    topicId: 'analog',
    question: '555 astable duty cycle is:',
    options: ['RA/(RA+RB)', '(RA+RB)/(RA+2RB)', 'RB/(RA+RB)', '(RA+2RB)/(RA+RB)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Thigh = 0.693(RA+RB)C, Tlow = 0.693(RB)C.\n'
        'Duty = Thigh/T = (RA+RB)/(RA+2RB).\n\n'
        '\u26a0\ufe0f Duty cycle > 50% always in standard 555.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_ana_06',
    topicId: 'analog',
    question: 'For oscillation to start, Barkhausen criterion requires loop gain:',
    options: ['|A\u03b2| < 1', '|A\u03b2| = 1 and phase = 0 or 360 degrees', '|A\u03b2| > 1', 'Phase = 90 degrees'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Barkhausen criterion: |A\u03b2| = 1 and total phase shift = 0 (or 360 degrees).\n'
        'In practice, |A\u03b2| is slightly > 1 to start oscillations, then stabilizes to 1.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ana_07',
    topicId: 'analog',
    question: 'Slew rate of an op-amp is defined as:',
    options: ['Maximum input voltage', 'Maximum rate of change of output voltage', 'Input offset voltage', 'Bandwidth'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Slew Rate (SR) = max dVout/dt, measured in V/\u00b5s.\n'
        'Limits the maximum frequency of large-signal operation.\n'
        'fmax = SR / (2\u03c0 x Vpeak)\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ana_08',
    topicId: 'analog',
    question: 'Negative feedback in amplifiers:',
    options: ['Increases gain, increases BW', 'Decreases gain, increases BW', 'Increases gain, decreases BW', 'Decreases gain, decreases BW'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Negative feedback:\n'
        '- Gain reduces by (1+A\u03b2)\n'
        '- Bandwidth increases by (1+A\u03b2)\n'
        '- Gain-Bandwidth product remains constant\n'
        '- Reduces distortion and noise\n'
        '- Improves input/output impedance\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_ana_09',
    topicId: 'analog',
    question: 'A voltage follower (buffer) has gain:',
    options: ['-1', '+1', '0', 'infinity'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Buffer/voltage follower: output = input, Av = +1.\n'
        'High input impedance, low output impedance.\n'
        'Used for impedance matching.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_ana_10',
    topicId: 'analog',
    question: 'Wien bridge oscillator produces oscillation at frequency:',
    options: ['1/(RC)', '1/(2\u03c0RC)', '2\u03c0RC', 'RC/(2\u03c0)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Wien bridge: f = 1/(2\u03c0RC).\n'
        'Requires minimum gain of 3 (Rf/R1 = 2) to sustain oscillation.\n'
        'Produces sinusoidal output.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),

  // ===========================================================================
  // 5. DIGITAL CIRCUITS (10 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_dig_01',
    topicId: 'digital',
    question: 'Min 2-input NAND gates for XOR:',
    options: ['3', '4', '5', '2'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc XOR using NAND: A XOR B = ((A NAND (A NAND B)) NAND (B NAND (A NAND B)))\n'
        '4 NAND gates needed.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_dig_02',
    topicId: 'digital',
    question: '12-bit ADC, Vref=5V. Resolution = ?',
    options: ['2.44 mV', '1.22 mV', '4.88 mV', '0.61 mV'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Resolution = Vref/(2^n - 1) = 5/4095 = 1.22 mV.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_dig_03',
    topicId: 'digital',
    question: 'F = AB + A\'B + AB\' simplifies to:',
    options: ['A + B', 'A + B\'', 'AB', 'A\' + B'],
    correctIndex: 0,
    explanation:
        '\ud83d\udccc F = B(A+A\') + AB\' = B + AB\' = A + B (absorption).\n'
        'Verify: only A=0,B=0 gives F=0.\n\n'
        '\u2705 Answer: Option A',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_dig_04',
    topicId: 'digital',
    question: 'JK flip-flop with J=K=1 acts as:',
    options: ['Set', 'Toggle', 'Reset', 'No change'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc J=K=1 => Toggle. Q_next = Q\'.\n\n'
        '\u26a0\ufe0f Trap: SR with S=R=1 is FORBIDDEN (indeterminate).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_dig_05',
    topicId: 'digital',
    question: 'Mod-10 counter needs min flip-flops:',
    options: ['3', '4', '5', '10'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc 2^n >= 10. 2^3=8 < 10. 2^4=16 >= 10.\n'
        'Minimum = ceil(log2(10)) = 4.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_dig_06',
    topicId: 'digital',
    question: 'Gray code advantage over binary:',
    options: ['More bits needed', 'Only 1 bit changes between adjacent codes', 'Easier to add', 'Uses fewer bits'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Gray code: adjacent values differ by exactly 1 bit.\n'
        'Used in shaft encoders, K-maps, and reducing switching errors.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_dig_07',
    topicId: 'digital',
    question: 'An 8-to-1 multiplexer has how many select lines?',
    options: ['2', '3', '4', '8'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc 2^n = number of inputs. 2^3 = 8.\n'
        'So 3 select lines for 8:1 MUX.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_dig_08',
    topicId: 'digital',
    question: 'The output of a full adder with A=1, B=1, Cin=1:',
    options: ['Sum=0, Cout=1', 'Sum=1, Cout=1', 'Sum=0, Cout=0', 'Sum=1, Cout=0'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Full adder: A+B+Cin = 1+1+1 = 3 = 11 in binary.\n'
        'Sum = 1, Cout = 1.\n\n'
        '\ud83d\udcdd Sum = A XOR B XOR Cin = 1 XOR 1 XOR 1 = 1\n'
        'Cout = AB + BCin + ACin = 1+1+1 = 1\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_dig_09',
    topicId: 'digital',
    question: 'A D flip-flop stores:',
    options: ['Previous output', 'Input D at clock edge', 'Complement of D', 'Always 1'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc D FF: Q_next = D (at active clock edge).\n'
        'Transparent latch captures D during enable; edge-triggered FF captures at clock edge.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_dig_10',
    topicId: 'digital',
    question: 'How many minterms in a 3-variable K-map?',
    options: ['4', '8', '16', '6'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc n variables => 2^n minterms.\n'
        '3 variables => 2^3 = 8 minterms.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),

  // ===========================================================================
  // 6. CONTROL SYSTEMS (10 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_ctrl_01',
    topicId: 'control',
    question: 'Unity feedback, G(s)=10/(s+2). Closed-loop TF:',
    options: ['10/(s+2)', '10/(s+12)', '(s+2)/10', '10s/(s+12)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc T(s) = G/(1+G) = [10/(s+2)] / [1+10/(s+2)] = 10/(s+12).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ctrl_02',
    topicId: 'control',
    question: '2nd-order underdamped: peak overshoot depends on:',
    options: ['Only \u03c9n', 'Only \u03b6 (damping ratio)', 'Both \u03b6 and \u03c9n', 'Neither'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Mp = exp(-\u03c0\u03b6/sqrt(1-\u03b6\u00b2)) x 100%.\n'
        'Mp depends ONLY on \u03b6. \u03c9n affects rise/settling time, NOT overshoot.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ctrl_03',
    topicId: 'control',
    question: 'System type of G(s) = K/[s\u00b2(s+1)(s+5)]:',
    options: ['Type 0', 'Type 2', 'Type 1', 'Type 3'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Type = number of poles at s = 0.\n'
        's\u00b2 = 2 poles at origin => Type 2.\n'
        'Type 2: zero steady-state error for step AND ramp inputs.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_ctrl_04',
    topicId: 'control',
    question: 'Gain margin is defined at:',
    options: ['Gain crossover frequency', 'Phase crossover frequency', 'Resonant frequency', 'Bandwidth'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc GM measured at phase crossover freq (phase = -180 degrees).\n'
        'PM measured at gain crossover freq (|G| = 0 dB).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ctrl_05',
    topicId: 'control',
    question: 'Routh array for s\u00b3+2s\u00b2+3s+6=0 has sign changes:',
    options: ['0 (stable)', '1', '2', '3'],
    correctIndex: 0,
    explanation:
        '\ud83d\udccc Routh array:\n'
        's3: 1, 3\n'
        's2: 2, 6\n'
        's1: (2x3 - 1x6)/2 = 0 (special case!)\n'
        's0: 6\n\n'
        '\ud83d\udcdd Use auxiliary polynomial from s2 row: A(s) = 2s\u00b2+6, dA/ds = 4s.\n'
        'New s1: 4, 0. First column: 1, 2, 4, 6 - all positive => 0 sign changes => stable.\n\n'
        '\u2705 Answer: Option A',
    difficulty: 'Hard',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ctrl_06',
    topicId: 'control',
    question: 'Root locus starts at:',
    options: ['Closed-loop poles', 'Open-loop poles', 'Open-loop zeros', 'Origin'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Root locus rules:\n'
        '- Starts at open-loop POLES (K=0)\n'
        '- Ends at open-loop ZEROS (K=infinity)\n'
        '- Number of branches = number of poles\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_ctrl_07',
    topicId: 'control',
    question: 'Steady-state error for unit step input in Type 1 system:',
    options: ['infinity', '0', '1/Kp', '1/Kv'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Type 1 system:\n'
        '- Step input: ess = 0 (Kp = infinity)\n'
        '- Ramp input: ess = 1/Kv\n'
        '- Parabolic: ess = infinity\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_ctrl_08',
    topicId: 'control',
    question: 'Adding a pole to a system:',
    options: ['Makes it faster', 'Makes it slower (increases rise time)', 'Has no effect', 'Always destabilizes'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Adding pole: makes system sluggish (slower response, larger rise time).\n'
        'Adding zero: makes system faster but may cause overshoot.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_ctrl_09',
    topicId: 'control',
    question: 'PID controller - Integral action eliminates:',
    options: ['Overshoot', 'Steady-state error', 'Rise time', 'Settling time'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc PID actions:\n'
        '- P: Reduces error, may not eliminate it\n'
        '- I: Eliminates steady-state error (adds a pole at origin)\n'
        '- D: Reduces overshoot, damps oscillation\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_ctrl_10',
    topicId: 'control',
    question: 'Nyquist stability: system stable if encirclements of -1+j0 point N equals:',
    options: ['Z (RHP zeros)', '-P (negative of OL RHP poles)', 'P (OL RHP poles)', '0 always'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc N = Z - P where:\n'
        'N = clockwise encirclements of -1+j0\n'
        'Z = closed-loop RHP poles\n'
        'P = open-loop RHP poles\n'
        'Stable when Z = 0, so N = -P.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Hard',
    year: 2022,
  ),

  // ===========================================================================
  // 7. COMMUNICATION SYSTEMS (10 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_com_01',
    topicId: 'communication',
    question: 'AM with \u03bc=0.5: total power relative to Pc:',
    options: ['1.5 Pc', '1.125 Pc', '1.25 Pc', '2 Pc'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc PT = Pc(1 + \u03bc\u00b2/2) = Pc(1 + 0.125) = 1.125 Pc.\n'
        'Efficiency = \u03bc\u00b2/(2+\u03bc\u00b2) = 11.1% (very inefficient!).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_com_02',
    topicId: 'communication',
    question: 'Carson rule: delta_f=5kHz, fm=1kHz. FM BW:',
    options: ['10 kHz', '12 kHz', '6 kHz', '5 kHz'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc BW = 2(delta_f + fm) = 2(5+1) = 12 kHz.\n'
        'Modulation index beta = delta_f/fm = 5.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_com_03',
    topicId: 'communication',
    question: 'Shannon capacity: B=4kHz, SNR=31:',
    options: ['16 kbps', '20 kbps', '32 kbps', '40 kbps'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc C = B x log2(1+SNR) = 4000 x log2(32) = 4000 x 5 = 20 kbps.\n\n'
        '\u26a0\ufe0f Trap: SNR is ratio form, not dB.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_com_04',
    topicId: 'communication',
    question: 'BPSK BER is:',
    options: ['Q(sqrt(Eb/N0))', 'Q(sqrt(2Eb/N0))', 'Q(sqrt(Eb/2N0))', '0.5 x Q(sqrt(2Eb/N0))'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc BPSK BER = Q(sqrt(2Eb/N0)).\n'
        'QPSK has same BER per bit as BPSK!\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Hard',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_com_05',
    topicId: 'communication',
    question: 'Friis noise formula for cascaded stages:',
    options: ['Ftotal = F1 + F2', 'Ftotal = F1 + (F2-1)/G1', 'Ftotal = F1 x F2', 'Ftotal = F1 + F2/G1'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Ftotal = F1 + (F2-1)/G1 + (F3-1)/(G1xG2) + ...\n'
        'First stage dominates if G1 is large. Use LNA first!\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_com_06',
    topicId: 'communication',
    question: 'PCM quantization noise power for step size delta is:',
    options: ['delta\u00b2/6', 'delta\u00b2/12', 'delta\u00b2/3', 'delta\u00b2/4'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Quantization noise power = delta\u00b2/12.\n'
        'For uniform quantizer: delta = Vref/2^n.\n'
        'SQNR = 3 x 2^(2n) (or approximately 6.02n + 1.76 dB).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_com_07',
    topicId: 'communication',
    question: 'DSB-SC signal bandwidth compared to AM:',
    options: ['Double', 'Same', 'Half', 'One-fourth'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Both AM and DSB-SC have BW = 2fm.\n'
        'SSB has BW = fm (half). VSB: between SSB and DSB.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_com_08',
    topicId: 'communication',
    question: 'Matched filter output SNR is:',
    options: ['E/N0', '2E/N0', 'E/(2N0)', 'sqrt(E/N0)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Matched filter maximizes output SNR.\n'
        'SNR_max = 2E/N0 where E = signal energy.\n'
        'h(t) = x(T-t) (time-reversed, delayed signal).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Hard',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_com_09',
    topicId: 'communication',
    question: 'Superheterodyne receiver uses:',
    options: ['Direct amplification', 'Frequency conversion to IF', 'Baseband processing only', 'No local oscillator'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Superheterodyne: RF -> Mixer (with LO) -> IF -> Detector -> Audio.\n'
        'Converts input to fixed IF for easier amplification and selectivity.\n'
        'IF for AM radio = 455 kHz.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_com_10',
    topicId: 'communication',
    question: 'Entropy H(X) is maximum when:',
    options: ['One symbol has probability 1', 'All symbols are equally probable', 'Probabilities are skewed', 'Only 2 symbols exist'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc H(X) = -sum(p(x) log2 p(x)).\n'
        'Maximum entropy = log2(M) when all M symbols are equally probable (p = 1/M).\n'
        'Minimum entropy = 0 when one symbol has probability 1.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),

  // ===========================================================================
  // 8. ELECTROMAGNETIC THEORY (8 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_em_01',
    topicId: 'em',
    question: 'Skin depth formula is:',
    options: ['sqrt(2\u03c0f\u03bc\u03c3)', '1/sqrt(\u03c0f\u03bc\u03c3)', 'sqrt(\u03c3/\u03c0f\u03bc)', '1/(2\u03c0f\u03bc\u03c3)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc \u03b4 = sqrt(2/(\u03c9\u03bc\u03c3)) = 1/sqrt(\u03c0f\u03bc\u03c3).\n'
        'Higher frequency => smaller skin depth.\n'
        'Copper at 1 MHz: \u03b4 = 66 \u03bcm.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_em_02',
    topicId: 'em',
    question: 'VSWR for ZL=75\u03a9 on Z0=50\u03a9 line:',
    options: ['1.0', '1.5', '2.0', '3.0'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Gamma = (75-50)/(75+50) = 0.2.\n'
        'VSWR = (1+0.2)/(1-0.2) = 1.5.\n\n'
        '\u26a0\ufe0f Matched load (ZL=Z0): Gamma=0, VSWR=1 (ideal).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_em_03',
    topicId: 'em',
    question: 'Divergence of B is always:',
    options: ['Positive', 'Zero', 'Negative', 'Medium-dependent'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc div B = 0 (Gauss law for magnetism). No magnetic monopoles.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_em_04',
    topicId: 'em',
    question: 'Lossless TL characteristic impedance Z0 = ?',
    options: ['sqrt(L/C)', 'sqrt(LC)', 'L/C', 'sqrt(LxC)'],
    correctIndex: 0,
    explanation:
        '\ud83d\udccc Z0 = sqrt((R+j\u03c9L)/(G+j\u03c9C)). Lossless: R=0, G=0 => sqrt(L/C).\n\n'
        '\u2705 Answer: Option A',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_em_05',
    topicId: 'em',
    question: 'Poynting vector S represents:',
    options: ['E-field intensity', 'Power flow per unit area', 'B-field density', 'Energy per volume'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc S = E x H (W/m\u00b2) = electromagnetic power flow per unit area.\n'
        'Direction of S = direction of wave propagation.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_em_06',
    topicId: 'em',
    question: 'Boundary condition: tangential component of E across interface:',
    options: ['Discontinuous', 'Continuous', 'Zero', 'Infinite'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc At boundary between two media:\n'
        '- Tangential E: continuous (Et1 = Et2)\n'
        '- Normal D: discontinuous by surface charge (Dn1 - Dn2 = \u03c1s)\n'
        '- Tangential H: discontinuous by surface current\n'
        '- Normal B: continuous\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_em_07',
    topicId: 'em',
    question: 'Wave velocity in a medium with \u03bcr=1, \u03b5r=4:',
    options: ['3x10^8 m/s', '1.5x10^8 m/s', '6x10^8 m/s', '0.75x10^8 m/s'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc v = c/sqrt(\u03bcr x \u03b5r) = 3x10^8/sqrt(1x4) = 3x10^8/2 = 1.5x10^8 m/s.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_em_08',
    topicId: 'em',
    question: 'Displacement current density is:',
    options: ['\u03c3E', 'dD/dt', 'curl H', 'div E'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Jd = dD/dt = \u03b5 dE/dt.\n'
        'Maxwell added displacement current to Ampere law:\n'
        'curl H = J + dD/dt (conduction + displacement).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),

  // ===========================================================================
  // 9. ENGINEERING MATHEMATICS (10 questions)
  // ===========================================================================
  GateQuestion(
    id: 'q_math_01',
    topicId: 'maths',
    question: 'Eigenvalues of [[2,1],[0,3]] are:',
    options: ['1 and 4', '2 and 3', '0 and 5', '1 and 6'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Triangular matrix: eigenvalues = diagonal entries.\n'
        '\u03bb1 = 2, \u03bb2 = 3.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_math_02',
    topicId: 'maths',
    question: 'Rank of [[1,2,3],[2,4,6],[1,1,1]]:',
    options: ['1', '2', '3', '0'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc R2 = 2xR1 (dependent). After elimination: 2 non-zero rows.\n'
        'Rank = 2.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_math_03',
    topicId: 'maths',
    question: 'L{t x e^(-at) x u(t)} = ?',
    options: ['1/(s+a)', '1/(s+a)\u00b2', 'a/(s+a)\u00b2', 's/(s+a)\u00b2'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc L{t^n x e^(-at)} = n!/(s+a)^(n+1).\n'
        'For n=1: 1!/(s+a)\u00b2 = 1/(s+a)\u00b2.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_math_04',
    topicId: 'maths',
    question: 'Integral from 0 to infinity of e^(-x\u00b2) dx = ?',
    options: ['sqrt(\u03c0)', 'sqrt(\u03c0)/2', '\u03c0', '1'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Full Gaussian: integral from -inf to inf of e^(-x\u00b2) = sqrt(\u03c0).\n'
        'Half (0 to inf) = sqrt(\u03c0)/2.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_math_05',
    topicId: 'maths',
    question: 'div F for F = x\u00b2 i + y\u00b2 j + z\u00b2 k:',
    options: ['x+y+z', '2(x+y+z)', '2(x\u00b2+y\u00b2+z\u00b2)', '6xyz'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc div F = dFx/dx + dFy/dy + dFz/dz = 2x + 2y + 2z = 2(x+y+z).\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_math_06',
    topicId: 'maths',
    question: 'P(A)=0.6, P(B)=0.4, independent events. P(A intersection B)=?',
    options: ['1.0', '0.24', '0.20', '0.40'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Independent: P(A\u2229B) = P(A) x P(B) = 0.6 x 0.4 = 0.24.\n\n'
        '\u26a0\ufe0f Trap: Mutually exclusive => P(A\u2229B) = 0.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2020,
  ),
  GateQuestion(
    id: 'q_math_07',
    topicId: 'maths',
    question: '3x3 matrix with two identical rows has det:',
    options: ['1', '0', '-1', 'Cannot determine'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Two identical rows => det = 0.\n'
        'Swapping identical rows: det = -det, so 2 x det = 0, det = 0.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2023,
  ),
  GateQuestion(
    id: 'q_math_08',
    topicId: 'maths',
    question: 'dy/dx + y = e^(-x), y(0)=0. Solution:',
    options: ['y = e^(-x)', 'y = x e^(-x)', 'y = e^(-x) - e^(-2x)', 'y = 1-e^(-x)'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc Step-by-Step:\n'
        '1. IF = e^(integral of 1 dx) = e^x\n'
        '2. d/dx(y e^x) = e^x x e^(-x) = 1\n'
        '3. y e^x = x + C\n'
        '4. y(0) = 0 => C = 0\n'
        '5. y = x e^(-x)\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Medium',
    year: 2022,
  ),
  GateQuestion(
    id: 'q_math_09',
    topicId: 'maths',
    question: 'Cayley-Hamilton: every matrix satisfies:',
    options: ['Transpose equation', 'Its own characteristic equation', 'Inverse equation', 'Adjoint equation'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc A matrix satisfies its own characteristic polynomial.\n'
        'Useful for computing A inverse and higher powers of A.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Easy',
    year: 2021,
  ),
  GateQuestion(
    id: 'q_math_10',
    topicId: 'maths',
    question: 'Residue of 1/(z\u00b2+1) at z=j:',
    options: ['j', '1/(2j)', '-j/2', '1/2'],
    correctIndex: 1,
    explanation:
        '\ud83d\udccc f(z) = 1/((z-j)(z+j)). Simple pole at z=j.\n'
        'Res = lim(z->j) (z-j)/((z-j)(z+j)) = 1/(2j) = -j/2.\n\n'
        '\u2705 Answer: Option B',
    difficulty: 'Hard',
    year: 2023,
  ),
];

// ===========================================================================
// FAQ (Most Frequently Asked Topics in GATE ECE) per subject
// ===========================================================================
const Map<String, List<String>> faqTopics = {
  'networks': [
    'Maximum Power Transfer Theorem',
    'Thevenin & Norton Equivalents',
    'KVL/KCL Applications',
    'Series & Parallel RLC Resonance',
    'Transient Analysis (RC, RL, RLC)',
    'Network Graph Theory',
    'Superposition Theorem',
  ],
  'signals': [
    'Nyquist Sampling Theorem',
    'Laplace Transform & ROC',
    'Z-Transform Properties',
    'Convolution (CT & DT)',
    'Fourier Series & Transform',
    'LTI System Stability (BIBO)',
    'DFT & FFT',
  ],
  'edc': [
    'PN Junction Diode (Shockley Equation)',
    'MOSFET Operation Regions',
    'BJT Current Relations',
    'Zener Diode Regulation',
    'Hall Effect',
    'Carrier Concentration & Mobility',
  ],
  'analog': [
    'Op-Amp Configurations (Inverting/Non-Inverting)',
    'CMRR and Slew Rate',
    'Feedback Amplifiers',
    'Oscillators (Barkhausen Criterion)',
    '555 Timer (Astable/Monostable)',
    'Active Filters',
  ],
  'digital': [
    'Boolean Simplification (K-Map)',
    'Flip-Flops (SR, JK, D, T)',
    'Counters (Synchronous/Asynchronous)',
    'ADC/DAC Resolution',
    'Number Systems & Codes',
    'Multiplexer as Universal Gate',
  ],
  'control': [
    'Root Locus Rules',
    'Routh-Hurwitz Stability',
    'Bode Plot (GM & PM)',
    'Nyquist Stability Criterion',
    'Time Domain Specs (Overshoot, Settling)',
    'Type & Order of System',
    'PID Controller Tuning',
  ],
  'communication': [
    'AM/FM Modulation & Power',
    'Carson Rule for FM BW',
    'Shannon Capacity Theorem',
    'Noise Figure (Friis Formula)',
    'PCM Quantization',
    'Digital Modulation (BPSK, QPSK)',
    'Matched Filter',
  ],
  'em': [
    'Maxwell Equations',
    'Transmission Line (VSWR, Gamma)',
    'Skin Depth',
    'Poynting Vector',
    'Boundary Conditions',
    'Wave Propagation',
  ],
  'maths': [
    'Eigenvalues & Eigenvectors',
    'Rank of Matrix',
    'Laplace Transform',
    'Probability & Bayes Theorem',
    'First-order ODE',
    'Residue Theorem',
    'Taylor/Maclaurin Series',
  ],
};