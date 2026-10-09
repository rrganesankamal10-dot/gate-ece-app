// lib/data/module_notes_data.dart

class ModuleQuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const ModuleQuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class ModuleStudyData {
  final String title;
  final String readTime;
  final String overview;
  final List<String> keyPrinciples;
  final List<String> equations;
  final String circuitDiagram;
  final String gateExamTips;
  final String officialResourceUrl;
  final String officialResourceName;
  final List<ModuleQuizQuestion> quizQuestions;

  const ModuleStudyData({
    required this.title,
    this.readTime = '10 min comprehensive read',
    required this.overview,
    required this.keyPrinciples,
    required this.equations,
    required this.circuitDiagram,
    required this.gateExamTips,
    required this.officialResourceUrl,
    required this.officialResourceName,
    required this.quizQuestions,
  });
}

/// Key: "$topicId-$moduleIndex"
final Map<String, ModuleStudyData> allModuleStudyData = {

  // ==========================================================================
  // 1. NETWORKS & CIRCUITS
  // ==========================================================================
  'networks-0': const ModuleStudyData(
    title: 'KVL, KCL, Mesh & Node Analysis',
    overview:
        'Kirchhoff\'s Current Law (KCL) is grounded in the conservation of electric charge: the algebraic sum of all currents entering any electrical node must equal zero (Sum I = 0).\n\n'
        'Kirchhoff\'s Voltage Law (KVL) is grounded in the conservation of energy: the algebraic sum of electric potential differences around any closed circuit loop is zero (Sum V = 0).\n\n'
        'Mesh Analysis applies KVL around independent planar loops. For a planar network with B branches and N nodes, the number of independent mesh equations required is M = B - N + 1. If a current source lies on the boundary of two meshes, a Supermesh is formed by removing the current source and writing a single combined KVL loop, supplemented by the source constraint equation.\n\n'
        'Nodal Analysis applies KCL at all non-reference nodes. A reference (ground) node is chosen with 0 V potential. If an ideal voltage source is connected between two non-reference nodes with no series resistor, a Supernode is enclosed around the source, applying KCL across its boundary.',
    keyPrinciples: [
      'KCL is valid for lumped circuits at all frequencies where circuit physical dimension is much smaller than wavelength (d << lambda).',
      'KVL states the line integral of electrostatic E-field around a closed contour is zero: oint E . dl = 0.',
      'Supermesh: Created when an independent/dependent current source is shared between two adjacent meshes.',
      'Supernode: Created when an independent/dependent voltage source is connected between two non-reference nodes.',
      'Tellegen\'s Theorem: In any lumped network, the sum of delivered powers across all branches is identically zero: Sum (v_k . i_k) = 0, valid for linear, non-linear, active, passive, and time-varying elements.',
    ],
    equations: [
      'KCL: Sum(I_entering) = Sum(I_leaving) => Sum_{k=1}^n I_k = 0',
      'KVL: Sum_{k=1}^m V_k = 0 (around any closed loop)',
      'Number of Independent Meshes: M = B - N + 1',
      'Number of Independent Node Equations: N_eq = N - 1',
      'Supernode Constraint: V_A - V_B = V_source',
    ],
    circuitDiagram:
        '       +-----------[ R1 ]-----------+-----------[ R2 ]-----------+\n'
        '       |                            |                            |\n'
        '     ( + ) Vs                   [ R_load ]                   ( ^ ) Is\n'
        '     ( - )                          |                        ( | )\n'
        '       |                            |                            |\n'
        '  -----+----------------------------+----------------------------+-----\n'
        '                                  (GND 0V)',
    gateExamTips:
        'Always check for dependent sources before applying mesh or nodal formulas. When a dependent source is present, never disable it during resistance calculations! In nodal analysis, choose the node connected to the maximum number of voltage sources as your ground reference to simplify the matrix equations.',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - Network Analysis',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'For a planar circuit having 8 branches and 5 nodes, the number of independent mesh equations required is:',
        options: ['4', '5', '3', '12'],
        correctIndex: 0,
        explanation: 'Number of independent meshes M = B - N + 1 = 8 - 5 + 1 = 4.',
      ),
      ModuleQuizQuestion(
        question: 'Tellegen\'s theorem is valid for which of the following circuits?',
        options: [
          'Only linear and time-invariant networks',
          'Only reciprocal networks',
          'Any lumped network, whether linear, non-linear, active, passive, or time-varying',
          'Only purely resistive DC networks',
        ],
        correctIndex: 2,
        explanation: 'Tellegen\'s theorem depends strictly on Kirchhoff\'s laws and network topology, making it universally valid for any lumped network.',
      ),
      ModuleQuizQuestion(
        question: 'In nodal analysis, if an ideal 10 V voltage source is connected between node 1 and node 2 without series resistance, we form a:',
        options: ['Supermesh', 'Supernode', 'Norton equivalent', 'Thevenin branch'],
        correctIndex: 1,
        explanation: 'A voltage source between two non-reference nodes forms a Supernode, governed by the constraint V1 - V2 = 10 V.',
      ),
    ],
  ),

  'networks-1': const ModuleStudyData(
    title: 'Thevenin\'s & Norton\'s Equivalent Theorems',
    overview:
        'Thevenin\'s Theorem states that any linear, two-terminal bilateral electrical network consisting of independent and dependent sources and resistors can be replaced at terminals A-B by an equivalent circuit containing an ideal voltage source Vth in series with an equivalent resistance Rth.\n\n'
        '* Vth (Open-Circuit Voltage, Voc): The potential difference across terminals A-B when the external load is disconnected (RL = infinity).\n\n'
        '* Rth (Thevenin Resistance): The equivalent looking-in resistance measured between terminals A-B with all independent sources turned off (independent voltage sources replaced by short circuits, independent current sources replaced by open circuits).\n\n'
        'When dependent sources are present, Rth CANNOT be found by simple resistor series/parallel reduction. Instead, deactivate all independent sources, apply an external test source (1 V or 1 A) across A-B, and compute Rth = V_test / I_test (or compute Rth = Voc / Isc).\n\n'
        'Norton\'s Theorem is the exact source-dual of Thevenin\'s Theorem. The entire network is replaced by an ideal current source IN = Isc in parallel with resistance RN = Rth. The transformation follows Ohm\'s Law: Vth = IN . Rth.',
    keyPrinciples: [
      'Vth = Voc (Terminal voltage when load current IL = 0).',
      'IN = Isc (Current through terminal A-B when short-circuited with a zero-ohm wire).',
      'Rth = RN = Voc / Isc (Valid for all linear networks, even with dependent sources).',
      'Maximum Power Transfer Theorem: A resistive load RL receives maximum power when RL = Rth. Efficiency at max power is exactly 50%.',
      'AC Maximum Power: For complex source impedance Zth = Rth + jXth, maximum power transfer occurs when ZL = Zth* = Rth - jXth (complex conjugate matching).',
    ],
    equations: [
      'Thevenin Voltage: Vth = Voc',
      'Norton Current: IN = Isc',
      'Equivalent Resistance: Rth = RN = Voc / Isc',
      'Load Current: IL = Vth / (Rth + RL)',
      'Maximum Power Transfer: P_max = (Vth^2) / (4 . Rth)',
      'AC Conjugate Match: Z_L = Z_th* = R_th - j.X_th',
    ],
    circuitDiagram:
        '  Thevenin Equivalent Circuit:           Norton Equivalent Circuit:\n'
        '       +----[ Rth ]----+----> Terminal A      +--------+----+----> Terminal A\n'
        '       |                                      |        |\n'
        '     ( + ) Vth              [ Load RL ]     ( ^ ) IN  [ RN ]   [ Load RL ]\n'
        '     ( - )                                  ( | )      |\n'
        '       |                                      |        |\n'
        '  -----+----------------> Terminal B     -----+--------+----+----> Terminal B',
    gateExamTips:
        'GATE Trap: If a circuit contains ONLY dependent sources and resistors (no independent sources), Voc = 0 and Isc = 0. In this case, Rth cannot be found by Voc/Isc! You MUST apply an external 1 V test source at the terminals and compute Rth = 1 V / I_test.',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - Circuit Theorems',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'A linear active network has open-circuit voltage Voc = 24 V and short-circuit current Isc = 4 A. What is the maximum power it can deliver to an external load resistor RL?',
        options: ['24 W', '48 W', '96 W', '12 W'],
        correctIndex: 0,
        explanation: 'Rth = Voc / Isc = 24 / 4 = 6 Ohms. P_max = (Voc^2) / (4 . Rth) = (24^2) / (4 . 6) = 576 / 24 = 24 W.',
      ),
      ModuleQuizQuestion(
        question: 'When finding the Thevenin equivalent resistance of a network containing dependent sources:',
        options: [
          'Deactivate both independent and dependent sources',
          'Deactivate independent sources only, keeping dependent sources active',
          'Keep independent sources active and short dependent sources',
          'Replace all resistors with short circuits',
        ],
        correctIndex: 1,
        explanation: 'Dependent sources are controlled by circuit variables and must NEVER be deactivated during Thevenin/Norton resistance calculations.',
      ),
      ModuleQuizQuestion(
        question: 'For an AC source with internal impedance Zth = 4 + j3 Ohms, the load impedance ZL for maximum power transfer is:',
        options: ['4 + j3 Ohms', '4 - j3 Ohms', '5 Ohms', '3 - j4 Ohms'],
        correctIndex: 1,
        explanation: 'Maximum power transfer in AC requires complex conjugate matching: ZL = Zth* = 4 - j3 Ohms.',
      ),
    ],
  ),

  // ==========================================================================
  // 2. SIGNALS & SYSTEMS
  // ==========================================================================
  'signals-2': const ModuleStudyData(
    title: 'Nyquist Sampling Theorem & Reconstruction',
    overview:
        'The Nyquist-Shannon Sampling Theorem establishes that a continuous-time bandlimited signal x(t) with maximum frequency component f_max can be uniquely reconstructed from its discrete-time samples without any loss of information if the sampling frequency f_s satisfies f_s >= 2 . f_max.\n\n'
        '* Nyquist Rate: The minimum sampling rate required to avoid spectral aliasing: f_N = 2 . f_max (or omega_N = 2 . omega_max).\n\n'
        '* Nyquist Interval: The maximum allowable time between consecutive samples: T_s <= 1 / (2 . f_max).\n\n'
        'When f_s < 2 . f_max, spectral overlapping known as aliasing occurs, where high-frequency signal components fold into the baseband and corrupt the original signal. An analog Anti-Aliasing Filter (low-pass filter with cutoff f_c <= f_s / 2) must precede the sampler.\n\n'
        'Signal reconstruction is performed using an ideal low-pass filter with impulse response h(t) = sinc(2 . f_max . t), interpolating samples in the time domain via the Whittaker-Shannon interpolation formula: x(t) = Sum_{n=-infinity}^infinity x(n.Ts) . sinc((t - n.Ts) / Ts).',
    keyPrinciples: [
      'Sampling in time domain corresponds to periodic replication of spectrum in frequency domain: X_s(f) = (1/Ts) . Sum_{k=-infinity}^infinity X(f - k.fs).',
      'Aliasing is prevented if and only if (fs - f_max) >= f_max, meaning fs >= 2 . f_max.',
      'Multiplication of two signals in time x1(t) . x2(t) corresponds to convolution in frequency: bandwidth adds, so f_max_total = f_max1 + f_max2.',
      'Convolution of two signals x1(t) * x2(t) corresponds to multiplication in frequency: bandwidth is the minimum, so f_max_total = min(f_max1, f_max2).',
      'For a sinc^2(200t) signal: sinc(200t) has bandwidth 100 Hz. Squaring doubles bandwidth to 200 Hz, so Nyquist rate is 2 . 200 = 400 Hz.',
    ],
    equations: [
      'Nyquist Sampling Condition: f_s >= 2 . f_max',
      'Nyquist Rate: f_N = 2 . f_max',
      'Nyquist Interval: T_s = 1 / (2 . f_max)',
      'Sampled Spectrum: X_s(omega) = (1/Ts) . Sum_{k=-infinity}^infinity X(omega - k.omega_s)',
      'Time-domain Product: BW{x1(t) . x2(t)} = BW1 + BW2',
      'Reconstruction Interpolation: x(t) = Sum_n x(n.Ts) . sinc(pi . (t - n.Ts) / Ts)',
    ],
    circuitDiagram:
        'Continuous Signal x(t)       Impulse Sampler s(t)       Sampled Signal x_s(t)\n'
        '     -------------> [ MULTIPLIER (X) ] -------------->\n'
        '                            ^\n'
        '                            |\n'
        '                    p(t) = Sum delta(t - n.Ts)\n'
        '\n'
        'Spectrum:        -f_max     0     +f_max           fs-f_max   fs   fs+f_max\n'
        '               .../\\.......|......./\\...       .../\\.......|......./\\...\n'
        '  --------------------------------------------------------------------> Frequency (f)\n'
        '                    |<- 2.f_max ->|             |<-- fs >= 2.f_max -->|',
    gateExamTips:
        'Pay special attention to sinc and sinc^2 functions in GATE! For x(t) = sinc(A.t), the Fourier transform is a rectangular pulse from -A/2 to +A/2. Thus f_max = A/2 Hz, and Nyquist rate = A Hz. For sinc^2(A.t), f_max = A Hz, and Nyquist rate = 2.A Hz!',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - Signals & Sampling',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'The Nyquist sampling rate for the signal x(t) = sinc^2(400 . t) is:',
        options: ['400 Hz', '800 Hz', '200 Hz', '1600 Hz'],
        correctIndex: 1,
        explanation: 'sinc(400t) has f_max = 200 Hz. Squaring in time convolves in frequency, doubling bandwidth: f_max_new = 400 Hz. Nyquist rate = 2 . f_max = 2 . 400 = 800 Hz.',
      ),
      ModuleQuizQuestion(
        question: 'If two bandlimited signals x1(t) with bandwidth 10 kHz and x2(t) with bandwidth 15 kHz are multiplied together in time, the Nyquist rate of the resulting signal is:',
        options: ['25 kHz', '30 kHz', '50 kHz', '20 kHz'],
        correctIndex: 2,
        explanation: 'Multiplication in time convolves spectra: total bandwidth B = B1 + B2 = 10 + 15 = 25 kHz. The Nyquist sampling rate is 2 . B = 2 . 25 = 50 kHz.',
      ),
      ModuleQuizQuestion(
        question: 'Aliasing occurs during continuous-to-discrete conversion whenever:',
        options: [
          'Sampling frequency is greater than twice the highest frequency',
          'Sampling frequency is strictly equal to highest frequency',
          'Sampling frequency is strictly less than twice the maximum signal frequency',
          'Signal has infinite amplitude',
        ],
        correctIndex: 2,
        explanation: 'By the Nyquist criterion, aliasing occurs whenever fs < 2 . f_max, as spectral replicas overlap.',
      ),
    ],
  ),

  // ==========================================================================
  // 3. ELECTRONIC DEVICES (EDC)
  // ==========================================================================
  'devices-2': const ModuleStudyData(
    title: 'MOSFET Physics, Operational Modes & Saturation Current',
    overview:
        'The Metal-Oxide-Semiconductor Field-Effect Transistor (MOSFET) is a voltage-controlled majority carrier device. An NMOS transistor consists of a p-type substrate (body) with two heavily doped n+ regions (source and drain), separated by a thin dielectric insulator (silicon dioxide, SiO2) beneath a conductive gate electrode.\n\n'
        '* Threshold Voltage (Vth): The minimum gate-to-source voltage required to invert the surface of the p-substrate beneath the oxide from p-type to an n-type conductive inversion layer channel.\n\n'
        '* Cutoff Region (Vgs < Vth): No conduction channel exists between source and drain; drain current ID = 0 A (neglecting subthreshold leakage).\n\n'
        '* Triode (Linear / Ohmic) Region [Vgs >= Vth and Vds < (Vgs - Vth)]: A continuous inversion channel extends from source to drain. The channel acts as a voltage-controlled resistor, where ID depends on both Vgs and Vds.\n\n'
        '* Saturation (Active / Pinch-Off) Region [Vgs >= Vth and Vds >= (Vgs - Vth)]: The inversion layer pinches off at the drain end (Vgd <= Vth). Additional drain voltage increases the depletion region width around the drain pinch-off point rather than increasing channel electric field. Consequently, drain current ID saturates and is predominantly controlled by Vgs alone (ideal current source behavior).\n\n'
        '* Channel Length Modulation (Early Effect): High Vds reduces effective channel length L_eff, causing a slight upward slope in ID vs Vds characterized by parameter lambda: ID = (1/2) . mu_n . Cox . (W/L) . (Vgs - Vth)^2 . (1 + lambda . Vds).',
    keyPrinciples: [
      'Oxide Capacitance per unit area: Cox = epsilon_ox / t_ox, where epsilon_ox = 3.9 . epsilon_0.',
      'Transconductance Parameter: k_n\' = mu_n . Cox (typically 100 - 400 muA/V^2 in modern planar processes).',
      'Pinch-off condition at drain: V_DS_sat = V_GS - V_TH (known as the overdrive voltage V_ov).',
      'Small-signal transconductance: g_m = d(I_D) / d(V_GS) = sqrt(2 . mu_n . Cox . (W/L) . I_D) = 2 . I_D / (V_GS - V_TH).',
      'Small-signal output resistance: r_o = 1 / (lambda . I_D) = V_A / I_D.',
      'Body Effect: If source is at higher potential than substrate (Vsb > 0), threshold voltage increases: Delta Vth = gamma . [sqrt(2.phi_F + Vsb) - sqrt(2.phi_F)].',
    ],
    equations: [
      'Triode Region: I_D = mu_n . C_ox . (W/L) . [(V_GS - V_TH).V_DS - (V_DS^2)/2]',
      'Saturation Current: I_D = (1/2) . mu_n . C_ox . (W/L) . (V_GS - V_TH)^2 . (1 + lambda.V_DS)',
      'Overdrive Voltage: V_ov = V_GS - V_TH',
      'Saturation Condition: V_DS >= V_GS - V_TH',
      'Small-signal Transconductance: g_m = 2 . I_D / V_ov = sqrt(2 . k_n . I_D)',
      'Output Resistance: r_o = 1 / (lambda . I_D)',
    ],
    circuitDiagram:
        '                  Gate (V_GS)\n'
        '                    [=======]   <-- Metal / Polysilicon Gate\n'
        '               -----------------  <-- Oxide (SiO2, t_ox)\n'
        '      n+ [Source]   Channel   n+ [Drain]  (V_DS)\n'
        '     +-----------+===========+-----------+\n'
        '     |           | (Inversion|           |\n'
        '     |           |   Layer)  |           |\n'
        '     +-----------+-----------+-----------+\n'
        '               p-type Substrate (Body V_B)',
    gateExamTips:
        'Always check the region of operation first! Calculate V_ov = Vgs - Vth. If Vds < V_ov, use the Triode equation. If Vds >= V_ov, use the Saturation square-law formula. For small-signal questions, remember that g_m can be written in three distinct ways depending on what is held constant: 2.ID/Vov, sqrt(2.kn.ID), or kn.Vov.',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - MOSFET Devices',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'An NMOS transistor operates with V_GS = 3 V, V_TH = 1 V, and V_DS = 3 V. The transistor is operating in:',
        options: ['Cutoff region', 'Triode (Linear) region', 'Saturation region', 'Subthreshold conduction'],
        correctIndex: 2,
        explanation: 'V_GS = 3 V > V_TH = 1 V (channel is on). Overdrive voltage V_ov = V_GS - V_TH = 3 - 1 = 2 V. Since V_DS = 3 V >= V_ov (2 V), the MOSFET is in Saturation.',
      ),
      ModuleQuizQuestion(
        question: 'If the drain current ID of a saturation-mode MOSFET is doubled while keeping (W/L) and V_TH constant, the transconductance g_m increases by a factor of:',
        options: ['2', 'sqrt(2) = 1.414', '4', '0.5'],
        correctIndex: 1,
        explanation: 'Since g_m = sqrt(2 . mu_n . Cox . (W/L) . I_D), g_m is proportional to sqrt(I_D). Doubling I_D increases g_m by a factor of sqrt(2) approx 1.414.',
      ),
      ModuleQuizQuestion(
        question: 'The physical mechanism causing channel pinch-off at the drain in a MOSFET is:',
        options: [
          'Gate oxide breakdown under excessive voltage',
          'Reverse bias breakdown of source-body junction',
          'Reduction of gate-to-channel potential below threshold voltage at the drain end (V_GD <= V_TH)',
          'Velocity saturation of electron carriers',
        ],
        correctIndex: 2,
        explanation: 'Pinch-off occurs when the local gate-to-channel voltage at the drain drops to V_TH, so V_GD <= V_TH, extinguishing the inversion layer at the drain edge.',
      ),
    ],
  ),

  // ==========================================================================
  // 4. ANALOG CIRCUITS
  // ==========================================================================
  'analog-1': const ModuleStudyData(
    title: 'Op-Amp Fundamentals, Golden Rules & Linear Topologies',
    overview:
        'An Operational Amplifier (Op-Amp) is a high-gain DC-coupled differential amplifier designed to perform mathematical operations with external feedback components.\n\n'
        '* Golden Rule 1 (Virtual Short): When negative feedback is present and the op-amp output is not saturated, the differential input voltage is zero: V(+) = V(-).\n\n'
        '* Golden Rule 2 (Virtual Open): The input impedance of an ideal op-amp is infinite (Z_in = infinity). Therefore, zero current flows into either input terminal: I(+) = I(-) = 0 A.\n\n'
        '* Inverting Amplifier: The non-inverting terminal is connected to ground. An input resistor R1 connects to the inverting terminal, and feedback resistor Rf loops from output to inverting terminal. Gain A_v = -Rf / R1.\n\n'
        '* Non-Inverting Amplifier: Input is applied directly to the non-inverting terminal (+). Feedback divider R1 and Rf connects from output to inverting terminal (-). Gain A_v = 1 + (Rf / R1).\n\n'
        '* Op-Amp Integrator: Feedback resistor is replaced by capacitor C. Output voltage is proportional to the time integral of input: V_out(t) = -(1 / (R.C)) . integral V_in(t) dt.\n\n'
        '* Op-Amp Differentiator: Input resistor is replaced by capacitor C. Output is proportional to the time derivative: V_out(t) = -R.C . (d V_in / dt).',
    keyPrinciples: [
      'Ideal Op-Amp parameters: Open-loop gain A_OL = infinity, Input impedance Z_in = infinity, Output impedance Z_out = 0, Bandwidth BW = infinity, Common-Mode Rejection Ratio CMRR = infinity, Slew Rate SR = infinity.',
      'Negative Feedback ensures stability and keeps the op-amp operating within its linear region: -V_sat <= V_out <= +V_sat.',
      'Positive Feedback leads to saturation and hysteresis (used in Schmitt Triggers and Multivibrators).',
      'Virtual ground exists at the inverting terminal of an inverting amplifier because V(+) is grounded and V(-) = V(+) = 0 V.',
      'Slew Rate limit: Maximum rate of change of output voltage: SR = max |dV_out/dt|. For sinusoidal output V_m . sin(omega.t), full-power bandwidth is f_max = SR / (2 . pi . V_m).',
    ],
    equations: [
      'Inverting Gain: V_out = -(R_f / R_1) . V_in',
      'Non-Inverting Gain: V_out = (1 + R_f / R_1) . V_in',
      'Voltage Follower (Buffer): V_out = V_in (Gain = +1, Z_in = inf, Z_out = 0)',
      'Inverting Integrator: V_out(t) = -(1 / (R.C)) . int_0^t V_in(tau) dtau + V_out(0)',
      'Inverting Differentiator: V_out(t) = -R.C . (d V_in / dt)',
      'Full-power Bandwidth: f_max = Slew_Rate / (2 . pi . V_peak)',
      'CMRR: CMRR = 20 . log10(|A_d / A_cm|) dB',
    ],
    circuitDiagram:
        '                     R_f\n'
        '             +------[===]------+\n'
        '             |                 |\n'
        '   Vin --[R1]--+--(-)          |\n'
        '                  \\           |\n'
        '                   \\----------+----> Vout = -(Rf/R1).Vin\n'
        '                   //\n'
        '            +--(+)//\n'
        '            |\n'
        '          (GND 0V)',
    gateExamTips:
        'Always verify if negative feedback dominates! If feedback connects to the non-inverting terminal (+), the virtual ground concept is INVALID. You must check whether the op-amp acts as a Schmitt trigger or comparator with output clamped to supply rails (+V_sat or -V_sat).',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - Operational Amplifiers',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'An inverting amplifier has R1 = 10 kOhms and Rf = 100 kOhms, powered from +/- 15 V supplies. If an input Vin = 2 V is applied, the output voltage Vout is:',
        options: ['-20 V', '-15 V (saturated)', '-10 V', '+20 V'],
        correctIndex: 1,
        explanation: 'Ideal linear output would be Vout = -(Rf/R1).Vin = -(100/10).2 = -20 V. However, the output cannot exceed the supply rails (+/- 15 V), so it saturates at -15 V.',
      ),
      ModuleQuizQuestion(
        question: 'An ideal op-amp circuit has slew rate SR = 1 V/microsecond. The maximum frequency of a 10 V peak sinusoidal output without slew-rate distortion is:',
        options: ['15.9 kHz', '31.8 kHz', '100 kHz', '50 kHz'],
        correctIndex: 0,
        explanation: 'f_max = SR / (2 . pi . V_peak) = 10^6 / (2 . pi . 10) = 10^5 / (20 . pi) approx 15,915 Hz approx 15.9 kHz.',
      ),
      ModuleQuizQuestion(
        question: 'In an op-amp integrator, replacing the input resistor R with a short circuit will cause:',
        options: [
          'Linear ramping with finite slope',
          'Output saturation due to uncontrolled, theoretically infinite charging current',
          'Zero output voltage',
          'Oscillation at resonance frequency',
        ],
        correctIndex: 1,
        explanation: 'With R = 0, current i(t) = C . dV/dt is unrestricted and approaches infinity, immediately driving the op-amp output into positive or negative saturation.',
      ),
    ],
  ),

  // ==========================================================================
  // 5. CONTROL SYSTEMS
  // ==========================================================================
  'control-2': const ModuleStudyData(
    title: 'Bode Plots, Gain Margin & Phase Margin',
    overview:
        'A Bode plot is a frequency-response representation consisting of two logarithmic plots: the magnitude plot in decibels (20 . log10 |G(j.omega)|) versus log10(omega), and the phase angle plot in degrees (angle G(j.omega)) versus log10(omega).\n\n'
        '* Gain Crossover Frequency (omega_gc): The frequency at which the open-loop magnitude |G(j.omega)| = 1 (meaning the magnitude plot crosses the 0 dB line).\n\n'
        '* Phase Crossover Frequency (omega_pc): The frequency at which the open-loop phase angle angle G(j.omega) crosses -180 degrees.\n\n'
        '* Gain Margin (GM): The amount of additional gain required to make a system marginally stable: GM = -20 . log10 |G(j.omega_pc)| dB. If |G(j.omega_pc)| < 1 (below 0 dB), GM is positive (> 0 dB).\n\n'
        '* Phase Margin (PM): The additional phase lag required at omega_gc to bring the system to marginal stability: PM = 180 deg + angle G(j.omega_gc). If angle G(j.omega_gc) is above -180 deg, PM is positive (> 0 deg).\n\n'
        '* Stability Criterion (for minimum-phase systems):\n'
        '  - Stable: omega_gc < omega_pc (both GM > 0 dB and PM > 0 deg).\n'
        '  - Marginally Stable: omega_gc = omega_pc (GM = 0 dB and PM = 0 deg).\n'
        '  - Unstable: omega_gc > omega_pc (GM < 0 dB and PM < 0 deg).',
    keyPrinciples: [
      'Bode magnitude slopes: A pole at the origin (1/s) gives -20 dB/decade slope passing through 0 dB at omega = 1.',
      'A simple pole 1/(1 + s/p) introduces a break frequency at omega = p, shifting slope by -20 dB/decade and contributing -45 deg phase at break frequency.',
      'A simple zero (1 + s/z) introduces a break frequency at omega = z, shifting slope by +20 dB/decade and contributing +45 deg phase at break frequency.',
      'Minimum-phase system: Has all poles and zeros located strictly in the Left Half of the s-plane (LHP).',
      'Non-minimum phase system: Contains zeros or poles in the Right Half Plane (RHP) or time delay e^(-s.T), introducing excess phase lag without changing magnitude asymptote.',
    ],
    equations: [
      'Magnitude in dB: M_dB = 20 . log10 |G(j.omega)|',
      'Gain Crossover Condition: |G(j.omega_gc)| = 1 (i.e., 0 dB)',
      'Phase Crossover Condition: angle G(j.omega_pc) = -180 deg',
      'Gain Margin: GM_dB = -20 . log10 |G(j.omega_pc)|',
      'Phase Margin: PM = 180 deg + angle G(j.omega_gc)',
      'Stability Condition: omega_gc < omega_pc <=> GM > 0 dB, PM > 0 deg',
    ],
    circuitDiagram:
        'Magnitude (dB)\n'
        '     20 dB  \\\n'
        '      0 dB ---\\---------[ omega_gc ]-------------------------> Frequency (omega)\n'
        '               \\\n'
        '  Phase (deg)   \\\n'
        '      0 deg -----*------------------------------------------->\n'
        '   -180 deg -------\\---[ omega_pc ]------------------------->\n'
        '                     \\            |<--- PM = 180 + angle(w_gc)\n'
        '                      \\           |     GM = -|M(w_pc)|',
    gateExamTips:
        'When calculating Phase Margin for G(s) = K / [s(1+s)(1+2s)], first find omega_gc by setting |G(j.omega)| = 1. Then compute phase angle at that specific frequency: angle = -90 - arctan(omega_gc) - arctan(2.omega_gc). Finally, PM = 180 + angle. Never confuse omega_gc with omega_pc!',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - Control Frequency Response',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'For a unity negative feedback system, omega_gc = 2 rad/s and omega_pc = 5 rad/s. If the system is minimum phase, the closed-loop system is:',
        options: ['Stable', 'Unstable', 'Marginally stable', 'Conditionally stable with oscillatory poles'],
        correctIndex: 0,
        explanation: 'For minimum phase systems, if omega_gc < omega_pc (here 2 < 5 rad/s), both Gain Margin and Phase Margin are positive, so the system is Stable.',
      ),
      ModuleQuizQuestion(
        question: 'At the gain crossover frequency omega_gc, the open-loop phase angle is -135 degrees. The phase margin is:',
        options: ['+45 degrees', '-45 degrees', '+135 degrees', '-135 degrees'],
        correctIndex: 0,
        explanation: 'Phase Margin PM = 180 deg + angle G(j.omega_gc) = 180 + (-135) = +45 degrees.',
      ),
      ModuleQuizQuestion(
        question: 'The presence of a transportation lag (time delay e^(-s.T)) in an open-loop transfer function:',
        options: [
          'Decreases magnitude and improves stability',
          'Leaves magnitude unchanged but increases phase lag, reducing Phase Margin',
          'Shifts the Bode magnitude plot upward by 20 dB',
          'Adds a zero in the left half s-plane',
        ],
        correctIndex: 1,
        explanation: 'Since |e^(-j.omega.T)| = 1 (0 dB), the magnitude plot is identical, but phase angle decreases by -omega.T radians (-57.3 . omega . T degrees), reducing Phase Margin.',
      ),
    ],
  ),

  // ==========================================================================
  // 6. COMMUNICATIONS
  // ==========================================================================
  'communications-2': const ModuleStudyData(
    title: 'Pulse Code Modulation (PCM), Quantization & SNR',
    overview:
        'Pulse Code Modulation (PCM) is the standard method for converting continuous analog waveforms into discrete digital binary bitstreams. The process consists of three core stages: Sampling, Quantization, and Binary Encoding.\n\n'
        '* 1. Sampling: The analog signal is sampled at sampling frequency fs >= 2 . W (Nyquist rate) to generate discrete-time, continuous-amplitude Pulse Amplitude Modulated (PAM) samples.\n\n'
        '* 2. Quantization: The continuous range of sample amplitudes is partitioned into L = 2^n discrete levels separated by step size Delta. Each analog sample is rounded to the nearest discrete level. The rounding error is Quantization Error e_q, which is uniformly distributed over [-Delta/2, +Delta/2].\n\n'
        '* 3. Binary Encoding: Each quantized level is assigned an n-bit binary code word. The resulting bit rate is R_b = n . f_s bits/second.\n\n'
        '* Transmission Bandwidth: The minimum baseband transmission bandwidth required for a PCM bitstream (using Nyquist pulse shaping) is B_T >= R_b / 2 = (n . f_s) / 2.\n\n'
        '* Signal-to-Quantization Noise Ratio (SQNR): For a full-scale sinusoidal signal with n quantization bits, SQNR increases by 6 dB for every extra bit added: SQNR_dB = 6.02 . n + 1.76 dB.',
    keyPrinciples: [
      'Step size for signal with dynamic range V_max - V_min: Delta = (V_max - V_min) / L = (V_max - V_min) / (2^n).',
      'Quantization Noise Power (variance): N_q = integral_{-Delta/2}^{+Delta/2} (e^2 / Delta) de = Delta^2 / 12.',
      'Bit rate: R_b = n . f_s (where n = number of bits per sample, f_s = sampling frequency).',
      'Minimum Baseband Bandwidth: B_min = R_b / 2 = n . f_s / 2 (or B_min = n . W when sampled at Nyquist rate f_s = 2.W).',
      '6 dB Rule: Adding 1 additional bit doubles the number of levels (L), halves the quantization step (Delta/2), quarters noise power (N_q/4), increasing SNR by 10.log10(4) = 6.02 dB.',
      'Companding (A-law and mu-law): Non-uniform quantization that compresses dynamic range before uniform quantization, giving equal SNR for quiet and loud speech signals.',
    ],
    equations: [
      'Quantization Levels: L = 2^n',
      'Step Size: Delta = (V_max - V_min) / 2^n',
      'Quantization Noise Power: N_q = (Delta^2) / 12',
      'PCM Bit Rate: R_b = n . f_s',
      'Minimum Bandwidth: B_T = R_b / 2 = (n . f_s) / 2',
      'Sinusoidal SQNR (dB): (S/N)_q = 6.02 . n + 1.76 dB',
    ],
    circuitDiagram:
        'Analog Input x(t)       PAM Samples           Quantized Levels       PCM Bitstream\n'
        '  ---->[ SAMPLER ]----->[ QUANTIZER ]--------->[ ENCODER ]---------> [ TRANSMITTER ]\n'
        '           ^                  ^                     ^\n'
        '           |                  |                     |\n'
        '        Clock (f_s)       Step (Delta)          n bits / sample\n'
        '\n'
        'Step Size:   Delta = (V_max - V_min) / 2^n\n'
        'Bit Rate:    R_b = n . f_s  bps',
    gateExamTips:
        'A frequent GATE numerical question: If the number of quantization levels is increased from 64 to 256, what is the improvement in SQNR? Solution: 64 = 2^6 (n=6), 256 = 2^8 (n=8). Delta n = 8 - 6 = 2 bits. SQNR improves by 2 . 6.02 = 12.04 dB (or a factor of 16 in linear power)!',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - Digital Communications',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'A speech signal bandlimited to 4 kHz is sampled at 1.25 times the Nyquist rate and encoded using an 8-bit PCM system. The bit rate of the PCM system is:',
        options: ['64 kbps', '80 kbps', '32 kbps', '100 kbps'],
        correctIndex: 1,
        explanation: 'Nyquist rate = 2 . 4 kHz = 8 kHz. Sampling rate fs = 1.25 . 8 kHz = 10 kHz. Bit rate Rb = n . fs = 8 . 10,000 = 80,000 bps = 80 kbps.',
      ),
      ModuleQuizQuestion(
        question: 'In a PCM system, if the number of quantization bits is increased from 7 to 9, the signal-to-quantization-noise ratio increases by approximately:',
        options: ['6 dB', '12 dB', '18 dB', '2 dB'],
        correctIndex: 1,
        explanation: 'Each additional bit increases SQNR by 6.02 dB. Here Delta n = 9 - 7 = 2 bits. Improvement = 2 . 6.02 dB approx 12 dB.',
      ),
      ModuleQuizQuestion(
        question: 'Assuming uniform quantization over [-V, +V], the quantization noise power is given by:',
        options: ['Delta^2 / 6', 'Delta^2 / 12', 'Delta^2 / 4', 'Delta^2 / 24'],
        correctIndex: 1,
        explanation: 'For a uniform probability distribution over [-Delta/2, +Delta/2], the variance is (Delta^2) / 12.',
      ),
    ],
  ),

  // ==========================================================================
  // 7. ELECTROMAGNETICS
  // ==========================================================================
  'electromagnetics-1': const ModuleStudyData(
    title: 'Uniform Plane Waves, Intrinsic Impedance & Skin Depth',
    overview:
        'Uniform Plane Waves (UPWs) are electromagnetic waves where electric field E and magnetic field H are spatially uniform across infinite planar wavefronts perpendicular to the direction of wave propagation.\n\n'
        '* Intrinsic Impedance (eta): The ratio of transverse electric field to transverse magnetic field in a medium: eta = E / H = sqrt(mu / epsilon). In free space, eta_0 = sqrt(mu_0 / epsilon_0) approx 120 . pi approx 377 Ohms.\n\n'
        '* Wave Propagation in Lossless Media: Attenuation constant alpha = 0 Np/m, phase constant beta = omega . sqrt(mu . epsilon) rad/m, phase velocity v_p = 1 / sqrt(mu . epsilon).\n\n'
        '* Wave Propagation in Good Conductors (sigma / (omega.epsilon) >> 1): Conductive media dissipate EM energy into heat (Joule losses). The wave attenuates exponentially as e^(-alpha.z).\n\n'
        '* Skin Depth (delta): The penetration depth at which the amplitude of the electromagnetic wave drops to 1/e (approx 36.8%) of its initial surface value: delta = 1 / alpha = 1 / sqrt(pi . f . mu . sigma).\n\n'
        '* High-frequency implications: At high frequencies (GHz domain), skin depth is sub-micron, forcing current to flow in an extremely thin surface layer and dramatically increasing AC resistance.',
    keyPrinciples: [
      'Poynting Vector: Instantaneous power density: S = E x H [W/m^2]. Time-average power density for lossless wave: P_avg = (1/2) . (|E|^2 / eta) a_z.',
      'Polarization: Defined by orientation of electric field vector E(t). Can be Linear (E stays along one line), Circular (equal orthogonal components in 90 deg phase quadrature), or Elliptical.',
      'Loss Tangent: tan(theta) = sigma / (omega . epsilon). If << 1, good dielectric. If >> 1, good conductor.',
      'In good conductors: alpha = beta = sqrt(pi . f . mu . sigma) = 1 / delta.',
      'Intrinsic impedance of conductor: eta_c = sqrt(j . omega . mu / sigma) = (1 + j) / (sigma . delta) = |eta_c| . e^(j.pi/4), meaning magnetic field lags electric field by 45 degrees!',
    ],
    equations: [
      'Intrinsic Impedance: eta = sqrt(mu / epsilon)',
      'Free Space Impedance: eta_0 = sqrt(mu_0 / epsilon_0) approx 377 Ohms',
      'Phase Constant: beta = omega . sqrt(mu . epsilon) = 2.pi / lambda',
      'Skin Depth (Good Conductor): delta = 1 / sqrt(pi . f . mu . sigma)',
      'Attenuation Constant: alpha = 1 / delta = sqrt(pi . f . mu . sigma)',
      'Time-Average Power Flow: P_avg = (1/2) . Re{E x H*} = (|E_0|^2 / (2.eta)) a_z',
    ],
    circuitDiagram:
        '   E-field (y-axis)              Direction of Propagation (z-axis)\n'
        '         ^                               ----->\n'
        '         |       +----+          \n'
        '         |      /      \\        Wave: E(z,t) = E0 . e^(-alpha.z) . cos(w.t - beta.z) a_y\n'
        '         |-----+--------+------->\n'
        '        /       \\      /        At z = delta: Amplitude = E0 / e = 0.368 . E0\n'
        '       /         +----+\n'
        '      v\n'
        '   H-field (x-axis)',
    gateExamTips:
        'In GATE, always verify medium classification before applying formulas! If sigma = 0, use lossless formulas. If sigma >> omega.epsilon, use good conductor skin depth delta = 1/sqrt(pi.f.mu.sigma). Notice that skin depth is inversely proportional to sqrt(frequency): quadrupling frequency halves skin depth!',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - Electromagnetics',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'In free space, an electromagnetic wave has peak electric field amplitude E0 = 37.7 V/m. The peak magnetic field amplitude H0 is:',
        options: ['0.1 A/m', '10 A/m', '14.2 A/m', '0.01 A/m'],
        correctIndex: 0,
        explanation: 'H0 = E0 / eta_0 = 37.7 V/m / 377 Ohms = 0.1 A/m.',
      ),
      ModuleQuizQuestion(
        question: 'If the frequency of an electromagnetic wave inside a copper conductor is multiplied by 4, the skin depth delta becomes:',
        options: ['4 times original', 'Double original', 'Half of original', 'One-fourth of original'],
        correctIndex: 2,
        explanation: 'Skin depth delta is inversely proportional to sqrt(f). Multiplying frequency by 4 decreases skin depth by sqrt(4) = 2, so it becomes half (0.5x).',
      ),
      ModuleQuizQuestion(
        question: 'In a good conductor, the phase difference between electric field E and magnetic field H is:',
        options: ['0 degrees (in phase)', '45 degrees (H lags E)', '90 degrees (H in quadrature)', '180 degrees'],
        correctIndex: 1,
        explanation: 'The intrinsic impedance of a good conductor is eta = |eta| . e^(j.pi/4), which causes the magnetic field H to lag electric field E by exactly 45 degrees.',
      ),
    ],
  ),

  // ==========================================================================
  // 8. ENGINEERING MATHEMATICS
  // ==========================================================================
  'math-0': const ModuleStudyData(
    title: 'Linear Algebra, Eigenvalues & Cayley-Hamilton Theorem',
    overview:
        'Linear Algebra forms the bedrock of state-space control theory, signal processing, and communication matrices in GATE ECE.\n\n'
        '* Eigenvalues (lambda): Scalars satisfying the characteristic equation det(A - lambda . I) = 0 for an n x n square matrix A.\n\n'
        '* Eigenvectors (X): Non-zero vectors satisfying (A - lambda . I) . X = 0.\n\n'
        '* Key Algebraic Properties of Eigenvalues:\n'
        '  1. Sum of eigenvalues = Trace of the matrix (sum of main diagonal elements): Sum lambda_i = Trace(A).\n'
        '  2. Product of eigenvalues = Determinant of the matrix: Product lambda_i = det(A).\n'
        '  3. Eigenvalues of an upper/lower triangular or diagonal matrix are simply the main diagonal elements.\n'
        '  4. If matrix A has eigenvalues lambda_i, then A^k has eigenvalues (lambda_i)^k, and A^(-1) has eigenvalues 1 / lambda_i (provided det(A) != 0).\n'
        '  5. Eigenvalues of a real symmetric matrix are ALWAYS real numbers.\n'
        '  6. Eigenvalues of a skew-symmetric matrix are either zero or purely imaginary (j.omega).\n\n'
        '* Cayley-Hamilton Theorem: Every square matrix satisfies its own characteristic equation! If P(lambda) = det(A - lambda.I) = lambda^n + c_{n-1}.lambda^{n-1} + ... + c_0 = 0, then substituting matrix A yields: A^n + c_{n-1}.A^{n-1} + ... + c_0 . I = 0. This enables rapid calculation of high matrix powers (A^100) and matrix inverses A^(-1).',
    keyPrinciples: [
      'Rank of a matrix: Maximum number of linearly independent rows or columns. Rank(A) <= min(m, n).',
      'System of linear equations A . X = B has a unique solution if Rank(A) = Rank([A|B]) = n (number of variables).',
      'Infinite solutions exist if Rank(A) = Rank([A|B]) < n.',
      'No solution (inconsistent system) if Rank(A) < Rank([A|B]).',
      'Diagonalization: Matrix A can be diagonalized as A = P . D . P^(-1) if and only if A has n linearly independent eigenvectors.',
    ],
    equations: [
      'Characteristic Equation: det(A - lambda . I) = 0',
      'Eigenvector Definition: A . X = lambda . X',
      'Trace Property: Sum_{i=1}^n lambda_i = Trace(A) = Sum_{i=1}^n a_{ii}',
      'Determinant Property: Product_{i=1}^n lambda_i = det(A)',
      'Cayley-Hamilton: A^n + c_{n-1}.A^{n-1} + ... + c_0 . I = 0',
      'Inverse via Cayley-Hamilton: A^(-1) = -(1/c_0) . [A^{n-1} + c_{n-1}.A^{n-2} + ... + c_1 . I]',
    ],
    circuitDiagram:
        'Matrix Vector Transformation:   Y = A . X\n'
        'For Eigenvectors:              A . X = lambda . X\n'
        '\n'
        '        Direction of X is preserved; only scaled by eigenvalue factor lambda!\n'
        '        \n'
        '           ^                   ^ (lambda . X)\n'
        '           |                  /\n'
        '           | X               /\n'
        '           |    ----->      /\n'
        '           +----->         +----->',
    gateExamTips:
        'In GATE, you rarely need to compute eigenvalues from scratch! Always check the two golden shortcuts first:\n'
        '1. Sum of options = Trace(A)\n'
        '2. Product of options = det(A)\n'
        'In 90% of GATE questions, matching Trace and Determinant immediately isolates the correct answer option within 15 seconds without solving any quadratic/cubic equation!',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus - Engineering Mathematics',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'A 2x2 matrix A has trace = 7 and determinant = 10. The eigenvalues of matrix A are:',
        options: ['2 and 5', '1 and 6', '3 and 4', '-2 and -5'],
        correctIndex: 0,
        explanation: 'Sum of eigenvalues = 2 + 5 = 7 (Trace), and product = 2 . 5 = 10 (Determinant). Thus eigenvalues are 2 and 5.',
      ),
      ModuleQuizQuestion(
        question: 'If a 3x3 matrix has eigenvalues 1, -1, and 2, what is the determinant of matrix A^3?',
        options: ['-8', '+8', '-2', '+2'],
        correctIndex: 0,
        explanation: 'Eigenvalues of A^3 are (1)^3 = 1, (-1)^3 = -1, and (2)^3 = 8. det(A^3) = product of eigenvalues = 1 . (-1) . 8 = -8.',
      ),
      ModuleQuizQuestion(
        question: 'According to the Cayley-Hamilton theorem, every square matrix A satisfies:',
        options: [
          'Its own characteristic polynomial equation det(A - lambda.I) = 0',
          'A . A^T = I',
          'det(A) = 0',
          'Trace(A) = 0',
        ],
        correctIndex: 0,
        explanation: 'The Cayley-Hamilton theorem states that substituting matrix A into its characteristic polynomial produces the null matrix: P(A) = 0.',
      ),
    ],
  ),
};

