// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gpay_clone/bloc/payment_response/payment_response_bloc.dart';
import 'package:gpay_clone/bloc/payment_response/payment_response_event.dart';
import 'package:gpay_clone/bloc/payment_response/payment_response_state.dart';
import 'package:gpay_clone/presentation/payment_response/payment_loading_widget.dart';
import 'package:gpay_clone/presentation/payment_response/payment_success_widget.dart';

class PaymentResponseScreen extends StatefulWidget {
  final String amount;
  const PaymentResponseScreen({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentResponseScreen> createState() => _PaymentResponseScreenState();
}

class _PaymentResponseScreenState extends State<PaymentResponseScreen> {
  PaymentResponseBloc? _paymentResponseBloc;
  @override
  void initState() {
    super.initState();
    _paymentResponseBloc = context.read<PaymentResponseBloc>();
    Future.delayed(const Duration(seconds: 5), () {
      _paymentResponseBloc?.add(PaymentResponseSuccessEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: BlocBuilder<PaymentResponseBloc, PaymentResponseState>(
        builder: (context, state) {
          if (state is PaymentResponseSuccessState) {
            return PaymentSuccessWidget(amount: widget.amount);
          }
          return const PaymentLoadingWidget();
        },
      ),
    );
  }
}
