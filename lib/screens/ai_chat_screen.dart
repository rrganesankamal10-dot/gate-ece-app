// lib/screens/ai_chat_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/questions_data.dart';
import '../data/topics_data.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add(_ChatMessage(
      text: 'Hello! I am your GATE ECE Study Assistant.\n\n'
          'Ask me about any topic:\n'
          '- Formulas (e.g. "Nyquist rate")\n'
          '- Concepts (e.g. "BIBO stability")\n'
          '- FAQ topics (e.g. "FAQ signals")\n'
          '- Quick revision (e.g. "revise control")\n\n'
          'Type your question below!',
      isUser: false,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _messages.add(_ChatMessage(text: _generateResponse(text), isUser: false));
    });
    _controller.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _generateResponse(String query) {
    final q = query.toLowerCase().trim();

    // FAQ topics
    if (q.contains('faq')) {
      for (final entry in faqTopics.entries) {
        if (q.contains(entry.key) || q.contains(_topicName(entry.key).toLowerCase())) {
          return '\ud83d\udcca FAQ Topics for ${_topicName(entry.key)}:\n\n${entry.value.asMap().entries.map((e) => '${e.key + 1}. ${e.value}').join('\n')}\n\nThese are the most frequently asked topics in GATE. Focus on these!';
        }
      }
      return '\ud83d\udcca Available subjects for FAQ:\n${faqTopics.keys.map((k) => '- ${_topicName(k)}').join('\n')}\n\nType "FAQ <subject>" to see top topics.';
    }

    // Quick revision
    if (q.contains('revise') || q.contains('revision') || q.contains('summary')) {
      for (final entry in faqTopics.entries) {
        if (q.contains(entry.key) || q.contains(_topicName(entry.key).toLowerCase())) {
          final topicFormulas = gateFormulas.where((f) => f.topicId == entry.key).take(5);
          if (topicFormulas.isEmpty) {
            return '\ud83d\udcdd Quick Revision for ${_topicName(entry.key)}:\n\nKey topics:\n${entry.value.map((t) => '\u2022 $t').join('\n')}';
          }
          return '\ud83d\udcdd Quick Revision for ${_topicName(entry.key)}:\n\n'
              'Key Formulas:\n${topicFormulas.map((f) => '\u2022 ${f.title}: ${f.latex}').join('\n')}\n\n'
              'Key Topics:\n${entry.value.map((t) => '\u2022 $t').join('\n')}';
        }
      }
    }

    // Search questions by keyword
    for (final question in gateQuestions) {
      if (q.length > 3 && question.question.toLowerCase().contains(q)) {
        return '\ud83d\udcdd Found a matching question:\n\n'
            'Q: ${question.question}\n\n'
            'Options:\n${question.options.asMap().entries.map((e) => '${String.fromCharCode(65 + e.key)}) ${e.value}').join('\n')}\n\n'
            'Answer: ${String.fromCharCode(65 + question.correctIndex)}\n\n'
            '${question.explanation}';
      }
    }

    // Search formulas by keyword
    for (final formula in gateFormulas) {
      if (q.length > 3 && (formula.title.toLowerCase().contains(q) || formula.description.toLowerCase().contains(q))) {
        return '\ud83d\udccc Formula: ${formula.title}\n\n'
            '\ud83d\udcdd ${formula.latex}\n\n'
            '${formula.description}\n\n'
            'Example: ${formula.example}';
      }
    }

    // Subject-specific keyword responses
    final Map<String, String> quickAnswers = {
      'nyquist': '\ud83d\udccc Nyquist Sampling Theorem:\nfs >= 2 x fmax\n\nSampling rate must be at least twice the highest frequency component to avoid aliasing.\n\nExample: Audio 20 kHz -> fs >= 40 kHz (CD: 44.1 kHz)',
      'thevenin': '\ud83d\udccc Thevenin Theorem:\nAny linear circuit can be replaced by Vth in series with Rth.\n\nVth = Open-circuit voltage\nRth = Equivalent resistance (sources killed)\n\nNorton: IN = Vth/Rth, RN = Rth',
      'norton': '\ud83d\udccc Norton Theorem:\nIN = Vth/Rth (short-circuit current)\nRN = Rth\n\nNorton is the dual of Thevenin.',
      'bibo': '\ud83d\udccc BIBO Stability:\nBounded Input -> Bounded Output\n\nContinuous: All poles in LHP (Re(s) < 0)\nDiscrete: All poles inside unit circle (|z| < 1)\n\nCondition: integral of |h(t)| dt < infinity',
      'laplace': '\ud83d\udccc Common Laplace Transforms:\n\u2022 u(t) -> 1/s\n\u2022 e^(-at)u(t) -> 1/(s+a)\n\u2022 t*e^(-at)u(t) -> 1/(s+a)^2\n\u2022 sin(wt)u(t) -> w/(s^2+w^2)\n\u2022 cos(wt)u(t) -> s/(s^2+w^2)\n\u2022 delta(t) -> 1',
      'z-transform': '\ud83d\udccc Common Z-Transforms:\n\u2022 a^n u[n] -> z/(z-a), |z|>|a|\n\u2022 n*a^n u[n] -> az/(z-a)^2\n\u2022 u[n] -> z/(z-1)\n\u2022 delta[n] -> 1',
      'mosfet': '\ud83d\udccc MOSFET Regions:\n\u2022 Cutoff: VGS < Vth (OFF)\n\u2022 Linear: VDS < VGS-Vth, ID = kn(W/L)[(VGS-Vth)VDS - VDS^2/2]\n\u2022 Saturation: VDS >= VGS-Vth, ID = (kn/2)(W/L)(VGS-Vth)^2',
      'bjt': '\ud83d\udccc BJT Relations:\n\u2022 IC = beta * IB\n\u2022 IE = IC + IB = (beta+1) * IB\n\u2022 alpha = IC/IE = beta/(beta+1)\n\u2022 gm = IC/VT (VT = 26 mV at 300K)',
      'op-amp': '\ud83d\udccc Op-Amp Configurations:\n\u2022 Inverting: Av = -Rf/Rin\n\u2022 Non-Inverting: Av = 1 + Rf/R1\n\u2022 Buffer: Av = +1\n\u2022 Summing: Vo = -(Rf/R1*V1 + Rf/R2*V2 + ...)\n\u2022 Differentiator: Vo = -RC dVin/dt',
      'shannon': '\ud83d\udccc Shannon Channel Capacity:\nC = B * log2(1 + SNR) bits/s\n\nB = channel bandwidth (Hz)\nSNR = signal-to-noise ratio (not in dB!)\n\nExample: B=4kHz, SNR=31 -> C = 4000 x 5 = 20 kbps',
      'routh': '\ud83d\udccc Routh-Hurwitz Criterion:\n1. Form Routh array from characteristic polynomial\n2. Count sign changes in first column\n3. Sign changes = number of RHP poles\n4. All positive first column = stable\n\nSpecial cases: row of zeros (use auxiliary polynomial)',
      'bode': '\ud83d\udccc Bode Plot:\n\u2022 GM at phase crossover freq (phase = -180 deg)\n\u2022 PM at gain crossover freq (|G| = 0 dB)\n\u2022 Stable if GM > 0 dB and PM > 0 deg\n\u2022 Pole: -20 dB/decade slope\n\u2022 Zero: +20 dB/decade slope',
      'maxwell': '\ud83d\udccc Maxwell Equations:\n1. curl E = -dB/dt (Faraday)\n2. curl H = J + dD/dt (Ampere + displacement)\n3. div D = rho_v (Gauss electric)\n4. div B = 0 (Gauss magnetic)\n\nConstitutive: D=eE, B=uH, J=sigmaE',
      'skin depth': '\ud83d\udccc Skin Depth:\ndelta = 1/sqrt(pi*f*mu*sigma)\n\nHigher freq -> smaller skin depth\nCopper at 1MHz: delta ~ 66 um\nCurrent concentrated near surface of conductor.',
      'vswr': '\ud83d\udccc VSWR & Reflection:\nGamma = (ZL-Z0)/(ZL+Z0)\nVSWR = (1+|Gamma|)/(1-|Gamma|)\n\nMatched: VSWR = 1 (ideal)\nOpen: VSWR = infinity\nShort: VSWR = infinity',
    };

    for (final entry in quickAnswers.entries) {
      if (q.contains(entry.key)) {
        return entry.value;
      }
    }

    // Generic help
    if (q.contains('help') || q.contains('what can you do')) {
      return '\ud83d\udcda I can help you with:\n\n'
          '\u2022 Formula lookup: "Nyquist", "Thevenin", "MOSFET"\n'
          '\u2022 FAQ topics: "FAQ signals", "FAQ control"\n'
          '\u2022 Quick revision: "revise analog", "revise digital"\n'
          '\u2022 Concept explanation: "BIBO", "Routh", "Bode"\n'
          '\u2022 Question search: Type any keyword\n\n'
          'Try asking something specific!';
    }

    // Try partial match on formulas
    final words = q.split(RegExp(r'\s+'));
    for (final word in words) {
      if (word.length < 3) continue;
      for (final formula in gateFormulas) {
        if (formula.title.toLowerCase().contains(word)) {
          return '\ud83d\udccc Related Formula: ${formula.title}\n\n'
              '${formula.latex}\n\n'
              '${formula.description}\n\n'
              'Example: ${formula.example}';
        }
      }
    }

    return '\ud83e\udd14 I could not find a specific answer for "$query".\n\n'
        'Try:\n'
        '\u2022 More specific keywords (e.g. "Nyquist", "MOSFET")\n'
        '\u2022 "FAQ <subject>" for top topics\n'
        '\u2022 "revise <subject>" for quick revision\n'
        '\u2022 "help" for all commands';
  }

  String _topicName(String id) {
    switch (id) {
      case 'networks': return 'Networks & Circuit Theory';
      case 'signals': return 'Signals & Systems';
      case 'edc': return 'Electronic Devices';
      case 'analog': return 'Analog Electronics';
      case 'digital': return 'Digital Circuits';
      case 'control': return 'Control Systems';
      case 'communication': return 'Communications';
      case 'em': return 'Electromagnetics';
      case 'maths': return 'Engg. Mathematics';
      default: return id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Study Assistant',
          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildBubble(msg);
              },
            ),
          ),
          // Input bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask about any GATE topic...',
                        hintStyle: GoogleFonts.inter(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      style: GoogleFonts.inter(fontSize: 14),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(_ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
        decoration: BoxDecoration(
          color: msg.isUser
              ? const Color(0xFF1565C0)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
            bottomRight: Radius.circular(msg.isUser ? 4 : 16),
          ),
        ),
        child: Text(
          msg.text,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            height: 1.5,
            color: msg.isUser
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage({required this.text, required this.isUser});
}