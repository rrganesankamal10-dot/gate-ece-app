// lib/screens/chapter_quiz_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../providers/progress_provider.dart';

class _QuizQuestion {
  final String question;
  final List<String> options;
  final int answer; // 0-3
  final String explanation;

  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
  });
}

// ─── Per-topic inline quiz banks ────────────────────────────────────────────
const Map<String, List<_QuizQuestion>> _quizBank = {
  'networks': [
    _QuizQuestion(
      question: 'In a series RLC circuit at resonance, the impedance equals:',
      options: ['Zero', 'R only (purely resistive)', 'jωL', '1/(jωC)'],
      answer: 1,
      explanation: 'At resonance, XL = XC so they cancel, leaving Z = R (purely resistive).',
    ),
    _QuizQuestion(
      question: 'Maximum power is transferred to a load when RL equals:',
      options: ['0', 'Infinity', 'Rth (Thevenin resistance)', '2 × Rth'],
      answer: 2,
      explanation: 'Maximum power transfer theorem: RL = Rth for maximum power Pmax = Vth²/(4Rth).',
    ),
    _QuizQuestion(
      question: 'The superposition theorem applies to circuits that are:',
      options: ['Non-linear only', 'Linear and bilateral', 'Active only', 'Passive only'],
      answer: 1,
      explanation: 'Superposition requires linearity. The response from each source is summed algebraically.',
    ),
    _QuizQuestion(
      question: 'KCL states that the sum of currents at a node equals:',
      options: ['Voltage × Resistance', 'Zero', 'Maximum current', 'Source voltage'],
      answer: 1,
      explanation: 'KCL: Σ currents entering = Σ currents leaving a node. Net sum = 0.',
    ),
    _QuizQuestion(
      question: 'Time constant τ for an RC circuit is:',
      options: ['R/C', 'RC', 'C/R', 'R²C'],
      answer: 1,
      explanation: 'τ = RC (in seconds). The capacitor charges to 63.2% of final value in one time constant.',
    ),
  ],
  'signals': [
    _QuizQuestion(
      question: 'The Fourier transform of δ(t) (unit impulse) is:',
      options: ['0', 'u(t)', '1 (constant for all ω)', 'jω'],
      answer: 2,
      explanation: 'FT of δ(t) = 1. The impulse has flat spectrum — all frequencies equally present.',
    ),
    _QuizQuestion(
      question: 'Nyquist sampling rate for a 5 kHz signal is:',
      options: ['5 kHz', '10 kHz', '2.5 kHz', '20 kHz'],
      answer: 1,
      explanation: 'fs ≥ 2fmax = 2 × 5000 = 10 kHz to avoid aliasing.',
    ),
    _QuizQuestion(
      question: 'The Z-transform of aⁿu[n] has ROC:',
      options: ['|z| < |a|', '|z| > |a|', '|z| = |a|', 'Entire z-plane'],
      answer: 1,
      explanation: 'For causal sequence aⁿu[n], ROC is |z| > |a| (outside the pole circle).',
    ),
    _QuizQuestion(
      question: 'Convolution in time domain corresponds to what in frequency domain?',
      options: ['Convolution', 'Division', 'Multiplication', 'Addition'],
      answer: 2,
      explanation: 'Convolution theorem: x(t)*h(t) ↔ X(jω)·H(jω). Convolution → Multiplication.',
    ),
    _QuizQuestion(
      question: 'A system is LTI if its output y(t) to x(t) satisfies:',
      options: ['y(t) = x²(t)', 'Linearity and Time-invariance', 'Non-causality', 'y(t) = x(t+T)'],
      answer: 1,
      explanation: 'LTI = Linear (superposition holds) + Time-Invariant (delay in input ↔ same delay in output).',
    ),
  ],
  'devices': [
    _QuizQuestion(
      question: 'The thermal voltage VT at room temperature (300 K) is approximately:',
      options: ['0.7 V', '26 mV', '0.6 V', '1.2 V'],
      answer: 1,
      explanation: 'VT = kT/q ≈ (1.38×10⁻²³ × 300)/(1.6×10⁻¹⁹) ≈ 25.9 mV ≈ 26 mV.',
    ),
    _QuizQuestion(
      question: 'MOSFET in saturation requires:',
      options: ['VGS < VTH', 'VDS < VGS − VTH', 'VDS ≥ VGS − VTH', 'VGS = 0'],
      answer: 2,
      explanation: 'Saturation condition: VDS ≥ VGS − VTH (channel pinched off at drain end).',
    ),
    _QuizQuestion(
      question: 'In an NPN BJT, the relationship between IC and IB is:',
      options: ['IC = IB/β', 'IC = β·IB', 'IC = α·IB', 'IC = (β+1)IB'],
      answer: 1,
      explanation: 'IC = β·IB where β (hFE) is the current gain. Typical β = 100–200.',
    ),
    _QuizQuestion(
      question: 'The built-in potential of a Si p-n junction is approximately:',
      options: ['0 V', '0.3 V', '0.7 V', '1.1 V'],
      answer: 2,
      explanation: 'Si p-n junction built-in potential ≈ 0.6–0.7 V. This is also the forward bias turn-on voltage.',
    ),
    _QuizQuestion(
      question: 'Zener diode is designed to operate in:',
      options: ['Forward bias only', 'Reverse breakdown region', 'Saturation', 'Cutoff region'],
      answer: 1,
      explanation: 'Zener operates in reverse breakdown (Zener/avalanche), maintaining constant voltage regulation.',
    ),
  ],
  'analog': [
    _QuizQuestion(
      question: 'An inverting op-amp with Rf=50kΩ, Rin=10kΩ has voltage gain:',
      options: ['5', '−5', '50', '0.2'],
      answer: 1,
      explanation: 'Av = −Rf/Rin = −50/10 = −5. Negative sign = phase inversion.',
    ),
    _QuizQuestion(
      question: 'An ideal op-amp has:',
      options: [
        'Zero input impedance, finite output impedance',
        'Infinite input impedance, zero output impedance, infinite gain',
        'Finite gain, finite bandwidth',
        'High offset voltage',
      ],
      answer: 1,
      explanation: 'Ideal op-amp: Zin=∞, Zout=0, AOL=∞, BW=∞, no offset.',
    ),
    _QuizQuestion(
      question: 'The cutoff frequency of a first-order RC low-pass filter is:',
      options: ['2πRC', '1/(2πRC)', 'RC', '1/RC'],
      answer: 1,
      explanation: 'fc = 1/(2πRC). At this frequency, gain = −3 dB (0.707 of DC gain).',
    ),
    _QuizQuestion(
      question: 'Negative feedback in an amplifier:',
      options: [
        'Increases gain, increases distortion',
        'Reduces gain, reduces distortion, stabilizes',
        'Increases bandwidth, increases noise',
        'No effect on gain',
      ],
      answer: 1,
      explanation: 'Negative feedback reduces gain (by factor 1+Aβ), but reduces distortion, noise, improves bandwidth and stability.',
    ),
    _QuizQuestion(
      question: 'BJT transconductance gm at IC=2mA is:',
      options: ['2 mA/V', '77 mA/V', '26 mA/V', '0.5 mA/V'],
      answer: 1,
      explanation: 'gm = IC/VT = 2 mA / 26 mV ≈ 76.9 mA/V ≈ 77 mA/V.',
    ),
  ],
  'digital': [
    _QuizQuestion(
      question: 'De Morgan\'s theorem: NOT(A AND B) equals:',
      options: ['NOT-A AND NOT-B', 'NOT-A OR NOT-B', 'A AND B', 'A OR B'],
      answer: 1,
      explanation: 'De Morgan: (AB)̄ = Ā + B̄. NAND = NOT-A OR NOT-B.',
    ),
    _QuizQuestion(
      question: 'Binary number 1011₂ equals decimal:',
      options: ['9', '10', '11', '12'],
      answer: 2,
      explanation: '1×2³ + 0×2² + 1×2¹ + 1×2⁰ = 8 + 0 + 2 + 1 = 11.',
    ),
    _QuizQuestion(
      question: 'A 4-bit ripple counter divides clock by:',
      options: ['4', '8', '16', '2'],
      answer: 2,
      explanation: 'N-bit counter divides by 2ⁿ. For n=4: 2⁴ = 16.',
    ),
    _QuizQuestion(
      question: 'A multiplexer (MUX) selects one of its inputs based on:',
      options: ['Output', 'Select lines', 'Clock', 'Power supply'],
      answer: 1,
      explanation: 'MUX select lines choose which input passes to the output. 2ⁿ inputs need n select lines.',
    ),
    _QuizQuestion(
      question: 'In a JK flip-flop, J=1, K=1 causes:',
      options: ['Set (Q=1)', 'Reset (Q=0)', 'Toggle (Q flips)', 'No change'],
      answer: 2,
      explanation: 'JK FF: J=0,K=0 → No change; J=0,K=1 → Reset; J=1,K=0 → Set; J=1,K=1 → Toggle.',
    ),
  ],
  'control': [
    _QuizQuestion(
      question: 'For a stable minimum-phase system, the gain margin must be:',
      options: ['Negative in dB', 'Greater than 0 dB', 'Zero', 'Less than 0 dB'],
      answer: 1,
      explanation: 'Gain Margin > 0 dB means |G(jωpc)| < 1. For stable systems, GM > 0 dB and PM > 0°.',
    ),
    _QuizQuestion(
      question: 'The Routh-Hurwitz criterion determines:',
      options: [
        'Transient response speed',
        'Number of RHP poles (stability)',
        'Steady-state error',
        'Bandwidth of the system',
      ],
      answer: 1,
      explanation: 'Routh-Hurwitz: Count sign changes in the first column = number of unstable (RHP) poles.',
    ),
    _QuizQuestion(
      question: 'A Type-1 system has steady-state error to ramp input equal to:',
      options: ['Zero', 'Finite constant', 'Infinity', '1'],
      answer: 1,
      explanation: 'Type-1 system has 1 integrator. Error to step=0, error to ramp = finite (1/Kv), error to parabola=∞.',
    ),
    _QuizQuestion(
      question: 'Root locus starts (K=0) at:',
      options: ['Zeros of G(s)', 'Poles of G(s)H(s)', 'Origin', 'Infinity'],
      answer: 1,
      explanation: 'Root locus: starts at open-loop poles (K=0), ends at open-loop zeros (K→∞).',
    ),
    _QuizQuestion(
      question: 'A PD controller adds a zero to the:',
      options: ['Plant', 'Forward path', 'Feedback path', 'Closed-loop TF'],
      answer: 1,
      explanation: 'PD = Proportional + Derivative: C(s) = Kp + Kd·s. It adds a zero at s = −Kp/Kd in forward path.',
    ),
  ],
  'communications': [
    _QuizQuestion(
      question: 'AM efficiency η (power in sidebands / total power) for μ=1 is:',
      options: ['25%', '33.33%', '50%', '66.67%'],
      answer: 1,
      explanation: 'η = μ²/(2+μ²) = 1/(2+1) = 1/3 ≈ 33.33% for μ=1.',
    ),
    _QuizQuestion(
      question: 'Shannon channel capacity increases with:',
      options: [
        'Decreasing bandwidth',
        'Decreasing SNR',
        'Increasing bandwidth and SNR',
        'Increasing noise only',
      ],
      answer: 2,
      explanation: 'C = B log₂(1 + SNR). C increases as B or SNR increases.',
    ),
    _QuizQuestion(
      question: 'In BPSK, how many bits are transmitted per symbol?',
      options: ['1', '2', '4', '8'],
      answer: 0,
      explanation: 'BPSK = Binary Phase Shift Keying. 2 phases, 1 bit/symbol. QPSK=2 bits, 16-QAM=4 bits.',
    ),
    _QuizQuestion(
      question: 'FM bandwidth by Carson\'s rule for Δf=4kHz, fm=1kHz is:',
      options: ['4 kHz', '8 kHz', '10 kHz', '5 kHz'],
      answer: 2,
      explanation: 'BW = 2(Δf + fm) = 2(4+1) = 10 kHz.',
    ),
    _QuizQuestion(
      question: 'Matched filter maximizes:',
      options: ['Bandwidth', 'SNR at the sampling instant', 'Noise power', 'Bit error rate'],
      answer: 1,
      explanation: 'Matched filter is the optimal linear filter that maximizes output SNR at the decision instant.',
    ),
  ],
  'electromagnetics': [
    _QuizQuestion(
      question: 'VSWR = 1 means:',
      options: [
        'Total reflection (Γ=1)',
        'Perfect match (no reflection, Γ=0)',
        'Half power point',
        'Maximum mismatch',
      ],
      answer: 1,
      explanation: 'VSWR = (1+|Γ|)/(1−|Γ|). VSWR=1 when Γ=0 (ZL=Z₀), meaning perfect impedance matching.',
    ),
    _QuizQuestion(
      question: 'Faraday\'s law in Maxwell\'s form is:',
      options: [
        '∇×H = J + ∂D/∂t',
        '∇×E = −∂B/∂t',
        '∇·D = ρv',
        '∇·B = 0',
      ],
      answer: 1,
      explanation: '∇×E = −∂B/∂t is Faraday\'s law (differential form). Changing B induces E.',
    ),
    _QuizQuestion(
      question: 'The skin depth δ in a conductor depends on frequency as:',
      options: ['δ ∝ f', 'δ ∝ 1/√f', 'δ ∝ √f', 'δ independent of f'],
      answer: 1,
      explanation: 'δ = 1/√(πfμσ) ∝ 1/√f. Higher frequency → smaller skin depth → more surface conduction.',
    ),
    _QuizQuestion(
      question: 'A half-wave dipole antenna has directivity of approximately:',
      options: ['1.0 dBi (isotropic)', '2.15 dBi (linear 1.64)', '3.01 dBi (linear 2.0)', '6.0 dBi (linear 4.0)'],
      answer: 1,
      explanation: 'Half-wave dipole (λ/2) directivity D = 1.64 (linear) = 10·log₁₀(1.64) = 2.15 dBi (or 0 dBd). A Hertzian dipole has D = 1.5 = 1.76 dBi.',
    ),
    _QuizQuestion(
      question: 'In a rectangular waveguide, the dominant mode is:',
      options: ['TM₀₀', 'TE₁₀', 'TEM', 'TE₁₁'],
      answer: 1,
      explanation: 'TE₁₀ is the dominant (lowest cutoff frequency) mode in a rectangular waveguide (a > b).',
    ),
  ],
  'math': [
    _QuizQuestion(
      question: 'The rank of matrix [[1,2],[2,4]] is:',
      options: ['0', '1', '2', '4'],
      answer: 1,
      explanation: 'Row 2 = 2×Row 1, so rows are linearly dependent. Rank = 1 (one independent row).',
    ),
    _QuizQuestion(
      question: 'Probability P(A∪B) = P(A) + P(B) when A and B are:',
      options: ['Dependent', 'Independent', 'Mutually exclusive', 'Complementary'],
      answer: 2,
      explanation: 'P(A∪B) = P(A)+P(B)−P(A∩B). If mutually exclusive, P(A∩B)=0, so P(A∪B)=P(A)+P(B).',
    ),
    _QuizQuestion(
      question: 'The Laplace transform of t·u(t) is:',
      options: ['1/s', '1/s²', '1/(s+1)', '2/s³'],
      answer: 1,
      explanation: 'L{tⁿu(t)} = n!/s^(n+1). For n=1: L{t·u(t)} = 1/s².',
    ),
    _QuizQuestion(
      question: 'For a random variable X with mean μ and variance σ², E[X²] equals:',
      options: ['μ²', 'σ²', 'μ² + σ²', 'σ² − μ²'],
      answer: 2,
      explanation: 'Var(X) = E[X²] − (E[X])² → E[X²] = σ² + μ².',
    ),
    _QuizQuestion(
      question: 'The determinant of an identity matrix Iₙ is:',
      options: ['n', '0', '1', 'n!'],
      answer: 2,
      explanation: 'det(Iₙ) = 1. Eigenvalues of I are all 1, product of eigenvalues = det = 1.',
    ),
  ],
};

