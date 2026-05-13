import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaGrowingDegreeDaysView extends StatefulWidget {
  const WcaGrowingDegreeDaysView({super.key});

  @override
  State<WcaGrowingDegreeDaysView> createState() => _WcaGrowingDegreeDaysViewState();
}

class _WcaGrowingDegreeDaysViewState extends State<WcaGrowingDegreeDaysView> {
  String selectedCrop = "Corn";
  String selectedLocation = "Iowa, USA";
  String selectedYear = "2024";

  List<Map<String, dynamic>> cropTypes = [
    {"label": "Corn", "value": "Corn"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Cotton", "value": "Cotton"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Barley", "value": "Barley"},
  ];

  List<Map<String, dynamic>> yearOptions = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
  ];

  List<Map<String, dynamic>> gddSummary = [
    {
      "title": "Current GDD",
      "value": "1,245",
      "subtitle": "Base 50°F",
      "color": primaryColor,
      "icon": Icons.thermostat,
      "change": "+45 today",
    },
    {
      "title": "Target GDD",
      "value": "2,700",
      "subtitle": "For maturity",
      "color": infoColor,
      "icon": Icons.flag,
      "change": "1,455 remaining",
    },
    {
      "title": "Progress",
      "value": "46",
      "subtitle": "% Complete",
      "color": successColor,
      "icon": Icons.trending_up,
      "change": "On schedule",
    },
    {
      "title": "Days to Maturity",
      "value": "89",
      "subtitle": "Estimated",
      "color": warningColor,
      "icon": Icons.schedule,
      "change": "September 15",
    },
  ];

  List<Map<String, dynamic>> monthlyGDD = [
    {
      "month": "March",
      "gdd": 125,
      "target": 150,
      "temperature": "45°F",
      "status": "Below Target",
    },
    {
      "month": "April",
      "gdd": 285,
      "target": 300,
      "temperature": "58°F",
      "status": "Near Target",
    },
    {
      "month": "May",
      "gdd": 465,
      "target": 450,
      "temperature": "68°F",
      "status": "Above Target",
    },
    {
      "month": "June",
      "gdd": 370,
      "target": 400,
      "temperature": "75°F",
      "status": "Below Target",
    },
    {
      "month": "July",
      "gdd": 0,
      "target": 450,
      "temperature": "82°F",
      "status": "Projected",
    },
    {
      "month": "August",
      "gdd": 0,
      "target": 420,
      "temperature": "79°F",
      "status": "Projected",
    },
  ];

  List<Map<String, dynamic>> growthStages = [
    {
      "stage": "VE (Emergence)",
      "gddRequired": 120,
      "gddActual": 120,
      "date": "April 15",
      "status": "Completed",
      "color": successColor,
    },
    {
      "stage": "V6 (6 Leaves)",
      "gddRequired": 475,
      "gddActual": 475,
      "date": "May 20",
      "status": "Completed",
      "color": successColor,
    },
    {
      "stage": "VT (Tasseling)",
      "gddRequired": 850,
      "gddActual": 0,
      "date": "July 5",
      "status": "Current Target",
      "color": warningColor,
    },
    {
      "stage": "R1 (Silking)",
      "gddRequired": 950,
      "gddActual": 0,
      "date": "July 15",
      "status": "Upcoming",
      "color": infoColor,
    },
    {
      "stage": "R6 (Maturity)",
      "gddRequired": 2700,
      "gddActual": 0,
      "date": "September 15",
      "status": "Future",
      "color": disabledBoldColor,
    },
  ];

  List<Map<String, dynamic>> dailyGDD = [
    {"date": "June 13", "gdd": 18, "temp": "72°F", "accumulated": 1201},
    {"date": "June 14", "gdd": 22, "temp": "76°F", "accumulated": 1223},
    {"date": "June 15", "gdd": 15, "temp": "69°F", "accumulated": 1238},
    {"date": "June 16", "gdd": 7, "temp": "61°F", "accumulated": 1245},
    {"date": "June 17", "gdd": 0, "temp": "58°F", "accumulated": 1245},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Growing Degree Days"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              si("GDD calculation: (Max + Min) / 2 - Base Temperature");
            },
          ),
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              si("GDD Calculator opened");
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
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(20),
                    infoColor.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.thermostat,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "GDD Tracking System",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Monitor heat accumulation for optimal crop development timing",
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
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Crop Type",
                    items: cropTypes,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Year",
                    items: yearOptions,
                    value: selectedYear,
                    onChanged: (value, label) {
                      selectedYear = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QTextField(
              label: "Location",
              value: selectedLocation,
              hint: "Enter your location",
              onChanged: (value) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            Text(
              "GDD Summary",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: gddSummary.map((item) {
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
                          Icon(
                            item["icon"],
                            color: item["color"],
                            size: 24,
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: item["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${item["change"]}",
                              style: TextStyle(
                                color: item["color"],
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${item["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${item["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${item["subtitle"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Growth Stages Progress",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: growthStages.map((stage) {
                bool isCompleted = stage["status"] == "Completed";
                bool isCurrent = stage["status"] == "Current Target";
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isCurrent ? Border.all(color: warningColor, width: 2) : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: stage["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : Icons.schedule,
                          color: stage["color"],
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${stage["stage"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Required: ${stage["gddRequired"]} GDD",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Date: ${stage["date"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: stage["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${stage["status"]}",
                          style: TextStyle(
                            color: stage["color"],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Monthly GDD Accumulation",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: monthlyGDD.map((month) {
                double progress = month["target"] > 0 ? (month["gdd"] / month["target"]) : 0;
                Color statusColor = month["status"] == "Above Target"
                    ? successColor
                    : month["status"] == "Near Target"
                        ? warningColor
                        : month["status"] == "Below Target"
                            ? dangerColor
                            : infoColor;

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
                          Text(
                            "${month["month"]}",
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
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${month["status"]}",
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
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
                                  "GDD: ${month["gdd"]} / ${month["target"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: LinearProgressIndicator(
                                    value: progress > 1 ? 1 : progress,
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "${month["temperature"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Recent Daily GDD",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: dailyGDD.map((day) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${day["date"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${day["temp"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "+${day["gdd"]} GDD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${day["accumulated"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "About Growing Degree Days",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "GDD measures heat accumulation above a base temperature (50°F for corn) to predict plant development timing and maturity dates.",
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
      ),
    );
  }
}
