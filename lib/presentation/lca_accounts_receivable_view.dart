import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaAccountsReceivableView extends StatefulWidget {
  const LcaAccountsReceivableView({super.key});

  @override
  State<LcaAccountsReceivableView> createState() => _LcaAccountsReceivableViewState();
}

class _LcaAccountsReceivableViewState extends State<LcaAccountsReceivableView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedClient = "all";
  String sortBy = "due_date";
  
  List<Map<String, dynamic>> receivables = [
    {
      "id": "AR001",
      "client_name": "Johnson & Associates",
      "case_number": "2024-0123",
      "invoice_number": "INV-2024-0089",
      "amount": 15750.00,
      "amount_due": 15750.00,
      "invoice_date": "2024-05-15",
      "due_date": "2024-06-15",
      "status": "overdue",
      "days_overdue": 15,
      "services": "Corporate Litigation",
      "attorney": "Sarah Mitchell",
    },
    {
      "id": "AR002",
      "client_name": "Tech Solutions Inc",
      "case_number": "2024-0124",
      "invoice_number": "INV-2024-0090",
      "amount": 8250.00,
      "amount_due": 4125.00,
      "invoice_date": "2024-05-20",
      "due_date": "2024-06-20",
      "status": "partial",
      "days_overdue": 0,
      "services": "Contract Review",
      "attorney": "Michael Chen",
    },
    {
      "id": "AR003",
      "client_name": "Green Valley Medical",
      "case_number": "2024-0125",
      "invoice_number": "INV-2024-0091",
      "amount": 22100.00,
      "amount_due": 22100.00,
      "invoice_date": "2024-06-01",
      "due_date": "2024-07-01",
      "status": "pending",
      "days_overdue": 0,
      "services": "Medical Malpractice Defense",
      "attorney": "David Rodriguez",
    },
    {
      "id": "AR004",
      "client_name": "Metro Construction",
      "case_number": "2024-0126",
      "invoice_number": "INV-2024-0092",
      "amount": 12300.00,
      "amount_due": 0.00,
      "invoice_date": "2024-05-10",
      "due_date": "2024-06-10",
      "status": "paid",
      "days_overdue": 0,
      "services": "Construction Disputes",
      "attorney": "Lisa Thompson",
    },
    {
      "id": "AR005",
      "client_name": "Retail Plus Corp",
      "case_number": "2024-0127",
      "invoice_number": "INV-2024-0093",
      "amount": 6750.00,
      "amount_due": 6750.00,
      "invoice_date": "2024-06-10",
      "due_date": "2024-07-10",
      "status": "current",
      "days_overdue": 0,
      "services": "Employment Law",
      "attorney": "Robert Kim",
    },
  ];

  List<Map<String, dynamic>> get filteredReceivables {
    return receivables.where((receivable) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${receivable["client_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${receivable["case_number"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${receivable["invoice_number"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || receivable["status"] == selectedStatus;
      bool matchesClient = selectedClient == "all" || receivable["client_name"] == selectedClient;
      
      return matchesSearch && matchesStatus && matchesClient;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "overdue":
        return dangerColor;
      case "partial":
        return warningColor;
      case "pending":
        return infoColor;
      case "current":
        return primaryColor;
      case "paid":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "overdue":
        return "Overdue";
      case "partial":
        return "Partial Payment";
      case "pending":
        return "Pending";
      case "current":
        return "Current";
      case "paid":
        return "Paid";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = filteredReceivables.fold(0.0, (sum, item) => sum + (item["amount"] as double));
    final totalDue = filteredReceivables.fold(0.0, (sum, item) => sum + (item["amount_due"] as double));
    final overdueAmount = filteredReceivables.where((item) => item["status"] == "overdue").fold(0.0, (sum, item) => sum + (item["amount_due"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Accounts Receivable"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create new receivable
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              si("Exporting receivables report...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Summary Cards
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
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Billed",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
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
                    padding: EdgeInsets.all(spMd),
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
                            Icon(
                              Icons.pending_actions,
                              color: warningColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Amount Due",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalDue.currency}",
                          style: TextStyle(
                            fontSize: fsH4,
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
            SizedBox(height: spSm),
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
                        Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Overdue",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${overdueAmount.currency}",
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
                        Row(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Invoices",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${filteredReceivables.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Filters
            Container(
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
                    "Filters & Search",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search receivables...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "all"},
                            {"label": "Current", "value": "current"},
                            {"label": "Overdue", "value": "overdue"},
                            {"label": "Partial Payment", "value": "partial"},
                            {"label": "Pending", "value": "pending"},
                            {"label": "Paid", "value": "paid"},
                          ],
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
                          label: "Sort By",
                          items: [
                            {"label": "Due Date", "value": "due_date"},
                            {"label": "Amount", "value": "amount"},
                            {"label": "Client Name", "value": "client_name"},
                            {"label": "Invoice Date", "value": "invoice_date"},
                          ],
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Receivables List
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
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Receivables (${filteredReceivables.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Send Reminders",
                          size: bs.sm,
                          onPressed: () {
                            si("Sending payment reminders...");
                          },
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredReceivables.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final receivable = filteredReceivables[index];
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 60,
                              decoration: BoxDecoration(
                                color: _getStatusColor("${receivable["status"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${receivable["client_name"]}",
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
                                          color: _getStatusColor("${receivable["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          _getStatusLabel("${receivable["status"]}"),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${receivable["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.receipt,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${receivable["invoice_number"]} • ${receivable["case_number"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "Due: ${DateTime.parse("${receivable["due_date"]}").dMMMy}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: receivable["status"] == "overdue" ? dangerColor : disabledBoldColor,
                                          fontWeight: receivable["status"] == "overdue" ? FontWeight.w600 : FontWeight.normal,
                                        ),
                                      ),
                                      if (receivable["status"] == "overdue") ...[
                                        Text(
                                          " (${receivable["days_overdue"]} days overdue)",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: dangerColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${(receivable["amount_due"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: (receivable["amount_due"] as double) > 0 ? primaryColor : successColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "of \$${(receivable["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to receivable details
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
