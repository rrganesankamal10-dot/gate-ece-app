import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../data/notes_data.dart';
import '../data/topics_data.dart';

class NotesScreen extends StatefulWidget {
  final String? initialTopicId;
  const NotesScreen({super.key, this.initialTopicId});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late String _selectedTopicId;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedTopicId = widget.initialTopicId ?? 'all';
  }

  List<SubjectNote> get _filteredNotes {
    var list = allSubjectNotes;
    if (_selectedTopicId != 'all') {
      list = list.where((n) => n.topicId == _selectedTopicId).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((n) {
        return n.title.toLowerCase().contains(q) ||
            n.summary.toLowerCase().contains(q) ||
            n.sections.any((s) => s.heading.toLowerCase().contains(q) || s.content.toLowerCase().contains(q));
      }).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📖 Master Chapter Notes'),
      ),
      body: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search concepts, theorems, formulas...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),

          // Topic Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _buildChip('All Topics', 'all'),
                ...gateTopics.map((t) => _buildChip('${t.icon} ${t.name.split(' ').first}', t.id)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Notes List
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text('No notes matching "$_searchQuery"', style: GoogleFonts.inter(color: Colors.grey)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final note = filtered[i];
                      final topic = gateTopics.firstWhere((t) => t.id == note.topicId, orElse: () => gateTopics.first);
                      final color = Color(int.parse(topic.color.replaceFirst('#', '0xFF')));

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            initiallyExpanded: i == 0,
                            leading: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(topic.icon, style: const TextStyle(fontSize: 20))),
                            ),
                            title: Text(note.title, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15)),
                            subtitle: Text(note.summary, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
                            children: note.sections.map((sec) => _buildSectionWidget(sec, color)).toList(),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String id) {
    final isSelected = _selectedTopicId == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        selected: isSelected,
        selectedColor: const Color(0xFF1565C0),
        onSelected: (_) => setState(() => _selectedTopicId = id),
      ),
    );
  }

  Widget _buildSectionWidget(NoteSection sec, Color topicColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: topicColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sec.heading,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: const Color(0xFFFFD600)),
          ),
          const SizedBox(height: 8),
          Text(
            sec.content,
            style: GoogleFonts.inter(fontSize: 13, height: 1.5),
          ),
          if (sec.formula != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1B2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Math.tex(
                  sec.formula!,
                  textStyle: const TextStyle(fontSize: 15, color: Color(0xFFFFD600)),
                ),
              ),
            ),
          ],
          if (sec.trapWarning != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('⚠️ ', style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(
                      'GATE TRAP: ${sec.trapWarning!}',
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
