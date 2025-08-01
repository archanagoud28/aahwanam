import 'package:aahwanam/services/proceedpay.dart';
import 'package:flutter/material.dart';

class DetailedPackageCartScreen extends StatefulWidget {
  const DetailedPackageCartScreen({Key? key}) : super(key: key);

  @override
  State<DetailedPackageCartScreen> createState() =>
      _DetailedPackageCartScreenState();
}

class _DetailedPackageCartScreenState extends State<DetailedPackageCartScreen> {
  final List<Map<String, dynamic>> services = [
    {
      "title": "Decoration",
      "price": "₹ 8,000",
      "image": "assets/images/cartdecoration.png",
      "quantity": 1
    },
    {
      "title": "Decoration",
      "price": "₹ 8,000",
      "image": "assets/images/cartdecoration2.png",
      "quantity": 1
    },
    {
      "title": "Bartender",
      "price": "₹ 8,000",
      "image": "assets/images/cartbortender.png",
      "quantity": 1
    },
    {
      "title": "Royal valet Service",
      "price": "₹ 8,000",
      "image": "assets/images/RoyalvaletService.png",
      "quantity": 1
    },
  ];

  int platformFee = 100;

  int get total {
    int serviceTotal =
        services.fold<int>(0, (int sum, Map<String, dynamic> item) {
      int price = int.parse(item["price"].replaceAll(RegExp(r'[^0-9]'), ''));
      int quantity = item["quantity"] as int;
      return sum + (price * quantity);
    });
    return serviceTotal + platformFee;
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      int newQty = (services[index]["quantity"] as int) + delta;
      if (newQty >= 1) {
        services[index]["quantity"] = newQty;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Package Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            "Birthday Party Package",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0XFF575959),
            ),
          ),
          const SizedBox(height: 8),

          /// ✅ Services List + Bill Details in one scrollable widget
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...services.asMap().entries.map((entry) {
                  int index = entry.key;
                  final service = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4E8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            service["image"],
                            width: 67,
                            height: 46,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        /// Title + Price Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service["title"],
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1.0,
                                    // ✅ line-height: 100%
                                    color: Color(0xFF575959)),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                service["price"],
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1E535B),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Quantity Selector
                        /// Quantity Selector
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF1E535B),
                            // 👈 background white
                            border: Border.all(color: const Color(0xFF1E535B)),
                            // 👈 same theme color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => _updateQuantity(index, -1),
                                child: const Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: Colors.white, // 👈 theme color
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                (service["quantity"] as int).toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white, // 👈 text color per spec
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () => _updateQuantity(index, 1),
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.white, // 👈 theme color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 16),

                /// ✅ Bill Details immediately after services
                Row(children: const [
                  Expanded(child: Divider(thickness: 1)),
                  SizedBox(width: 6),
                  Text(
                    "Bill Details",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      // Medium
                      fontSize: 14,
                      height: 1.0,
                      // line-height: 100%
                      letterSpacing: 0,
                      color: Color(0xFF575959),
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(child: Divider(thickness: 1)),
                ]),
                const SizedBox(height: 6),
                _buildBillRow("Package Charges", "₹ ${total - platformFee}",
                    showInfo: true),
                _buildBillRow("Platform Fee", "₹ $platformFee"),
                _buildBillRow("Transport Fee", "FREE"),
                _buildBillRow("Total", "₹ $total", bold: true),
              ],
            ),
          ),

          /// ✅ Proceed Button fixed at bottom
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              // 👈 adds gap at the bottom
              child: SizedBox(
                width: 189,
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E535B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentOptionsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Proceed to pay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String value,
      {bool showInfo = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                    // ✅ Total bold, others normal
                    fontSize: 12,
                    height: 2.0,
                    // ✅ line-height: 100%
                    letterSpacing: 0,
                    color: const Color(0xFF757575),
                  ),
                ),
                if (showInfo) const SizedBox(width: 4),
                if (showInfo)
                  const Icon(Icons.info_outline,
                      size: 14, color: Color(0xFF757575)),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              fontSize: 12,
              height: 2.0,
              letterSpacing: 0,
              color: bold
                  ? const Color(0xFF1E535B) // maybe for total?
                  : const Color(0xFF575959),
            ),
          ),
        ],
      ),
    );
  }
}
