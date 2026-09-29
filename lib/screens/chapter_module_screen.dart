// lib/screens/chapter_module_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../models/models.dart';
import '../providers/progress_provider.dart';
import 'chapter_quiz_screen.dart';

// ─── Module content descriptions ─────────────────────────────────────────────
const Map<String, List<String>> _moduleContent = {
  'networks': [
    'KVL states: The algebraic sum of all voltages around a closed loop equals zero (ΣV = 0). KCL states: The sum of currents entering a node equals the sum leaving it (ΣI = 0). These two laws form the foundation of circuit analysis and are applied systematically to solve for unknown voltages and currents in any linear circuit.',
    'Mesh analysis applies KVL to each independent loop (mesh) in a planar circuit. Assign a mesh current clockwise in each loop. Write KVL equation for each mesh. Solve the resulting system of equations. Number of meshes = B − N + 1 (B = branches, N = nodes).',
    'Node analysis applies KCL at each non-reference node. Assign a reference (ground) node voltage = 0. Express branch currents in terms of node voltages using Ohm\'s law. Write KCL at each non-reference node. Solve the N−1 equations for N−1 unknown node voltages.',
    'Thevenin\'s theorem: Any linear two-terminal circuit can be replaced by an equivalent circuit consisting of voltage source Vth in series with resistance Rth. Vth = open-circuit voltage across terminals. Rth = equivalent resistance with independent sources deactivated (voltage → short, current → open).',
    'Norton\'s theorem: Any linear two-terminal circuit ≡ current source IN in parallel with Rth. IN = Isc (short-circuit current). Rth is same as Thevenin. Conversion: Vth = IN × Rth. Use Norton when load is in parallel with the source.',
    'Superposition: In a linear circuit with multiple independent sources, the response = algebraic sum of responses caused by each source acting alone (with all others deactivated). Voltage sources → short circuit; Current sources → open circuit when deactivated.',
    'Maximum power transfer: Load RL receives maximum power when RL = Rth. Pmax = Vth²/(4Rth). Efficiency at maximum power = 50% (half the power is dissipated internally). Used in antenna matching and audio systems.',
    'Two-port networks characterized by Z, Y, h, ABCD parameters. Z-parameters (impedance): [V] = [Z][I]. Y-parameters (admittance): [I] = [Y][V]. h-parameters used for BJT small-signal model. ABCD (transmission) parameters used for cascaded networks.',
    'Resonance in RLC circuits: At resonant frequency ω₀ = 1/√(LC), XL = XC. Series RLC at resonance: Z = R (minimum), current is maximum. Parallel RLC at resonance: Z = R (maximum), current is minimum. Quality factor Q = ω₀L/R = ω₀/(BW).',
    'Transient analysis: First-order circuits (RC, RL) have exponential responses. RC: v(t) = V∞ + (V₀−V∞)e^(−t/τ), τ=RC. RL: i(t) = I∞ + (I₀−I∞)e^(−t/τ), τ=L/R. Second-order (RLC): can be overdamped, underdamped, or critically damped based on damping ratio ζ.',
  ],
  'signals': [
    'Continuous-time signals x(t): functions of continuous variable t. Key signals: unit step u(t), unit impulse δ(t), complex exponential e^(jωt), sinusoid A·cos(ωt+φ). Signal energy E = ∫|x(t)|²dt; Signal power P = lim(T→∞)(1/2T)∫|x(t)|²dt.',
    'Discrete-time signals x[n]: defined at integer n. Key sequences: unit impulse δ[n], unit step u[n], exponential a^n·u[n]. A causal sequence is zero for n<0. Energy: E = Σ|x[n]|². Periodic if x[n+N]=x[n] for all n.',
    'Fourier series for periodic signals: x(t) = Σcₙe^(jnω₀t). Coefficients cₙ = (1/T)∫x(t)e^(−jnω₀t)dt. Represents signal as sum of harmonics. Parseval\'s theorem: average power = Σ|cₙ|². Gibbs phenomenon occurs at discontinuities.',
    'Continuous Fourier Transform: X(jω) = ∫x(t)e^(−jωt)dt. Inverse: x(t) = (1/2π)∫X(jω)e^(jωt)dω. Key pairs: δ(t)↔1, u(t)↔πδ(ω)+1/(jω), e^(−at)u(t)↔1/(a+jω), rect↔sinc. Properties: linearity, time-shift, frequency-shift, convolution, differentiation.',
    'Laplace Transform: X(s) = ∫x(t)e^(−st)dt, s=σ+jω. More general than FT (allows analysis of unstable systems). Key pairs: u(t)↔1/s, e^(−at)u(t)↔1/(s+a), δ(t)↔1. Initial/final value theorems. Used for circuit analysis and control systems.',
    'Z-Transform: X(z) = Σx[n]z^(−n). Discrete-time equivalent of Laplace. Key pairs: u[n]↔z/(z−1), a^n·u[n]↔z/(z−a). ROC (Region of Convergence) determines causality and stability. Inverse Z: partial fractions, power series, or residue method.',
    'DTFT: X(e^(jω)) = Σx[n]e^(−jωn). DFT: X[k] = Σx[n]e^(−j2πnk/N) for 0≤k<N. FFT is efficient DFT computation O(N log N) vs O(N²). DFT assumes periodicity; apply windowing to reduce spectral leakage.',
    'Nyquist-Shannon sampling theorem: A bandlimited signal with fmax must be sampled at fs ≥ 2fmax. Aliasing occurs if fs < 2fmax (high-frequency components appear as low-frequency artifacts). Anti-aliasing filter (LPF at fmax) applied before sampling. Reconstruction using ideal sinc interpolation.',
    'LTI systems characterized by impulse response h(t) (CT) or h[n] (DT). Properties: linearity (superposition), time-invariance (time-shift in input → same shift in output). Causality: h(t)=0 for t<0. Stability (BIBO): ∫|h(t)|dt < ∞.',
    'Convolution: y(t) = x(t)*h(t) = ∫x(τ)h(t−τ)dτ. For DT: y[n] = x[n]*h[n] = Σx[k]h[n−k]. Steps: flip h, slide across x, integrate product. Convolution ↔ Multiplication in frequency domain (FT/ZT property). Deconvolution used in channel equalization.',
  ],
  'devices': [
    'Semiconductor basics: Si/Ge semiconductors. Intrinsic carriers: ni² = np. For Si at 300K: ni ≈ 1.5×10¹⁰/cm³. Doping: N-type (donor, majority electrons), P-type (acceptor, majority holes). Mass action law: n·p = ni². Fermi level shifts toward conduction band for N-type.',
    'P-N junction: Contact potential Vbi ≈ 0.6–0.7V (Si). Depletion region formed by diffusion. Forward bias: reduces barrier, exponential current. Reverse bias: widens depletion, small leakage current Is. Shockley equation: ID = Is(e^(VD/ηVT)−1). Breakdown: Zener (<6V), avalanche (>6V).',
    'Zener diode: Operates in reverse breakdown. Zener breakdown (tunneling, <6V) or avalanche (impact ionization, >6V). Used as voltage regulator: output voltage = Vz. Must ensure IZ stays between IZmin and IZmax. Power rating: Pmax = VZ × IZmax.',
    'BJT biasing: NPN transistor has 3 regions: Active (linear amplification), Saturation (switch ON), Cutoff (switch OFF). VBE ≈ 0.7V (active mode Si). Fixed bias, self-bias (voltage divider), emitter-feedback bias. Q-point: (VCEq, ICq). β = IC/IB, α = IC/IE = β/(β+1).',
    'BJT small-signal model: hybrid-π model. gm = IC/VT (transconductance). rπ = β/gm (input resistance). ro = VA/IC (output resistance). Voltage gain of CE: Av = −gm(RC||ro). Input resistance Rin = rπ. Frequency response: fT = gm/(2πCπ).',
    'MOSFET operation: N-channel MOSFET. Cutoff: VGS < VTH (no channel). Triode/Linear: VDS < VGS−VTH, ID = μnCox(W/L)[(VGS−VTH)VDS − VDS²/2]. Saturation: VDS ≥ VGS−VTH, ID = (μnCox/2)(W/L)(VGS−VTH)². VTH ≈ 0.5–1V for N-MOSFET.',
    'MOSFET small-signal: gm = 2ID/(VGS−VTH) = √(2μnCox(W/L)ID). rd = 1/λID (channel length modulation). Common-source: Av = −gm(RD||rd). Common-gate: non-inverting, low input impedance. Common-drain (source follower): Av ≈ 1, high input impedance.',
    'LED & Photodiode: LED emits photons via recombination (E=hν=hc/λ). Different materials give different colors: GaAs(IR), GaP(red/green), GaN(blue). Photodiode: reverse-biased p-n junction; photons generate electron-hole pairs → photocurrent IP = responsivity × optical power.',
    'Solar cell: Large-area photodiode. P = VOC × ISC × FF (fill factor). VOC ≈ 0.5–0.6V for Si. Efficiency η = Pout/Pin. Multi-junction solar cells achieve η>40%. Equivalent circuit: current source IP in parallel with diode, series resistance Rs.',
    'JFET: Depletion-type device. Pinch-off voltage VP. Gate-Source reverse biased. IDSS = drain current at VGS=0. ID = IDSS(1−VGS/VP)². gm = 2IDSS/|VP| × (1−VGS/VP). Used in low-noise amplifiers and analog switches.',
  ],
  'analog': [
    'BJT amplifier configurations: Common-Emitter (CE): inverting, high voltage gain Av=−βRC/rπ, medium Rin. Common-Base (CB): non-inverting, low Rin, current gain<1. Common-Collector (CC/Emitter Follower): Av≈1, high Rin, low Rout, used as buffer.',
    'MOSFET amplifiers: Common-Source (CS): Av=−gm×RD, high Rin. Common-Gate (CG): low Rin ≈ 1/gm, non-inverting. Common-Drain (Source Follower): Av≈1, highest Rin, very low Rout. CS is analogous to BJT CE; CG to CB; CD to CC.',
    'Op-Amp fundamentals: Ideal op-amp: Zin=∞, Zout=0, AOL=∞, BW=∞. Virtual short: V+=V− (in linear region). Virtual open: no current into input terminals. Open-loop gain A≈10⁵–10⁶. Slew rate = max dVout/dt. CMRR = common-mode rejection ratio.',
    'Inverting amplifier: Vin→Rin→summing point (V−=0)→Rf→Vout. Av = −Rf/Rin. Rin_input = Rin. Bandwidth: GBW = |Av|×f−3dB. Summing amplifier: Vout = −Rf(V1/R1+V2/R2+...). Difference amplifier: Vout = (Rf/R1)(V2−V1).',
    'Non-inverting amplifier: Vin→V+, Rf and R1 from output to V−. Av = 1+Rf/R1. Rin_input = ∞ (ideal). Voltage follower: Av=1 (Rf=0, R1=∞). Used as buffer/impedance converter. Lower noise than inverting for same gain.',
    'Integrator: Vout = −(1/RC)∫Vin dt. Frequency response: Av(jω) = −1/(jωRC). Gain→∞ at DC (instability → practical: add large Rf in parallel with C). Differentiator: Vout = −RC dVin/dt. Av = −jωRC. Prone to noise amplification at high frequency.',
    'Active filters: Use op-amp + RC. First-order LPF: fc = 1/(2πRC), gain at DC = 1+Rf/R1. Second-order (Sallen-Key): Butterworth (maximally flat), Chebyshev (equiripple), Bessel (linear phase). Higher order by cascading. Active filters avoid inductors.',
    'Oscillators: Barkhausen criterion: Loop gain = 1 and loop phase = 0° (or 360°). RC oscillators: Phase-shift (f₀=1/(2π√6RC)), Wien bridge (f₀=1/(2πRC)). LC oscillators: Colpitts, Hartley, Clapp. Crystal oscillator: highest frequency stability (Q>10⁴).',
    'Wave shaping: Clipper: limits output at a threshold (diode + voltage source). Clamper: shifts DC level (diode + capacitor). Precision rectifier uses op-amp to eliminate diode drop (ideal rectifier). Schmitt trigger: hysteresis using positive feedback for clean switching.',
    'Feedback amplifiers: Negative feedback types: Series-shunt (voltage-voltage), Shunt-shunt (current-voltage), Series-series (voltage-current), Shunt-series (current-current). With feedback β: gain = A/(1+Aβ). Improves bandwidth, reduces distortion and output impedance, increases input impedance (series FB).',
  ],
  'digital': [
    'Number systems: Binary (base-2), Octal (base-8), Hexadecimal (base-16), Decimal (base-10). Conversions: divide by base for integer part, multiply for fractional. 2\'s complement for signed binary: invert all bits + 1. Range of n-bit 2\'s complement: −2^(n−1) to 2^(n−1)−1.',
    'Boolean algebra: Laws: Commutative, Associative, Distributive. Identities: A+0=A, A·1=A, A+1=1, A·0=0. Complement: A+Ā=1, A·Ā=0. De Morgan: (AB)̄=Ā+B̄, (A+B)̄=Ā·B̄. SOP (Sum of Products), POS (Product of Sums) forms.',
    'Logic gates: AND, OR, NOT, NAND, NOR, XOR, XNOR. NAND and NOR are universal gates (any function implementable). XOR: odd parity checker. XNOR: even parity, equality detector. Propagation delay, fan-in, fan-out are key parameters.',
    'Combinational circuits: No memory/feedback. Adders: half-adder (XOR, AND), full-adder (3 inputs, S=A⊕B⊕Cin, Cout=AB+BCin+ACin). Ripple carry adder: n full-adders, delay = n×tFA. Carry look-ahead adder: fast but complex. Subtractor uses 2\'s complement.',
    'Multiplexers & Demux: 2ⁿ:1 MUX selects one of 2ⁿ inputs using n select lines. 1:2ⁿ DEMUX routes 1 input to one of 2ⁿ outputs. MUX as universal logic element (implements any Boolean function). 4:1 MUX needs 2 select lines.',
    'Encoders & Decoders: Priority encoder: 8-to-3, outputs binary code of highest active input. Decoder: 3-to-8, activates one of 8 outputs. BCD to 7-segment decoder drives display. Code converters: BCD to Excess-3, Gray to Binary. Gray code: adjacent codes differ by 1 bit (used in shaft encoders).',
    'Flip-Flops: SR (forbidden: S=R=1), D (data), JK (versatile: J=K=1→toggle), T (toggle). Level-sensitive (latch) vs edge-triggered. Master-slave FF eliminates race condition. Flip-flops are basic memory elements in sequential circuits.',
    'Counters: Synchronous: all FFs clocked simultaneously (faster). Asynchronous/Ripple: FFs trigger each other (propagation delay accumulates). Mod-N counter: divides clock by N. Up/down counters. BCD counter: mod-10. Ring counter and Johnson counter.',
    'Shift registers: SISO, SIPO, PISO, PIPO configurations. Serial data transmission. Universal shift register: can shift left/right/parallel load. Ring counter from shift register. Used in serial-parallel conversion, sequence generators.',
    'ADC & DAC: DAC: converts n-bit digital to analog. Resolution = Vref/2ⁿ. Types: R-2R ladder (accurate), weighted resistor. ADC types: Flash (fastest, 2ⁿ comparators), SAR (Successive Approximation, balanced), Dual-slope (accurate, slow). ADC parameters: resolution, ENOB, SNR, THD.',
  ],
  'control': [
    'Transfer functions: G(s) = Y(s)/U(s) for zero initial conditions. Poles (denominator roots) determine stability; zeros (numerator roots) affect response shape. Order = degree of denominator. DC gain = G(0). Standard 2nd-order: ωn²/(s²+2ζωns+ωn²).',
    'Block diagram reduction: Series: G1·G2. Parallel: G1+G2. Feedback: G/(1+GH). Moving a summing junction ahead of block: multiply branch by 1/G. Moving a takeoff point behind block: multiply branch by G. Signal flow graph uses Mason\'s gain formula.',
    'Signal flow graph: Mason\'s gain formula: T = ΣPk·Δk/Δ. Δ = 1 − ΣL₁ + ΣL₂ − ... Forward path gain Pk. Δk = cofactor (Δ with loops touching Pk removed). More efficient than block diagram for complex systems.',
    'Time domain analysis: 2nd-order step response. ζ<1: underdamped (oscillatory). ζ=1: critically damped (fastest non-oscillatory). ζ>1: overdamped. Key specs: rise time tr, peak time tp=π/ωd, overshoot Mp=e^(−πζ/√(1−ζ²))×100%, settling time ts≈4/(ζωn).',
    'Frequency domain analysis: Frequency response G(jω). Magnitude |G(jω)| in dB = 20 log₁₀|G(jω)|. Phase ∠G(jω). Bandwidth: frequency where gain drops 3 dB. Resonance peak Mr = 1/(2ζ√(1−ζ²)) for ζ<0.707.',
    'Bode plot: Log-frequency vs magnitude (dB) and phase (degrees). Asymptotic approximations: pole at s=−a adds −20dB/decade slope after ω=a, −45° at ω=a. Zero: +20dB/decade. Integrator: −20dB/decade from ω=0. Simplifies frequency response sketching.',
    'Nyquist criterion: Stability determined by encirclements of −1+j0 point in G(jω)H(jω) polar plot. N = Z − P where N=encirclements, Z=closed-loop RHP poles, P=open-loop RHP poles. Stable if Z=0 → N=−P.',
    'Root locus: Locus of closed-loop poles as gain K varies 0→∞. Rules: starts at OL poles, ends at OL zeros. Number of branches = number of poles. Asymptotes centroid = (Σpoles−Σzeros)/(n−m). Breakaway/break-in points on real axis. Design by adding poles/zeros.',
    'Routh-Hurwitz: Construct Routh array from characteristic polynomial. System stable if all elements in first column have same sign. Sign changes = number of RHP poles. Special cases: zero in first column (replace with ε→0), row of zeros (use auxiliary equation).',
    'PID controllers: P (Proportional): reduces error, may cause steady-state error. I (Integral): eliminates steady-state error, may cause oscillation. D (Derivative): damps oscillation, predicts error trend, amplifies noise. Ziegler-Nichols tuning methods for PID parameters.',
  ],
  'communications': [
    'Amplitude Modulation (AM): s(t) = Ac[1 + μcos(2πfmt)]cos(2πfct). Modulation index μ = Am/Ac. Bandwidth BW = 2fm. Total power P = Pc(1 + μ²/2). Efficiency η = μ²/(2+μ²). DSB-SC (no carrier): P = Pc·μ²/2. SSB: BW = fm.',
    'Frequency Modulation (FM): Instantaneous frequency fi = fc + kf·m(t). Frequency deviation Δf = kf·Am. Modulation index β = Δf/fm. Carson\'s rule BW = 2(Δf+fm) = 2fm(1+β). FM is more noise-resistant than AM. FM capture effect.',
    'Sampling & PCM: Sampling at fs → discrete-time signal. Quantization: divides amplitude into 2ⁿ levels. Quantization noise power = Δ²/12 = Vref²/(3×4ⁿ). PCM bit rate = fs × n bits/sample. Companding (μ-law, A-law) reduces quantization error for small signals.',
    'Digital modulation: ASK: amplitude varies. FSK: frequency varies. PSK: phase varies. BPSK: 2 phases (1 bit/symbol), BER = Q(√(2Eb/N0)). QPSK: 4 phases (2 bits/symbol), same BER as BPSK. Constellation diagrams show symbol mapping.',
    'QAM & OFDM: M-QAM: M = 2^k symbols using both amplitude and phase. 16-QAM = 4 bits/symbol. OFDM: Orthogonal Frequency Division Multiplexing, uses DFT/IDFT. Resistant to multipath. Cyclic prefix eliminates ISI. Used in 4G/5G, WiFi.',
    'Noise in communication: Thermal noise: N = kTB (Johnson noise). SNR = S/N. Noise figure NF = SNRin/SNRout (dB). Friis formula for cascaded stages: Ftotal = F1 + (F2−1)/G1 + (F3−1)/(G1G2) + ... White noise: flat PSD N₀/2. AWGN channel model.',
    'Information theory: Entropy H(X) = −Σp(x)log₂p(x) bits. Maximum entropy for uniform distribution = log₂M. Mutual information I(X;Y) = H(X) − H(X|Y). Channel capacity C = max I(X;Y) = B log₂(1+SNR). Source coding: Huffman, Shannon-Fano. Channel coding: Hamming, convolution codes.',
    'Error correction codes: Hamming distance: minimum errors needed to change codeword. (n,k) block code: n bits total, k information bits, n−k redundancy bits. Hamming code: detects 2-bit, corrects 1-bit errors. CRC: detects burst errors. Convolutional codes: used with Viterbi decoder.',
    'Spread spectrum: DSSS (Direct Sequence): multiply by PN code (chipping sequence). Processing gain Gp = Wss/Winfo (dB). FHSS (Frequency Hopping): carrier jumps between frequencies. CDMA uses DSSS for multiple access. Resistant to narrowband jamming and interception.',
    'Matched filter: Maximizes output SNR at sampling instant. h(t) = x(T−t) (time-reversed, delayed version of signal). Correlator receiver is equivalent. Optimal detector for AWGN. Output SNR = 2E/N₀ where E = signal energy. Used in radar and digital comms.',
  ],
  'electromagnetics': [
    'Vector calculus: Gradient ∇f: direction of steepest ascent. Divergence ∇·F: net flux out of a point. Curl ∇×F: rotation/circulation. Divergence theorem: ∯F·dS = ∭∇·F dV. Stokes\' theorem: ∮F·dl = ∬∇×F·dS. Coordinate systems: Cartesian, Cylindrical, Spherical.',
    'Electrostatics: Coulomb\'s law: F = q1q2/(4πε₀r²). Electric field E = F/q. Gauss\'s law: ∯D·dS = Qenc. D = ε₀E (free space). Potential V = −∫E·dl. Capacitance C = Q/V. Laplace equation: ∇²V = 0 (charge-free). Poisson: ∇²V = −ρv/ε.',
    'Magnetostatics: Biot-Savart: dH = I(dl×âR)/(4πR²). Ampere\'s law: ∮H·dl = Ienc. B = μ₀H (free space). Magnetic flux Φ = ∬B·dS. Faraday\'s law (static limit). Force on current: F = IL×B. Inductance L = NΦ/I.',
    'Maxwell\'s equations: ∇×E = −∂B/∂t (Faraday). ∇×H = J + ∂D/∂t (Ampere+displacement). ∇·D = ρv (Gauss electric). ∇·B = 0 (Gauss magnetic). Constitutive: D=εE, B=μH, J=σE. Boundary conditions at interfaces: tangential E continuous, normal D discontinuous by ρs.',
    'EM wave propagation: Wave equation from Maxwell\'s: ∇²E = με∂²E/∂t². Phase velocity vp = 1/√(με). For free space vp = c = 3×10⁸ m/s. Intrinsic impedance η = √(μ/ε) = 377Ω (free space). Skin depth δ = √(2/ωμσ). Plane wave: E and H perpendicular, transverse to propagation.',
    'Transmission lines: Telegrapher\'s equations. Characteristic impedance Z₀ = √(L/C). Propagation constant γ = α + jβ. Reflection coefficient Γ = (ZL−Z₀)/(ZL+Z₀). VSWR = (1+|Γ|)/(1−|Γ|). Input impedance: Zin = Z₀(ZL+jZ₀tanβl)/(Z₀+jZLtanβl). Short-circuit and open-circuit stubs.',
    'Smith chart: Graphical tool for transmission line calculations. Normalized impedance z = Z/Z₀. Circles of constant resistance and reactance. Reflection coefficient plotted in polar form. Moving toward generator: clockwise. Impedance matching using stub tuners. Read reflection coefficient, VSWR, impedance directly.',
    'Waveguides: Hollow metallic tubes. TE (transverse electric), TM (transverse magnetic) modes. No TEM mode. Cutoff frequency fc(mn) = (c/2)√((m/a)²+(n/b)²) for rectangular. Dominant mode TE₁₀: fc = c/2a. Phase velocity > c, group velocity < c. vp×vg = c². Attenuation below cutoff.',
    'Antenna basics: Radiation resistance Rrad. Short dipole (Δl << λ): Rrad = 80π²(Δl/λ)². Half-wave dipole: Rrad ≈ 73Ω, D = 1.64 (2.15 dBi). Effective aperture Ae = Gλ²/(4π). Friis transmission: Pr/Pt = GtGr(λ/4πR)². Polarization: linear, circular, elliptical.',
    'Radiation pattern: 3D plot of radiated power vs direction. Main lobe, side lobes, back lobe, nulls. HPBW (Half-Power Beamwidth). Directivity D = 4π×Umax/Prad. Gain G = η×D (η = radiation efficiency). Antenna arrays: increase directivity using interference (constructive in desired direction).',
  ],
  'math': [
    'Linear algebra: Matrix operations, determinants, rank. Eigenvalues: det(A−λI)=0. Eigenvectors: (A−λI)v=0. Diagonalization: A=PDP⁻¹ if n independent eigenvectors. Cayley-Hamilton theorem: A satisfies its own characteristic equation. Gram-Schmidt orthogonalization.',
    'Calculus: Differentiation rules, chain rule, product rule. Integration techniques: substitution, parts, partial fractions. Multiple integrals: double, triple, change of order. Taylor/Maclaurin series. L\'Hôpital\'s rule for 0/0 or ∞/∞ forms. Extreme value analysis.',
    'Differential equations: First-order: separable, linear (integrating factor). Second-order linear with constant coefficients: homogeneous (characteristic equation) + particular (undetermined coefficients or variation of parameters). Laplace transform method. Systems of ODEs.',
    'Vector analysis: Gradient, divergence, curl. Line integrals, surface integrals, volume integrals. Green\'s theorem (2D). Stokes\' theorem. Divergence (Gauss\') theorem. Conservative fields: ∇×F=0. Scalar and vector potentials.',
    'Complex analysis: Complex numbers z=x+jy, |z|, arg(z). Analytic functions (Cauchy-Riemann equations). Cauchy\'s integral theorem/formula. Laurent series. Residue theorem for contour integrals. Poles and residues. Used in Laplace and Z-transform inversion.',
    'Probability & statistics: Sample space, events, probability axioms. Conditional probability P(A|B). Bayes\' theorem. Random variables: PDF, CDF, expected value E[X], variance Var(X). Common distributions: Gaussian/Normal, Binomial, Poisson, Uniform, Exponential. Central Limit Theorem.',
    'Numerical methods: Root finding: Bisection, Newton-Raphson (x_{n+1}=xₙ−f(xₙ)/f\'(xₙ)). Numerical integration: Trapezoidal rule, Simpson\'s 1/3 rule. Numerical ODE solving: Euler, Runge-Kutta (4th order). Gauss elimination for linear systems. Interpolation: Lagrange, Newton.',
    'Fourier analysis (Math): Fourier series for periodic functions. Fourier transform pairs. Parseval\'s theorem. Convolution theorem. Poisson summation formula. Windowed Fourier/Short-time FT. Applied in signal processing, PDE solving, spectral analysis.',
    'Z-Transform (Math): Bilateral Z-transform. ROC, causality, stability conditions. Inverse Z by partial fractions, power series. Unilateral Z for initial conditions. Difference equations solved via Z-transform. Tables of common pairs and properties.',
    'Laplace (Math): Bilateral and unilateral Laplace transforms. ROC in s-plane. Inverse via Bromwich contour integral or partial fractions. Solving ODEs and systems. Transfer function definition. Stability via pole locations (Re(s)<0 for stable).',
  ],
};

