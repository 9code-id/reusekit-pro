import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaCreditCardProcessingView extends StatefulWidget {
  const HhaCreditCardProcessingView({super.key});

  @override
  State<HhaCreditCardProcessingView> createState() => _HhaCreditCardProcessingViewState();
}

class _HhaCreditCardProcessingViewState extends State<HhaCreditCardProcessingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  
  // Form fields for new transaction
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  String amount = "";
  String description = "";
  String transactionType = "charge";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Approved", "value": "approved"},
    {"label": "Declined", "value": "declined"},
    {"label": "Pending", "value": "pending"},
    {"label": "Refunded", "value": "refunded"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Charge", "value": "charge"},
    {"label": "Refund", "value": "refund"},
    {"label": "Authorization", "value": "auth"},
  ];

  List<Map<String, dynamic>> transactionTypeOptions = [
    {"label": "Charge", "value": "charge"},
    {"label": "Refund", "value": "refund"},
    {"label": "Authorization", "value": "auth"},
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TXN001",
      "type": "charge",
      "amount": 450.0,
      "card_last4": "4242",
      "card_type": "Visa",
      "cardholder": "John Anderson",
      "status": "approved",
      "date": "2024-01-18 14:30",
      "reference": "ch_1234567890",
      "description": "Room Payment - FOL001",
      "folio_id": "FOL001",
      "guest_name": "John Anderson",
      "room": "101",
      "processor_response": "Approved",
      "auth_code": "123456",
    },
    {
      "id": "TXN002",
      "type": "charge", 
      "amount": 795.0,
      "card_last4": "5555",
      "card_type": "Mastercard",
      "cardholder": "Sarah Williams",
      "status": "approved",
      "date": "2024-01-17 16:45",
      "reference": "ch_2345678901",
      "description": "Full Stay Payment - FOL002",
      "folio_id": "FOL002",
      "guest_name": "Sarah Williams",
      "room": "205",
      "processor_response": "Approved",
      "auth_code": "789012",
    },
    {
      "id": "TXN003",
      "type": "charge",
      "amount": 125.0,
      "card_last4": "1234",
      "card_type": "American Express",
      "cardholder": "Michael Chen",
      "status": "declined",
      "date": "2024-01-18 10:15",
      "reference": "ch_3456789012",
      "description": "Additional Charges - FOL003",
      "folio_id": "FOL003",
      "guest_name": "Michael Chen",
      "room": "301",
      "processor_response": "Insufficient Funds",
      "auth_code": "",
    },
    {
      "id": "TXN004",
      "type": "refund",
      "amount": 50.0,
      "card_last4": "4242",
      "card_type": "Visa",
      "cardholder": "John Anderson",
      "status": "approved",
      "date": "2024-01-18 15:20",
      "reference": "re_4567890123",
      "description": "Minibar Refund - FOL001",
      "folio_id": "FOL001",
      "guest_name": "John Anderson",
      "room": "101",
      "processor_response": "Approved",
      "auth_code": "345678",
    },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return transactions.where((transaction) {
      bool matchesSearch = searchQuery.isEmpty ||
          (transaction["cardholder"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["reference"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (transaction["folio_id"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || transaction["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || transaction["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Credit Card Processing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Transactions", icon: Icon(Icons.credit_card)),
        Tab(text: "Process Payment", icon: Icon(Icons.payment)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildTransactionsTab(),
        _buildProcessPaymentTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildTransactionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search",
                  hint: "Search by cardholder, reference, or folio ID",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary Stats
          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Total Processed",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${((transactions.where((t) => t["status"] == "approved").fold(0.0, (sum, t) => sum + (t["amount"] as double))) as double).currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Declined",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${transactions.where((t) => t["status"] == "declined").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Transactions List
          Text(
            "Recent Transactions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...filteredTransactions.map((transaction) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: (transaction["status"] as String) == "approved" 
                      ? successColor 
                      : (transaction["status"] as String) == "declined"
                          ? dangerColor
                          : (transaction["status"] as String) == "pending"
                              ? warningColor
                              : infoColor,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${transaction["cardholder"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${transaction["card_type"]} •••• ${transaction["card_last4"]}",
                            style: TextStyle(
                              fontSize: 14,
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
                          "${(transaction["type"] as String) == "refund" ? "-" : ""}\$${((transaction["amount"] as double)).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: (transaction["type"] as String) == "refund" 
                                ? warningColor 
                                : primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: (transaction["status"] as String) == "approved" 
                                ? successColor.withAlpha(20)
                                : (transaction["status"] as String) == "declined"
                                    ? dangerColor.withAlpha(20)
                                    : (transaction["status"] as String) == "pending"
                                        ? warningColor.withAlpha(20)
                                        : infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${transaction["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (transaction["status"] as String) == "approved" 
                                  ? successColor
                                  : (transaction["status"] as String) == "declined"
                                      ? dangerColor
                                      : (transaction["status"] as String) == "pending"
                                          ? warningColor
                                          : infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Reference: ${transaction["reference"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "${transaction["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Description: ${transaction["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if ((transaction["auth_code"] as String).isNotEmpty)
                        Text(
                          "Auth Code: ${transaction["auth_code"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      Text(
                        "Response: ${transaction["processor_response"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    if ((transaction["status"] as String) == "approved" && 
                        (transaction["type"] as String) == "charge")
                      Expanded(
                        child: QButton(
                          label: "Refund",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.receipt,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildProcessPaymentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Transaction Type Selection
          QDropdownField(
            label: "Transaction Type",
            items: transactionTypeOptions,
            value: transactionType,
            onChanged: (value, label) {
              transactionType = value;
              setState(() {});
            },
          ),

          // Card Information
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Card Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QTextField(
                  label: "Cardholder Name",
                  value: cardholderName,
                  hint: "Enter cardholder full name",
                  onChanged: (value) {
                    cardholderName = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Card Number",
                  value: cardNumber,
                  hint: "1234 5678 9012 3456",
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

          // Transaction Details
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Transaction Details",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QNumberField(
                  label: "Amount",
                  value: amount,
                  hint: "0.00",
                  onChanged: (value) {
                    amount = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Description",
                  value: description,
                  hint: "Enter transaction description",
                  onChanged: (value) {
                    description = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Security Information
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  color: infoColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Secure Processing",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "All transactions are processed securely using PCI DSS compliant systems. Card information is encrypted during transmission.",
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

          // Transaction Summary
          if (amount.isNotEmpty && double.tryParse(amount) != null)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Transaction Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Transaction Type",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(
                        "${transactionType.toUpperCase()}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Amount",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(
                        "\$${((double.tryParse(amount) ?? 0.0)).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if (description.isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Description",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            description,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

          // Process Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Process ${transactionType.toUpperCase()}",
              onPressed: cardNumber.isNotEmpty && 
                         cardholderName.isNotEmpty && 
                         amount.isNotEmpty ? () {
                _processPayment();
              } : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Daily Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Daily Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Transactions",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${transactions.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Volume",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((transactions.fold(0.0, (sum, t) => sum + (t["amount"] as double))) as double).currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Approved",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${transactions.where((t) => t["status"] == "approved").length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Declined",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${transactions.where((t) => t["status"] == "declined").length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Card Type Breakdown
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Card Type Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ...["Visa", "Mastercard", "American Express"].map((cardType) {
                  final cardTransactions = transactions.where((t) => t["card_type"] == cardType).toList();
                  final totalAmount = cardTransactions.fold(0.0, (sum, t) => sum + (t["amount"] as double));
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cardType,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${cardTransactions.length} transactions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((totalAmount as double)).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Recent Activity
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ...transactions.take(5).map((transaction) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (transaction["status"] as String) == "approved" 
                            ? Icons.check_circle
                            : (transaction["status"] as String) == "declined"
                                ? Icons.cancel
                                : Icons.pending,
                        color: (transaction["status"] as String) == "approved" 
                            ? successColor
                            : (transaction["status"] as String) == "declined"
                                ? dangerColor
                                : warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${transaction["cardholder"]} - ${transaction["card_type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${transaction["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${((transaction["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _processPayment() async {
    showLoading();
    
    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    // Show success message
    ss("Payment processed successfully");
    
    // Clear form
    cardNumber = "";
    expiryDate = "";
    cvv = "";
    cardholderName = "";
    amount = "";
    description = "";
    setState(() {});
    
    // Switch to transactions tab
    currentTab = 0;
    setState(() {});
  }
}
