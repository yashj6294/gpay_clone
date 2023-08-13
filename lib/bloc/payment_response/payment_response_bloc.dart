import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpay_clone/bloc/payment_response/payment_response_event.dart';
import 'package:gpay_clone/bloc/payment_response/payment_response_state.dart';

class PaymentResponseBloc
    extends Bloc<PaymentResponseEvent, PaymentResponseState> {
  PaymentResponseBloc() : super(PaymentResponseInitialState()) {
    on<PaymentResponseInitEvent>(
        (event, emit) => emit(PaymentResponseLoadingState()));
    on<PaymentResponseSuccessEvent>(
        (event, emit) => emit(PaymentResponseSuccessState()));
  }
}
