// lib/screens/streak_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../providers/progress_provider.dart';

const List<String> _motivationalQuotes = [
  '"Success is the sum of small efforts, repeated day in and day out." — Robert Collier',
  '"The expert in anything was once a beginner." — Helen Hayes',
  '"Don\'t wish it were easier. Wish you were better." — Jim Rohn',
  '"Engineering is not only study of 45 subjects but it is moral studies of intellectual life." — Prakhar Srivastav',
  '"The more that you read, the more things you will know." — Dr. Seuss',
  '"Consistency is the key. Show up every day." — GATE Topper AIR 12',
  '"Hard work beats talent when talent doesn\'t work hard." — Tim Notke',
  '"GATE is not a test of intelligence — it is a test of preparation." — Kamal',
  '"Every day you study is a day closer to your dream PSU & IIT rank." — Anonymous',
  '"Focus on progress, not perfection." — Unknown',
  '"Discipline is the bridge between goals and accomplishment." — Jim Rohn',
  '"Your future rank is created by what you do today, not tomorrow." — Robert Kiyosaki',
];

class _MilestoneBadge {
  final int days;
  final String label;
  final String icon;
  final Color color;
  final String perk;
  const _MilestoneBadge({
    required this.days,
    required this.label,
    required this.icon,
    required this.color,
    required this.perk,
  });
}

