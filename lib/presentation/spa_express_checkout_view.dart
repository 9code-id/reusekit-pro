import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaExpressCheckoutView extends StatefulWidget {
  const SpaExpressCheckoutView({super.key});

  @override
  State<SpaExpressCheckoutView> createState() => _SpaExpressCheckoutViewState();
}

class _SpaExpressCheckoutViewState extends State<SpaExpressCheckoutView> {
  String selectedPaymentMethod = "apple_pay";
  String selectedAddress = "home";
  bool isProcessing = false;
  
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "iPhone 15 Pro",
      "price": 999.00,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=1&keyword=phone"
    },
    {
      "id": 2,
      "name": "MagSafe Charger",
      "price": 39.00,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=2&keyword=charger"
    }
  ];
  
  List<Map<String, dynamic>> savedAddresses = [
    {
      "id": "home",
      "label": "Home",
      "name": "John Doe",
      "address": "123 Main Street",
      "city": "New York",
      "state": "NY",
      "zip": "10001",
      "isDefault": true
    },
    {
      "id": "work",
      "label": "Work",
      "name": "John Doe",
      "address": "456 Business Ave",
      "city": "New York",
      "state": "NY",
      "zip": "10002",
      "isDefault": false
    }
  ];
  
  List<Map<String, dynamic>> savedPaymentMethods = [
    {
      "id": "apple_pay",
      "type": "digital_wallet",
      "label": "Apple Pay",
      "icon": Icons.apple,
      "isDefault": true,
      "isExpress": true
    },
    {
      "id": "google_pay",
      "type": "digital_wallet",
      "label": "Google Pay",
      "icon": Icons.g_mobiledata,
      "isDefault": false,
      "isExpress": true
    },
    {
      "id": "paypal",
      "type": "digital_wallet",
      "label": "PayPal",
      "icon": Icons.payment,
      "isDefault": false,
      "isExpress": true
    },
    {
      "id": "credit_card_1",
      "type": "credit_card",
      "label": "•••• 1234",
      "icon": Icons.credit_card,
      "brand": "Visa",
      "isDefault": false,
      "isExpress": false
    }
  ];

  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get tax => subtotal * 0.08;
  double get shipping => subtotal > 50 ? 0.0 : 9.99;
  double get total => subtotal + tax + shipping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Express Checkout"),
        actions: [
          Icon(
            Icons.security,
            color: successColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildExpressPaymentOptions(),
            _buildOrderSummary(),
            _buildDeliveryAddress(),
            _buildOrderTotal(),
            _buildExpressCheckoutButton(),
            _buildSecurityInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildExpressPaymentOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Express Payment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Pay quickly and securely with your preferred method",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Column(
            spacing: spXs,
            children: savedPaymentMethods
                .where((method) => method["isExpress"] as bool)
                .map((method) => _buildPaymentMethodTile(method))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile(Map<String, dynamic> method) {
    bool isSelected = selectedPaymentMethod == method["id"];
    
    return GestureDetector(
      onTap: () {
        selectedPaymentMethod = method["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                method["icon"] as IconData,
                color: isSelected ? Colors.white : disabledBoldColor,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${method["label"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  if (method["type"] == "credit_card") ...[
                    Text(
                      "${method["brand"]} Card",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Touch ID or Face ID",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${cartItems.length} items",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...cartItems.map((item) => _buildOrderItem(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radiusSm),
          child: Image.network(
            "${item["image"]}",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "Qty: ${item["quantity"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Text(
          "\$${(item["price"] as double).toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Delivery Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _showAddressSelector,
                child: Text(
                  "Change",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          _buildSelectedAddress(),
          Row(
            children: [
              Icon(
                Icons.local_shipping,
                color: successColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                shipping == 0 ? "FREE delivery" : "Standard delivery",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "Est. 2-3 days",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedAddress() {
    Map<String, dynamic> address = savedAddresses.firstWhere((addr) => addr["id"] == selectedAddress);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${address["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${address["address"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
          Text(
            "${address["city"]}, ${address["state"]} ${address["zip"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTotal() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          _buildTotalRow("Subtotal", subtotal),
          _buildTotalRow("Tax", tax),
          _buildTotalRow("Shipping", shipping),
          if (shipping == 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "FREE shipping on orders over \$50",
                style: TextStyle(
                  fontSize: 10,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Container(
            height: 1,
            color: disabledColor,
            margin: EdgeInsets.symmetric(vertical: spXs),
          ),
          _buildTotalRow("Total", total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildExpressCheckoutButton() {
    String paymentMethodLabel = savedPaymentMethods
        .firstWhere((method) => method["id"] == selectedPaymentMethod)["label"];
    
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: isProcessing 
                ? "Processing..." 
                : "Pay with $paymentMethodLabel - \$${total.toStringAsFixed(2)}",
            size: bs.md,
            onPressed: isProcessing ? null : _processExpressCheckout,
          ),
        ),
        Text(
          "Your payment information is secured with end-to-end encryption",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.shield,
            color: successColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Secure Express Checkout",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
                Text(
                  "Protected by 256-bit SSL encryption and fraud detection",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Delivery Address"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: savedAddresses.map((address) => _buildAddressOption(address)).toList(),
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressOption(Map<String, dynamic> address) {
    bool isSelected = selectedAddress == address["id"];
    
    return GestureDetector(
      onTap: () {
        selectedAddress = address["id"];
        setState(() {});
        back();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spXs),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${address["label"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                if (address["isDefault"] as bool) ...[
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Default",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            Text(
              "${address["name"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
            Text(
              "${address["address"]}, ${address["city"]}, ${address["state"]} ${address["zip"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _processExpressCheckout() async {
    setState(() => isProcessing = true);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: spMd),
            Text("Processing payment..."),
            SizedBox(height: spSm),
            Text(
              "Please authenticate using Touch ID or Face ID",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
    
    // Simulate processing
    await Future.delayed(Duration(seconds: 3));
    
    back();
    setState(() => isProcessing = false);
    
    ss("Payment successful! Your order has been placed.");
  }
}
