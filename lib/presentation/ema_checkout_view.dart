import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaCheckoutView extends StatefulWidget {
  const EmaCheckoutView({super.key});

  @override
  State<EmaCheckoutView> createState() => _EmaCheckoutViewState();
}

class _EmaCheckoutViewState extends State<EmaCheckoutView> {
  bool loading = false;
  String promoCode = "";
  bool useStoredPayment = true;
  bool agreeToTerms = false;
  String selectedPaymentMethod = "credit_card";
  String billingAddress = "";
  String email = "";
  String phone = "";
  
  List<Map<String, dynamic>> cartItems = [
    {
      "id": "1",
      "eventName": "Tech Conference 2025",
      "ticketType": "VIP Pass",
      "quantity": 2,
      "price": 299.0,
      "section": "VIP Section A",
      "seats": ["A-15", "A-16"],
      "date": "2025-07-15",
      "time": "09:00 AM",
    },
    {
      "id": "2", 
      "eventName": "Music Festival",
      "ticketType": "General Admission",
      "quantity": 1,
      "price": 89.0,
      "section": "General",
      "seats": ["GA-001"],
      "date": "2025-08-20",
      "time": "06:00 PM",
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "credit_card",
      "type": "Credit Card",
      "cardNumber": "**** **** **** 4532",
      "expiry": "12/27",
      "icon": Icons.credit_card,
    },
    {
      "id": "paypal",
      "type": "PayPal",
      "email": "user@email.com", 
      "icon": Icons.account_balance_wallet,
    },
    {
      "id": "apple_pay",
      "type": "Apple Pay",
      "device": "iPhone 14 Pro",
      "icon": Icons.phone_iphone,
    },
  ];

  List<Map<String, dynamic>> promoCodes = [
    {
      "code": "SAVE20",
      "discount": 20.0,
      "type": "percentage",
      "description": "20% off total order",
    },
    {
      "code": "FIRST50",
      "discount": 50.0,
      "type": "fixed",
      "description": "\$50 off first purchase",
    },
  ];

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
      sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get processingFee => subtotal * 0.025;
  double get taxes => subtotal * 0.08;
  
  double get discount {
    if (promoCode.isEmpty) return 0.0;
    final promo = promoCodes.firstWhere(
      (p) => p["code"] == promoCode,
      orElse: () => {},
    );
    if (promo.isEmpty) return 0.0;
    
    if (promo["type"] == "percentage") {
      return subtotal * ((promo["discount"] as double) / 100);
    } else {
      return promo["discount"] as double;
    }
  }

  double get total => subtotal + processingFee + taxes - discount;

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          // Cart Items
          ...cartItems.map((item) => Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.event,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["eventName"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${item["ticketType"]} • ${item["section"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Qty: ${item["quantity"]} • Seats: ${(item["seats"] as List).join(", ")}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${(item["price"] as double).toStringAsFixed(2)} each",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
          
          SizedBox(height: spMd),
          
          // Price Breakdown
          _buildPriceRow("Subtotal", subtotal),
          _buildPriceRow("Processing Fee", processingFee),
          _buildPriceRow("Taxes", taxes),
          if (discount > 0) _buildPriceRow("Discount", -discount, color: successColor),
          
          Divider(height: spMd * 2),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${amount < 0 ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color ?? primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Enter promo code",
                  value: promoCode,
                  onChanged: (value) {
                    promoCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Apply",
                size: bs.sm,
                onPressed: () {
                  if (promoCode.isNotEmpty) {
                    final isValid = promoCodes.any((p) => p["code"] == promoCode);
                    if (isValid) {
                      ss("Promo code applied successfully!");
                    } else {
                      se("Invalid promo code");
                    }
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          
          if (discount > 0) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Promo code applied: -\$${discount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // navigateTo(EmaPaymentMethodView())
                },
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
          SizedBox(height: spMd),
          
          ...paymentMethods.map((method) => GestureDetector(
            onTap: () {
              selectedPaymentMethod = method["id"];
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: selectedPaymentMethod == method["id"] 
                  ? primaryColor.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: selectedPaymentMethod == method["id"]
                    ? primaryColor
                    : disabledOutlineBorderColor,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: selectedPaymentMethod == method["id"]
                        ? primaryColor
                        : disabledBoldColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      method["icon"],
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${method["type"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if (method["cardNumber"] != null)
                          Text(
                            "${method["cardNumber"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        if (method["email"] != null)
                          Text(
                            "${method["email"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selectedPaymentMethod == method["id"])
                    Icon(
                      Icons.check_circle,
                      color: primaryColor,
                      size: 20,
                    ),
                ],
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildBillingInfoSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Billing Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          QTextField(
            label: "Email Address",
            value: email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Phone Number",
            value: phone,
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          
          QTextField(
            label: "Billing Address",
            value: billingAddress,
            onChanged: (value) {
              billingAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Terms & Conditions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  agreeToTerms = !agreeToTerms;
                  setState(() {});
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: agreeToTerms ? primaryColor : Colors.transparent,
                    border: Border.all(
                      color: agreeToTerms ? primaryColor : disabledOutlineBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: agreeToTerms
                    ? Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "I agree to the Terms of Service and Privacy Policy",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "By completing this purchase, you agree to our refund and cancellation policies.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: infoColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Important Information",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "• Tickets are non-transferable and non-refundable\n• Valid ID required for entry\n• Event subject to change or cancellation\n• Processing fee is non-refundable",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _processCheckout() async {
    if (loading) return;
    
    if (!agreeToTerms) {
      se("Please agree to the terms and conditions");
      return;
    }
    
    if (email.isEmpty || phone.isEmpty) {
      se("Please fill in all required fields");
      return;
    }
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    loading = false;
    setState(() {});
    
    ss("Order placed successfully! Check your email for tickets.");
    
    // navigateTo(EmaTicketPurchaseView())
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Need help? Contact our support team");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(),
            SizedBox(height: spMd),
            _buildPromoCodeSection(),
            SizedBox(height: spMd),
            _buildPaymentMethodSection(),
            SizedBox(height: spMd),
            _buildBillingInfoSection(),
            SizedBox(height: spMd),
            _buildTermsSection(),
            SizedBox(height: spMd * 2),
            
            // Checkout Button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading 
                  ? "Processing..." 
                  : "Complete Purchase - \$${total.toStringAsFixed(2)}",
                size: bs.md,
                onPressed: _processCheckout,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Secure Checkout Info
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Secure 256-bit SSL encrypted checkout",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
