import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaVendorExpensesView extends StatefulWidget {
  const AbaVendorExpensesView({super.key});

  @override
  State<AbaVendorExpensesView> createState() => _AbaVendorExpensesViewState();
}

class _AbaVendorExpensesViewState extends State<AbaVendorExpensesView> {
  int selectedTabIndex = 0;
  String selectedVendor = "All Vendors";
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";

  List<Map<String, dynamic>> vendorOptions = [
    {"label": "All Vendors", "value": "All Vendors"},
    {"label": "TechSupply Corp", "value": "TechSupply Corp"},
    {"label": "Office Solutions Ltd", "value": "Office Solutions Ltd"},
    {"label": "Global Logistics", "value": "Global Logistics"},
    {"label": "Creative Marketing", "value": "Creative Marketing"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Office Supplies", "value": "Office Supplies"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Services", "value": "Services"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Equipment", "value": "Equipment"},
  ];

  List<Map<String, dynamic>> vendorExpenses = [
    {
      "id": 1,
      "vendorName": "TechSupply Corp",
      "vendorId": "VEN001",
      "invoiceNumber": "INV-2024-001",
      "invoiceDate": "2024-03-15",
      "dueDate": "2024-04-15",
      "amount": 2847.65,
      "category": "Technology",
      "description": "Laptop computers and accessories",
      "status": "Approved",
      "approvedBy": "John Manager",
      "approvedDate": "2024-03-16",
      "paymentStatus": "Paid",
      "items": [
        {"name": "Dell Laptop", "quantity": 3, "unitPrice": 899.00},
        {"name": "Wireless Mouse", "quantity": 3, "unitPrice": 25.00},
        {"name": "Laptop Bags", "quantity": 3, "unitPrice": 35.55}
      ]
    },
    {
      "id": 2,
      "vendorName": "Office Solutions Ltd",
      "vendorId": "VEN002",
      "invoiceNumber": "INV-2024-002",
      "invoiceDate": "2024-03-14",
      "dueDate": "2024-04-14",
      "amount": 1456.32,
      "category": "Office Supplies",
      "description": "Monthly office supplies and stationery",
      "status": "Pending",
      "approvedBy": null,
      "approvedDate": null,
      "paymentStatus": "Pending",
      "items": [
        {"name": "Paper Reams", "quantity": 50, "unitPrice": 12.50},
        {"name": "Printer Ink", "quantity": 12, "unitPrice": 45.75},
        {"name": "Office Chairs", "quantity": 5, "unitPrice": 125.00}
      ]
    },
    {
      "id": 3,
      "vendorName": "Global Logistics",
      "vendorId": "VEN003",
      "invoiceNumber": "INV-2024-003",
      "invoiceDate": "2024-03-12",
      "dueDate": "2024-04-12",
      "amount": 892.48,
      "category": "Services",
      "description": "Shipping and delivery services",
      "status": "Approved",
      "approvedBy": "Sarah Director",
      "approvedDate": "2024-03-13",
      "paymentStatus": "Processing",
      "items": [
        {"name": "Express Delivery", "quantity": 15, "unitPrice": 25.80},
        {"name": "International Shipping", "quantity": 8, "unitPrice": 45.60},
        {"name": "Handling Fees", "quantity": 1, "unitPrice": 100.00}
      ]
    },
    {
      "id": 4,
      "vendorName": "Creative Marketing",
      "vendorId": "VEN004",
      "invoiceNumber": "INV-2024-004",
      "invoiceDate": "2024-03-10",
      "dueDate": "2024-04-10",
      "amount": 3567.89,
      "category": "Marketing",
      "description": "Q1 Marketing campaign materials",
      "status": "Rejected",
      "approvedBy": "Mike CFO",
      "approvedDate": "2024-03-11",
      "paymentStatus": "Cancelled",
      "rejectionReason": "Invoice amount exceeds approved budget",
      "items": [
        {"name": "Banner Design", "quantity": 10, "unitPrice": 150.00},
        {"name": "Print Materials", "quantity": 1000, "unitPrice": 2.85},
        {"name": "Digital Ads", "quantity": 1, "unitPrice": 717.89}
      ]
    }
  ];

  List<Map<String, dynamic>> vendorSummary = [
    {
      "vendorName": "TechSupply Corp",
      "totalSpent": 15420.75,
      "invoiceCount": 8,
      "avgAmount": 1927.59,
      "paymentTerms": "Net 30",
      "onTimePayment": 95.5
    },
    {
      "vendorName": "Office Solutions Ltd",
      "totalSpent": 8765.43,
      "invoiceCount": 12,
      "avgAmount": 730.45,
      "paymentTerms": "Net 15",
      "onTimePayment": 98.2
    },
    {
      "vendorName": "Global Logistics",
      "totalSpent": 6234.18,
      "invoiceCount": 15,
      "avgAmount": 415.61,
      "paymentTerms": "Due on Receipt",
      "onTimePayment": 87.3
    },
    {
      "vendorName": "Creative Marketing",
      "totalSpent": 12890.56,
      "invoiceCount": 6,
      "avgAmount": 2148.43,
      "paymentTerms": "Net 45",
      "onTimePayment": 92.8
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Vendor Expenses",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Expenses", icon: Icon(Icons.receipt_long)),
        Tab(text: "Vendors", icon: Icon(Icons.business)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildExpensesTab(),
        _buildVendorsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildExpensesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Icon(Icons.filter_list, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Filter Expenses",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Vendor",
                  items: vendorOptions,
                  value: selectedVendor,
                  onChanged: (value, label) {
                    selectedVendor = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
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
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Expenses",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${vendorExpenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as num)).toStringAsFixed(2)}",
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
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vendorExpenses.where((e) => e["status"] == "Pending").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vendors",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vendorExpenses.map((e) => e["vendorName"]).toSet().length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...vendorExpenses.map((expense) => _buildVendorExpenseCard(expense)),
        ],
      ),
    );
  }

  Widget _buildVendorExpenseCard(Map<String, dynamic> expense) {
    Color statusColor = expense["status"] == "Approved" 
        ? successColor 
        : expense["status"] == "Pending" 
            ? warningColor 
            : dangerColor;

    Color paymentColor = expense["paymentStatus"] == "Paid" 
        ? successColor 
        : expense["paymentStatus"] == "Processing" 
            ? warningColor 
            : expense["paymentStatus"] == "Cancelled"
                ? dangerColor
                : infoColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
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
                      "${expense["vendorName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${expense["vendorId"]} • ${expense["invoiceNumber"]}",
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
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${expense["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${expense["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
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
                        "\$${(expense["amount"] as num).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                        "Invoice Date",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${expense["invoiceDate"]}",
                        style: TextStyle(
                          fontSize: 16,
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
                        "${expense["dueDate"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${expense["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: paymentColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Payment: ${expense["paymentStatus"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: paymentColor,
                  ),
                ),
              ),
            ],
          ),
          if (expense["approvedBy"] != null)
            Row(
              children: [
                Icon(Icons.person, color: successColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Approved by ${expense["approvedBy"]} on ${expense["approvedDate"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: successColor,
                  ),
                ),
              ],
            ),
          if (expense["rejectionReason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: dangerColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Rejected: ${expense["rejectionReason"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ExpansionTile(
            title: Text(
              "View Items (${(expense["items"] as List).length})",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: (expense["items"] as List).map((item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${item["name"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Qty: ${item["quantity"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "\$${(item["unitPrice"] as num).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("View expense details");
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (expense["status"] == "Pending")
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Approve this vendor expense?");
                      if (isConfirmed) {
                        ss("Vendor expense approved");
                      }
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVendorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active Vendors",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vendorSummary.length}",
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
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${vendorSummary.fold(0.0, (sum, vendor) => sum + (vendor["totalSpent"] as num)).toStringAsFixed(2)}",
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
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avg Invoice",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(vendorSummary.fold(0.0, (sum, vendor) => sum + (vendor["avgAmount"] as num)) / vendorSummary.length).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...vendorSummary.map((vendor) => _buildVendorSummaryCard(vendor)),
        ],
      ),
    );
  }

  Widget _buildVendorSummaryCard(Map<String, dynamic> vendor) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: Text(
                  "${vendor["vendorName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${vendor["paymentTerms"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(vendor["totalSpent"] as num).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                        "Invoices",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${vendor["invoiceCount"]}",
                        style: TextStyle(
                          fontSize: 16,
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
                        "Avg Amount",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(vendor["avgAmount"] as num).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "On-time Payment: ${vendor["onTimePayment"]}%",
                style: TextStyle(
                  fontSize: 13,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View History",
                  size: bs.sm,
                  onPressed: () {
                    si("View vendor history");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Contact Vendor",
                  size: bs.sm,
                  onPressed: () {
                    si("Contact vendor");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Spending Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.trending_up, color: successColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "This Month",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$43,310.92",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "+8.5%",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
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
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.trending_down, color: warningColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Last Month",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$39,847.65",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "-3.2%",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Top Spending Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildCategorySpending("Technology", 15420.75, 35, primaryColor),
                _buildCategorySpending("Services", 12890.56, 30, successColor),
                _buildCategorySpending("Office Supplies", 8765.43, 20, warningColor),
                _buildCategorySpending("Marketing", 6234.18, 15, infoColor),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Payment Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildPaymentStatus("On Time", 85, successColor),
                _buildPaymentStatus("Late (1-7 days)", 10, warningColor),
                _buildPaymentStatus("Late (8+ days)", 5, dangerColor),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Vendor Performance Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.receipt, color: infoColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Avg Invoice Time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "3.2 days",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
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
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.star, color: primaryColor, size: 32),
                            SizedBox(height: spXs),
                            Text(
                              "Avg Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "4.6/5.0",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            label: "Export Analytics Report",
            onPressed: () {
              ss("Analytics report exported successfully");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySpending(String category, double amount, int percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                "$percentage%",
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
  }

  Widget _buildPaymentStatus(String status, int percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            status.contains("On Time") ? Icons.check_circle : Icons.access_time,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "$percentage%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
