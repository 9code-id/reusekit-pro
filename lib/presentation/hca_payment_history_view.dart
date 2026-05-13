import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPaymentHistoryView extends StatefulWidget {
  const HcaPaymentHistoryView({super.key});

  @override
  State<HcaPaymentHistoryView> createState() => _HcaPaymentHistoryViewState();
}

class _HcaPaymentHistoryViewState extends State<HcaPaymentHistoryView> {
  String selectedFilter = "all";
  String selectedYear = "2025";
  
  List<Map<String, dynamic>> payments = [
    {
      "id": "PMT001",
      "date": "2025-06-15",
      "provider": "City Medical Center",
      "service": "Annual Physical Exam",
      "amount": 320.00,
      "insuranceCovered": 256.00,
      "patientPaid": 64.00,
      "paymentMethod": "Credit Card",
      "status": "completed",
      "type": "medical",
      "claimId": "CLM001234",
      "receiptUrl": "receipt_001.pdf",
    },
    {
      "id": "PMT002",
      "date": "2025-06-10",
      "provider": "Dr. Johnson Cardiology",
      "service": "Cardiology Consultation",
      "amount": 450.00,
      "insuranceCovered": 360.00,
      "patientPaid": 90.00,
      "paymentMethod": "Auto Pay",
      "status": "completed",
      "type": "specialist",
      "claimId": "CLM001235",
      "receiptUrl": "receipt_002.pdf",
    },
    {
      "id": "PMT003",
      "date": "2025-06-05",
      "provider": "Lab Corp",
      "service": "Blood Work Panel",
      "amount": 180.00,
      "insuranceCovered": 144.00,
      "patientPaid": 36.00,
      "paymentMethod": "Bank Transfer",
      "status": "completed",
      "type": "lab",
      "claimId": "CLM001236",
      "receiptUrl": "receipt_003.pdf",
    },
    {
      "id": "PMT004",
      "date": "2025-05-28",
      "provider": "Pharmacy Plus",
      "service": "Prescription Medication",
      "amount": 85.00,
      "insuranceCovered": 68.00,
      "patientPaid": 17.00,
      "paymentMethod": "Credit Card",
      "status": "completed",
      "type": "pharmacy",
      "claimId": "CLM001237",
      "receiptUrl": "receipt_004.pdf",
    },
    {
      "id": "PMT005",
      "date": "2025-05-20",
      "provider": "Dental Care Plus",
      "service": "Dental Cleaning",
      "amount": 120.00,
      "insuranceCovered": 96.00,
      "patientPaid": 24.00,
      "paymentMethod": "Credit Card",
      "status": "completed",
      "type": "dental",
      "claimId": "CLM001238",
      "receiptUrl": "receipt_005.pdf",
    },
    {
      "id": "PMT006",
      "date": "2025-05-15",
      "provider": "Vision Center",
      "service": "Eye Exam",
      "amount": 150.00,
      "insuranceCovered": 120.00,
      "patientPaid": 30.00,
      "paymentMethod": "Auto Pay",
      "status": "pending",
      "type": "vision",
      "claimId": "CLM001239",
      "receiptUrl": "",
    },
  ];

  List<Map<String, dynamic>> get filteredPayments {
    return payments.where((payment) {
      bool matchesFilter = selectedFilter == "all" || 
                          payment["type"] == selectedFilter ||
                          payment["status"] == selectedFilter;
      
      bool matchesYear = payment["date"].startsWith(selectedYear);
      
      return matchesFilter && matchesYear;
    }).toList();
  }

  double get totalPaid {
    return filteredPayments.fold(0.0, (sum, payment) => sum + (payment["patientPaid"] as double));
  }

  double get totalAmount {
    return filteredPayments.fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
  }

  double get totalInsuranceCovered {
    return filteredPayments.fold(0.0, (sum, payment) => sum + (payment["insuranceCovered"] as double));
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "medical":
        return primaryColor;
      case "specialist":
        return infoColor;
      case "lab":
        return warningColor;
      case "pharmacy":
        return successColor;
      case "dental":
        return secondaryColor;
      case "vision":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "medical":
        return Icons.local_hospital;
      case "specialist":
        return Icons.person;
      case "lab":
        return Icons.science;
      case "pharmacy":
        return Icons.medication;
      case "dental":
        return Icons.medical_services;
      case "vision":
        return Icons.visibility;
      default:
        return Icons.payment;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _exportPayments();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters Section
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
                        child: QDropdownField(
                          label: "Filter by Type",
                          items: [
                            {"label": "All Types", "value": "all"},
                            {"label": "Medical", "value": "medical"},
                            {"label": "Specialist", "value": "specialist"},
                            {"label": "Laboratory", "value": "lab"},
                            {"label": "Pharmacy", "value": "pharmacy"},
                            {"label": "Dental", "value": "dental"},
                            {"label": "Vision", "value": "vision"},
                          ],
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
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Paid",
                    "\$${totalPaid.toStringAsFixed(2)}",
                    "By you",
                    Icons.account_balance_wallet,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Insurance Covered",
                    "\$${totalInsuranceCovered.toStringAsFixed(2)}",
                    "By insurance",
                    Icons.security,
                    successColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Services",
                    "\$${totalAmount.toStringAsFixed(2)}",
                    "Service value",
                    Icons.receipt,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Transactions",
                    "${filteredPayments.length}",
                    "This period",
                    Icons.list,
                    infoColor,
                  ),
                ),
              ],
            ),

            // Monthly Breakdown Chart (Mock)
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
                    "Monthly Spending",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        double height = (50 + (index * 15)).toDouble();
                        List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
                        List<double> amounts = [245.50, 189.25, 325.75, 156.00, 298.50, 187.00];
                        
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "\$${amounts[index].toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: 20,
                              height: height,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(100 + (index * 20)),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              months[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // Payment History List
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
                    "Payment History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...filteredPayments.map((payment) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: _getTypeColor(payment["type"]),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getTypeColor(payment["type"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  _getTypeIcon(payment["type"]),
                                  color: _getTypeColor(payment["type"]),
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${payment["service"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${payment["provider"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(payment["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${payment["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(payment["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Payment Details
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              spacing: spXs,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Service Amount:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(payment["amount"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Insurance Covered:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(payment["insuranceCovered"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: disabledColor, thickness: 1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "You Paid:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(payment["patientPaid"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Footer
                          Row(
                            children: [
                              Icon(
                                Icons.payment,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${payment["paymentMethod"]} • ${payment["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              if (payment["receiptUrl"].isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    _viewReceipt(payment["receiptUrl"]);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.receipt,
                                        size: 14,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Receipt",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _exportPayments() {
    // Export payments to PDF or CSV
    ss("Payment history exported successfully");
  }

  void _viewReceipt(String receiptUrl) {
    // View receipt document
    si("Opening receipt: $receiptUrl");
  }
}
