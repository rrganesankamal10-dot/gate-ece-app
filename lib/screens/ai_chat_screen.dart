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
      text: '👋 Hello! I am your GATE ECE Study Assistant.\n\n'
          'You can ask me about:\n'
          '• Exam info (e.g. "How many questions in GATE?", "cutoff", "marking")\n'
          '• Key theorems (e.g. "Thevenin theorem", "Norton", "Nyquist rate")\n'
          '• Subject formulas (e.g. "MOSFET", "Op-Amp", "Bode plot", "Routh")\n'
          '• Quick revisions (e.g. "revise control", "revise signals")\n\n'
          'How can I help you today?',
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

  /// Converts raw LaTeX strings into clean, readable math notation
  static String cleanMath(String text) {
    var s = text;
    // Replace fractions: \frac{A}{B} -> (A) / (B)
    s = s.replaceAllMapped(RegExp(r'\\frac\{([^{}]+)\}\{([^{}]+)\}'), (m) => '${m[1]} / (${m[2]})');
    s = s.replaceAllMapped(RegExp(r'\\frac\{([^{}]+)\}\{([^{}]+)\}'), (m) => '(${m[1]}) / (${m[2]})');

    // Subscripts & Greek letters
    s = s.replaceAll(r'\omega_{pc}', 'ω_pc')
         .replaceAll(r'\omega_{gc}', 'ω_gc')
         .replaceAll(r'\omega', 'ω')
         .replaceAll(r'\Omega', 'Ω')
         .replaceAll(r'\pi', 'π')
         .replaceAll(r'\tau', 'τ')
         .replaceAll(r'\lambda', 'λ')
         .replaceAll(r'\mu_n', 'μ_n')
         .replaceAll(r'\mu_p', 'μ_p')
         .replaceAll(r'\mu', 'μ')
         .replaceAll(r'\sigma', 'σ')
         .replaceAll(r'\delta', 'δ')
         .replaceAll(r'\alpha', 'α')
         .replaceAll(r'\beta', 'β')
         .replaceAll(r'\eta', 'η')
         .replaceAll(r'\theta', 'θ')
         .replaceAll(r'\epsilon', 'ε');

    // Mathematical symbols
    s = s.replaceAll(r'\sqrt', '√')
         .replaceAll(r'\cdot', '·')
         .replaceAll(r'\times', '×')
         .replaceAll(r'\pm', '±')
         .replaceAll(r'\leq', '≤')
         .replaceAll(r'\geq', '≥')
         .replaceAll(r'\neq', '≠')
         .replaceAll(r'\approx', '≈')
         .replaceAll(r'\infty', '∞')
         .replaceAll(r'\int', '∫')
         .replaceAll(r'\sum', '∑')
         .replaceAll(r'\partial', '∂')
         .replaceAll(r'\nabla', '∇')
         .replaceAll(r'\angle', '∠')
         .replaceAll(r'\cdots', '…')
         .replaceAll(r'\dots', '…')
         .replaceAll(r'\Rightarrow', ' ⇒ ')
         .replaceAll(r'\rightarrow', ' → ')
         .replaceAll(r'\Leftarrow', ' ⇐ ')
         .replaceAll(r'\leftarrow', ' ← ');

    // Formatting tags & spacing
    s = s.replaceAllMapped(RegExp(r'\\text\{([^}]+)\}'), (m) => m[1]!)
         .replaceAll(r'\quad', '  ')
         .replaceAll(r'\qquad', '   ')
         .replaceAll(r'\,', ' ')
         .replaceAll(r'\;', ' ')
         .replaceAll(r'\!', '')
         .replaceAll(r'\left(', '(')
         .replaceAll(r'\right)', ')')
         .replaceAll(r'\left[', '[')
         .replaceAll(r'\right]', ']')
         .replaceAll(r'\log', 'log')
         .replaceAll(r'\ln', 'ln')
         .replaceAll(r'\sin', 'sin')
         .replaceAll(r'\cos', 'cos')
         .replaceAll(r'\tan', 'tan');

    // Clean common power/subscript representations
    s = s.replaceAll(r'^{2}', '²')
         .replaceAll(r'^{3}', '³')
         .replaceAll(r'^2', '²')
         .replaceAll(r'^3', '³')
         .replaceAll(r'_{th}', '_th')
         .replaceAll(r'_{oc}', '_oc')
         .replaceAll(r'_{sc}', '_sc')
         .replaceAll(r'_{max}', '_max')
         .replaceAll(r'_{in}', '_in')
         .replaceAll(r'_{out}', '_out');

    return s.trim();
  }

  String _generateResponse(String query) {
    final q = query.toLowerCase().trim();

    // 1. GATE Exam Question Pattern & Structure
    if (q.contains('how many question') ||
        q.contains('pattern') ||
        q.contains('total question') ||
        q.contains('paper format') ||
        q.contains('exam structure') ||
        q.contains('number of question')) {
      return '📊 GATE ECE Question Paper Pattern:\n\n'
          '• Total Questions: 65 Questions\n'
          '• Total Marks: 100 Marks\n'
          '• Duration: 3 Hours (180 Minutes)\n\n'
          '📌 Section-wise Breakdown:\n'
          '1. General Aptitude (GA):\n'
          '   • 10 Questions = 15 Marks\n'
          '   • 5 questions of 1 mark each\n'
          '   • 5 questions of 2 marks each\n\n'
          '2. Technical (Core ECE + Engg. Mathematics):\n'
          '   • 55 Questions = 85 Marks\n'
          '   • Engineering Mathematics: ~13 Marks\n'
          '   • ECE Core Subjects: ~72 Marks\n'
          '   • 25 questions of 1 mark each\n'
          '   • 30 questions of 2 marks each\n\n'
          '⚖️ Question Types & Marking Rules:\n'
          '• MCQ (Multiple Choice Questions):\n'
          '   - 1-mark question: -1/3 negative mark for wrong answer\n'
          '   - 2-mark question: -2/3 negative mark for wrong answer\n'
          '• MSQ (Multiple Select Questions):\n'
          '   - One or more correct options. NO negative marking. Full marks only if all correct options are selected.\n'
          '• NAT (Numerical Answer Type):\n'
          '   - Real number entered via virtual numeric keypad. NO negative marking!';
    }

    // 2. Marking & Negative Marking Scheme
    if (q.contains('negative mark') || q.contains('marking scheme') || q.contains('marking rule')) {
      return '⚖️ GATE ECE Marking Scheme:\n\n'
          '• 1-Mark MCQ: +1 for correct, -0.33 (-1/3) for wrong answer.\n'
          '• 2-Mark MCQ: +2 for correct, -0.67 (-2/3) for wrong answer.\n'
          '• NAT (Numerical Questions): +1 or +2 for correct. 0 for wrong (ZERO negative marking).\n'
          '• MSQ (Multiple Select): +1 or +2 for correct. 0 for wrong (ZERO negative marking, no partial marks).\n'
          '• Unattempted questions: 0 marks.\n\n'
          '💡 Strategy: Never guess blindly on MCQs, but always attempt NAT and MSQ questions since there is no negative marking penalty!';
    }

    // 3. Cutoff & Score Analysis
    if (q.contains('cutoff') || q.contains('cut off') || q.contains('qualifying mark')) {
      return '📈 GATE ECE Typical Cutoff Trends:\n\n'
          '• General (General / Open): 25 – 29 Marks (out of 100)\n'
          '• OBC-NCL / EWS: 22 – 26 Marks\n'
          '• SC / ST / PwD: 16 – 19 Marks\n\n'
          '🎯 Marks required for Top Opportunities:\n'
          '• IISc Bangalore & Top IITs (VLSI / Microelectronics / Comms): 65+ Marks (Score ~750+)\n'
          '• Other IITs / Top NITs: 50 – 60 Marks (Score ~600–720)\n'
          '• PSUs (ONGC, IOCL, ISRO, DRDO, BEL): 70+ Marks (Rank under 200)';
    }

    // 4. Subject Weightage
    if (q.contains('weightage') || q.contains('marks distribution') || q.contains('important subject')) {
      return '📊 GATE ECE Subject-wise Marks Weightage:\n\n'
          '1. General Aptitude: 15 Marks (Fixed)\n'
          '2. Engineering Mathematics: 13 Marks (Fixed)\n'
          '3. Semiconductor Devices (EDC): 9 – 11 Marks\n'
          '4. Analog Circuits: 8 – 10 Marks\n'
          '5. Signals & Systems: 8 – 10 Marks\n'
          '6. Control Systems: 8 – 10 Marks\n'
          '7. Digital Circuits: 7 – 9 Marks\n'
          '8. Network Theory: 7 – 9 Marks\n'
          '9. Communications: 10 – 12 Marks\n'
          '10. Electromagnetics: 7 – 9 Marks\n\n'
          '💡 Top high-scoring combo: Aptitude + Maths + Networks + Signals + Digital provides ~45 marks with high accuracy!';
    }

    // 5. Virtual Calculator
    if (q.contains('calculator') || q.contains('virtual calc')) {
      return '🧮 TCS iON Virtual Calculator Tips for GATE:\n\n'
          '• No physical calculator is permitted in the exam hall.\n'
          '• Practice using mouse clicks on the on-screen calculator.\n'
          '• Use brackets carefully: e.g. for (A+B)/(C+D), calculate numerator, then store or divide.\n'
          '• Switch between Deg (degrees) and Rad (radians) as required for trigonometric operations.\n'
          '• Use the built-in Virtual Calculator tab in this app to practice before the exam!';
    }

    // 6. Thevenin's Theorem
    if (q.contains('thevenin')) {
      return '⚡ Thevenin\'s Theorem:\n\n'
          'Any linear, two-terminal bilateral network can be replaced by an equivalent circuit consisting of a single independent voltage source Vth in series with resistance Rth.\n\n'
          '📐 Step-by-Step Procedure:\n'
          '1. Identify and remove the load resistance RL.\n'
          '2. Find Vth: Calculate the open-circuit voltage across the open terminals (Vth = Voc).\n'
          '3. Find Rth:\n'
          '   • Deactivate all independent sources (Voltage sources → Short circuit; Current sources → Open circuit).\n'
          '   • Look into the open terminals to calculate equivalent resistance Rth.\n'
          '   • (If dependent sources are present: Rth = Voc / Isc, or apply 1V test source).\n\n'
          '📐 Key Formulas:\n'
          '• Load Current: IL = Vth / (Rth + RL)\n'
          '• Load Voltage: VL = IL · RL = Vth · RL / (Rth + RL)\n'
          '• Maximum Power Transfer: When RL = Rth:\n'
          '  Pmax = Vth² / (4 · Rth)\n\n'
          '📝 Quick Example:\n'
          'If a circuit has Voc = 24 V and short-circuit current Isc = 4 A:\n'
          '→ Rth = 24 / 4 = 6 Ω\n'
          '→ For RL = 6 Ω, Pmax = (24)² / (4 × 6) = 576 / 24 = 24 W!';
    }

    // 7. Norton's Theorem
    if (q.contains('norton')) {
      return '⚡ Norton\'s Theorem:\n\n'
          'Any linear, bilateral two-terminal network can be replaced by an equivalent current source IN in parallel with resistance RN.\n\n'
          '📐 Key Relations:\n'
          '• IN = Isc (Short-circuit current across load terminals)\n'
          '• RN = Rth (Norton resistance is identical to Thevenin resistance)\n'
          '• Source Transformation:\n'
          '  Vth = IN · RN   and   IN = Vth / Rth\n'
          '• Load Current: IL = IN · [RN / (RN + RL)]';
    }

    // 8. Nyquist Sampling Rate
    if (q.contains('nyquist') || q.contains('sampling rate')) {
      return '📊 Nyquist Sampling Theorem:\n\n'
          'To reconstruct a continuous-time bandlimited signal without aliasing, the sampling frequency fs must be at least twice the maximum frequency component fmax.\n\n'
          '📐 Key Formulas:\n'
          '• Nyquist Rate: fs ≥ 2 · fmax\n'
          '• Nyquist Interval: Ts ≤ 1 / (2 · fmax)\n\n'
          '📝 Common GATE Examples:\n'
          '• If x(t) = sinc(200t): fmax = 100 Hz → Nyquist Rate = 200 Hz.\n'
          '• If x(t) = sinc²(200t): Multiplication in time means convolution in frequency → Bandwidth doubles: fmax = 200 Hz → Nyquist Rate = 400 Hz!\n'
          '• For product x1(t) · x2(t): fs_rate = 2 · (fmax1 + fmax2)';
    }

    // 9. Shannon Capacity
    if (q.contains('shannon') || q.contains('channel capacity')) {
      return '📡 Shannon-Hartley Channel Capacity Theorem:\n\n'
          'C = B · log₂(1 + SNR)  [bps]\n\n'
          '• C = Theoretical maximum information rate (bps)\n'
          '• B = Channel bandwidth (Hz)\n'
          '• SNR = Signal-to-noise ratio in linear power ratio (NOT in dB)\n\n'
          '📝 Example:\n'
          'B = 4 kHz, SNR = 255 (or ~24 dB):\n'
          '1 + SNR = 256 = 2⁸\n'
          '→ C = 4000 · log₂(2⁸) = 4000 × 8 = 32,000 bps = 32 kbps!';
    }

    // 10. Bode Plot & Stability Margins
    if (q.contains('bode') || q.contains('gain margin') || q.contains('phase margin')) {
      return '📈 Bode Plot & Stability Criteria:\n\n'
          '📐 Frequency Definitions:\n'
          '• Gain Crossover Frequency (ω_gc): Frequency where |G(jω)| = 1 (i.e. magnitude is 0 dB).\n'
          '• Phase Crossover Frequency (ω_pc): Frequency where phase ∠G(jω) = -180°.\n\n'
          '📐 Margins:\n'
          '• Gain Margin (GM):\n'
          '  GM = -20 · log₁₀|G(jω_pc)| dB\n'
          '• Phase Margin (PM):\n'
          '  PM = 180° + ∠G(jω_gc)\n\n'
          '⚖️ Stability for Minimum Phase Systems:\n'
          '• Stable: ω_gc < ω_pc  (GM > 0 dB, PM > 0°)\n'
          '• Marginally Stable: ω_gc = ω_pc  (GM = 0 dB, PM = 0°)\n'
          '• Unstable: ω_gc > ω_pc  (GM < 0 dB, PM < 0°)';
    }

    // 11. Routh-Hurwitz Stability
    if (q.contains('routh')) {
      return '📐 Routh-Hurwitz Stability Criterion:\n\n'
          'For a closed-loop characteristic equation P(s) = a_n·sⁿ + … + a₀ = 0:\n\n'
          '1. Necessary Condition: All coefficients must be non-zero and possess the same sign.\n'
          '2. Sufficient Condition: All terms in the first column of the Routh array must be strictly positive (no sign changes).\n\n'
          '📌 Important GATE Special Cases:\n'
          '• Sign change in 1st column: The number of sign changes equals the number of roots in the Right Half Plane (RHP) → Unstable.\n'
          '• First element of a row is zero: Replace zero with a small positive ε and continue, or substitute s = 1/z.\n'
          '• Entire row of zeros: Indicates roots symmetric about the origin (e.g. imaginary axis poles ±jω). Form auxiliary polynomial A(s) from the row above and take derivative dA(s)/ds.';
    }

    // 12. MOSFET equations
    if (q.contains('mosfet')) {
      return '🔬 MOSFET Operational Regions (N-Channel Enhancement):\n\n'
          '1. Cutoff Region:\n'
          '   • V_GS < V_TH\n'
          '   • I_D = 0 A\n\n'
          '2. Triode (Linear) Region:\n'
          '   • V_GS ≥ V_TH  and  V_DS < (V_GS - V_TH)\n'
          '   • I_D = μ_n·C_ox·(W/L) · [(V_GS - V_TH)·V_DS - (V_DS)² / 2]\n\n'
          '3. Saturation Region:\n'
          '   • V_GS ≥ V_TH  and  V_DS ≥ (V_GS - V_TH)\n'
          '   • I_D = (1/2) · μ_n·C_ox·(W/L) · (V_GS - V_TH)²\n'
          '   • Transconductance: g_m = 2·I_D / (V_GS - V_TH) = √(2·μ_n·C_ox·(W/L)·I_D)\n'
          '   • Output Resistance: r_o = 1 / (λ · I_D) = V_A / I_D';
    }

    // 13. Op-Amp
    if (q.contains('opamp') || q.contains('op-amp')) {
      return '⚡ Op-Amp Golden Rules & Standard Circuits:\n\n'
          'Rules for Ideal Op-Amp with Negative Feedback:\n'
          '1. Virtual Short: V₊ = V₋\n'
          '2. Virtual Open: Input currents I₊ = I₋ = 0 A (Z_in = ∞)\n\n'
          '📐 Common Topologies:\n'
          '• Inverting Amp: V_out = -(R_f / R_in) · V_in\n'
          '• Non-Inverting Amp: V_out = (1 + R_f / R_in) · V_in\n'
          '• Voltage Follower: V_out = V_in  (Buffer with gain = 1)\n'
          '• Integrator: V_out(t) = -(1 / (R·C)) · ∫ V_in(t) dt\n'
          '• Differentiator: V_out(t) = -R·C · (d V_in / dt)\n'
          '• CMRR = |A_d / A_cm| (Ideal CMRR = ∞)';
    }

    // FAQ topics
    if (q.contains('faq')) {
      for (final entry in faqTopics.entries) {
        if (q.contains(entry.key) || q.contains(_topicName(entry.key).toLowerCase())) {
          return '📊 FAQ Topics for ${_topicName(entry.key)}:\n\n'
              '${entry.value.asMap().entries.map((e) => '${e.key + 1}. ${e.value}').join('\n')}\n\n'
              'These are high-yield questions repeatedly tested in GATE. Focus on these!';
        }
      }
      return '📊 Available subjects for FAQ:\n'
          '${faqTopics.keys.map((k) => '• ${_topicName(k)}').join('\n')}\n\n'
          'Type "FAQ <subject>" to view high-yield topics.';
    }

    // Quick revision for any subject
    if (q.contains('revise') || q.contains('revision') || q.contains('summary')) {
      for (final entry in faqTopics.entries) {
        if (q.contains(entry.key) || q.contains(_topicName(entry.key).toLowerCase())) {
          final topicFormulas = gateFormulas.where((f) => topicIdsMatch(f.topicId, entry.key)).take(5);
          final formulasText = topicFormulas.isNotEmpty
              ? '\nKey Formulas:\n${topicFormulas.map((f) => '• ${f.title}: ${cleanMath(f.latex)}').join('\n')}\n'
              : '';
          return '📝 Quick Revision for ${_topicName(entry.key)}:\n'
              '$formulasText\n'
              'Key Topics to Revise:\n${entry.value.map((t) => '• $t').join('\n')}';
        }
      }
    }

    // Search formulas by keyword with clean formatting
    for (final formula in gateFormulas) {
      if (q.length > 3 && (formula.title.toLowerCase().contains(q) || formula.description.toLowerCase().contains(q))) {
        return '📌 Formula: ${formula.title}\n\n'
            '📐 Equation:\n${cleanMath(formula.latex)}\n\n'
            '📖 Explanation:\n${formula.description}\n\n'
            '📝 Example: ${cleanMath(formula.example)}';
      }
    }

    // Search questions by keyword
    for (final question in gateQuestions) {
      if (q.length > 4 && question.question.toLowerCase().contains(q)) {
        return '📝 GATE Practice Question:\n\n'
            'Q: ${question.question}\n\n'
            'Options:\n${question.options.asMap().entries.map((e) => '${String.fromCharCode(65 + e.key)}) ${e.value}').join('\n')}\n\n'
            'Correct Answer: Option ${String.fromCharCode(65 + question.correctIndex)}\n\n'
            'Step-by-Step Solution:\n${cleanMath(question.explanation)}';
      }
    }

    // Partial formula match
    final words = q.split(RegExp(r'\s+'));
    for (final word in words) {
      if (word.length < 3) continue;
      for (final formula in gateFormulas) {
        if (formula.title.toLowerCase().contains(word)) {
          return '📌 Related Formula: ${formula.title}\n\n'
              '📐 Equation:\n${cleanMath(formula.latex)}\n\n'
              '📖 Explanation:\n${formula.description}\n\n'
              '📝 Example: ${cleanMath(formula.example)}';
        }
      }
    }

    // Helpful default fallback
    return '💡 I am here to help with your GATE ECE preparation!\n\n'
        'You can ask me:\n'
        '• "How many questions in GATE?"\n'
        '• "Negative marking rules"\n'
        '• "Thevenin theorem formula and example"\n'
        '• "Nyquist sampling theorem"\n'
        '• "Bode plot gain and phase margin"\n'
        '• "MOSFET equations"\n'
        '• "Revise signals" or "Revise control"\n\n'
        'Try typing one of these topics!';
  }

  String _topicName(String key) {
    const names = {
      'networks': 'Network Theory',
      'signals': 'Signals & Systems',
      'edc': 'Electronic Devices (EDC)',
      'devices': 'Electronic Devices (EDC)',
      'analog': 'Analog Electronics',
      'digital': 'Digital Circuits',
      'control': 'Control Systems',
      'communication': 'Communications',
      'communications': 'Communications',
      'em': 'Electromagnetics',
      'electromagnetics': 'Electromagnetics',
      'maths': 'Engg. Mathematics',
      'math': 'Engg. Mathematics',
    };
    return names[key] ?? key.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _ChatBubble(msg: msg, isDark: isDark);
              },
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0D1B2A) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white12 : Colors.grey.shade200,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                        style: GoogleFonts.inter(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Ask about any GATE topic...',
                          hintStyle: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: const Color(0xFF1565C0),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: _sendMessage,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send, color: Colors.white, size: 20),
                      ),
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
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage msg;
  final bool isDark;

  const _ChatBubble({required this.msg, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        decoration: BoxDecoration(
          color: msg.isUser
              ? const Color(0xFF1565C0)
              : isDark
                  ? const Color(0xFF1E293B)
                  : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
            bottomRight: Radius.circular(msg.isUser ? 4 : 16),
          ),
          border: msg.isUser
              ? null
              : Border.all(
                  color: isDark ? Colors.white12 : Colors.grey.shade300,
                  width: 0.8,
                ),
        ),
        child: SelectableText(
          msg.text,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            height: 1.5,
            color: msg.isUser
                ? Colors.white
                : isDark
                    ? Colors.white
                    : const Color(0xFF1E293B),
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