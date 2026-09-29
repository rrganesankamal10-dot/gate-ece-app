// lib/screens/previous_papers_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/papers_data.dart';

class PreviousYearsScreen extends StatefulWidget {
  const PreviousYearsScreen({super.key});

  @override
  State<PreviousYearsScreen> createState() => _PreviousYearsScreenState();
}

class _PreviousYearsScreenState extends State<PreviousYearsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: allGatePapers.length, vsync: this);
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
          'Previous Year Papers',
          style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4527A0),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFFD600),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14),
          tabs: allGatePapers
              .map((p) => Tab(text: 'GATE ${p.year}'))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: allGatePapers
            .map((paper) => _PaperTab(paper: paper))
            .toList(),
      ),
    );
  }
}

// ─── Paper Tab ───────────────────────────────────────────────────────────────
class _PaperTab extends StatefulWidget {
  final GatePaper paper;
  const _PaperTab({required this.paper});

  @override
  State<_PaperTab> createState() => _PaperTabState();
}

class _PaperTabState extends State<_PaperTab> {
  // selectedAnswer[i] = null if not answered, else index 0-3
  late List<int?> _selectedAnswers;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List.filled(widget.paper.questions.length, null);
  }

  int get _answeredCount => _selectedAnswers.where((a) => a != null).length;

  int get _correctCount {
    int c = 0;
    for (int i = 0; i < widget.paper.questions.length; i++) {
      if (_selectedAnswers[i] == widget.paper.questions[i].answer) c++;
    }
    return c;
  }

  double get _score {
    double s = 0;
    for (int i = 0; i < widget.paper.questions.length; i++) {
      final q = widget.paper.questions[i];
      if (_selectedAnswers[i] != null) {
        if (_selectedAnswers[i] == q.answer) {
          s += q.marks;
        } else {
          s -= q.marks / 3.0; // GATE negative marking
        }
      }
    }
    return s;
  }

  void _submit() {
    setState(() => _submitted = true);
    _showResultDialog();
  }

  void _showResultDialog() {
    final total = widget.paper.totalMarks;
    final score = _score;
    final pct = (score / total * 100).clamp(0.0, 100.0);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Paper Result',
          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('GATE ECE ${widget.paper.year}',
                style: GoogleFonts.inter(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: pct / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(
                      pct >= 60 ? Colors.green : pct >= 40 ? Colors.orange : Colors.red,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${pct.toStringAsFixed(1)}%',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: pct >= 60 ? Colors.green : pct >= 40 ? Colors.orange : Colors.red,
                      ),
                    ),
                    Text('Score', style: GoogleFonts.inter(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _ResultRow(label: 'Raw Score', value: '${score.toStringAsFixed(2)} / $total'),
            _ResultRow(label: 'Correct Answers', value: '$_correctCount / ${widget.paper.questions.length}'),
            _ResultRow(label: 'Questions Attempted', value: '$_answeredCount / ${widget.paper.questions.length}'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (pct >= 60 ? Colors.green : Colors.orange).withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: (pct >= 60 ? Colors.green : Colors.orange).withOpacity(0.3),
                ),
              ),
              child: Text(
                pct >= 60
                    ? '🎉 Excellent! You would qualify GATE cutoff.'
                    : pct >= 40
                        ? '📈 Good attempt. Focus on weak areas to improve.'
                        : '📚 Keep practicing. Review solutions carefully.',
                style: GoogleFonts.inter(fontSize: 13, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.paper.questions;
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        // Summary card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _SummaryCard(
              year: widget.paper.year,
              answered: _answeredCount,
              total: questions.length,
              totalMarks: widget.paper.totalMarks,
              submitted: _submitted,
              onSubmit: _answeredCount > 0 && !_submitted ? _submit : null,
            ),
          ),
        ),
        // Questions
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: _QuestionCard(
                question: questions[i],
                questionNumber: i + 1,
                selectedAnswer: _selectedAnswers[i],
                submitted: _submitted,
                onAnswer: _submitted
                    ? null
                    : (idx) => setState(() => _selectedAnswers[i] = idx),
              ),
            ),
            childCount: questions.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
      ],
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  const _ResultRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey)),
          Text(value,
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

// ─── Summary Card ─────────────────────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  final int year;
  final int answered;
  final int total;
  final int totalMarks;
  final bool submitted;
  final VoidCallback? onSubmit;

  const _SummaryCard({
    required this.year,
    required this.answered,
    required this.total,
    required this.totalMarks,
    required this.submitted,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4527A0), Color(0xFF311B92)],
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
                  'GATE ECE $year',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$answered / $total answered · $totalMarks total marks',
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  submitted ? 'Paper submitted!' : 'Negative marking: −1/3 per wrong answer',
                  style: GoogleFonts.inter(
                    color: submitted ? const Color(0xFFFFD600) : Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (!submitted)
            ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: onSubmit != null ? const Color(0xFFFFD600) : Colors.white24,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: Text(
                'Submit\nPaper',
                style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          else
            const Icon(Icons.check_circle, color: Color(0xFFFFD600), size: 32),
        ],
      ),
    );
  }
}

