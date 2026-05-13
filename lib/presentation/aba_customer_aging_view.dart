import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCustomerAgingView extends StatefulWidget {
  const AbaCustomerAgingView({super.key});

  @override
  State<AbaCustomerAgingView> createState() => _AbaCustomerAgingViewState();
}

class _AbaCustomerAgingViewState extends State<AbaCustomerAgingView> {
  String searchQuery = "";
  String selectedAging = "all";
  String selectedCustomer = "all";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> agingOptions = [
    {"label": "All Aging", "value": "all"},
    {"label": "Current (0-30)", "value": "current"},
    {"label": "30-60 Days", "value": "30_60"},
    {"label": "60-90 Days", "value": "60_90"},
    {"label": "Over 90 Days", "value": "over_90"},
  ];

  List<Map<String, dynamic>> customerOptions = [
    {"label": "All Customers", "value": "all"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Brown", "value": "michael_brown"},
    {"label": "Emily Davis", "value": "emily_davis"},
  ];

  List<Map<String, dynamic>> agingData = [
    {
      "customer_name": "John Smith",
      "customer_id": "CUST-001",
      "total_outstanding": 2850.00,
      "current": 1200.00,
      "days_30_60": 850.00,
      "days_60_90": 500.00,
      "days_over_90": 300.00,
      "last_payment_date": "2024-06-10",
      "contact_attempts": 2,
      "risk_score": 65,
      "credit_limit": 5000.00,
    },
    {
      "customer_name": "Sarah Johnson",
      "customer_id": "CUST-002",
      "total_outstanding": 1450.50,
      "current": 890.50,
      "days_30_60": 560.00,
      "days_60_90": 0.00,
      "days_over_90": 0.00,
      "last_payment_date": "2024-06-15",
      "contact_attempts": 1,
      "risk_score": 35,
      "credit_limit": 3000.00,
    },
    {
      "customer_name": "Michael Brown",
      "customer_id": "CUST-003",
      "total_outstanding": 4200.75,
      "current": 0.00,
      "days_30_60": 1200.00,
      "days_60_90": 1500.75,
      "days_over_90": 1500.00,
      "last_payment_date": "2024-04-20",
      "contact_attempts": 5,
      "risk_score": 85,
      "credit_limit": 7500.00,
    },
    {
      "customer_name": "Emily Davis",
      "customer_id": "CUST-004",
      "total_outstanding": 680.00,
      "current": 680.00,
      "days_30_60": 0.00,
      "days_60_90": 0.00,
      "days_over_90": 0.00,
      "last_payment_date": "2024-06-18",
      "contact_attempts": 0,
      "risk_score": 25,
      "credit_limit": 2500.00,
    },
    {
      "customer_name": "David Wilson",
      "customer_id": "CUST-005",
      "total_outstanding": 3200.00,
      "current": 0.00,
      "days_30_60": 0.00,
      "days_60_90": 800.00,
      "days_over_90": 2400.00,
      "last_payment_date": "2024-03-15",
      "contact_attempts": 8,
      "risk_score": 95,
      "credit_limit": 4000.00,
    },
  ];

  List<Map<String, dynamic>> get filteredAgingData {
    return agingData.where((data) {
      final matchesSearch = data["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          data["customer_id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCustomer = selectedCustomer == "all" || 
          data["customer_name"].toString().toLowerCase().contains(selectedCustomer.replaceAll("_", " "));
      
      bool matchesAging = true;
      if (selectedAging != "all") {
        switch (selectedAging) {
          case "current":
            matchesAging = (data["current"] as double) > 0;
            break;
          case "30_60":
            matchesAging = (data["days_30_60"] as double) > 0;
            break;
          case "60_90":
            matchesAging = (data["days_60_90"] as double) > 0;
            break;
          case "over_90":
            matchesAging = (data["days_over_90"] as double) > 0;
            break;
        }
      }
      
      return matchesSearch && matchesCustomer && matchesAging;
    }).toList();
  }

  Color _getRiskColor(int riskScore) {
    if (riskScore >= 80) return dangerColor;
    if (riskScore >= 60) return warningColor;
    if (riskScore >= 40) return infoColor;
    return successColor;
  }

  String _getRiskLevel(int riskScore) {
    if (riskScore >= 80) return "High";
    if (riskScore >= 60) return "Medium";
    if (riskScore >= 40) return "Low";
    return "Minimal";
  }

  void _generateAgingReport() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Aging report generated successfully");
  }

  void _sendReminder(Map<String, dynamic> customer) async {
    bool isConfirmed = await confirm("Send payment reminder to ${customer["customer_name"]}?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Payment reminder sent");
  }

  Widget _buildSummaryCard(String title, double amount, Color color) {
    return Expanded(
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
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "\$${amount.currency}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    final totalOutstanding = agingData.fold(0.0, (sum, data) => sum + (data["total_outstanding"] as double));
    final currentAmount = agingData.fold(0.0, (sum, data) => sum + (data["current"] as double));
    final days30_60 = agingData.fold(0.0, (sum, data) => sum + (data["days_30_60"] as double));
    final days60_90 = agingData.fold(0.0, (sum, data) => sum + (data["days_60_90"] as double));
    final daysOver90 = agingData.fold(0.0, (sum, data) => sum + (data["days_over_90"] as double));

    return Column(
      spacing: spMd,
      children: [
        // Summary Cards
        Row(
          children: [
            _buildSummaryCard("Total Outstanding", totalOutstanding, primaryColor),
            SizedBox(width: spSm),
            _buildSummaryCard("Current", currentAmount, successColor),
          ],
        ),
        Row(
          children: [
            _buildSummaryCard("30-60 Days", days30_60, warningColor),
            SizedBox(width: spSm),
            _buildSummaryCard("60-90 Days", days60_90, dangerColor),
          ],
        ),
        Row(
          children: [
            _buildSummaryCard("Over 90 Days", daysOver90, dangerColor),
            SizedBox(width: spSm),
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
                  Text(
                    "High Risk Customers",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${agingData.where((d) => (d["risk_score"] as int) >= 80).length}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        // Aging Chart Placeholder
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
              Text(
                "Aging Distribution",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    flex: (currentAmount / totalOutstanding * 100).round(),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    flex: (days30_60 / totalOutstanding * 100).round(),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    flex: (days60_90 / totalOutstanding * 100).round(),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    flex: (daysOver90 / totalOutstanding * 100).round(),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLegendItem("Current", successColor),
                  _buildLegendItem("30-60", warningColor),
                  _buildLegendItem("60-90", dangerColor),
                  _buildLegendItem("90+", dangerColor),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsTab() {
    return Column(
      spacing: spMd,
      children: [
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
                      label: "Search customers...",
                      value: searchQuery,
                      hint: "Customer name or ID",
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
                      label: "Customer",
                      items: customerOptions,
                      value: selectedCustomer,
                      onChanged: (value, label) {
                        selectedCustomer = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Aging Period",
                      items: agingOptions,
                      value: selectedAging,
                      onChanged: (value, label) {
                        selectedAging = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Customer Aging List
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
                      "Customer Aging Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${filteredAgingData.length} customers",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              ...List.generate(filteredAgingData.length, (index) {
                final customer = filteredAgingData[index];
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: index < filteredAgingData.length - 1 
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
                                  "${customer["customer_name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${customer["customer_id"]}",
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
                              color: _getRiskColor(customer["risk_score"] as int).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${_getRiskLevel(customer["risk_score"] as int)} Risk",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getRiskColor(customer["risk_score"] as int),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Total Outstanding: \$${(customer["total_outstanding"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(customer["current"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
                                  "30-60 Days",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(customer["days_30_60"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
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
                                  "60-90 Days",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(customer["days_60_90"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
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
                                  "Over 90 Days",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(customer["days_over_90"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Last Payment: ${customer["last_payment_date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Contact Attempts: ${customer["contact_attempts"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              si("Customer details viewed");
                            },
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            label: "Send Reminder",
                            size: bs.sm,
                            onPressed: () => _sendReminder(customer),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Aging",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.pie_chart)),
        Tab(text: "Details", icon: Icon(Icons.list)),
      ],
      tabChildren: [
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildOverviewTab(),
          ),
        loading ? 
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: _buildDetailsTab(),
          ),
      ],
      actions: [
        IconButton(
          onPressed: _generateAgingReport,
          icon: Icon(Icons.download),
        ),
      ],
    );
  }
}
