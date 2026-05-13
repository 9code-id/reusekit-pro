import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHistory3View extends StatefulWidget {
  const GrlHistory3View({Key? key}) : super(key: key);

  @override
  State<GrlHistory3View> createState() => _GrlHistory3ViewState();
}

class _GrlHistory3ViewState extends State<GrlHistory3View> {
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedTimeRange = "This Month";
  
  List<Map<String, dynamic>> progressHistory = [
    {
      "id": 1,
      "date": "2024-12-20",
      "type": "Weight Loss",
      "category": "Body Composition",
      "previousValue": 75.5,
      "currentValue": 74.8,
      "change": -0.7,
      "unit": "kg",
      "percentage": -0.93,
      "status": "Improved",
      "notes": "Consistent diet and exercise routine",
      "icon": Icons.trending_down,
      "color": Colors.green,
    },
    {
      "id": 2,
      "date": "2024-12-19",
      "type": "Running Distance",
      "category": "Cardio Performance",
      "previousValue": 3.2,
      "currentValue": 4.1,
      "change": 0.9,
      "unit": "km",
      "percentage": 28.1,
      "status": "Improved",
      "notes": "New personal best for daily run",
      "icon": Icons.directions_run,
      "color": Colors.blue,
    },
    {
      "id": 3,
      "date": "2024-12-18",
      "type": "Sleep Quality",
      "category": "Recovery",
      "previousValue": 7.2,
      "currentValue": 8.5,
      "change": 1.3,
      "unit": "hours",
      "percentage": 18.1,
      "status": "Improved",
      "notes": "Better sleep schedule implementation",
      "icon": Icons.bedtime,
      "color": Colors.purple,
    },
    {
      "id": 4,
      "date": "2024-12-17",
      "type": "Bench Press",
      "category": "Strength Training",
      "previousValue": 65.0,
      "currentValue": 67.5,
      "change": 2.5,
      "unit": "kg",
      "percentage": 3.8,
      "status": "Improved",
      "notes": "Increased working weight successfully",
      "icon": Icons.fitness_center,
      "color": Colors.orange,
    },
    {
      "id": 5,
      "date": "2024-12-16",
      "type": "Body Fat",
      "category": "Body Composition",
      "previousValue": 18.5,
      "currentValue": 17.8,
      "change": -0.7,
      "unit": "%",
      "percentage": -3.8,
      "status": "Improved",
      "notes": "Reduced through consistent training",
      "icon": Icons.monitor_weight,
      "color": Colors.green,
    },
    {
      "id": 6,
      "date": "2024-12-15",
      "type": "Heart Rate",
      "category": "Cardiovascular",
      "previousValue": 72.0,
      "currentValue": 68.0,
      "change": -4.0,
      "unit": "bpm",
      "percentage": -5.6,
      "status": "Improved",
      "notes": "Resting heart rate improvement",
      "icon": Icons.favorite,
      "color": Colors.red,
    },
    {
      "id": 7,
      "date": "2024-12-14",
      "type": "Squat",
      "category": "Strength Training",
      "previousValue": 80.0,
      "currentValue": 82.5,
      "change": 2.5,
      "unit": "kg",
      "percentage": 3.1,
      "status": "Improved",
      "notes": "Form improvement and weight increase",
      "icon": Icons.fitness_center,
      "color": Colors.orange,
    },
    {
      "id": 8,
      "date": "2024-12-13",
      "type": "Daily Steps",
      "category": "Daily Activity",
      "previousValue": 8500.0,
      "currentValue": 12300.0,
      "change": 3800.0,
      "unit": "steps",
      "percentage": 44.7,
      "status": "Improved",
      "notes": "Added evening walk routine",
      "icon": Icons.directions_walk,
      "color": Colors.teal,
    },
  ];

  List<String> filterOptions = ["All", "Improved", "Declined", "Maintained"];
  List<String> timeRangeOptions = ["Today", "This Week", "This Month", "Last 3 Months", "This Year"];
  List<String> categoryOptions = ["All Categories", "Body Composition", "Strength Training", "Cardio Performance", "Recovery", "Daily Activity", "Cardiovascular"];

  String selectedCategory = "All Categories";

  List<Map<String, dynamic>> get filteredHistory {
    return progressHistory.where((item) {
      bool matchesSearch = "${item["type"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["notes"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesFilter = selectedFilter == "All" || "${item["status"]}" == selectedFilter;
      bool matchesCategory = selectedCategory == "All Categories" || "${item["category"]}" == selectedCategory;
      return matchesSearch && matchesFilter && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress History"),
        actions: [
          IconButton(
            icon: Icon(Icons.insights),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search progress...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Options
            QHorizontalScroll(
              children: [
                _buildFilterChip("Status", selectedFilter, filterOptions),
                _buildFilterChip("Time Range", selectedTimeRange, timeRangeOptions),
                _buildFilterChip("Category", selectedCategory, categoryOptions),
              ],
            ),

            // Summary Stats
            _buildSummarySection(),

            // Progress History List
            Text(
              "Recent Progress Changes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // History Items
            ...filteredHistory.map((item) => _buildProgressHistoryCard(item)),

            // Load More Button
            if (filteredHistory.isNotEmpty)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More History",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String currentValue, List<String> options) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {
          // Show filter options
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$label: $currentValue",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spXs),
              Icon(
                Icons.keyboard_arrow_down,
                size: 16,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "This Month Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  "Improvements",
                  "23",
                  Icons.trending_up,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Maintained",
                  "8",
                  Icons.trending_flat,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard(
                  "Declined",
                  "3",
                  Icons.trending_down,
                  warningColor,
                ),
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
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressHistoryCard(Map<String, dynamic> item) {
    Color statusColor = item["status"] == "Improved" 
        ? successColor 
        : item["status"] == "Declined"
            ? dangerColor
            : infoColor;

    String changeText = (item["change"] as num) > 0 
        ? "+${(item["change"] as num).toStringAsFixed(1)}"
        : "${(item["change"] as num).toStringAsFixed(1)}";

    String percentageText = (item["percentage"] as num) > 0
        ? "+${(item["percentage"] as num).toStringAsFixed(1)}%"
        : "${(item["percentage"] as num).toStringAsFixed(1)}%";

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and status
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (item["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["category"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${item["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Values and Changes
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Previous",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(item["previousValue"] as num).toStringAsFixed(1)} ${item["unit"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: disabledBoldColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
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
                        "${(item["currentValue"] as num).toStringAsFixed(1)} ${item["unit"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        changeText,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      Text(
                        percentageText,
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Notes and Date
          if ("${item["notes"]}".isNotEmpty)
            Text(
              "${item["notes"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),

          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(item["date"] as String).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.more_vert,
                  size: 16,
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
