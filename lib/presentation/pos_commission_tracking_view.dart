import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCommissionTrackingView extends StatefulWidget {
  const PosCommissionTrackingView({super.key});

  @override
  State<PosCommissionTrackingView> createState() => _PosCommissionTrackingViewState();
}

class _PosCommissionTrackingViewState extends State<PosCommissionTrackingView> {
  String selectedPeriod = "This Month";
  String selectedEmployee = "All Employees";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
  ];

  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "All Employees"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Davis", "value": "mike_davis"},
    {"label": "Emily Wilson", "value": "emily_wilson"},
  ];

  List<Map<String, dynamic>> commissionData = [
    {
      "id": "emp_001",
      "name": "John Smith",
      "position": "Sales Associate",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "totalSales": 15750.0,
      "commissionRate": 3.5,
      "commissionEarned": 551.25,
      "transactionCount": 78,
      "avgTransaction": 201.92,
      "target": 20000.0,
      "achievement": 78.75,
    },
    {
      "id": "emp_002",
      "name": "Sarah Johnson",
      "position": "Senior Sales",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "totalSales": 22100.0,
      "commissionRate": 4.0,
      "commissionEarned": 884.0,
      "transactionCount": 92,
      "avgTransaction": 240.22,
      "target": 25000.0,
      "achievement": 88.4,
    },
    {
      "id": "emp_003",
      "name": "Mike Davis",
      "position": "Sales Manager",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "totalSales": 18900.0,
      "commissionRate": 5.0,
      "commissionEarned": 945.0,
      "transactionCount": 65,
      "avgTransaction": 290.77,
      "target": 30000.0,
      "achievement": 63.0,
    },
    {
      "id": "emp_004",
      "name": "Emily Wilson",
      "position": "Sales Associate",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "totalSales": 12450.0,
      "commissionRate": 3.0,
      "commissionEarned": 373.5,
      "transactionCount": 56,
      "avgTransaction": 222.32,
      "target": 18000.0,
      "achievement": 69.17,
    },
  ];

  Widget _buildCommissionSummary() {
    double totalCommission = commissionData.fold(0.0, (sum, e) => sum + (e["commissionEarned"] as double));
    double totalSales = commissionData.fold(0.0, (sum, e) => sum + (e["totalSales"] as double));
    int totalTransactions = commissionData.fold(0, (sum, e) => sum + (e["transactionCount"] as int));
    double avgCommissionRate = commissionData.fold(0.0, (sum, e) => sum + (e["commissionRate"] as double)) / commissionData.length;

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
          Text(
            "Commission Overview",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.payments,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalCommission.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Commission",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${totalSales.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Sales",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.receipt,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$totalTransactions",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Transactions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.percent,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${avgCommissionRate.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Avg Rate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
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
              label: "Employee",
              items: employeeOptions,
              value: selectedEmployee,
              onChanged: (value, label) {
                selectedEmployee = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformers() {
    List<Map<String, dynamic>> topPerformers = List.from(commissionData);
    topPerformers.sort((a, b) => (b["commissionEarned"] as double).compareTo(a["commissionEarned"] as double));

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
          Text(
            "Top Performers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: topPerformers.take(3).toList().asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> performer = entry.value;
              
              List<Color> colors = [Colors.amber, Colors.grey, Colors.brown];
              List<IconData> icons = [Icons.emoji_events, Icons.military_tech, Icons.star];

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors[index].withAlpha(20),
                      colors[index].withAlpha(5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: colors[index].withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: colors[index],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icons[index],
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${performer["avatar"]}",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${performer["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${performer["position"]}",
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
                          "\$${(performer["commissionEarned"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "${(performer["commissionRate"] as double).toStringAsFixed(1)}% rate",
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
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedCommissionList() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Commission Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {
                  ss("Commission report exported successfully");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: commissionData.map((employee) {
              double achievementPercent = (employee["achievement"] as double);
              Color achievementColor = achievementPercent >= 90 ? successColor : 
                                     achievementPercent >= 70 ? warningColor : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: achievementColor,
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
                            "${employee["avatar"]}",
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
                              Text(
                                "${employee["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${employee["position"]}",
                                style: TextStyle(
                                  fontSize: 14,
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
                              "\$${(employee["commissionEarned"] as double).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "${(employee["commissionRate"] as double).toStringAsFixed(1)}% rate",
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
                                "Sales: \$${(employee["totalSales"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Transactions: ${employee["transactionCount"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                "Avg Transaction: \$${(employee["avgTransaction"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Target Achievement: ${achievementPercent.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: achievementColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (achievementPercent / 100).clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: achievementColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commission Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to commission analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to commission settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCommissionSummary(),
            _buildFilters(),
            _buildTopPerformers(),
            _buildDetailedCommissionList(),
          ],
        ),
      ),
    );
  }
}
