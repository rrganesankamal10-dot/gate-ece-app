import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/topics_data.dart';
import '../models/models.dart';

class CalculatorsScreen extends StatelessWidget {
  const CalculatorsScreen({super.key});

  Color _hexToColor(String hex) =>
      Color(int.parse(hex.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    // Build calculators inline (no external import issue)
    final calcs = _buildCalculators();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🧮 Formula Calculators'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: calcs.length,
        itemBuilder: (ctx, i) => _CalculatorCard(calc: calcs[i]),
      ),
    );
  }

  List<_Calc> _buildCalculators() => [
        _Calc(
          topicId: 'networks',
          name: 'RC Time Constant',
          formula: 'τ = R × C',
          description:
              'RC time constant determines how fast a capacitor charges. At t = τ, capacitor reaches 63.2% of supply voltage.',
          fields: [
            _Field('R', 'Resistance', 'Ω', 1000, 'e.g. 1000 for 1kΩ'),
            _Field('C', 'Capacitance', 'F', 0.000001, 'e.g. 0.000001 for 1μF'),
          ],
          compute: (v) {
            final tau = v['R']! * v['C']!;
            final bw = 1.0 / (2 * math.pi * tau);
            return '⏱ τ = ${_f(tau)} s\n📡 Bandwidth = ${_f(bw)} Hz\n🔋 At t=τ: 63.2% charged';
          },
        ),
        _Calc(
          topicId: 'networks',
          name: 'RL Time Constant',
          formula: 'τ = L / R',
          description: 'RL time constant for inductive circuits.',
          fields: [
            _Field('L', 'Inductance', 'H', 0.01, 'e.g. 0.01 for 10mH'),
            _Field('R', 'Resistance', 'Ω', 100, 'e.g. 100'),
          ],
          compute: (v) {
            final tau = v['L']! / v['R']!;
            return '⏱ τ = ${_f(tau)} s';
          },
        ),
        _Calc(
          topicId: 'networks',
          name: 'LC Resonance Frequency',
          formula: 'f₀ = 1 / (2π√LC)',
          description: 'Series/parallel LC circuit resonant frequency.',
          fields: [
            _Field('L', 'Inductance', 'H', 0.001, 'e.g. 0.001 for 1mH'),
            _Field('C', 'Capacitance', 'F', 0.000001, 'e.g. 0.000001 for 1μF'),
          ],
          compute: (v) {
            final f0 = 1.0 / (2 * math.pi * math.sqrt(v['L']! * v['C']!));
            return '🎵 f₀ = ${_f(f0)} Hz\n🔄 ω₀ = ${_f(2 * math.pi * f0)} rad/s';
          },
        ),
        _Calc(
          topicId: 'networks',
          name: 'Maximum Power Transfer',
          formula: 'Pmax = Vth² / 4Rth  (when RL = Rth)',
          description: 'Max power to load when RL equals Thevenin resistance.',
          fields: [
            _Field('Vth', 'Thevenin Voltage', 'V', 12, 'Open circuit voltage'),
            _Field('Rth', 'Thevenin Resistance', 'Ω', 10, 'Source impedance'),
          ],
          compute: (v) {
            final pmax = v['Vth']! * v['Vth']! / (4 * v['Rth']!);
            return '⚡ RL(opt) = ${_f(v['Rth']!)} Ω\n💡 Pmax = ${_f(pmax)} W\n📉 VL = ${_f(v['Vth']! / 2)} V';
          },
        ),
        _Calc(
          topicId: 'signals',
          name: 'Nyquist Sampling Rate',
          formula: 'fs_min = 2 × fmax',
          description: 'Minimum sampling rate to prevent aliasing.',
          fields: [
            _Field('fmax', 'Max Signal Frequency', 'Hz', 3000, 'Highest frequency component'),
          ],
          compute: (v) {
            final fs = 2 * v['fmax']!;
            return '📡 Minimum fs = ${_f(fs)} Hz\n⚠️ Aliasing occurs below this';
          },
        ),
        _Calc(
          topicId: 'analog',
          name: 'Inverting Op-Amp Gain',
          formula: 'Av = −Rf / Rin',
          description: 'Voltage gain of inverting op-amp configuration (180° phase shift).',
          fields: [
            _Field('Rin', 'Input Resistance', 'Ω', 1000, 'e.g. 1000 for 1kΩ'),
            _Field('Rf', 'Feedback Resistance', 'Ω', 47000, 'e.g. 47000 for 47kΩ'),
          ],
          compute: (v) {
            final av = -v['Rf']! / v['Rin']!;
            final db = 20 * math.log(av.abs()) / math.log(10);
            return '📢 Av = ${_f(av)} V/V\n📶 |Av| = ${_f(db)} dB\n↩️ Phase shift: 180°';
          },
        ),
        _Calc(
          topicId: 'analog',
          name: 'Non-Inverting Op-Amp Gain',
          formula: 'Av = 1 + Rf / R1',
          description: 'Voltage gain of non-inverting op-amp (no phase shift).',
          fields: [
            _Field('R1', 'Bottom Resistor (R1)', 'Ω', 10000, ''),
            _Field('Rf', 'Feedback Resistor (Rf)', 'Ω', 90000, ''),
          ],
          compute: (v) {
            final av = 1 + v['Rf']! / v['R1']!;
            final db = 20 * math.log(av) / math.log(10);
            return '📢 Av = ${_f(av)} V/V\n📶 ${_f(db)} dB\n↩️ Phase shift: 0°';
          },
        ),
        _Calc(
          topicId: 'analog',
          name: 'RC Filter Cutoff Frequency',
          formula: 'fc = 1 / (2πRC)',
          description: '-3dB cutoff frequency for RC low-pass or high-pass filter.',
          fields: [
            _Field('R', 'Resistance', 'Ω', 10000, ''),
            _Field('C', 'Capacitance', 'F', 0.00001, 'e.g. 0.00001 for 10μF'),
          ],
          compute: (v) {
            final fc = 1.0 / (2 * math.pi * v['R']! * v['C']!);
            return '🎚 fc = ${_f(fc)} Hz\n🔄 ωc = ${_f(2 * math.pi * fc)} rad/s\n📉 -3dB at this frequency';
          },
        ),
        _Calc(
          topicId: 'analog',
          name: 'BJT Transconductance',
          formula: 'gm = IC / VT  (VT ≈ 26mV at 300K)',
          description: 'BJT small-signal transconductance at room temperature.',
          fields: [
            _Field('IC', 'Collector Current', 'A', 0.001, 'e.g. 0.001 for 1mA'),
          ],
          compute: (v) {
            final gm = v['IC']! / 0.026;
            final rpi = 100 / gm; // assuming beta=100
            return '📡 gm = ${_f(gm)} A/V = ${_f(gm * 1000)} mA/V\n🔩 rπ (β=100) = ${_f(rpi)} Ω';
          },
        ),
        _Calc(
          topicId: 'devices',
          name: 'MOSFET Drain Current (Saturation)',
          formula: 'ID = (kn/2)(VGS − Vth)²',
          description: 'NMOS drain current in saturation. Check: VDS ≥ VGS − Vth.',
          fields: [
            _Field('kn', 'μnCox×W/L  (kn)', 'A/V²', 0.001, 'Process × W/L ratio'),
            _Field('VGS', 'VGS', 'V', 2.0, ''),
            _Field('Vth', 'Threshold Voltage', 'V', 0.5, ''),
          ],
          compute: (v) {
            final vov = v['VGS']! - v['Vth']!;
            if (vov <= 0) return '⚠️ MOSFET is OFF (VGS < Vth)';
            final id = (v['kn']! / 2) * vov * vov;
            return '⚡ ID = ${_f(id)} A = ${_f(id * 1000)} mA\n🔑 VDSsat = ${_f(vov)} V\n✅ Saturation if VDS ≥ ${_f(vov)} V';
          },
        ),
        _Calc(
          topicId: 'communications',
          name: 'Shannon Channel Capacity',
          formula: 'C = B × log₂(1 + SNR)',
          description: 'Maximum error-free data rate over a noisy channel.',
          fields: [
            _Field('B', 'Bandwidth', 'Hz', 4000, 'Channel bandwidth in Hz'),
            _Field('SNR', 'SNR (linear, not dB)', '', 31, 'e.g. 31 = 14.9 dB'),
          ],
          compute: (v) {
            final C = v['B']! * math.log(1 + v['SNR']!) / math.log(2);
            final snrdb = 10 * math.log(v['SNR']!) / math.log(10);
            return '📡 C = ${_f(C)} bps = ${_f(C / 1000)} kbps\n📶 SNR = ${_f(snrdb)} dB';
          },
        ),
        _Calc(
          topicId: 'communications',
          name: 'FM Bandwidth (Carson\'s Rule)',
          formula: 'BW = 2(Δf + fm)',
          description: 'Approximate FM signal bandwidth using Carson\'s rule (98% power).',
          fields: [
            _Field('df', 'Frequency Deviation (Δf)', 'Hz', 5000, ''),
            _Field('fm', 'Message Frequency (fm)', 'Hz', 1000, ''),
          ],
          compute: (v) {
            final bw = 2 * (v['df']! + v['fm']!);
            final beta = v['df']! / v['fm']!;
            return '📻 BW = ${_f(bw)} Hz = ${_f(bw / 1000)} kHz\n📊 β = ${_f(beta)}';
          },
        ),
        _Calc(
          topicId: 'electromagnetics',
          name: 'VSWR & Reflection Coefficient',
          formula: 'Γ = (ZL−Z0)/(ZL+Z0)',
          description: 'Transmission line VSWR and reflection coefficient.',
          fields: [
            _Field('Z0', 'Characteristic Impedance Z0', 'Ω', 50, ''),
            _Field('ZL', 'Load Impedance ZL', 'Ω', 75, ''),
          ],
          compute: (v) {
            final gamma = (v['ZL']! - v['Z0']!) / (v['ZL']! + v['Z0']!);
            final gAbs = gamma.abs();
            if (gAbs >= 1.0) return '⚠️ Open/Short circuit (|Γ|=1)';
            final vswr = (1 + gAbs) / (1 - gAbs);
            final rl = -20 * math.log(gAbs) / math.log(10);
            return '🌊 |Γ| = ${_f(gAbs)}\n📡 VSWR = ${_f(vswr)}\n📉 Return Loss = ${_f(rl)} dB';
          },
        ),
      ];

  static String _f(double v) {
    if (v.abs() == 0) return '0';
    if (v.abs() >= 10000) return v.toStringAsFixed(1);
    if (v.abs() >= 10) return v.toStringAsFixed(3);
    if (v.abs() >= 0.01) return v.toStringAsFixed(6);
    return v.toStringAsExponential(4);
  }
}

