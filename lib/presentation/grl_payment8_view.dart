import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPayment8View extends StatefulWidget {
  @override
  State<GrlPayment8View> createState() => _GrlPayment8ViewState();
}

class _GrlPayment8ViewState extends State<GrlPayment8View> {
  List<Map<String, dynamic>> bills = [
    {
      "id": "bill_001",
      "category": "utilities",
      "provider": "Electric Company",
      "amount": 145.50,
      "dueDate": "2024-07-05",
      "status": "pending",
      "accountNumber": "****4567",
      "lastPaid": "2024-06-05",
      "isRecurring": true,
      "color": Colors.yellow,
      "icon": Icons.bolt,
    },
    {
      "id": "bill_002",
      "category": "telecom",
      "provider": "Mobile Network",
      "amount": 89.99,
      "dueDate": "2024-07-10",
      "status": "pending",
      "accountNumber": "****8901",
      "lastPaid": "2024-06-10",
      "isRecurring": true,
      "color": Colors.blue,
      "icon": Icons.phone_android,
    },
    {
      "id": "bill_003",
      "category": "internet",
      "provider": "Internet Service Provider",
      "amount": 65.00,
      "dueDate": "2024-07-15",
      "status": "overdue",
      "accountNumber": "****2345",
      "lastPaid": "2024-05-15",
      "isRecurring": true,
      "color": Colors.purple,
      "icon": Icons.wifi,
    },
    {
      "id": "bill_004",
      "category": "insurance",
      "provider": "Health Insurance",
      "amount": 320.00,
      "dueDate": "2024-07-20",
      "status": "paid",
      "accountNumber": "****6789",
      "lastPaid": "2024-06-20",
      "isRecurring": true,
      "color": Colors.green,
      "icon": Icons.local_hospital,
    },
    {
      "id": "bill_005",
      "category": "subscription",
      "provider": "Streaming Service",
      "amount": 15.99,
      "dueDate": "2024-07-25",
      "status": "pending",
      "accountNumber": "****3456",
      "lastPaid": "2024-06-25",
      "isRecurring": true,
      "color": Colors.red,
      "icon": Icons.play_circle,
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "card_001",
      "type": "Credit Card",
      "name": "Chase Sapphire",
      "number": "****4532",
      "isDefault": true,
    },
    {
      "id": "bank_001",
      "type": "Bank Account",
      "name": "Checking Account",
      "number": "****1234",
      "isDefault": false,
    },
    {
      "id": "wallet_001",
      "type": "Digital Wallet",
      "name": "PayPal",
      "number": "user@email.com",
      "isDefault": false,
    },
  ];

