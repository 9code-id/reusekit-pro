import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaGrowthChartView extends StatefulWidget {
  const HcaGrowthChartView({super.key});

  @override
  State<HcaGrowthChartView> createState() => _HcaGrowthChartViewState();
}

class _HcaGrowthChartViewState extends State<HcaGrowthChartView> {
  String selectedChild = "Emma (5 years)";
  String selectedMetric = "Height";
  String selectedPeriod = "1 Year";
  
  List<Map<String, dynamic>> children = [
    {"label": "Emma (5 years)", "value": "emma", "age": 5},
    {"label": "Oliver (8 years)", "value": "oliver", "age": 8},
    {"label": "Sophia (3 years)", "value": "sophia", "age": 3},
  ];
  
  List<Map<String, dynamic>> metrics = [
    {"label": "Height", "value": "height"},
    {"label": "Weight", "value": "weight"},
    {"label": "BMI", "value": "bmi"},
    {"label": "Head Circumference", "value": "head"},
  ];
  
  List<Map<String, dynamic>> periods = [
    {"label": "6 Months", "value": "6m"},
    {"label": "1 Year", "value": "1y"},
    {"label": "2 Years", "value": "2y"},
    {"label": "All Time", "value": "all"},
  ];
  
  List<Map<String, dynamic>> growthData = [
    {"date": "Jan 2024", "height": 105, "weight": 18.5, "percentile": 65},
    {"date": "Mar 2024", "height": 107, "weight": 19.1, "percentile": 67},
    {"date": "Jun 2024", "height": 109, "weight": 19.8, "percentile": 70},
    {"date": "Sep 2024", "height": 111, "weight": 20.3, "percentile": 72},
    {"date": "Dec 2024", "height": 113, "weight": 20.9, "percentile": 75},
  ];
  
  List<Map<String, dynamic>> milestones = [
    {
      "age": "5 years",
      "milestone": "Can hop on one foot",
      "achieved": true,
      "date": "Nov 2024",
      "category": "Physical"
    },
    {
      "age": "5 years",
      "milestone": "Knows phone number",
      "achieved": true,
      "date": "Oct 2024",
      "category": "Cognitive"
    },
    {
      "age": "5-6 years",
      "milestone": "Rides bike without training wheels",
      "achieved": false,
      "date": null,
      "category": "Physical"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Growth Chart"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddMeasurementDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterSection(),
            _buildCurrentStatsCard(),
            _buildChartSection(),
            _buildPercentileCard(),
            _buildMilestonesSection(),
            _buildPreviousMeasurementsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QDropdownField(
            label: "Select Child",
            items: children,
            value: selectedChild,
            onChanged: (value, label) {
              selectedChild = label!;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Metric",
                  items: metrics,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = label!;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periods,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = label!;
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

  Widget _buildCurrentStatsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.child_care,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Stats - $selectedChild",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Last updated: Dec 15, 2024",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatItem("Height", "113 cm", "75th %ile"),
              _buildStatItem("Weight", "20.9 kg", "70th %ile"),
              _buildStatItem("BMI", "16.4", "Normal"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String percentile) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(50),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(200),
              ),
            ),
            Text(
              percentile,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withAlpha(180),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.show_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "$selectedMetric Growth Chart",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 48,
                    color: successColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Growth Trending Upward",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "75th percentile",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Your child",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(width: spMd),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Average",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPercentileCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.trending_up,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Healthy Growth Pattern",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Your child is growing at a steady rate in the 75th percentile",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flag,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Developmental Milestones",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...milestones.map((milestone) => _buildMilestoneItem(milestone)),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem(Map<String, dynamic> milestone) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: milestone["achieved"] ? successColor.withAlpha(25) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: milestone["achieved"] ? successColor.withAlpha(100) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: milestone["achieved"] ? successColor : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              milestone["achieved"] ? Icons.check : Icons.radio_button_unchecked,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${milestone["milestone"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: milestone["achieved"] ? successColor : disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${milestone["age"]} • ${milestone["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (milestone["achieved"] && milestone["date"] != null) ...[
                      Text(
                        " • Achieved ${milestone["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousMeasurementsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Previous Measurements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...growthData.map((data) => _buildMeasurementItem(data)),
        ],
      ),
    );
  }

  Widget _buildMeasurementItem(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${data["percentile"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
                  "${data["date"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Height: ${data["height"]} cm • Weight: ${data["weight"]} kg",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${data["percentile"]}th %ile",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMeasurementDialog() {
    String height = "";
    String weight = "";
    String headCircumference = "";
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Measurement"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDatePicker(
                label: "Measurement Date",
                value: selectedDate,
                onChanged: (value) {
                  selectedDate = value;
                  setDialogState(() {});
                },
              ),
              QNumberField(
                label: "Height (cm)",
                value: height,
                onChanged: (value) {
                  height = value;
                  setDialogState(() {});
                },
              ),
              QNumberField(
                label: "Weight (kg)",
                value: weight,
                onChanged: (value) {
                  weight = value;
                  setDialogState(() {});
                },
              ),
              QNumberField(
                label: "Head Circumference (cm)",
                value: headCircumference,
                onChanged: (value) {
                  headCircumference = value;
                  setDialogState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Measurement",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Measurement added successfully");
            },
          ),
        ],
      ),
    );
  }
}
