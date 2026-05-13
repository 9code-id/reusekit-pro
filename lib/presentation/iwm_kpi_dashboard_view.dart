import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmKpiDashboardView extends StatefulWidget {
  const IwmKpiDashboardView({super.key});

  @override
  State<IwmKpiDashboardView> createState() => _IwmKpiDashboardViewState();
}

class _IwmKpiDashboardViewState extends State<IwmKpiDashboardView> {
  String selectedPeriod = "This Month";
  String selectedKpiCategory = "All KPIs";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> kpiCategoryItems = [
    {"label": "All KPIs", "value": "All KPIs"},
    {"label": "Financial", "value": "Financial"},
    {"label": "Operational", "value": "Operational"},
    {"label": "Quality", "value": "Quality"},
    {"label": "Customer", "value": "Customer"},
  ];

  List<Map<String, dynamic>> primaryKpis = [
    {
      "title": "Inventory Turnover",
      "value": 8.5,
      "target": 8.0,
      "unit": "x",
      "change": 6.25,
      "trend": "up",
      "icon": Icons.refresh,
      "color": primaryColor,
      "category": "Financial",
      "description": "Times inventory sold per year",
    },
    {
      "title": "Fill Rate",
      "value": 98.2,
      "target": 95.0,
      "unit": "%",
      "change": 3.4,
      "trend": "up",
      "icon": Icons.check_circle,
      "color": successColor,
      "category": "Operational",
      "description": "Orders fulfilled completely",
    },
    {
      "title": "Carrying Cost",
      "value": 18.5,
      "target": 20.0,
      "unit": "%",
      "change": -7.5,
      "trend": "down",
      "icon": Icons.account_balance_wallet,
      "color": warningColor,
      "category": "Financial",
      "description": "Annual holding cost percentage",
    },
    {
      "title": "Order Accuracy",
      "value": 99.1,
      "target": 98.0,
      "unit": "%",
      "change": 1.1,
      "trend": "up",
      "icon": Icons.verified,
      "color": infoColor,
      "category": "Quality",
      "description": "Orders shipped without errors",
    },
  ];

  List<Map<String, dynamic>> operationalKpis = [
    {
      "title": "Average Lead Time",
      "value": 3.2,
      "target": 4.0,
      "unit": "days",
      "change": -20.0,
      "trend": "down",
      "icon": Icons.schedule,
      "color": successColor,
      "category": "Operational",
      "description": "Time from order to delivery",
    },
    {
      "title": "Warehouse Utilization",
      "value": 82.5,
      "target": 85.0,
      "unit": "%",
      "change": 2.5,
      "trend": "up",
      "icon": Icons.warehouse,
      "color": warningColor,
      "category": "Operational",
      "description": "Storage space utilization",
    },
    {
      "title": "Pick Accuracy",
      "value": 99.5,
      "target": 99.0,
      "unit": "%",
      "change": 0.5,
      "trend": "up",
      "icon": Icons.assignment_turned_in,
      "color": primaryColor,
      "category": "Quality",
      "description": "Correct items picked",
    },
    {
      "title": "Damage Rate",
      "value": 0.8,
      "target": 1.0,
      "unit": "%",
      "change": -20.0,
      "trend": "down",
      "icon": Icons.broken_image,
      "color": dangerColor,
      "category": "Quality",
      "description": "Percentage of damaged goods",
    },
    {
      "title": "Cost Per Shipment",
      "value": 15.25,
      "target": 18.00,
      "unit": "\$",
      "change": -15.3,
      "trend": "down",
      "icon": Icons.local_shipping,
      "color": infoColor,
      "category": "Financial",
      "description": "Average shipping cost",
    },
    {
      "title": "Return Rate",
      "value": 2.1,
      "target": 3.0,
      "unit": "%",
      "change": -30.0,
      "trend": "down",
      "icon": Icons.keyboard_return,
      "color": successColor,
      "category": "Customer",
      "description": "Products returned by customers",
    },
  ];