const List<_MilestoneBadge> _badges = [
  _MilestoneBadge(days: 3, label: '3-Day Spark', icon: '🔥', color: Color(0xFFE65100), perk: '+50 Bonus XP'),
  _MilestoneBadge(days: 7, label: '7-Day Warrior', icon: '⚡', color: Color(0xFF1565C0), perk: '+100 Bonus XP & Streak Freeze'),
  _MilestoneBadge(days: 14, label: '2-Week Master', icon: '🏆', color: Color(0xFF6A1B9A), perk: '+250 Bonus XP'),
  _MilestoneBadge(days: 30, label: 'Monthly Legend', icon: '💎', color: Color(0xFF00897B), perk: '+500 Bonus XP & Gold Badge'),
  _MilestoneBadge(days: 60, label: 'AIR 1 Champion', icon: '👑', color: Color(0xFFFFD600), perk: 'Unlocks Master Ranker Status'),
];

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _numberAnim;
  late Animation<double> _numberAnimation;
  late ConfettiController _confettiController;
  int _quoteIndex = 0;

  @override
  void initState() {
    super.initState();
    _quoteIndex = Random().nextInt(_motivationalQuotes.length);
    _numberAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _numberAnimation = CurvedAnimation(parent: _numberAnim, curve: Curves.easeOutBack);
    _numberAnim.forward();

    _confettiController = ConfettiController(duration: const Duration(seconds: 3));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final streak = Provider.of<ProgressProvider>(context, listen: false).streak;
      if (streak >= 3) {
        _confettiController.play();
      }
    });
  }

  @override
  void dispose() {
    _numberAnim.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ProgressProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF071320) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Daily Streak & Mastery',
          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFFFD600)),
            tooltip: 'New Motivational Quote',
            onPressed: () {
              setState(() {
                _quoteIndex = (_quoteIndex + 1) % _motivationalQuotes.length;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Hero Streak Display
                _buildHeroStreak(progress),
                const SizedBox(height: 24),

                // 2. Duolingo-style Streak Freeze Shield
                _buildStreakFreezeCard(progress),
                const SizedBox(height: 16),

                // 3. Today\'s Study Goal
                _buildDailyGoalCard(progress),
                const SizedBox(height: 20),

                // 4. Weekly Activity Calendar
                _buildWeeklyCalendar(progress),
                const SizedBox(height: 24),

                // 5. Milestone Badges
                _buildMilestones(progress),
                const SizedBox(height: 24),

                // 6. Daily Topper Quote
                _buildQuoteCard(),
                const SizedBox(height: 24),

                // 7. Action CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE65100),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.bolt, color: Color(0xFFFFD600)),
                    label: Text(
                      'Study Today\'s Module ➔',
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          // Confetti overlay
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Color(0xFFFFD600),
                Color(0xFFE65100),
                Color(0xFF1565C0),
                Color(0xFF10B981),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStreak(ProgressProvider progress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFBF360C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE65100).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          ScaleTransition(
            scale: _numberAnimation,
            child: const Text('🔥', style: TextStyle(fontSize: 64)),
          ),
          const SizedBox(height: 10),
          ScaleTransition(
            scale: _numberAnimation,
            child: Text(
              '${progress.streak}',
              style: GoogleFonts.inter(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
          Text(
            progress.streak == 1 ? 'DAY STREAK' : 'DAYS STREAK!',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              color: const Color(0xFFFFD600),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            progress.streak > 0
                ? 'You are on fire! Consistency builds GATE AIR < 100.'
                : 'Start your study streak today! Complete any topic module.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakFreezeCard(ProgressProvider progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0288D1).withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF0288D1).withOpacity(0.35)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0288D1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text('🛡️', style: TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Streak Freeze Shield',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: const Color(0xFF0288D1),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0288D1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${progress.streakFreezes} Active',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'If you miss 1 day of study, a freeze auto-consumes to protect your streak from resetting to zero.',
                  style: GoogleFonts.inter(fontSize: 11, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyGoalCard(ProgressProvider progress) {
    final pct = progress.dailyGoalPercent;
    final isMet = progress.isDailyGoalMet;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isMet ? const Color(0xFF10B981).withOpacity(0.12) : const Color(0xFF1565C0).withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isMet ? const Color(0xFF10B981).withOpacity(0.4) : const Color(0xFF1565C0).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 32.0,
            lineWidth: 6.0,
            percent: pct,
            center: Text(
              '${progress.todayCompleted}/${progress.dailyGoal}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: isMet ? const Color(0xFF10B981) : const Color(0xFF1565C0),
              ),
            ),
            progressColor: isMet ? const Color(0xFF10B981) : const Color(0xFF1565C0),
            backgroundColor: Colors.grey.withOpacity(0.2),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isMet ? '🎉 Daily Goal Accomplished!' : 'Today\'s Target Goal',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: isMet ? const Color(0xFF10B981) : const Color(0xFF1565C0),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isMet
                      ? 'Awesome work! Your daily streak is safe and +50 XP bonus earned.'
                      : 'Complete ${progress.dailyGoal - progress.todayCompleted} more module(s) or quizzes today.',
                  style: GoogleFonts.inter(fontSize: 11, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyCalendar(ProgressProvider progress) {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final now = DateTime.now();
    final currentWeekday = now.weekday; // 1 = Monday, 7 = Sunday

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week\'s Momentum',
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final dayIndex = i + 1;
              final isToday = dayIndex == currentWeekday;
              final isPastOrToday = dayIndex <= currentWeekday;
              // Check if completed today or has active streak
              final isActive = isPastOrToday && progress.streak >= (currentWeekday - dayIndex + 1);

              return Column(
                children: [
                  Text(
                    days[i],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
                      color: isToday ? const Color(0xFFFFD600) : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFFE65100)
                          : isToday
                              ? const Color(0xFFFFD600).withOpacity(0.2)
                              : Colors.grey.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: isToday
                          ? Border.all(color: const Color(0xFFFFD600), width: 2)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isActive ? '🔥' : (isPastOrToday ? '✓' : '•'),
                      style: TextStyle(
                        fontSize: isActive ? 16 : 14,
                        color: isActive ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestones(ProgressProvider progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Streak Milestones',
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            Text(
              'Total XP: ${progress.totalXP}',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFD600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._badges.map((b) {
          final isUnlocked = progress.streak >= b.days;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUnlocked ? b.color.withOpacity(0.12) : Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isUnlocked ? b.color.withOpacity(0.4) : Colors.grey.withOpacity(0.15),
              ),
            ),
            child: Row(
              children: [
                Text(
                  b.icon,
                  style: TextStyle(
                    fontSize: 28,
                    color: isUnlocked ? null : Colors.grey,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b.label,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: isUnlocked ? b.color : Colors.grey,
                        ),
                      ),
                      Text(
                        b.perk,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: isUnlocked ? Colors.grey : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isUnlocked ? b.color : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isUnlocked ? 'UNLOCKED' : '${b.days} Days',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: isUnlocked ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildQuoteCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6A1B9A).withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF6A1B9A).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('💡', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                'Topper Wisdom',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: const Color(0xFF6A1B9A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _motivationalQuotes[_quoteIndex],
            style: GoogleFonts.inter(
              fontStyle: FontStyle.italic,
              fontSize: 13,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
