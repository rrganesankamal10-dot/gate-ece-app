// lib/screens/ai_chat_screen.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isLoading = false;
  String _apiKey = '';

  final List<String> _quickSuggestions = [
    'How many questions in GATE?',
    'Thevenin\'s Theorem',
    'Nyquist Sampling Rate',
    'MOSFET Saturation Current',
    'Bode Plot GM & PM',
    'Op-Amp Golden Rules',
    'Shannon Channel Capacity',
    'Negative Marking Rules',
  ];

  @override
  void initState() {
    super.initState();
    _loadApiKey();
    _messages.add(_ChatMessage(
      text: 'Hello! I am your GATE ECE AI Study Assistant.\n\n'
          'You can ask me anything about:\n'
          '\u2022 Exam pattern & structure (questions, marks, cutoffs)\n'
          '\u2022 Core network theorems & formulas (Thevenin, Norton, Superposition)\n'
          '\u2022 Semiconductor devices & Analog (MOSFET, BJT, Op-Amp, Diodes)\n'
          '\u2022 Signals & Systems, Control, Communications, Electromagnetics\n'
          '\u2022 Step-by-step numerical problem solving\n\n'
          'Tap any topic below or type your question!',
      isUser: false,
      source: 'GATE ECE AI',
    ));
  }

  Future<void> _loadApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('gemini_api_key') ?? '';
    });
  }

  Future<void> _saveApiKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gemini_api_key', key.trim());
    setState(() {
      _apiKey = key.trim();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage([String? presetText]) async {
    final text = (presetText ?? _controller.text).trim();
    if (text.isEmpty || _isLoading) return;

    if (presetText == null) {
      _controller.clear();
    }

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });
    _scrollToBottom();

    String responseText = '';
    String responseSource = 'ECE Neural Engine';

    // If API key is configured, call live Gemini API
    if (_apiKey.isNotEmpty) {
      try {
        responseText = await _callGeminiApi(text);
        responseSource = 'Gemini 1.5 Flash (Live AI)';
      } catch (e) {
        // Fall back gracefully to local expert engine
        responseText = _generateLocalResponse(text);
        responseSource = 'ECE Neural Engine (Offline Fallback)';
      }
    } else {
      // Local instant neural engine
      await Future.delayed(const Duration(milliseconds: 250));
      responseText = _generateLocalResponse(text);
      responseSource = 'ECE Neural Engine';
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
        _messages.add(_ChatMessage(
          text: responseText,
          isUser: false,
          source: responseSource,
        ));
      });
      _scrollToBottom();
    }
  }

  Future<String> _callGeminiApi(String prompt) async {
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 15);

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey',
    );

    final request = await client.postUrl(url);
    request.headers.set('Content-Type', 'application/json');

    final systemInstruction =
        'You are the expert GATE ECE AI Tutor created for GATE ECE Master app. '
        'Answer with authoritative, high-accuracy engineering precision at IIT GATE level. '
        'Always format formulas cleanly using standard readable Unicode symbols '
        '(e.g., \u03A9 for Ohms, \u03C0 for pi, \u03C9 for omega, \u03BC for micro, \u00B2 for squared, \u00B3 for cubed, \u221A for square root, \u00D7 for times, \u2248 for approx). '
        'NEVER output raw LaTeX backslashes or commands like \\frac or \\omega. '
        'Include step-by-step derivations or numerical procedures where applicable.';

    final payload = {
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': '$systemInstruction\n\nStudent Query: $prompt'}
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.3,
        'maxOutputTokens': 1000,
      }
    };

    request.write(jsonEncode(payload));
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    client.close();

    if (response.statusCode == 200) {
      final data = jsonDecode(responseBody);
      final candidates = data['candidates'] as List?;
      if (candidates != null && candidates.isNotEmpty) {
        final content = candidates[0]['content'];
        final parts = content['parts'] as List?;
        if (parts != null && parts.isNotEmpty) {
          final text = parts[0]['text'] as String?;
          if (text != null && text.isNotEmpty) {
            return cleanMath(text);
          }
        }
      }
    }
    throw Exception('API error (${response.statusCode})');
  }

  /// Converts raw LaTeX strings into clean, readable Unicode math notation
  static String cleanMath(String text) {
    var s = text;
    // Replace fractions: \frac{A}{B} -> (A) / (B)
    s = s.replaceAllMapped(
      RegExp(r'\\frac\{([^{}]+)\}\{([^{}]+)\}'),
      (m) => '(${m[1]}) / (${m[2]})',
    );
    s = s.replaceAllMapped(
      RegExp(r'\\frac\{([^{}]+)\}\{([^{}]+)\}'),
      (m) => '(${m[1]}) / (${m[2]})',
    );

    // Subscripts & Greek letters (using explicit unicode escapes to prevent encoding corruption)
    s = s.replaceAll(r'\omega_{pc}', '\u03C9_pc')
         .replaceAll(r'\omega_{gc}', '\u03C9_gc')
         .replaceAll(r'\omega', '\u03C9')
         .replaceAll(r'\Omega', '\u03A9')
         .replaceAll(r'\pi', '\u03C0')
         .replaceAll(r'\tau', '\u03C4')
         .replaceAll(r'\lambda', '\u03BB')
         .replaceAll(r'\mu_n', '\u03BC_n')
         .replaceAll(r'\mu_p', '\u03BC_p')
         .replaceAll(r'\mu', '\u03BC')
         .replaceAll(r'\sigma', '\u03C3')
         .replaceAll(r'\delta', '\u03B4')
         .replaceAll(r'\Delta', '\u0394')
         .replaceAll(r'\alpha', '\u03B1')
         .replaceAll(r'\beta', '\u03B2')
         .replaceAll(r'\eta', '\u03B7')
         .replaceAll(r'\theta', '\u03B8')
         .replaceAll(r'\epsilon', '\u03B5');

    // Mathematical symbols
    s = s.replaceAll(r'\sqrt', '\u221A')
         .replaceAll(r'\cdot', ' \u00B7 ')
         .replaceAll(r'\times', ' \u00D7 ')
         .replaceAll(r'\pm', '\u00B1')
         .replaceAll(r'\leq', ' \u2264 ')
         .replaceAll(r'\geq', ' \u2265 ')
         .replaceAll(r'\neq', ' \u2260 ')
         .replaceAll(r'\approx', ' \u2248 ')
         .replaceAll(r'\infty', '\u221E')
         .replaceAll(r'\int', '\u222B')
         .replaceAll(r'\sum', '\u2211')
         .replaceAll(r'\partial', '\u2202')
         .replaceAll(r'\nabla', '\u2207')
         .replaceAll(r'\angle', '\u2220')
         .replaceAll(r'\cdots', '...')
         .replaceAll(r'\dots', '...')
         .replaceAll(r'\Rightarrow', ' \u21D2 ')
         .replaceAll(r'\rightarrow', ' \u2192 ')
         .replaceAll(r'\Leftarrow', ' \u21D0 ')
         .replaceAll(r'\leftarrow', ' \u2190 ');

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

    // Powers & Subscripts
    s = s.replaceAll(r'^{2}', '\u00B2')
         .replaceAll(r'^{3}', '\u00B3')
         .replaceAll(r'^2', '\u00B2')
         .replaceAll(r'^3', '\u00B3')
         .replaceAll(r'_{th}', '_th')
         .replaceAll(r'_{oc}', '_oc')
         .replaceAll(r'_{sc}', '_sc')
         .replaceAll(r'_{max}', '_max')
         .replaceAll(r'_{in}', '_in')
         .replaceAll(r'_{out}', '_out');

    return s.trim();
  }

  String _generateLocalResponse(String query) {
    final q = query.toLowerCase().trim();

    // 1. GATE Exam Question Pattern & Structure
    if (q.contains('how many question') ||
        q.contains('pattern') ||
        q.contains('total question') ||
        q.contains('paper format') ||
        q.contains('exam structure') ||
        q.contains('number of question')) {
      return 'GATE ECE Question Paper Pattern:\n\n'
          '\u2022 Total Questions: 65 Questions\n'
          '\u2022 Total Marks: 100 Marks\n'
          '\u2022 Duration: 3 Hours (180 Minutes)\n\n'
          'Section-wise Breakdown:\n'
          '1. General Aptitude (GA):\n'
          '   \u2022 10 Questions = 15 Marks\n'
          '   \u2022 5 questions of 1 mark each\n'
          '   \u2022 5 questions of 2 marks each\n\n'
          '2. Technical (Core ECE + Engineering Mathematics):\n'
          '   \u2022 55 Questions = 85 Marks\n'
          '   \u2022 Engineering Mathematics: ~13 Marks\n'
          '   \u2022 Core ECE Subjects: ~72 Marks\n'
          '   \u2022 25 questions of 1 mark each\n'
          '   \u2022 30 questions of 2 marks each\n\n'
          'Question Types & Marking Rules:\n'
          '\u2022 MCQ (Multiple Choice Questions):\n'
          '   - 1-mark question: -1/3 (-0.33) mark for wrong answer\n'
          '   - 2-mark question: -2/3 (-0.67) mark for wrong answer\n'
          '\u2022 MSQ (Multiple Select Questions):\n'
          '   - One or more correct options. ZERO negative marking. Full marks only if all correct options are chosen.\n'
          '\u2022 NAT (Numerical Answer Type):\n'
          '   - Real number entered via virtual keypad. ZERO negative marking!';
    }

    // 2. Marking & Negative Marking Scheme
    if (q.contains('negative mark') || q.contains('marking scheme') || q.contains('marking rule')) {
      return 'GATE ECE Marking & Negative Marking Scheme:\n\n'
          '\u2022 1-Mark MCQ: +1 for correct, -0.33 (-1/3) for wrong answer.\n'
          '\u2022 2-Mark MCQ: +2 for correct, -0.67 (-2/3) for wrong answer.\n'
          '\u2022 NAT (Numerical Questions): +1 or +2 for correct. ZERO negative marks for wrong answers.\n'
          '\u2022 MSQ (Multiple Select Questions): +1 or +2 for correct. ZERO negative marks (no partial credit).\n'
          '\u2022 Unattempted Questions: 0 marks.\n\n'
          'Pro Strategy: Never guess blindly on MCQs, but always attempt NAT and MSQ questions since there is no negative mark penalty!';
    }

    // 3. Cutoff & Score Analysis
    if (q.contains('cutoff') || q.contains('cut off') || q.contains('qualifying mark')) {
      return 'GATE ECE Typical Cutoff Trends (Out of 100 Marks):\n\n'
          '\u2022 General / Open: 25 \u2013 29 Marks\n'
          '\u2022 OBC-NCL / EWS: 22 \u2013 26 Marks\n'
          '\u2022 SC / ST / PwD: 16 \u2013 19 Marks\n\n'
          'Marks Required for Top Opportunities:\n'
          '\u2022 IISc Bangalore & Top IITs (VLSI / Microelectronics / Comms): 65+ Marks (Score ~750+)\n'
          '\u2022 Other IITs / Top NITs: 50 \u2013 60 Marks (Score ~600\u2013720)\n'
          '\u2022 PSUs (ONGC, IOCL, ISRO, DRDO, BEL, BHEL): 70+ Marks (All India Rank under 200)';
    }

    // 4. Subject Weightage
    if (q.contains('weightage') || q.contains('marks distribution') || q.contains('important subject')) {
      return 'GATE ECE Subject-wise Marks Weightage:\n\n'
          '1. General Aptitude: 15 Marks (Fixed)\n'
          '2. Engineering Mathematics: 13 Marks (Fixed)\n'
          '3. Semiconductor Devices (EDC): 9 \u2013 11 Marks\n'
          '4. Analog Circuits: 8 \u2013 10 Marks\n'
          '5. Signals & Systems: 8 \u2013 10 Marks\n'
          '6. Control Systems: 8 \u2013 10 Marks\n'
          '7. Digital Circuits: 7 \u2013 9 Marks\n'
          '8. Network Theory: 7 \u2013 9 Marks\n'
          '9. Communications: 10 \u2013 12 Marks\n'
          '10. Electromagnetics: 7 \u2013 9 Marks\n\n'
          'High Scoring Foundation: Aptitude + Maths + Networks + Signals + Digital provides ~45 marks with maximum scoring certainty!';
    }

    // 5. Thevenin's Theorem
    if (q.contains('thevenin')) {
      return 'Thevenin\'s Theorem:\n\n'
          'Any linear, two-terminal bilateral network can be replaced by an equivalent circuit consisting of a single independent voltage source Vth in series with resistance Rth.\n\n'
          'Step-by-Step Procedure:\n'
          '1. Identify and remove the load resistor RL.\n'
          '2. Find Vth: Calculate the open-circuit voltage across terminals A-B (Vth = Voc).\n'
          '3. Find Rth:\n'
          '   \u2022 Deactivate all independent sources: Voltage sources \u2192 Short Circuit; Current sources \u2192 Open Circuit.\n'
          '   \u2022 Look into terminals A-B to calculate equivalent resistance Rth.\n'
          '   \u2022 If dependent sources are present: Apply 1V test source at load terminals (Rth = 1V / Itest) or calculate Rth = Voc / Isc.\n\n'
          'Key Formulas:\n'
          '\u2022 Load Current: IL = Vth / (Rth + RL)\n'
          '\u2022 Load Voltage: VL = IL \u00D7 RL = Vth \u00D7 RL / (Rth + RL)\n'
          '\u2022 Maximum Power Transfer: When RL = Rth:\n'
          '  Pmax = (Vth\u00B2) / (4 \u00D7 Rth)\n\n'
          'Numerical Example:\n'
          'If a circuit has Voc = 24 V and short-circuit current Isc = 4 A:\n'
          '\u2192 Rth = 24 / 4 = 6 \u03A9\n'
          '\u2192 For RL = 6 \u03A9, Pmax = (24\u00B2) / (4 \u00D7 6) = 576 / 24 = 24 W!';
    }

    // 6. Norton's Theorem
    if (q.contains('norton')) {
      return 'Norton\'s Theorem:\n\n'
          'Any linear, bilateral two-terminal network can be replaced by an equivalent current source IN in parallel with resistance RN.\n\n'
          'Key Relations:\n'
          '\u2022 IN = Isc (Short-circuit current flowing through load terminals)\n'
          '\u2022 RN = Rth (Norton resistance is identical to Thevenin resistance)\n'
          '\u2022 Source Transformation:\n'
          '  Vth = IN \u00D7 RN   and   IN = Vth / Rth\n'
          '\u2022 Load Current: IL = IN \u00D7 [RN / (RN + RL)]';
    }

    // 7. Maximum Power Transfer Theorem
    if (q.contains('maximum power') || q.contains('mptt')) {
      return 'Maximum Power Transfer Theorem:\n\n'
          '1. DC Circuit: RL = Rth \u21D2 Maximum power delivered to load.\n'
          '   Pmax = (Vth\u00B2) / (4 \u00D7 Rth)\n'
          '   Efficiency \u03B7 = 50% at maximum power transfer.\n\n'
          '2. AC Circuit with complex impedance Zth = Rth + j Xth:\n'
          '   \u2022 Both RL and XL variable: ZL = Zth* = Rth - j Xth (Complex Conjugate match).\n'
          '   \u2022 Only RL variable (purely resistive load): RL = |Zth| = \u221A(Rth\u00B2 + Xth\u00B2).\n'
          '   \u2022 Pmax = (|Vth|\u00B2) / (4 \u00D7 Rth)';
    }

    // 8. Nyquist Sampling Rate
    if (q.contains('nyquist') || q.contains('sampling rate')) {
      return 'Nyquist Sampling Theorem:\n\n'
          'To reconstruct a continuous-time bandlimited signal without aliasing, the sampling frequency fs must be at least twice the maximum frequency component fmax.\n\n'
          'Key Formulas:\n'
          '\u2022 Nyquist Sampling Rate: fs \u2265 2 \u00D7 fmax\n'
          '\u2022 Nyquist Interval: Ts = 1 / (2 \u00D7 fmax)\n\n'
          'Standard GATE Exam Cases:\n'
          '\u2022 Signal x(t) = sinc(200t): fmax = 100 Hz \u2192 Nyquist Rate = 200 Hz.\n'
          '\u2022 Signal x(t) = sinc\u00B2(200t): Multiplication in time represents convolution in frequency \u2192 Bandwidth doubles: fmax = 200 Hz \u2192 Nyquist Rate = 400 Hz!\n'
          '\u2022 Product x1(t) \u00D7 x2(t): fs_rate = 2 \u00D7 (fmax1 + fmax2)\n'
          '\u2022 Convolution x1(t) * x2(t): fs_rate = 2 \u00D7 min(fmax1, fmax2)';
    }

    // 9. Shannon Channel Capacity
    if (q.contains('shannon') || q.contains('channel capacity')) {
      return 'Shannon-Hartley Channel Capacity Theorem:\n\n'
          'C = B \u00D7 log\u2082(1 + SNR)  [in bits per second / bps]\n\n'
          '\u2022 C = Theoretical maximum information rate without error (bps)\n'
          '\u2022 B = Channel bandwidth (Hz)\n'
          '\u2022 SNR = Signal-to-noise power ratio in linear scale (NOT in dB)\n\n'
          'GATE Numerical Example:\n'
          'Given B = 4 kHz, SNR = 255 (or ~24 dB):\n'
          '1 + SNR = 1 + 255 = 256 = 2\u2078\n'
          '\u2192 C = 4000 \u00D7 log\u2082(2\u2078) = 4000 \u00D7 8 = 32,000 bps = 32 kbps!';
    }

    // 10. Bode Plot & Stability Margins
    if (q.contains('bode') || q.contains('gain margin') || q.contains('phase margin')) {
      return 'Bode Plot & Stability Margins:\n\n'
          'Frequency Definitions:\n'
          '\u2022 Gain Crossover Frequency (\u03C9_gc): Frequency where magnitude |G(j\u03C9)| = 1 (0 dB).\n'
          '\u2022 Phase Crossover Frequency (\u03C9_pc): Frequency where phase \u2220G(j\u03C9) = -180\u00B0.\n\n'
          'Margins:\n'
          '\u2022 Gain Margin (GM): GM = -20 \u00D7 log\u2081\u2080|G(j\u03C9_pc)| dB\n'
          '\u2022 Phase Margin (PM): PM = 180\u00B0 + \u2220G(j\u03C9_gc)\n\n'
          'Stability Criteria for Minimum Phase Systems:\n'
          '\u2022 Stable: \u03C9_gc < \u03C9_pc  (GM > 0 dB, PM > 0\u00B0)\n'
          '\u2022 Marginally Stable: \u03C9_gc = \u03C9_pc  (GM = 0 dB, PM = 0\u00B0)\n'
          '\u2022 Unstable: \u03C9_gc > \u03C9_pc  (GM < 0 dB, PM < 0\u00B0)';
    }

    // 11. Routh-Hurwitz Stability
    if (q.contains('routh')) {
      return 'Routh-Hurwitz Stability Criterion:\n\n'
          'For a closed-loop characteristic equation P(s) = a_n s\u207F + ... + a_0 = 0:\n\n'
          '1. Necessary Condition: All coefficients must be non-zero and possess the same sign.\n'
          '2. Sufficient Condition: All entries in the first column of the Routh array must be strictly positive (no sign changes).\n\n'
          'Critical GATE Special Cases:\n'
          '\u2022 Sign changes in 1st column: Number of sign changes = Number of roots in the Right Half Plane (RHP) \u2192 Unstable.\n'
          '\u2022 First element of a row is zero: Replace zero with a small positive \u03B5 > 0 and continue, or substitute s = 1/z.\n'
          '\u2022 Entire row of zeros: Indicates roots symmetric about the origin (e.g., imaginary axis poles \u00B1j\u03C9). Form auxiliary polynomial A(s) from the row above and differentiate dA(s)/ds.';
    }

    // 12. MOSFET Equations
    if (q.contains('mosfet')) {
      return 'MOSFET Operational Regions & Current Equations (NMOS):\n\n'
          '1. Cutoff Region:\n'
          '   \u2022 Condition: V_GS < V_TH\n'
          '   \u2022 Drain Current: I_D = 0 A\n\n'
          '2. Triode (Linear / Ohmic) Region:\n'
          '   \u2022 Condition: V_GS \u2265 V_TH  and  V_DS < (V_GS - V_TH)\n'
          '   \u2022 Drain Current: I_D = \u03BC_n C_ox (W/L) \u00D7 [(V_GS - V_TH) V_DS - (V_DS\u00B2) / 2]\n\n'
          '3. Saturation (Active) Region:\n'
          '   \u2022 Condition: V_GS \u2265 V_TH  and  V_DS \u2265 (V_GS - V_TH)\n'
          '   \u2022 Pinch-off at drain end: V_GD \u2264 V_TH\n'
          '   \u2022 Drain Current: I_D = (1/2) \u03BC_n C_ox (W/L) (V_GS - V_TH)\u00B2 (1 + \u03BB V_DS)\n'
          '   \u2022 Transconductance: g_m = \u2202I_D / \u2202V_GS = \u221A(2 \u03BC_n C_ox (W/L) I_D) = 2 I_D / (V_GS - V_TH)\n'
          '   \u2022 Small-Signal Output Resistance: r_o = 1 / (\u03BB I_D) = V_A / I_D';
    }

    // 13. Op-Amp Principles
    if (q.contains('opamp') || q.contains('op-amp')) {
      return 'Op-Amp Golden Rules & Standard Topologies:\n\n'
          'Ideal Op-Amp Characteristics (with negative feedback):\n'
          '1. Virtual Short: V+ = V- (Non-inverting and Inverting terminal voltages are equal)\n'
          '2. Virtual Open: Input currents I+ = I- = 0 A (Infinite input impedance Z_in = \u221E)\n'
          '3. Zero output impedance: Z_out = 0 \u03A9\n'
          '4. Infinite open-loop gain: A_OL = \u221E\n\n'
          'Standard Configurations:\n'
          '\u2022 Inverting Amplifier: V_out = -(R_f / R_in) \u00D7 V_in\n'
          '\u2022 Non-Inverting Amplifier: V_out = (1 + R_f / R_in) \u00D7 V_in\n'
          '\u2022 Voltage Follower (Buffer): V_out = V_in (Gain = 1)\n'
          '\u2022 Inverting Integrator: V_out(t) = -(1 / (R C)) \u222B V_in(t) dt\n'
          '\u2022 Inverting Differentiator: V_out(t) = -R C \u00D7 (d V_in / dt)\n'
          '\u2022 Difference Amplifier: V_out = (R2 / R1) \u00D7 (V2 - V1) (when bridge resistors are matched)';
    }

    // 14. Setup and Hold Time (Digital Circuits)
    if (q.contains('setup time') || q.contains('hold time') || q.contains('clock frequency')) {
      return 'Setup & Hold Time Timing Analysis (GATE Digital):\n\n'
          'Definitions:\n'
          '\u2022 Setup Time (t_su): Minimum time data must be stable BEFORE active clock edge.\n'
          '\u2022 Hold Time (t_h): Minimum time data must remain stable AFTER active clock edge.\n\n'
          'Timing Constraints for Flip-Flop to Flip-Flop:\n'
          '1. Maximum Clock Frequency (Setup Constraint):\n'
          '   T_clk \u2265 t_cq + t_comb_max + t_su\n'
          '   \u2192 f_clk_max = 1 / (t_cq + t_comb_max + t_su)\n'
          '2. Hold Time Constraint (Must be satisfied independently of clock period):\n'
          '   t_cq + t_comb_min \u2265 t_h\n'
          '   (If violated, hold time failure occurs and CANNOT be fixed by slowing down clock!)';
    }

    // 15. Maxwell's Equations & Electromagnetics
    if (q.contains('maxwell') || q.contains('electromagnetic') || q.contains('wave') || q.contains('intrinsic impedance')) {
      return 'Maxwell\'s Equations & Uniform Plane Waves:\n\n'
          'Maxwell\'s Equations (Differential Form):\n'
          '1. Gauss\'s Law for E: \u2207 \u00B7 D = \u03C1_v\n'
          '2. Gauss\'s Law for B: \u2207 \u00B7 B = 0 (No magnetic monopoles)\n'
          '3. Faraday\'s Law: \u2207 \u00D7 E = -\u2202B / \u2202t\n'
          '4. Ampere-Maxwell Law: \u2207 \u00D7 H = J + \u2202D / \u2202t\n\n'
          'Wave Properties in Lossless Media:\n'
          '\u2022 Intrinsic Impedance: \u03B7 = \u221A(\u03BC / \u03B5)\n'
          '  Free space: \u03B7_0 \u2248 120\u03C0 \u2248 377 \u03A9\n'
          '\u2022 Phase Velocity: v_p = 1 / \u221A(\u03BC \u03B5)\n'
          '\u2022 Skin Depth (Lossy media): \u03B4 = 1 / \u221A(\u03C0 f \u03BC \u03C3)\n'
          '\u2022 Reflection Coefficient: \u0393 = (Z_L - Z_0) / (Z_L + Z_0)\n'
          '\u2022 Standing Wave Ratio: VSWR = (1 + |\u0393|) / (1 - |\u0393|)';
    }

    // Search formulas by keyword
    for (final formula in gateFormulas) {
      if (q.length > 3 && (formula.title.toLowerCase().contains(q) || formula.description.toLowerCase().contains(q))) {
        return 'Formula: ${formula.title}\n\n'
            'Equation:\n${cleanMath(formula.latex)}\n\n'
            'Explanation:\n${formula.description}\n\n'
            'Example:\n${cleanMath(formula.example)}';
      }
    }

    // Search questions by keyword
    for (final question in gateQuestions) {
      if (q.length > 4 && question.question.toLowerCase().contains(q)) {
        return 'GATE Practice Question:\n\n'
            'Q: ${question.question}\n\n'
            "Options:\n" + question.options.asMap().entries.map((e) => String.fromCharCode(65 + e.key) + ": " + e.value).join("\n") + "\n\n"
            'Correct Answer: Option ${String.fromCharCode(65 + question.correctIndex)}\n\n'
            'Step-by-Step Solution:\n${cleanMath(question.explanation)}';
      }
    }

    // Helpful default response
    return 'I am ready to assist with any GATE ECE concept, formula, or problem!\n\n'
        'Quick Topics to Ask:\n'
        '\u2022 "How many questions in GATE?"\n'
        '\u2022 "Thevenin theorem formula and example"\n'
        '\u2022 "Nyquist sampling theorem"\n'
        '\u2022 "Bode plot gain and phase margin"\n'
        '\u2022 "MOSFET saturation equation"\n'
        '\u2022 "Setup and hold time"\n'
        '\u2022 "Shannon channel capacity"\n\n'
        'Tip: Tap the \u2699\uFE0F settings icon above to link your free Google Gemini API key for live AI answers to ANY custom question!';
  }

  void _showApiKeyDialog() {
    final keyController = TextEditingController(text: _apiKey);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.psychology, color: Color(0xFF1565C0)),
            const SizedBox(width: 8),
            Text(
              'Gemini AI Settings',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upgrade to live Google Gemini 1.5 Flash AI to answer ANY custom question with instant engineering accuracy.',
              style: GoogleFonts.inter(fontSize: 13, height: 1.4),
            ),
            const SizedBox(width: 8, height: 12),
            TextField(
              controller: keyController,
              decoration: const InputDecoration(
                labelText: 'Google Gemini API Key',
                hintText: 'AIzaSy...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                'How to get a key (100% Free):\n'
                '1. Go to aistudio.google.com\n'
                '2. Click "Get API key" -> "Create API key"\n'
                '3. Paste it here and tap Save.',
                style: GoogleFonts.inter(fontSize: 11.5, color: Colors.blue.shade900),
              ),
            ),
          ],
        ),
        actions: [
          if (_apiKey.isNotEmpty)
            TextButton(
              onPressed: () async {
                await _saveApiKey('');
                if (mounted) Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Switched to built-in offline ECE solver')),
                );
              },
              child: const Text('Clear Key', style: TextStyle(color: Colors.red)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await _saveApiKey(keyController.text);
              if (mounted) Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gemini Live AI configured successfully!')),
              );
            },
            child: const Text('Save Key'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GATE AI Tutor',
              style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 17),
            ),
            Text(
              _apiKey.isNotEmpty ? '⚡ Gemini 1.5 Flash (Live)' : '🧠 ECE Neural Engine (Offline)',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: _apiKey.isNotEmpty ? const Color(0xFF64FFDA) : Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _apiKey.isNotEmpty ? Icons.check_circle : Icons.settings,
              color: _apiKey.isNotEmpty ? const Color(0xFF64FFDA) : Colors.white,
            ),
            tooltip: 'Configure Gemini API Key',
            onPressed: _showApiKeyDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick suggestion chips
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.white12 : Colors.grey.shade200,
                ),
              ),
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _quickSuggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final suggestion = _quickSuggestions[index];
                return ActionChip(
                  label: Text(
                    suggestion,
                    style: GoogleFonts.inter(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF1565C0),
                    ),
                  ),
                  backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                  side: BorderSide(
                    color: isDark ? Colors.blue.withOpacity(0.3) : Colors.blue.shade200,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  onPressed: () => _sendMessage(suggestion),
                );
              },
            ),
          ),

          // Chat messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return const _ThinkingBubble();
                }
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
                          hintText: 'Ask any GATE ECE question...',
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
                      onTap: () => _sendMessage(),
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

class _ThinkingBubble extends StatelessWidget {
  const _ThinkingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF1565C0)),
            ),
            const SizedBox(width: 10),
            Text(
              'AI is formulating step-by-step solution...',
              style: GoogleFonts.inter(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1565C0),
              ),
            ),
          ],
        ),
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
          maxWidth: MediaQuery.of(context).size.width * 0.86,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!msg.isUser && msg.source != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      msg.source!.contains('Gemini') ? Icons.bolt : Icons.memory,
                      size: 13,
                      color: const Color(0xFF1565C0),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      msg.source!,
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1565C0),
                      ),
                    ),
                  ],
                ),
              ),
            SelectableText(
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
            if (!msg.isUser)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: msg.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied answer to clipboard'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.copy,
                            size: 12,
                            color: isDark ? Colors.white60 : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Copy',
                            style: GoogleFonts.inter(
                              fontSize: 10.5,
                              color: isDark ? Colors.white60 : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final String? source;

  _ChatMessage({
    required this.text,
    required this.isUser,
    this.source,
  });
}