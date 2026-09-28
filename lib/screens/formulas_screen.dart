import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../data/topics_data.dart';
import '../models/models.dart';
import '../providers/progress_provider.dart';

class FormulasScreen extends StatefulWidget {
  const FormulasScreen({super.key});

  @override
  State<FormulasScreen> createState() => _FormulasScreenState();
}

class _FormulasScreenState extends State<FormulasScreen> {
  String _selectedTopicId = 'all';
  bool _bookmarkedOnly = false;

  List<GateFormula> get _filtered {
    final progress = Provider.of<ProgressProvider>(context, listen: false);
    var list = gateFormulas;
    if (_selectedTopicId != 'all') {
      list = list.where((f) => f.topicId == _selectedTopicId).toList();
    }
    if (_bookmarkedOnly) {
      list = list.where((f) => progress.isBookmarked(f.id)).toList();
    }
    return list;
  }

  Color _hexToColor(String hex) =>
      Color(int.parse(hex.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    final filtered = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📐 Formulas'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              _bookmarkedOnly ? Icons.bookmark : Icons.bookmark_outline,
              color: _bookmarkedOnly ? const Color(0xFFFFD600) : Colors.white,
            ),
            tooltip: 'Bookmarked only',
            onPressed: () => setState(() => _bookmarkedOnly = !_bookmarkedOnly),
          ),
        ],
      ),
      body: Column(
        children: [
          // Topic filter chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                _FilterChip(
                  label: 'All',
                  selected: _selectedTopicId == 'all',
                  onTap: () => setState(() => _selectedTopicId = 'all'),
                  color: const Color(0xFF37474F),
                ),
                ...gateTopics.map((t) => _FilterChip(
                      label: '${t.icon} ${t.name.split(' ').first}',
                      selected: _selectedTopicId == t.id,
                      onTap: () => setState(() => _selectedTopicId = t.id),
                      color: _hexToColor(t.color),
                    )),
              ],
            ),
          ),

          // Formula count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${filtered.length} formula${filtered.length != 1 ? 's' : ''}',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5)),
                ),
              ],
            ),
          ),

          // Formula list
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🔖', style: TextStyle(fontSize: 40)),
                        const SizedBox(height: 12),
                        Text(
                          _bookmarkedOnly
                              ? 'No bookmarked formulas yet.\nTap the bookmark icon on any formula.'
                              : 'No formulas found.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final f = filtered[i];
                      final topicColor = _hexToColor(
                          gateTopics.firstWhere((t) => t.id == f.topicId).color);
                      final isBookmarked = progress.isBookmarked(f.id);

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
                                      f.title,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isBookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline,
                                      color: isBookmarked
                                          ? const Color(0xFFFFD600)
                                          : Colors.grey,
                                    ),
                                    onPressed: () =>
                                        progress.toggleBookmark(f.id),
                                  ),
                                ],
                              ),

                              // LaTeX formula
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: topicColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: topicColor.withOpacity(0.2)),
                                ),
                                child: Center(
                                  child: Math.tex(
                                    f.latex,
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                    onErrorFallback: (e) => Text(
                                      f.latex,
                                      style: GoogleFonts.sourceCodePro(
                                          fontSize: 13),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),

                              // Description
                              Text(
                                f.description,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  height: 1.5,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.75),
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Example
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Text('💡 ',
                                        style: TextStyle(fontSize: 13)),
                                    Expanded(
                                      child: Text(
                                        f.example,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.green.shade700,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label,
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
                color: selected ? Colors.white : color)),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: color.withOpacity(0.1),
        selectedColor: color,
        checkmarkColor: Colors.white,
        side: BorderSide(color: color.withOpacity(0.3)),
        showCheckmark: false,
      ),
    );
  }
}
