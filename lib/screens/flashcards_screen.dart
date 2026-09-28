import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../data/topics_data.dart';
import '../models/models.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({super.key});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showBack = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnim;
  String _selectedTopicId = 'all';

  List<GateFormula> get _activeCards {
    if (_selectedTopicId == 'all') return gateFormulas;
    return gateFormulas.where((f) => f.topicId == _selectedTopicId).toList();
  }

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_showBack) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _showBack = !_showBack);
  }

  void _nextCard() {
    final list = _activeCards;
    if (_currentIndex < list.length - 1) {
      if (_showBack) {
        _flipController.reverse();
        _showBack = false;
      }
      setState(() => _currentIndex++);
    }
  }

  void _prevCard() {
    if (_currentIndex > 0) {
      if (_showBack) {
        _flipController.reverse();
        _showBack = false;
      }
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = _activeCards;
    final f = list.isNotEmpty ? list[_currentIndex.clamp(0, list.length - 1)] : null;
    final topic = f != null
        ? gateTopics.firstWhere((t) => t.id == f.topicId, orElse: () => gateTopics.first)
        : null;
    final color = topic != null
        ? Color(int.parse(topic.color.replaceFirst('#', '0xFF')))
        : const Color(0xFF1565C0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎴 Formula Flashcards'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${list.isEmpty ? 0 : _currentIndex + 1} / ${list.length}',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: const Color(0xFFFFD600)),
              ),
            ),
          ),
        ],
      ),
      body: list.isEmpty
          ? const Center(child: Text('No formulas found'))
          : Column(
              children: [
                // Topic filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      _TopicFilterChip(
                        label: 'All Topics',
                        isSelected: _selectedTopicId == 'all',
                        onTap: () => setState(() {
                          _selectedTopicId = 'all';
                          _currentIndex = 0;
                        }),
                      ),
                      ...gateTopics.map((t) => _TopicFilterChip(
                            label: '${t.icon} ${t.name.split(' ').first}',
                            isSelected: _selectedTopicId == t.id,
                            onTap: () => setState(() {
                              _selectedTopicId = t.id;
                              _currentIndex = 0;
                            }),
                          )),
                    ],
                  ),
                ),

                // Card Area
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: _flipCard,
                      child: AnimatedBuilder(
                        animation: _flipAnim,
                        builder: (ctx, child) {
                          final angle = _flipAnim.value * math.pi;
                          final isFront = angle < (math.pi / 2);

                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.0015)
                              ..rotateY(angle),
                            alignment: Alignment.center,
                            child: isFront
                                ? _buildFront(f!, color, topic!)
                                : Transform(
                                    transform: Matrix4.identity()..rotateY(math.pi),
                                    alignment: Alignment.center,
                                    child: _buildBack(f!, color, topic!),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Bottom Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton.filled(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _currentIndex > 0 ? _prevCard : null,
                        style: IconButton.styleFrom(backgroundColor: const Color(0xFF162032)),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.flip),
                        label: Text(_showBack ? 'Show Formula' : 'Reveal Solution'),
                        onPressed: _flipCard,
                      ),
                      IconButton.filled(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: _currentIndex < list.length - 1 ? _nextCard : null,
                        style: IconButton.styleFrom(backgroundColor: const Color(0xFF162032)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildFront(GateFormula f, Color color, GateTopic topic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF162032),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${topic.icon} ${topic.name}',
              style: GoogleFonts.inter(color: color, fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
          const Spacer(),
          Text(
            f.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1B2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Math.tex(
              f.latex,
              textStyle: const TextStyle(fontSize: 20, color: Color(0xFFFFD600)),
              onErrorFallback: (e) => Text(f.latex, style: const TextStyle(color: Color(0xFFFFD600))),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.touch_app, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text('Tap card to reveal explanation & example', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBack(GateFormula f, Color color, GateTopic topic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2A3E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFFD600), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD600).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explanation & Example',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: const Color(0xFFFFD600)),
              ),
              const Icon(Icons.lightbulb, color: Color(0xFFFFD600)),
            ],
          ),
          const Divider(height: 24),
          Text(
            'Concept Summary:',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            f.description,
            style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: Colors.white),
          ),
          const SizedBox(height: 18),
          Text(
            'Solved Numerical Example:',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Text(
              f.example,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.greenAccent, fontStyle: FontStyle.italic, height: 1.4),
            ),
          ),
          const Spacer(),
          Center(
            child: Text(
              'Tap card to flip back',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TopicFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        selected: isSelected,
        selectedColor: const Color(0xFF1565C0),
        onSelected: (_) => onTap(),
      ),
    );
  }
}
