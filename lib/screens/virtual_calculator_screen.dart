import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VirtualCalculatorScreen extends StatefulWidget {
  const VirtualCalculatorScreen({super.key});

  @override
  State<VirtualCalculatorScreen> createState() => _VirtualCalculatorScreenState();
}

class _VirtualCalculatorScreenState extends State<VirtualCalculatorScreen> {
  String _display = '0';
  String _expression = '';
  double _memory = 0.0;
  bool _isDegree = true;
  bool _isInverse = false;
  bool _isHyp = false;
  double? _operand1;
  String? _operator;
  bool _shouldResetDisplay = false;

  void _onDigit(String digit) {
    setState(() {
      if (_display == '0' || _shouldResetDisplay) {
        _display = digit;
        _shouldResetDisplay = false;
      } else {
        _display += digit;
      }
    });
  }

  void _onDecimal() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _onClear() {
    setState(() {
      _display = '0';
      _expression = '';
      _operand1 = null;
      _operator = null;
      _shouldResetDisplay = false;
    });
  }

  void _onBackspace() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = '0';
      }
    });
  }

  void _onOperator(String op) {
    setState(() {
      final cur = double.tryParse(_display) ?? 0.0;
      if (_operand1 == null) {
        _operand1 = cur;
      } else if (_operator != null && !_shouldResetDisplay) {
        _operand1 = _calculate(_operand1!, cur, _operator!);
        _display = _formatNumber(_operand1!);
      }
      _operator = op;
      _expression = '${_formatNumber(_operand1!)} $op ';
      _shouldResetDisplay = true;
    });
  }

  void _onEquals() {
    setState(() {
      if (_operand1 != null && _operator != null) {
        final cur = double.tryParse(_display) ?? 0.0;
        final res = _calculate(_operand1!, cur, _operator!);
        _expression = '${_formatNumber(_operand1!)} $_operator ${_formatNumber(cur)} =';
        _display = _formatNumber(res);
        _operand1 = null;
        _operator = null;
        _shouldResetDisplay = true;
      }
    });
  }

  double _calculate(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '−':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        return b == 0 ? double.nan : a / b;
      case 'xʸ':
        return math.pow(a, b).toDouble();
      case 'mod':
        return a % b;
      default:
        return b;
    }
  }

  void _onScientific(String func) {
    setState(() {
      final val = double.tryParse(_display) ?? 0.0;
      double res = val;

      switch (func) {
        case 'sin':
          final angle = _isDegree ? (val * math.pi / 180) : val;
          res = _isInverse
              ? (_isDegree ? (math.asin(val) * 180 / math.pi) : math.asin(val))
              : math.sin(angle);
          break;
        case 'cos':
          final angle = _isDegree ? (val * math.pi / 180) : val;
          res = _isInverse
              ? (_isDegree ? (math.acos(val) * 180 / math.pi) : math.acos(val))
              : math.cos(angle);
          break;
        case 'tan':
          final angle = _isDegree ? (val * math.pi / 180) : val;
          res = _isInverse
              ? (_isDegree ? (math.atan(val) * 180 / math.pi) : math.atan(val))
              : math.tan(angle);
          break;
        case 'ln':
          res = math.log(val);
          break;
        case 'log':
          res = math.log(val) / math.ln10;
          break;
        case '√':
          res = math.sqrt(val);
          break;
        case 'x²':
          res = val * val;
          break;
        case 'x³':
          res = val * val * val;
          break;
        case '1/x':
          res = val == 0 ? double.nan : 1.0 / val;
          break;
        case 'eˣ':
          res = math.exp(val);
          break;
        case '10ˣ':
          res = math.pow(10, val).toDouble();
          break;
        case 'n!':
          res = _factorial(val.toInt()).toDouble();
          break;
        case '±':
          res = -val;
          break;
        case 'π':
          res = math.pi;
          break;
        case 'e':
          res = math.e;
          break;
      }

      _expression = '$func($val)';
      _display = _formatNumber(res);
      _shouldResetDisplay = true;
    });
  }

  int _factorial(int n) {
    if (n <= 1) return 1;
    if (n > 20) return 2432902008176640000;
    int res = 1;
    for (int i = 2; i <= n; i++) {
      res *= i;
    }
    return res;
  }

  String _formatNumber(double n) {
    if (n.isNaN) return 'Error';
    if (n.isInfinite) return 'Infinity';
    if (n == n.roundToDouble() && n.abs() < 1e12) {
      return n.toInt().toString();
    }
    if (n.abs() > 1e9 || (n.abs() < 1e-4 && n.abs() > 0)) {
      return n.toStringAsExponential(6);
    }
    return n.toStringAsPrecision(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🧮 GATE Virtual Calculator', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16)),
            Text('TCS iON Exam Mode Compatible', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFFFFD600))),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => _isDegree = !_isDegree),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _isDegree ? 'DEG' : 'RAD',
                style: const TextStyle(color: Color(0xFFFFD600), fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Screen display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: const Color(0xFF070E17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 14,
                      color: Colors.white54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      _display,
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Mode row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: const Color(0xFF101B2B),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _modeToggle('INV', _isInverse, () => setState(() => _isInverse = !_isInverse)),
                  _modeToggle('DEG', _isDegree, () => setState(() => _isDegree = true)),
                  _modeToggle('RAD', !_isDegree, () => setState(() => _isDegree = false)),
                  _calcBtn('MC', () => setState(() => _memory = 0), isSmall: true),
                  _calcBtn('MR', () => setState(() => _display = _formatNumber(_memory)), isSmall: true),
                  _calcBtn('MS', () => setState(() => _memory = double.tryParse(_display) ?? 0), isSmall: true),
                  _calcBtn('M+', () => setState(() => _memory += double.tryParse(_display) ?? 0), isSmall: true),
                ],
              ),
            ),

            // Keypad Grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6),
                color: const Color(0xFF0D1B2A),
                child: Column(
                  children: [
                    _keypadRow(['sin', 'cos', 'tan', 'ln', 'log', 'C']),
                    _keypadRow(['√', 'x²', 'x³', 'xʸ', 'eˣ', '⌫']),
                    _keypadRow(['1/x', 'n!', 'π', 'e', 'mod', '÷']),
                    _keypadRow(['7', '8', '9', '(', ')', '×']),
                    _keypadRow(['4', '5', '6', '±', '%', '−']),
                    _keypadRow(['1', '2', '3', '0', '.', '+']),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD600),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: _onEquals,
                            child: Text('=', style: GoogleFonts.sourceCodePro(fontSize: 26, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modeToggle(String label, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF1565C0) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: active ? Colors.white : Colors.white60,
          ),
        ),
      ),
    );
  }

  Widget _calcBtn(String label, VoidCallback onTap, {bool isSmall = false}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Text(
          label,
          style: GoogleFonts.inter(fontSize: isSmall ? 11 : 13, color: Colors.white70, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _keypadRow(List<String> keys) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: keys.map((k) {
          final isNumber = '0123456789.'.contains(k);
          final isOp = ['+', '−', '×', '÷', 'mod', 'xʸ'].contains(k);
          final isSpecial = ['C', '⌫'].contains(k);

          Color bgColor = const Color(0xFF162032);
          Color textColor = Colors.white;

          if (isNumber) {
            bgColor = const Color(0xFF1E2D42);
            textColor = Colors.white;
          } else if (isOp) {
            bgColor = const Color(0xFF1565C0).withOpacity(0.4);
            textColor = const Color(0xFFFFD600);
          } else if (isSpecial) {
            bgColor = Colors.red.withOpacity(0.2);
            textColor = Colors.redAccent;
          }

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Material(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    if (isNumber) {
                      if (k == '.') {
                        _onDecimal();
                      } else {
                        _onDigit(k);
                      }
                    } else if (isOp) {
                      _onOperator(k);
                    } else if (k == 'C') {
                      _onClear();
                    } else if (k == '⌫') {
                      _onBackspace();
                    } else {
                      _onScientific(k);
                    }
                  },
                  child: Center(
                    child: Text(
                      k,
                      style: GoogleFonts.inter(
                        fontSize: isNumber ? 16 : 13,
                        fontWeight: isNumber ? FontWeight.bold : FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
