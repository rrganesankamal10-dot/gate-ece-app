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

  Map<String, int> get topicProgress => _topicProgress;
  Map<String, int> get topicTotal => _topicTotal;
  Map<String, List<bool>> get mockResults => _mockResults;
  Set<String> get bookmarkedFormulas => _bookmarkedFormulas;
  int get totalXP => _totalXP;
  int get streak => _streak;

  ProgressProvider() {
    _load();
  }

  double getTopicPercent(String topicId) {
    final done = _topicProgress[topicId] ?? 0;
    final total = _topicTotal[topicId] ?? 1;
    return (done / total).clamp(0.0, 1.0);
  }

  double get overallPercent {
    if (_topicTotal.isEmpty) return 0.0;
    int done = _topicProgress.values.fold(0, (a, b) => a + b);
    int total = _topicTotal.values.fold(0, (a, b) => a + b);
    return total == 0 ? 0.0 : (done / total).clamp(0.0, 1.0);
  }

  int getMockScore(String mockId) {
    final results = _mockResults[mockId] ?? [];
    return results.where((r) => r).length;
  }

  Future<void> recordAnswer(String topicId, int totalInTopic, bool correct) async {
    _topicTotal[topicId] = totalInTopic;
    _topicProgress[topicId] = (_topicProgress[topicId] ?? 0) + 1;
    if (correct) _totalXP += 10;
    _updateStreak();
    await _save();
    notifyListeners();
  }

  Future<void> recordMockResult(String mockId, List<bool> results) async {
    _mockResults[mockId] = results;
    int correct = results.where((r) => r).length;
    _totalXP += correct * 15;
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

  void _updateStreak() {
    final today = DateTime.now();
    if (_lastActiveDate == null) {
      _streak = 1;
    } else {
      final diff = today.difference(_lastActiveDate!).inDays;
      if (diff == 0) {
        // same day, no change
      } else if (diff == 1) {
        _streak++;
      } else {
        _streak = 1;
      }
    }
    _lastActiveDate = today;
  }

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
    if (_lastActiveDate != null) {
      await prefs.setString('lastActive', _lastActiveDate!.toIso8601String());
    }
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final tp = prefs.getString('topicProgress');
    final tt = prefs.getString('topicTotal');
    final mr = prefs.getString('mockResults');
    final bm = prefs.getStringList('bookmarks');
    _totalXP = prefs.getInt('totalXP') ?? 0;
    _streak = prefs.getInt('streak') ?? 0;
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
    notifyListeners();
  }
}
