import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaRevenueReportView extends StatefulWidget {
  const DlaRevenueReportView({super.key});

  @override
  State<DlaRevenueReportView> createState() => _DlaRevenueReportViewState();
}

class _DlaRevenueReportViewState extends State<DlaRevenueReportView> {
  String selectedPeriod = "monthly";
  String selectedCategory = "all";
  
  final List<Map<String, dynamic>> periodOptions = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  final List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Services", "value": "all"},
    {"label": "Express Delivery", "value": "express"},
    {"label": "Standard Delivery", "value": "standard"},
    {"label": "Warehouse Services", "value": "warehouse"},
    {"label": "Logistics Consulting", "value": "consulting"},
  ];

  final List<Map<String, dynamic>> revenueData = [
    {
      "month": "January",
      "revenue": 125000.0,
      "target": 120000.0,
      "growth": 8.5,
    },
    {
      "month": "February", 
      "revenue": 138500.0,
      "target": 125000.0,
      "growth": 10.8,
    },
    {
      "month": "March",
      "revenue": 142300.0,
      "target": 130000.0,
      "growth": 9.5,
    },
    {
      "month": "April",
      "revenue": 155800.0,
      "target": 135000.0,
      "growth": 15.4,
    },
    {
      "month": "May",
      "revenue": 168200.0,
      "target": 140000.0,
      "growth": 20.1,
    },
    {
      "month": "June",
      "revenue": 175600.0,
      "target": 145000.0,
      "growth": 21.1,
    },
  ];

  final List<Map<String, dynamic>> serviceBreakdown = [
    {
      "service": "Express Delivery",
      "revenue": 485200.0,
      "percentage": 42.5,
      "color": primaryColor,
    },
    {
      "service": "Standard Delivery",
      "revenue": 352800.0,
      "percentage": 30.9,
      "color": secondaryColor,
    },
    {
      "service": "Warehouse Services",
      "revenue": 189600.0,
      "percentage": 16.6,
      "color": successColor,
    },
    {
      "service": "Logistics Consulting",
      "revenue": 114400.0,
      "percentage": 10.0,
      "color": warningColor,
    },
  ];

  final Map<String, dynamic> summaryData = {
    "total_revenue": 1142000.0,
    "monthly_growth": 12.8,
    "target_achievement": 108.5,
    "average_order_value": 245.60,
    "total_orders": 4650,
    "recurring_revenue": 687500.0,
  };

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Revenue Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
                  label: "Service Category",
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
    );
  }

  Widget _buildRevenueSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Revenue Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Revenue",
                "\$${(summaryData["total_revenue"] as double).currency}",
                Icons.trending_up,
                successColor,
              ),
              _buildSummaryCard(
                "Monthly Growth",
                "${(summaryData["monthly_growth"] as double).toStringAsFixed(1)}%",
                Icons.show_chart,
                primaryColor,
              ),
              _buildSummaryCard(
                "Target Achievement",
                "${(summaryData["target_achievement"] as double).toStringAsFixed(1)}%",
                Icons.flag,
                warningColor,
              ),
              _buildSummaryCard(
                "Avg Order Value",
                "\$${(summaryData["average_order_value"] as double).currency}",
                Icons.receipt,
                infoColor,
              ),
              _buildSummaryCard(
                "Total Orders",
                "${summaryData["total_orders"]}",
                Icons.shopping_cart,
                secondaryColor,
              ),
              _buildSummaryCard(
                "Recurring Revenue",
                "\$${(summaryData["recurring_revenue"] as double).currency}",
                Icons.autorenew,
                successColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Monthly Revenue Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 250,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: revenueData.length,
                    itemBuilder: (context, index) {
                      final item = revenueData[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                "${item["month"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: (item["revenue"] as double) / 200000,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: (item["revenue"] as double) >= (item["target"] as double) 
                                          ? successColor 
                                          : primaryColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            SizedBox(
                              width: 80,
                              child: Text(
                                "\$${((item["revenue"] as double) / 1000).toStringAsFixed(0)}K",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            SizedBox(
                              width: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    (item["growth"] as double) > 0 ? Icons.trending_up : Icons.trending_down,
                                    size: 14,
                                    color: (item["growth"] as double) > 0 ? successColor : dangerColor,
                                  ),
                                  Text(
                                    "${(item["growth"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: (item["growth"] as double) > 0 ? successColor : dangerColor,
                                    ),
                                  ),
                                ],
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
        ],
      ),
    );
  }

  Widget _buildServiceBreakdown() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Revenue by Service",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...serviceBreakdown.map((service) => Container(
            padding: EdgeInsets.all(spSm),
            margin: EdgeInsets.only(bottom: spSm),
            decoration: BoxDecoration(
              color: (service["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: service["color"] as Color,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${service["service"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${(service["percentage"] as double).toStringAsFixed(1)}% of total revenue",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${((service["revenue"] as double) / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: service["color"] as Color,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildReportActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Export Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Export PDF",
                  icon: Icons.picture_as_pdf,
                  size: bs.sm,
                  onPressed: () {
                    si("Exporting revenue report as PDF");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Export Excel",
                  icon: Icons.table_chart,
                  size: bs.sm,
                  onPressed: () {
                    si("Exporting revenue data to Excel");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Send Report",
                  icon: Icons.send,
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Sending revenue report via email");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Revenue Report"),
        actions: [
          QButton(
            icon: Icons.calendar_today,
            size: bs.sm,
            onPressed: () {
              si("Setting custom date range");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilters(),
            _buildRevenueSummary(),
            _buildRevenueChart(),
            _buildServiceBreakdown(),
            _buildReportActions(),
          ],
        ),
      ),
    );
  }
}
