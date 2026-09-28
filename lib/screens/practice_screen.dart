import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../models/models.dart';
import '../providers/progress_provider.dart';

class PracticeScreen extends StatefulWidget {
  final List<GateQuestion> questions;
  final String topicName;
  final String topicId;

  const PracticeScreen({
    super.key,
    required this.questions,
    required this.topicName,
    required this.topicId,
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  int? _selected;
  bool _answered = false;
  int _correct = 0;
  bool _showExplanation = false;
  late ConfettiController _confetti;
  late AnimationController _anim;
  late Animation<double> _slideAnim;

  GateQuestion get _q => widget.questions[_current];
  bool get _isLast => _current >= widget.questions.length - 1;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    _anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnim =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _anim,
      curve: Curves.easeOut,
    ));
    _anim.forward();
  }

  @override
  void dispose() {
    _confetti.dispose();
    _anim.dispose();
    super.dispose();
  }

  void _answer(int index) {
    if (_answered) return;
    final correct = index == _q.correctIndex;
    setState(() {
      _selected = index;
      _answered = true;
      if (correct) {
        _correct++;
        _confetti.play();
      }
    });
    Provider.of<ProgressProvider>(context, listen: false).recordAnswer(
        widget.topicId, widget.questions.length, correct);
  }

  void _next() {
    if (_isLast) {
      _showResults();
      return;
    }
    setState(() {
      _current++;
      _selected = null;
      _answered = false;
      _showExplanation = false;
    });
    _anim.reset();
    _anim.forward();
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Results 🎉',
            style: GoogleFonts.inter(fontWeight: FontWeight.w800)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_correct / ${widget.questions.length}',
              style: GoogleFonts.inter(
                  fontSize: 40, fontWeight: FontWeight.w900,
                  color: const Color(0xFF1565C0)),
            ),
            Text('questions correct',
                style: GoogleFonts.inter(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(
              _correct == widget.questions.length
                  ? 'Perfect score! 🏆'
                  : _correct >= widget.questions.length * 0.7
                      ? 'Great job! Keep it up!'
                      : 'Keep practicing — you\'ll improve!',
              style: GoogleFonts.inter(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text('+${_correct * 10} XP earned',
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
            child: const Text('Back to Topics'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _current = 0;
                _selected = null;
                _answered = false;
                _correct = 0;
                _showExplanation = false;
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.questions.length;
    final progress = (_current + 1) / total;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topicName,
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white24,
            color: const Color(0xFFFFD600),
            minHeight: 4,
          ),
        ),
      ),
      body: Stack(
        children: [
          FadeTransition(
            opacity: _slideAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_current + 1} of $total',
                        style: GoogleFonts.inter(
                            fontSize: 13, color: colorScheme.onSurface.withOpacity(0.6)),
                      ),
                      _DifficultyBadge(difficulty: _q.difficulty),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Question text
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        _q.question,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Options
                  ..._q.options.asMap().entries.map((e) {
                    final idx = e.key;
                    final label = String.fromCharCode(65 + idx); // A, B, C, D
                    final isSelected = _selected == idx;
                    final isCorrect = idx == _q.correctIndex;

                    Color optColor = colorScheme.surface;
                    Color borderColor = colorScheme.outline.withOpacity(0.3);
                    Color textColor = colorScheme.onSurface;
                    IconData? trailingIcon;

                    if (_answered) {
                      if (isCorrect) {
                        optColor = Colors.green.withOpacity(0.12);
                        borderColor = Colors.green;
                        textColor = Colors.green.shade700;
                        trailingIcon = Icons.check_circle;
                      } else if (isSelected && !isCorrect) {
                        optColor = Colors.red.withOpacity(0.10);
                        borderColor = Colors.red;
                        textColor = Colors.red.shade700;
                        trailingIcon = Icons.cancel;
                      }
                    } else if (isSelected) {
                      borderColor = colorScheme.primary;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () => _answer(idx),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: optColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: borderColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(label,
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          color: borderColor,
                                          fontSize: 13)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(e.value,
                                    style: GoogleFonts.inter(
                                        fontSize: 14, color: textColor)),
                              ),
                              if (trailingIcon != null)
                                Icon(trailingIcon, color: textColor, size: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  // Explanation
                  if (_answered) ...[
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () =>
                          setState(() => _showExplanation = !_showExplanation),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              _showExplanation
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _showExplanation
                                  ? 'Hide Explanation'
                                  : 'Show Explanation',
                              style: GoogleFonts.inter(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_showExplanation)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: colorScheme.primary.withOpacity(0.25)),
                        ),
                        child: Text(
                          _q.explanation,
                          style: GoogleFonts.inter(fontSize: 13, height: 1.6),
                        ),
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _next,
                        child: Text(
                          _isLast ? 'View Results 🎉' : 'Next Question →',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 20,
              emissionFrequency: 0.05,
              colors: const [
                Color(0xFFFFD600),
                Color(0xFF1565C0),
                Colors.green,
                Colors.orange,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  final String difficulty;
  const _DifficultyBadge({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    final color = difficulty == 'Easy'
        ? Colors.green
        : difficulty == 'Medium'
            ? Colors.orange
            : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        difficulty,
        style: GoogleFonts.inter(
            fontSize: 11, color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
