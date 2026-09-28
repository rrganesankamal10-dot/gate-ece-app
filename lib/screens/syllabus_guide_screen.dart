import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SyllabusGuideScreen extends StatelessWidget {
  const SyllabusGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 GATE ECE Exam Strategy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exam Pattern Banner
            _buildPatternCard(),
            const SizedBox(height: 20),

            // Subject-wise Mark Distribution
            _sectionHeader('Subject-wise Weightage (Last 10 Years Avg)'),
            const SizedBox(height: 12),
            _buildWeightageTable(),
            const SizedBox(height: 24),

            // High Yield Topics Checklist
            _sectionHeader('🔥 High-Yield "Must-Do" Topics'),
            const SizedBox(height: 12),
            _buildHighYieldCard(),
            const SizedBox(height: 24),

            // Study Planners
            _sectionHeader('📅 Preparation Roadmaps'),
            const SizedBox(height: 12),
            _buildRoadmaps(),
            const SizedBox(height: 24),

            // Golden Rules for AIR < 100
            _sectionHeader('🏆 Golden Rules for Top Rank by Kamal'),
            const SizedBox(height: 12),
            _buildGoldenRulesCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800),
    );
  }

  Widget _buildPatternCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GATE ECE Exam Pattern',
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
              ),
              const Icon(Icons.verified, color: Color(0xFFFFD600)),
            ],
          ),
          const SizedBox(height: 12),
          _patternRow('Total Marks', '100 Marks (65 Questions)'),
          _patternRow('Exam Duration', '3 Hours (180 Minutes)'),
          _patternRow('General Aptitude', '15 Marks (10 Questions)'),
          _patternRow('Engg. Mathematics', '13 Marks (~8 Questions)'),
          _patternRow('Core Technical ECE', '72 Marks (~47 Questions)'),
          _patternRow('Question Types', 'MCQ, MSQ (Multiple Select), NAT (Numerical)'),
          _patternRow('Negative Marking', '1/3rd for 1-mark MCQ, 2/3rd for 2-mark MCQ. (No negative for NAT & MSQ)'),
        ],
      ),
    );
  }

  Widget _patternRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• $label: ', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFFFFD600), fontSize: 13)),
          Expanded(child: Text(val, style: GoogleFonts.inter(color: Colors.white, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildWeightageTable() {
    final list = [
      {'sub': 'General Aptitude', 'marks': '15 Marks', 'pct': '15%', 'diff': 'Easy-Med'},
      {'sub': 'Engineering Mathematics', 'marks': '13 Marks', 'pct': '13%', 'diff': 'Medium'},
      {'sub': 'Communications', 'marks': '11 - 13 Marks', 'pct': '12%', 'diff': 'Hard'},
      {'sub': 'Analog Circuits', 'marks': '9 - 11 Marks', 'pct': '10%', 'diff': 'Medium-Hard'},
      {'sub': 'Signals & Systems', 'marks': '8 - 10 Marks', 'pct': '9%', 'diff': 'Medium'},
      {'sub': 'Electronic Devices (EDC)', 'marks': '8 - 10 Marks', 'pct': '9%', 'diff': 'Hard'},
      {'sub': 'Control Systems', 'marks': '8 - 10 Marks', 'pct': '9%', 'diff': 'Easy-Med'},
      {'sub': 'Networks & Circuits', 'marks': '7 - 9 Marks', 'pct': '8%', 'diff': 'Easy'},
      {'sub': 'Digital Circuits', 'marks': '7 - 9 Marks', 'pct': '8%', 'diff': 'Easy'},
      {'sub': 'Electromagnetics (EMT)', 'marks': '7 - 9 Marks', 'pct': '8%', 'diff': 'Hard'},
    ];

    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DataTable(
          columnSpacing: 16,
          headingRowColor: MaterialStateProperty.all(const Color(0xFF1565C0).withOpacity(0.15)),
          columns: const [
            DataColumn(label: Text('Subject')),
            DataColumn(label: Text('Weightage')),
            DataColumn(label: Text('Difficulty')),
          ],
          rows: list.map((item) {
            final isHigh = item['sub'] == 'General Aptitude' || item['sub'] == 'Engineering Mathematics';
            return DataRow(
              cells: [
                DataCell(Text(item['sub']!, style: GoogleFonts.inter(fontWeight: isHigh ? FontWeight.bold : FontWeight.w500, fontSize: 13))),
                DataCell(Text(item['marks']!, style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFFFFD600), fontSize: 12))),
                DataCell(Text(item['diff']!, style: GoogleFonts.inter(fontSize: 12))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHighYieldCard() {
    final topics = [
      '⚡ Networks: Thevenin / Norton theorems, Maximum Power, Transient RC/RL, 2-Port Z/Y/h parameters',
      '📊 Signals: Nyquist sampling, Z-transform ROC, Convolution, Fourier Transform duality & properties',
      '💡 EDC: MOSFET saturation equation, P-N junction capacitance, BJT current relations, Built-in potential',
      '🔊 Analog: Op-Amp inverting/non-inverting/differential, BJT small-signal gm/rπ, Feedback amplifiers',
      '🔢 Digital: Flip-Flop setup/hold time, Synchronous & Asynchronous counters, K-Maps, MUX expansion',
      '🎛️ Control: Routh-Hurwitz stability, Bode phase & gain margin, Root locus breakaway points, State space',
      '📡 Comms: Shannon capacity, Carson\'s FM rule, PCM quantization noise, BPSK/QPSK constellation distance',
      '🌊 EMT: VSWR & Reflection coefficient, Maxwell equations, Skin depth, Waveguide cutoff frequency',
      '📐 Maths: Eigenvalues & eigenvectors, Cauchy residue theorem, Maxima/minima, Normal distribution',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: topics.map((t) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.greenAccent, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(t, style: GoogleFonts.inter(fontSize: 13, height: 1.4)),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRoadmaps() {
    return Column(
      children: [
        _roadmapTile(
          title: '60-Day Crash Revision Plan',
          subtitle: 'Daily 4-6 hours structured preparation',
          details: '• Days 1-15: Networks + Signals + Digital (High scoring, easiest to complete)\n'
              '• Days 16-30: Control Systems + Analog Circuits + Mathematics\n'
              '• Days 31-45: EDC + Communications + Electromagnetics\n'
              '• Days 46-60: Full-length Mock Tests daily + Virtual Calculator practice + Formula Revision',
        ),
        const SizedBox(height: 10),
        _roadmapTile(
          title: '30-Day Final Sprint Plan',
          subtitle: 'Daily 8-10 hours intense PYQ & Mock test grind',
          details: '• Morning (3 hrs): Solve 1 Full Mock Test on computer with virtual calculator\n'
              '• Afternoon (2.5 hrs): In-depth error analysis of wrong & skipped questions\n'
              '• Evening (2.5 hrs): Formula flashcards revision + High-yield topics brush up\n'
              '• Night (1 hr): General Aptitude + Engg Math quick practice',
        ),
      ],
    );
  }

  Widget _roadmapTile({required String title, required String subtitle, required String details}) {
    return Card(
      child: ExpansionTile(
        title: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
        subtitle: Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(details, style: GoogleFonts.inter(fontSize: 13, height: 1.6)),
          ),
        ],
      ),
    );
  }

  Widget _buildGoldenRulesCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF162032),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFD600), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ruleItem('1. Never ignore General Aptitude & Mathematics', 'Together they carry 28 marks! Scoring 25+ here guarantees an interview call in top PSUs & IISc/IITs.'),
          _ruleItem('2. Master the Virtual Calculator Early', 'Do NOT use physical calculators. Practice finding powers, inverse trig, and natural logs on the app\'s virtual calculator.'),
          _ruleItem('3. Avoid Negative Marking in MCQs', 'NAT (Numerical) and MSQ questions have NO negative marking. Attempt all of them with calculated logic.'),
          _ruleItem('4. Maintain a Formula Error Diary', 'Note down every tricky trap question you get wrong in our Mock Tests and review it every Sunday.'),
        ],
      ),
    );
  }

  Widget _ruleItem(String header, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: const Color(0xFFFFD600), fontSize: 13)),
          const SizedBox(height: 2),
          Text(desc, style: GoogleFonts.inter(fontSize: 12, color: Colors.white70, height: 1.4)),
        ],
      ),
    );
  }
}
