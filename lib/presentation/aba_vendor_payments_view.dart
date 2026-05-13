import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaVendorPaymentsView extends StatefulWidget {
  const AbaVendorPaymentsView({super.key});

  @override
  State<AbaVendorPaymentsView> createState() => _AbaVendorPaymentsViewState();
}

class _AbaVendorPaymentsViewState extends State<AbaVendorPaymentsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPeriod = "This Month";
  bool loading = false;

  List<Map<String, dynamic>> payments = [
    {
      "id": "PAY-001",
      "vendorName": "Tech Solutions Ltd",
      "vendorId": "VEN-001",
      "amount": 15000.00,
      "currency": "USD",
      "paymentDate": "2024-01-20",
      "dueDate": "2024-01-18",
      "status": "Paid",
      "method": "Bank Transfer",
      "reference": "INV-2024-001",
      "description": "Software License Payment",
      "paymentTerms": "Net 30",
      "approvedBy": "John Manager",
      "category": "Technology"
    },
    {
      "id": "PAY-002",
      "vendorName": "Global Supplies Inc",
      "vendorId": "VEN-002",
      "amount": 8500.00,
      "currency": "USD",
      "paymentDate": "2024-01-19",
      "dueDate": "2024-01-15",
      "status": "Overdue",
      "method": "Check",
      "reference": "INV-2024-002",
      "description": "Office Supplies Purchase",
      "paymentTerms": "Net 15",
      "approvedBy": "Sarah Finance",
      "category": "Supplies"
    },
    {
      "id": "PAY-003",
      "vendorName": "Manufacturing Corp",
      "vendorId": "VEN-003",
      "amount": 25000.00,
      "currency": "USD",
      "paymentDate": null,
      "dueDate": "2024-01-25",
      "status": "Pending",
      "method": "Wire Transfer",
      "reference": "INV-2024-003",
      "description": "Equipment Purchase",
      "paymentTerms": "Net 30",
      "approvedBy": "Mike Director",
      "category": "Manufacturing"
    },
    {
      "id": "PAY-004",
      "vendorName": "Logistics Partners",
      "vendorId": "VEN-004",
      "amount": 12750.00,
      "currency": "USD",
      "paymentDate": "2024-01-17",
      "dueDate": "2024-01-16",
      "status": "Paid",
      "method": "ACH",
      "reference": "INV-2024-004",
      "description": "Shipping Services",
      "paymentTerms": "Net 7",
      "approvedBy": "Emily Operations",
      "category": "Logistics"
    },
    {
      "id": "PAY-005",
      "vendorName": "Service Providers LLC",
      "vendorId": "VEN-005",
      "amount": 6200.00,
      "currency": "USD",
      "paymentDate": null,
      "dueDate": "2024-01-30",
      "status": "Scheduled",
      "method": "Bank Transfer",
      "reference": "INV-2024-005",
      "description": "Consulting Services",
      "paymentTerms": "Net 30",
      "approvedBy": "David Success",
      "category": "Services"
    }
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All", "value": "All"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Scheduled", "value": "Scheduled"}
  ];

  List<Map<String, dynamic>> periodFilters = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"}
  ];

  List<Map<String, dynamic>> get filteredPayments {
    return payments.where((payment) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${payment["vendorName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${payment["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${payment["reference"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || payment["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "Scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  double get totalAmount {
    return filteredPayments.fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
  }

  double get paidAmount {
    return filteredPayments
        .where((p) => p["status"] == "Paid")
        .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
  }

  double get pendingAmount {
    return filteredPayments
        .where((p) => p["status"] == "Pending" || p["status"] == "Scheduled")
        .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
  }

  double get overdueAmount {
    return filteredPayments
        .where((p) => p["status"] == "Overdue")
        .fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Payments"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo AddPaymentView
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export payments
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
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
                          label: "Search payments...",
                          value: searchQuery,
                          hint: "Payment ID, vendor, or reference",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.filter_list,
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
                          items: statusFilters,
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
                          label: "Period",
                          items: periodFilters,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
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
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${totalAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Amount",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${paidAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Paid",
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
                      children: [
                        Text(
                          "\$${pendingAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${overdueAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Overdue",
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

            // Payments List
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else if (filteredPayments.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.payment,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No payments found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredPayments.map((payment) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
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
                                  "${payment["id"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${payment["vendorName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${payment["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${payment["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${payment["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Payment Amount
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "\$${(payment["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Payment Details
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.receipt,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Ref: ${payment["reference"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.payment,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${payment["method"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Due: ${DateTime.parse("${payment["dueDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if (payment["paymentDate"] != null)
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Paid: ${DateTime.parse("${payment["paymentDate"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      // Description
                      Text(
                        "${payment["description"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo PaymentDetailView
                              },
                            ),
                          ),
                          SizedBox(width: spXs),
                          if (payment["status"] == "Pending")
                            Expanded(
                              child: QButton(
                                label: "Process Payment",
                                size: bs.sm,
                                onPressed: () {
                                  // Process payment
                                },
                              ),
                            ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // Show more options
                            },
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
    );
  }
}
