import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaInvoiceView extends StatefulWidget {
  const RmaInvoiceView({super.key});

  @override
  State<RmaInvoiceView> createState() => _RmaInvoiceViewState();
}

class _RmaInvoiceViewState extends State<RmaInvoiceView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPeriod = "This Month";
  String selectedCustomer = "All Customers";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Draft", "value": "draft"},
    {"label": "Sent", "value": "sent"},
    {"label": "Paid", "value": "paid"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "This Quarter", "value": "current_quarter"},
    {"label": "This Year", "value": "current_year"},
  ];

  List<Map<String, dynamic>> customerOptions = [
    {"label": "All Customers", "value": "all"},
    {"label": "Acme Corporation", "value": "acme"},
    {"label": "Tech Solutions Inc", "value": "tech_solutions"},
    {"label": "Global Enterprises", "value": "global"},
    {"label": "Startup Co.", "value": "startup"},
  ];

  List<Map<String, dynamic>> invoiceStats = [
    {
      "title": "Total Invoices",
      "amount": 156,
      "change": 12.5,
      "icon": Icons.receipt_long,
      "color": primaryColor,
      "isCount": true,
    },
    {
      "title": "Outstanding Amount",
      "amount": 89650.75,
      "change": -8.3,
      "icon": Icons.pending_actions,
      "color": warningColor,
      "isCount": false,
    },
    {
      "title": "Paid This Month",
      "amount": 124780.50,
      "change": 15.7,
      "icon": Icons.payments,
      "color": successColor,
      "isCount": false,
    },
    {
      "title": "Overdue Invoices",
      "amount": 23,
      "change": -18.2,
      "icon": Icons.warning,
      "color": dangerColor,
      "isCount": true,
    },
  ];

  List<Map<String, dynamic>> recentInvoices = [
    {
      "id": "INV-2024-001",
      "customerName": "Acme Corporation",
      "customerEmail": "billing@acme.com",
      "amount": 12500.00,
      "issueDate": "2024-01-15",
      "dueDate": "2024-02-14",
      "status": "paid",
      "items": 5,
      "paymentMethod": "Bank Transfer",
    },
    {
      "id": "INV-2024-002",
      "customerName": "Tech Solutions Inc",
      "customerEmail": "accounts@techsolutions.com",
      "amount": 8750.50,
      "issueDate": "2024-01-14",
      "dueDate": "2024-02-13",
      "status": "sent",
      "items": 3,
      "paymentMethod": null,
    },
    {
      "id": "INV-2024-003",
      "customerName": "Global Enterprises",
      "customerEmail": "finance@global.com",
      "amount": 15200.00,
      "issueDate": "2024-01-13",
      "dueDate": "2024-02-12",
      "status": "overdue",
      "items": 8,
      "paymentMethod": null,
    },
    {
      "id": "INV-2024-004",
      "customerName": "Startup Co.",
      "customerEmail": "billing@startup.co",
      "amount": 5600.25,
      "issueDate": "2024-01-12",
      "dueDate": "2024-02-11",
      "status": "draft",
      "items": 2,
      "paymentMethod": null,
    },
    {
      "id": "INV-2024-005",
      "customerName": "Innovation Labs",
      "customerEmail": "payments@innovationlabs.com",
      "amount": 9850.75,
      "issueDate": "2024-01-11",
      "dueDate": "2024-02-10",
      "status": "paid",
      "items": 4,
      "paymentMethod": "Credit Card",
    },
  ];

  List<Map<String, dynamic>> invoiceTemplates = [
    {
      "id": "template_1",
      "name": "Standard Invoice",
      "description": "Basic invoice template for general services",
      "isDefault": true,
      "usageCount": 89,
    },
    {
      "id": "template_2",
      "name": "Professional Services",
      "description": "Template for consulting and professional services",
      "isDefault": false,
      "usageCount": 45,
    },
    {
      "id": "template_3",
      "name": "Product Sales",
      "description": "Template for product-based invoices with tax",
      "isDefault": false,
      "usageCount": 67,
    },
    {
      "id": "template_4",
      "name": "Recurring Billing",
      "description": "Template for subscription and recurring payments",
      "isDefault": false,
      "usageCount": 23,
    },
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "method": "Bank Transfer",
      "count": 45,
      "amount": 89650.00,
      "percentage": 42.5,
      "icon": Icons.account_balance,
    },
    {
      "method": "Credit Card",
      "count": 67,
      "amount": 78450.50,
      "percentage": 37.2,
      "icon": Icons.credit_card,
    },
    {
      "method": "PayPal",
      "count": 28,
      "amount": 34250.75,
      "percentage": 16.2,
      "icon": Icons.payment,
    },
    {
      "method": "Check",
      "count": 12,
      "amount": 8940.25,
      "percentage": 4.1,
      "icon": Icons.receipt,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid': return successColor;
      case 'sent': return primaryColor;
      case 'draft': return disabledBoldColor;
      case 'overdue': return dangerColor;
      case 'cancelled': return dangerColor;
      default: return disabledBoldColor;
    }
  }

  void _showInvoiceDetails(Map<String, dynamic> invoice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Invoice Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(invoice["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      color: _getStatusColor(invoice["status"]),
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${invoice["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(invoice["status"]),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(invoice["status"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${invoice["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              _buildDetailRow("Customer", "${invoice["customerName"]}"),
              _buildDetailRow("Email", "${invoice["customerEmail"]}"),
              _buildDetailRow("Amount", "\$${((invoice["amount"] as num).toDouble()).currency}"),
              _buildDetailRow("Issue Date", "${invoice["issueDate"]}"),
              _buildDetailRow("Due Date", "${invoice["dueDate"]}"),
              _buildDetailRow("Items", "${invoice["items"]} items"),
              if (invoice["paymentMethod"] != null)
                _buildDetailRow("Payment Method", "${invoice["paymentMethod"]}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "View Invoice",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Invoice viewer would open here");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: invoiceStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
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
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            stat["icon"],
                            color: stat["color"],
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (stat["change"] as num) >= 0 
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                (stat["change"] as num) >= 0 
                                    ? Icons.trending_up 
                                    : Icons.trending_down,
                                color: (stat["change"] as num) >= 0 
                                    ? successColor 
                                    : dangerColor,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(stat["change"] as num) >= 0 ? '+' : ''}${(stat["change"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: (stat["change"] as num) >= 0 
                                      ? successColor 
                                      : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      stat["isCount"] == true 
                          ? "${(stat["amount"] as num).toInt()}"
                          : "\$${((stat["amount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Payment Methods Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          ...paymentMethods.map((method) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      method["icon"],
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${method["method"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${method["count"]} invoices",
                          style: TextStyle(
                            fontSize: 12,
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
                        "\$${((method["amount"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(method["percentage"] as num).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildInvoicesTab() {
    var filteredInvoices = recentInvoices.where((invoice) {
      bool matchesSearch = searchQuery.isEmpty || 
          invoice["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          invoice["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          invoice["customerEmail"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || invoice["status"] == selectedStatus;
      bool matchesCustomer = selectedCustomer == "All Customers" || invoice["customerName"] == selectedCustomer;
      
      return matchesSearch && matchesStatus && matchesCustomer;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
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
                  _showFiltersDialog();
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  si("Create new invoice dialog would open here");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...filteredInvoices.map((invoice) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(invoice["status"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${invoice["customerName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(invoice["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${invoice["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(invoice["status"]),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${((invoice["amount"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${invoice["customerEmail"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Due: ${invoice["dueDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () => _showInvoiceDetails(invoice),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: disabledBoldColor,
                          size: 14,
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
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Invoice Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  si("Create new template dialog would open here");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...invoiceTemplates.map((template) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: template["isDefault"] == true 
                    ? Border.all(color: primaryColor, width: 2)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${template["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (template["isDefault"] == true) ...[
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "DEFAULT",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${template["description"]}",
                              style: TextStyle(
                                fontSize: 12,
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
                            "${template["usageCount"]} uses",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  si("Template preview would open here");
                                },
                                child: Icon(
                                  Icons.visibility,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  si("Template editor would open here");
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showFiltersDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Invoices"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Customer",
              items: customerOptions,
              value: selectedCustomer,
              onChanged: (value, label) {
                selectedCustomer = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedStatus = "All";
              selectedCustomer = "All Customers";
              selectedPeriod = "This Month";
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Clear"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Invoice Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Invoices", icon: Icon(Icons.receipt_long)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildInvoicesTab(),
        _buildTemplatesTab(),
      ],
    );
  }
}
