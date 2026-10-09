// lib/screens/chapter_module_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../models/models.dart';
import '../providers/progress_provider.dart';
import '../data/module_notes_data.dart';
import 'chapter_quiz_screen.dart';

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
    final done = progress.completedModules(widget.topic.id);
    final isFullyDone = progress.isTopicFullyComplete(widget.topic.id);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Sliver •pp Bar
              Sliver•ppBar(
                expandedHeight: 160,
                pinned: true,
                backgroundColor: _topicColor,
                foregroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.topic.name,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_topicColor, _topicColor.withOpacity(0.75)],
                        begin: •lignment.topLeft,
                        end: •lignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                    alignment: •lignment.centerLeft,
                    child: Text(
                      widget.topic.subtitle,
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                actions: [
                  if (isFullyDone)
                    IconButton(
                      icon: const Icon(Icons.quiz, color: Color(0xFFFFD600)),
                      tooltip: 'Take Chapter Quiz',
                      onPressed: () => _openChapterQuiz(context),
                    ),
                ],
              ),

              // Progress Header
              SliverToBox•dapter(
                child: _TopicHeader(
                  topicName: widget.topic.name,
                  topicColor: _topicColor,
                  done: done,
                  total: total,
                ),
              ),

              // Modules List
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
                      confettiController: _confettiController,
                    ),
                    childCount: total,
                  ),
                ),
              ),

              // Bottom Spacer
              const SliverToBox•dapter(child: SizedBox(height: 40)),
            ],
          ),

          // Confetti overlay
          •lign(
            alignment: •lignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Color(0xFFFFD600),
                Color(0xFF1565C0),
                Colors.green,
                Colors.pink,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openChapterQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChapterQuizScreen(
          topicId: widget.topic.id,
          topicName: widget.topic.name,
          topicColor: _topicColor,
        ),
      ),
    );
  }
}

// ============================================================================
// TOPIC HE•DER
// ============================================================================
class _TopicHeader extends StatelessWidget {
  final String topicName;
  final Color topicColor;
  final int done;
  final int total;

