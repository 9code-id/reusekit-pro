import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsBirthdayPromotionsView extends StatefulWidget {
  const RfsBirthdayPromotionsView({super.key});

  @override
  State<RfsBirthdayPromotionsView> createState() => _RfsBirthdayPromotionsViewState();
}

class _RfsBirthdayPromotionsViewState extends State<RfsBirthdayPromotionsView> {
  String searchQuery = "";
  String selectedFilter = "all";
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  String birthdayDate = "";
  String promoCode = "";
  String discountType = "percentage";
  String discountValue = "";
  String promoDescription = "";
  bool isActive = true;
  bool autoSendEmail = true;
  bool autoSendSMS = false;

  List<Map<String, dynamic>> promotions = [
    {
      "id": "P001",
      "customer_name": "John Smith",
      "email": "john@example.com",
      "phone": "+1-555-0123",
      "birthday": "1990-03-15",
      "promo_code": "BDAY15",
      "discount_type": "percentage",
      "discount_value": 15,
      "description": "Happy Birthday! Get 15% off your entire order",
      "status": "active",
      "auto_send_email": true,
      "auto_send_sms": false,
      "created_date": "2024-01-15",
      "last_used": "2024-02-20",
      "usage_count": 3,
      "max_usage": 5
    },
    {
      "id": "P002",
      "customer_name": "Sarah Johnson",
      "email": "sarah@example.com",
      "phone": "+1-555-0456",
      "birthday": "1985-07-22",
      "promo_code": "BDAY20",
      "discount_type": "fixed",
      "discount_value": 25,
      "description": "Birthday Special - \$25 off orders over \$100",
      "status": "active",
      "auto_send_email": true,
      "auto_send_sms": true,
      "created_date": "2024-02-10",
      "last_used": null,
      "usage_count": 0,
      "max_usage": 3
    },
    {
      "id": "P003",
      "customer_name": "Mike Davis",
      "email": "mike@example.com", 
      "phone": "+1-555-0789",
      "birthday": "1992-11-08",
      "promo_code": "BDAY10",
      "discount_type": "percentage",
      "discount_value": 10,
      "description": "Birthday Month Special - 10% off all desserts",
      "status": "expired",
      "auto_send_email": false,
      "auto_send_sms": false,
      "created_date": "2023-11-01",
      "last_used": "2023-11-15",
      "usage_count": 2,
      "max_usage": 2
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Promotions", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Expired", "value": "expired"},
    {"label": "Auto Email", "value": "auto_email"},
    {"label": "Auto SMS", "value": "auto_sms"}
  ];

  List<Map<String, dynamic>> discountTypeOptions = [
    {"label": "Percentage", "value": "percentage"},
    {"label": "Fixed Amount", "value": "fixed"}
  ];

