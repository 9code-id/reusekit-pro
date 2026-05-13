import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaHistoricalWeatherView extends StatefulWidget {
  const WcaHistoricalWeatherView({super.key});

  @override
  State<WcaHistoricalWeatherView> createState() => _WcaHistoricalWeatherViewState();
}

class _WcaHistoricalWeatherViewState extends State<WcaHistoricalWeatherView> {
  String selectedTimeRange = "Last 30 Days";
  String selectedLocation = "Current Location";
  String selectedDataType = "Temperature";

  List<String> timeRanges = ["Last 7 Days", "Last 30 Days", "Last 3 Months", "Last Year", "Custom Range"];
  List<String> locations = ["Current Location", "New York", "London", "Tokyo", "Sydney"];
  List<String> dataTypes = ["Temperature", "Precipitation", "Humidity", "Wind Speed", "Pressure"];

  List<Map<String, dynamic>> historicalData = [
    {
      "date": "2024-01-15",
      "temperature": 22.5,
      "precipitation": 2.3,
      "humidity": 65,
      "windSpeed": 12.5,
      "pressure": 1013.25,
      "condition": "Partly Cloudy",
    },
    {
      "date": "2024-01-14",
      "temperature": 19.8,
      "precipitation": 0.0,
      "humidity": 58,
      "windSpeed": 8.2,
      "pressure": 1015.80,
      "condition": "Sunny",
    },
    {
      "date": "2024-01-13",
      "temperature": 18.2,
      "precipitation": 15.6,
      "humidity": 78,
      "windSpeed": 15.3,
      "pressure": 1008.45,
      "condition": "Rainy",
    },
    {
      "date": "2024-01-12",
      "temperature": 25.1,
      "precipitation": 0.0,
      "humidity": 52,
      "windSpeed": 6.8,
      "pressure": 1018.20,
      "condition": "Clear",
    },
    {
      "date": "2024-01-11",
      "temperature": 21.7,
      "precipitation": 5.2,
      "humidity": 71,
      "windSpeed": 11.4,
      "pressure": 1011.75,
      "condition": "Light Rain",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historical Weather"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              _exportData();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildFilterSection(),
            _buildSummaryStats(),
            _buildChartSection(),
            _buildDataTable(),
            _buildTrendAnalysis(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter Historical Data",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Time Range",
            items: timeRanges.map((range) => {
              "label": range,
              "value": range,
            }).toList(),
            value: selectedTimeRange,
            onChanged: (value, label) {
              selectedTimeRange = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locations.map((location) => {
                    "label": location,
                    "value": location,
                  }).toList(),
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Data Type",
                  items: dataTypes.map((type) => {
                    "label": type,
                    "value": type,
                  }).toList(),
                  value: selectedDataType,
                  onChanged: (value, label) {
                    selectedDataType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Apply Filters",
              size: bs.sm,
              onPressed: () {
                _applyFilters();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    Map<String, dynamic> stats = _calculateStats();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Summary Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatCard("Average", "${stats["average"]}", Icons.trending_flat, infoColor),
              _buildStatCard("Maximum", "${stats["maximum"]}", Icons.trending_up, successColor),
              _buildStatCard("Minimum", "${stats["minimum"]}", Icons.trending_down, warningColor),
              _buildStatCard("Range", "${stats["range"]}", Icons.compare_arrows, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.show_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "$selectedDataType Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  selectedTimeRange,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(30)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: spSm,
                children: [
                  Icon(
                    Icons.show_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  Text(
                    "Interactive Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Historical $selectedDataType data visualization",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.table_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Historical Data Table",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showColumnFilter();
                },
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  _buildTableHeader(),
                  ...historicalData.take(5).map((data) => _buildTableRow(data)),
                ],
              ),
            ),
          ),
          if (historicalData.length > 5)
            Center(
              child: QButton(
                label: "View All ${historicalData.length} Records",
                size: bs.sm,
                onPressed: () {
                  _showFullTable();
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusSm),
          topRight: Radius.circular(radiusSm),
        ),
      ),
      child: Row(
        children: [
          _buildTableCell("Date", isHeader: true, width: 100),
          _buildTableCell("Temp (°C)", isHeader: true, width: 80),
          _buildTableCell("Rain (mm)", isHeader: true, width: 80),
          _buildTableCell("Humidity (%)", isHeader: true, width: 90),
          _buildTableCell("Wind (km/h)", isHeader: true, width: 90),
          _buildTableCell("Condition", isHeader: true, width: 120),
        ],
      ),
    );
  }

  Widget _buildTableRow(Map<String, dynamic> data) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          _buildTableCell("${data["date"]}", width: 100),
          _buildTableCell("${(data["temperature"] as double).toStringAsFixed(1)}", width: 80),
          _buildTableCell("${(data["precipitation"] as double).toStringAsFixed(1)}", width: 80),
          _buildTableCell("${data["humidity"]}", width: 90),
          _buildTableCell("${(data["windSpeed"] as double).toStringAsFixed(1)}", width: 90),
          _buildTableCell("${data["condition"]}", width: 120),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, required double width}) {
    return Container(
      width: width,
      padding: EdgeInsets.all(spSm),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? primaryColor : primaryColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights,
                color: successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Trend Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          _buildTrendItem(
            "Temperature Trend",
            "Rising by 0.5°C over the last 30 days",
            Icons.trending_up,
            warningColor,
          ),
          _buildTrendItem(
            "Precipitation Pattern",
            "Below average rainfall this month",
            Icons.trending_down,
            infoColor,
          ),
          _buildTrendItem(
            "Humidity Levels",
            "Stable around 65% average",
            Icons.trending_flat,
            successColor,
          ),
          _buildTrendItem(
            "Wind Conditions",
            "Increasing wind speeds detected",
            Icons.trending_up,
            primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendItem(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(
            icon,
            color: color,
            size: 16,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _calculateStats() {
    List<double> values = [];
    
    switch (selectedDataType) {
      case "Temperature":
        values = historicalData.map((d) => d["temperature"] as double).toList();
        break;
      case "Precipitation":
        values = historicalData.map((d) => d["precipitation"] as double).toList();
        break;
      case "Humidity":
        values = historicalData.map((d) => (d["humidity"] as int).toDouble()).toList();
        break;
      case "Wind Speed":
        values = historicalData.map((d) => d["windSpeed"] as double).toList();
        break;
      case "Pressure":
        values = historicalData.map((d) => d["pressure"] as double).toList();
        break;
    }

    if (values.isEmpty) return {"average": "N/A", "maximum": "N/A", "minimum": "N/A", "range": "N/A"};

    double average = values.reduce((a, b) => a + b) / values.length;
    double maximum = values.reduce((a, b) => a > b ? a : b);
    double minimum = values.reduce((a, b) => a < b ? a : b);
    double range = maximum - minimum;

    String unit = _getUnit(selectedDataType);

    return {
      "average": "${average.toStringAsFixed(1)}$unit",
      "maximum": "${maximum.toStringAsFixed(1)}$unit",
      "minimum": "${minimum.toStringAsFixed(1)}$unit",
      "range": "${range.toStringAsFixed(1)}$unit",
    };
  }

  String _getUnit(String dataType) {
    switch (dataType) {
      case "Temperature":
        return "°C";
      case "Precipitation":
        return "mm";
      case "Humidity":
        return "%";
      case "Wind Speed":
        return "km/h";
      case "Pressure":
        return "hPa";
      default:
        return "";
    }
  }

  void _applyFilters() {
    ss("Filters applied: $selectedTimeRange, $selectedLocation, $selectedDataType");
  }

  void _exportData() {
    ss("Historical weather data exported successfully");
  }

  void _showColumnFilter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Columns"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: dataTypes.map((type) => CheckboxListTile(
            title: Text(type),
            value: true,
            onChanged: (value) {},
          )).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Column filter applied");
            },
          ),
        ],
      ),
    );
  }

  void _showFullTable() {
    // Navigate to full table view
    ss("Opening full historical data table");
  }
}
