import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaPurchaseGiftCardView extends StatefulWidget {
  const SpaPurchaseGiftCardView({super.key});

  @override
  State<SpaPurchaseGiftCardView> createState() => _SpaPurchaseGiftCardViewState();
}

class _SpaPurchaseGiftCardViewState extends State<SpaPurchaseGiftCardView> {
  double selectedAmount = 100.0;
  String customAmount = "";
  String recipientName = "";
  String recipientEmail = "";
  String senderName = "";
  String personalMessage = "";
  String selectedDesign = "classic";
  String selectedDeliveryMethod = "email";
  DateTime deliveryDate = DateTime.now().add(Duration(days: 1));
  bool scheduleDelivery = false;
  
  List<double> presetAmounts = [25.0, 50.0, 100.0, 150.0, 200.0, 300.0];
  
  List<Map<String, dynamic>> giftCardDesigns = [
    {
      "id": "classic",
      "name": "Classic Elegance",
      "image": "https://picsum.photos/300/200?random=1&keyword=elegant",
      "description": "Timeless and sophisticated design",
    },
    {
      "id": "floral",
      "name": "Floral Bliss",
      "image": "https://picsum.photos/300/200?random=2&keyword=flowers",
      "description": "Beautiful floral patterns",
    },
    {
      "id": "zen",
      "name": "Zen Garden",
      "image": "https://picsum.photos/300/200?random=3&keyword=zen",
      "description": "Peaceful and calming design",
    },
    {
      "id": "luxury",
      "name": "Luxury Gold",
      "image": "https://picsum.photos/300/200?random=4&keyword=gold",
      "description": "Premium golden theme",
    },
  ];
  
  List<Map<String, dynamic>> deliveryMethods = [
    {"label": "Email Delivery", "value": "email"},
    {"label": "Print at Home", "value": "print"},
    {"label": "Physical Card", "value": "physical"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Gift Card"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showGiftCardHelp(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildAmountSection(),
            _buildDesignSection(),
            _buildRecipientSection(),
            _buildDeliverySection(),
            _buildOrderSummary(),
            _buildPurchaseButton(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAmountSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Amount",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: presetAmounts.map((amount) {
              bool isSelected = selectedAmount == amount;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAmount = amount;
                    customAmount = "";
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${amount.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? primaryColor : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          Text(
            "Or enter custom amount:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          QNumberField(
            label: "Custom Amount (\$)",
            value: customAmount,
            hint: "Enter amount between \$10 - \$1000",
            onChanged: (value) {
              customAmount = value;
              double? amount = double.tryParse(value);
              if (amount != null && amount >= 10 && amount <= 1000) {
                selectedAmount = amount;
              }
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildDesignSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Design",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: giftCardDesigns.map((design) {
              bool isSelected = selectedDesign == design["id"];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDesign = design["id"];
                  });
                },
                child: Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 3 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                        child: Image.network(
                          "${design["image"]}",
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          children: [
                            Text(
                              "${design["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? primaryColor : Colors.black,
                              ),
                            ),
                            Text(
                              "${design["description"]}",
                              textAlign: TextAlign.center,
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
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRecipientSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recipient Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Recipient Name",
            value: recipientName,
            validator: Validator.required,
            onChanged: (value) {
              recipientName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Recipient Email",
            value: recipientEmail,
            validator: Validator.email,
            onChanged: (value) {
              recipientEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Your Name",
            value: senderName,
            validator: Validator.required,
            onChanged: (value) {
              senderName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Personal Message",
            value: personalMessage,
            hint: "Add a personal touch to your gift card...",
            onChanged: (value) {
              personalMessage = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildDeliverySection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Delivery Method",
            items: deliveryMethods,
            value: selectedDeliveryMethod,
            onChanged: (value, label) {
              selectedDeliveryMethod = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Schedule delivery for later",
                "value": true,
                "checked": scheduleDelivery,
              }
            ],
            value: [if (scheduleDelivery) {"label": "Schedule delivery for later", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                scheduleDelivery = values.isNotEmpty;
              });
            },
          ),
          if (scheduleDelivery)
            QDatePicker(
              label: "Delivery Date",
              value: deliveryDate,
              onChanged: (value) {
                deliveryDate = value;
                setState(() {});
              },
            ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Delivery Information",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Email delivery is instant\n• Print-at-home cards are available immediately\n• Physical cards take 3-5 business days",
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOrderSummary() {
    double tax = selectedAmount * 0.08;
    double processingFee = selectedDeliveryMethod == "physical" ? 5.0 : 0.0;
    double total = selectedAmount + tax + processingFee;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spMd,
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Gift Card Value",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                "\$${selectedAmount.currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          if (processingFee > 0)
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Processing Fee (Physical Card)",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "\$${processingFee.currency}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Tax",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                "\$${tax.currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${total.currency}",
                style: TextStyle(
                  fontSize: 18,
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
  
  Widget _buildPurchaseButton() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Purchase Gift Card",
            size: bs.md,
            onPressed: () => _purchaseGiftCard(),
          ),
        ),
        Text(
          "By purchasing, you agree to our Terms of Service and Gift Card Policy",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
  
  void _showGiftCardHelp() {
    si("Gift card help information available");
  }
  
  void _purchaseGiftCard() {
    if (recipientName.isEmpty || recipientEmail.isEmpty || senderName.isEmpty) {
      se("Please fill in all required fields");
      return;
    }
    
    if (selectedAmount < 10 || selectedAmount > 1000) {
      se("Gift card amount must be between \$10 and \$1000");
      return;
    }
    
    ss("Gift card purchased successfully!");
    back();
  }
}
