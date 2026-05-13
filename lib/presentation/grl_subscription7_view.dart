import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSubscription7View extends StatefulWidget {
  @override
  State<GrlSubscription7View> createState() => _GrlSubscription7ViewState();
}

class _GrlSubscription7ViewState extends State<GrlSubscription7View> {
  List<Map<String, dynamic>> billingHistory = [
    {
      "date": "2025-06-22",
      "invoice": "INV-2025-06-001",
      "plan": "Pro Monthly",
      "amount": 29.99,
      "status": "paid",
      "paymentMethod": "Credit Card ending in 4567",
      "items": [
        {"description": "Pro Plan Subscription", "amount": 29.99},
        {"description": "Tax", "amount": 2.40},
      ],
      "total": 32.39,
    },
    {
      "date": "2025-05-22",
      "invoice": "INV-2025-05-001",
      "plan": "Pro Monthly",
      "amount": 29.99,
      "status": "paid",
      "paymentMethod": "Credit Card ending in 4567",
      "items": [
        {"description": "Pro Plan Subscription", "amount": 29.99},
        {"description": "Tax", "amount": 2.40},
      ],
      "total": 32.39,
    },
    {
      "date": "2025-04-22",
      "invoice": "INV-2025-04-001",
      "plan": "Pro Monthly",
      "amount": 29.99,
      "status": "paid",
      "paymentMethod": "Credit Card ending in 4567",
      "items": [
        {"description": "Pro Plan Subscription", "amount": 29.99},
        {"description": "Tax", "amount": 2.40},
      ],
      "total": 32.39,
    },
    {
      "date": "2025-03-22",
      "invoice": "INV-2025-03-001",
      "plan": "Basic Monthly",
      "amount": 19.99,
      "status": "paid",
      "paymentMethod": "Credit Card ending in 4567",
      "items": [
        {"description": "Basic Plan Subscription", "amount": 19.99},
        {"description": "Tax", "amount": 1.60},
      ],
      "total": 21.59,
    },
    {
      "date": "2025-02-22",
      "invoice": "INV-2025-02-001",
      "plan": "Basic Monthly",
      "amount": 19.99,
      "status": "failed",
      "paymentMethod": "Credit Card ending in 4567",
      "items": [
        {"description": "Basic Plan Subscription", "amount": 19.99},
        {"description": "Tax", "amount": 1.60},
      ],
      "total": 21.59,
    },
  ];

  String selectedYear = "2025";
  String selectedStatus = "All";
  Map<String, dynamic>? selectedInvoice;

