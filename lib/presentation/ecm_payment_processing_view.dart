import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmPaymentProcessingView extends StatefulWidget {
  const EcmPaymentProcessingView({super.key});

  @override
  State<EcmPaymentProcessingView> createState() => _EcmPaymentProcessingViewState();
}

class _EcmPaymentProcessingViewState extends State<EcmPaymentProcessingView> {
  String filterStatus = "all";
  String filterPaymentMethod = "all";
  String filterPeriod = "7";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> payments = [
    {
      "id": "PAY-2024-1001",
      "orderId": "ORD-2024-5501",
      "customer": "John Smith",
      "email": "john.smith@email.com",
      "amount": 299.99,
      "currency": "USD",
      "method": "credit_card",
      "status": "completed",
      "gatewayResponse": "approved",
      "transactionId": "txn_1A2B3C4D5E",
      "processingFee": 8.99,
      "netAmount": 291.00,
      "processedAt": "2024-06-19 14:30:00",
      "gateway": "Stripe",
      "cardLast4": "4242",
      "cardBrand": "visa"
    },
    {
      "id": "PAY-2024-1002",
      "orderId": "ORD-2024-5502",
      "customer": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "amount": 149.50,
      "currency": "USD",
      "method": "paypal",
      "status": "processing",
      "gatewayResponse": "pending",
      "transactionId": "pp_1F2G3H4I5J",
      "processingFee": 4.34,
      "netAmount": 145.16,
      "processedAt": "2024-06-19 13:45:00",
      "gateway": "PayPal",
      "cardLast4": null,
      "cardBrand": null
    },
    {
      "id": "PAY-2024-1003",
      "orderId": "ORD-2024-5503",
      "customer": "Mike Wilson",
      "email": "mike.w@email.com",
      "amount": 799.00,
      "currency": "USD",
      "method": "bank_transfer",
      "status": "failed",
      "gatewayResponse": "insufficient_funds",
      "transactionId": "bt_1K2L3M4N5O",
      "processingFee": 0.00,
      "netAmount": 0.00,
      "processedAt": "2024-06-19 12:15:00",
      "gateway": "Bank Transfer",
      "cardLast4": null,
      "cardBrand": null
    },
    {
      "id": "PAY-2024-1004",
      "orderId": "ORD-2024-5504",
      "customer": "Emma Davis",
      "email": "emma.davis@email.com",
      "amount": 89.99,
      "currency": "USD",
      "method": "apple_pay",
      "status": "completed",
      "gatewayResponse": "approved",
      "transactionId": "ap_1P2Q3R4S5T",
      "processingFee": 2.61,
      "netAmount": 87.38,
      "processedAt": "2024-06-19 11:20:00",
      "gateway": "Apple Pay",
      "cardLast4": "8765",
      "cardBrand": "mastercard"
    },
    {
      "id": "PAY-2024-1005",
      "orderId": "ORD-2024-5505",
      "customer": "David Brown",
      "email": "david.brown@email.com",
      "amount": 459.75,
      "currency": "USD",
      "method": "google_pay",
      "status": "refunded",
      "gatewayResponse": "refund_processed",
      "transactionId": "gp_1U2V3W4X5Y",
      "processingFee": -13.79,
      "netAmount": 445.96,
      "processedAt": "2024-06-19 10:30:00",
      "gateway": "Google Pay",
      "cardLast4": "1234",
      "cardBrand": "visa"
    }
  ];

