import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpay_clone/bloc/payment_response/payment_response_bloc.dart';
import 'package:gpay_clone/presentation/amount_entry/amount_entry_screen.dart';
import 'package:gpay_clone/providers/mpin_text_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentResponseBloc>(
      create: (_) => PaymentResponseBloc(),
      child: ChangeNotifierProvider<MpinTextProvider>(
        create: (context) => MpinTextProvider(),
        child: MaterialApp(
          title: 'Google Pay',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.light),
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.transparent),
          ),
          home: const AmountEntryScreen(),
        ),
      ),
    );
  }
}
