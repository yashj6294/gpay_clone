// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gpay_clone/presentation/payment_response/components/ripple_painter.dart';
import 'package:gpay_clone/presentation/payment_response/components/tick_painter.dart';

class PaymentSuccessWidget extends StatefulWidget {
  final String amount;
  const PaymentSuccessWidget({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentSuccessWidget> createState() => _PaymentSuccessWidgetState();
}

class _PaymentSuccessWidgetState extends State<PaymentSuccessWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation tickAnimation, ripple1Animation, ripple2Animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    tickAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3),
      ),
    );
    ripple1Animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.65),
      ),
    );
    ripple2Animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0),
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0, left: 20.0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      opacity: _controller.value >= 0.7 ? 1 : 0,
                      child: Transform.scale(
                        scale: ripple2Animation.value,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.lightBlueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: CustomPaint(
                            painter: RipplePainter(color: Colors.white70),
                            size: const Size(200, 200),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0, left: 20.0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      opacity: _controller.value >= 0.3 ? 1 : 0,
                      child: Transform.scale(
                        scale: ripple1Animation.value,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.lightBlue,
                            shape: BoxShape.circle,
                          ),
                          child: CustomPaint(
                            painter: RipplePainter(color: Colors.white70),
                            size: const Size(140, 140),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomPaint(
                    painter: TickPainter(position: tickAnimation.value),
                    size: const Size(60, 60),
                  ),
                ],
              ),
            ),
            Text(
              "₹ ${widget.amount} Paid",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 40),
            const Text(
              "Receiver Name",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Text(
              "receiver@bank",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            const SizedBox(height: 80),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.blue[300],
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
