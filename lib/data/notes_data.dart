class SubjectNote {
  final String id;
  final String topicId;
  final String title;
  final String summary;
  final List<NoteSection> sections;

  const SubjectNote({
    required this.id,
    required this.topicId,
    required this.title,
    required this.summary,
    required this.sections,
  });
}

class NoteSection {
  final String heading;
  final String content;
  final String? formula;
  final String? trapWarning;

  const NoteSection({
    required this.heading,
    required this.content,
    this.formula,
    this.trapWarning,
  });
}

final List<SubjectNote> allSubjectNotes = [
  // ── 1. NETWORKS & CIRCUITS ────────────────────────────────────────────────
  const SubjectNote(
    id: 'note_networks',
    topicId: 'networks',
    title: 'Networks & Circuit Theory Master Notes',
    summary: 'Comprehensive revision of Kirchhoff laws, circuit theorems, transients, two-port networks, and resonance.',
    sections: [
      NoteSection(
        heading: '1. Kirchhoff\'s Laws & Graph Theory',
        content: '• KVL is based on Conservation of Energy (Sum of voltages around any closed loop is zero).\n'
            '• KCL is based on Conservation of Charge (Sum of currents entering a node equals sum leaving).\n'
            '• For a connected planar graph with N nodes and B branches:\n'
            '  - Number of independent KCL equations = N - 1\n'
            '  - Number of independent KVL (mesh) equations = B - N + 1',
        trapWarning: 'In circuits with dependent sources, NEVER deactivate them when calculating Thevenin resistance (Rth). Apply a test source (1V or 1A) at the terminals!',
      ),
      NoteSection(
        heading: '2. Thevenin\'s & Norton\'s Theorems',
        content: '• Any linear bilateral network can be replaced by:\n'
            '  - Thevenin: Open-circuit voltage Vth in series with Rth.\n'
            '  - Norton: Short-circuit current Isc in parallel with Rth.\n'
            '• Relationship: Vth = Isc × Rth.\n'
            '• Maximum Power Transfer Theorem: Power transferred to load RL is maximized when RL = Rth (for resistive circuits), where Pmax = Vth² / (4 × Rth). For complex load: ZL = Zth* (complex conjugate).',
        formula: r'P_{max} = \frac{V_{th}^2}{4R_{th}} \quad (\text{when } R_L = R_{th})',
      ),
      NoteSection(
        heading: '3. First & Second Order Transients',
        content: '• Inductor opposes sudden change of current: iL(0+) = iL(0-). Acts as open circuit in DC steady state.\n'
            '• Capacitor opposes sudden change of voltage: vC(0+) = vC(0-). Acts as short circuit at t=0+ if uncharged, and open circuit in DC steady state.\n'
            '• Standard step response formula: x(t) = x(∞) + [x(0+) - x(∞)] × e^(-t/τ)',
        formula: r'x(t) = x(\infty) + [x(0^+) - x(\infty)]e^{-t/\tau}, \quad \tau_{RC}=RC, \;\tau_{RL}=L/R',
      ),
      NoteSection(
        heading: '4. Resonance in RLC Circuits',
        content: '• Series RLC: At resonance (ω0 = 1/√(LC)), impedance is minimum (Z = R), current is maximum, power factor is unity.\n'
            '• Quality Factor: Q = (ω0 L)/R = (1/R)√(L/C) = f0 / Bandwidth.\n'
            '• Half power frequencies: f1 = f0 - BW/2, f2 = f0 + BW/2.',
        formula: r'f_0 = \frac{1}{2\pi\sqrt{LC}}, \quad Q = \frac{1}{R}\sqrt{\frac{L}{C}}, \quad BW = \frac{f_0}{Q}',
      ),
    ],
  ),

  // ── 2. SIGNALS & SYSTEMS ──────────────────────────────────────────────────
  const SubjectNote(
    id: 'note_signals',
    topicId: 'signals',
    title: 'Signals & Systems Master Notes',
    summary: 'Classification of signals, LTI systems, Continuous & Discrete Fourier transform, Laplace, and Z-transform.',
    sections: [
      NoteSection(
        heading: '1. Signal Classification & LTI Properties',
        content: '• Energy Signal: Finite energy, zero average power. (e.g. pulses, decaying exponentials).\n'
            '• Power Signal: Infinite energy, finite non-zero average power. (e.g. periodic signals like sine, square waves).\n'
            '• Linear Time-Invariant (LTI) system output is completely determined by convolution: y(t) = x(t) * h(t).\n'
            '• Stability condition: Absolute integrability/summability of impulse response ∫|h(t)|dt < ∞ (BIBO stable).',
      ),
      NoteSection(
        heading: '2. Nyquist Sampling Theorem',
        content: '• To avoid aliasing (spectral overlap), a bandlimited signal with maximum frequency fm must be sampled at rate fs ≥ 2fm.\n'
            '• Nyquist Rate = 2fm.\n'
            '• Nyquist Interval = 1 / (2fm).\n'
            '• If sampled at fs < 2fm, aliased frequency = |fs - fin|.',
        formula: r'f_s \geq 2f_{max}, \quad T_s \leq \frac{1}{2f_{max}}',
        trapWarning: 'When multiplying two signals x1(t) and x2(t), the maximum frequency of the product is (fm1 + fm2). Thus Nyquist rate = 2(fm1 + fm2)!',
      ),
      NoteSection(
        heading: '3. Laplace & Z-Transform ROC Rules',
        content: '• Region of Convergence (ROC) never contains any poles.\n'
            '• For right-sided (causal) signals, ROC is to the right of the rightmost pole in s-plane (or outside outermost pole circle in z-plane).\n'
            '• For left-sided (anti-causal) signals, ROC is to the left of the leftmost pole (or inside innermost circle).\n'
            '• An LTI system is both Causal and Stable if and only if all poles lie strictly in the left half of the s-plane (or strictly inside unit circle |z| < 1 in z-plane).',
      ),
    ],
  ),

  // ── 3. ELECTRONIC DEVICES (EDC) ──────────────────────────────────────────
  const SubjectNote(
    id: 'note_devices',
    topicId: 'devices',
    title: 'Electronic Devices (EDC) Master Notes',
    summary: 'Semiconductor physics, carrier transport, P-N junction diodes, BJT, MOS capacitors, and MOSFETs.',
    sections: [
      NoteSection(
        heading: '1. Carrier Transport & Fermi Level',
        content: '• Mass Action Law in thermal equilibrium: n × p = ni² (valid for both intrinsic and extrinsic).\n'
            '• Einstein Relation: D/μ = VT = kT/q ≈ 26 mV at 300K.\n'
            '• Total current density: J = J_drift + J_diffusion = (q n μn E + q p μp E) + (q Dn dn/dx - q Dp dp/dx).',
      ),
      NoteSection(
        heading: '2. P-N Junction & Capacitances',
        content: '• Built-in potential: V0 = VT × ln(NA × ND / ni²).\n'
            '• Depletion width W ∝ √(V0 + VR). Most depletion region extends into the LIGHTLY doped side.\n'
            '• Junction (Depletion) Capacitance Cj = εA / W ∝ 1/√(VR) dominates in REVERSE bias.\n'
            '• Diffusion Capacitance Cd = (τ × ID) / (η VT) dominates in FORWARD bias.',
        formula: r'V_0 = \frac{kT}{q}\ln\left(\frac{N_A N_D}{n_i^2}\right), \quad W = \sqrt{\frac{2\epsilon(V_0 + V_R)}{q}\left(\frac{1}{N_A}+\frac{1}{N_D}\right)}',
      ),
      NoteSection(
        heading: '3. MOSFET Operation & Current Equations',
        content: '• Cutoff: VGS < Vth → ID = 0.\n'
            '• Triode (Linear): VGS > Vth and VDS < (VGS - Vth) → ID = μn Cox (W/L) [(VGS - Vth)VDS - VDS²/2].\n'
            '• Saturation (Pinch-off): VGS > Vth and VDS ≥ (VGS - Vth) → ID = ½ μn Cox (W/L) (VGS - Vth)² [1 + λVDS].',
        formula: r'I_D = \frac{1}{2}\mu_n C_{ox}\frac{W}{L}(V_{GS}-V_{th})^2 \quad (\text{Saturation})',
        trapWarning: 'In MOSFET questions, always verify if the device is in Saturation before applying the square law formula!',
      ),
    ],
  ),

  // ── 4. ANALOG CIRCUITS ───────────────────────────────────────────────────
  const SubjectNote(
    id: 'note_analog',
    topicId: 'analog',
    title: 'Analog Circuits Master Notes',
    summary: 'Op-amp ideal characteristics, inverting/non-inverting amps, BJT small-signal models, active filters, and feedback.',
    sections: [
      NoteSection(
        heading: '1. Ideal Op-Amp & Virtual Ground',
        content: '• Ideal Op-Amp properties: Rin = ∞, Rout = 0, Open Loop Gain A = ∞, Bandwidth = ∞, CMRR = ∞, Slew Rate = ∞.\n'
            '• Virtual Ground Concept: When negative feedback is present and the op-amp is not saturated, V+ ≈ V-.\n'
            '• Inverting Gain: Av = -Rf / Rin.\n'
            '• Non-Inverting Gain: Av = 1 + (Rf / R1).',
      ),
      NoteSection(
        heading: '2. BJT Small Signal Parameters',
        content: '• Transconductance: gm = IC / VT = IC / 26mV.\n'
            '• Base-emitter dynamic resistance: rπ = β / gm = VT / IB.\n'
            '• Emitter resistance: re = VT / IE = α / gm ≈ 1 / gm.\n'
            '• Common Emitter Voltage Gain without RE: Av = -gm × (RC || RL).',
        formula: r'g_m = \frac{I_C}{V_T}, \quad r_\pi = \frac{\beta}{g_m}, \quad A_v \approx -g_m R_C',
      ),
    ],
  ),

  // ── 5. DIGITAL CIRCUITS ──────────────────────────────────────────────────
  const SubjectNote(
    id: 'note_digital',
    topicId: 'digital',
    title: 'Digital Circuits Master Notes',
    summary: 'Boolean minimization, Combinational logic, Sequential circuits, Flip-flops, Counters, and ADC/DAC.',
    sections: [
      NoteSection(
        heading: '1. Boolean Algebra & K-Maps',
        content: '• De Morgan\'s: complement(A + B) = Ā · B̄; complement(A · B) = Ā + B̄.\n'
            '• Universal Gates: NAND and NOR. Any boolean function can be realized using only NAND or only NOR gates.\n'
            '• XOR Gate: A ⊕ B = A B̄ + Ā B. Odd parity generator. Complement of XOR is XNOR (A ⊙ B).',
      ),
      NoteSection(
        heading: '2. Flip-Flops & Setup/Hold Time',
        content: '• Characteristic equations:\n'
            '  - D Flip-Flop: Q+ = D\n'
            '  - T Flip-Flop: Q+ = T ⊕ Q\n'
            '  - JK Flip-Flop: Q+ = J Q̄ + K̄ Q\n'
            '• Setup time (ts): Minimum time input must be stable BEFORE clock edge.\n'
            '• Hold time (th): Minimum time input must remain stable AFTER clock edge.\n'
            '• Maximum clock frequency: Tclk ≥ t_cq + t_comb + t_setup → fmax = 1 / Tclk.',
        formula: r'T_{clk\_min} = t_{cq} + t_{comb} + t_{setup}, \quad f_{max} = \frac{1}{T_{clk\_min}}',
      ),
    ],
  ),

  // ── 6. CONTROL SYSTEMS ───────────────────────────────────────────────────
  const SubjectNote(
    id: 'note_control',
    topicId: 'control',
    title: 'Control Systems Master Notes',
    summary: 'Time-domain analysis, Routh-Hurwitz stability, Root Locus, Bode Plots, Nyquist, and State Space.',
    sections: [
      NoteSection(
        heading: '1. Second-Order Time Response Specifications',
        content: '• Characteristic equation: s² + 2ζωn s + ωn² = 0.\n'
            '• Rise time (tr): tr = (π - β) / ωd where β = atan(√(1-ζ²)/ζ), ωd = ωn√(1-ζ²).\n'
            '• Peak time (tp): tp = π / ωd.\n'
            '• Max Peak Overshoot (%Mp): %Mp = e^(-πζ / √(1-ζ²)) × 100%.\n'
            '• Settling time (2% tolerance): ts ≈ 4 / (ζωn). (For 5%: ts ≈ 3 / (ζωn)).',
        formula: r'\%M_p = e^{-\frac{\pi\zeta}{\sqrt{1-\zeta^2}}} \times 100\%, \quad t_s(2\%) = \frac{4}{\zeta\omega_n}',
      ),
      NoteSection(
        heading: '2. Frequency Domain Stability (Bode & Nyquist)',
        content: '• Gain Crossover Frequency (ωgc): Frequency where magnitude |G(jω)H(jω)| = 1 (0 dB).\n'
            '• Phase Crossover Frequency (ωpc): Frequency where phase ∠G(jω)H(jω) = -180°.\n'
            '• Phase Margin (PM) = 180° + ∠G(jωgc)H(jωgc).\n'
            '• Gain Margin (GM) = -20 log10 |G(jωpc)H(jωpc)| dB.\n'
            '• System is STABLE if ωgc < ωpc (i.e. both PM > 0 and GM > 0 dB).',
      ),
    ],
  ),

  // ── 7. COMMUNICATIONS ────────────────────────────────────────────────────
  const SubjectNote(
    id: 'note_comms',
    topicId: 'communications',
    title: 'Communications Master Notes',
    summary: 'Analog modulation (AM, FM), Digital baseband & bandpass (PCM, ASK, PSK, QAM), and Information Theory.',
    sections: [
      NoteSection(
        heading: '1. Analog Modulation Comparisons',
        content: '• Standard AM: Bandwidth = 2fm. Total power PT = Pc(1 + μ²/2). Max efficiency at μ=1 is 33.3%.\n'
            '• DSB-SC: Bandwidth = 2fm. 100% power efficiency (carrier suppressed). Requires synchronous detection.\n'
            '• SSB-SC: Bandwidth = fm (minimum bandwidth). Generated using Hartley or Weaver method.\n'
            '• FM: Carson\'s bandwidth BW = 2(Δf + fm) = 2fm(1 + β), where β = Δf / fm.',
      ),
      NoteSection(
        heading: '2. PCM & Quantization Noise',
        content: '• For an n-bit PCM with step size Δ = 2Vp / 2ⁿ:\n'
            '• Quantization noise power: Nq = Δ² / 12.\n'
            '• Peak Signal-to-Quantization Noise Ratio: (SNR)dB = (6.02 n + 1.76) dB for a full-scale sinusoid.\n'
            '• Each additional bit increases SNR by approximately 6 dB.',
        formula: r'(\text{SNR})_{dB} = 6.02 n + 1.76 \;\text{dB}, \quad \text{Bit Rate } R_b = n \cdot f_s',
      ),
    ],
  ),

  // ── 8. ELECTROMAGNETICS (EMT) ────────────────────────────────────────────
  const SubjectNote(
    id: 'note_emt',
    topicId: 'electromagnetics',
    title: 'Electromagnetics (EMT) Master Notes',
    summary: 'Maxwell\'s equations, EM plane wave propagation, Transmission lines, Smith chart, and Waveguides.',
    sections: [
      NoteSection(
        heading: '1. Maxwell\'s Equations in Differential Form',
        content: '1. Gauss\'s Law: ∇ · D = ρv (Electric charge creates electric displacement).\n'
            '2. Gauss\'s Magnetism: ∇ · B = 0 (No magnetic monopoles).\n'
            '3. Faraday\'s Law: ∇ × E = -∂B/∂t (Time-varying B creates circulatory E).\n'
            '4. Ampere-Maxwell Law: ∇ × H = J + ∂D/∂t (Current + Displacement current creates B).',
      ),
      NoteSection(
        heading: '2. Transmission Lines & Impedance',
        content: '• Characteristic Impedance: Z0 = √((R + jωL)/(G + jωC)) ≈ √(L/C) for lossless lines.\n'
            '• Voltage Reflection Coefficient: Γ = (ZL - Z0) / (ZL + Z0).\n'
            '• Voltage Standing Wave Ratio: VSWR = (1 + |Γ|) / (1 - |Γ|), with 1 ≤ VSWR < ∞.\n'
            '• Quarter-wave transformer matching: Zin = Z0² / ZL (when line length l = λ/4).',
        formula: r'\Gamma = \frac{Z_L - Z_0}{Z_L + Z_0}, \quad VSWR = \frac{1 + |\Gamma|}{1 - |\Gamma|}, \quad Z_{in}(\lambda/4) = \frac{Z_0^2}{Z_L}',
      ),
    ],
  ),

  // ── 9. ENGINEERING MATHEMATICS ───────────────────────────────────────────
  const SubjectNote(
    id: 'note_math',
    topicId: 'math',
    title: 'Engineering Mathematics Master Notes',
    summary: 'Linear algebra, calculus, vector analysis, complex variables, and probability & statistics.',
    sections: [
      NoteSection(
        heading: '1. Linear Algebra & Eigenvalues',
        content: '• Sum of eigenvalues = Trace of matrix (sum of diagonal elements).\n'
            '• Product of eigenvalues = Determinant of matrix det(A).\n'
            '• Eigenvalues of a real symmetric matrix are always REAL.\n'
            '• Cayley-Hamilton Theorem: Every square matrix satisfies its own characteristic equation: P(A) = 0.',
      ),
      NoteSection(
        heading: '2. Calculus & Complex Residue Theorem',
        content: '• Cauchy Residue Theorem: ∫_C f(z) dz = 2πi × (Sum of residues of poles inside contour C).\n'
            '• Residue at simple pole z0: Res(z0) = lim_{z→z0} (z - z0) f(z).\n'
            '• Normal Distribution: 68.3% lies in [μ - σ, μ + σ], 95.4% in [μ - 2σ, μ + 2σ], 99.7% in [μ - 3σ, μ + 3σ].',
        formula: r'\oint_C f(z)\,dz = 2\pi i \sum \text{Res}(f, z_k)',
      ),
    ],
  ),
];
