import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaHealthWeatherView extends StatefulWidget {
  const WcaHealthWeatherView({super.key});

  @override
  State<WcaHealthWeatherView> createState() => _WcaHealthWeatherViewState();
}

class _WcaHealthWeatherViewState extends State<WcaHealthWeatherView> {
  String selectedCondition = "Asthma";
  bool alertsEnabled = true;
  
  List<Map<String, dynamic>> healthConditions = [
    {"label": "Asthma", "value": "Asthma"},
    {"label": "Allergies", "value": "Allergies"},
    {"label": "Arthritis", "value": "Arthritis"},
    {"label": "Migraine", "value": "Migraine"},
    {"label": "Heart Conditions", "value": "Heart Conditions"},
    {"label": "Skin Conditions", "value": "Skin Conditions"},
    {"label": "Sinus Issues", "value": "Sinus Issues"},
  ];

  List<Map<String, dynamic>> healthMetrics = [
    {
      "metric": "Air Quality Index",
      "value": "45",
      "status": "Good",
      "color": "success",
      "icon": Icons.air,
      "description": "Safe for outdoor activities",
      "advice": "Good day for exercise and outdoor activities",
    },
    {
      "metric": "Pollen Count",
      "value": "Medium",
      "status": "Moderate",
      "color": "warning",
      "icon": Icons.local_florist,
      "description": "Tree pollen levels elevated",
      "advice": "Consider taking allergy medication before going out",
    },
    {
      "metric": "UV Index",
      "value": "7",
      "status": "High",
      "color": "danger",
      "icon": Icons.wb_sunny,
      "description": "Strong UV radiation",
      "advice": "Use SPF 30+ sunscreen and wear protective clothing",
    },
    {
      "metric": "Humidity",
      "value": "65%",
      "status": "Comfortable",
      "color": "info",
      "icon": Icons.water_drop,
      "description": "Ideal humidity levels",
      "advice": "Comfortable conditions for most people",
    },
  ];

  List<Map<String, dynamic>> healthAlerts = [
    {
      "type": "Allergy Alert",
      "severity": "Medium",
      "message": "Tree pollen levels are elevated today",
      "recommendation": "Take allergy medication and limit outdoor exposure during peak hours (10 AM - 4 PM)",
      "icon": Icons.warning,
      "color": "warning",
      "time": "2 hours ago",
    },
    {
      "type": "Air Quality",
      "severity": "Low",
      "message": "Good air quality conditions",
      "recommendation": "Safe for outdoor activities and exercise",
      "icon": Icons.check_circle,
      "color": "success",
      "time": "1 hour ago",
    },
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "time": "Morning (6-10 AM)",
      "activity": "Light Exercise",
      "suitability": "Good",
      "reason": "Lower pollen levels, comfortable temperature",
      "precautions": ["Take allergy medication", "Stay hydrated"],
      "color": "success",
    },
    {
      "time": "Midday (10 AM-4 PM)",
      "activity": "Indoor Activities",
      "suitability": "Recommended",
      "reason": "Peak pollen hours, high UV levels",
      "precautions": ["Avoid prolonged outdoor exposure", "Use air conditioning"],
      "color": "warning",
    },
    {
      "time": "Evening (4-8 PM)",
      "activity": "Outdoor Activities",
      "suitability": "Good",
      "reason": "Lower UV, reduced pollen levels",
      "precautions": ["Still use sunscreen", "Monitor air quality"],
      "color": "success",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health & Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("Health weather notifications");
            },
          ),
          IconButton(
            icon: Icon(Icons.medical_services),
            onPressed: () {
              si("View health profile");
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
                  colors: [primaryColor.withAlpha(20), successColor.withAlpha(20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.health_and_safety,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Weather Monitor",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Weather insights for your health conditions",
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

            Text(
              "Health Profile",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Primary Health Condition",
                    items: healthConditions,
                    value: selectedCondition,
                    onChanged: (value, label) {
                      selectedCondition = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    label: "Health Alerts",
                    items: [
                      {
                        "label": "Enable weather health alerts",
                        "value": true,
                        "checked": alertsEnabled,
                      }
                    ],
                    value: [
                      if (alertsEnabled)
                        {
                          "label": "Enable weather health alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      alertsEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Current Health Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: healthMetrics.map((metric) {
                Color statusColor = primaryColor;
                if (metric["color"] == "success") statusColor = successColor;
                if (metric["color"] == "warning") statusColor = warningColor;
                if (metric["color"] == "danger") statusColor = dangerColor;
                if (metric["color"] == "info") statusColor = infoColor;

                return Container(
                  padding: EdgeInsets.all(spMd),
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
                          Icon(
                            metric["icon"] as IconData,
                            color: statusColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${metric["metric"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${metric["status"]}",
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["advice"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Text(
              "Health Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...healthAlerts.map((alert) {
              Color alertColor = primaryColor;
              if (alert["color"] == "success") alertColor = successColor;
              if (alert["color"] == "warning") alertColor = warningColor;
              if (alert["color"] == "danger") alertColor = dangerColor;

              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: alertColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: alertColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          alert["icon"] as IconData,
                          color: alertColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${alert["type"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: alertColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: alertColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${alert["severity"]}",
                            style: TextStyle(
                              color: alertColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${alert["message"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${alert["recommendation"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${alert["time"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),

            Text(
              "Daily Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...recommendations.map((rec) {
              Color recColor = primaryColor;
              if (rec["color"] == "success") recColor = successColor;
              if (rec["color"] == "warning") recColor = warningColor;

              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: recColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${rec["time"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: recColor,
                                ),
                              ),
                              Text(
                                "${rec["activity"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: recColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${rec["suitability"]}",
                            style: TextStyle(
                              color: recColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${rec["reason"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Precautions:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    ...(rec["precautions"] as List<String>).map((precaution) {
                      return Padding(
                        padding: EdgeInsets.only(top: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: recColor,
                              size: 14,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                precaution,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),

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
                        Icons.health_and_safety,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Health Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Monitor pollen forecasts if you have allergies",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Stay indoors during poor air quality days",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Use UV protection when index is high",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "• Stay hydrated in humid conditions",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Set Health Alerts",
              size: bs.md,
              onPressed: () {
                si("Configuring personalized health alerts");
              },
            ),
          ],
        ),
      ),
    );
  }
}