  String filterCategory = "all";
  String selectedPaymentMethod = "card_001";
  bool showPayBillForm = false;
  Map<String, dynamic>? selectedBill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Pay"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              si("Add new bill coming soon!");
            },
          ),
        ],
      ),
      body: showPayBillForm ? _buildPayBillForm() : _buildBillsList(),
    );
  }

  Widget _buildBillsList() {
    return Column(
      children: [
        _buildBillsOverview(),
        _buildCategoryFilter(),
        Expanded(
          child: _buildBillsContent(),
        ),
      ],
    );
  }

  Widget _buildBillsOverview() {
    double totalPending = bills.where((bill) => bill["status"] == "pending")
        .fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    double totalOverdue = bills.where((bill) => bill["status"] == "overdue")
        .fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    int dueSoon = bills.where((bill) {
      DateTime dueDate = DateTime.parse("${bill["dueDate"]}");
      DateTime now = DateTime.now();
      return dueDate.difference(now).inDays <= 7 && bill["status"] != "paid";
    }).length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard(
                  "Pending",
                  "\$${totalPending.toStringAsFixed(2)}",
                  Icons.schedule,
                  Colors.white,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard(
                  "Overdue",
                  "\$${totalOverdue.toStringAsFixed(2)}",
                  Icons.error,
                  dangerColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard(
                  "Due Soon",
                  "${dueSoon} bills",
                  Icons.warning,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color iconColor) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    List<Map<String, dynamic>> categories = [
      {"id": "all", "title": "All", "icon": Icons.dashboard},
      {"id": "utilities", "title": "Utilities", "icon": Icons.bolt},
      {"id": "telecom", "title": "Telecom", "icon": Icons.phone},
      {"id": "internet", "title": "Internet", "icon": Icons.wifi},
      {"id": "insurance", "title": "Insurance", "icon": Icons.security},
      {"id": "subscription", "title": "Subscriptions", "icon": Icons.subscriptions},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      child: QHorizontalScroll(
        children: categories.map((category) {
          bool isSelected = filterCategory == category["id"];
          return GestureDetector(
            onTap: () {
              filterCategory = "${category["id"]}";
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category["icon"] as IconData,
                    color: isSelected ? Colors.white : disabledBoldColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${category["title"]}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBillsContent() {
    List<Map<String, dynamic>> filteredBills = bills.where((bill) {
      return filterCategory == "all" || bill["category"] == filterCategory;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: filteredBills.map((bill) {
          return _buildBillCard(bill);
        }).toList(),
      ),
    );
  }

  Widget _buildBillCard(Map<String, dynamic> bill) {
    DateTime dueDate = DateTime.parse("${bill["dueDate"]}");
    DateTime now = DateTime.now();
    int daysUntilDue = dueDate.difference(now).inDays;
    
    Color statusColor;
    String statusText;
    IconData statusIcon;
    
    switch (bill["status"]) {
      case "paid":
        statusColor = successColor;
        statusText = "PAID";
        statusIcon = Icons.check_circle;
        break;
      case "overdue":
        statusColor = dangerColor;
        statusText = "OVERDUE";
        statusIcon = Icons.error;
        break;
      case "pending":
        if (daysUntilDue <= 3) {
          statusColor = warningColor;
          statusText = "DUE SOON";
          statusIcon = Icons.warning;
        } else {
          statusColor = infoColor;
          statusText = "PENDING";
          statusIcon = Icons.schedule;
        }
        break;
      default:
        statusColor = disabledBoldColor;
        statusText = "UNKNOWN";
        statusIcon = Icons.help;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: bill["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (bill["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  bill["icon"] as IconData,
                  color: bill["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${bill["provider"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Account: ${bill["accountNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      color: statusColor,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
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
                      "Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(bill["amount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
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
                      "Due Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${dueDate.dMMMy}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (daysUntilDue > 0 && bill["status"] != "paid")
                      Text(
                        "${daysUntilDue} days left",
                        style: TextStyle(
                          fontSize: 10,
                          color: daysUntilDue <= 3 ? warningColor : disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (bill["status"] != "paid")
                QButton(
                  label: "Pay Now",
                  size: bs.sm,
                  onPressed: () {
                    selectedBill = bill;
                    showPayBillForm = true;
                    setState(() {});
                  },
                ),
            ],
          ),
          if (bill["isRecurring"] == true)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.refresh,
                    color: infoColor,
                    size: 14,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Recurring monthly bill",
                    style: TextStyle(
                      fontSize: 12,
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

  Widget _buildPayBillForm() {
    if (selectedBill == null) return Container();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Pay Bill",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  showPayBillForm = false;
                  selectedBill = null;
                  setState(() {});
                },
              ),
            ],
          ),
          _buildBillSummary(),
          _buildPaymentMethodSelector(),
          _buildPaymentConfirmation(),
          _buildSecurityNotice(),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  onPressed: () {
                    showPayBillForm = false;
                    selectedBill = null;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Pay \$${(selectedBill!["amount"] as double).toStringAsFixed(2)}",
                  onPressed: () {
                    _processBillPayment();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillSummary() {
    return Container(
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
            "Bill Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (selectedBill!["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  selectedBill!["icon"] as IconData,
                  color: selectedBill!["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${selectedBill!["provider"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Account: ${selectedBill!["accountNumber"]}",
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
          Divider(),
          _buildSummaryRow("Amount Due", "\$${(selectedBill!["amount"] as double).toStringAsFixed(2)}"),
          _buildSummaryRow("Due Date", "${DateTime.parse(selectedBill!["dueDate"]).dMMMy}"),
          _buildSummaryRow("Service Fee", "Free"),
          Divider(),
          _buildSummaryRow("Total", "\$${(selectedBill!["amount"] as double).toStringAsFixed(2)}", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Container(
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
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...paymentMethods.map((method) {
            return GestureDetector(
              onTap: () {
                selectedPaymentMethod = "${method["id"]}";
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: selectedPaymentMethod == method["id"]
                        ? primaryColor
                        : disabledOutlineBorderColor,
                    width: selectedPaymentMethod == method["id"] ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getPaymentMethodIcon("${method["type"]}"),
                      color: selectedPaymentMethod == method["id"]
                          ? primaryColor
                          : disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${method["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (method["isDefault"] == true) ...[
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "DEFAULT",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            "${method["type"]} ${method["number"]}",
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentConfirmation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Payment Processing Time",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Your payment will be processed within 1-2 business days. You will receive a confirmation email once the payment is complete.",
            style: TextStyle(
              fontSize: 12,
              color: infoColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security,
            color: successColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "Your payment information is encrypted and secured with bank-level security.",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? primaryColor : Colors.black,
          ),
        ),
      ],
    );
  }

  IconData _getPaymentMethodIcon(String type) {
    switch (type) {
      case "Credit Card":
        return Icons.credit_card;
      case "Bank Account":
        return Icons.account_balance;
      case "Digital Wallet":
        return Icons.account_balance_wallet;
      default:
        return Icons.payment;
    }
  }

  void _processBillPayment() {
    showLoading();
    
    // Simulate payment processing
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      
      // Update bill status
      int billIndex = bills.indexWhere((bill) => bill["id"] == selectedBill!["id"]);
      if (billIndex != -1) {
        bills[billIndex]["status"] = "paid";
        bills[billIndex]["lastPaid"] = DateTime.now().toString();
      }
      
      showPayBillForm = false;
      selectedBill = null;
      ss("Bill payment successful!");
      setState(() {});
    });
  }
}
