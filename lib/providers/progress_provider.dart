// lib/providers/progress_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressProvider extends ChangeNotifier {
  Map<String, int> _topicProgress = {}; // topicId -> questions answered
  Map<String, int> _topicTotal = {};    // topicId -> total questions
  Map<String, List<bool>> _mockResults = {}; // mockId -> list of correct/wrong
  Set<String> _bookmarkedFormulas = {};
  int _totalXP = 0;
  int _streak = 0;
  DateTime? _lastActiveDate;

  // Duolingo-style Streak & Gamification fields
  int _streakFreezes = 2; // Duolingo streak freeze shields
  int _dailyGoal = 3;     // Target modules/quizzes per day
  int _todayCompleted = 0;
  String? _todayDateStr;

  // Module tracking & Chapter quiz scores
  Map<String, Set<int>> _moduleProgress = {}; // topicId -> set of completed module indices
  Map<String, int> _chapterQuizScores = {}; // topicId -> best score

  Map<String, int> get topicProgress => _topicProgress;
  Map<String, int> get topicTotal => _topicTotal;
  Map<String, List<bool>> get mockResults => _mockResults;
  Set<String> get bookmarkedFormulas => _bookmarkedFormulas;
  int get totalXP => _totalXP;
  int get streak => _streak;
  DateTime? get lastActiveDate => _lastActiveDate;

  int get streakFreezes => _streakFreezes;
  int get dailyGoal => _dailyGoal;
  int get todayCompleted => _todayCompleted;
  double get dailyGoalPercent => (_todayCompleted / _dailyGoal).clamp(0.0, 1.0);
  bool get isDailyGoalMet => _todayCompleted >= _dailyGoal;

  ProgressProvider() {
    _load();
  }

  double getTopicPercent(String topicId) {
    final done = _topicProgress[topicId] ?? 0;
    final total = _topicTotal[topicId] ?? 1;
    return (done / total).clamp(0.0, 1.0);
  }

  static const int totalSyllabusUnits = 180; // 9 subjects * 20 units: 1 module = 0.55%, 1 whole chapter = ~11% (approx 10%)

  double get overallPercent {
    int totalCompletedModules = 0;
    for (final completedSet in _moduleProgress.values) {
      totalCompletedModules += completedSet.length;
    }
    if (totalCompletedModules == 0) {
      int done = _topicProgress.values.fold(0, (a, b) => a + b);
      return (done / totalSyllabusUnits).clamp(0.0, 1.0);
    }
    return (totalCompletedModules / totalSyllabusUnits).clamp(0.0, 1.0);
  }

  int getMockScore(String mockId) {
    final results = _mockResults[mockId] ?? [];
    return results.where((r) => r).length;
  }

  Future<void> recordAnswer(String topicId, int totalInTopic, bool correct) async {
    _topicTotal[topicId] = totalInTopic;
    _topicProgress[topicId] = (_topicProgress[topicId] ?? 0) + 1;
    if (correct) _totalXP += 10;
    _incrementToday();
    _updateStreak();
    await _save();
    notifyListeners();
  }

  Future<void> recordMockResult(String mockId, List<bool> results) async {
    _mockResults[mockId] = results;
    int correct = results.where((r) => r).length;
    _totalXP += correct * 15;
    _incrementToday();
    _updateStreak();
    await _save();
    notifyListeners();
  }

  Future<void> toggleBookmark(String formulaId) async {
    if (_bookmarkedFormulas.contains(formulaId)) {
      _bookmarkedFormulas.remove(formulaId);
    } else {
      _bookmarkedFormulas.add(formulaId);
    }
    await _save();
    notifyListeners();
  }

  bool isBookmarked(String formulaId) => _bookmarkedFormulas.contains(formulaId);

  // â”€â”€â”€ MODULE PROGRESS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Mark a module as complete. Adds XP, updates streak, and increments daily goal.
  Future<void> markModuleComplete(String topicId, int moduleIndex, int totalModules) async {
    _moduleProgress[topicId] ??= {};
    final wasNew = !_moduleProgress[topicId]!.contains(moduleIndex);
    _moduleProgress[topicId]!.add(moduleIndex);

    if (wasNew) {
      _totalXP += 20;
      // Update topic-level progress based on modules
      _topicTotal[topicId] = totalModules;
      _topicProgress[topicId] = _moduleProgress[topicId]!.length;
      _incrementToday();
      _updateStreak();
    }

    await _save();
    notifyListeners();
  }

  /// Returns true if the specific module index for a topic is complete.
  bool isModuleComplete(String topicId, int moduleIndex) {
    return _moduleProgress[topicId]?.contains(moduleIndex) ?? false;
  }

  /// Returns true if ALL modules for the given topic are complete.
  bool isTopicFullyComplete(String topicId) {
    final total = _topicTotal[topicId] ?? 0;
    if (total == 0) return false;
    return (_moduleProgress[topicId]?.length ?? 0) >= total;
  }

  /// Returns the number of completed modules for a topic.
  int completedModules(String topicId) {
    return _moduleProgress[topicId]?.length ?? 0;
  }

  // â”€â”€â”€ CHAPTER QUIZ SCORES â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Record the result of a chapter quiz. Stores the best (highest) score.
  Future<void> recordChapterQuizResult(String topicId, int score, int total) async {
    final existing = _chapterQuizScores[topicId] ?? 0;
    if (score > existing) {
      _chapterQuizScores[topicId] = score;
    }
    // Award bonus XP for the quiz (up to +50 XP)
    _totalXP += score * 10;
    _incrementToday();
    _updateStreak();
    await _save();
    notifyListeners();
  }

  /// Returns the best chapter quiz score for a given topic.
  int getChapterQuizScore(String topicId) {
    return _chapterQuizScores[topicId] ?? 0;
  }

  // â”€â”€â”€ STREAK & FREEZES (DUOLINGO STYLE) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  void _incrementToday() {
    final today = _dateKey(DateTime.now());
    if (_todayDateStr != today) {
      _todayDateStr = today;
      _todayCompleted = 1;
    } else {
      _todayCompleted++;
    }
  }

  void _updateStreak() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (_lastActiveDate == null) {
      _streak = 1;
    } else {
      final last = DateTime(_lastActiveDate!.year, _lastActiveDate!.month, _lastActiveDate!.day);
      final diff = today.difference(last).inDays;
      if (diff == 0) {
        // Already active today; retain streak
      } else if (diff == 1) {
        // Consecutive day
        _streak++;
      } else if (diff == 2 && _streakFreezes > 0) {
        // Missed one day, but streak freeze saved it!
        _streakFreezes--;
        _streak++; // continue streak
      } else {
        // Streak reset to 1
        _streak = 1;
      }
    }
    _lastActiveDate = today;
  }

  Future<void> addStreakFreeze() async {
    _streakFreezes++;
    await _save();
    notifyListeners();
  }

  String _dateKey(DateTime dt) => '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';

  // â”€â”€â”€ PERSISTENCE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('topicProgress', jsonEncode(_topicProgress));
    await prefs.setString('topicTotal', jsonEncode(_topicTotal));
    await prefs.setString('mockResults', jsonEncode(
      _mockResults.map((k, v) => MapEntry(k, v.map((b) => b ? 1 : 0).toList()))
    ));
    await prefs.setStringList('bookmarks', _bookmarkedFormulas.toList());
    await prefs.setInt('totalXP', _totalXP);
    await prefs.setInt('streak', _streak);
    await prefs.setInt('streakFreezes', _streakFreezes);
    await prefs.setInt('dailyGoal', _dailyGoal);
    await prefs.setInt('todayCompleted', _todayCompleted);
    if (_todayDateStr != null) {
      await prefs.setString('todayDateStr', _todayDateStr!);
    }
    if (_lastActiveDate != null) {
      await prefs.setString('lastActive', _lastActiveDate!.toIso8601String());
    }
    await prefs.setString('moduleProgress', jsonEncode(
      _moduleProgress.map((k, v) => MapEntry(k, v.toList()))
    ));
    await prefs.setString('chapterQuizScores', jsonEncode(_chapterQuizScores));
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final tp = prefs.getString('topicProgress');
    final tt = prefs.getString('topicTotal');
    final mr = prefs.getString('mockResults');
    final bm = prefs.getStringList('bookmarks');
    _totalXP = prefs.getInt('totalXP') ?? 0;
    _streak = prefs.getInt('streak') ?? 0;
    _streakFreezes = prefs.getInt('streakFreezes') ?? 2;
    _dailyGoal = prefs.getInt('dailyGoal') ?? 3;
    _todayCompleted = prefs.getInt('todayCompleted') ?? 0;
    _todayDateStr = prefs.getString('todayDateStr');

    final today = _dateKey(DateTime.now());
    if (_todayDateStr != today) {
      _todayDateStr = today;
      _todayCompleted = 0;
    }

    final la = prefs.getString('lastActive');
    if (la != null) _lastActiveDate = DateTime.tryParse(la);

    if (tp != null) {
      _topicProgress = Map<String, int>.from(jsonDecode(tp));
    }
    if (tt != null) {
      _topicTotal = Map<String, int>.from(jsonDecode(tt));
    }
    if (mr != null) {
      final raw = Map<String, dynamic>.from(jsonDecode(mr));
      _mockResults = raw.map((k, v) =>
        MapEntry(k, (v as List).map((e) => e == 1).toList()));
    }
    if (bm != null) _bookmarkedFormulas = bm.toSet();

    final mp = prefs.getString('moduleProgress');
    if (mp != null) {
      final raw = Map<String, dynamic>.from(jsonDecode(mp));
      _moduleProgress = raw.map((k, v) =>
        MapEntry(k, Set<int>.from((v as List).map((e) => e as int))));
    }

    final cqs = prefs.getString('chapterQuizScores');
    if (cqs != null) {
      _chapterQuizScores = Map<String, int>.from(jsonDecode(cqs));
    }

    notifyListeners();
  }
}
