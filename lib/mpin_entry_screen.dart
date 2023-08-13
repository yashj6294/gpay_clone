import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpay_clone/constants.dart';
import 'package:gpay_clone/mpin_keypad.dart';
import 'package:gpay_clone/providers/mpin_text_provider.dart';
import 'package:provider/provider.dart';

class MpinEntryScreen extends StatefulWidget {
  final String amount;
  const MpinEntryScreen({super.key, required this.amount});

  @override
  State<MpinEntryScreen> createState() => _MpinEntryScreenState();
}

class _MpinEntryScreenState extends State<MpinEntryScreen> {
  final String upiLogoUrl = "https://logodix.com/logo/1645140.png";

  final _controllers = List.generate(Constants.mpinLength, (index) => TextEditingController());
  MpinTextProvider? mpinTextProvider;

  _numberKeyPressed(String value, BuildContext context) {
    String mpin = mpinTextProvider?.mpin ?? "";
    int length = mpin.length;
    if (length < Constants.mpinLength) {
      _controllers[length].value = TextEditingValue(text: value);
      mpinTextProvider?.setMpin(mpin + value);
      FocusScope.of(context).nextFocus();
    }
  }

  _backSpacePressed(BuildContext context) {
    String mpin = mpinTextProvider?.mpin ?? "";
    if (mpin.isNotEmpty) {
      mpin = mpin.substring(0, mpin.length - 1);
      mpinTextProvider?.setMpin(mpin);
      int index = mpin.length;
      _controllers[index].value = TextEditingValue.empty;
      FocusScope.of(context).previousFocus();
    }
  }

  _donePressed(BuildContext context) {
    String mpin = mpinTextProvider?.mpin ?? "";
    if (mpin.length == Constants.mpinLength) {
      //TODO :: Navigate to Success Screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your PIN'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    mpinTextProvider = context.read<MpinTextProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Name'),
        toolbarHeight: 60,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.indigo[700],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CachedNetworkImage(
              imageUrl: upiLogoUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Receiver Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          toolbarHeight: 40.0,
          actions: [
            Text(
              '₹ ${widget.amount}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(width: 4),
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 20.0,
              ),
            )
          ],
          backgroundColor: Colors.indigo[700],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(
                  child: SizedBox(height: 60),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      children: [
                        const Text('ENTER UPI PIN'),
                        const Spacer(),
                        Icon(
                          Icons.visibility,
                          color: Colors.indigo[700],
                        ),
                        const SizedBox(width: 4.0),
                        const Text('SHOW'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SizedBox(
                      width: Constants.mpinLength == 4 ? 50.0 : 30.0,
                      height: 40.0,
                      child: TextField(
                        maxLength: 1,
                        autofocus: index == 0,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        controller: _controllers[index],
                        keyboardType: TextInputType.none,
                        showCursor: false,
                        decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.indigo[700]!,
                              width: 2.0
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: _controllers.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        bottomSheet: MpinKeypad(
          numberKeyPressed: (val) {
            _numberKeyPressed(val, context);
          },
          backSpacePressed: () {
            _backSpacePressed(context);
          },
          donePressed: () {
            _donePressed(context);
          },
        ),
      ),
    );
  }
}
