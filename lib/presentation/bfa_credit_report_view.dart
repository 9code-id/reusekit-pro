import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCreditReportView extends StatefulWidget {
  const BfaCreditReportView({super.key});

  @override
  State<BfaCreditReportView> createState() => _BfaCreditReportViewState();
}

class _BfaCreditReportViewState extends State<BfaCreditReportView> {
  int currentTab = 0;
  String selectedReportType = "Full Report";
  
  List<Map<String, dynamic>> reportTypes = [
    {"label": "Full Report", "value": "Full Report"},
    {"label": "Quick Check", "value": "Quick Check"},
    {"label": "Score Only", "value": "Score Only"},
  ];

  List<Map<String, dynamic>> creditData = [
    {
      "title": "Credit Score",
      "value": "785",
      "status": "Excellent",
      "color": successColor,
      "change": "+15",
      "icon": Icons.trending_up,
    },
    {
      "title": "Payment History",
      "value": "98%",
      "status": "Excellent",
      "color": successColor,
      "change": "+2%",
      "icon": Icons.payment,
    },
    {
      "title": "Credit Utilization",
      "value": "18%",
      "status": "Good",
      "color": warningColor,
      "change": "-5%",
      "icon": Icons.credit_card,
    },
    {
      "title": "Account Age",
      "value": "8.5 years",
      "status": "Good",
      "color": successColor,
      "change": "+0.5yr",
      "icon": Icons.history,
    },
  ];

  List<Map<String, dynamic>> accounts = [
    {
      "name": "Chase Freedom",
      "type": "Credit Card",
      "balance": 2450.00,
      "limit": 10000.00,
      "payment_status": "On Time",
      "last_payment": "2024-05-15",
      "status_color": successColor,
    },
    {
      "name": "Bank of America",
      "type": "Credit Card",
      "balance": 1250.00,
      "limit": 5000.00,
      "payment_status": "On Time",
      "last_payment": "2024-05-12",
      "status_color": successColor,
    },
    {
      "name": "Wells Fargo Auto",
      "type": "Auto Loan",
      "balance": 18500.00,
      "limit": 25000.00,
      "payment_status": "30 Days Late",
      "last_payment": "2024-04-15",
      "status_color": warningColor,
    },
    {
      "name": "Capital One",
      "type": "Credit Card",
      "balance": 850.00,
      "limit": 3000.00,
      "payment_status": "On Time",
      "last_payment": "2024-05-18",
      "status_color": successColor,
    },
  ];

  List<Map<String, dynamic>> inquiries = [
    {
      "company": "American Express",
      "type": "Hard Inquiry",
      "date": "2024-04-15",
      "purpose": "Credit Card Application",
      "impact": "Minor",
    },
    {
      "company": "Toyota Financial",
      "type": "Hard Inquiry", 
      "date": "2024-03-22",
      "purpose": "Auto Loan",
      "impact": "Minor",
    },
    {
      "company": "Credit Karma",
      "type": "Soft Inquiry",
      "date": "2024-05-10",
      "purpose": "Credit Monitoring",
      "impact": "None",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Credit Report",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Accounts", icon: Icon(Icons.account_balance)),
        Tab(text: "Inquiries", icon: Icon(Icons.search)),
        Tab(text: "Disputes", icon: Icon(Icons.report_problem)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAccountsTab(),
        _buildInquiriesTab(),
        _buildDisputesTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "785",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Excellent Credit Score",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "+15 points this month",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          QDropdownField(
            label: "Report Type",
            items: reportTypes,
            value: selectedReportType,
            onChanged: (value, label) {
              selectedReportType = value;
              setState(() {});
            },
          ),

          Text(
            "Credit Factors",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: creditData.map((factor) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (factor["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            factor["icon"] as IconData,
                            color: factor["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${factor["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${factor["value"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (factor["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${factor["change"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: factor["color"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${factor["status"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: factor["color"] as Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.info_outline,
                  color: infoColor,
                  size: 24,
                ),
                Text(
                  "Credit Report Tips",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Check your credit report regularly for errors and unauthorized accounts. Dispute any inaccuracies immediately to maintain your credit health.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Download Full Report",
              icon: Icons.download,
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Credit Accounts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${accounts.length} Accounts",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          ...accounts.map((account) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: account["status_color"] as Color,
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${account["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${account["type"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (account["status_color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${account["payment_status"]}",
                          style: TextStyle(
                            color: account["status_color"] as Color,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
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
                              "Balance",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${((account["balance"] as double)).currency}",
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
                              "Limit",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${((account["limit"] as double)).currency}",
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
                              "Utilization",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${(((account["balance"] as double) / (account["limit"] as double)) * 100).toStringAsFixed(1)}%",
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

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Last Payment: ${account["last_payment"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInquiriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Credit Inquiries",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: warningColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.warning_amber,
                  color: warningColor,
                  size: 24,
                ),
                Text(
                  "About Credit Inquiries",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Hard inquiries can temporarily lower your credit score. Soft inquiries don't affect your score but show who has checked your credit.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          ...inquiries.map((inquiry) {
            bool isHardInquiry = inquiry["type"] == "Hard Inquiry";
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: isHardInquiry ? warningColor : infoColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${inquiry["company"]}",
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
                          color: isHardInquiry ? warningColor.withAlpha(20) : infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${inquiry["type"]}",
                          style: TextStyle(
                            color: isHardInquiry ? warningColor : infoColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
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
                              "Purpose",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${inquiry["purpose"]}",
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
                              "Date",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${inquiry["date"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isHardInquiry ? Icons.trending_down : Icons.info_outline,
                          size: 16,
                          color: isHardInquiry ? warningColor : infoColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Impact: ${inquiry["impact"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDisputesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dispute Center",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: successColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
              Icon(
                Icons.check_circle_outline,
                color: successColor,
                size: 24,
              ),
              Text(
                "No Active Disputes",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "You currently have no active disputes. If you find any errors in your credit report, you can file a dispute here.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              Icon(
                Icons.report_problem_outlined,
                color: primaryColor,
                size: 32,
              ),
              Text(
                "File a Dispute",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "If you notice any errors or unauthorized accounts on your credit report, you can dispute them directly through our secure system.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Start New Dispute",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: infoColor.withAlpha(60)),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Text(
                "Dispute Process Timeline",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: infoColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Submit dispute within 30 days of error discovery",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: infoColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Credit bureau has 30 days to investigate",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: infoColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Receive results and updated credit report",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
