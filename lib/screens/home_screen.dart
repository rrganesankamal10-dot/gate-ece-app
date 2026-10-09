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
import 'circuit_visualizer_screen.dart';
import 'virtual_calculator_screen.dart';
import 'flashcards_screen.dart';
import 'learning_path_screen.dart';
import 'previous_papers_screen.dart';
import 'streak_screen.dart';
import 'score_guide_screen.dart';
import 'ai_chat_screen.dart';
import 'faq_screen.dart';

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
    final isDark = themeProvider.isDark || themeProvider.isStudy;

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

// HOME TAB
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    // Theme cycle icon + tooltip
    IconData themeIcon;
    String themeTooltip;
    switch (themeProvider.mode) {
      case AppThemeMode.dark:
        themeIcon = Icons.light_mode;
        themeTooltip = 'Switch to Light Mode';
        break;
      case AppThemeMode.light:
        themeIcon = Icons.nightlight_round;
        themeTooltip = 'Switch to Study Mode';
        break;
      case AppThemeMode.study:
        themeIcon = Icons.dark_mode;
        themeTooltip = 'Switch to Dark Mode';
        break;
    }

    Color appBarBg = themeProvider.isStudy
        ? ThemeProvider.studyBg
        : themeProvider.isLight
            ? const Color(0xFF0D47A1)
            : const Color(0xFF071320);

    Color themeBadgeColor = themeProvider.isStudy
        ? const Color(0xFFFFD600)
        : themeProvider.isLight
            ? Colors.white70
            : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBg,
        elevation: 0,
        title: Row(
          children: [
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
          if (themeProvider.isStudy)
            Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD600).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFD600).withOpacity(0.5)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.nightlight_round, size: 14, color: Color(0xFFFFD600)),
                  const SizedBox(width: 4),
                  Text(
                    'Study Mode',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFD600),
                    ),
                  ),
                ],
              ),
            ),
          IconButton(
            icon: const Icon(Icons.calculate, color: Color(0xFFFFD600)),
            tooltip: 'Virtual Calculator',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VirtualCalculatorScreen()),
            ),
          ),
          IconButton(
            icon: Icon(themeIcon, color: themeBadgeColor),
            tooltip: themeTooltip,
            onPressed: themeProvider.cycleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero banner
            _HeroBanner(progress: progress, themeProvider: themeProvider),
            const SizedBox(height: 20),

            // Stats row
            _StatsRow(progress: progress),
            const SizedBox(height: 24),

            // Main Feature Cards: Modules & AI Assistant
            Row(
              children: [
                Expanded(
                  child: _FeaturedActionCard(
                    title: 'Start Learning',
                    subtitle: 'Modules with Theory & Quiz',
                    icon: Icons.school,
                    gradient: const [Color(0xFF1565C0), Color(0xFF0D47A1)],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LearningPathScreen()),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FeaturedActionCard(
                    title: 'AI Study Assistant',
                    subtitle: 'Ask doubts, get answers',
                    icon: Icons.smart_toy,
                    gradient: const [Color(0xFF6A1B9A), Color(0xFF4A148C)],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AiChatScreen()),
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

            // Study tip banner (shown only in study mode)
            if (themeProvider.isStudy) ...[
              _StudyModeBanner(),
              const SizedBox(height: 16),
            ],

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

// HERO BANNER
class _HeroBanner extends StatelessWidget {
  final ProgressProvider progress;
  final ThemeProvider themeProvider;

  const _HeroBanner({required this.progress, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final overall = progress.overallPercent;
    final gradient = themeProvider.isStudy
        ? const [Color(0xFF2E2E1A), Color(0xFF3E3E20)]
        : const [Color(0xFF1565C0), Color(0xFF0D47A1)];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GATE 2026 Preparation',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Electronics & Communication Engineering',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your progress',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                LinearPercentIndicator(
                  percent: overall.clamp(0.0, 1.0),
                  lineHeight: 8,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  progressColor: const Color(0xFFFFD600),
                  barRadius: const Radius.circular(10),
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 4),
                Text(
                  '${(overall * 100 < 10 && overall > 0 ? (overall * 100).toStringAsFixed(1) : (overall * 100).toInt())}% complete',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFD600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircularPercentIndicator(
            radius: 40,
            lineWidth: 6,
            percent: overall.clamp(0.0, 1.0),
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(overall * 100).toInt()}%',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            progressColor: const Color(0xFFFFD600),
            backgroundColor: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}

// STATS ROW
class _StatsRow extends StatelessWidget {
  final ProgressProvider progress;
  const _StatsRow({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          icon: '\u26a1',
          value: '${progress.streak}',
          label: 'Day Streak',
          color: const Color(0xFFFF8F00),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const StreakScreen()),
          ),
        ),
        const SizedBox(width: 10),
        _StatCard(
          icon: '\u2b50',
          value: '${progress.totalXP}',
          label: 'Total XP',
          color: const Color(0xFF6A1B9A),
        ),
        const SizedBox(width: 10),
        _StatCard(
          icon: '\ud83d\udcca',
          value: '${progress.todayCompleted}/${progress.dailyGoal}',
          label: 'Daily Goal',
          color: const Color(0xFF2E7D32),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TopicsScreen()),
          ),
        ),
      ],
    );
  }
}

// FEATURED ACTION CARD (gradient top card)
class _FeaturedActionCard extends StatelessWidget {
  final String title, subtitle;
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
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.9), size: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// STUDY MODE BANNER
class _StudyModeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFD600).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: Color(0xFFFFD600), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Study Mode is active. Low blue light for comfortable night-time studying.',
              style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFFFFD600), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon, value, label;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
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
      ),
    );
  }
}

// QUICK ACTIONS GRID (updated with FAQ and AI)
class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.tune, 'label': 'TCS Virtual Calc', 'color': const Color(0xFFE65100), 'screen': const VirtualCalculatorScreen()},
      {'icon': Icons.bolt, 'label': 'Streak & Goals', 'color': const Color(0xFFFF8F00), 'screen': const StreakScreen()},
      {'icon': Icons.history_edu, 'label': 'GATE PYQ Papers', 'color': const Color(0xFF1565C0), 'screen': const PreviousYearsScreen()},
      {'icon': Icons.help_center, 'label': 'FAQ Topics', 'color': const Color(0xFFC62828), 'screen': const FaqScreen()},
      {'icon': Icons.style_outlined, 'label': 'Flashcards', 'color': const Color(0xFF6A1B9A), 'screen': const FlashcardsScreen()},
      {'icon': Icons.military_tech_outlined, 'label': 'PSU & Score Guide', 'color': const Color(0xFF2E7D32), 'screen': const ScoreGuideScreen()},
      {'icon': Icons.waves, 'label': 'Circuit Labs', 'color': const Color(0xFF0277BD), 'screen': const CircuitVisualizerScreen()},
      {'icon': Icons.map_outlined, 'label': 'Learning Path', 'color': const Color(0xFF00897B), 'screen': const LearningPathScreen()},
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.3,
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
                Icon(a['icon'] as IconData, color: a['color'] as Color, size: 22),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    a['label'] as String,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      color: a['color'] as Color,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
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

// TOPIC PROGRESS TILE
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

// ABOUT CARD
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
              'Featuring 80+ verified questions with step-by-step solutions, AI study assistant, circuit simulation, TCS iON virtual calculator, and three eye-comfort themes.',
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
                  child: Text(
                    'Version 2.0.0 - Production Ready',
                    style: GoogleFonts.inter(fontSize: 11, color: Colors.greenAccent, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