List<_QuizQuestion> _getQuestionsForTopic(String topicId) {
  return _quizBank[topicId] ??
      _quizBank['networks']!; // fallback
}

// ─── CHAPTER QUIZ SCREEN ────────────────────────────────────────────────────
class ChapterQuizScreen extends StatefulWidget {
  final String topicId;
  final String topicName;
  final Color? topicColor;

  const ChapterQuizScreen({
    super.key,
    required this.topicId,
    required this.topicName,
    this.topicColor,
  });

  @override
  State<ChapterQuizScreen> createState() => _ChapterQuizScreenState();
}

class _ChapterQuizScreenState extends State<ChapterQuizScreen> {
  late final List<_QuizQuestion> _questions;
  int _currentIndex = 0;
  int? _selectedOption;
  bool _answered = false;
  int _score = 0;
  bool _quizFinished = false;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _questions = _getQuestionsForTopic(widget.topicId);
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _selectOption(int idx) {
    if (_answered) return;
    final q = _questions[_currentIndex];
    final correct = idx == q.answer;
    setState(() {
      _selectedOption = idx;
      _answered = true;
      if (correct) _score++;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
    } else {
      // Quiz done
      setState(() => _quizFinished = true);
      final progress = Provider.of<ProgressProvider>(context, listen: false);
      progress.recordChapterQuizResult(widget.topicId, _score, _questions.length);
      if (_score >= 4) _confettiController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_quizFinished) {
      return _QuizResultScreen(
        topicName: widget.topicName,
        score: _score,
        total: _questions.length,
        confettiController: _confettiController,
      );
    }

    final q = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.topicName} Quiz',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            color: const Color(0xFF1565C0),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentIndex + 1} of ${_questions.length}',
                      style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                    ),
                    Text(
                      'Score: $_score',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFFD600),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearPercentIndicator(
                  percent: progress,
                  lineHeight: 6,
                  backgroundColor: Colors.white24,
                  progressColor: const Color(0xFFFFD600),
                  barRadius: const Radius.circular(10),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Question card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outline.withOpacity(0.15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      q.question,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Options
                  ...List.generate(q.options.length, (i) {
                    Color cardColor = colorScheme.surface;
                    Color borderColor = colorScheme.outline.withOpacity(0.2);
                    Color textColor = colorScheme.onSurface;
                    IconData? trailingIcon;

                    if (_answered) {
                      if (i == q.answer) {
                        cardColor = Colors.green.withOpacity(0.12);
                        borderColor = Colors.green;
                        textColor = Colors.green.shade700;
                        trailingIcon = Icons.check_circle;
                      } else if (i == _selectedOption) {
                        cardColor = Colors.red.withOpacity(0.1);
                        borderColor = Colors.red;
                        textColor = Colors.red.shade700;
                        trailingIcon = Icons.cancel;
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => _selectOption(i),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: borderColor.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  String.fromCharCode(65 + i), // A, B, C, D
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  q.options[i],
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              if (trailingIcon != null)
                                Icon(trailingIcon, color: textColor, size: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  // Explanation
                  if (_answered) ...[
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lightbulb, color: Colors.amber, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              q.explanation,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                height: 1.5,
                                color: colorScheme.onSurface.withOpacity(0.85),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _currentIndex < _questions.length - 1
                              ? 'Next Question →'
                              : 'See Results',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── QUIZ RESULT SCREEN ─────────────────────────────────────────────────────
class _QuizResultScreen extends StatelessWidget {
  final String topicName;
  final int score;
  final int total;
  final ConfettiController confettiController;

  const _QuizResultScreen({
    required this.topicName,
    required this.score,
    required this.total,
    required this.confettiController,
  });

  int get _stars {
    if (score >= total) return 3;
    if (score >= (total * 0.6).ceil()) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final pct = score / total;
    final xpEarned = score * 10;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 30,
            colors: const [
              Colors.green, Colors.blue, Colors.pink, Color(0xFFFFD600),
            ],
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    score >= 4 ? '🎉 Excellent!' : score >= 3 ? '👍 Good Job!' : '📚 Keep Practicing!',
                    style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    topicName,
                    style: GoogleFonts.inter(
                        fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 32),

                  // Score circle
                  CircularPercentIndicator(
                    radius: 80,
                    lineWidth: 12,
                    percent: pct.clamp(0.0, 1.0),
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$score/$total',
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: pct >= 0.8
                                ? Colors.green
                                : pct >= 0.6
                                    ? Colors.orange
                                    : Colors.red,
                          ),
                        ),
                        Text(
                          'Score',
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    progressColor: pct >= 0.8
                        ? Colors.green
                        : pct >= 0.6
                            ? Colors.orange
                            : Colors.red,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 24),

                  // Stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return Icon(
                        i < _stars ? Icons.star_rounded : Icons.star_outline_rounded,
                        size: 48,
                        color: i < _stars ? const Color(0xFFFFD600) : Colors.grey.shade300,
                      );
                    }),
                  ),
                  const SizedBox(height: 24),

                  // XP badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFFD600), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '+$xpEarned XP Earned',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Back button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Pop back to Learning Path
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst || route.settings.name == '/learning_path',
                        );
                      },
                      icon: const Icon(Icons.route),
                      label: Text(
                        'Back to Learning Path',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Try Again',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
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
