// lib/screens/score_guide_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

// ─── Data ─────────────────────────────────────────────────────────────────────
class _SubjectMarks {
  final String subject;
  final int marks;
  final Color color;
  const _SubjectMarks({required this.subject, required this.marks, required this.color});
}

const List<_SubjectMarks> _subjectData = [
  _SubjectMarks(subject: 'Networks', marks: 11, color: Color(0xFF1565C0)),
  _SubjectMarks(subject: 'Signals', marks: 9, color: Color(0xFF6A1B9A)),
  _SubjectMarks(subject: 'Devices', marks: 8, color: Color(0xFF1B5E20)),
  _SubjectMarks(subject: 'Analog', marks: 10, color: Color(0xFFE65100)),
  _SubjectMarks(subject: 'Digital', marks: 9, color: Color(0xFF880E4F)),
  _SubjectMarks(subject: 'Control', marks: 8, color: Color(0xFF004D40)),
  _SubjectMarks(subject: 'Comms', marks: 11, color: Color(0xFFBF360C)),
  _SubjectMarks(subject: 'EM', marks: 10, color: Color(0xFF01579B)),
  _SubjectMarks(subject: 'Maths', marks: 15, color: Color(0xFF37474F)),
  _SubjectMarks(subject: 'Aptitude', marks: 9, color: Color(0xFF4E342E)),
];

class _HighYieldTopic {
  final String topic;
  final String marks;
  final bool mustStudy;
  final String reason;
  const _HighYieldTopic({
    required this.topic,
    required this.marks,
    required this.mustStudy,
    required this.reason,
  });
}

const List<_HighYieldTopic> _highYield = [
  _HighYieldTopic(topic: 'Engineering Mathematics', marks: '13–17 marks', mustStudy: true, reason: 'Appears in almost every GATE paper. Covers Linear Algebra, Probability, Calculus.'),
  _HighYieldTopic(topic: 'Networks & Circuits', marks: '9–13 marks', mustStudy: true, reason: 'Foundation subject. Thevenin, KVL, Two-port, Resonance — high ROI.'),
  _HighYieldTopic(topic: 'Communications', marks: '9–13 marks', mustStudy: true, reason: 'AM/FM, digital modulation, Shannon, matched filter — scoring topic.'),
  _HighYieldTopic(topic: 'Analog Circuits', marks: '8–12 marks', mustStudy: true, reason: 'Op-amp, amplifiers, feedback — conceptual but high-scoring.'),
  _HighYieldTopic(topic: 'Digital Circuits', marks: '7–10 marks', mustStudy: true, reason: 'Sequential/combinational logic — straightforward scoring.'),
  _HighYieldTopic(topic: 'Signals & Systems', marks: '7–11 marks', mustStudy: true, reason: 'Transforms and LTI — integral to Communications and Control.'),
  _HighYieldTopic(topic: 'Control Systems', marks: '6–9 marks', mustStudy: false, reason: 'Bode, Routh-Hurwitz, Root Locus — moderate difficulty.'),
  _HighYieldTopic(topic: 'Electromagnetics', marks: '6–11 marks', mustStudy: false, reason: 'Maxwell\'s equations, transmission lines, antennas — theory-heavy.'),
  _HighYieldTopic(topic: 'Electronic Devices', marks: '6–9 marks', mustStudy: false, reason: 'BJT, MOSFET, diodes — essential for Analog Circuits understanding.'),
];

class _TimeBlock {
  final String period;
  final String activity;
  final String hours;
  const _TimeBlock({required this.period, required this.activity, required this.hours});
}

const List<_TimeBlock> _timeStrategy = [
  _TimeBlock(period: 'Months 1–3', activity: 'Build Fundamentals: Complete all subject modules. Focus on Mathematics, Networks, Signals.', hours: '6–8 hrs/day'),
  _TimeBlock(period: 'Months 4–5', activity: 'Practice & Formula Revision: Solve 20+ questions daily per topic. Revise formulas every week.', hours: '7–9 hrs/day'),
  _TimeBlock(period: 'Month 6', activity: 'Previous Year Papers: Solve GATE papers 2015–2023 under timed conditions. Identify weak areas.', hours: '8–10 hrs/day'),
  _TimeBlock(period: 'Last 2 Weeks', activity: 'Rapid Revision: Only formulas, important derivations, and most common question types. No new topics.', hours: '6 hrs/day'),
  _TimeBlock(period: 'Last 3 Days', activity: 'Light Revision: Skim formula sheet, rest well, check logistics. No heavy studying.', hours: '3–4 hrs/day'),
];

const List<String> _examDayTips = [
  'Attempt all questions you know with confidence first, then return to uncertain ones.',
  'For 2-mark NAT (Numerical Answer Type) questions, compute carefully — no negative marking.',
  'For MCQs you are unsure about: attempt only if you can eliminate at least 2 options.',
  'Use the GATE virtual calculator efficiently — practice with it during preparation.',
  'Keep track of time: budget approximately 90 seconds per 1-mark and 3 minutes per 2-mark question.',
  'Do not change confident answers. First instinct is usually correct for well-prepared candidates.',
  'Mark difficult questions for review and move on — don\'t get stuck on any single question.',
  'During the last 15 minutes, review marked questions and ensure all confident ones are answered.',
];

