import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircuitVisualizerScreen extends StatefulWidget {
  const CircuitVisualizerScreen({super.key});

  @override
  State<CircuitVisualizerScreen> createState() => _CircuitVisualizerScreenState();
}

class _CircuitVisualizerScreenState extends State<CircuitVisualizerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '⚡ Interactive Circuit Labs',
          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFFFFD600),
          unselectedLabelColor: Colors.white70,
          indicatorColor: const Color(0xFFFFD600),
          indicatorWeight: 3,
          tabs: const [
            Tab(icon: Icon(Icons.waves), text: 'RLC Resonance'),
            Tab(icon: Icon(Icons.settings_input_component), text: 'Op-Amp Studio'),
            Tab(icon: Icon(Icons.alt_route), text: 'Logic Gates Lab'),
            Tab(icon: Icon(Icons.tune), text: 'BJT Load Line'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          RlcResonanceLab(),
          OpAmpStudioLab(),
          LogicGatesLab(),
          BjtLoadLineLab(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. RLC RESONANCE & OSCILLOSCOPE LAB
// ─────────────────────────────────────────────────────────────────────────────
class RlcResonanceLab extends StatefulWidget {
  const RlcResonanceLab({super.key});

  @override
  State<RlcResonanceLab> createState() => _RlcResonanceLabState();
}

class _RlcResonanceLabState extends State<RlcResonanceLab> {
  double _r = 50.0; // Ohms
  double _l = 10.0; // mH
  double _c = 1.0; // uF
  double _freq = 1591.0; // Hz
  double _vin = 10.0; // V peak

  double get lHenries => _l * 1e-3;
  double get cFarads => _c * 1e-6;
  double get omega => 2 * math.pi * _freq;
  double get xl => omega * lHenries;
  double get xc => 1.0 / (omega * cFarads);
  double get zMag => math.sqrt(_r * _r + (xl - xc) * (xl - xc));
  double get phaseAngleRad => math.atan2(xl - xc, _r);
  double get phaseAngleDeg => phaseAngleRad * 180 / math.pi;
  double get iPeak => _vin / zMag;
  double get fResonance => 1.0 / (2 * math.pi * math.sqrt(lHenries * cFarads));
  double get qualityFactor => (1.0 / _r) * math.sqrt(lHenries / cFarads);
  double get bandwidth => fResonance / qualityFactor;

  @override
  void initState() {
    super.initState();
    _freq = fResonance;
  }

  @override
  Widget build(BuildContext context) {
    final isResonant = (_freq - fResonance).abs() < (fResonance * 0.05);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Oscilloscope Screen
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF070E17),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1565C0), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1565C0).withOpacity(0.3),
                  blurRadius: 15,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CustomPaint(
                painter: OscilloscopePainter(
                  vinPeak: _vin,
                  iPeak: iPeak * 100, // Scale for visibility
                  phaseRad: phaseAngleRad,
                  freq: _freq,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SignalLegend(color: Colors.amberAccent, label: 'Vin (V)'),
              _SignalLegend(color: Colors.cyanAccent, label: 'Iout (mA scaled)'),
              if (isResonant)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.flash_on, color: Colors.green, size: 14),
                      Text(
                        'AT RESONANCE',
                        style: GoogleFonts.inter(
                          color: Colors.green,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Live Parameters Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _MetricTile(
                          title: 'Resonant Freq (f₀)',
                          value: '${fResonance.toStringAsFixed(1)} Hz',
                          highlight: true,
                        ),
                      ),
                      Expanded(
                        child: _MetricTile(
                          title: 'Quality Factor (Q)',
                          value: qualityFactor.toStringAsFixed(2),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _MetricTile(
                          title: 'Impedance |Z|',
                          value: '${zMag.toStringAsFixed(2)} Ω',
                        ),
                      ),
                      Expanded(
                        child: _MetricTile(
                          title: 'Phase Angle (θ)',
                          value: '${phaseAngleDeg.toStringAsFixed(1)}°',
                        ),
                      ),
                      Expanded(
                        child: _MetricTile(
                          title: 'Peak Current (I)',
                          value: '${(iPeak * 1000).toStringAsFixed(1)} mA',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Interactive Sliders
          _ControlSlider(
            label: 'Frequency (f)',
            unit: 'Hz',
            value: _freq,
            min: 100,
            max: 10000,
            onChanged: (v) => setState(() => _freq = v),
            quickActions: [
              TextButton(
                onPressed: () => setState(() => _freq = fResonance),
                child: const Text('Snap to f₀', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          _ControlSlider(
            label: 'Resistance (R)',
            unit: 'Ω',
            value: _r,
            min: 5,
            max: 500,
            onChanged: (v) => setState(() => _r = v),
          ),
          _ControlSlider(
            label: 'Inductance (L)',
            unit: 'mH',
            value: _l,
            min: 1,
            max: 100,
            onChanged: (v) => setState(() => _l = v),
          ),
          _ControlSlider(
            label: 'Capacitance (C)',
            unit: 'μF',
            value: _c,
            min: 0.1,
            max: 20,
            onChanged: (v) => setState(() => _c = v),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. OP-AMP STUDIO LAB
// ─────────────────────────────────────────────────────────────────────────────
class OpAmpStudioLab extends StatefulWidget {
  const OpAmpStudioLab({super.key});

  @override
  State<OpAmpStudioLab> createState() => _OpAmpStudioLabState();
}

class _OpAmpStudioLabState extends State<OpAmpStudioLab> {
  String _mode = 'Inverting'; // Inverting, Non-Inverting, Integrator, Buffer
  double _rin = 10.0; // kOhms
  double _rf = 47.0; // kOhms
  double _vin = 1.0; // V peak
  double _vcc = 15.0; // V supply rails

  double get gain {
    switch (_mode) {
      case 'Inverting':
        return -(_rf / _rin);
      case 'Non-Inverting':
        return 1 + (_rf / _rin);
      case 'Buffer':
        return 1.0;
      case 'Integrator':
        return -(_rf / _rin); // magnitude proxy
      default:
        return 1.0;
    }
  }

  double get theoreticalVout => _vin * gain;
  double get actualVout => theoreticalVout.clamp(-_vcc + 1.5, _vcc - 1.5);
  bool get isClipped => theoreticalVout.abs() > (_vcc - 1.5);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mode selector chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Inverting', 'Non-Inverting', 'Buffer', 'Integrator'].map((m) {
                final selected = _mode == m;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(m, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                    selected: selected,
                    selectedColor: const Color(0xFF1565C0),
                    onSelected: (_) => setState(() => _mode = m),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Circuit Schematic & Waveform Display
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF070E17),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isClipped ? Colors.redAccent : const Color(0xFF1565C0),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CustomPaint(
                painter: OpAmpWaveformPainter(
                  vinPeak: _vin,
                  gain: gain,
                  vSat: _vcc - 1.5,
                  isInverting: _mode == 'Inverting' || _mode == 'Integrator',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SignalLegend(color: Colors.amberAccent, label: 'Vin (Input)'),
              _SignalLegend(
                color: isClipped ? Colors.redAccent : Colors.cyanAccent,
                label: isClipped ? 'Vout (CLIPPED!)' : 'Vout (Output)',
              ),
              Text(
                'Rails: ±${_vcc.toStringAsFixed(0)}V',
                style: GoogleFonts.inter(fontSize: 12, color: Colors.white60),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Metric Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _MetricTile(
                      title: 'Voltage Gain (Av)',
                      value: '${gain.toStringAsFixed(2)} V/V',
                      subtitle: '${(20 * math.log(gain.abs()) / math.log(10)).toStringAsFixed(1)} dB',
                      highlight: true,
                    ),
                  ),
                  Expanded(
                    child: _MetricTile(
                      title: 'Peak Output (Vout)',
                      value: '${actualVout.toStringAsFixed(2)} V',
                      subtitle: isClipped ? '⚠️ Saturated!' : 'Linear Region',
                    ),
                  ),
                  Expanded(
                    child: _MetricTile(
                      title: 'Phase Shift',
                      value: _mode == 'Inverting' || _mode == 'Integrator' ? '180°' : '0°',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Controls
          _ControlSlider(
            label: 'Input Voltage (Vin Peak)',
            unit: 'V',
            value: _vin,
            min: 0.1,
            max: 10.0,
            onChanged: (v) => setState(() => _vin = v),
          ),
          if (_mode != 'Buffer') ...[
            _ControlSlider(
              label: 'Feedback Resistor (Rf)',
              unit: 'kΩ',
              value: _rf,
              min: 1.0,
              max: 200.0,
              onChanged: (v) => setState(() => _rf = v),
            ),
            _ControlSlider(
              label: 'Input Resistor (Rin)',
              unit: 'kΩ',
              value: _rin,
              min: 1.0,
              max: 100.0,
              onChanged: (v) => setState(() => _rin = v),
            ),
          ],
          _ControlSlider(
            label: 'Supply Rails (±Vcc)',
            unit: 'V',
            value: _vcc,
            min: 5.0,
            max: 24.0,
            onChanged: (v) => setState(() => _vcc = v),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. LOGIC GATES LAB & TRUTH TABLE SIMULATOR
// ─────────────────────────────────────────────────────────────────────────────
class LogicGatesLab extends StatefulWidget {
  const LogicGatesLab({super.key});

  @override
  State<LogicGatesLab> createState() => _LogicGatesLabState();
}

class _LogicGatesLabState extends State<LogicGatesLab> {
  String _selectedGate = 'AND';
  bool _inA = false;
  bool _inB = false;

  bool _evaluate(String gate, bool a, bool b) {
    switch (gate) {
      case 'AND':
        return a && b;
      case 'OR':
        return a || b;
      case 'NOT':
        return !a;
      case 'NAND':
        return !(a && b);
      case 'NOR':
        return !(a || b);
      case 'XOR':
        return a != b;
      case 'XNOR':
        return a == b;
      default:
        return false;
    }
  }

  bool get output => _evaluate(_selectedGate, _inA, _inB);

  @override
  Widget build(BuildContext context) {
    final gates = ['AND', 'OR', 'NOT', 'NAND', 'NOR', 'XOR', 'XNOR'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gate Selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: gates.map((g) {
                final selected = _selectedGate == g;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(g, style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                    selected: selected,
                    selectedColor: const Color(0xFF880E4F),
                    onSelected: (_) => setState(() => _selectedGate = g),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Interactive Logic Board
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1A24),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF880E4F), width: 2),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Input A
                    _InputSwitch(
                      label: 'Input A',
                      val: _inA,
                      onToggle: (v) => setState(() => _inA = v),
                    ),
                    // Gate Symbol
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF880E4F).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF880E4F)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _selectedGate,
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          Text('GATE', style: GoogleFonts.inter(fontSize: 10, color: Colors.white60)),
                        ],
                      ),
                    ),
                    // Output LED
                    _OutputIndicator(val: output),
                  ],
                ),
                if (_selectedGate != 'NOT') ...[
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _InputSwitch(
                        label: 'Input B',
                        val: _inB,
                        onToggle: (v) => setState(() => _inB = v),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Truth Table
          Text(
            '$_selectedGate Gate Truth Table',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(const Color(0xFF880E4F).withOpacity(0.15)),
                columns: [
                  const DataColumn(label: Text('Input A')),
                  if (_selectedGate != 'NOT') const DataColumn(label: Text('Input B')),
                  DataColumn(label: Text('Output ($_selectedGate)')),
                ],
                rows: _selectedGate == 'NOT'
                    ? [
                        _buildRow(false, false, _evaluate('NOT', false, false), _inA == false),
                        _buildRow(true, false, _evaluate('NOT', true, false), _inA == true),
                      ]
                    : [
                        _buildRow(false, false, _evaluate(_selectedGate, false, false), !_inA && !_inB),
                        _buildRow(false, true, _evaluate(_selectedGate, false, true), !_inA && _inB),
                        _buildRow(true, false, _evaluate(_selectedGate, true, false), _inA && !_inB),
                        _buildRow(true, true, _evaluate(_selectedGate, true, true), _inA && _inB),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(bool a, bool b, bool out, bool isCurrentState) {
    return DataRow(
      color: isCurrentState
          ? MaterialStateProperty.all(const Color(0xFFFFD600).withOpacity(0.15))
          : null,
      cells: [
        DataCell(Text(a ? '1' : '0', style: TextStyle(fontWeight: isCurrentState ? FontWeight.bold : FontWeight.normal))),
        if (_selectedGate != 'NOT')
          DataCell(Text(b ? '1' : '0', style: TextStyle(fontWeight: isCurrentState ? FontWeight.bold : FontWeight.normal))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: out ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              out ? '1 (HIGH)' : '0 (LOW)',
              style: TextStyle(
                color: out ? Colors.greenAccent : Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. BJT DC LOAD LINE & Q-POINT ANALYZER
// ─────────────────────────────────────────────────────────────────────────────
class BjtLoadLineLab extends StatefulWidget {
  const BjtLoadLineLab({super.key});

  @override
  State<BjtLoadLineLab> createState() => _BjtLoadLineLabState();
}

class _BjtLoadLineLabState extends State<BjtLoadLineLab> {
  double _vcc = 12.0; // V
  double _rc = 2.0; // kOhms
  double _rb = 100.0; // kOhms
  double _vbb = 3.0; // V
  double _beta = 100.0;
  final double _vbe = 0.7;

  double get ibMicroAmps => ((_vbb - _vbe) / (_rb * 1e3)) * 1e6;
  double get icTheoreticalMilliAmps => (_beta * ibMicroAmps) / 1000;
  double get icSatMilliAmps => _vcc / _rc;
  double get icMilliAmps => math.min(icTheoreticalMilliAmps, icSatMilliAmps);
  double get vceVolts => (_vcc - (icMilliAmps * _rc)).clamp(0.2, _vcc);

  String get region {
    if (_vbb < _vbe) return 'Cut-off (OFF)';
    if (vceVolts <= 0.3) return 'Saturation';
    return 'Active Region (Amplification)';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Load Line Canvas
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF070E17),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1B5E20), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CustomPaint(
                painter: BjtLoadLinePainter(
                  vcc: _vcc,
                  icSat: icSatMilliAmps,
                  vceQ: vceVolts,
                  icQ: icMilliAmps,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Q-Point Metrics Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _MetricTile(
                          title: 'Operating Region',
                          value: region,
                          highlight: true,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _MetricTile(
                          title: 'Vce (Q-Point)',
                          value: '${vceVolts.toStringAsFixed(2)} V',
                        ),
                      ),
                      Expanded(
                        child: _MetricTile(
                          title: 'Ic (Collector)',
                          value: '${icMilliAmps.toStringAsFixed(2)} mA',
                        ),
                      ),
                      Expanded(
                        child: _MetricTile(
                          title: 'Ib (Base)',
                          value: '${ibMicroAmps.toStringAsFixed(1)} μA',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Sliders
          _ControlSlider(
            label: 'Collector Supply (Vcc)',
            unit: 'V',
            value: _vcc,
            min: 5.0,
            max: 30.0,
            onChanged: (v) => setState(() => _vcc = v),
          ),
          _ControlSlider(
            label: 'Base Supply (Vbb)',
            unit: 'V',
            value: _vbb,
            min: 0.0,
            max: 10.0,
            onChanged: (v) => setState(() => _vbb = v),
          ),
          _ControlSlider(
            label: 'Collector Resistor (Rc)',
            unit: 'kΩ',
            value: _rc,
            min: 0.5,
            max: 10.0,
            onChanged: (v) => setState(() => _rc = v),
          ),
          _ControlSlider(
            label: 'Current Gain (β)',
            unit: '',
            value: _beta,
            min: 20.0,
            max: 300.0,
            onChanged: (v) => setState(() => _beta = v),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REUSABLE CUSTOM PAINTERS & WIDGETS
// ─────────────────────────────────────────────────────────────────────────────
class OscilloscopePainter extends CustomPainter {
  final double vinPeak;
  final double iPeak;
  final double phaseRad;
  final double freq;

  OscilloscopePainter({
    required this.vinPeak,
    required this.iPeak,
    required this.phaseRad,
    required this.freq,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Grid
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1;
    const step = 20.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Center axes
    final axisPaint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), axisPaint);

    final midY = size.height / 2;
    final vPath = Path();
    final iPath = Path();

    final vScale = size.height / 30.0;
    final iScale = size.height / 30.0;

    for (double x = 0; x < size.width; x += 1) {
      final t = (x / size.width) * 4 * math.pi;
      final vy = midY - (math.sin(t) * vinPeak * vScale * 0.5);
      final iy = midY - (math.sin(t - phaseRad) * iPeak * iScale * 0.5);

      if (x == 0) {
        vPath.moveTo(x, vy);
        iPath.moveTo(x, iy);
      } else {
        vPath.lineTo(x, vy);
        iPath.lineTo(x, iy);
      }
    }

    final vPaint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    final iPaint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(vPath, vPaint);
    canvas.drawPath(iPath, iPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class OpAmpWaveformPainter extends CustomPainter {
  final double vinPeak;
  final double gain;
  final double vSat;
  final bool isInverting;

  OpAmpWaveformPainter({
    required this.vinPeak,
    required this.gain,
    required this.vSat,
    required this.isInverting,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final midY = size.height / 2;

    // Grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final vinPath = Path();
    final voutPath = Path();
    final scale = (size.height / 2) / (vSat * 1.3);

    for (double x = 0; x < size.width; x += 1) {
      final t = (x / size.width) * 4 * math.pi;
      final vin = math.sin(t) * vinPeak;
      final rawVout = vin * gain;
      final voutClamped = rawVout.clamp(-vSat, vSat);

      final yIn = midY - (vin * scale);
      final yOut = midY - (voutClamped * scale);

      if (x == 0) {
        vinPath.moveTo(x, yIn);
        voutPath.moveTo(x, yOut);
      } else {
        vinPath.lineTo(x, yIn);
        voutPath.lineTo(x, yOut);
      }
    }

    final inPaint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final outPaint = Paint()
      ..color = (vinPeak * gain.abs() > vSat) ? Colors.redAccent : Colors.cyanAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(vinPath, inPaint);
    canvas.drawPath(voutPath, outPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BjtLoadLinePainter extends CustomPainter {
  final double vcc;
  final double icSat;
  final double vceQ;
  final double icQ;

  BjtLoadLinePainter({
    required this.vcc,
    required this.icSat,
    required this.vceQ,
    required this.icQ,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const pad = 30.0;
    final w = size.width - 2 * pad;
    final h = size.height - 2 * pad;

    // Axes
    final axisPaint = Paint()
      ..color = Colors.white60
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(pad, pad + h), Offset(pad + w + 10, pad + h), axisPaint); // X
    canvas.drawLine(Offset(pad, pad + h), Offset(pad, pad - 10), axisPaint); // Y

    // Load line from (0, icSat) to (vcc, 0)
    final pSat = Offset(pad, pad + 10);
    final pCutoff = Offset(pad + w, pad + h);

    final linePaint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 2.5;
    canvas.drawLine(pSat, pCutoff, linePaint);

    // Q Point coordinates
    final qX = pad + (vceQ / vcc) * w;
    final qY = (pad + h) - (icQ / icSat) * (h - 10);

    final qPaint = Paint()..color = Colors.cyanAccent;
    canvas.drawCircle(Offset(qX, qY), 6, qPaint);

    final glowPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(qX, qY), 10, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _MetricTile extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final bool highlight;

  const _MetricTile({
    required this.title,
    required this.value,
    this.subtitle,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: highlight ? const Color(0xFFFFD600) : null,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: GoogleFonts.inter(fontSize: 10, color: Colors.white60),
          ),
      ],
    );
  }
}

class _SignalLegend extends StatelessWidget {
  final Color color;
  final String label;
  const _SignalLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ControlSlider extends StatelessWidget {
  final String label;
  final String unit;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final List<Widget>? quickActions;

  const _ControlSlider({
    required this.label,
    required this.unit,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.quickActions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
            Row(
              children: [
                Text(
                  '${value.toStringAsFixed(1)} $unit',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFFFD600),
                  ),
                ),
                if (quickActions != null) ...quickActions!,
              ],
            ),
          ],
        ),
        Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          activeColor: const Color(0xFF1565C0),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _InputSwitch extends StatelessWidget {
  final String label;
  final bool val;
  final ValueChanged<bool> onToggle;

  const _InputSwitch({required this.label, required this.val, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: Colors.white70)),
        const SizedBox(height: 6),
        Switch(
          value: val,
          activeColor: Colors.greenAccent,
          onChanged: onToggle,
        ),
        Text(
          val ? '1 (HIGH)' : '0 (LOW)',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: val ? Colors.greenAccent : Colors.redAccent,
          ),
        ),
      ],
    );
  }
}

class _OutputIndicator extends StatelessWidget {
  final bool val;
  const _OutputIndicator({required this.val});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Output (Y)', style: GoogleFonts.inter(fontSize: 12, color: Colors.white70)),
        const SizedBox(height: 8),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: val ? Colors.greenAccent : Colors.black45,
            border: Border.all(
              color: val ? Colors.greenAccent : Colors.white24,
              width: 3,
            ),
            boxShadow: val
                ? [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.6),
                      blurRadius: 15,
                      spreadRadius: 3,
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              val ? '1' : '0',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: val ? Colors.black : Colors.white60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