class _Field {
  final String id, label, unit, hint;
  final double defaultValue;
  const _Field(this.id, this.label, this.unit, this.defaultValue, this.hint);
}

class _Calc {
  final String topicId, name, formula, description;
  final List<_Field> fields;
  final String Function(Map<String, double>) compute;
  const _Calc({
    required this.topicId,
    required this.name,
    required this.formula,
    required this.description,
    required this.fields,
    required this.compute,
  });
}

class _CalculatorCard extends StatefulWidget {
  final _Calc calc;
  const _CalculatorCard({super.key, required this.calc});

  @override
  State<_CalculatorCard> createState() => _CalculatorCardState();
}

class _CalculatorCardState extends State<_CalculatorCard> {
  late Map<String, TextEditingController> _controllers;
  String? _result;
  bool _expanded = false;

  Color get _color {
    final topic = gateTopics.firstWhere((t) => t.id == widget.calc.topicId,
        orElse: () => gateTopics.first);
    return Color(int.parse(topic.color.replaceFirst('#', '0xFF')));
  }

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (final f in widget.calc.fields)
        f.id: TextEditingController(text: f.defaultValue.toString()),
    };
  }

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  void _calculate() {
    try {
      final vals = {
        for (final f in widget.calc.fields)
          f.id: double.parse(_controllers[f.id]!.text)
      };
      setState(() => _result = widget.calc.compute(vals));
    } catch (e) {
      setState(() => _result = '⚠️ Invalid input — check all fields.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text('🧮', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.calc.name,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700, fontSize: 14)),
                        Text(widget.calc.formula,
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                color: color,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                      color: color),
                ],
              ),
            ),
          ),

          if (_expanded) ...[
            Divider(height: 1, color: color.withOpacity(0.15)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.calc.description,
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.65),
                          height: 1.5)),
                  const SizedBox(height: 14),

                  // Input fields
                  ...widget.calc.fields.map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TextField(
                          controller: _controllers[f.id],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          decoration: InputDecoration(
                            labelText: f.label,
                            suffixText: f.unit.isEmpty ? null : f.unit,
                            hintText: f.hint.isEmpty ? null : f.hint,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                          ),
                        ),
                      )),

                  // Calculate button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.calculate),
                      label: Text('Calculate',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: color),
                      onPressed: _calculate,
                    ),
                  ),

                  // Result
                  if (_result != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: color.withOpacity(0.25)),
                      ),
                      child: Text(
                        _result!,
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1.7,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
