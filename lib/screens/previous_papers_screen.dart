// lib/screens/previous_papers_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
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

class _PaperTab extends StatefulWidget {
  final GatePaper paper;
  const _PaperTab({required this.paper});

  @override
  State<_PaperTab> createState() => _PaperTabState();
}

class _PaperTabState extends State<_PaperTab> {
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
          s -= q.marks / 3.0; // GATE negative marking rule
        }
      }
    }
    return s;
  }

  void _submit() {
    setState(() => _submitted = true);
    _showResultDialog();
  }

  void _showOfficialLinksDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.school, color: Color(0xFF4527A0)),
            const SizedBox(width: 8),
            Text(
              'Official IIT GATE ${widget.paper.year}',
              style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Organizing Institute: ${widget.paper.organizingInstitute}',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Text(
              'Direct links to official question papers and master answer keys:',
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            _LinkTile(
              title: 'Official 65-Q Question Paper (PDF)',
              subtitle: widget.paper.officialPaperUrl,
              icon: Icons.description,
            ),
            const SizedBox(height: 10),
            _LinkTile(
              title: 'Official Final Answer Key (PDF)',
              subtitle: widget.paper.officialAnswerKeyUrl,
              icon: Icons.key,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
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
            Text('GATE ECE ${widget.paper.year} (${widget.paper.organizingInstitute})',
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
                    ? '🎯 Excellent score! You are on track for top GATE rank.'
                    : pct >= 40
                        ? '👍 Good attempt! Review solutions to eliminate negative marks.'
                        : '📚 Keep practicing! Step-by-step solutions are shown below.',
                style: GoogleFonts.inter(fontSize: 13, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Review Solutions', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.paper.questions;

    return CustomScrollView(
      slivers: [
        // Summary & Official IIT Hub
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _SummaryCard(
                  year: widget.paper.year,
                  institute: widget.paper.organizingInstitute,
                  answered: _answeredCount,
                  total: questions.length,
                  totalMarks: widget.paper.totalMarks,
                  submitted: _submitted,
                  onSubmit: _answeredCount > 0 && !_submitted ? _submit : null,
                  onOpenOfficialLinks: _showOfficialLinksDialog,
                ),
              ],
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

class _LinkTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _LinkTile({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4527A0), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 11, color: Colors.blue.shade700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 18),
            tooltip: 'Copy URL',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: subtitle));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link copied to clipboard!'), duration: Duration(seconds: 2)),
              );
            },
          ),
        ],
      ),
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
          Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final int year;
  final String institute;
  final int answered;
  final int total;
  final int totalMarks;
  final bool submitted;
  final VoidCallback? onSubmit;
  final VoidCallback onOpenOfficialLinks;

  const _SummaryCard({
    required this.year,
    required this.institute,
    required this.answered,
    required this.total,
    required this.totalMarks,
    required this.submitted,
    this.onSubmit,
    required this.onOpenOfficialLinks,
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
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4527A0).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'GATE ECE $year',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD600),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            institute,
                            style: GoogleFonts.inter(
                              color: Colors.black87,
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$answered / $total solved · $totalMarks total marks',
                      style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (!submitted)
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onSubmit != null ? const Color(0xFFFFD600) : Colors.white24,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Negative marking: -1/3 (1M) · -2/3 (2M)',
                style: GoogleFonts.inter(color: Colors.white60, fontSize: 11),
              ),
              InkWell(
                onTap: onOpenOfficialLinks,
                child: Row(
                  children: [
                    const Icon(Icons.download, color: Color(0xFFFFD600), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Official IIT Papers',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFFD600),
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final GatePaperQuestion question;
  final int questionNumber;
  final int? selectedAnswer;
  final bool submitted;
  final ValueChanged<int>? onAnswer;

  const _QuestionCard({
    required this.question,
    required this.questionNumber,
    required this.selectedAnswer,
    required this.submitted,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top badges
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: question.marks == 2
                        ? const Color(0xFF4527A0).withOpacity(0.12)
                        : const Color(0xFF2E7D32).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: question.marks == 2
                          ? const Color(0xFF4527A0)
                          : const Color(0xFF2E7D32),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${question.marks} ${question.marks == 1 ? "Mark" : "Marks"}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: question.marks == 2
                          ? const Color(0xFF4527A0)
                          : const Color(0xFF2E7D32),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    question.topic,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.grey.shade800,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Q$questionNumber',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Question statement
            Text(
              question.question,
              style: GoogleFonts.inter(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            // Options
            ...List.generate(question.options.length, (idx) {
              final isSelected = selectedAnswer == idx;
              final isCorrect = question.answer == idx;

              Color? bg;
              Color border = Colors.grey.shade300;
              Color textCol = isDark ? Colors.white : Colors.black87;

              if (submitted) {
                if (isCorrect) {
                  bg = Colors.green.withOpacity(0.15);
                  border = Colors.green;
                  textCol = Colors.green.shade800;
                } else if (isSelected && !isCorrect) {
                  bg = Colors.red.withOpacity(0.12);
                  border = Colors.red;
                  textCol = Colors.red.shade800;
                }
              } else if (isSelected) {
                bg = const Color(0xFF4527A0).withOpacity(0.1);
                border = const Color(0xFF4527A0);
                textCol = const Color(0xFF4527A0);
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: onAnswer != null ? () => onAnswer!(idx) : null,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: border, width: isSelected || (submitted && isCorrect) ? 1.5 : 1),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${String.fromCharCode(65 + idx)}) ',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: textCol,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            question.options[idx],
                            style: GoogleFonts.inter(fontSize: 13.5, color: textCol),
                          ),
                        ),
                        if (submitted && isCorrect)
                          const Icon(Icons.check_circle, color: Colors.green, size: 18)
                        else if (submitted && isSelected && !isCorrect)
                          const Icon(Icons.cancel, color: Colors.red, size: 18),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Explanation
            if (submitted) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lightbulb, size: 16, color: Colors.blue),
                        const SizedBox(width: 6),
                        Text(
                          'Step-by-Step Solution:',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      question.explanation,
                      style: GoogleFonts.inter(fontSize: 12.5, height: 1.45),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}