  @override
  Widget build(BuildContext context) {
    final filteredHistory = _getFilteredHistory();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Billing history exported successfully");
            },
          ),
        ],
      ),
      body: selectedInvoice != null
          ? _buildInvoiceDetail()
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildSummaryCards(),
                  _buildFilters(),
                  _buildBillingList(filteredHistory),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryCards() {
    final totalPaid = billingHistory
        .where((bill) => bill["status"] == "paid")
        .fold(0.0, (sum, bill) => sum + (bill["total"] as double));
    
    final thisYearTotal = billingHistory
        .where((bill) => bill["date"].startsWith(selectedYear) && bill["status"] == "paid")
        .fold(0.0, (sum, bill) => sum + (bill["total"] as double));
        
    final failedPayments = billingHistory
        .where((bill) => bill["status"] == "failed")
        .length;

    return Column(
      spacing: spSm,
      children: [
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spLg),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Total Paid",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${totalPaid.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "All time",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [successColor, successColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "$selectedYear Total",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "\$${thisYearTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "This year",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (failedPayments > 0)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: dangerColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: dangerColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "$failedPayments failed payment${failedPayments > 1 ? 's' : ''} found. Please update your payment method.",
                    style: TextStyle(
                      color: dangerColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                QButton(
                  label: "Update",
                  size: bs.sm,
                  onPressed: () {
                    si("Redirecting to payment settings");
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Year",
                  items: [
                    {"label": "2025", "value": "2025"},
                    {"label": "2024", "value": "2024"},
                    {"label": "2023", "value": "2023"},
                  ],
                  value: selectedYear,
                  onChanged: (value, label) {
                    selectedYear = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Paid", "value": "paid"},
                    {"label": "Failed", "value": "failed"},
                    {"label": "Pending", "value": "pending"},
                  ],
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
    );
  }

  Widget _buildBillingList(List<Map<String, dynamic>> filteredHistory) {
    if (filteredHistory.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spXl),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long,
              size: 48,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No billing history found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Billing History (${filteredHistory.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: filteredHistory.map((bill) {
              final billDate = DateTime.parse(bill["date"]);
              final isPaid = bill["status"] == "paid";
              final isFailed = bill["status"] == "failed";
              
              return GestureDetector(
                onTap: () {
                  selectedInvoice = bill;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isFailed ? dangerColor.withAlpha(5) : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isFailed ? dangerColor.withAlpha(50) : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isPaid 
                                  ? successColor.withAlpha(20)
                                  : isFailed 
                                      ? dangerColor.withAlpha(20)
                                      : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isPaid 
                                  ? Icons.check_circle
                                  : isFailed 
                                      ? Icons.error
                                      : Icons.schedule,
                              color: isPaid 
                                  ? successColor
                                  : isFailed 
                                      ? dangerColor
                                      : warningColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${bill["invoice"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${billDate.dMMMy} • ${bill["plan"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${bill["paymentMethod"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(bill["total"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: isPaid 
                                      ? successColor
                                      : isFailed 
                                          ? dangerColor
                                          : warningColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  isPaid 
                                      ? "PAID"
                                      : isFailed 
                                          ? "FAILED"
                                          : "PENDING",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                        ],
                      ),
                      if (isFailed)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: dangerColor,
                                size: 14,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Payment failed - please update your payment method",
                                  style: TextStyle(
                                    color: dangerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              QButton(
                                label: "Retry",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Payment retry initiated");
                                },
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

  Widget _buildInvoiceDetail() {
    final invoice = selectedInvoice!;
    final billDate = DateTime.parse(invoice["date"]);
    final isPaid = invoice["status"] == "paid";
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectedInvoice = null;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Text(
                        "Invoice Details",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Download",
                      size: bs.sm,
                      onPressed: () {
                        ss("Invoice downloaded");
                      },
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Column(
                    spacing: spMd,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isPaid ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              isPaid ? Icons.check_circle : Icons.error,
                              color: isPaid ? successColor : dangerColor,
                              size: 32,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${invoice["invoice"]}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Issued on ${billDate.dMMMy}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: spXs),
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: isPaid ? successColor : dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    isPaid ? "PAID" : "FAILED",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(invoice["total"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Billing Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...([
                      {"label": "Plan", "value": invoice["plan"]},
                      {"label": "Payment Method", "value": invoice["paymentMethod"]},
                      {"label": "Invoice Date", "value": billDate.dMMMy},
                      {"label": "Status", "value": isPaid ? "Paid" : "Failed"},
                    ].map((info) {
                      return Row(
                        children: [
                          Text(
                            "${info["label"]}:",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${info["value"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    }).toList()),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Item Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...(invoice["items"] as List<Map<String, dynamic>>).map((item) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${item["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "\$${(item["amount"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    Divider(color: disabledOutlineBorderColor),
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(invoice["total"] as double).toStringAsFixed(2)}",
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
              ],
            ),
          ),
          if (!isPaid)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: dangerColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Payment Failed",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "This payment failed. Please update your payment method or retry the payment to avoid service interruption.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          child: QButton(
                            label: "Update Payment",
                            size: bs.sm,
                            onPressed: () {
                              si("Redirecting to payment settings");
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: QButton(
                            label: "Retry Payment",
                            size: bs.sm,
                            onPressed: () {
                              ss("Payment retry initiated");
                            },
                          ),
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
  }

  List<Map<String, dynamic>> _getFilteredHistory() {
    return billingHistory.where((bill) {
      bool yearMatch = bill["date"].startsWith(selectedYear);
      bool statusMatch = selectedStatus == "All" || bill["status"] == selectedStatus;
      return yearMatch && statusMatch;
    }).toList();
  }
}
