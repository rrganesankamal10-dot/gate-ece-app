import 'chapter_module_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/models.dart';
import '../data/questions_data.dart';
import '../data/topics_data.dart';
import 'practice_screen.dart';
import 'notes_screen.dart';
import 'formulas_screen.dart';
import 'circuit_visualizer_screen.dart';

class TopicDetailScreen extends StatelessWidget {
  final GateTopic topic;
  const TopicDetailScreen({super.key, required this.topic});

  Color get _color => Color(int.parse(topic.color.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    final topicQs = gateQuestions.where((q) => topicIdsMatch(q.topicId, topic.id)).toList();
    final topicFormulas = gateFormulas.where((f) => topicIdsMatch(f.topicId, topic.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${topic.icon} ${topic.name}'),
        backgroundColor: _color,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: _color.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.play_arrow),
                        label: Text('Practice ${topicQs.length} Questions', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                        style: ElevatedButton.styleFrom(backgroundColor: _color),
                        onPressed: topicQs.isEmpty
                            ? null
                            : () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PracticeScreen(
                                      questions: topicQs,
                                      topicName: topic.name,
                                      topicId: topic.id,
                                    ),
                                  ),
                                ),
                      ),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.menu_book),
                        label: const Text('Read Notes'),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NotesScreen(initialTopicId: topic.id),
                          ),
                        ),
                      ),
                      if (topic.id == 'networks' || topic.id == 'analog' || topic.id == 'digital' || topic.id == 'devices')
                        ElevatedButton.icon(
                          icon: const Icon(Icons.waves),
                          label: const Text('Circuit Lab'),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF004D40)),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CircuitVisualizerScreen()),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _miniStat('Subtopics', '${topic.subtopics.length}'),
                  const SizedBox(width: 8),
                  _miniStat('Formulas', '${topicFormulas.length}'),
                  const SizedBox(width: 8),
                  _miniStat('MCQs / PYQs', '${topicQs.length}'),
                ],
              ),
            ),

            // Subtopics List
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Syllabus & Key Subtopics',
                    style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  ...topic.subtopics.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: _color.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${e.key + 1}',
                                  style: GoogleFonts.inter(
                                    color: _color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                e.value,
                                style: GoogleFonts.inter(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),

            // Questions list preview
            if (topicQs.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Topic Questions & PYQs (${topicQs.length})',
                        style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    ...topicQs.asMap().entries.map((e) => Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _color.withOpacity(0.15),
                              child: Text('${e.key + 1}',
                                  style: GoogleFonts.inter(color: _color, fontWeight: FontWeight.w700)),
                            ),
                            title: Text(
                              e.value.question,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(fontSize: 13),
                            ),
                            subtitle: Row(
                              children: [
                                _DiffChip(difficulty: e.value.difficulty),
                                if (e.value.year > 0)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Chip(
                                      label: Text('GATE ${e.value.year}', style: GoogleFonts.inter(fontSize: 10)),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(String label, String val) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: _color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(val, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: _color)),
            Text(label, style: GoogleFonts.inter(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _DiffChip extends StatelessWidget {
  final String difficulty;
  const _DiffChip({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    final color = difficulty == 'Easy'
        ? Colors.green
        : difficulty == 'Medium'
            ? Colors.orange
            : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        difficulty,
        style: GoogleFonts.inter(fontSize: 10, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
