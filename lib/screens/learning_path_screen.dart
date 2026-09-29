// lib/screens/learning_path_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../data/topics_data.dart';
import '../providers/progress_provider.dart';
import 'chapter_module_screen.dart';

class LearningPathScreen extends StatefulWidget {
  const LearningPathScreen({super.key});

  @override
  State<LearningPathScreen> createState() => _LearningPathScreenState();
}

class _LearningPathScreenState extends State<LearningPathScreen> {
  late ConfettiController _confettiController;

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
    final overall = progress.overallPercent;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Path ⚡',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              'Overall: ${(overall * 100).toInt()}% complete',
              style: GoogleFonts.inter(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1565C0),
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
            colors: const [Colors.amber, Colors.green, Colors.blue, Colors.pink, Color(0xFFFFD600)],
          ),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _OverallProgressCard(overall: overall),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _PathNode(
                      topic: gateTopics[i],
                      index: i,
                      isLast: i == gateTopics.length - 1,
                      progress: progress,
                      confettiController: _confettiController,
                    ),
                    childCount: gateTopics.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Overall progress card ────────────────────────────────────────────────────
class _OverallProgressCard extends StatelessWidget {
  final double overall;
  const _OverallProgressCard({required this.overall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${gateTopics.length} Subjects to Master',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Complete all modules to unlock mastery badges and chapter quizzes.',
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: CircularProgressIndicator(
                  value: overall,
                  strokeWidth: 6,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD600)),
                ),
              ),
              Text(
                '${(overall * 100).toInt()}%',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Path Node ────────────────────────────────────────────────────────────────
class _PathNode extends StatelessWidget {
  final dynamic topic;
  final int index;
  final bool isLast;
  final ProgressProvider progress;
  final ConfettiController confettiController;

  const _PathNode({
    required this.topic,
    required this.index,
    required this.isLast,
    required this.progress,
    required this.confettiController,
  });

  Color get _topicColor {
    try {
      return Color(int.parse(topic.color.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF1565C0);
    }
  }

  double get _pct {
    final total = topic.subtopics.length;
    if (total == 0) return 0.0;
    return (progress.completedModules(topic.id) / total).clamp(0.0, 1.0);
  }

  bool get _isFullyComplete => progress.isTopicFullyComplete(topic.id);

  @override
  Widget build(BuildContext context) {
    final pct = _pct;
    final color = _topicColor;
    final isActive = pct > 0;

    // Alternate left and right with offset for path effect
    final isLeft = index % 2 == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLeft) ...[
            _NodeCircle(
              topic: topic,
              pct: pct,
              color: color,
              isActive: isActive,
              isComplete: _isFullyComplete,
              onTap: () => _openTopic(context),
            ),
            const SizedBox(width: 16),
            Expanded(child: _NodeLabel(topic: topic, color: color, pct: pct, isLeft: true)),
          ] else ...[
            Expanded(child: _NodeLabel(topic: topic, color: color, pct: pct, isLeft: false)),
            const SizedBox(width: 16),
            _NodeCircle(
              topic: topic,
              pct: pct,
              color: color,
              isActive: isActive,
              isComplete: _isFullyComplete,
              onTap: () => _openTopic(context),
            ),
          ],
        ],
      ),
    );
  }

  void _openTopic(BuildContext context) {
    if (_isFullyComplete) confettiController.play();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChapterModuleScreen(topic: topic),
      ),
    );
  }
}

// ─── Node Circle ─────────────────────────────────────────────────────────────
class _NodeCircle extends StatelessWidget {
  final dynamic topic;
  final double pct;
  final Color color;
  final bool isActive;
  final bool isComplete;
  final VoidCallback onTap;

  const _NodeCircle({
    required this.topic,
    required this.pct,
    required this.color,
    required this.isActive,
    required this.isComplete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow effect for active topics
                if (isActive && !isComplete)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.35),
                          blurRadius: 16,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                // Progress ring
                SizedBox(
                  width: 76,
                  height: 76,
                  child: CircularProgressIndicator(
                    value: pct,
                    strokeWidth: 5,
                    backgroundColor: color.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation(
                      isComplete ? const Color(0xFFFFD600) : color,
                    ),
                  ),
                ),
                // Inner circle
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive
                        ? (isComplete ? const Color(0xFFFFD600).withOpacity(0.15) : color.withOpacity(0.12))
                        : Colors.grey.withOpacity(0.08),
                    border: Border.all(
                      color: isActive
                          ? (isComplete ? const Color(0xFFFFD600) : color)
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isComplete ? '👑' : topic.icon,
                      style: TextStyle(fontSize: isComplete ? 24 : 28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Dotted line connector (not for last node)
        _DottedLine(color: color, isActive: isActive),
      ],
    );
  }
}

// ─── Dotted connector ────────────────────────────────────────────────────────
class _DottedLine extends StatelessWidget {
  final Color color;
  final bool isActive;

  const _DottedLine({required this.color, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(4, 40),
      painter: _DottedLinePainter(
        color: isActive ? color : Colors.grey.shade300,
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  _DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const dotHeight = 4.0;
    const gapHeight = 6.0;
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, min(y + dotHeight, size.height)),
        paint,
      );
      y += dotHeight + gapHeight;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter old) => old.color != color;
}

// ─── Node Label ──────────────────────────────────────────────────────────────
class _NodeLabel extends StatelessWidget {
  final dynamic topic;
  final Color color;
  final double pct;
  final bool isLeft;

  const _NodeLabel({
    required this.topic,
    required this.color,
    required this.pct,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            topic.name,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: pct > 0 ? color : colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: isLeft ? TextAlign.left : TextAlign.right,
          ),
          const SizedBox(height: 4),
          Text(
            '${(pct * 100).toInt()}%',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: pct > 0 ? color : Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            topic.subtitle,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: colorScheme.onSurface.withOpacity(0.45),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: isLeft ? TextAlign.left : TextAlign.right,
          ),
        ],
      ),
    );
  }
}
