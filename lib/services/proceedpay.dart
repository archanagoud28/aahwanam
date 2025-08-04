import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'addcard.dart';
import 'paymentsuccess.dart';

class PaymentOptionsScreen extends StatefulWidget {
  final double? total; // ✅ Make it nullable if optional

  const PaymentOptionsScreen({Key? key, this.total}) : super(key: key);

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  String selectedPaymentMethod = "upi";
  bool useDefaultUpi = true;
  late Razorpay _razorpay;

  final String amount = "1";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _launchRazorpay({String? upiId}) {
    var options = {
      'key': 'rzp_live_KK4RDkGbtZzQf1',
      'amount': ((widget.total ?? 0) * 100).toInt(), // ✅ Correct conversion
      'name': 'Aahwanam',
      'description': 'Service Payment',
      'prefill': {
        'contact': '9014944283',
        'email': 'archanaashannagari@gmail.com',
      },
      if (!useDefaultUpi) 'method': 'upi',
      if (!useDefaultUpi && upiId != null) 'vpa': upiId,
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaymentSuccessScreen()),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment failed. Please try again.")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("External Wallet Selected: ${response.walletName}")),
    );
  }

  Future<void> _showUpiInputDialog() async {
    String? upiId = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text("Enter UPI ID"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "example@upi"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );

    if (upiId != null && upiId.contains('@')) {
      setState(() {
        useDefaultUpi = false;
        selectedPaymentMethod = "upi";
      });
      _launchRazorpay(upiId: upiId);
    } else if (upiId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid UPI ID")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Options", style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E535B)),
          onPressed: () => Navigator.pop(context),
          splashRadius: 20,
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SizedBox(
          width: 170,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod == 'upi' && !useDefaultUpi) {
                  _showUpiInputDialog(); // Ask for UPI ID
                } else {
                  _launchRazorpay(); // Default UPI app flow
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E535B),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                "Proceed to Pay ₹${widget.total?.toStringAsFixed(2) ?? '0.00'}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),

            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _upiSection(),
        const SizedBox(height: 16),
        const Text("Cards", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _cardSection(),
        const SizedBox(height: 24),
        const Text("Pay On Delivery", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _codSection(),
      ],
    );
  }

  Widget _upiSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        border: Border.all(color: const Color(0xFFE2E2E2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pay by UPI", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildPaymentOptionCard(
            title: "Pay by any UPI app",
            subtitle: "Use any UPI app on your phone to pay",
            leadingIcon: Icons.account_balance_wallet_outlined,
            selected: selectedPaymentMethod == "upi" && useDefaultUpi,
            onTap: () {
              setState(() {
                selectedPaymentMethod = "upi";
                useDefaultUpi = true;
              });
            },
            showArrow: false,
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFFF1F1F1)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildMiniUpiIcon("assets/images/paytm.jpg", "Paytm", () {
                setState(() {
                  selectedPaymentMethod = "upi";
                  useDefaultUpi = true;
                });
                _launchRazorpay();
              }),
              const SizedBox(width: 12),
              _buildMiniUpiIcon("assets/images/phonepay.jpg", "PhonePe", () {
                setState(() {
                  selectedPaymentMethod = "upi";
                  useDefaultUpi = true;
                });
                _launchRazorpay();
              }),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFFF1F1F1)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _showUpiInputDialog,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E535B),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                const Text("Add new UPI ID", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E535B))),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF1E535B)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        border: Border.all(color: const Color(0xFFE2E2E2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildPaymentOptionCard(
        title: "Debit / Credit Cards",
        leadingIcon: Icons.credit_card,
        selected: selectedPaymentMethod == "card",
        onTap: () {
          setState(() {
            selectedPaymentMethod = "card";
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCardScreen()),
          );
        },
      ),
    );
  }

  Widget _codSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        border: Border.all(color: const Color(0xFFE2E2E2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildPaymentOptionCard(
        title: "Cash On Delivery",
        leadingIcon: Icons.money,
        selected: selectedPaymentMethod == "cod",
        onTap: () {
          setState(() {
            selectedPaymentMethod = "cod";
          });
        },
      ),
    );
  }

  Widget _buildPaymentOptionCard({
    required String title,
    String? subtitle,
    required IconData leadingIcon,
    required VoidCallback onTap,
    bool selected = false,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(leadingIcon, color: const Color(0xFF1E535B)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                if (subtitle != null) Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const Spacer(),
          if (showArrow) const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF1E535B)),
          if (selected) const Icon(Icons.check_circle, color: Color(0xFF1E535B)),
        ],
      ),
    );
  }

  Widget _buildMiniUpiIcon(String imagePath, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