  List<Map<String, dynamic>> kpiTargets = [
    {
      "kpi": "Inventory Turnover",
      "current": 8.5,
      "target": 8.0,
      "stretch": 10.0,
      "status": "Exceeded",
    },
    {
      "kpi": "Fill Rate",
      "current": 98.2,
      "target": 95.0,
      "stretch": 99.5,
      "status": "Exceeded",
    },
    {
      "kpi": "Order Accuracy",
      "current": 99.1,
      "target": 98.0,
      "stretch": 99.8,
      "status": "Exceeded",
    },
    {
      "kpi": "Average Lead Time",
      "current": 3.2,
      "target": 4.0,
      "stretch": 2.5,
      "status": "Met",
    },
    {
      "kpi": "Warehouse Utilization",
      "current": 82.5,
      "target": 85.0,
      "stretch": 90.0,
      "status": "Below Target",
    },
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "type": "Warning",
      "message": "Warehouse utilization below target (82.5% vs 85%)",
      "severity": "Medium",
      "timestamp": "2024-06-19 14:30",
    },
    {
      "type": "Success",
      "message": "Fill rate exceeded target for 3 consecutive weeks",
      "severity": "Low",
      "timestamp": "2024-06-19 09:15",
    },
    {
      "type": "Critical",
      "message": "Safety stock levels critical for 5 items",
      "severity": "High",
      "timestamp": "2024-06-19 08:45",
    },
  ];

  Widget _buildKpiCard(Map<String, dynamic> kpi, {bool isLarge = false}) {
    bool exceededTarget = kpi["unit"] == "days" || kpi["unit"] == "%" && kpi["title"].contains("Cost") || kpi["title"].contains("Damage") || kpi["title"].contains("Return") || kpi["title"].contains("Lead")
        ? kpi["value"] <= kpi["target"]
        : kpi["value"] >= kpi["target"];

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
                padding: EdgeInsets.all(isLarge ? spMd : spSm),
                decoration: BoxDecoration(
                  color: (kpi["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  kpi["icon"],
                  color: kpi["color"] as Color,
                  size: isLarge ? 32 : 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: exceededTarget 
                      ? successColor.withAlpha(25)
                      : warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  exceededTarget ? "Target Met" : "Below Target",
                  style: TextStyle(
                    fontSize: 10,
                    color: exceededTarget ? successColor : warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${kpi["value"]}",
                style: TextStyle(
                  fontSize: isLarge ? 28 : 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${kpi["unit"]}",
                style: TextStyle(
                  fontSize: isLarge ? 18 : 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: kpi["trend"] == "up" 
                      ? successColor.withAlpha(25)
                      : dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      kpi["trend"] == "up" 
                          ? Icons.trending_up 
                          : Icons.trending_down,
                      size: 12,
                      color: kpi["trend"] == "up" 
                          ? successColor 
                          : dangerColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${(kpi["change"] as num).abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: kpi["trend"] == "up" 
                            ? successColor 
                            : dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${kpi["title"]}",
            style: TextStyle(
              fontSize: isLarge ? 16 : 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          if (isLarge) ...[
            SizedBox(height: spXs),
            Text(
              "${kpi["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "Target: ${kpi["target"]}${kpi["unit"]}",
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

  Widget _buildTargetCard(Map<String, dynamic> target) {
    Color statusColor = target["status"] == "Exceeded"
        ? successColor
        : target["status"] == "Met"
            ? primaryColor
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${target["kpi"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${target["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                      "Current: ${target["current"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Target: ${target["target"]}",
                      style: TextStyle(
                        fontSize: 13,
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
                    "Stretch: ${target["stretch"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${((target["current"] / target["target"] * 100)).toStringAsFixed(0)}% of target",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    Color alertColor = alert["severity"] == "High"
        ? dangerColor
        : alert["severity"] == "Medium"
            ? warningColor
            : successColor;

    IconData alertIcon = alert["type"] == "Critical"
        ? Icons.error
        : alert["type"] == "Warning"
            ? Icons.warning
            : Icons.check_circle;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: alertColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(alertIcon, color: alertColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["message"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${alert["timestamp"]}",
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
              color: alertColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${alert["severity"]}",
              style: TextStyle(
                fontSize: 11,
                color: alertColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "KPI Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Detailed", icon: Icon(Icons.analytics)),
        Tab(text: "Targets", icon: Icon(Icons.flag)),
        Tab(text: "Alerts", icon: Icon(Icons.notifications)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Period",
                      items: periodItems,
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
                      label: "KPI Category",
                      items: kpiCategoryItems,
                      value: selectedKpiCategory,
                      onChanged: (value, label) {
                        selectedKpiCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Primary KPIs
              ResponsiveGridView(
                padding: EdgeInsets.all(0),
                minItemWidth: 200,
                children: primaryKpis
                    .where((kpi) => selectedKpiCategory == "All KPIs" || kpi["category"] == selectedKpiCategory)
                    .map((kpi) => _buildKpiCard(kpi, isLarge: true))
                    .toList(),
              ),

              // Performance Overview
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
                      "Performance Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      padding: EdgeInsets.all(0),
                      minItemWidth: 200,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(12),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "12",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "KPIs Above Target",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(12),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "3",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "KPIs Below Target",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(12),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "85%",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Overall Score",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
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

        // Detailed Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detailed KPIs",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                  ],
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.all(0),
                minItemWidth: 200,
                children: operationalKpis
                    .where((kpi) => selectedKpiCategory == "All KPIs" || kpi["category"] == selectedKpiCategory)
                    .map((kpi) => _buildKpiCard(kpi))
                    .toList(),
              ),
            ],
          ),
        ),

        // Targets Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "KPI Targets & Achievement",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...kpiTargets.map((target) => _buildTargetCard(target)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Alerts Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "KPI Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Mark All Read",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...alerts.map((alert) => _buildAlertCard(alert)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
