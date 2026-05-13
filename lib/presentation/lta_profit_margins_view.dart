import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaProfitMarginsView extends StatefulWidget {
  const LtaProfitMarginsView({super.key});

  @override
  State<LtaProfitMarginsView> createState() => _LtaProfitMarginsViewState();
}

class _LtaProfitMarginsViewState extends State<LtaProfitMarginsView> {
  String selectedPeriod = "monthly";
  String selectedService = "all";
  
  List<Map<String, dynamic>> periods = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];
  
  List<Map<String, dynamic>> services = [
    {"label": "All Services", "value": "all"},
    {"label": "Standard Delivery", "value": "standard"},
    {"label": "Express Delivery", "value": "express"},
    {"label": "Premium Service", "value": "premium"},
  ];
  
  Map<String, dynamic> profitData = {
    "totalRevenue": 125000.0,
    "totalCosts": 87500.0,
    "grossProfit": 37500.0,
    "profitMargin": 30.0,
    "previousPeriod": {
      "revenue": 118000.0,
      "costs": 84000.0,
      "profit": 34000.0,
      "margin": 28.8,
    },
  };
  
  List<Map<String, dynamic>> serviceBreakdown = [
    {
      "service": "Standard Delivery",
      "revenue": 65000.0,
      "costs": 42250.0,
      "profit": 22750.0,
      "margin": 35.0,
      "volume": 1250,
    },
    {
      "service": "Express Delivery",
      "revenue": 45000.0,
      "costs": 31500.0,
      "profit": 13500.0,
      "margin": 30.0,
      "volume": 750,
    },
    {
      "service": "Premium Service",
      "revenue": 15000.0,
      "costs": 13750.0,
      "profit": 1250.0,
      "margin": 8.3,
      "volume": 125,
    },
  ];
  
  List<Map<String, dynamic>> costBreakdown = [
    {
      "category": "Transportation",
      "amount": 35000.0,
      "percentage": 40.0,
    },
    {
      "category": "Fuel & Maintenance",
      "amount": 17500.0,
      "percentage": 20.0,
    },
    {
      "category": "Labor Costs",
      "amount": 21000.0,
      "percentage": 24.0,
    },
    {
      "category": "Insurance",
      "amount": 8750.0,
      "percentage": 10.0,
    },
    {
      "category": "Administrative",
      "amount": 5250.0,
      "percentage": 6.0,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profit Margins"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilterSection(),
            _buildOverviewCards(),
            _buildProfitChart(),
            _buildServiceBreakdown(),
            _buildCostAnalysis(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QDropdownField(
              label: "Period",
              items: periods,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: QDropdownField(
              label: "Service Type",
              items: services,
              value: selectedService,
              onChanged: (value, label) {
                selectedService = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOverviewCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 200,
      children: [
        _buildMetricCard(
          "Total Revenue",
          "\$${(profitData["totalRevenue"] as double).currency}",
          Icons.trending_up,
          primaryColor,
          "+5.9%",
          true,
        ),
        _buildMetricCard(
          "Total Costs",
          "\$${(profitData["totalCosts"] as double).currency}",
          Icons.trending_down,
          warningColor,
          "+4.2%",
          false,
        ),
        _buildMetricCard(
          "Gross Profit",
          "\$${(profitData["grossProfit"] as double).currency}",
          Icons.account_balance_wallet,
          successColor,
          "+10.3%",
          true,
        ),
        _buildMetricCard(
          "Profit Margin",
          "${(profitData["profitMargin"] as double).toStringAsFixed(1)}%",
          Icons.pie_chart,
          infoColor,
          "+1.2%",
          true,
        ),
      ],
    );
  }
  
  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change, bool isPositive) {
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
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? successColor : dangerColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? successColor : dangerColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "vs last period",
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
  
  Widget _buildProfitChart() {
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
            "Profit Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 60,
                    color: primaryColor.withAlpha(150),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Profit Trend Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Interactive chart showing profit trends over time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
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
            "Service Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(serviceBreakdown.length, (index) {
            final service = serviceBreakdown[index];
            return _buildServiceItem(service);
          }),
        ],
      ),
    );
  }
  
  Widget _buildServiceItem(Map<String, dynamic> service) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${service["service"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(service["margin"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildServiceMetric(
                  "Revenue",
                  "\$${(service["revenue"] as double).currency}",
                ),
              ),
              Expanded(
                child: _buildServiceMetric(
                  "Costs",
                  "\$${(service["costs"] as double).currency}",
                ),
              ),
              Expanded(
                child: _buildServiceMetric(
                  "Profit",
                  "\$${(service["profit"] as double).currency}",
                ),
              ),
              Expanded(
                child: _buildServiceMetric(
                  "Volume",
                  "${service["volume"]}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildServiceMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCostAnalysis() {
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
            "Cost Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(costBreakdown.length, (index) {
            final cost = costBreakdown[index];
            return _buildCostItem(cost);
          }),
        ],
      ),
    );
  }
  
  Widget _buildCostItem(Map<String, dynamic> cost) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cost["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 4,
                  margin: EdgeInsets.only(top: spXs),
                  decoration: BoxDecoration(
                    color: disabledOutlineBorderColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (cost["percentage"] as double) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
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
                "\$${(cost["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(cost["percentage"] as double).toStringAsFixed(1)}%",
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
}
