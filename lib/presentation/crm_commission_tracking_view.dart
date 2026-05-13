import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCommissionTrackingView extends StatefulWidget {
  const CrmCommissionTrackingView({super.key});

  @override
  State<CrmCommissionTrackingView> createState() => _CrmCommissionTrackingViewState();
}

class _CrmCommissionTrackingViewState extends State<CrmCommissionTrackingView> {
  String selectedPeriod = "This Month";
  String selectedAgent = "All Agents";
  String searchQuery = "";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];
  
  List<Map<String, dynamic>> agentOptions = [
    {"label": "All Agents", "value": "All Agents"},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Mike Chen", "value": "Mike Chen"},
    {"label": "Emily Davis", "value": "Emily Davis"},
  ];
  
  List<Map<String, dynamic>> commissionData = [
    {
      "agentName": "Sarah Johnson",
      "agentId": "AG001",
      "salesCount": 45,
      "totalSales": 125000.0,
      "commissionRate": 8.5,
      "grossCommission": 10625.0,
      "deductions": 200.0,
      "netCommission": 10425.0,
      "status": "Approved",
      "paymentDate": "2024-12-15",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
    },
    {
      "agentName": "Mike Chen",
      "agentId": "AG002",
      "salesCount": 38,
      "totalSales": 95000.0,
      "commissionRate": 7.0,
      "grossCommission": 6650.0,
      "deductions": 150.0,
      "netCommission": 6500.0,
      "status": "Pending",
      "paymentDate": "2024-12-15",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
    },
    {
      "agentName": "Emily Davis",
      "agentId": "AG003",
      "salesCount": 52,
      "totalSales": 140000.0,
      "commissionRate": 9.0,
      "grossCommission": 12600.0,
      "deductions": 300.0,
      "netCommission": 12300.0,
      "status": "Paid",
      "paymentDate": "2024-12-01",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
    },
    {
      "agentName": "David Wilson",
      "agentId": "AG004",
      "salesCount": 29,
      "totalSales": 78000.0,
      "commissionRate": 6.5,
      "grossCommission": 5070.0,
      "deductions": 100.0,
      "netCommission": 4970.0,
      "status": "Approved",
      "paymentDate": "2024-12-15",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
    },
  ];

  List<Map<String, dynamic>> get filteredCommissions {
    List<Map<String, dynamic>> filtered = commissionData;
    
    if (selectedAgent != "All Agents") {
      filtered = filtered.where((commission) => commission["agentName"] == selectedAgent).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((commission) =>
        (commission["agentName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (commission["agentId"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    return filtered;
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Approved":
        return infoColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalCommissions = filteredCommissions.fold(0.0, (sum, item) => sum + (item["netCommission"] as double));
    double totalSales = filteredCommissions.fold(0.0, (sum, item) => sum + (item["totalSales"] as double));
    int totalTransactions = filteredCommissions.fold(0, (sum, item) => sum + (item["salesCount"] as int));
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Commission Tracking"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Commission report exported successfully");
            },
          ),
          SizedBox(width: spSm),
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
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                          label: "Agent",
                          items: agentOptions,
                          value: selectedAgent,
                          onChanged: (value, label) {
                            selectedAgent = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Search Agent",
                    value: searchQuery,
                    hint: "Search by name or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.attach_money, color: primaryColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Commissions",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${totalCommissions.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.trending_up, color: successColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Sales",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${totalSales.currency}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.receipt_long, color: infoColor, size: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Transactions",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$totalTransactions",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Commission List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.people, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Agent Commissions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredCommissions.length} agents",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredCommissions.length,
                    itemBuilder: (context, index) {
                      final commission = filteredCommissions[index];
                      final statusColor = _getStatusColor(commission["status"]);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor.withAlpha(100),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${commission["avatar"]}",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${commission["agentName"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: statusColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${commission["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: statusColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "ID: ${commission["agentId"]} • ${commission["salesCount"]} sales",
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
                                      "\$${(commission["netCommission"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${(commission["commissionRate"] as double).toStringAsFixed(1)}% rate",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Sales",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(commission["totalSales"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
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
                                        "Gross Commission",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(commission["grossCommission"] as double).currency}",
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
                                        "Payment Date",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${commission["paymentDate"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if ((commission["deductions"] as double) > 0) ...[
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.remove_circle_outline, color: warningColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Deductions: \$${(commission["deductions"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
