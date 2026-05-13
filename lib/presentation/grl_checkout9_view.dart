import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCheckout9View extends StatefulWidget {
  @override
  State<GrlCheckout9View> createState() => _GrlCheckout9ViewState();
}

class _GrlCheckout9ViewState extends State<GrlCheckout9View> {
  final formKey = GlobalKey<FormState>();
  
  // Split Payment State
  String selectedSplitMethod = "equal";
  List<Map<String, dynamic>> splitParticipants = [
    {
      "name": "You",
      "email": "you@example.com",
      "amount": 0.0,
      "percentage": 50.0,
      "isHost": true,
      "paymentMethod": "Credit Card",
      "status": "pending"
    },
    {
      "name": "Sarah Johnson",
      "email": "sarah@example.com", 
      "amount": 0.0,
      "percentage": 50.0,
      "isHost": false,
      "paymentMethod": "PayPal",
      "status": "pending"
    }
  ];
  
  // Cart Items
  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Premium Wireless Headphones",
      "price": 299.99,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
      "category": "Electronics"
    },
    {
      "name": "Coffee Subscription Box",
      "price": 89.99,
      "quantity": 2,
      "image": "https://picsum.photos/80/80?random=2&keyword=coffee",
      "category": "Food & Beverage"
    },
    {
      "name": "Yoga Mat Premium",
      "price": 45.00,
      "quantity": 1,
      "image": "https://picsum.photos/80/80?random=3&keyword=yoga",
      "category": "Fitness"
    }
  ];
  
  // Payment Info
  String paymentMethod = "Credit Card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  
  // Split Options
  List<Map<String, dynamic>> splitMethods = [
    {"label": "Split Equally", "value": "equal"},
    {"label": "Split by Amount", "value": "amount"},
    {"label": "Split by Percentage", "value": "percentage"},
    {"label": "Split by Items", "value": "items"}
  ];
  
  // Form Fields
  String inviteEmail = "";
  String inviteMessage = "Let's split this purchase together!";
  bool sendReminders = true;
  bool requireApproval = false;
  
  double get totalAmount {
    return cartItems.fold(0.0, (sum, item) => 
        sum + ((item["price"] as double) * (item["quantity"] as int)));
  }
  
  void _calculateSplitAmounts() {
    if (selectedSplitMethod == "equal") {
      double amountPerPerson = totalAmount / splitParticipants.length;
      for (var participant in splitParticipants) {
        participant["amount"] = amountPerPerson;
        participant["percentage"] = 100.0 / splitParticipants.length;
      }
    } else if (selectedSplitMethod == "percentage") {
      for (var participant in splitParticipants) {
        participant["amount"] = totalAmount * ((participant["percentage"] as double) / 100);
      }
    }
    setState(() {});
  }
  
  void _addParticipant() {
    if (inviteEmail.isNotEmpty) {
      splitParticipants.add({
        "name": inviteEmail.split('@')[0],
        "email": inviteEmail,
        "amount": 0.0,
        "percentage": 0.0,
        "isHost": false,
        "paymentMethod": "Credit Card",
        "status": "invited"
      });
      inviteEmail = "";
      _calculateSplitAmounts();
      ss("Participant added successfully");
    }
  }
  
  void _removeParticipant(int index) {
    if (!splitParticipants[index]["isHost"]) {
      splitParticipants.removeAt(index);
      _calculateSplitAmounts();
      ss("Participant removed");
    }
  }
  
  void _sendInvitations() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    for (var participant in splitParticipants) {
      if (!participant["isHost"]) {
        participant["status"] = "invited";
      }
    }
    setState(() {});
    ss("Invitations sent successfully");
  }
  
  void _processSplitPayment() async {
    if (!formKey.currentState!.validate()) return;
    
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    
    ss("Split payment request created successfully");
    // Navigate to confirmation
  }
  
  @override
  void initState() {
    super.initState();
    _calculateSplitAmounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Split Payment"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              si("Split the cost with friends and family");
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Order Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shopping_cart, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...cartItems.map((item) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
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
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${item["category"]}",
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
                                "Qty: ${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )).toList(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${totalAmount.toStringAsFixed(2)}",
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
              ),
              
              // Split Method Selection
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Split Method",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QCategoryPicker(
                      items: splitMethods,
                      value: selectedSplitMethod,
                      onChanged: (index, label, value, item) {
                        selectedSplitMethod = value;
                        _calculateSplitAmounts();
                      },
                    ),
                  ],
                ),
              ),
              
              // Participants
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Participants (${splitParticipants.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          icon: Icons.person_add,
                          size: bs.sm,
                          onPressed: () {
                            if (inviteEmail.isNotEmpty) {
                              _addParticipant();
                            } else {
                              se("Please enter an email to invite");
                            }
                          },
                        ),
                      ],
                    ),
                    
                    // Add Participant
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Invite by Email",
                            value: inviteEmail,
                            hint: "Enter email address",
                            onChanged: (value) {
                              inviteEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          size: bs.sm,
                          onPressed: _addParticipant,
                        ),
                      ],
                    ),
                    
                    // Participants List
                    ...splitParticipants.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> participant = entry.value;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: participant["isHost"] 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                          ),
                          borderRadius: BorderRadius.circular(radiusSm),
                          color: participant["isHost"] 
                              ? primaryColor.withAlpha(20) 
                              : null,
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: primaryColor,
                                  child: Text(
                                    "${participant["name"]}".substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${participant["name"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (participant["isHost"])
                                            Container(
                                              margin: EdgeInsets.only(left: spXs),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "Host",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Text(
                                        "${participant["email"]}",
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
                                      "\$${(participant["amount"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${(participant["percentage"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                if (!participant["isHost"])
                                  GestureDetector(
                                    onTap: () => _removeParticipant(index),
                                    child: Container(
                                      margin: EdgeInsets.only(left: spSm),
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            
                            // Custom Amount/Percentage Input
                            if (selectedSplitMethod == "amount" || selectedSplitMethod == "percentage")
                              Row(
                                children: [
                                  Expanded(
                                    child: QNumberField(
                                      label: selectedSplitMethod == "amount" ? "Amount (\$)" : "Percentage (%)",
                                      value: selectedSplitMethod == "amount" 
                                          ? (participant["amount"] as double).toString()
                                          : (participant["percentage"] as double).toString(),
                                      onChanged: (value) {
                                        double numValue = double.tryParse(value) ?? 0.0;
                                        if (selectedSplitMethod == "amount") {
                                          participant["amount"] = numValue;
                                          participant["percentage"] = (numValue / totalAmount) * 100;
                                        } else {
                                          participant["percentage"] = numValue;
                                          participant["amount"] = totalAmount * (numValue / 100);
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            
                            // Status
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: participant["status"] == "pending" 
                                        ? warningColor
                                        : participant["status"] == "invited"
                                        ? infoColor
                                        : successColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${participant["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: participant["status"] == "pending" 
                                        ? warningColor
                                        : participant["status"] == "invited"
                                        ? infoColor
                                        : successColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${participant["paymentMethod"]}",
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
                    }).toList(),
                  ],
                ),
              ),
              
              // Invitation Settings
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Invitation Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Invitation Message",
                      value: inviteMessage,
                      hint: "Add a personal message to your invitation",
                      onChanged: (value) {
                        inviteMessage = value;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Send payment reminders",
                          "value": "reminders",
                          "checked": sendReminders,
                        }
                      ],
                      value: sendReminders ? [{"label": "Send payment reminders", "value": "reminders", "checked": true}] : [],
                      onChanged: (values, ids) {
                        sendReminders = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Require approval before payment",
                          "value": "approval",
                          "checked": requireApproval,
                        }
                      ],
                      value: requireApproval ? [{"label": "Require approval before payment", "value": "approval", "checked": true}] : [],
                      onChanged: (values, ids) {
                        requireApproval = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              // Your Payment Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Your Payment Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Cardholder Name",
                      value: cardholderName,
                      validator: Validator.required,
                      onChanged: (value) {
                        cardholderName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Card Number",
                      value: cardNumber,
                      hint: "1234 5678 9012 3456",
                      validator: Validator.required,
                      onChanged: (value) {
                        cardNumber = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Expiry Date",
                            value: expiryDate,
                            hint: "MM/YY",
                            validator: Validator.required,
                            onChanged: (value) {
                              expiryDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "CVV",
                            value: cvv,
                            hint: "123",
                            validator: Validator.required,
                            onChanged: (value) {
                              cvv = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Share:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "\$${splitParticipants.isNotEmpty ? (splitParticipants.firstWhere((p) => p["isHost"])["amount"] as double).toStringAsFixed(2) : "0.00"}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Invitations",
                    size: bs.md,
                    onPressed: _sendInvitations,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Create Split",
                    size: bs.md,
                    onPressed: _processSplitPayment,
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
