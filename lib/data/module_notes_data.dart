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
        'Kirchhoff\'s Current Law (KCL) is grounded in the conservation of electric charge: the algebraic sum of all currents entering any electrical node must equal zero (Σ I = 0). Kirchhoff\'s Voltage Law (KVL) is grounded in the conservation of energy: the algebraic sum of electric potential differences around any closed circuit loop is zero (Σ V = 0).\n\n'
        'Mesh Analysis applies KVL around independent planar loops. For a planar network with B branches and N nodes, the number of independent mesh equations required is M = B - N + 1. If a current source lies on the boundary of two meshes, a Supermesh is formed by removing the current source and writing a single combined KVL loop, supplemented by the source constraint equation.\n\n'
        'Nodal Analysis applies KCL at all non-reference nodes. A reference (datum/ground) node is chosen with 0 V potential. If an ideal voltage source is connected between two non-reference nodes with no series resistor, a Supernode is enclosed around the source, applying KCL across its boundary.',
    keyPrinciples: [
      'KCL is valid for lumped circuits at all frequencies where circuit physical dimension << wavelength (d << λ).',
      'KVL states the line integral of electrostatic E-field around a closed contour is zero (∮ E · dl = 0).',
      'Supermesh: Created when an independent/dependent current source is shared between two adjacent meshes.',
      'Supernode: Created when an independent/dependent voltage source is connected between two non-reference nodes.',
      'Tellegen\'s Theorem: In any lumped network, the sum of delivered powers across all branches is identically zero (Σ v_k · i_k = 0), regardless of whether elements are linear or non-linear.',
    ],
    equations: [
      'KCL: Σ I_entering = Σ I_leaving  ⇒  Σ_{k=1}^n I_k = 0',
      'KVL: Σ_{k=1}^m V_k = 0 around any closed directed loop',
      'Mesh Equation: [R_mesh] · [I_mesh] = [V_sources]',
      'Nodal Equation: [G_node] · [V_node] = [I_sources]',
      'Supernode Constraint: V_A - V_B = V_source',
    ],
    circuitDiagram:
        '  ┌─────────[ R1 ]─────────┬─────────[ R2 ]─────────┐\n'
        '  │                        │                        │\n'
        '( + ) Vs               [ R_load ]                 ( ↑ ) Is\n'
        '  │                        │                        │\n'
        '  └────────────────────────┴────────────────────────┘ (Ground)',
    gateExamTips:
        'Always check for dependent sources before applying mesh or nodal formulas. When a dependent source is present, never disable it during resistance calculations! In nodal analysis, choose the node connected to the maximum number of voltage sources as your ground reference to simplify the matrix equations.',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus — Network Analysis',
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
          'Any lumped network, whether linear, non-linear, active, passive, time-variant or invariant',
          'Only purely resistive DC networks',
        ],
        correctIndex: 2,
        explanation: 'Tellegen\'s theorem depends strictly on Kirchhoff\'s laws and topology, making it universally valid for any lumped network.',
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
        '• Vth (Open-Circuit Voltage, Voc): The potential difference across terminals A-B when the external load is disconnected (RL = ∞).\n'
        '• Rth (Thevenin Resistance): The equivalent looking-in resistance measured between terminals A-B with all independent sources turned off (independent voltage sources replaced by short circuits, independent current sources replaced by open circuits).\n\n'
        'When dependent sources are present, Rth CANNOT be found by simple resistor series/parallel reduction. Instead, deactivate all independent sources, apply an external test source (e.g. 1 V or 1 A) across A-B, and compute Rth = V_test / I_test (or compute Rth = Voc / Isc).\n\n'
        'Norton\'s Theorem is the exact source-dual of Thevenin\'s Theorem. The entire network is replaced by an ideal current source IN = Isc in parallel with resistance RN = Rth. The transformation follows Ohm\'s Law: Vth = IN · Rth.',
    keyPrinciples: [
      'Vth = Voc (Terminal voltage when load current IL = 0).',
      'IN = Isc (Current through terminal A-B when short-circuited with a zero-ohm wire).',
      'Rth = RN = Voc / Isc (Valid for all linear networks, even with dependent sources).',
      'Maximum Power Transfer Theorem: A resistive load RL receives maximum power when RL = Rth. Efficiency at max power is exactly 50%.',
      'AC Maximum Power: For complex source impedance Zth = Rth + jXth, maximum power transfer occurs when ZL = Zth* = Rth - jXth (complex conjugate matching).',
    ],
    equations: [
      'Thevenin Load Current: I_L = V_th / (R_th + R_L)',
      'Thevenin Load Voltage: V_L = V_th · R_L / (R_th + R_L)',
      'Norton Load Current: I_L = I_N · [R_th / (R_th + R_L)]',
      'Maximum DC Power: P_max = (V_th)² / (4 · R_th)',
      'AC Conjugate Match: Z_L = R_th - j X_th  ⇒  P_max = |V_th|² / (4 · R_th)',
    ],
    circuitDiagram:
        'Thevenin Equivalent:               Norton Equivalent:\n'
        '    ┌───( + ) Vth ───[ Rth ]─── A     ┌───────┬───────[ RN ]─────── A\n'
        '    │                           │     │       │            │\n'
        '    └────────────────────────── B    ( ↑ ) IN └────────────┴─────── B',
    gateExamTips:
        'GATE frequently presents circuits with dependent sources where Rth comes out negative! A negative Rth indicates that the internal active elements (amplifiers/dependent sources) are supplying net power to the external terminals. Always remember: Pmax = Vth² / (4Rth), NOT Vth² / Rth!',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus — Network Theorems',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'A circuit has open-circuit voltage Voc = 30 V and short-circuit current Isc = 6 A. The maximum power that can be delivered to an adjustable load resistor is:',
        options: ['45 W', '90 W', '180 W', '22.5 W'],
        correctIndex: 0,
        explanation: 'Rth = Voc / Isc = 30 / 6 = 5 Ω. Pmax = Voc² / (4 · Rth) = (30)² / (4 × 5) = 900 / 20 = 45 W.',
      ),
      ModuleQuizQuestion(
        question: 'When determining the Thevenin resistance of a circuit containing dependent sources, you must:',
        options: [
          'Open circuit dependent sources and short circuit independent sources',
          'Short circuit dependent sources and open independent sources',
          'Turn off only independent sources, keep dependent sources active, and apply a test source',
          'Deactivate both independent and dependent sources',
        ],
        correctIndex: 2,
        explanation: 'Dependent sources are controlled by circuit variables and can never be arbitrarily deactivated. Only independent sources are killed.',
      ),
      ModuleQuizQuestion(
        question: 'If source impedance is Zs = 4 + j3 Ω, the load impedance ZL that extracts maximum power from the source is:',
        options: ['4 + j3 Ω', '4 - j3 Ω', '5 Ω purely resistive', '3 - j4 Ω'],
        correctIndex: 1,
        explanation: 'For maximum power transfer in AC circuits, the load impedance must equal the complex conjugate of the source: ZL = Zs* = 4 - j3 Ω.',
      ),
    ],
  ),

  // ==========================================================================
  // 2. SIGNALS & SYSTEMS
  // ==========================================================================
  'signals-0': const ModuleStudyData(
    title: 'Signal Classification, Energy & Power',
    overview:
        'A signal x(t) is a function of time that conveys physical information. Continuous-Time (CT) signals are defined over a continuum of time t ∈ (-∞, ∞), whereas Discrete-Time (DT) signals x[n] are defined only at integer sample instants n ∈ Z.\n\n'
        'Signals are fundamentally categorized into Energy and Power signals:\n'
        '• Energy Signal: Has finite total energy 0 < E < ∞ and zero average power (P = 0). Transient pulses, decaying exponentials, and finite-duration signals are typically energy signals.\n'
        '• Power Signal: Has finite, non-zero average power 0 < P < ∞ and infinite total energy (E = ∞). Periodic waveforms (sinusoids, square waves) and stationary random noise are power signals.\n\n'
        'A signal cannot be simultaneously both an energy signal and a power signal. However, some non-convergent signals (like e^(2t) or t · u(t)) are neither energy nor power signals (both E = ∞ and P = ∞).',
    keyPrinciples: [
      'Energy of CT signal: E = ∫_{-∞}^∞ |x(t)|² dt. Energy of DT sequence: E = Σ_{n=-∞}^∞ |x[n]|².',
      'Average Power of CT signal: P = lim_{T→∞} (1 / 2T) ∫_{-T}^T |x(t)|² dt. For periodic signal: P = (1/T0) ∫_0^{T0} |x(t)|² dt.',
      'Symmetric properties: Any signal can be uniquely split into Even and Odd components: x_e(t) = 0.5[x(t) + x(-t)], x_o(t) = 0.5[x(t) - x(-t)].',
      'Periodicity test in DT: A sinusoid x[n] = cos(ω0 · n) is periodic IF AND ONLY IF (ω0 / 2π) is a rational number (ratio of two integers m/N).',
      'Unit impulse properties: Sifting property ∫_{-∞}^∞ x(t) · δ(t - t0) dt = x(t0); Scaling property δ(a · t) = (1 / |a|) · δ(t).',
    ],
    equations: [
      'Signal Energy: E = ∫_{-∞}^{∞} |x(t)|² dt',
      'Signal Power: P = lim_{T → ∞} (1 / 2T) ∫_{-T}^{T} |x(t)|² dt',
      'Even Component: x_e(t) = 0.5 · [x(t) + x(-t)]',
      'Odd Component: x_o(t) = 0.5 · [x(t) - x(-t)]',
      'Impulse Sifting: ∫_{-∞}^{∞} x(t) · δ(t - t_0) dt = x(t_0)',
      'DT Periodicity: ω_0 / (2π) = m / N  ⇒  Fundamental Period N = 2π · m / ω_0',
    ],
    circuitDiagram:
        '  x(t) [Signal] ──┬──> [ Even Filter: 0.5(x(t) + x(-t)) ] ──> x_even(t)\n'
        '                  │\n'
        '                  └──> [ Odd Filter:  0.5(x(t) - x(-t)) ] ──> x_odd(t)',
    gateExamTips:
        'A common GATE trap is asking whether x[n] = cos(3n) is periodic. In continuous time cos(3t) is periodic, but in discrete time 3 / (2π) is irrational, so cos(3n) is NOT periodic! Always check for rationality in discrete time.',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus — Signals & Systems',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'Which of the following discrete-time sequences is periodic?',
        options: ['cos(0.5 · n)', 'sin(0.2π · n)', 'e^(j 2 n)', 'cos(n)'],
        correctIndex: 1,
        explanation: 'For sin(0.2π n), ω0 = 0.2π. The ratio ω0 / 2π = 0.2π / 2π = 1/10 (rational), so fundamental period N = 10 samples.',
      ),
      ModuleQuizQuestion(
        question: 'The total energy of the signal x(t) = e^(-3t) · u(t) is:',
        options: ['1/3 J', '1/6 J', '1/9 J', 'Infinite'],
        correctIndex: 1,
        explanation: 'E = ∫₀^∞ |e^(-3t)|² dt = ∫₀^∞ e^(-6t) dt = [-e^(-6t) / 6]₀^∞ = 1/6 J.',
      ),
      ModuleQuizQuestion(
        question: 'The value of the integral ∫_{-∞}^∞ (t³ + 4) · δ(2t - 4) dt is:',
        options: ['12', '6', '24', '4'],
        correctIndex: 1,
        explanation: 'Using δ(at - b) = (1/|a|) · δ(t - b/a): δ(2t - 4) = 0.5 · δ(t - 2). Integral = 0.5 × (2³ + 4) = 0.5 × 12 = 6.',
      ),
    ],
  ),

  'signals-1': const ModuleStudyData(
    title: 'Sampling Theorem & Aliasing',
    overview:
        'The Nyquist-Shannon Sampling Theorem establishes the fundamental mathematical bridge between continuous-time analog signals and discrete-time digital processing. A continuous-time bandlimited signal x(t) with highest spectral frequency component fmax can be uniquely reconstructed without distortion from its instantaneous samples x[n] = x(n · Ts) if and only if the sampling rate fs satisfies fs ≥ 2 · fmax.\n\n'
        '• Nyquist Rate: The minimum theoretical sampling frequency fs_nyquist = 2 · fmax.\n'
        '• Nyquist Interval: The maximum allowable spacing between consecutive samples Ts_max = 1 / (2 · fmax).\n\n'
        'If the signal is sampled below the Nyquist rate (fs < 2 · fmax), Aliasing occurs: high-frequency spectral components fold into the baseband frequency region, creating unrecoverable overlapping distortion. An Anti-Aliasing Low-Pass Filter (LPF) with cutoff frequency fc = fmax must always precede the sampler in physical systems.',
    keyPrinciples: [
      'Nyquist Sampling Criterion: fs ≥ 2 · fmax.',
      'Sampled Spectrum: Xs(f) = fs · Σ_{k=-∞}^∞ X(f - k · fs). Spectral replicas repeat at integer multiples of fs.',
      'Reconstruction: Ideal reconstruction requires passing sampled impulses through an ideal low-pass filter with bandwidth B = fs/2 and impulse response h(t) = sinc(2Bt).',
      'Product Signal Rule: If y(t) = x1(t) · x2(t), the bandwidth is additive: W_y = W1 + W2. Hence Nyquist rate is 2 · (W1 + W2).',
      'Convolution Signal Rule: If y(t) = x1(t) * x2(t), the bandwidth is limited by the narrower filter: W_y = min(W1, W2). Hence Nyquist rate is 2 · min(W1, W2).',
    ],
    equations: [
      'Nyquist Rate: f_s ≥ 2 · f_max',
      'Nyquist Interval: T_s ≤ 1 / (2 · f_max)',
      'Sampled Spectrum: X_s(ω) = (1 / T_s) · Σ_{k=-∞}^{∞} X(ω - k · ω_s)',
      'Whittaker-Shannon Interpolation: x(t) = Σ_{n=-∞}^{∞} x(n T_s) · sinc((t - n T_s) / T_s)',
      'Multiplication Bandwidth: BW[x_1(t) · x_2(t)] = f_{max1} + f_{max2}',
    ],
    circuitDiagram:
        '  x(t) [Analog] ──> [ Anti-Aliasing LPF: fc=fmax ] ──> ( × ) [Sampler: fs ≥ 2fmax] ──> x[n]\n'
        '                                                         ↑\n'
        '                                                   p(t)=Σ δ(t - nTs)',
    gateExamTips:
        'When dealing with sinc²(200πt), remember that sinc²(at) is the square of sinc(at). In frequency domain, squaring is equivalent to convolution, so the bandwidth DOUBLES! If sinc(200πt) has bandwidth 100 Hz, sinc²(200πt) has bandwidth 200 Hz, making the Nyquist rate 400 Hz!',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus — Sampling Theorem',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'The Nyquist sampling rate for the signal x(t) = 5 cos(1000πt) + 12 sin(3000πt) is:',
        options: ['1500 Hz', '3000 Hz', '6000 Hz', '1000 Hz'],
        correctIndex: 1,
        explanation: 'Frequencies are f1 = 1000π / 2π = 500 Hz, f2 = 3000π / 2π = 1500 Hz. The maximum frequency fmax = 1500 Hz. Nyquist rate = 2 × 1500 Hz = 3000 Hz.',
      ),
      ModuleQuizQuestion(
        question: 'If a signal with maximum frequency 4 kHz is sampled at 6 kHz (below Nyquist rate), a 3.5 kHz component will alias to:',
        options: ['2.5 kHz', '0.5 kHz', '1.0 kHz', '3.0 kHz'],
        correctIndex: 0,
        explanation: 'The aliased frequency f_alias = |fs - f_input| = |6 kHz - 3.5 kHz| = 2.5 kHz.',
      ),
      ModuleQuizQuestion(
        question: 'The Nyquist rate for the signal x(t) = sinc²(400t) is:',
        options: ['400 / π Hz', '800 / π Hz', '200 / π Hz', '400 Hz'],
        correctIndex: 1,
        explanation: 'sinc(400t) has fmax = 400 / 2π = 200/π Hz. Squaring doubles the bandwidth to 400/π Hz. Nyquist rate = 2 × (400/π) = 800/π Hz.',
      ),
    ],
  ),

  // ==========================================================================
  // 3. ELECTRONIC DEVICES (EDC)
  // ==========================================================================
  'devices-0': const ModuleStudyData(
    title: 'Semiconductor Physics & Carrier Transport',
    overview:
        'Intrinsic semiconductors (pure Silicon, Germanium) have equal electron and hole concentrations: n = p = ni. At room temperature (300 K), the intrinsic concentration for Silicon is ni ≈ 1.5 × 10¹⁰ cm⁻³, with a bandgap energy Eg ≈ 1.12 eV.\n\n'
        'Extrinsic semiconductors are created via doping:\n'
        '• N-type: Doped with pentavalent donor atoms (P, As, Sb). Electrons are majority carriers (n ≈ Nd), holes are minority carriers.\n'
        '• P-type: Doped with trivalent acceptor atoms (B, Ga, In). Holes are majority carriers (p ≈ Na), electrons are minority carriers.\n'
        'The Mass Action Law states that in thermal equilibrium, the product of electron and hole concentrations is constant regardless of doping level: n · p = ni².\n\n'
        'Current transport occurs via two independent physical mechanisms:\n'
        '1. Drift Current: Movement of charged carriers driven by an applied electric field (J_drift = σ · E = q(n·μn + p·μp)·E).\n'
        '2. Diffusion Current: Movement of carriers driven by a spatial concentration gradient (J_diff = q·Dn·(dn/dx) - q·Dp·(dp/dx)). The Einstein Relation connects mobility and diffusivity: Dn / μn = Dp / μp = VT = kT/q (≈ 26 mV at 300 K).',
    keyPrinciples: [
      'Mass Action Law: n · p = ni² (Holds under thermal equilibrium for both non-degenerate N-type and P-type semiconductors).',
      'Einstein Relation: D / μ = VT = kT / q (VT ≈ 25.9 mV at 300 K).',
      'Fermi-Dirac Distribution: f(E) = 1 / [1 + exp((E - EF) / kT)]. Probability of state at Fermi level EF being occupied is exactly 1/2.',
      'Conductivity: σ = q · (n · μn + p · μp). In N-type: σ ≈ q · Nd · μn. Resistivity ρ = 1 / σ.',
      'Direct vs Indirect Bandgap: GaAs is direct bandgap (efficient optical emission for LEDs). Silicon is indirect bandgap (recombination requires phonon momentum, poor optical emission).',
    ],
    equations: [
      'Mass Action Law: n · p = n_i²',
      'Total Current Density: J = J_drift + J_diff',
      'Drift Current: J_drift = q · (n · μ_n + p · μ_p) · E',
      'Diffusion Current: J_diff = q · D_n · (dn/dx) - q · D_p · (dp/dx)',
      'Einstein Relation: D_n / μ_n = D_p / μ_p = V_T = k · T / q',
    ],
    circuitDiagram:
        'Conduction Band (Ec) ───────────────────────────\n'
        '                    - - - - Donor Level (Ed)\n'
        'Fermi Level (Ef)     - - - - - - - - - - - - - -\n'
        'Valence Band (Ev)   ───────────────────────────',
    gateExamTips:
        'At high electric fields, carrier velocity saturates (vsat ≈ 10⁷ cm/s in Silicon) due to optical phonon scattering. Once velocity saturates, drift current no longer increases linearly with electric field! This effect is critical in short-channel MOSFET analysis in GATE.',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus — Semiconductor Physics',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'In a semiconductor in thermal equilibrium, the product of electron and hole concentrations (n · p) depends primarily on:',
        options: ['Donor doping Nd', 'Acceptor doping Na', 'Temperature', 'Applied electric field'],
        correctIndex: 2,
        explanation: 'By the mass action law n · p = ni²(T). The intrinsic concentration ni depends exponentially on temperature and bandgap, and is independent of doping.',
      ),
      ModuleQuizQuestion(
        question: 'If the electron mobility in silicon is 1300 cm²/(V·s) at 300 K (VT = 26 mV), the electron diffusion coefficient Dn is:',
        options: ['33.8 cm²/s', '50.0 cm²/s', '13.0 cm²/s', '26.0 cm²/s'],
        correctIndex: 0,
        explanation: 'By Einstein relation Dn = μn · VT = 1300 cm²/(V·s) × 0.026 V = 33.8 cm²/s.',
      ),
      ModuleQuizQuestion(
        question: 'Silicon is an indirect bandgap semiconductor. This property makes it fundamentally unsuitable for:',
        options: ['High-speed BJTs', 'CMOS microprocessors', 'Efficient light emitting diodes (LEDs)', 'Photodetectors'],
        correctIndex: 2,
        explanation: 'In indirect bandgap materials, radiative recombination requires simultaneous phonon exchange, resulting in very poor light emission efficiency.',
      ),
    ],
  ),

  // ==========================================================================
  // 4. CONTROL SYSTEMS
  // ==========================================================================
  'control-0': const ModuleStudyData(
    title: 'Transfer Functions & Transient Specifications',
    overview:
        'A linear time-invariant (LTI) continuous system is modeled in the frequency domain by its Transfer Function G(s) = Y(s) / U(s), defined as the ratio of Laplace transform of output to input assuming all initial conditions are zero.\n\n'
        'Standard second-order prototype transfer function:\n'
        'T(s) = ωn² / (s² + 2ζωn·s + ωn²)\n\n'
        'Where:\n'
        '• ωn = Natural undamped frequency (rad/s)\n'
        '• ζ = Damping ratio (dimensionless)\n\n'
        'System behavior is governed entirely by damping ratio ζ:\n'
        '1. ζ = 0 (Undamped): Poles on imaginary axis s = ±jωn. Sustained constant oscillation.\n'
        '2. 0 < ζ < 1 (Underdamped): Complex conjugate poles s = -ζωn ± jωd, where damped frequency ωd = ωn · √(1 - ζ²). Exhibits transient overshoot.\n'
        '3. ζ = 1 (Critically Damped): Two equal real poles s = -ωn. Fastest non-oscillatory return to equilibrium.\n'
        '4. ζ > 1 (Overdamped): Two distinct real poles on negative real axis. Sluggish non-oscillatory response.',
    keyPrinciples: [
      'Peak Overshoot Mp = exp(-πζ / √(1 - ζ²)) × 100%. Depends solely on damping ratio ζ!',
      'Peak Time tp = π / ωd = π / [ωn · √(1 - ζ²)].',
      'Rise Time tr = (π - β) / ωd, where β = arctan(√(1 - ζ²) / ζ).',
      'Settling Time (2% criterion): ts ≈ 4 / (ζ · ωn) = 4 / σ.',
      'Settling Time (5% criterion): ts ≈ 3 / (ζ · ωn) = 3 / σ.',
    ],
    equations: [
      'Standard 2nd-Order T(s): T(s) = ω_n² / (s² + 2ζ ω_n s + ω_n²)',
      'Damped Frequency: ω_d = ω_n · √(1 - ζ²)',
      'Peak Overshoot: M_p = e^{-π ζ / √(1 - ζ²)} × 100%',
      'Peak Time: t_p = π / ω_d',
      'Settling Time (2% tolerance): t_s = 4 / (ζ · ω_n)',
    ],
    circuitDiagram:
        '  R(s) [Input] ──> ( + ) ──[ Error E(s) ]──> [ Controller G(s) ] ──┬──> Y(s) [Output]\n'
        '                    - ↑                                             │\n'
        '                      └──────────────[ Feedback H(s) ]──────────────┘',
    gateExamTips:
        'Notice that peak overshoot Mp depends ONLY on damping ratio ζ! If an amplifier doubles natural frequency ωn while keeping ζ constant, the peak overshoot Mp does not change at all, but the system speeds up (settling time ts and peak time tp are cut in half).',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus — Control Systems',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'A second-order system has closed-loop poles at s = -3 ± j4. The natural frequency ωn and damping ratio ζ are:',
        options: ['ωn = 5 rad/s, ζ = 0.6', 'ωn = 4 rad/s, ζ = 0.75', 'ωn = 5 rad/s, ζ = 0.8', 'ωn = 3 rad/s, ζ = 0.6'],
        correctIndex: 0,
        explanation: 'Poles are -ζωn ± jωd. Here ζωn = 3 and ωd = 4. Natural frequency ωn = √(3² + 4²) = 5 rad/s. Damping ratio ζ = 3 / 5 = 0.6.',
      ),
      ModuleQuizQuestion(
        question: 'For a prototype second-order underdamped system, if damping ratio ζ increases while ωn remains constant:',
        options: [
          'Peak overshoot increases and settling time increases',
          'Peak overshoot decreases and settling time decreases',
          'Peak overshoot increases and settling time decreases',
          'Both overshoot and settling time remain unchanged',
        ],
        correctIndex: 1,
        explanation: 'As ζ increases toward 1, overshoot Mp = exp(-πζ/√(1-ζ²)) decreases, and settling time ts = 4/(ζωn) decreases (faster settling).',
      ),
      ModuleQuizQuestion(
        question: 'For the transfer function T(s) = 16 / (s² + 8s + 16), the system is:',
        options: ['Underdamped', 'Critically damped', 'Overdamped', 'Undamped'],
        correctIndex: 1,
        explanation: 'ωn² = 16 → ωn = 4. 2ζωn = 8 → 2ζ(4) = 8 → ζ = 1.0 (Critically damped).',
      ),
    ],
  ),
};

