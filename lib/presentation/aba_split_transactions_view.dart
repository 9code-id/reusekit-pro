import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaSplitTransactionsView extends StatefulWidget {
  const AbaSplitTransactionsView({super.key});

  @override
  State<AbaSplitTransactionsView> createState() => _AbaSplitTransactionsViewState();
}

class _AbaSplitTransactionsViewState extends State<AbaSplitTransactionsView> {
  String searchQuery = "";
  String selectedPeriod = "This Month";
  String selectedType = "All";
  bool loading = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "All Time", "value": "All Time"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Expense", "value": "Expense"},
    {"label": "Income", "value": "Income"},
    {"label": "Transfer", "value": "Transfer"},
  ];

  List<Map<String, dynamic>> splitTransactions = [
    {
      "id": "st001",
      "date": "2024-12-18",
      "description": "Business Lunch Meeting",
      "reference": "BL-001",
      "account": "Credit Card",
      "accountNumber": "2100",
      "totalAmount": 180.00,
      "type": "Expense",
      "status": "Completed",
      "splitCount": 3,
      "createdBy": "John Smith",
      "createdDate": "2024-12-18T12:30:00",
      "splits": [
        {
          "category": "Meals & Entertainment",
          "description": "Restaurant bill",
          "amount": 120.00,
          "percentage": 66.67
        },
        {
          "category": "Travel",
          "description": "Parking fee",
          "amount": 15.00,
          "percentage": 8.33
        },
        {
          "category": "Client Entertainment",
          "description": "Client portion",
          "amount": 45.00,
          "percentage": 25.00
        }
      ]
    },
    {
      "id": "st002",
      "date": "2024-12-17",
      "description": "Office Supplies & Equipment Purchase",
      "reference": "OSE-002",
      "account": "Bank Account - Checking",
      "accountNumber": "1002",
      "totalAmount": 850.00,
      "type": "Expense",
      "status": "Completed",
      "splitCount": 4,
      "createdBy": "Sarah Wilson",
      "createdDate": "2024-12-17T10:15:00",
      "splits": [
        {
          "category": "Office Supplies",
          "description": "Stationery and paper",
          "amount": 250.00,
          "percentage": 29.41
        },
        {
          "category": "Computer Equipment",
          "description": "Monitor and keyboard",
          "amount": 400.00,
          "percentage": 47.06
        },
        {
          "category": "Furniture",
          "description": "Office chair",
          "amount": 150.00,
          "percentage": 17.65
        },
        {
          "category": "Software",
          "description": "License renewal",
          "amount": 50.00,
          "percentage": 5.88
        }
      ]
    },
    {
      "id": "st003",
      "date": "2024-12-16",
      "description": "Marketing Campaign Expenses",
      "reference": "MKT-003",
      "account": "Credit Card",
      "accountNumber": "2100",
      "totalAmount": 2500.00,
      "type": "Expense",
      "status": "Completed",
      "splitCount": 5,
      "createdBy": "Mike Johnson",
      "createdDate": "2024-12-16T14:20:00",
      "splits": [
        {
          "category": "Online Advertising",
          "description": "Google Ads campaign",
          "amount": 1200.00,
          "percentage": 48.00
        },
        {
          "category": "Print Marketing",
          "description": "Brochures and flyers",
          "amount": 400.00,
          "percentage": 16.00
        },
        {
          "category": "Website Development",
          "description": "Landing page creation",
          "amount": 600.00,
          "percentage": 24.00
        },
        {
          "category": "Photography",
          "description": "Product photos",
          "amount": 200.00,
          "percentage": 8.00
        },
        {
          "category": "Design Services",
          "description": "Logo and graphics",
          "amount": 100.00,
          "percentage": 4.00
        }
      ]
    },
    {
      "id": "st004",
      "date": "2024-12-15",
      "description": "Multi-Service Revenue",
      "reference": "MSR-004",
      "account": "Bank Account - Checking",
      "accountNumber": "1002",
      "totalAmount": 3500.00,
      "type": "Income",
      "status": "Completed",
      "splitCount": 3,
      "createdBy": "Jane Doe",
      "createdDate": "2024-12-15T16:45:00",
      "splits": [
        {
          "category": "Consulting Services",
          "description": "Business strategy consulting",
          "amount": 2000.00,
          "percentage": 57.14
        },
        {
          "category": "Training Services",
          "description": "Staff training sessions",
          "amount": 1000.00,
          "percentage": 28.57
        },
        {
          "category": "Support Services",
          "description": "Technical support",
          "amount": 500.00,
          "percentage": 14.29
        }
      ]
    },
    {
      "id": "st005",
      "date": "2024-12-14",
      "description": "Travel Expense Breakdown",
      "reference": "TRV-005",
      "account": "Credit Card",
      "accountNumber": "2100",
      "totalAmount": 1200.00,
      "type": "Expense",
      "status": "Completed",
      "splitCount": 6,
      "createdBy": "Sarah Wilson",
      "createdDate": "2024-12-14T09:30:00",
      "splits": [
        {
          "category": "Airfare",
          "description": "Flight tickets",
          "amount": 600.00,
          "percentage": 50.00
        },
        {
          "category": "Hotel",
          "description": "Accommodation",
          "amount": 300.00,
          "percentage": 25.00
        },
        {
          "category": "Meals",
          "description": "Business meals",
          "amount": 150.00,
          "percentage": 12.50
        },
        {
          "category": "Transportation",
          "description": "Local transport",
          "amount": 80.00,
          "percentage": 6.67
        },
        {
          "category": "Conference Fee",
          "description": "Event registration",
          "amount": 50.00,
          "percentage": 4.17
        },
        {
          "category": "Miscellaneous",
          "description": "Other expenses",
          "amount": 20.00,
          "percentage": 1.67
        }
      ]
    },
    {
      "id": "st006",
      "date": "2024-12-13",
      "description": "Utility Bills Split",
      "reference": "UTL-006",
      "account": "Bank Account - Checking",
      "accountNumber": "1002",
      "totalAmount": 450.00,
      "type": "Expense",
      "status": "Completed",
      "splitCount": 3,
      "createdBy": "Mike Johnson",
      "createdDate": "2024-12-13T11:00:00",
      "splits": [
        {
          "category": "Electricity",
          "description": "Monthly electric bill",
          "amount": 250.00,
          "percentage": 55.56
        },
        {
          "category": "Internet",
          "description": "Business internet",
          "amount": 120.00,
          "percentage": 26.67
        },
        {
          "category": "Phone",
          "description": "Business phone line",
          "amount": 80.00,
          "percentage": 17.78
        }
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return splitTransactions.where((transaction) {
      bool matchesSearch = "${transaction["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${transaction["reference"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType == "All" || transaction["type"] == selectedType;
      return matchesSearch && matchesType;
    }).toList();
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Income":
        return successColor;
      case "Expense":
        return dangerColor;
      case "Transfer":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Income":
        return Icons.trending_up;
      case "Expense":
        return Icons.trending_down;
      case "Transfer":
        return Icons.swap_horiz;
      default:
        return Icons.call_split;
    }
  }

  double get totalSplitAmount {
    return filteredTransactions.map((t) => t["totalAmount"] as double).fold(0.0, (sum, amount) => sum + amount);
  }

  int get totalSplitCount {
    return filteredTransactions.map((t) => t["splitCount"] as int).fold(0, (sum, count) => sum + count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Split Transactions"),
        actions: [
          IconButton(
            onPressed: () {
              //navigateTo('SplitReportsView')
            },
            icon: Icon(Icons.analytics),
          ),
          IconButton(
            onPressed: () {
              //navigateTo('AddSplitTransactionView')
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QTextField(
                                label: "Search split transactions...",
                                value: searchQuery,
                                hint: "Description or reference",
                                onChanged: (value) {
                                  searchQuery = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: spSm,
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
                            Expanded(
                              child: QDropdownField(
                                label: "Type",
                                items: typeOptions,
                                value: selectedType,
                                onChanged: (value, label) {
                                  selectedType = value;
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
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard(
                        "Total Transactions",
                        "${filteredTransactions.length}",
                        Icons.call_split,
                        primaryColor,
                      ),
                      _buildSummaryCard(
                        "Total Amount",
                        "${totalSplitAmount.currency}",
                        Icons.attach_money,
                        successColor,
                      ),
                      _buildSummaryCard(
                        "Total Splits",
                        "$totalSplitCount",
                        Icons.pie_chart,
                        infoColor,
                      ),
                      _buildSummaryCard(
                        "Avg Splits per Transaction",
                        "${filteredTransactions.isNotEmpty ? (totalSplitCount / filteredTransactions.length).toStringAsFixed(1) : '0'}",
                        Icons.analytics,
                        warningColor,
                      ),
                    ],
                  ),

                  // Split Transactions List
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
                            children: [
                              Icon(
                                Icons.list,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Split Transactions (${filteredTransactions.length})",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredTransactions.length,
                          separatorBuilder: (context, index) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final transaction = filteredTransactions[index];
                            String type = "${transaction["type"]}";
                            List<Map<String, dynamic>> splits = transaction["splits"] as List<Map<String, dynamic>>;

                            return GestureDetector(
                              onTap: () {
                                //navigateTo('SplitTransactionDetailView', transaction)
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Transaction Header
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: _getTypeColor(type).withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            _getTypeIcon(type),
                                            color: _getTypeColor(type),
                                            size: 20,
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
                                                      "${transaction["description"]}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: spXs,
                                                      vertical: 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: _getTypeColor(type).withAlpha(20),
                                                      borderRadius: BorderRadius.circular(radiusXs),
                                                    ),
                                                    child: Text(
                                                      type,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        color: _getTypeColor(type),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${DateTime.parse("${transaction["date"]}").dMMMy}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                  if (transaction["reference"] != null) ...[
                                                    SizedBox(width: spSm),
                                                    Container(
                                                      width: 4,
                                                      height: 4,
                                                      decoration: BoxDecoration(
                                                        color: disabledColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    SizedBox(width: spSm),
                                                    Text(
                                                      "${transaction["reference"]}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: disabledBoldColor,
                                                      ),
                                                    ),
                                                  ],
                                                  SizedBox(width: spSm),
                                                  Container(
                                                    width: 4,
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      color: disabledColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(width: spSm),
                                                  Text(
                                                    "${transaction["account"]}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${(transaction["totalAmount"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: _getTypeColor(type),
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              "${transaction["splitCount"]} splits",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: disabledColor,
                                          size: 16,
                                        ),
                                      ],
                                    ),

                                    // Split Preview
                                    SizedBox(height: spSm),
                                    Container(
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: disabledColor.withAlpha(5),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.pie_chart,
                                                color: disabledBoldColor,
                                                size: 14,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "Split Breakdown",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: spXs),
                                          ...splits.take(3).map((split) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: BoxDecoration(
                                                      color: _getTypeColor(type),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(width: spXs),
                                                  Expanded(
                                                    child: Text(
                                                      "${split["category"]}",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: disabledBoldColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${(split["amount"] as double).currency}",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w500,
                                                      color: _getTypeColor(type),
                                                    ),
                                                  ),
                                                  SizedBox(width: spXs),
                                                  Text(
                                                    "(${(split["percentage"] as double).toStringAsFixed(1)}%)",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: disabledColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          if (splits.length > 3) ...[
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2),
                                              child: Text(
                                                "... and ${splits.length - 3} more splits",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: disabledColor,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),

                                    // Created By Info
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: disabledColor,
                                          size: 14,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Created by ${transaction["createdBy"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${transaction["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: successColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('AddSplitTransactionView')
        },
        child: Icon(Icons.call_split),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              Spacer(),
              Icon(
                Icons.call_split,
                color: color,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
