import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaInvoiceView extends StatefulWidget {
  const CmaInvoiceView({super.key});

  @override
  State<CmaInvoiceView> createState() => _CmaInvoiceViewState();
}

class _CmaInvoiceViewState extends State<CmaInvoiceView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPeriod = "This Month";
  int currentTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Sent", "value": "Sent"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "customerName": "Acme Corporation",
      "amount": 2500.00,
      "dueDate": "2024-07-15",
      "status": "Sent",
      "issueDate": "2024-06-15",
      "paymentTerms": "Net 30",
    },
    {
      "id": "INV-2024-002",
      "customerName": "TechStart Inc.",
      "amount": 1850.00,
      "dueDate": "2024-07-10",
      "status": "Paid",
      "issueDate": "2024-06-10",
      "paymentTerms": "Net 30",
    },
    {
      "id": "INV-2024-003",
      "customerName": "Global Solutions",
      "amount": 3200.00,
      "dueDate": "2024-06-30",
      "status": "Overdue",
      "issueDate": "2024-05-30",
      "paymentTerms": "Net 30",
    },
    {
      "id": "INV-2024-004",
      "customerName": "Innovation Labs",
      "amount": 1200.00,
      "dueDate": "2024-07-20",
      "status": "Draft",
      "issueDate": "2024-06-20",
      "paymentTerms": "Net 30",
    },
    {
      "id": "INV-2024-005",
      "customerName": "Digital Agency",
      "amount": 4500.00,
      "dueDate": "2024-07-25",
      "status": "Sent",
      "issueDate": "2024-06-25",
      "paymentTerms": "Net 30",
    },
  ];

  List<Map<String, dynamic>> get filteredInvoices {
    return invoices.where((invoice) {
      bool matchesSearch = "${invoice["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${invoice["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || invoice["status"] == selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Sent":
        return infoColor;
      case "Overdue":
        return dangerColor;
      case "Draft":
        return warningColor;
      case "Cancelled":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.trending_up,
                    color: successColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${invoice["status"]}"),
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
                      "${invoice["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${invoice["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${invoice["status"]}").withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${invoice["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${invoice["status"]}"),
                  ),
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
                      "\$${(invoice["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
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
                      "${invoice["dueDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DateTime.parse("${invoice["dueDate"]}").isBefore(DateTime.now()) && invoice["status"] != "Paid"
                            ? dangerColor
                            : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showInvoiceActions(invoice);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showInvoiceActions(Map<String, dynamic> invoice) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              "${invoice["id"]}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Column(
              spacing: spSm,
              children: [
                _buildActionTile(
                  icon: Icons.visibility,
                  label: "View Details",
                  onTap: () {
                    back();
                    // Navigate to invoice detail
                  },
                ),
                _buildActionTile(
                  icon: Icons.edit,
                  label: "Edit Invoice",
                  onTap: () {
                    back();
                    ss("Edit invoice functionality");
                  },
                ),
                _buildActionTile(
                  icon: Icons.send,
                  label: "Send Invoice",
                  onTap: () {
                    back();
                    ss("Invoice sent successfully");
                  },
                ),
                _buildActionTile(
                  icon: Icons.download,
                  label: "Download PDF",
                  onTap: () {
                    back();
                    ss("Invoice downloaded");
                  },
                ),
                _buildActionTile(
                  icon: Icons.delete,
                  label: "Delete Invoice",
                  color: dangerColor,
                  onTap: () async {
                    back();
                    bool isConfirmed = await confirm("Are you sure you want to delete this invoice?");
                    if (isConfirmed) {
                      ss("Invoice deleted successfully");
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(13),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color ?? primaryColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoices"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create invoice
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard("Total Invoices", "142", Icons.description, primaryColor),
                _buildSummaryCard("Outstanding", "\$12,450", Icons.schedule, warningColor),
                _buildSummaryCard("Paid This Month", "\$24,780", Icons.check_circle, successColor),
                _buildSummaryCard("Overdue", "\$3,200", Icons.error, dangerColor),
              ],
            ),

            // Filters
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
                          label: "Search invoices...",
                          value: searchQuery,
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
                        onPressed: () {
                          // Show advanced filters
                        },
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
                          label: "Period",
                          items: periodOptions,
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

            // Invoices List
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
                      Expanded(
                        child: Text(
                          "Invoices (${filteredInvoices.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Create Invoice",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to create invoice
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (filteredInvoices.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.description,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No invoices found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Create your first invoice to get started",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredInvoices.map((invoice) => _buildInvoiceCard(invoice)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create invoice
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