/// Fallback generator for modules without custom deep-dive text
ModuleStudyData getModuleStudyData(String topicId, int index, String moduleTitle) {
  final key = '${topicId.toLowerCase()}-$index';
  if (allModuleStudyData.containsKey(key)) {
    return allModuleStudyData[key]!;
  }

  // Create a structured, deep-dive 10-minute study module for any general topic
  return ModuleStudyData(
    title: moduleTitle,
    overview:
        'This module provides comprehensive theoretical coverage and analytical derivations for $moduleTitle in GATE ECE.\n\n'
        'In competitive examinations like GATE, mastering $moduleTitle requires a dual approach: understanding the first-principles physics and circuit mechanics, accompanied by rigorous step-by-step mathematical problem solving.\n\n'
        'Review the key principles, study the governing equations, and take the 3-question mastery quiz to complete this module and unlock subsequent learning stages.',
    keyPrinciples: [
      'Fundamental formulation based on standard GATE curriculum textbooks (Sedra & Smith, Oppenheim, Hayt & Kemmerly, Ogata).',
      'Verification of assumptions: boundary conditions, small-signal approximations, and linear region constraints.',
      'Analysis of edge cases: high-frequency behavior, parasitic effects, and non-ideal component parameters.',
      'Synthesis of transfer characteristics, nodal/mesh equations, and state-space formulations.',
    ],
    equations: [
      'Governing Relation: y(t) = f(x(t), θ)',
      'Characteristic Equation: P(s) = 0',
      'Efficiency Metric: η = P_out / P_in',
      'Stability Boundary: Re{s_poles} < 0',
    ],
    circuitDiagram:
        '  [ Input Stage ] ───> [ Core Processing Element: $moduleTitle ] ───> [ Output Stage ]\n'
        '         ▲                                                                      │\n'
        '         └──────────────────────────[ Feedback Network ]────────────────────────┘',
    gateExamTips:
        'GATE frequently questions the boundary conditions and domain of validity for this topic. Pay close attention to numerical tolerances, units conversion (kHz to rad/s, mV to V), and sign conventions.',
    officialResourceUrl: 'https://gate2024.iisc.ac.in/syllabus/',
    officialResourceName: 'Official GATE ECE Syllabus & Reference Guidelines',
    quizQuestions: [
      ModuleQuizQuestion(
        question: 'In the analysis of $moduleTitle, which fundamental assumption must be verified first?',
        options: [
          'Linearity and operating region constraints',
          'High temperature breakdown',
          'Digital saturation state',
          'Zero source impedance',
        ],
        correctIndex: 0,
        explanation: 'Linearity and valid operating regions must always be confirmed before applying small-signal or linear circuit theorems.',
      ),
      ModuleQuizQuestion(
        question: 'What is the primary factor determining stability in linear systems representing $moduleTitle?',
        options: [
          'Location of poles in the left-half of the complex s-plane',
          'Location of zeros in the right-half plane',
          'The amplitude of the input voltage',
          'The length of the connecting wires',
        ],
        correctIndex: 0,
        explanation: 'A continuous linear system is BIBO stable if and only if all system poles lie strictly in the open left-half of the s-plane (Re{s} < 0).',
      ),
      ModuleQuizQuestion(
        question: 'When solving numerical problems in this section for the GATE examination, you should:',
        options: [
          'Use correct SI units, write step-by-step substitutions, and avoid rounding until the final answer',
          'Round off at every intermediate calculation stage',
          'Ignore negative signs in phase angles',
          'Assume ideal components without checking given non-ideal parameters',
        ],
        correctIndex: 0,
        explanation: 'In GATE NAT questions, intermediate rounding causes truncation errors outside the official answer range. Always preserve precision until the final step.',
      ),
    ],
  );
}