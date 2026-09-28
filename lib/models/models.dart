class GateTopic {
  final String id;
  final String name;
  final String subtitle;
  final String icon;
  final String color;
  final List<String> subtopics;

  const GateTopic({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.subtopics,
  });
}

class GateFormula {
  final String id;
  final String topicId;
  final String title;
  final String latex;
  final String description;
  final String example;

  const GateFormula({
    required this.id,
    required this.topicId,
    required this.title,
    required this.latex,
    required this.description,
    required this.example,
  });
}

class GateQuestion {
  final String id;
  final String topicId;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String difficulty; // 'Easy', 'Medium', 'Hard'
  final int year; // GATE year (0 = practice)

  const GateQuestion({
    required this.id,
    required this.topicId,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.difficulty = 'Medium',
    this.year = 0,
  });
}

class MockTest {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final List<String> questionIds;
  final int totalMarks;

  const MockTest({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.questionIds,
    required this.totalMarks,
  });
}

class FormulaCalculator {
  final String id;
  final String topicId;
  final String name;
  final String formula;
  final String description;
  final List<CalculatorField> inputs;
  final String outputUnit;
  final String Function(Map<String, double>) calculate;

  const FormulaCalculator({
    required this.id,
    required this.topicId,
    required this.name,
    required this.formula,
    required this.description,
    required this.inputs,
    required this.outputUnit,
    required this.calculate,
  });
}

class CalculatorField {
  final String id;
  final String label;
  final String unit;
  final double defaultValue;
  final String hint;

  const CalculatorField({
    required this.id,
    required this.label,
    required this.unit,
    this.defaultValue = 0.0,
    this.hint = '',
  });
}
