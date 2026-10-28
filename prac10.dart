import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nova Calculator',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6FC),
      ),
      home: const CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  static const Color purple = Color(0xFF7457FF);
  static const Color darkText = Color(0xFF25213A);
  static const Color mutedText = Color(0xFF77738A);
  static const Color numberBackground = Color(0xFFECEAF7);
  static const Color utilityBackground = Color(0xFFDDD6FE);

  String display = '0';
  String expression = 'SMART CALCULATOR';
  double? firstNumber;
  String? selectedOperator;
  bool startNewNumber = true;

  String formatNumber(double number) {
    if (!number.isFinite) return 'Error';
    if (number == 0) return '0';

    if (number.abs() >= 1e12 || number.abs() < 1e-8) {
      return number.toStringAsExponential(5);
    }

    return number
        .toStringAsFixed(8)
        .replaceFirst(RegExp(r'\.?0+$'), '');
  }

  double calculate(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '−':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        if (b == 0) {
          throw const FormatException('Cannot divide by zero');
        }
        return a / b;
      default:
        return b;
    }
  }

  void clearCalculator() {
    display = '0';
    expression = 'SMART CALCULATOR';
    firstNumber = null;
    selectedOperator = null;
    startNewNumber = true;
  }

  void press(String key) {
    setState(() {
      if (display == 'Error') {
        clearCalculator();
        if (key == 'AC') return;
      }

      if (key.length == 1 && '0123456789'.contains(key)) {
        if (startNewNumber || display == '0') {
          display = key;
        } else if (display.length < 16) {
          display += key;
        }
        startNewNumber = false;
        return;
      }

      switch (key) {
        case 'AC':
          clearCalculator();
          break;

        case '⌫':
          if (!startNewNumber) {
            if (display.length <= 1 ||
                (display.startsWith('-') && display.length == 2)) {
              display = '0';
            } else {
              display = display.substring(0, display.length - 1);
            }
          }
          break;

        case '.':
          if (startNewNumber) {
            display = '0.';
            startNewNumber = false;
          } else if (!display.contains('.')) {
            display += '.';
          }
          break;

        case '±':
          final value = double.tryParse(display);
          if (value != null && value != 0) {
            display = formatNumber(-value);
          }
          break;

        case '%':
          final value = double.tryParse(display);
          if (value != null) {
            display = formatNumber(value / 100);
            startNewNumber = true;
          }
          break;

        case '+':
        case '−':
        case '×':
        case '÷':
          final value = double.tryParse(display);
          if (value == null) return;

          if (firstNumber != null &&
              selectedOperator != null &&
              !startNewNumber) {
            try {
              display = formatNumber(
                calculate(firstNumber!, value, selectedOperator!),
              );
            } catch (_) {
              display = 'Error';
              expression = 'Cannot divide by zero';
              firstNumber = null;
              selectedOperator = null;
              startNewNumber = true;
              return;
            }
          }

          firstNumber = double.tryParse(display);
          selectedOperator = key;
          expression = '${formatNumber(firstNumber!)} $key';
          startNewNumber = true;
          break;

        case '=':
          if (firstNumber == null || selectedOperator == null) return;

          final a = firstNumber!;
          final b = double.tryParse(display) ?? 0;
          final op = selectedOperator!;

          try {
            final result = calculate(a, b, op);

            if (!result.isFinite) {
              throw const FormatException('Invalid result');
            }

            expression =
                '${formatNumber(a)} $op ${formatNumber(b)} =';
            display = formatNumber(result);
          } catch (_) {
            display = 'Error';
            expression = 'Cannot divide by zero';
          }

          firstNumber = null;
          selectedOperator = null;
          startNewNumber = true;
          break;
      }
    });
  }

  Widget calculatorButton(String label, {int flex = 1}) {
    final isOperator = ['÷', '×', '−', '+', '='].contains(label);
    final isUtility = ['AC', '±', '%', '⌫'].contains(label);

    final Color buttonColor = isOperator
        ? purple
        : isUtility
            ? utilityBackground
            : numberBackground;

    final Color foregroundColor =
        isOperator ? Colors.white : darkText;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Material(
          color: buttonColor,
          borderRadius: BorderRadius.circular(18),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => press(label),
            child: Center(
              child: label == '⌫'
                  ? Icon(
                      Icons.backspace_outlined,
                      color: foregroundColor,
                      size: 23,
                    )
                  : Text(
                      label,
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonRow(List<String> labels) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: labels.map((label) {
          return calculatorButton(label);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 500;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: compact ? 42 : 58,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calculate_rounded,
                              color: purple,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'NOVA',
                                    style: TextStyle(
                                      color: darkText,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 3,
                                    ),
                                  ),
                                  Text(
                                    'SMART CALCULATOR',
                                    style: TextStyle(
                                      color: mutedText,
                                      fontSize: 10,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.circle,
                              size: 9,
                              color: purple,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'READY',
                              style: TextStyle(
                                color: purple,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFE7E4F2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF30245A)
                                    .withValues(alpha: 0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                expression,
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: mutedText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      display,
                                      key: const ValueKey(
                                        'calculator-display',
                                      ),
                                      style: TextStyle(
                                        color: display == 'Error'
                                            ? Colors.redAccent
                                            : darkText,
                                        fontSize: 54,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 3,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: purple,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            buttonRow(['AC', '±', '%', '÷']),
                            buttonRow(['7', '8', '9', '×']),
                            buttonRow(['4', '5', '6', '−']),
                            buttonRow(['1', '2', '3', '+']),
                            Expanded(
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [
                                  calculatorButton('0', flex: 2),
                                  calculatorButton('.'),
                                  calculatorButton('⌫'),
                                  calculatorButton('='),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (!compact)
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'SIMPLE  •  FAST  •  PRECISE',
                            style: TextStyle(
                              color: mutedText,
                              fontSize: 10,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}