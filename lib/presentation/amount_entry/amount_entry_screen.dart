import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpay_clone/presentation/mpin_entry/mpin_entry_screen.dart';

class AmountEntryScreen extends StatefulWidget {
  const AmountEntryScreen({super.key});

  @override
  State<AmountEntryScreen> createState() => _AmountEntryScreenState();
}

class _AmountEntryScreenState extends State<AmountEntryScreen> {
  final TextEditingController _amountController = TextEditingController();
  final profileUrlSender = "https://picsum.photos/200?random=1";
  final profileUrlReceiver = "https://picsum.photos/200?random=2";
  final receiverName = "Receiver";
  @override
  Widget build(BuildContext context) {
    const imageSize = 60.0;
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('More options'),
                  ),
                );
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: height * 0.05),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(
                  child: SizedBox(height: 40.0),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      imageUrl: profileUrlSender,
                      imageBuilder: (context, imageProvider) => Container(
                        width: imageSize,
                        height: imageSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0),
                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                    CachedNetworkImage(
                      imageUrl: profileUrlReceiver,
                      imageBuilder: (context, imageProvider) => Container(
                        width: imageSize,
                        height: imageSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0),
                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
                const Flexible(
                  child: SizedBox(height: 20.0),
                ),
                Text(
                  'Paying to $receiverName',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  '($receiverName@bank)',
                  style: const TextStyle(fontSize: 12.0, color: Colors.white),
                ),
                const Flexible(
                  child: SizedBox(height: 10.0),
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        flex: 5,
                        child: Text(
                          '₹',
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLength: 6,
                          controller: _amountController,
                          style: const TextStyle(fontSize: 40.0, color: Colors.white, height: 1),
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: Colors.white,
                          cursorHeight: 35.0,
                          decoration: const InputDecoration(
                            counterText: "",
                            hintText: '0',
                            hintStyle: TextStyle(fontSize: 40.0, color: Colors.white),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
                const Flexible(
                  child: SizedBox(height: 10),
                ),
                const Text(
                  'Payment via BillDesk',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            height: height * 0.2,
            width: width,
            padding: const EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Container(
                            color: Colors.grey,
                            height: 20,
                            width: 35,
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              height: 8,
                              width: 8,
                              alignment: Alignment.center,
                              child: Container(
                                color: Colors.grey,
                                height: 8,
                                width: 8,
                              ),
                            ),
                          ),
                          title: const Text(
                            'Your Bank ••••4321',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black54,
                        size: 28.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                MaterialButton(
                  height: 36.0,
                  onPressed: () {
                    if (_amountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter amount'),
                        ),
                      );
                      return;
                    }
                    _amountController.text = "";
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MpinEntryScreen(amount: _amountController.value.text),
                      ),
                    );
                  },
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                  color: Colors.blue,
                  child: const Text(
                    'Proceed to pay',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'IN PARTNERSHIP WITH ',
                    style: const TextStyle(color: Colors.black54, fontSize: 12.0),
                    children: [
                      WidgetSpan(
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                          height: 16,
                          width: 16,
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.white,
                            height: 8,
                            width: 8,
                          ),
                        ),
                      ),
                      const TextSpan(
                        text: ' YOUR BANK',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
