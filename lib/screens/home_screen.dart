import 'package:flutter/material.dart';
import '../data/topics.dart';
import '../widgets/circuit_painter.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const HomeScreen({super.key, required this.isDarkMode, required this.onToggleTheme});

  // Placeholder exam date — swap for the real GATE date once announced,
  // or better, make this editable in Settings later.
  static final DateTime examDate = DateTime(2027, 2, 7);

  int get daysLeft => examDate.difference(DateTime.now()).inDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GATE ECE Companion'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: onToggleTheme,
            tooltip: 'Toggle night reading mode',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          _CountdownCard(daysLeft: daysLeft),
          const SizedBox(height: 24),
          Text('Sample circuit diagram', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  RcCircuitDiagram(),
                  SizedBox(height: 8),
                  Text('Series RC circuit — drawn entirely in code',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Topics', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          ...gateEceTopics.map((t) => _TopicTile(topic: t)),
        ],
      ),
    );
  }
}

class _CountdownCard extends StatelessWidget {
  final int daysLeft;
  const _CountdownCard({required this.daysLeft});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: scheme.primary.withOpacity(0.12),
              child: Text('$daysLeft', style: TextStyle(fontWeight: FontWeight.bold, color: scheme.primary)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Days left to GATE', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('Stay consistent — one topic at a time.',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicTile extends StatelessWidget {
  final Topic topic;
  const _TopicTile({required this.topic});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: CircleAvatar(
            backgroundColor: scheme.primary.withOpacity(0.12),
            child: Icon(topic.icon, color: scheme.primary),
          ),
          title: Text(topic.title, style: Theme.of(context).textTheme.titleMedium),
          subtitle: Text(topic.weightageNote, style: Theme.of(context).textTheme.bodyMedium),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Next step: wire this to the Formula Sheet screen for topic.id
          },
        ),
      ),
    );
  }
}