String _getModuleContent(String topicId, int index) {
  final list = _moduleContent[topicId] ?? [];
  if (index < list.length) return list[index];
  return 'Study material for this module covers advanced concepts in ${topicId} engineering. '
      'Please refer to standard GATE textbooks for detailed theory and solved examples.';
}

// ─── CHAPTER MODULE SCREEN ──────────────────────────────────────────────────
class ChapterModuleScreen extends StatefulWidget {
  final GateTopic topic;

  const ChapterModuleScreen({super.key, required this.topic});

  @override
  State<ChapterModuleScreen> createState() => _ChapterModuleScreenState();
}

class _ChapterModuleScreenState extends State<ChapterModuleScreen> {
  late ConfettiController _confettiController;

  Color get _topicColor {
    try {
      return Color(int.parse(widget.topic.color.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF1565C0);
    }
  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    final modules = widget.topic.subtopics;
    final total = modules.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.topic.name,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        backgroundColor: _topicColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 40,
            colors: const [Colors.amber, Colors.green, Colors.blue, Colors.pink],
          ),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _TopicHeader(
                  topic: widget.topic,
                  topicColor: _topicColor,
                  progress: progress,
                  total: total,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _ModuleTile(
                      index: i,
                      moduleName: modules[i],
                      topicId: widget.topic.id,
                      topicName: widget.topic.name,
                      topicColor: _topicColor,
                      total: total,
                      progress: progress,
                      confettiController: _confettiController,
                    ),
                    childCount: modules.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Topic Header ────────────────────────────────────────────────────────────
class _TopicHeader extends StatelessWidget {
  final GateTopic topic;
  final Color topicColor;
  final ProgressProvider progress;
  final int total;

  const _TopicHeader({
    required this.topic,
    required this.topicColor,
    required this.progress,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final done = progress.completedModules(topic.id);
    final pct = total == 0 ? 0.0 : done / total;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [topicColor, topicColor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topic.icon,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 8),
          Text(
            topic.subtitle,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$done / $total modules',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              Text(
                '${(pct * 100).toInt()}%',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFFD600),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD600)),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Module Tile ─────────────────────────────────────────────────────────────
class _ModuleTile extends StatelessWidget {
  final int index;
  final String moduleName;
  final String topicId;
  final String topicName;
  final Color topicColor;
  final int total;
  final ProgressProvider progress;
  final ConfettiController confettiController;

  const _ModuleTile({
    required this.index,
    required this.moduleName,
    required this.topicId,
    required this.topicName,
    required this.topicColor,
    required this.total,
    required this.progress,
    required this.confettiController,
  });

  bool get _isCompleted => progress.isModuleComplete(topicId, index);
  bool get _isLocked => index > 0 && !progress.isModuleComplete(topicId, index - 1);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color statusColor;
    IconData statusIcon;
    String statusLabel;

    if (_isCompleted) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
      statusLabel = 'Completed';
    } else if (_isLocked) {
      statusColor = Colors.grey;
      statusIcon = Icons.lock;
      statusLabel = 'Locked';
    } else {
      statusColor = topicColor;
      statusIcon = Icons.play_circle_outline;
      statusLabel = 'Start';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: _isLocked
            ? null
            : () => _openModule(context),
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isCompleted
                ? Colors.green.withOpacity(0.06)
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isCompleted
                  ? Colors.green.withOpacity(0.3)
                  : _isLocked
                      ? colorScheme.outline.withOpacity(0.12)
                      : topicColor.withOpacity(0.25),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Number badge
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: statusColor,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      moduleName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: _isLocked
                            ? colorScheme.onSurface.withOpacity(0.4)
                            : colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      statusLabel,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(statusIcon, color: statusColor, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  void _openModule(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ModuleStudySheet(
        index: index,
        moduleName: moduleName,
        topicId: topicId,
        topicName: topicName,
        topicColor: topicColor,
        total: total,
        confettiController: confettiController,
      ),
    );
  }
}

// ─── Module Study Sheet ───────────────────────────────────────────────────────
class _ModuleStudySheet extends StatelessWidget {
  final int index;
  final String moduleName;
  final String topicId;
  final String topicName;
  final Color topicColor;
  final int total;
  final ConfettiController confettiController;

  const _ModuleStudySheet({
    required this.index,
    required this.moduleName,
    required this.topicId,
    required this.topicName,
    required this.topicColor,
    required this.total,
    required this.confettiController,
  });

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
    final content = _getModuleContent(topicId, index);
    final alreadyDone = progress.isModuleComplete(topicId, index);

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: topicColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Module ${index.toString().padLeft(2, '0')}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: topicColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                moduleName,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                topicName,
                style: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
              ),
            ),
            const Divider(height: 24),
            // Content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📖 Study Notes',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: topicColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      content,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        height: 1.7,
                        color: colorScheme.onSurface.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (!alreadyDone)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await progress.markModuleComplete(topicId, index, total);
                            if (context.mounted) Navigator.pop(context);
                            // Check full completion
                            final allDone = progress.isTopicFullyComplete(topicId);
                            if (allDone && context.mounted) {
                              confettiController.play();
                              _showCompletionDialog(context, progress);
                            } else if (context.mounted) {
                              _showModuleQuizPrompt(context, progress);
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: Text(
                            'Mark as Complete (+20 XP)',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: topicColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              'Module Completed!',
                              style: GoogleFonts.inter(
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCompletionDialog(BuildContext context, ProgressProvider progress) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ChapterCompleteDialog(
        topicId: topicId,
        topicName: topicName,
        topicColor: topicColor,
        xpEarned: 20 * total,
      ),
    );
  }
  void _showModuleQuizPrompt(BuildContext context, ProgressProvider progress) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _ModuleCompleteQuizDialog(
        topicId: topicId,
        topicName: topicName,
        topicColor: topicColor,
        moduleName: moduleName,
        streak: progress.streak,
      ),
    );
  }
}

// ─── Module Complete Quiz Prompt Dialog ──────────────────────────────────────
class _ModuleCompleteQuizDialog extends StatelessWidget {
  final String topicId;
  final String topicName;
  final Color topicColor;
  final String moduleName;
  final int streak;

