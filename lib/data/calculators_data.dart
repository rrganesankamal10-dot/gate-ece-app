import 'dart:math' as math;
import '../models/models.dart';

/// All interactive formula calculators for GATE ECE topics.
/// Each calculator takes numeric inputs and returns a computed result string.
final List<FormulaCalculator> gateCalculators = [
  // ── NETWORKS ──────────────────────────────────────────────────────────────
  FormulaCalculator(
    id: 'calc_rc_time',
    topicId: 'networks',
    name: 'RC Time Constant',
    formula: 'τ = R × C',
    description: 'Calculate the RC time constant. The capacitor charges to 63.2% of supply voltage in one τ.',
    inputs: [
      const CalculatorField(id: 'R', label: 'Resistance (R)', unit: 'Ω', defaultValue: 1000, hint: 'e.g. 1000'),
      const CalculatorField(id: 'C', label: 'Capacitance (C)', unit: 'F', defaultValue: 0.000001, hint: 'e.g. 0.000001 for 1μF'),
    ],
    outputUnit: 's',
    calculate: (vals) {
      final tau = vals['R']! * vals['C']!;
      return 'τ = ${_fmt(tau)} s\nBandwidth = ${_fmt(1 / (2 * math.pi * tau))} Hz';
    },
  ),

  FormulaCalculator(
    id: 'calc_rl_time',
    topicId: 'networks',
    name: 'RL Time Constant',
    formula: 'τ = L / R',
    description: 'Calculate the RL time constant.',
    inputs: [
      const CalculatorField(id: 'L', label: 'Inductance (L)', unit: 'H', defaultValue: 0.01, hint: 'e.g. 0.01 for 10mH'),
      const CalculatorField(id: 'R', label: 'Resistance (R)', unit: 'Ω', defaultValue: 100, hint: 'e.g. 100'),
    ],
    outputUnit: 's',
    calculate: (vals) {
      final tau = vals['L']! / vals['R']!;
      return 'τ = ${_fmt(tau)} s';
    },
  ),

  FormulaCalculator(
    id: 'calc_resonance',
    topicId: 'networks',
    name: 'LC Resonance Frequency',
    formula: 'f₀ = 1 / (2π√(LC))',
    description: 'Find resonant frequency of an LC circuit.',
    inputs: [
      const CalculatorField(id: 'L', label: 'Inductance (L)', unit: 'H', defaultValue: 0.001, hint: 'e.g. 0.001 for 1mH'),
      const CalculatorField(id: 'C', label: 'Capacitance (C)', unit: 'F', defaultValue: 0.000001, hint: 'e.g. 0.000001 for 1μF'),
    ],
    outputUnit: 'Hz',
    calculate: (vals) {
      final f0 = 1.0 / (2 * math.pi * math.sqrt(vals['L']! * vals['C']!));
      return 'f₀ = ${_fmt(f0)} Hz\nω₀ = ${_fmt(2 * math.pi * f0)} rad/s';
    },
  ),

  FormulaCalculator(
    id: 'calc_max_power',
    topicId: 'networks',
    name: 'Maximum Power Transfer',
    formula: 'Pmax = Vth² / (4 × Rth)',
    description: 'Calculate maximum power delivered to load when RL = Rth.',
    inputs: [
      const CalculatorField(id: 'Vth', label: 'Thevenin Voltage (Vth)', unit: 'V', defaultValue: 12, hint: 'Open circuit voltage'),
      const CalculatorField(id: 'Rth', label: 'Thevenin Resistance (Rth)', unit: 'Ω', defaultValue: 10, hint: 'Thevenin equivalent resistance'),
    ],
    outputUnit: 'W',
    calculate: (vals) {
      final pmax = (vals['Vth']! * vals['Vth']!) / (4 * vals['Rth']!);
      return 'RL(optimal) = ${_fmt(vals['Rth']!)} Ω\nPmax = ${_fmt(pmax)} W\nVL = ${_fmt(vals['Vth']! / 2)} V';
    },
  ),

  // ── SIGNALS ──────────────────────────────────────────────────────────────
  FormulaCalculator(
    id: 'calc_nyquist',
    topicId: 'signals',
    name: 'Nyquist Sampling Rate',
    formula: 'fs_min = 2 × fmax',
    description: 'Minimum sampling rate to avoid aliasing.',
    inputs: [
      const CalculatorField(id: 'fmax', label: 'Max Signal Frequency', unit: 'Hz', defaultValue: 3000, hint: 'Highest freq component'),
    ],
    outputUnit: 'Hz',
    calculate: (vals) {
      final fs = 2 * vals['fmax']!;
      return 'Minimum fs = ${_fmt(fs)} Hz\nAliasing occurs below this rate';
    },
  ),

  // ── ANALOG ───────────────────────────────────────────────────────────────
  FormulaCalculator(
    id: 'calc_inv_amp',
    topicId: 'analog',
    name: 'Inverting Op-Amp Gain',
    formula: 'Av = -Rf / Rin',
    description: 'Voltage gain of inverting amplifier configuration.',
    inputs: [
      const CalculatorField(id: 'Rin', label: 'Input Resistance (Rin)', unit: 'Ω', defaultValue: 1000, hint: 'e.g. 1000 for 1kΩ'),
      const CalculatorField(id: 'Rf', label: 'Feedback Resistance (Rf)', unit: 'Ω', defaultValue: 47000, hint: 'e.g. 47000 for 47kΩ'),
    ],
    outputUnit: 'V/V',
    calculate: (vals) {
      final av = -vals['Rf']! / vals['Rin']!;
      return 'Av = ${_fmt(av)} (${_fmt(20 * _log10(av.abs()))} dB)\nPhase shift = 180°';
    },
  ),

  FormulaCalculator(
    id: 'calc_noninv_amp',
    topicId: 'analog',
    name: 'Non-Inverting Op-Amp Gain',
    formula: 'Av = 1 + Rf / R1',
    description: 'Voltage gain of non-inverting amplifier configuration.',
    inputs: [
      const CalculatorField(id: 'R1', label: 'Bottom Resistor (R1)', unit: 'Ω', defaultValue: 10000),
      const CalculatorField(id: 'Rf', label: 'Feedback Resistor (Rf)', unit: 'Ω', defaultValue: 90000),
    ],
    outputUnit: 'V/V',
    calculate: (vals) {
      final av = 1 + vals['Rf']! / vals['R1']!;
      return 'Av = ${_fmt(av)} (${_fmt(20 * _log10(av))} dB)\nPhase shift = 0°';
    },
  ),

  FormulaCalculator(
    id: 'calc_rc_filter',
    topicId: 'analog',
    name: 'RC Filter Cutoff Frequency',
    formula: 'fc = 1 / (2πRC)',
    description: '-3dB cutoff frequency for RC filter.',
    inputs: [
      const CalculatorField(id: 'R', label: 'Resistance (R)', unit: 'Ω', defaultValue: 10000),
      const CalculatorField(id: 'C', label: 'Capacitance (C)', unit: 'F', defaultValue: 0.00001),
    ],
    outputUnit: 'Hz',
    calculate: (vals) {
      final fc = 1.0 / (2 * math.pi * vals['R']! * vals['C']!);
      return 'fc = ${_fmt(fc)} Hz\nωc = ${_fmt(2 * math.pi * fc)} rad/s\n-3dB at this frequency';
    },
  ),

  FormulaCalculator(
    id: 'calc_bjt_gm',
    topicId: 'analog',
    name: 'BJT Transconductance',
    formula: 'gm = IC / VT',
    description: 'BJT small-signal transconductance at room temperature.',
    inputs: [
      const CalculatorField(id: 'IC', label: 'Collector Current (IC)', unit: 'A', defaultValue: 0.001, hint: 'e.g. 0.001 for 1mA'),
    ],
    outputUnit: 'A/V',
    calculate: (vals) {
      final gm = vals['IC']! / 0.026; // VT = 26mV at 300K
      return 'gm = ${_fmt(gm)} A/V = ${_fmt(gm * 1000)} mA/V\nrπ = β/gm (assume β=100: rπ=${_fmt(100 / gm)} Ω)';
    },
  ),

  // ── DEVICES ──────────────────────────────────────────────────────────────
  FormulaCalculator(
    id: 'calc_mosfet_id',
    topicId: 'devices',
    name: 'MOSFET Drain Current (Saturation)',
    formula: 'ID = (μnCox/2)(W/L)(VGS - Vth)²',
    description: 'NMOS drain current in saturation region.',
    inputs: [
      const CalculatorField(id: 'kn', label: 'μnCox × W/L (kn\')', unit: 'A/V²', defaultValue: 0.001, hint: 'Process parameter × W/L'),
      const CalculatorField(id: 'VGS', label: 'Gate-Source Voltage (VGS)', unit: 'V', defaultValue: 2.0),
      const CalculatorField(id: 'Vth', label: 'Threshold Voltage (Vth)', unit: 'V', defaultValue: 0.5),
    ],
    outputUnit: 'A',
    calculate: (vals) {
      final id = (vals['kn']! / 2) * (vals['VGS']! - vals['Vth']!) * (vals['VGS']! - vals['Vth']!);
      return 'ID = ${_fmt(id)} A = ${_fmt(id * 1000)} mA\nVDSsat = VGS - Vth = ${_fmt(vals['VGS']! - vals['Vth']!)} V';
    },
  ),

  // ── COMMUNICATIONS ────────────────────────────────────────────────────────
  FormulaCalculator(
    id: 'calc_shannon',
    topicId: 'communications',
    name: 'Shannon Channel Capacity',
    formula: 'C = B × log₂(1 + SNR)',
    description: 'Maximum error-free data rate through a noisy channel.',
    inputs: [
      const CalculatorField(id: 'B', label: 'Bandwidth (B)', unit: 'Hz', defaultValue: 4000, hint: 'Channel bandwidth in Hz'),
      const CalculatorField(id: 'SNR', label: 'Signal-to-Noise Ratio (linear)', unit: '', defaultValue: 31, hint: 'Linear SNR, not dB'),
    ],
    outputUnit: 'bps',
    calculate: (vals) {
      final C = vals['B']! * math.log(1 + vals['SNR']!) / math.log(2);
      final snrdb = 10 * math.log(vals['SNR']!) / math.log(10);
      return 'C = ${_fmt(C)} bps = ${_fmt(C / 1000)} kbps\nSNR = ${_fmt(snrdb)} dB';
    },
  ),

  FormulaCalculator(
    id: 'calc_fm_bw',
    topicId: 'communications',
    name: 'FM Bandwidth (Carson\'s Rule)',
    formula: 'BW = 2(Δf + fm) = 2fm(1 + β)',
    description: 'Approximate FM bandwidth using Carson\'s rule.',
    inputs: [
      const CalculatorField(id: 'df', label: 'Frequency Deviation (Δf)', unit: 'Hz', defaultValue: 5000),
      const CalculatorField(id: 'fm', label: 'Message Frequency (fm)', unit: 'Hz', defaultValue: 1000),
    ],
    outputUnit: 'Hz',
    calculate: (vals) {
      final bw = 2 * (vals['df']! + vals['fm']!);
      final beta = vals['df']! / vals['fm']!;
      return 'BW = ${_fmt(bw)} Hz = ${_fmt(bw / 1000)} kHz\nβ (modulation index) = ${_fmt(beta)}';
    },
  ),

  // ── ELECTROMAGNETICS ─────────────────────────────────────────────────────
  FormulaCalculator(
    id: 'calc_vswr',
    topicId: 'electromagnetics',
    name: 'VSWR & Reflection Coefficient',
    formula: 'Γ = (ZL-Z0)/(ZL+Z0), VSWR = (1+|Γ|)/(1-|Γ|)',
    description: 'Transmission line reflection coefficient and VSWR.',
    inputs: [
      const CalculatorField(id: 'Z0', label: 'Characteristic Impedance (Z0)', unit: 'Ω', defaultValue: 50),
      const CalculatorField(id: 'ZL', label: 'Load Impedance (ZL)', unit: 'Ω', defaultValue: 75),
    ],
    outputUnit: '',
    calculate: (vals) {
      final gamma = (vals['ZL']! - vals['Z0']!) / (vals['ZL']! + vals['Z0']!);
      final gammaAbs = gamma.abs();
      final vswr = (1 + gammaAbs) / (1 - gammaAbs);
      final rl = -20 * math.log(gammaAbs) / math.log(10);
      return '|Γ| = ${_fmt(gammaAbs)}\nVSWR = ${_fmt(vswr)}\nReturn Loss = ${_fmt(rl)} dB';
    },
  ),
];

String _fmt(double v) {
  if (v.abs() >= 1000) return v.toStringAsFixed(1);
  if (v.abs() >= 1) return v.toStringAsFixed(4);
  if (v.abs() >= 0.001) return v.toStringAsFixed(6);
  return v.toStringAsExponential(4);
}

double _log10(double x) {
  return math.log(x) / math.log(10);
}
