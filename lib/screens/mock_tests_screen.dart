import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/questions_data.dart';
import '../models/models.dart';
import '../providers/progress_provider.dart';
import 'practice_screen.dart';

class MockTestsScreen extends StatelessWidget {
  const MockTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 Mock Tests'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: mockTests.length,
        itemBuilder: (ctx, i) => _MockTestCard(test: mockTests[i]),
      ),
    );
  }
}

class _MockTestCard extends StatelessWidget {
  final MockTest test;
  const _MockTestCard({required this.test});

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    final hasDone = progress.mockResults.containsKey(test.id);
    final score = hasDone ? progress.getMockScore(test.id) : -1;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    test.title,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
                if (hasDone)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$score/${test.questionIds.length} ✓',
                      style: GoogleFonts.inter(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              test.description,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.6)),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _InfoChip(Icons.timer_outlined, '${test.durationMinutes} min'),
                const SizedBox(width: 8),
                _InfoChip(Icons.quiz_outlined,
                    '${test.questionIds.length} questions'),
                const SizedBox(width: 8),
                _InfoChip(Icons.star_outline, '${test.totalMarks} marks'),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(hasDone ? Icons.replay : Icons.play_arrow),
                label: Text(
                  hasDone ? 'Retake Test' : 'Start Test',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  final questions = test.questionIds
                      .map((id) => gateQuestions.firstWhere((q) => q.id == id,
                          orElse: () => gateQuestions.first))
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _MockTestRunner(
                        test: test,
                        questions: questions,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChip(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          const SizedBox(width: 4),
          Text(text,
              style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
        ],
      ),
    );
  }
}

// ─── TIMED MOCK TEST RUNNER ──────────────────────────────────────────────────
class _MockTestRunner extends StatefulWidget {
  final MockTest test;
  final List<GateQuestion> questions;
  const _MockTestRunner({required this.test, required this.questions});

  @override
  State<_MockTestRunner> createState() => _MockTestRunnerState();
}

class _MockTestRunnerState extends State<_MockTestRunner> {
  int _current = 0;
  final Map<int, int?> _answers = {};
  late Timer _timer;
  late int _secondsLeft;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.test.durationMinutes * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
        _submit();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _timeString {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _submit() {
    _timer.cancel();
    if (_submitted) return;
    _submitted = true;

    final results = List.generate(widget.questions.length, (i) {
      final ans = _answers[i];
      return ans != null && ans == widget.questions[i].correctIndex;
    });

    Provider.of<ProgressProvider>(context, listen: false)
        .recordMockResult(widget.test.id, results);

    final correct = results.where((r) => r).length;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Test Completed! 🎯',
            style: GoogleFonts.inter(fontWeight: FontWeight.w800)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$correct / ${widget.questions.length}',
              style: GoogleFonts.inter(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1565C0)),
            ),
            Text('correct answers',
                style: GoogleFonts.inter(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              'Score: ${(correct / widget.questions.length * widget.test.totalMarks).toStringAsFixed(1)} / ${widget.test.totalMarks} marks',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text('+${correct * 15} XP earned',
                style: GoogleFonts.inter(
                    color: const Color(0xFFFFD600),
                    fontWeight: FontWeight.w700)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_current];
    final total = widget.questions.length;
    final isTimeLow = _secondsLeft <= 60;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.title,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w700, fontSize: 15),
            overflow: TextOverflow.ellipsis),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isTimeLow
                  ? Colors.red.withOpacity(0.2)
                  : Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '⏱ $_timeString',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  color: isTimeLow ? Colors.red.shade300 : Colors.white,
                  fontSize: 14),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_current + 1) / total,
            backgroundColor: Colors.white24,
            color: const Color(0xFFFFD600),
            minHeight: 4,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question ${_current + 1} of $total',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.5))),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(q.question,
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.5)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...q.options.asMap().entries.map((e) {
                    final idx = e.key;
                    final selected = _answers[_current] == idx;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () =>
                            setState(() => _answers[_current] = idx),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF1565C0).withOpacity(0.12)
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF1565C0)
                                  : Theme.of(context)
                                      .colorScheme
                                      .outline
                                      .withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color(0xFF1565C0)
                                      : const Color(0xFF1565C0)
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + idx),
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: selected
                                            ? Colors.white
                                            : const Color(0xFF1565C0),
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(e.value,
                                    style: GoogleFonts.inter(fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4))
              ],
            ),
            child: Row(
              children: [
                if (_current > 0)
                  OutlinedButton(
                    onPressed: () => setState(() => _current--),
                    child: const Text('← Prev'),
                  ),
                const Spacer(),
                if (_current < total - 1)
                  ElevatedButton(
                    onPressed: () => setState(() => _current++),
                    child: const Text('Next →'),
                  )
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green),
                    onPressed: _submit,
                    child: Text('Submit Test',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