const List<String> _commonMistakes = [
  'Spending too long on a single difficult question — losing time for easier ones.',
  'Attempting MCQs with wild guesses — negative marking can significantly reduce score.',
  'Not reading the question carefully — many errors come from misunderstanding what\'s asked.',
  'Skipping Engineering Mathematics — it contributes 13–17 marks and is highly predictable.',
  'Ignoring General Aptitude — these 10 marks are the easiest scoring opportunity.',
  'Not practicing previous year papers — GATE repeats concepts and question patterns frequently.',
  'Poor time management — not finishing the paper due to spending excess time on hard problems.',
  'Neglecting units in numerical answers — GATE often tests dimensional analysis.',
];

// ─── SCORE GUIDE SCREEN ──────────────────────────────────────────────────────
class ScoreGuideScreen extends StatelessWidget {
  const ScoreGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Hero Header ──────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: const Color(0xFF1B5E20),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'How to Score 60+ in GATE ECE',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Strategic preparation guide by subject experts',
                      style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Marks Distribution Chart ─────────────────────────────
                _SectionHeader(title: 'Topic-wise Marks Distribution', icon: Icons.bar_chart),
                const SizedBox(height: 12),
                _MarksBarChart(data: _subjectData),
                const SizedBox(height: 8),
                Text(
                  'Total marks: 100  |  Questions: 65  |  Duration: 3 hours',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                // ── High-Yield Topics ─────────────────────────────────────
                _SectionHeader(title: 'High-Yield Topics', icon: Icons.trending_up),
                const SizedBox(height: 12),
                ..._highYield.map((t) => _HighYieldCard(topic: t)),
                const SizedBox(height: 28),

                // ── Time Strategy ─────────────────────────────────────────
                _SectionHeader(title: 'Study Time Strategy', icon: Icons.schedule),
                const SizedBox(height: 12),
                ..._timeStrategy.asMap().entries.map(
                  (e) => _TimelineCard(block: e.value, index: e.key, total: _timeStrategy.length),
                ),
                const SizedBox(height: 28),

                // ── Exam Day Tips ─────────────────────────────────────────
                _SectionHeader(title: 'Exam Day Strategy', icon: Icons.fact_check),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: colorScheme.outline.withOpacity(0.15)),
                  ),
                  child: Column(
                    children: _examDayTips.asMap().entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B5E20).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${e.key + 1}',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1B5E20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                e.value,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  height: 1.5,
                                  color: colorScheme.onSurface.withOpacity(0.85),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Common Mistakes ───────────────────────────────────────
                _SectionHeader(title: 'Common Mistakes to Avoid', icon: Icons.warning_amber),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.red.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: _commonMistakes.map((m) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.redAccent, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              m,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                height: 1.5,
                                color: colorScheme.onSurface.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1B5E20), size: 20),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

// ─── Marks Bar Chart ─────────────────────────────────────────────────────────
class _MarksBarChart extends StatelessWidget {
  final List<_SubjectMarks> data;
  const _MarksBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final maxMarks = data.map((d) => d.marks).reduce((a, b) => a > b ? a : b).toDouble();

    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.15),
        ),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxMarks + 3,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, _, rod, __) {
                return BarTooltipItem(
                  '${data[group.x].marks} marks',
                  GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, _) => Text(
                  value.toInt().toString(),
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.grey),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= data.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      data[i].subject,
                      style: GoogleFonts.inter(fontSize: 8.5, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (_) => FlLine(
              color: Colors.grey.withOpacity(0.15),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: data.asMap().entries.map((e) {
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: e.value.marks.toDouble(),
                  color: e.value.color,
                  width: 18,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─── High-Yield Card ──────────────────────────────────────────────────────────
class _HighYieldCard extends StatelessWidget {
  final _HighYieldTopic topic;
  const _HighYieldCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: topic.mustStudy
              ? const Color(0xFF1B5E20).withOpacity(0.25)
              : colorScheme.outline.withOpacity(0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        topic.topic,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (topic.mustStudy) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B5E20),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Must Study',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  topic.marks,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1B5E20),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  topic.reason,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.6),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Timeline Card ────────────────────────────────────────────────────────────
class _TimelineCard extends StatelessWidget {
  final _TimeBlock block;
  final int index;
  final int total;
  const _TimelineCard({required this.block, required this.index, required this.total});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = [
      const Color(0xFF1565C0),
      const Color(0xFF6A1B9A),
      const Color(0xFF1B5E20),
      const Color(0xFFE65100),
      const Color(0xFF880E4F),
    ];
    final color = colors[index % colors.length];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 6)],
                ),
              ),
              if (index < total - 1)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color.withOpacity(0.25),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        block.period,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: color,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          block.hours,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    block.activity,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.5,
                      color: colorScheme.onSurface.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