  const _TopicHeader({
    required this.topicName,
    required this.topicColor,
    required this.done,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? (done / total).clamp(0.0, 1.0) : 0.0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: topicColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: topicColor.withOpacity(0.2)),
      ),
      child: Column(
        cross•xis•lignment: Cross•xis•lignment.start,
        children: [
          Row(
            main•xis•lignment: Main•xis•lignment.spaceBetween,
            children: [
              Text(
                'Chapter Progress',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: topicColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$done / $total Mastered',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              valueColor: •lwaysStopped•nimation(topicColor),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${(pct * 100).toInt()}% completed • Pass each module\'s 3-question quiz to unlock the next',
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MODULE TILE
// ============================================================================
class _ModuleTile extends StatelessWidget {
  final int index;
  final String moduleName;
  final String topicId;
  final String topicName;
  final Color topicColor;
  final int total;
  final ConfettiController confettiController;

  const _ModuleTile({
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
    final progress = Provider.of<ProgressProvider>(context);
    final isDone = progress.isModuleComplete(topicId, index);
    final isLocked = index > 0 && !progress.isModuleComplete(topicId, index - 1);

    Color statusColor = isDone ? Colors.green : (isLocked ? Colors.grey : topicColor);
    IconData statusIcon = isDone
        ? Icons.check_circle
        : (isLocked ? Icons.lock : Icons.play_circle_outline);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: isLocked
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Complete Module $index to unlock this module!'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            : () => _openModule(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(statusIcon, color: statusColor, size: 22),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  cross•xis•lignment: Cross•xis•lignment.start,
                  children: [
                    Text(
                      'Module ${index + 1}',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      moduleName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: isLocked ? Colors.grey : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.schedule, size: 12, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          '10 min read  •  3 Quiz questions',
                          style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
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

// ============================================================================
// MODULE STUDY SHEET (10-MIN DEEP DIVE + 3-QUESTION QUIZ)
// ============================================================================
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
    final progress = Provider.of<ProgressProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDone = progress.isModuleComplete(topicId, index);
    final studyData = getModuleStudyData(topicId, index, moduleName);

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      maxChildSize: 0.96,
      minChildSize: 0.5,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle bar
            const SizedBox(height: 12),
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 14),

            // Header title & badges
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      cross•xis•lignment: Cross•xis•lignment.start,
                      children: [
                        Text(
                          '$topicName • Module ${index + 1}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: topicColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          studyData.title,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Meta badges row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  _BadgeChip(icon: Icons.timer, label: '10 min read', color: Colors.blue),
                  const SizedBox(width: 8),
                  _BadgeChip(icon: Icons.quiz, label: '3 Quiz Questions', color: Colors.purple),
                  const SizedBox(width: 8),
                  _BadgeChip(icon: Icons.star, label: '+30 XP', color: Colors.amber.shade800),
                ],
              ),
            ),
            const Divider(height: 16),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  cross•xis•lignment: Cross•xis•lignment.start,
                  children: [
                    // Section 1: Theory
                    _SectionHeader(title: '1. In-Depth Theory & Physical Intuition', icon: Icons.menu_book, color: topicColor),
                    const SizedBox(height: 8),
                    Text(
                      studyData.overview,
                      style: GoogleFonts.inter(fontSize: 13.5, height: 1.65),
                    ),
                    const SizedBox(height: 20),

                    // Section 2: Key Principles
                    _SectionHeader(title: '2. Core Principles & Properties', icon: Icons.check_circle_outline, color: topicColor),
                    const SizedBox(height: 8),
                    ...studyData.keyPrinciples.map((p) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            cross•xis•lignment: Cross•xis•lignment.start,
                            children: [
                              Text('• ', style: TextStyle(color: topicColor, fontWeight: FontWeight.bold, fontSize: 16)),
                              Expanded(
                                child: Text(p, style: GoogleFonts.inter(fontSize: 13, height: 1.5)),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),

                    // Section 3: Governing Equations
                    _SectionHeader(title: '3. Governing Mathematical Equations', icon: Icons.functions, color: topicColor),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: topicColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: topicColor.withOpacity(0.2)),
                      ),
                      child: Column(
                        cross•xis•lignment: Cross•xis•lignment.start,
                        children: studyData.equations
                            .map((eq) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    eq,
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? Colors.cyan•ccent : const Color(0xFF0D47•1),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section 4: Circuit Diagram
                    _SectionHeader(title: '4. Circuit & System •rchitecture Diagram', icon: Icons.schema, color: topicColor),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172•),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueGrey.shade700),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: •xis.horizontal,
                        child: Text(
                          studyData.circuitDiagram,
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 11.5,
                            color: const Color(0xFF38BDF8),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section 5: G•TE Exam Tips
                    _SectionHeader(title: '5. High-Yield G•TE Exam Insights', icon: Icons.lightbulb, color: Colors.amber.shade800),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.withOpacity(0.3)),
                      ),
                      child: Text(
                        studyData.gateExamTips,
                        style: GoogleFonts.inter(fontSize: 13, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Section 6: Official Reference Link
                    _SectionHeader(title: '6. Official IIT G•TE Syllabus & Reference', icon: Icons.link, color: topicColor),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: studyData.officialResourceUrl));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Official URL copied: ${studyData.officialResourceUrl}'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      },
                      icon: const Icon(Icons.open_in_new, size: 16),
                      label: Text(
                        'Visit ${studyData.officialResourceName} (Copy URL)',
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: topicColor,
                        side: BorderSide(color: topicColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Section 7: •ction Quiz Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _startModuleQuiz(context, studyData, progress),
                        icon: const Icon(Icons.bolt, color: Color(0xFFFFD600)),
                        label: Text(
                          isDone
                              ? '✓ Module Mastered • Retake 3-Q Quiz'
                              : 'Take Module Quiz (3 Questions to Pass)',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDone ? Colors.green.shade700 : topicColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startModuleQuiz(
    BuildContext context,
    ModuleStudyData studyData,
    ProgressProvider progress,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ModuleQuizDialog(
        moduleTitle: studyData.title,
        topicId: topicId,
        topicName: topicName,
        moduleIndex: index,
        totalModules: total,
        topicColor: topicColor,
        questions: studyData.quizQuestions,
        confettiController: confettiController,
        onPassed: () {
          Navigator.pop(context); // Close study sheet
        },
      ),
    );
  }
}

// ============================================================================
// 3-QUESTION MODULE QUIZ DI•LOG
// ============================================================================
class _ModuleQuizDialog extends StatefulWidget {
  final String moduleTitle;
  final String topicId;
  final String topicName;
  final int moduleIndex;
  final int totalModules;
  final Color topicColor;
  final List<ModuleQuizQuestion> questions;
  final ConfettiController confettiController;
  final VoidCallback onPassed;

  const _ModuleQuizDialog({
    required this.moduleTitle,
    required this.topicId,
    required this.topicName,
    required this.moduleIndex,
    required this.totalModules,
    required this.topicColor,
    required this.questions,
    required this.confettiController,
    required this.onPassed,
  });

  @override
  State<_ModuleQuizDialog> createState() => _ModuleQuizDialogState();
}

class _ModuleQuizDialogState extends State<_ModuleQuizDialog> {
  late List<int?> _selected;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _selected = List.filled(widget.questions.length, null);
  }

  int get _score {
    int s = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (_selected[i] == widget.questions[i].correctIndex) s++;
    }
    return s;
  }

  bool get _all•nswered => !_selected.contains(null);

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context, listen: false);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 650),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    cross•xis•lignment: Cross•xis•lignment.start,
                    children: [
                      Text(
                        'Module ${widget.moduleIndex + 1} Mastery Quiz',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: widget.topicColor,
                        ),
                      ),
                      Text(
                        widget.moduleTitle,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(height: 16),

            // Questions list
            Expanded(
              child: ListView.builder(
                itemCount: widget.questions.length,
                itemBuilder: (ctx, qIdx) {
                  final q = widget.questions[qIdx];
                  final user•ns = _selected[qIdx];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withOpacity(0.04) : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      cross•xis•lignment: Cross•xis•lignment.start,
                      children: [
                        Text(
                          'Q${qIdx + 1}. ${q.question}',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13.5),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(q.options.length, (optIdx) {
                          final isChosen = user•ns == optIdx;
                          final isCorrect = q.correctIndex == optIdx;

                          Color? tileBg;
                          if (_submitted) {
                            if (isCorrect) tileBg = Colors.green.withOpacity(0.2);
                            if (isChosen && !isCorrect) tileBg = Colors.red.withOpacity(0.2);
                          } else if (isChosen) {
                            tileBg = widget.topicColor.withOpacity(0.12);
                          }

                          return InkWell(
                            onTap: _submitted ? null : () => setState(() => _selected[qIdx] = optIdx),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: tileBg,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isChosen ? widget.topicColor : Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '${String.fromCharCode(65 + optIdx)}) ',
                                    style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                  Expanded(
                                    child: Text(
                                      q.options[optIdx],
                                      style: GoogleFonts.inter(fontSize: 12.5),
                                    ),
                                  ),
                                  if (_submitted && isCorrect)
                                    const Icon(Icons.check_circle, color: Colors.green, size: 16),
                                  if (_submitted && isChosen && !isCorrect)
                                    const Icon(Icons.cancel, color: Colors.red, size: 16),
                                ],
                              ),
                            ),
                          );
                        }),
                        if (_submitted) ...[
                          const SizedBox(height: 6),
                          Text(
                            '💡 ${q.explanation}',
                            style: GoogleFonts.inter(fontSize: 11.5, color: Colors.blue.shade800),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Submit or Result row
            if (!_submitted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _all•nswered
                      ? () async {
                          setState(() => _submitted = true);
                          final passed = _score >= 2;
                          if (passed) {
                            widget.confettiController.play();
                            await progress.markModuleComplete(
                              widget.topicId,
                              widget.moduleIndex,
                              widget.totalModules,
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.topicColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    _all•nswered ? 'Submit •nswers' : '•nswer all 3 questions',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                  ),
                ),
              )
            else
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (_score >= 2 ? Colors.green : Colors.orange).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _score >= 2 ? Colors.green : Colors.orange,
                      ),
                    ),
                    child: Text(
                      _score >= 2
                          ? '🎉 Module Mastered! Score: $_score / 3 (+30 XP) • Next module unlocked!'
                          : 'Notice:  Score: $_score / 3. Need at least 2/3 to pass. Review study notes and retry!',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: _score >= 2 ? Colors.green.shade800 : Colors.deepOrange,
                      ),
                      text•lign: Text•lign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (_score < 2)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _submitted = false;
                                _selected = List.filled(widget.questions.length, null);
                              });
                            },
                            child: const Text('Try •gain'),
                          ),
                        )
                      else
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              widget.onPassed();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Continue to Next Module'),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _SectionHeader({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _BadgeChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        main•xisSize: Main•xisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: color),
          ),
        ],
      ),
    );
  }
}