import 'package:amazon_clone/common/widgets/custom_textfiled.dart';
import 'package:amazon_clone/constants/utilis.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.totalAmount});
  static const String routeName = '/address';
  final String totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();

  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  late Future<PaymentConfiguration> _googlePayConfigFuture;

  String addressToBeUsed = "";
  List<PaymentItem> _paymentItems = [];

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');
    print("Google Pay configuration loading...");
    _paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
        type: PaymentItemType.total,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _areaController.dispose();
    _flatController.dispose();
    _pinController.dispose();
    _townController.dispose();
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
    print("Google Pay result received");
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = _flatController.text.isNotEmpty || _areaController.text.isNotEmpty || _pinController.text.isNotEmpty || _townController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed = '${_flatController.text}, ${_areaController.text}, ${_townController.text} - ${_pinController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBarError(context, 'ERROR');
    }
    print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text('Place Your Order'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF84d8e2),
                  Color(0xFF92deda),
                  Color(0xFFa5e6d0)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                            size: 24,
                          ),
                          Expanded(
                            child: Text(
                              'Delivery to ${Provider.of<UserProvider>(context).user.name} - $address',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                              top: 2,
                            ),
                            child: Icon(Icons.arrow_drop_down_outlined),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    customTextField(
                      controller: _flatController,
                      obSecureChar: false,
                      hintText: 'Flat, House no, Building ',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customTextField(
                      controller: _areaController,
                      hintText: 'Area, Street, pincode',
                      obSecureChar: false,
                    ),
                    customTextField(
                      controller: _pinController,
                      hintText: 'pincode',
                      obSecureChar: false,
                    ),
                    customTextField(
                      controller: _townController,
                      hintText: 'Town, City',
                      obSecureChar: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
                future: _googlePayConfigFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading configuration: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return GooglePayButton(
                      paymentConfiguration: snapshot.data!,
                      paymentItems: _paymentItems,
                      type: GooglePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15.0),
                      theme: GooglePayButtonTheme.light,
                      width: double.infinity,
                      onPaymentResult: onGooglePayResult,
                      onPressed: () => payPressed(address),
                      loadingIndicator: const Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
