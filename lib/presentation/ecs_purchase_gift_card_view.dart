import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsPurchaseGiftCardView extends StatefulWidget {
  const EcsPurchaseGiftCardView({super.key});

  @override
  State<EcsPurchaseGiftCardView> createState() => _EcsPurchaseGiftCardViewState();
}

class _EcsPurchaseGiftCardViewState extends State<EcsPurchaseGiftCardView> {
  String selectedAmount = "";
  String customAmount = "";
  String recipientName = "";
  String recipientEmail = "";
  String senderName = "";
  String personalMessage = "";
  String selectedDesign = "birthday";
  bool isScheduled = false;
  DateTime? deliveryDate;
  
  List<Map<String, dynamic>> predefinedAmounts = [
    {"label": "\$25", "value": "25"},
    {"label": "\$50", "value": "50"},
    {"label": "\$75", "value": "75"},
    {"label": "\$100", "value": "100"},
    {"label": "\$150", "value": "150"},
    {"label": "\$200", "value": "200"},
  ];

  List<Map<String, dynamic>> giftCardDesigns = [
    {
      "id": "birthday",
      "name": "Birthday",
      "image": "https://picsum.photos/300/200?random=1&keyword=birthday",
      "color": [233, 30, 99],
    },
    {
      "id": "anniversary",
      "name": "Anniversary",
      "image": "https://picsum.photos/300/200?random=2&keyword=anniversary",
      "color": [156, 39, 176],
    },
    {
      "id": "congratulations",
      "name": "Congratulations",
      "image": "https://picsum.photos/300/200?random=3&keyword=congratulations",
      "color": [76, 175, 80],
    },
    {
      "id": "thankyou",
      "name": "Thank You",
      "image": "https://picsum.photos/300/200?random=4&keyword=thankyou",
      "color": [255, 152, 0],
    },
    {
      "id": "holiday",
      "name": "Holiday",
      "image": "https://picsum.photos/300/200?random=5&keyword=holiday",
      "color": [244, 67, 54],
    },
    {
      "id": "general",
      "name": "General",
      "image": "https://picsum.photos/300/200?random=6&keyword=gift",
      "color": [63, 81, 181],
    },
  ];

