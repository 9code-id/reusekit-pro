import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaRentalIncomeView extends StatefulWidget {
  const ReaRentalIncomeView({super.key});

  @override
  State<ReaRentalIncomeView> createState() => _ReaRentalIncomeViewState();
}

class _ReaRentalIncomeViewState extends State<ReaRentalIncomeView> {
  String selectedPeriod = "thisMonth";
  String selectedProperty = "all";
  
  List<Map<String, dynamic>> incomeData = [
    {
      "id": "RI001",
      "propertyName": "Downtown Apartment 2A",
      "propertyImage": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "tenantName": "John Smith",
      "monthlyRent": 1200.0,
      "paidAmount": 1200.0,
      "dueDate": "2024-01-01",
      "paidDate": "2024-01-01",
      "status": "paid",
      "lateFee": 0.0,
      "month": "January 2024"
    },
    {
      "id": "RI002",
      "propertyName": "Sunset Villa Unit B",
      "propertyImage": "https://picsum.photos/300/200?random=2&keyword=villa",
      "tenantName": "Sarah Johnson",
      "monthlyRent": 1800.0,
      "paidAmount": 1800.0,
      "dueDate": "2024-01-05",
      "paidDate": "2024-01-04",
      "status": "paid",
      "lateFee": 0.0,
      "month": "January 2024"
    },
    {
      "id": "RI003",
      "propertyName": "City Center Studio",
      "propertyImage": "https://picsum.photos/300/200?random=3&keyword=studio",
      "tenantName": "Mike Wilson",
      "monthlyRent": 900.0,
      "paidAmount": 900.0,
      "dueDate": "2024-01-10",
      "paidDate": "2024-01-10",
      "status": "paid",
      "lateFee": 0.0,
      "month": "January 2024"
    },
    {
      "id": "RI004",
      "propertyName": "Garden View Condo",
      "propertyImage": "https://picsum.photos/300/200?random=4&keyword=condo",
      "tenantName": "Emma Davis",
      "monthlyRent": 1500.0,
      "paidAmount": 1500.0,
      "dueDate": "2024-01-15",
      "paidDate": "2024-01-14",
      "status": "paid",
      "lateFee": 0.0,
      "month": "January 2024"
    },
    {
      "id": "RI005",
      "propertyName": "Luxury Penthouse",
      "propertyImage": "https://picsum.photos/300/200?random=5&keyword=penthouse",
      "tenantName": "David Brown",
      "monthlyRent": 2500.0,
      "paidAmount": 1000.0,
      "dueDate": "2024-01-20",
      "paidDate": "2024-01-20",
      "status": "partial",
      "lateFee": 125.0,
      "month": "January 2024"
    },
    // Previous month data
    {
      "id": "RI006",
      "propertyName": "Downtown Apartment 2A",
      "propertyImage": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "tenantName": "John Smith",
      "monthlyRent": 1200.0,
      "paidAmount": 1200.0,
      "dueDate": "2023-12-01",
      "paidDate": "2023-12-01",
      "status": "paid",
      "lateFee": 0.0,
      "month": "December 2023"
    },
    {
      "id": "RI007",
      "propertyName": "Sunset Villa Unit B",
      "propertyImage": "https://picsum.photos/300/200?random=2&keyword=villa",
      "tenantName": "Sarah Johnson",
      "monthlyRent": 1800.0,
      "paidAmount": 1800.0,
      "dueDate": "2023-12-05",
      "paidDate": "2023-12-08",
      "status": "paid",
      "lateFee": 90.0,
      "month": "December 2023"
    }
  ];

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Aug 2023", "income": 6800.0, "properties": 5},
    {"month": "Sep 2023", "income": 7200.0, "properties": 5},
    {"month": "Oct 2023", "income": 7200.0, "properties": 5},
    {"month": "Nov 2023", "income": 7890.0, "properties": 5},
    {"month": "Dec 2023", "income": 8090.0, "properties": 5},
    {"month": "Jan 2024", "income": 7625.0, "properties": 5},
  ];

  double get totalIncomeThisMonth {
    return incomeData
        .where((income) => income["month"] == "January 2024")
        .fold(0.0, (sum, income) => sum + (income["paidAmount"] as double));
  }

  double get totalExpectedThisMonth {
    return incomeData
        .where((income) => income["month"] == "January 2024")
        .fold(0.0, (sum, income) => sum + (income["monthlyRent"] as double));
  }

  double get totalLateFees {
    return incomeData
        .where((income) => income["month"] == "January 2024")
        .fold(0.0, (sum, income) => sum + (income["lateFee"] as double));
  }

  int get paidPropertiesCount {
    return incomeData
        .where((income) => income["month"] == "January 2024" && income["status"] != "pending")
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rental Income"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _exportIncomeReport();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Period Selector
            QCategoryPicker(
              label: "Income Period",
              items: const [
                {"label": "This Month", "value": "thisMonth"},
                {"label": "Last Month", "value": "lastMonth"},
                {"label": "This Quarter", "value": "thisQuarter"},
                {"label": "This Year", "value": "thisYear"},
                {"label": "Custom Range", "value": "custom"},
              ],
              value: selectedPeriod,
              onChanged: (index, label, value, item) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            // Income Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildIncomeCard(
                  "Total Collected",
                  "\$${totalIncomeThisMonth.toStringAsFixed(0)}",
                  Icons.attach_money,
                  successColor,
                  "This month",
                ),
                _buildIncomeCard(
                  "Expected Income",
                  "\$${totalExpectedThisMonth.toStringAsFixed(0)}",
                  Icons.receipt_long,
                  primaryColor,
                  "This month",
                ),
                _buildIncomeCard(
                  "Late Fees",
                  "\$${totalLateFees.toStringAsFixed(0)}",
                  Icons.warning,
                  warningColor,
                  "Additional income",
                ),
                _buildIncomeCard(
                  "Collection Rate",
                  "${((totalIncomeThisMonth / totalExpectedThisMonth) * 100).toStringAsFixed(1)}%",
                  Icons.trending_up,
                  infoColor,
                  "${paidPropertiesCount}/5 properties",
                ),
              ],
            ),

            // Monthly Trend Chart
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
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Income Trend",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "+12.1% vs last month",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: monthlyTrends.length,
                      itemBuilder: (context, index) {
                        final trend = monthlyTrends[index];
                        final maxIncome = monthlyTrends.map((t) => t["income"] as double).reduce((a, b) => a > b ? a : b);
                        final height = ((trend["income"] as double) / maxIncome) * 150;
                        
                        return Container(
                          width: 80,
                          margin: EdgeInsets.only(right: spSm),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "\$${((trend["income"] as double) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                width: 40,
                                height: height,
                                decoration: BoxDecoration(
                                  color: index == monthlyTrends.length - 1 ? primaryColor : primaryColor.withAlpha(100),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${trend["month"]}".split(' ')[0],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Property Income Breakdown
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
                        Icon(Icons.home_work, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Property Income Breakdown",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View All",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: incomeData.where((income) => income["month"] == "January 2024").length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final currentMonthIncomes = incomeData.where((income) => income["month"] == "January 2024").toList();
                      final income = currentMonthIncomes[index];
                      return _buildPropertyIncomeItem(income);
                    },
                  ),
                ],
              ),
            ),

            // Quick Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Add Income",
                          icon: Icons.add,
                          onPressed: () {
                            _showAddIncomeDialog();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          icon: Icons.description,
                          onPressed: () {
                            _generateIncomeReport();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Send Invoices",
                          icon: Icons.send,
                          onPressed: () {
                            _sendInvoices();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Track Expenses",
                          icon: Icons.money_off,
                          onPressed: () {
                            // navigateTo('rea_expense_tracking_view')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyIncomeItem(Map<String, dynamic> income) {
    final collectionRate = (income["paidAmount"] as double) / (income["monthlyRent"] as double);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          // Property Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${income["propertyImage"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          
          // Property Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${income["propertyName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${income["tenantName"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Due: ${DateTime.parse(income["dueDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (income["paidDate"] != null) ...[
                      SizedBox(width: spSm),
                      Text(
                        "Paid: ${DateTime.parse(income["paidDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          
          // Income Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${(income["paidAmount"] as double).toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "of \$${(income["monthlyRent"] as double).toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  color: disabledColor,
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: collectionRate,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      color: collectionRate >= 1.0 ? successColor : warningColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: income["status"] == "paid" 
                      ? successColor.withAlpha(20)
                      : income["status"] == "partial"
                          ? warningColor.withAlpha(20)
                          : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  income["status"] == "paid" 
                      ? "Paid"
                      : income["status"] == "partial"
                          ? "Partial"
                          : "Pending",
                  style: TextStyle(
                    fontSize: 11,
                    color: income["status"] == "paid" 
                        ? successColor
                        : income["status"] == "partial"
                            ? warningColor
                            : disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _exportIncomeReport() {
    ss("Income report exported successfully");
  }

  void _showAddIncomeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Income Entry"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add a new income entry to your records"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Income entry added successfully");
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void _generateIncomeReport() {
    ss("Generating comprehensive income report...");
  }

  void _sendInvoices() {
    ss("Invoices sent to all tenants");
  }
}
