import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPaymentHistoryView extends StatefulWidget {
  const BfaPaymentHistoryView({super.key});

  @override
  State<BfaPaymentHistoryView> createState() => _BfaPaymentHistoryViewState();
}

class _BfaPaymentHistoryViewState extends State<BfaPaymentHistoryView> {
  String selectedFilter = "All";
  String selectedMonth = "All Time";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Bills", "value": "Bills"},
    {"label": "Credit Cards", "value": "Credit Cards"},
    {"label": "Loans", "value": "Loans"},
    {"label": "Insurance", "value": "Insurance"},
    {"label": "Transfers", "value": "Transfers"},
  ];

  List<Map<String, dynamic>> monthOptions = [
    {"label": "All Time", "value": "All Time"},
    {"label": "This Month", "value": "2025-01"},
    {"label": "Last Month", "value": "2024-12"},
    {"label": "November 2024", "value": "2024-11"},
    {"label": "October 2024", "value": "2024-10"},
  ];

  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": 1,
      "type": "Bills",
      "category": "Utilities",
      "merchant": "Electric Company",
      "description": "Monthly electricity bill",
      "amount": 125.50,
      "date": "2025-01-15T10:30:00",
      "status": "Success",
      "transactionId": "PAY789456123",
      "paymentMethod": "Bank Account ****1234",
      "icon": Icons.electrical_services,
      "color": Colors.amber
    },
    {
      "id": 2,
      "type": "Credit Cards",
      "category": "Credit Card Payment",
      "merchant": "Chase Bank",
      "description": "Chase Sapphire Preferred payment",
      "amount": 500.00,
      "date": "2025-01-12T15:45:00",
      "status": "Success",
      "transactionId": "PAY456789012",
      "paymentMethod": "Bank Account ****5678",
      "icon": Icons.credit_card,
      "color": Colors.blue
    },
    {
      "id": 3,
      "type": "Loans",
      "category": "Auto Loan",
      "merchant": "Toyota Financial",
      "description": "Monthly auto loan payment",
      "amount": 485.25,
      "date": "2025-01-10T09:20:00",
      "status": "Success",
      "transactionId": "PAY123456789",
      "paymentMethod": "Auto Pay - Bank ****9012",
      "icon": Icons.directions_car,
      "color": Colors.green
    },
    {
      "id": 4,
      "type": "Insurance",
      "category": "Health Insurance",
      "merchant": "Blue Cross Health",
      "description": "Monthly health insurance premium",
      "amount": 450.00,
      "date": "2025-01-08T14:10:00",
      "status": "Success",
      "transactionId": "PAY987654321",
      "paymentMethod": "Bank Account ****3456",
      "icon": Icons.health_and_safety,
      "color": Colors.red
    },
    {
      "id": 5,
      "type": "Bills",
      "category": "Internet",
      "merchant": "FastNet Internet",
      "description": "Monthly internet service",
      "amount": 89.99,
      "date": "2025-01-05T11:30:00",
      "status": "Success",
      "transactionId": "PAY555666777",
      "paymentMethod": "Credit Card ****7890",
      "icon": Icons.wifi,
      "color": Colors.cyan
    },
    {
      "id": 6,
      "type": "Transfers",
      "category": "Money Transfer",
      "merchant": "John Smith",
      "description": "Rent payment",
      "amount": 1200.00,
      "date": "2025-01-01T08:45:00",
      "status": "Success",
      "transactionId": "PAY111222333",
      "paymentMethod": "Bank Account ****1234",
      "icon": Icons.send,
      "color": Colors.purple
    },
    {
      "id": 7,
      "type": "Bills",
      "category": "Phone",
      "merchant": "Mobile Carrier",
      "description": "Monthly phone bill",
      "amount": 65.00,
      "date": "2024-12-28T16:20:00",
      "status": "Failed",
      "transactionId": "PAY444555666",
      "paymentMethod": "Bank Account ****1234",
      "icon": Icons.phone,
      "color": Colors.orange,
      "failureReason": "Insufficient funds"
    },
    {
      "id": 8,
      "type": "Credit Cards",
      "category": "Credit Card Payment",
      "merchant": "American Express",
      "description": "Amex Gold Card payment",
      "amount": 200.00,
      "date": "2024-12-25T13:15:00",
      "status": "Success",
      "transactionId": "PAY777888999",
      "paymentMethod": "Bank Account ****5678",
      "icon": Icons.credit_card,
      "color": Colors.amber
    },
    {
      "id": 9,
      "type": "Loans",
      "category": "Home Loan",
      "merchant": "Chase Bank",
      "description": "Monthly mortgage payment",
      "amount": 1850.75,
      "date": "2024-12-20T10:00:00",
      "status": "Success",
      "transactionId": "PAY000111222",
      "paymentMethod": "Auto Pay - Bank ****9012",
      "icon": Icons.home,
      "color": Colors.indigo
    },
    {
      "id": 10,
      "type": "Insurance",
      "category": "Auto Insurance",
      "merchant": "State Farm",
      "description": "Auto insurance premium",
      "amount": 180.50,
      "date": "2024-12-15T12:30:00",
      "status": "Success",
      "transactionId": "PAY333444555",
      "paymentMethod": "Credit Card ****7890",
      "icon": Icons.directions_car,
      "color": Colors.teal
    }
  ];

  List<Map<String, dynamic>> get filteredPayments {
    List<Map<String, dynamic>> filtered = paymentHistory;
    
    // Filter by type
    if (selectedFilter != "All") {
      filtered = filtered.where((payment) => payment["type"] == selectedFilter).toList();
    }
    
    // Filter by month
    if (selectedMonth != "All Time") {
      filtered = filtered.where((payment) {
        final paymentDate = DateTime.parse(payment["date"]);
        final filterDate = selectedMonth == "This Month" 
            ? DateTime.now()
            : DateTime.parse("$selectedMonth-01");
        return paymentDate.year == filterDate.year && 
               paymentDate.month == filterDate.month;
      }).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Success":
        return successColor;
      case "Failed":
        return dangerColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  double get totalSuccessfulPayments => filteredPayments
      .where((payment) => payment["status"] == "Success")
      .map((payment) => payment["amount"] as double)
      .fold(0.0, (sum, amount) => sum + amount);

  int get successfulCount => filteredPayments
      .where((payment) => payment["status"] == "Success")
      .length;

  int get failedCount => filteredPayments
      .where((payment) => payment["status"] == "Failed")
      .length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export payment history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Summary",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${filteredPayments.length} transactions found",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Total Paid",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "\$${totalSuccessfulPayments.currency}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Successful",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "$successfulCount",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (failedCount > 0)
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Failed",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(230),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "$failedCount",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
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

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Payment Type",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: monthOptions,
                    value: selectedMonth,
                    onChanged: (value, label) {
                      selectedMonth = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Payment History List
            if (filteredPayments.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.history,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Payment History",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No payments found for the selected filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredPayments.map((payment) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: payment["status"] == "Failed"
                        ? Border.all(color: dangerColor.withAlpha(128))
                        : null,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (payment["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              payment["icon"] as IconData,
                              color: payment["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${payment["merchant"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(payment["status"]).withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${payment["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor(payment["status"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${payment["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${payment["type"]} • ${payment["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
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
                                  "\$${(payment["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: payment["status"] == "Success" 
                                        ? primaryColor 
                                        : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Date & Time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(payment["date"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(payment["date"]).kkmm}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Transaction ID",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${payment["transactionId"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "Payment Method: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${payment["paymentMethod"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (payment["failureReason"] != null) ...[
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: dangerColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Failure Reason: ${payment["failureReason"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo(PaymentDetailView(payment));
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.receipt,
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(PaymentReceiptView(payment));
                            },
                          ),
                          if (payment["status"] == "Failed") ...[
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.refresh,
                              size: bs.sm,
                              onPressed: () {
                                // Retry payment
                              },
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),

            // Export Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Export Payment History",
                icon: Icons.download,
                onPressed: () {
                  // Export to PDF/CSV
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
