import 'package:flutter/material.dart';
import 'package:gpay_clone/presentation/payment_response/components/pacman_painter.dart';

class PaymentLoadingWidget extends StatefulWidget {
  const PaymentLoadingWidget({super.key});

  @override
  State<PaymentLoadingWidget> createState() => _PaymentLoadingWidgetState();
}

class _PaymentLoadingWidgetState extends State<PaymentLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pacmanController;
  @override
  void initState() {
    super.initState();
    _pacmanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      upperBound: 2.4,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _pacmanController,
          builder: (context, child) {
            return CustomPaint(
              painter: PacManPainter(_pacmanController.value),
              size: const Size(100, 100),
            );
          },
        ),
        const SizedBox(height: 12.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Please wait while we process your transaction...',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pacmanController.dispose();
    super.dispose();
  }
}