  double get finalAmount {
    if (selectedAmount.isNotEmpty) {
      return double.tryParse(selectedAmount) ?? 0.0;
    }
    return double.tryParse(customAmount) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Gift Card"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gift Card Preview
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      giftCardDesigns.firstWhere(
                        (design) => design["id"] == selectedDesign,
                        orElse: () => giftCardDesigns[0],
                      )["image"],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(153),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    right: spMd,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gift Card",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          finalAmount > 0 ? "\$${finalAmount.toStringAsFixed(0)}" : "\$0",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Amount Selection
            _buildSection(
              title: "Select Amount",
              child: Column(
                children: [
                  // Predefined Amounts
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 100,
                    children: predefinedAmounts.map((amount) {
                      bool isSelected = selectedAmount == amount["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedAmount = amount["value"];
                          customAmount = "";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${amount["label"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : primaryColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Custom Amount
                  QTextField(
                    label: "Or enter custom amount",
                    value: customAmount,
                    hint: "Enter amount",
                    onChanged: (value) {
                      customAmount = value;
                      selectedAmount = "";
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Design Selection
            _buildSection(
              title: "Choose Design",
              child: QHorizontalScroll(
                children: giftCardDesigns.map((design) {
                  bool isSelected = selectedDesign == design["id"];
                  return GestureDetector(
                    onTap: () {
                      selectedDesign = design["id"];
                      setState(() {});
                    },
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              topRight: Radius.circular(radiusSm),
                            ),
                            child: Image.network(
                              "${design["image"]}",
                              width: double.infinity,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(spXs),
                            child: Text(
                              "${design["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            // Recipient Information
            _buildSection(
              title: "Recipient Information",
              child: Column(
                children: [
                  QTextField(
                    label: "Recipient Name",
                    value: recipientName,
                    hint: "Enter recipient's full name",
                    onChanged: (value) {
                      recipientName = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QTextField(
                    label: "Recipient Email",
                    value: recipientEmail,
                    hint: "Enter recipient's email address",
                    onChanged: (value) {
                      recipientEmail = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Sender Information
            _buildSection(
              title: "Your Information",
              child: QTextField(
                label: "Your Name",
                value: senderName,
                hint: "Enter your name",
                onChanged: (value) {
                  senderName = value;
                  setState(() {});
                },
              ),
            ),
            
            // Personal Message
            _buildSection(
              title: "Personal Message (Optional)",
              child: QMemoField(
                label: "Personal Message",
                value: personalMessage,
                hint: "Write a personal message for the recipient...",
                onChanged: (value) {
                  personalMessage = value;
                  setState(() {});
                },
              ),
            ),
            
            // Delivery Options
            _buildSection(
              title: "Delivery Options",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Schedule for later",
                              "value": true,
                              "checked": isScheduled,
                            }
                          ],
                          value: [
                            if (isScheduled)
                              {
                                "label": "Schedule for later",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isScheduled = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  if (isScheduled) ...[
                    SizedBox(height: spSm),
                    QDatePicker(
                      label: "Delivery Date",
                      value: deliveryDate ?? DateTime.now().add(Duration(days: 1)),
                      onChanged: (value) {
                        deliveryDate = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Summary Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledColor),
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
                  SizedBox(height: spSm),
                  _buildSummaryRow("Gift Card Value", finalAmount > 0 ? "\$${finalAmount.toStringAsFixed(0)}" : "Not selected"),
                  _buildSummaryRow("Design", giftCardDesigns.firstWhere((d) => d["id"] == selectedDesign)["name"]),
                  _buildSummaryRow("Recipient", recipientName.isNotEmpty ? recipientName : "Not entered"),
                  _buildSummaryRow("Delivery", isScheduled && deliveryDate != null 
                      ? "Scheduled for ${deliveryDate!.dMMMy}" 
                      : "Send immediately"),
                  Divider(color: disabledColor),
                  _buildSummaryRow("Total", finalAmount > 0 ? "\$${finalAmount.toStringAsFixed(2)}" : "\$0.00", isTotal: true),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: QButton(
          label: "Purchase Gift Card - \$${finalAmount.toStringAsFixed(0)}",
          size: bs.md,
          onPressed: finalAmount > 0 && recipientName.isNotEmpty && recipientEmail.isNotEmpty
              ? () => _purchaseGiftCard()
              : null,
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          child,
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? primaryColor : disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? primaryColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _purchaseGiftCard() {
    if (finalAmount <= 0) {
      se("Please select or enter a gift card amount");
      return;
    }
    
    if (recipientName.isEmpty) {
      se("Please enter recipient's name");
      return;
    }
    
    if (recipientEmail.isEmpty) {
      se("Please enter recipient's email");
      return;
    }
    
    if (senderName.isEmpty) {
      se("Please enter your name");
      return;
    }
    
    // Process gift card purchase
    Map<String, dynamic> giftCardData = {
      'amount': finalAmount,
      'design': selectedDesign,
      'recipientName': recipientName,
      'recipientEmail': recipientEmail,
      'senderName': senderName,
      'personalMessage': personalMessage,
      'isScheduled': isScheduled,
      'deliveryDate': deliveryDate?.toIso8601String(),
    };
    
    ss("Gift card purchase completed! Recipient will receive it ${isScheduled ? 'on scheduled date' : 'immediately'}.");
    
    // Navigate to confirmation or back
    back();
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Gift Card Help"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Select or enter the gift card amount"),
            SizedBox(height: spXs),
            Text("• Choose a design that fits the occasion"),
            SizedBox(height: spXs),
            Text("• Enter recipient's information"),
            SizedBox(height: spXs),
            Text("• Add a personal message (optional)"),
            SizedBox(height: spXs),
            Text("• Choose to send now or schedule for later"),
            SizedBox(height: spXs),
            Text("• Complete purchase and recipient will receive the gift card via email"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
