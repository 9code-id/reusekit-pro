import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaPaymentMethodsView extends StatefulWidget {
  const AbaPaymentMethodsView({super.key});

  @override
  State<AbaPaymentMethodsView> createState() => _AbaPaymentMethodsViewState();
}

class _AbaPaymentMethodsViewState extends State<AbaPaymentMethodsView> {
  String searchQuery = "";
  String selectedType = "all";
  String selectedStatus = "all";
  bool loading = false;
  int currentTab = 0;

  // Add New Payment Method
  String methodType = "credit_card";
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  String bankName = "";
  String accountNumber = "";
  String routingNumber = "";
  String accountType = "checking";

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Debit Card", "value": "debit_card"},
    {"label": "Bank Account", "value": "bank_account"},
    {"label": "Digital Wallet", "value": "digital_wallet"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Expired", "value": "expired"},
    {"label": "Suspended", "value": "suspended"},
  ];

  List<Map<String, dynamic>> methodTypeOptions = [
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Debit Card", "value": "debit_card"},
    {"label": "Bank Account", "value": "bank_account"},
    {"label": "Digital Wallet", "value": "digital_wallet"},
  ];

  List<Map<String, dynamic>> accountTypeOptions = [
    {"label": "Checking", "value": "checking"},
    {"label": "Savings", "value": "savings"},
    {"label": "Business Checking", "value": "business_checking"},
    {"label": "Business Savings", "value": "business_savings"},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "PM-001",
      "customer_name": "John Smith",
      "customer_id": "CUST-001",
      "type": "credit_card",
      "card_brand": "Visa",
      "last_four": "4532",
      "expiry_month": "12",
      "expiry_year": "2025",
      "cardholder_name": "John Smith",
      "status": "active",
      "is_default": true,
      "added_date": "2024-01-15",
      "last_used": "2024-06-19",
      "usage_count": 12,
    },
    {
      "id": "PM-002",
      "customer_name": "Sarah Johnson",
      "customer_id": "CUST-002",
      "type": "bank_account",
      "bank_name": "Chase Bank",
      "account_type": "checking",
      "last_four": "7890",
      "routing_number": "021000021",
      "account_holder": "Sarah Johnson",
      "status": "active",
      "is_default": false,
      "added_date": "2024-02-20",
      "last_used": "2024-06-18",
      "usage_count": 8,
    },
    {
      "id": "PM-003",
      "customer_name": "Michael Brown",
      "customer_id": "CUST-003",
      "type": "credit_card",
      "card_brand": "Mastercard",
      "last_four": "1234",
      "expiry_month": "06",
      "expiry_year": "2024",
      "cardholder_name": "Michael Brown",
      "status": "expired",
      "is_default": false,
      "added_date": "2023-06-10",
      "last_used": "2024-05-30",
      "usage_count": 25,
    },
    {
      "id": "PM-004",
      "customer_name": "Emily Davis",
      "customer_id": "CUST-004",
      "type": "digital_wallet",
      "wallet_type": "PayPal",
      "email": "emily.davis@email.com",
      "status": "active",
      "is_default": true,
      "added_date": "2024-03-05",
      "last_used": "2024-06-17",
      "usage_count": 6,
    },
    {
      "id": "PM-005",
      "customer_name": "David Wilson",
      "customer_id": "CUST-005",
      "type": "bank_account",
      "bank_name": "Bank of America",
      "account_type": "savings",
      "last_four": "5678",
      "routing_number": "011401533",
      "account_holder": "David Wilson",
      "status": "suspended",
      "is_default": false,
      "added_date": "2024-01-30",
      "last_used": "2024-04-15",
      "usage_count": 3,
    },
  ];

  List<Map<String, dynamic>> get filteredMethods {
    return paymentMethods.where((method) {
      final matchesSearch = method["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          method["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          method["customer_id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesType = selectedType == "all" || method["type"] == selectedType;
      final matchesStatus = selectedStatus == "all" || method["status"] == selectedStatus;
      
      return matchesSearch && matchesType && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'inactive':
        return disabledBoldColor;
      case 'expired':
        return warningColor;
      case 'suspended':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'credit_card':
      case 'debit_card':
        return Icons.credit_card;
      case 'bank_account':
        return Icons.account_balance;
      case 'digital_wallet':
        return Icons.account_balance_wallet;
      default:
        return Icons.payment;
    }
  }

  String _getCardBrandIcon(String brand) {
    switch (brand.toLowerCase()) {
      case 'visa':
        return 'V';
      case 'mastercard':
        return 'M';
      case 'american express':
        return 'A';
      case 'discover':
        return 'D';
      default:
        return '?';
    }
  }

  void _activateMethod(Map<String, dynamic> method) async {
    bool isConfirmed = await confirm("Activate payment method for ${method["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Payment method activated");
  }

  void _suspendMethod(Map<String, dynamic> method) async {
    bool isConfirmed = await confirm("Suspend payment method for ${method["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    sw("Payment method suspended");
  }

  void _deleteMethod(Map<String, dynamic> method) async {
    bool isConfirmed = await confirm("Permanently delete payment method for ${method["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Payment method deleted");
  }

  void _addPaymentMethod() async {
    if (methodType == "credit_card" || methodType == "debit_card") {
      if (cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty || cardholderName.isEmpty) {
        se("Please fill in all card details");
        return;
      }
    } else if (methodType == "bank_account") {
      if (bankName.isEmpty || accountNumber.isEmpty || routingNumber.isEmpty) {
        se("Please fill in all bank account details");
        return;
      }
    }

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    // Clear form
    cardNumber = "";
    expiryDate = "";
    cvv = "";
    cardholderName = "";
    bankName = "";
    accountNumber = "";
    routingNumber = "";
    setState(() {});
    
    ss("Payment method added successfully");
  }

  Widget _buildMethodsTab() {
    final activeCount = paymentMethods.where((m) => m["status"] == "active").length;
    final expiredCount = paymentMethods.where((m) => m["status"] == "expired").length;
    final suspendedCount = paymentMethods.where((m) => m["status"] == "suspended").length;

    return Column(
      spacing: spMd,
      children: [
        // Summary Cards
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$activeCount",
                      style: TextStyle(
                        fontSize: fsH5,
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Expired",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "$expiredCount",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Search and Filters
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search payment methods...",
                      value: searchQuery,
                      hint: "Customer name, method ID, or customer ID",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
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
                  SizedBox(width: spSm),
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
                ],
              ),
            ],
          ),
        ),

        // Payment Methods List
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Methods",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${filteredMethods.length} methods",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              ...List.generate(filteredMethods.length, (index) {
                final method = filteredMethods[index];
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: index < filteredMethods.length - 1 
                          ? disabledOutlineBorderColor 
                          : Colors.transparent,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getTypeIcon("${method["type"]}"),
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${method["customer_name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (method["is_default"] == true)
                                      ...[
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "DEFAULT",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: infoColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                  ],
                                ),
                                Text(
                                  "${method["id"]} • ${method["customer_id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${method["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${method["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor("${method["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Payment Method Details
                      if (method["type"] == "credit_card" || method["type"] == "debit_card")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _getCardBrandIcon("${method["card_brand"]}"),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${method["card_brand"]} •••• ${method["last_four"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${method["expiry_month"]}/${method["expiry_year"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      
                      if (method["type"] == "bank_account")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${method["bank_name"]} • ${method["account_type"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Account •••• ${method["last_four"]} • Routing ${method["routing_number"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      
                      if (method["type"] == "digital_wallet")
                        Text(
                          "${method["wallet_type"]} • ${method["email"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Added: ${method["added_date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Used ${method["usage_count"]} times",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "Last used: ${method["last_used"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              si("Payment method details viewed");
                            },
                          ),
                          if (method["status"] == "inactive" || method["status"] == "suspended")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Activate",
                                size: bs.sm,
                                onPressed: () => _activateMethod(method),
                              ),
                            ],
                          if (method["status"] == "active")
                            ...[
                              SizedBox(width: spXs),
                              QButton(
                                label: "Suspend",
                                size: bs.sm,
                                onPressed: () => _suspendMethod(method),
                              ),
                            ],
                          SizedBox(width: spXs),
                          QButton(
                            label: "Delete",
                            size: bs.sm,
                            onPressed: () => _deleteMethod(method),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddTab() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Payment Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QDropdownField(
                label: "Payment Method Type",
                items: methodTypeOptions,
                value: methodType,
                onChanged: (value, label) {
                  methodType = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              if (methodType == "credit_card" || methodType == "debit_card")
                Column(
                  spacing: spSm,
                  children: [
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
                    QTextField(
                      label: "Cardholder Name",
                      value: cardholderName,
                      hint: "John Doe",
                      onChanged: (value) {
                        cardholderName = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              
              if (methodType == "bank_account")
                Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Bank Name",
                      value: bankName,
                      hint: "Chase Bank",
                      onChanged: (value) {
                        bankName = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Account Type",
                      items: accountTypeOptions,
                      value: accountType,
                      onChanged: (value, label) {
                        accountType = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Account Number",
                      value: accountNumber,
                      hint: "1234567890",
                      onChanged: (value) {
                        accountNumber = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Routing Number",
                      value: routingNumber,
                      hint: "021000021",
                      onChanged: (value) {
                        routingNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              
              if (methodType == "digital_wallet")
                Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Wallet Email",
                      value: "",
                      hint: "user@email.com",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Wallet ID",
                      value: "",
                      hint: "wallet_id_123",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              
              SizedBox(height: spMd),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  QButton(
                    label: "Reset Form",
                    size: bs.sm,
                    onPressed: () {
                      cardNumber = "";
                      expiryDate = "";
                      cvv = "";
                      cardholderName = "";
                      bankName = "";
                      accountNumber = "";
                      routingNumber = "";
                      setState(() {});
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Add Payment Method",
                    size: bs.md,
                    onPressed: _addPaymentMethod,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payment Methods",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Methods", icon: Icon(Icons.payment)),
        Tab(text: "Add New", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildMethodsTab(),
          ),
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildAddTab(),
          ),
      ],
    );
  }
}
