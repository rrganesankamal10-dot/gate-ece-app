import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/topics_data.dart';
import '../models/models.dart';
import 'topic_detail_screen.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  Color _hexToColor(String hex) =>
      Color(int.parse(hex.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 All Topics'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: gateTopics.length,
        itemBuilder: (ctx, i) {
          final topic = gateTopics[i];
          final color = _hexToColor(topic.color);
          return Card(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TopicDetailScreen(topic: topic),
                ),
              ),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(topic.icon,
                            style: const TextStyle(fontSize: 28)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic.name,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            topic.subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${topic.subtopics.length} subtopics',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: color),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