  const _ModuleCompleteQuizDialog({
    required this.topicId,
    required this.topicName,
    required this.topicColor,
    required this.moduleName,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🎉', style: TextStyle(fontSize: 36)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE65100).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE65100).withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 4),
                      Text(
                        '$streak Day Streak!',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: const Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Module Mastered! (+20 XP)',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: topicColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              moduleName,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: topicColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: topicColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Text('🧠', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Lock in retention right now with a fast 5-question quiz and earn +50 bonus XP!',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.blueGrey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterQuizScreen(
                        topicId: topicId,
                        topicName: topicName,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.bolt, color: Color(0xFFFFD600)),
                label: Text(
                  'Take Quick Quiz (+50 XP)',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: topicColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Next Module ➔',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Chapter Complete Dialog ─────────────────────────────────────────────────
class _ChapterCompleteDialog extends StatelessWidget {
  final String topicId;
  final String topicName;
  final Color topicColor;
  final int xpEarned;

  const _ChapterCompleteDialog({
    required this.topicId,
    required this.topicName,
    required this.topicColor,
    required this.xpEarned,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 60)),
            const SizedBox(height: 12),
            Text(
              'Chapter Complete!',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: topicColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              topicName,
              style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [topicColor, topicColor.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Color(0xFFFFD600), size: 18),
                  const SizedBox(width: 6),
                  Text(
                    '+$xpEarned XP Earned',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterQuizScreen(
                        topicId: topicId,
                        topicName: topicName,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.quiz),
                label: Text(
                  'Take Chapter Quiz',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: topicColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Continue Learning',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
