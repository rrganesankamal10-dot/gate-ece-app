// lib/screens/faq_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/questions_data.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  static const Map<String, IconData> _icons = {
    'networks': Icons.electrical_services,
    'signals': Icons.graphic_eq,
    'edc': Icons.developer_board,
    'analog': Icons.memory,
    'digital': Icons.dialpad,
    'control': Icons.tune,
    'communication': Icons.podcasts,
    'em': Icons.waves,
    'maths': Icons.functions,
  };

  static const Map<String, String> _names = {
    'networks': 'Network Theory',
    'signals': 'Signals & Systems',
    'edc': 'Electronic Devices',
    'analog': 'Analog Electronics',
    'digital': 'Digital Circuits',
    'control': 'Control Systems',
    'communication': 'Communications',
    'em': 'Electromagnetics',
    'maths': 'Engg. Mathematics',
  };

  static const Map<String, Color> _colors = {
    'networks': Color(0xFFE65100),
    'signals': Color(0xFF1565C0),
    'edc': Color(0xFF2E7D32),
    'analog': Color(0xFF6A1B9A),
    'digital': Color(0xFF00897B),
    'control': Color(0xFFD84315),
    'communication': Color(0xFF0277BD),
    'em': Color(0xFF4527A0),
    'maths': Color(0xFFC62828),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ Topics',
          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqTopics.length,
        itemBuilder: (context, index) {
          final key = faqTopics.keys.elementAt(index);
          final topics = faqTopics[key]!;
          final color = _colors[key] ?? Colors.blue;
          final icon = _icons[key] ?? Icons.book;
          final name = _names[key] ?? key;

          // Count questions for this topic
          final qCount = gateQuestions.where((q) => q.topicId == key).length;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                title: Text(
                  name,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                subtitle: Text(
                  '$qCount questions available | ${topics.length} key topics',
                  style: GoogleFonts.inter(fontSize: 11, color: Colors.grey),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Most Frequently Asked in GATE:',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...topics.asMap().entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '${entry.key + 1}',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: color,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    entry.value,
                                    style: GoogleFonts.inter(fontSize: 13, height: 1.4),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}