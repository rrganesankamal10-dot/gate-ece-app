import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../providers/theme_provider.dart';
import '../providers/progress_provider.dart';
import '../data/topics_data.dart';
import 'topics_screen.dart';
import 'formulas_screen.dart';
import 'mock_tests_screen.dart';
import 'progress_screen.dart';
import 'calculators_screen.dart';
import 'circuit_visualizer_screen.dart';
import 'virtual_calculator_screen.dart';
import 'flashcards_screen.dart';
import 'notes_screen.dart';
import 'syllabus_guide_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _HomeTab(),
    const TopicsScreen(),
    const FormulasScreen(),
    const MockTestsScreen(),
    const ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        backgroundColor: isDark ? const Color(0xFF0D1B2A) : Colors.white,
        indicatorColor: const Color(0xFF1565C0).withOpacity(0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Topics',
          ),
          NavigationDestination(
            icon: Icon(Icons.functions_outlined),
            selectedIcon: Icon(Icons.functions),
            label: 'Formulas',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'Mock Tests',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}

// ─── HOME TAB ────────────────────────────────────────────────────────────────
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('⚡ ', style: TextStyle(fontSize: 22)),
            Text(
              'GATE ECE Master',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate, color: Color(0xFFFFD600)),
            tooltip: 'Virtual Calculator',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VirtualCalculatorScreen()),
            ),
          ),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
            tooltip: 'Toggle theme',
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero banner
            _HeroBanner(progress: progress),
            const SizedBox(height: 20),

            // Stats row
            _StatsRow(progress: progress),
            const SizedBox(height: 24),

            // Top Feature Cards: Circuit Visualizer & Notes
            Row(
              children: [
                Expanded(
                  child: _FeaturedActionCard(
                    title: 'Interactive Circuit Labs',
                    subtitle: 'RLC, Op-Amp, Logic & BJT Simulator',
                    icon: Icons.waves,
                    gradient: const [Color(0xFF1565C0), Color(0xFF0D47A1)],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CircuitVisualizerScreen()),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FeaturedActionCard(
                    title: 'Chapter Notes',
                    subtitle: 'Theory & Formula Derivations',
                    icon: Icons.menu_book,
                    gradient: const [Color(0xFF6A1B9A), Color(0xFF4A148C)],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotesScreen()),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Quick actions grid
            Text(
              'Power Study Tools',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            const _QuickActionsGrid(),
            const SizedBox(height: 24),

            // Topic progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subject Progress',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TopicsScreen()),
                  ),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...gateTopics.take(5).map((t) => _TopicProgressTile(topic: t, progress: progress)),
            const SizedBox(height: 16),

            // About Card
            const _AboutCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _FeaturedActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _FeaturedActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.inter(fontSize: 11, color: Colors.white70),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final ProgressProvider progress;
  const _HeroBanner({required this.progress});

  @override
  Widget build(BuildContext context) {
    final pct = progress.overallPercent;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.4),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back! 👋',
                    style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'GATE ECE 2025',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Engineered by Kamal',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFFD600),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 42.0,
                lineWidth: 6.0,
                percent: pct,
                center: Text(
                  '${(pct * 100).toInt()}%',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                progressColor: const Color(0xFFFFD600),
                backgroundColor: Colors.white24,
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearPercentIndicator(
            percent: pct,
            lineHeight: 8,
            backgroundColor: Colors.white24,
            progressColor: const Color(0xFFFFD600),
            barRadius: const Radius.circular(10),
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          Text(
            '${(pct * 100).toInt()}% of syllabus covered · Aim for AIR < 100!',
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final ProgressProvider progress;
  const _StatsRow({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          icon: '🔥',
          value: '${progress.streak}',
          label: 'Day Streak',
          color: const Color(0xFFE65100),
        ),
        const SizedBox(width: 10),
        _StatCard(
          icon: '⭐',
          value: '${progress.totalXP}',
          label: 'Total XP',
          color: const Color(0xFF6A1B9A),
        ),
        const SizedBox(width: 10),
        _StatCard(
          icon: '📚',
          value: '${gateTopics.length}',
          label: 'Subjects',
          color: const Color(0xFF1565C0),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon, value, label;
  final Color color;
  const _StatCard({required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 20, color: color)),
            Text(label, style: GoogleFonts.inter(fontSize: 10, color: color.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.calculate_outlined, 'label': 'Calculators', 'color': const Color(0xFF1565C0), 'screen': const CalculatorsScreen()},
      {'icon': Icons.style_outlined, 'label': 'Flashcards', 'color': const Color(0xFF6A1B9A), 'screen': const FlashcardsScreen()},
      {'icon': Icons.tune, 'label': 'TCS Virtual Calc', 'color': const Color(0xFFE65100), 'screen': const VirtualCalculatorScreen()},
      {'icon': Icons.checklist_rtl, 'label': 'Exam Strategy', 'color': const Color(0xFF1B5E20), 'screen': const SyllabusGuideScreen()},
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: actions.map((a) {
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => a['screen'] as Widget)),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: (a['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: (a['color'] as Color).withOpacity(0.25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(a['icon'] as IconData, color: a['color'] as Color, size: 24),
                const SizedBox(width: 10),
                Text(
                  a['label'] as String,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: a['color'] as Color,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TopicProgressTile extends StatelessWidget {
  final dynamic topic;
  final ProgressProvider progress;
  const _TopicProgressTile({required this.topic, required this.progress});

  @override
  Widget build(BuildContext context) {
    final pct = progress.getTopicPercent(topic.id);
    final color = _hexToColor(topic.color);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(topic.icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(topic.name, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 4),
                LinearPercentIndicator(
                  percent: pct,
                  lineHeight: 6,
                  backgroundColor: color.withOpacity(0.15),
                  progressColor: color,
                  barRadius: const Radius.circular(10),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('${(pct * 100).toInt()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Color _hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFD600), size: 20),
                const SizedBox(width: 8),
                Text(
                  'About GATE ECE Master',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'GATE ECE Master is designed by Kamal to provide world-class, error-free preparation for GATE & PSU engineering aspirants. '
              'Featuring real-time circuit simulation, TCS iON virtual calculator, verified formulas, and chapter derivations.',
              style: GoogleFonts.inter(fontSize: 13, height: 1.5, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Version 1.0.0 · Production Ready', style: GoogleFonts.inter(fontSize: 11, color: Colors.greenAccent, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
