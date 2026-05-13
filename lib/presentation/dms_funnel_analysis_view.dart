import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsFunnelAnalysisView extends StatefulWidget {
  const DmsFunnelAnalysisView({super.key});

  @override
  State<DmsFunnelAnalysisView> createState() => _DmsFunnelAnalysisViewState();
}

class _DmsFunnelAnalysisViewState extends State<DmsFunnelAnalysisView> {
  int currentTab = 0;
  String selectedTimeframe = "Last 30 Days";
  String selectedFunnel = "E-commerce Funnel";
  String selectedSegment = "All Users";
  bool showDropoffAnalysis = true;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> funnelOptions = [
    {"label": "E-commerce Funnel", "value": "E-commerce Funnel"},
    {"label": "Lead Generation", "value": "Lead Generation"},
    {"label": "Content Engagement", "value": "Content Engagement"},
    {"label": "Subscription Flow", "value": "Subscription Flow"},
  ];

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "All Users", "value": "All Users"},
    {"label": "New Users", "value": "New Users"},
    {"label": "Returning Users", "value": "Returning Users"},
    {"label": "Mobile Users", "value": "Mobile Users"},
    {"label": "Desktop Users", "value": "Desktop Users"},
  ];

  List<Map<String, dynamic>> funnelMetrics = [
    {
      "title": "Funnel Conversion Rate",
      "value": 18.5,
      "change": 2.3,
      "icon": Icons.trending_up,
      "color": primaryColor,
      "suffix": "%",
    },
    {
      "title": "Total Entries",
      "value": 12450,
      "change": 15.7,
      "icon": Icons.input,
      "color": infoColor,
    },
    {
      "title": "Completions",
      "value": 2303,
      "change": 8.9,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Drop-off Rate",
      "value": 81.5,
      "change": -2.3,
      "icon": Icons.trending_down,
      "color": dangerColor,
      "suffix": "%",
    },
  ];

  List<Map<String, dynamic>> funnelSteps = [
    {
      "step": 1,
      "name": "Landing Page View",
      "description": "Users land on product page",
      "users": 12450,
      "conversion_rate": 100.0,
      "drop_off": 0.0,
      "avg_time": "0:00",
      "color": primaryColor,
    },
    {
      "step": 2,
      "name": "Product Interest",
      "description": "Users view product details or add to cart",
      "users": 8715,
      "conversion_rate": 70.0,
      "drop_off": 30.0,
      "avg_time": "2:45",
      "color": infoColor,
    },
    {
      "step": 3,
      "name": "Cart Addition",
      "description": "Users add item to shopping cart",
      "users": 4980,
      "conversion_rate": 40.0,
      "drop_off": 60.0,
      "avg_time": "4:32",
      "color": warningColor,
    },
    {
      "step": 4,
      "name": "Checkout Started",
      "description": "Users begin checkout process",
      "users": 3485,
      "conversion_rate": 28.0,
      "drop_off": 72.0,
      "avg_time": "6:15",
      "color": dangerColor,
    },
    {
      "step": 5,
      "name": "Payment Info",
      "description": "Users enter payment information",
      "users": 2678,
      "conversion_rate": 21.5,
      "drop_off": 78.5,
      "avg_time": "8:22",
      "color": disabledBoldColor,
    },
    {
      "step": 6,
      "name": "Purchase Complete",
      "description": "Successful transaction completion",
      "users": 2303,
      "conversion_rate": 18.5,
      "drop_off": 81.5,
      "avg_time": "10:45",
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> dropoffAnalysis = [
    {
      "from_step": "Landing Page View",
      "to_step": "Product Interest", 
      "drop_off_rate": 30.0,
      "users_lost": 3735,
      "primary_reasons": ["Page load speed", "Irrelevant content", "Poor design"],
      "improvement_potential": "High",
      "recommended_actions": ["Optimize page speed", "Improve content relevance", "A/B test new design"],
    },
    {
      "from_step": "Product Interest",
      "to_step": "Cart Addition",
      "drop_off_rate": 42.9,
      "users_lost": 3735,
      "primary_reasons": ["Price concerns", "Lack of trust signals", "Complex process"],
      "improvement_potential": "Medium",
      "recommended_actions": ["Add testimonials", "Simplify cart process", "Show security badges"],
    },
    {
      "from_step": "Cart Addition",
      "to_step": "Checkout Started", 
      "drop_off_rate": 30.0,
      "users_lost": 1495,
      "primary_reasons": ["Unexpected shipping costs", "Account creation requirement", "Complex checkout"],
      "improvement_potential": "High",
      "recommended_actions": ["Show shipping costs early", "Allow guest checkout", "Simplify form"],
    },
    {
      "from_step": "Checkout Started",
      "to_step": "Payment Info",
      "drop_off_rate": 23.2,
      "users_lost": 807,
      "primary_reasons": ["Security concerns", "Payment method unavailable", "Form errors"],
      "improvement_potential": "Medium",
      "recommended_actions": ["Add security badges", "More payment options", "Better form validation"],
    },
  ];

  List<Map<String, dynamic>> segmentComparison = [
    {
      "segment": "New Users",
      "total_users": 7470,
      "completions": 1382,
      "conversion_rate": 18.5,
      "avg_completion_time": "12:34",
      "top_drop_off": "Cart Addition",
    },
    {
      "segment": "Returning Users", 
      "total_users": 4980,
      "completions": 921,
      "conversion_rate": 18.5,
      "avg_completion_time": "8:45",
      "top_drop_off": "Payment Info",
    },
    {
      "segment": "Mobile Users",
      "total_users": 8715,
      "completions": 1612,
      "conversion_rate": 18.5,
      "avg_completion_time": "15:22",
      "top_drop_off": "Checkout Started",
    },
    {
      "segment": "Desktop Users",
      "total_users": 3735,
      "completions": 691,
      "conversion_rate": 18.5,
      "avg_completion_time": "9:12",
      "top_drop_off": "Product Interest",
    },
  ];

  Widget _buildFunnelOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframeOptions,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Funnel",
                  items: funnelOptions,
                  value: selectedFunnel,
                  onChanged: (value, label) {
                    selectedFunnel = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Metrics Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: funnelMetrics.map((metric) {
              return Container(
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (metric["change"] as double) >= 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      metric["title"] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${metric["value"]}${metric["suffix"] ?? ''}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Funnel Visualization
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
                  "Funnel Visualization",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...funnelSteps.map((step) {
                  double stepWidth = (step["conversion_rate"] as double) / 100;
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: step["color"] as Color,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${step["step"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step["name"] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    step["description"] as String,
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
                                  "${step["users"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(step["conversion_rate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: step["color"] as Color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: stepWidth,
                            child: Container(
                              decoration: BoxDecoration(
                                color: step["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                        if ((step["step"] as int) < funnelSteps.length)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: spSm),
                            child: Row(
                              children: [
                                SizedBox(width: 45),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(step["drop_off"] as double).toStringAsFixed(1)}% drop-off",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
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
          ),
        ],
      ),
    );
  }

  Widget _buildDropoffAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Toggle Switch
          QSwitch(
            items: [
              {
                "label": "Show Drop-off Analysis",
                "value": true,
                "checked": showDropoffAnalysis,
              }
            ],
            value: [
              if (showDropoffAnalysis)
                {
                  "label": "Show Drop-off Analysis",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              showDropoffAnalysis = values.isNotEmpty;
              setState(() {});
            },
          ),

          if (showDropoffAnalysis)
            ...dropoffAnalysis.map((analysis) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: dangerColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trending_down,
                          color: dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${analysis["from_step"]} → ${analysis["to_step"]}",
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
                            color: analysis["improvement_potential"] == "High"
                                ? dangerColor.withAlpha(20)
                                : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${analysis["improvement_potential"]} Impact",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: analysis["improvement_potential"] == "High"
                                  ? dangerColor
                                  : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Drop-off Rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(analysis["drop_off_rate"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
                                "Users Lost",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${analysis["users_lost"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Primary Reasons
                    Text(
                      "Primary Reasons",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(analysis["primary_reasons"] as List).map((reason) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          reason as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      );
                    }).toList(),
                    
                    SizedBox(height: spMd),
                    
                    // Recommended Actions
                    Text(
                      "Recommended Actions",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(analysis["recommended_actions"] as List).map((action) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                action as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildSegmentComparisonTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Segment Filter
          QDropdownField(
            label: "Compare Segments",
            items: segmentOptions,
            value: selectedSegment,
            onChanged: (value, label) {
              selectedSegment = value;
              setState(() {});
            },
          ),

          // Segment Comparison Cards
          ...segmentComparison.map((segment) {
            return Container(
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
                      Expanded(
                        child: Text(
                          segment["segment"] as String,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${(segment["conversion_rate"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Users",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${segment["total_users"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Completions",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${segment["completions"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avg Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            segment["avg_completion_time"] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top Drop-off",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            segment["top_drop_off"] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Funnel Analysis",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.timeline)),
        Tab(text: "Drop-offs", icon: Icon(Icons.trending_down)),
        Tab(text: "Segments", icon: Icon(Icons.group)),
      ],
      tabChildren: [
        _buildFunnelOverviewTab(),
        _buildDropoffAnalysisTab(),
        _buildSegmentComparisonTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