  List<Map<String, dynamic>> get filteredPayments {
    List<Map<String, dynamic>> filtered = List.from(payments);
    
    if (filterStatus != "all") {
      filtered = filtered.where((payment) => payment["status"] == filterStatus).toList();
    }
    
    if (filterPaymentMethod != "all") {
      filtered = filtered.where((payment) => payment["method"] == filterPaymentMethod).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((payment) => 
        (payment["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (payment["orderId"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (payment["customer"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (payment["email"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "processing":
        return warningColor;
      case "failed":
        return dangerColor;
      case "refunded":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "processing":
        return "Processing";
      case "failed":
        return "Failed";
      case "refunded":
        return "Refunded";
      default:
        return "Unknown";
    }
  }

  IconData _getPaymentMethodIcon(String method) {
    switch (method) {
      case "credit_card":
        return Icons.credit_card;
      case "paypal":
        return Icons.account_balance_wallet;
      case "bank_transfer":
        return Icons.account_balance;
      case "apple_pay":
        return Icons.phone_android;
      case "google_pay":
        return Icons.smartphone;
      default:
        return Icons.payment;
    }
  }

  String _getPaymentMethodText(String method) {
    switch (method) {
      case "credit_card":
        return "Credit Card";
      case "paypal":
        return "PayPal";
      case "bank_transfer":
        return "Bank Transfer";
      case "apple_pay":
        return "Apple Pay";
      case "google_pay":
        return "Google Pay";
      default:
        return "Other";
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = payments.map((p) => p["amount"] as double).reduce((a, b) => a + b);
    double totalFees = payments.map((p) => p["processingFee"] as double).reduce((a, b) => a + b);
    int completedCount = payments.where((p) => p["status"] == "completed").length;
    int failedCount = payments.where((p) => p["status"] == "failed").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Processing"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh payments data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
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
                      Row(
                        children: [
                          Icon(Icons.payments, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalAmount / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$completedCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.error, color: dangerColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Failed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$failedCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.money_off, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Processing Fees",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalFees.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search payments...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "Processing", "value": "processing"},
                      {"label": "Failed", "value": "failed"},
                      {"label": "Refunded", "value": "refunded"},
                    ],
                    value: filterStatus,
                    onChanged: (value, label) {
                      filterStatus = value;
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
                    label: "Payment Method",
                    items: [
                      {"label": "All Methods", "value": "all"},
                      {"label": "Credit Card", "value": "credit_card"},
                      {"label": "PayPal", "value": "paypal"},
                      {"label": "Bank Transfer", "value": "bank_transfer"},
                      {"label": "Apple Pay", "value": "apple_pay"},
                      {"label": "Google Pay", "value": "google_pay"},
                    ],
                    value: filterPaymentMethod,
                    onChanged: (value, label) {
                      filterPaymentMethod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: [
                      {"label": "Last 7 days", "value": "7"},
                      {"label": "Last 30 days", "value": "30"},
                      {"label": "Last 90 days", "value": "90"},
                      {"label": "This year", "value": "365"},
                    ],
                    value: filterPeriod,
                    onChanged: (value, label) {
                      filterPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Payment Processing Summary
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
                    "Processing Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Success Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${((completedCount / payments.length) * 100).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avg Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(totalAmount / payments.length).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fee Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${((totalFees / totalAmount) * 100).toStringAsFixed(2)}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Payments List
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payments (${filteredPayments.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Export",
                        size: bs.sm,
                        onPressed: () {
                          // Export payments data
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredPayments.map((payment) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getPaymentMethodIcon(payment["method"]),
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${payment["id"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${payment["customer"]} • ${payment["orderId"]}",
                                      style: TextStyle(
                                        fontSize: 13,
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
                                    "\$${((payment["amount"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(payment["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      _getStatusText(payment["status"]),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(payment["status"]),
                                      ),
                                    ),
                                  ),
                                ],
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
                                      "Method",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      _getPaymentMethodText(payment["method"]),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
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
                                      "Gateway",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${payment["gateway"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
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
                                      "Fee",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((payment["processingFee"] as double).abs().toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
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
                                      "Net Amount",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((payment["netAmount"] as double).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (payment["cardLast4"] != null) ...[
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "**** **** **** ${payment["cardLast4"]} (${(payment["cardBrand"] as String).toUpperCase()})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
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
                                    // Navigate to payment details
                                  },
                                ),
                              ),
                              if (payment["status"] == "completed") ...[
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Refund",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Process refund
                                  },
                                ),
                              ],
                              if (payment["status"] == "failed") ...[
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Retry",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
