import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCustomerPaymentsView extends StatefulWidget {
  const AbaCustomerPaymentsView({super.key});

  @override
  State<AbaCustomerPaymentsView> createState() => _AbaCustomerPaymentsViewState();
}

class _AbaCustomerPaymentsViewState extends State<AbaCustomerPaymentsView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPaymentMethod = "all";
  DateTime? fromDate;
  DateTime? toDate;
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Completed", "value": "completed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Refunded", "value": "refunded"},
  ];

  List<Map<String, dynamic>> paymentMethodOptions = [
    {"label": "All Methods", "value": "all"},
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Cash", "value": "cash"},
    {"label": "Check", "value": "check"},
  ];

  List<Map<String, dynamic>> payments = [
    {
      "id": "PAY-001",
      "customer_name": "John Smith",
      "customer_id": "CUST-001",
      "amount": 1250.00,
      "payment_method": "Credit Card",
      "status": "completed",
      "transaction_id": "TXN-789456123",
      "date": "2024-06-19",
      "invoice_number": "INV-2024-001",
      "reference": "Monthly Service Fee",
    },
    {
      "id": "PAY-002",
      "customer_name": "Sarah Johnson",
      "customer_id": "CUST-002",
      "amount": 890.50,
      "payment_method": "Bank Transfer",
      "status": "pending",
      "transaction_id": "TXN-789456124",
      "date": "2024-06-19",
      "invoice_number": "INV-2024-002",
      "reference": "Product Purchase",
    },
    {
      "id": "PAY-003",
      "customer_name": "Michael Brown",
      "customer_id": "CUST-003",
      "amount": 2100.75,
      "payment_method": "Check",
      "status": "failed",
      "transaction_id": "TXN-789456125",
      "date": "2024-06-18",
      "invoice_number": "INV-2024-003",
      "reference": "Consultation Fee",
    },
    {
      "id": "PAY-004",
      "customer_name": "Emily Davis",
      "customer_id": "CUST-004",
      "amount": 450.00,
      "payment_method": "Cash",
      "status": "completed",
      "transaction_id": "TXN-789456126",
      "date": "2024-06-18",
      "invoice_number": "INV-2024-004",
      "reference": "Service Payment",
    },
    {
      "id": "PAY-005",
      "customer_name": "David Wilson",
      "customer_id": "CUST-005",
      "amount": 780.25,
      "payment_method": "Credit Card",
      "status": "refunded",
      "transaction_id": "TXN-789456127",
      "date": "2024-06-17",
      "invoice_number": "INV-2024-005",
      "reference": "Order Cancellation",
    },
  ];

  List<Map<String, dynamic>> get filteredPayments {
    return payments.where((payment) {
      final matchesSearch = payment["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payment["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          payment["invoice_number"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "all" || payment["status"] == selectedStatus;
      final matchesMethod = selectedPaymentMethod == "all" || payment["payment_method"].toString().toLowerCase().contains(selectedPaymentMethod.replaceAll("_", " "));
      
      return matchesSearch && matchesStatus && matchesMethod;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'pending':
        return warningColor;
      case 'failed':
        return dangerColor;
      case 'refunded':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _exportPayments() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Payment data exported successfully");
  }

  void _processRefund(Map<String, dynamic> payment) async {
    bool isConfirmed = await confirm("Are you sure you want to process a refund for this payment?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Refund processed successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Payments"),
        actions: [
          IconButton(
            onPressed: _exportPayments,
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(
                            "Total Payments",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((payments.fold(0.0, (sum, payment) => sum + (payment["amount"] as double)))).currency}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${payments.where((p) => p["status"] == "completed").length}",
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
                            label: "Search payments...",
                            value: searchQuery,
                            hint: "Customer name, payment ID, or invoice",
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
                            label: "Payment Method",
                            items: paymentMethodOptions,
                            value: selectedPaymentMethod,
                            onChanged: (value, label) {
                              selectedPaymentMethod = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Payments List
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
                            "Payment Records",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${filteredPayments.length} payments",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1),
                    ...List.generate(filteredPayments.length, (index) {
                      final payment = filteredPayments[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index < filteredPayments.length - 1 
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${payment["customer_name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${payment["id"]} • ${payment["customer_id"]}",
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
                                    color: _getStatusColor("${payment["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${payment["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor("${payment["status"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${(payment["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${payment["payment_method"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${payment["invoice_number"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${payment["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${payment["reference"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            if (payment["status"] == "completed" || payment["status"] == "pending")
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      si("Payment details viewed");
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  if (payment["status"] == "completed")
                                    QButton(
                                      label: "Refund",
                                      size: bs.sm,
                                      onPressed: () => _processRefund(payment),
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
          ),
        ),
    );
  }
}