// ─── Question Card ────────────────────────────────────────────────────────────
class _QuestionCard extends StatefulWidget {
  final GatePaperQuestion question;
  final int questionNumber;
  final int? selectedAnswer;
  final bool submitted;
  final void Function(int)? onAnswer;

  const _QuestionCard({
    required this.question,
    required this.questionNumber,
    required this.selectedAnswer,
    required this.submitted,
    this.onAnswer,
  });

  @override
  State<_QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<_QuestionCard> {
  bool _showSolution = false;

  bool get _isAnswered => widget.selectedAnswer != null;
  bool get _isCorrect => widget.selectedAnswer == widget.question.answer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final q = widget.question;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4527A0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Q${widget.questionNumber}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF4527A0),
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: q.marks == 2
                        ? Colors.orange.withOpacity(0.12)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${q.marks} Mark${q.marks > 1 ? 's' : ''}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: q.marks == 2 ? Colors.orange.shade700 : Colors.blue.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      q.topic,
                      style: GoogleFonts.inter(fontSize: 10, color: Colors.green.shade700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Question text
            Text(
              q.question,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.55,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 14),

            // Options
            ...List.generate(q.options.length, (i) {
              Color borderColor = colorScheme.outline.withOpacity(0.2);
              Color bgColor = colorScheme.surface;
              Color textColor = colorScheme.onSurface;

              if (_isAnswered || widget.submitted) {
                if (i == q.answer) {
                  borderColor = Colors.green;
                  bgColor = Colors.green.withOpacity(0.08);
                  textColor = Colors.green.shade700;
                } else if (i == widget.selectedAnswer) {
                  borderColor = Colors.red;
                  bgColor = Colors.red.withOpacity(0.07);
                  textColor = Colors.red.shade700;
                }
              } else if (i == widget.selectedAnswer) {
                borderColor = const Color(0xFF4527A0);
                bgColor = const Color(0xFF4527A0).withOpacity(0.07);
                textColor = const Color(0xFF4527A0);
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: widget.onAnswer == null ? null : () => widget.onAnswer!(i),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${String.fromCharCode(65 + i)}.',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            q.options[i],
                            style: GoogleFonts.inter(fontSize: 13, color: textColor),
                          ),
                        ),
                        if ((_isAnswered || widget.submitted) && i == q.answer)
                          const Icon(Icons.check_circle, color: Colors.green, size: 16),
                        if ((_isAnswered || widget.submitted) &&
                            i == widget.selectedAnswer &&
                            i != q.answer)
                          const Icon(Icons.cancel, color: Colors.red, size: 16),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Show solution toggle
            if (_isAnswered || widget.submitted) ...[
              const SizedBox(height: 4),
              InkWell(
                onTap: () => setState(() => _showSolution = !_showSolution),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Icon(
                        _showSolution ? Icons.expand_less : Icons.expand_more,
                        color: const Color(0xFF4527A0),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _showSolution ? 'Hide Solution' : 'Step-by-Step Solution',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF4527A0),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_showSolution) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.lightbulb, color: Colors.amber, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Solution',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...q.explanation.split('\n').asMap().entries.map((e) {
                        final line = e.value.trim();
                        if (line.isEmpty) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            line,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              height: 1.5,
                              color: colorScheme.onSurface.withOpacity(0.8),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

/// Alias for backwards compatibility
typedef PreviousPapersScreen = PreviousYearsScreen;
