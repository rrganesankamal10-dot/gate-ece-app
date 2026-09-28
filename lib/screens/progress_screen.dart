import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/progress_provider.dart';
import '../data/topics_data.dart';
import '../data/questions_data.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  Color _hexToColor(String hex) =>
      Color(int.parse(hex.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 My Progress'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall progress
            _SectionTitle('Overall Progress'),
            const SizedBox(height: 12),
            _OverallCard(progress: progress),
            const SizedBox(height: 24),

            // XP & Streak
            _SectionTitle('Achievements'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _AchievementCard(
                    icon: '🔥',
                    title: 'Day Streak',
                    value: '${progress.streak}',
                    subtitle: 'days in a row',
                    color: const Color(0xFFE65100),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _AchievementCard(
                    icon: '⭐',
                    title: 'Total XP',
                    value: '${progress.totalXP}',
                    subtitle: 'experience points',
                    color: const Color(0xFF6A1B9A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Topic breakdown
            _SectionTitle('Topic Breakdown'),
            const SizedBox(height: 12),
            _TopicBreakdown(progress: progress),
            const SizedBox(height: 24),

            // Mock test results
            _SectionTitle('Mock Test Scores'),
            const SizedBox(height: 12),
            if (progress.mockResults.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('🎯', style: TextStyle(fontSize: 36)),
                        const SizedBox(height: 8),
                        Text(
                          'No mock tests taken yet.\nHead to Mock Tests to start!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: colorScheme.onSurface.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ...mockTests
                  .where((mt) => progress.mockResults.containsKey(mt.id))
                  .map((mt) {
                final score = progress.getMockScore(mt.id);
                final total = mt.questionIds.length;
                final pct = score / total;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 30,
                          lineWidth: 5,
                          percent: pct.clamp(0.0, 1.0),
                          center: Text('${(pct * 100).toInt()}%',
                              style: GoogleFonts.inter(
                                  fontSize: 10, fontWeight: FontWeight.w700)),
                          progressColor: pct >= 0.7
                              ? Colors.green
                              : pct >= 0.4
                                  ? Colors.orange
                                  : Colors.red,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mt.title,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 3),
                              Text('$score / $total correct',
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: colorScheme.onSurface
                                          .withOpacity(0.55))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

            const SizedBox(height: 24),

            // Bookmarks count
            _SectionTitle('Bookmarked Formulas'),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Text('🔖', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Text(
                      '${progress.bookmarkedFormulas.length} formulas bookmarked',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }
}

class _OverallCard extends StatelessWidget {
  final ProgressProvider progress;
  const _OverallCard({required this.progress});

  @override
  Widget build(BuildContext context) {
    final pct = progress.overallPercent;
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
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 55,
            lineWidth: 8,
            percent: pct,
            center: Text(
              '${(pct * 100).toInt()}%',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 18),
            ),
            progressColor: const Color(0xFFFFD600),
            backgroundColor: Colors.white24,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Overall Syllabus',
                    style: GoogleFonts.inter(
                        color: Colors.white70, fontSize: 13)),
                Text('${(pct * 100).toInt()}% Complete',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
                const SizedBox(height: 8),
                LinearPercentIndicator(
                  percent: pct,
                  lineHeight: 6,
                  backgroundColor: Colors.white24,
                  progressColor: const Color(0xFFFFD600),
                  barRadius: const Radius.circular(10),
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 6),
                Text('${gateTopics.length} topics · ${gateQuestions.length} questions',
                    style:
                        GoogleFonts.inter(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final String icon, title, value, subtitle;
  final Color color;
  const _AchievementCard(
      {required this.icon,
      required this.title,
      required this.value,
      required this.subtitle,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 6),
          Text(value,
              style: GoogleFonts.inter(
                  fontSize: 28, fontWeight: FontWeight.w900, color: color)),
          Text(subtitle,
              style: GoogleFonts.inter(
                  fontSize: 11,
                  color: color.withOpacity(0.7))),
        ],
      ),
    );
  }
}

class _TopicBreakdown extends StatelessWidget {
  final ProgressProvider progress;
  const _TopicBreakdown({required this.progress});

  Color _hexToColor(String hex) =>
      Color(int.parse(hex.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: gateTopics.map((t) {
            final pct = progress.getTopicPercent(t.id);
            final color = _hexToColor(t.color);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(t.icon, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(t.name.split(' ').first,
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            Text('${(pct * 100).toInt()}%',
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: color,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        LinearPercentIndicator(
                          percent: pct,
                          lineHeight: 6,
                          backgroundColor: color.withOpacity(0.12),
                          progressColor: color,
                          barRadius: const Radius.circular(10),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