  void _filterPromotions() {
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredPromotions {
    return promotions.where((promo) {
      bool matchesSearch = promo["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          promo["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          promo["promo_code"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "all" ||
                          promo["status"] == selectedFilter ||
                          (selectedFilter == "auto_email" && promo["auto_send_email"] == true) ||
                          (selectedFilter == "auto_sms" && promo["auto_send_sms"] == true);
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _createPromotion() {
    // Handle promotion creation
    customerName = "";
    customerEmail = "";
    customerPhone = "";
    birthdayDate = "";
    promoCode = "";
    discountValue = "";
    promoDescription = "";
    isActive = true;
    autoSendEmail = true;
    autoSendSMS = false;
    setState(() {});
    ss("Birthday promotion created successfully");
  }

  void _sendBirthdayReminder(Map<String, dynamic> promo) {
    ss("Birthday reminder sent to ${promo["customer_name"]}");
  }

  void _togglePromotionStatus(Map<String, dynamic> promo) {
    promo["status"] = promo["status"] == "active" ? "expired" : "active";
    setState(() {});
    ss("Promotion status updated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Birthday Promotions"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreatePromotionDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QTextField(
                    label: "Search customers or promo codes",
                    value: searchQuery,
                    hint: "Enter customer name, email, or promo code",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterPromotions();
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Filter by Status",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      _filterPromotions();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.card_giftcard, color: primaryColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${promotions.where((p) => p["status"] == "active").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Active Promotions",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.auto_awesome, color: successColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${promotions.where((p) => p["auto_send_email"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Auto Email",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.sms, color: infoColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${promotions.where((p) => p["auto_send_sms"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Auto SMS",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Promotions List
            Text(
              "Birthday Promotions (${filteredPromotions.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...filteredPromotions.map((promo) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: promo["status"] == "active" ? successColor : dangerColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${promo["customer_name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${promo["email"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${promo["phone"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: promo["status"] == "active" ? successColor : dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${promo["status"]}".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.card_giftcard, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Code: ${promo["promo_code"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${promo["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          promo["discount_type"] == "percentage" 
                            ? "${promo["discount_value"]}% OFF"
                            : "\$${promo["discount_value"]} OFF",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(Icons.cake, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Birthday: ${DateTime.parse(promo["birthday"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (promo["auto_send_email"] == true)
                        Container(
                          margin: EdgeInsets.only(right: spXs),
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "AUTO EMAIL",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (promo["auto_send_sms"] == true)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "AUTO SMS",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Used: ${promo["usage_count"]}/${promo["max_usage"]} times",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _sendBirthdayReminder(promo),
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(Icons.send, color: infoColor, size: 16),
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () => _togglePromotionStatus(promo),
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                promo["status"] == "active" ? Icons.pause : Icons.play_arrow,
                                color: warningColor,
                                size: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () => _showEditPromotionDialog(promo),
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(Icons.edit, color: primaryColor, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _showCreatePromotionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Birthday Promotion"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Customer Name",
                value: customerName,
                onChanged: (value) {
                  customerName = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Customer Email",
                value: customerEmail,
                onChanged: (value) {
                  customerEmail = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Customer Phone",
                value: customerPhone,
                onChanged: (value) {
                  customerPhone = value;
                  setState(() {});
                },
              ),
              QDatePicker(
                label: "Birthday",
                value: birthdayDate.isNotEmpty ? DateTime.parse(birthdayDate) : DateTime.now(),
                onChanged: (value) {
                  birthdayDate = value.toIso8601String().split('T')[0];
                  setState(() {});
                },
              ),
              QTextField(
                label: "Promo Code",
                value: promoCode,
                onChanged: (value) {
                  promoCode = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Discount Type",
                items: discountTypeOptions,
                value: discountType,
                onChanged: (value, label) {
                  discountType = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: discountType == "percentage" ? "Discount Percentage" : "Discount Amount (\$)",
                value: discountValue,
                onChanged: (value) {
                  discountValue = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Promotion Description",
                value: promoDescription,
                onChanged: (value) {
                  promoDescription = value;
                  setState(() {});
                },
              ),
              QSwitch(
                label: "Auto Send Email",
                items: [
                  {
                    "label": "Auto Send Email",
                    "value": true,
                    "checked": autoSendEmail,
                  }
                ],
                value: autoSendEmail ? [{"label": "Auto Send Email", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  autoSendEmail = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                label: "Auto Send SMS",
                items: [
                  {
                    "label": "Auto Send SMS",
                    "value": true,
                    "checked": autoSendSMS,
                  }
                ],
                value: autoSendSMS ? [{"label": "Auto Send SMS", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  autoSendSMS = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create Promotion",
            onPressed: () {
              Navigator.pop(context);
              _createPromotion();
            },
          ),
        ],
      ),
    );
  }

  void _showEditPromotionDialog(Map<String, dynamic> promo) {
    customerName = promo["customer_name"];
    customerEmail = promo["email"];
    customerPhone = promo["phone"];
    birthdayDate = promo["birthday"];
    promoCode = promo["promo_code"];
    discountType = promo["discount_type"];
    discountValue = promo["discount_value"].toString();
    promoDescription = promo["description"];
    autoSendEmail = promo["auto_send_email"];
    autoSendSMS = promo["auto_send_sms"];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Birthday Promotion"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Customer Name",
                value: customerName,
                onChanged: (value) {
                  customerName = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Customer Email",
                value: customerEmail,
                onChanged: (value) {
                  customerEmail = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Customer Phone",
                value: customerPhone,
                onChanged: (value) {
                  customerPhone = value;
                  setState(() {});
                },
              ),
              QDatePicker(
                label: "Birthday",
                value: DateTime.parse(birthdayDate),
                onChanged: (value) {
                  birthdayDate = value.toIso8601String().split('T')[0];
                  setState(() {});
                },
              ),
              QTextField(
                label: "Promo Code",
                value: promoCode,
                onChanged: (value) {
                  promoCode = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Discount Type",
                items: discountTypeOptions,
                value: discountType,
                onChanged: (value, label) {
                  discountType = value;
                  setState(() {});
                },
              ),
              QNumberField(
                label: discountType == "percentage" ? "Discount Percentage" : "Discount Amount (\$)",
                value: discountValue,
                onChanged: (value) {
                  discountValue = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Promotion Description",
                value: promoDescription,
                onChanged: (value) {
                  promoDescription = value;
                  setState(() {});
                },
              ),
              QSwitch(
                label: "Auto Send Email",
                items: [
                  {
                    "label": "Auto Send Email",
                    "value": true,
                    "checked": autoSendEmail,
                  }
                ],
                value: autoSendEmail ? [{"label": "Auto Send Email", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  autoSendEmail = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                label: "Auto Send SMS",
                items: [
                  {
                    "label": "Auto Send SMS",
                    "value": true,
                    "checked": autoSendSMS,
                  }
                ],
                value: autoSendSMS ? [{"label": "Auto Send SMS", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  autoSendSMS = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update Promotion",
            onPressed: () {
              Navigator.pop(context);
              ss("Promotion updated successfully");
            },
          ),
        ],
      ),
    );
  }
}