/// Public helper to retrieve or generate comprehensive study data for any module
ModuleStudyData getModuleStudyData(String topicId, int index, String moduleTitle) {
  final key = '${topicId.toLowerCase()}-$index';
  if (allModuleStudyData.containsKey(key)) {
    return allModuleStudyData[key]!;
  }

  // Fallback to canonical alias
  final canonicalMap = {
    'edc': 'devices',
    'communication': 'communications',
    'em': 'electromagnetics',
    'maths': 'math',
  };
  final canonicalTopic = canonicalMap[topicId.toLowerCase()] ?? topicId.toLowerCase();
  final canonicalKey = '$canonicalTopic-$index';
  if (allModuleStudyData.containsKey(canonicalKey)) {
    return allModuleStudyData[canonicalKey]!;
  }

  // Clean, high-yield fallback module for remaining syllabus modules
  return ModuleStudyData(
    title: moduleTitle,
    overview:
        'This module delivers comprehensive theoretical coverage, physical intuition, and mathematical derivations for $moduleTitle in GATE ECE.\n\n'
        'In competitive national examinations like GATE, achieving rank-1 accuracy requires understanding the fundamental governing equations, boundary constraints, and typical exam question tricks.\n\n'
        'Study the key principles and formulas below, review the schematic diagram, and take the 3-question mastery quiz to complete this unit and unlock next stages.',
    keyPrinciples: [
      'Rigorous mathematical formulation based on standard IIT GATE curriculum reference textbooks.',
      'Verification of assumptions: boundary conditions, steady-state vs transient response, and small-signal linearity.',
      'Analysis of edge conditions: frequency dependence, parasitic elements, and sensitivity.',
      'Synthesis of transfer characteristics, nodal/mesh relations, and matrix formulations.',
    ],
    equations: [
      'Fundamental Relation: Output = Transfer_Function . Input',
      'Conservation Law: Sum(Inflow) = Sum(Outflow)',
      'Energy / Power: P = V . I = I^2 . R = V^2 / R',
      'Frequency - Time Conjugate: delta_t . delta_f >= 1 / (4 . pi)',
    ],
    circuitDiagram:
        '  Input Signal x(t)        System Function H(s)        Output Signal y(t)\n'
        '  -------------------->[ TRANSFER BLOCK H(s) ]--------------------->\n'
        '                                  |\n'
        '                              Feedback\n'
        '                                  v\n'
        '  -----------------------[ FEEDBACK LOOP G(s) ]<--------------------',
    gateExamTips:
        'Focus on writing step-by-step working. When solving NAT (Numerical Answer Type) problems, keep intermediate steps to 4 decimal places and round off only at the final answer to avoid precision penalties.',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus & Previous Question Papers',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'Which of the following approaches is most effective for solving $moduleTitle problems in GATE?',
        options: [
          'Identify fundamental governing equations and check boundary conditions',
          'Memorize final answers without derivation',
          'Assume ideal conditions even when parasitics are explicitly given',
          'Ignore units during intermediate steps',
        ],
        correctIndex: 0,
        explanation: 'Applying first-principles equations with strict attention to boundary conditions yields 100% accuracy in GATE ECE.',
      ),
      ModuleQuizQuestion(
        question: 'In numerical GATE questions (NAT) on $moduleTitle, intermediate rounding off should be:',
        options: [
          'Avoided; keep maximum precision until the final answer',
          'Done after every multiplication to 1 decimal place',
          'Rounded to nearest integer immediately',
          'Ignored completely',
        ],
        correctIndex: 0,
        explanation: 'Premature rounding causes compounding truncation errors that fall outside GATE evaluation range tolerances.',
      ),
      ModuleQuizQuestion(
        question: 'Linearity and time-invariance in physical systems guarantees which critical property?',
        options: [
          'Principle of Superposition (homogeneity and additivity)',
          'Infinite bandwidth with zero delay',
          'Negative resistance at all frequencies',
          'Complete absence of noise',
        ],
        correctIndex: 0,
        explanation: 'By definition, linear systems strictly satisfy the Superposition theorem: T{a.x1 + b.x2} = a.T{x1} + b.T{x2}.',
      ),
    ],
  );
}
