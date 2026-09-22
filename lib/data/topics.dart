import 'package:flutter/material.dart';

/// One entry per official GATE ECE syllabus section.
/// This list is the backbone of the app — Formula Sheet, Quiz, and
/// Circuit Library screens all filter by `id`.
class Topic {
  final String id;
  final String title;
  final IconData icon;
  final String weightageNote;

  const Topic({
    required this.id,
    required this.title,
    required this.icon,
    required this.weightageNote,
  });
}

const List<Topic> gateEceTopics = [
  Topic(id: 'maths', title: 'Engineering Mathematics', icon: Icons.functions, weightageNote: '~13% weightage'),
  Topic(id: 'networks', title: 'Network Theory', icon: Icons.electrical_services, weightageNote: 'High weightage'),
  Topic(id: 'analog', title: 'Analog Electronics', icon: Icons.memory, weightageNote: 'High weightage'),
  Topic(id: 'edc', title: 'Electronic Devices & Circuits', icon: Icons.developer_board, weightageNote: 'Core topic'),
  Topic(id: 'digital', title: 'Digital Circuits', icon: Icons.dialpad, weightageNote: 'High scoring'),
  Topic(id: 'signals', title: 'Signals and Systems', icon: Icons.graphic_eq, weightageNote: 'High weightage'),
  Topic(id: 'control', title: 'Control Systems', icon: Icons.tune, weightageNote: 'High weightage'),
  Topic(id: 'communication', title: 'Communication Systems', icon: Icons.podcasts, weightageNote: 'Core topic'),
  Topic(id: 'em', title: 'Electromagnetic Theory', icon: Icons.waves, weightageNote: 'High scoring'),
];
