import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCheckout2View extends StatefulWidget {
  const GrlCheckout2View({Key? key}) : super(key: key);

  @override
  State<GrlCheckout2View> createState() => _GrlCheckout2ViewState();
}

class _GrlCheckout2ViewState extends State<GrlCheckout2View> {
  int currentStep = 0;
  String selectedShipping = "standard";
  String giftMessage = "";
  bool isGift = false;
  String recipientName = "";
  String recipientEmail = "";
  
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Luxury Handbag",
      "image": "https://picsum.photos/100/100?random=1&keyword=handbag",
      "price": 850.00,
      "quantity": 1,
      "brand": "Designer Collection",
      "color": "Black Leather"
    },
    {
      "id": 2,
      "name": "Silk Scarf",
      "image": "https://picsum.photos/100/100?random=2&keyword=scarf",
      "price": 195.00,
      "quantity": 2,
      "brand": "Premium Silk",
      "color": "Floral Pattern"
    },
  ];

  List<Map<String, dynamic>> shippingOptions = [
    {
      "id": "standard",
      "name": "Standard Shipping",
      "description": "5-7 business days",
      "price": 9.99,
      "icon": Icons.local_shipping,
    },
    {
      "id": "express",
      "name": "Express Shipping",
      "description": "2-3 business days",
      "price": 19.99,
      "icon": Icons.flash_on,
    },
    {
      "id": "overnight",
      "name": "Overnight Shipping",
      "description": "Next business day",
      "price": 39.99,
      "icon": Icons.rocket_launch,
    },
  ];

  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)));
  double get shippingCost => shippingOptions.firstWhere((s) => s["id"] == selectedShipping)["price"] as double;
  double get tax => subtotal * 0.085;
  double get total => subtotal + shippingCost + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            _buildProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spLg,
                  children: [
                    if (currentStep == 0) ...[
                      _buildCartReview(),
                      _buildShippingOptions(),
                    ] else if (currentStep == 1) ...[
                      _buildGiftOptions(),
                      _buildSpecialInstructions(),
                    ] else if (currentStep == 2) ...[
                      _buildOrderReview(),
                      _buildFinalPricing(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStepIndicator(0, "Cart", Icons.shopping_cart),
          Expanded(child: _buildStepLine(0)),
          _buildStepIndicator(1, "Options", Icons.card_giftcard),
          Expanded(child: _buildStepLine(1)),
          _buildStepIndicator(2, "Review", Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, IconData icon) {
    bool isActive = currentStep >= step;
    bool isCurrent = currentStep == step;
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.grey.shade200,
            shape: BoxShape.circle,
            border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : disabledBoldColor,
            size: 20,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isActive ? primaryColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int step) {
    bool isActive = currentStep > step;
    return Container(
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: spSm),
      color: isActive ? primaryColor : Colors.grey.shade300,
    );
  }

  Widget _buildCartReview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review Your Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: cartItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${item["image"]}",
                        width: 80,
                        height: 80,
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${item["brand"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${item["color"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Qty: ${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shipping Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: shippingOptions.map((option) {
              bool isSelected = selectedShipping == option["id"];
              return GestureDetector(
                onTap: () {
                  selectedShipping = option["id"];
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(25) : Colors.grey.shade50,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(50),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          option["icon"] as IconData,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${option["name"]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${option["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(option["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftOptions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gift Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "This is a gift",
                      "value": true,
                      "checked": isGift,
                    }
                  ],
                  value: [
                    if (isGift)
                      {
                        "label": "This is a gift",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    isGift = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (isGift) ...[
            SizedBox(height: spSm),
            QTextField(
              label: "Recipient Name",
              value: recipientName,
              hint: "Enter recipient's name",
              validator: Validator.required,
              onChanged: (value) {
                recipientName = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Recipient Email",
              value: recipientEmail,
              hint: "Enter recipient's email",
              validator: Validator.email,
              onChanged: (value) {
                recipientEmail = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpecialInstructions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gift Message",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Add a personal message",
            value: giftMessage,
            hint: "Write a special message for the recipient...",
            onChanged: (value) {
              giftMessage = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderReview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.local_shipping, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shippingOptions.firstWhere((s) => s["id"] == selectedShipping)["name"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        shippingOptions.firstWhere((s) => s["id"] == selectedShipping)["description"],
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${shippingCost.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (isGift) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.card_giftcard, color: Colors.pink, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gift for ${recipientName}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          recipientEmail,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.check_circle, color: successColor, size: 18),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFinalPricing() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Total",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          _buildPriceRow("Subtotal (${cartItems.length} items)", subtotal),
          _buildPriceRow("Shipping", shippingCost),
          _buildPriceRow("Tax", tax),
          if (isGift)
            _buildPriceRow("Gift wrapping", 5.99),
          Divider(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${(total + (isGift ? 5.99 : 0)).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: fsH5,
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

  Widget _buildPriceRow(String label, double amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
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
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowLg],
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Back",
                size: bs.md,
                color: secondaryColor,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          if (currentStep > 0) SizedBox(width: spSm),
          Expanded(
            flex: 2,
            child: QButton(
              label: currentStep == 2 ? "Place Order" : "Continue",
              size: bs.md,
              onPressed: _handleNextStep,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNextStep() {
    if (currentStep < 2) {
      if (currentStep == 1 && isGift) {
        if (recipientName.isEmpty || recipientEmail.isEmpty) {
          se("Please fill in all gift recipient details");
          return;
        }
      }
      
      currentStep++;
      setState(() {});
    } else {
      _placeOrder();
    }
  }

  void _placeOrder() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      Future.delayed(Duration(seconds: 3), () {
        hideLoading();
        ss("Order placed successfully!");
        // Navigate to order confirmation
      });
    }
  }
}
