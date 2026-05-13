import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport10View extends StatefulWidget {
  @override
  State<GrlReport10View> createState() => _GrlReport10ViewState();
}

class _GrlReport10ViewState extends State<GrlReport10View> {
  int currentTab = 0;
  String selectedPeriod = "monthly";
  String selectedCategory = "all";

  List<Map<String, dynamic>> environmentalMetrics = [
    {
      "id": 1,
      "metric": "Carbon Footprint",
      "value": 2450.5,
      "unit": "tCO2e",
      "target": 2300.0,
      "trend": "down",
      "change": -5.2,
      "color": successColor,
      "icon": Icons.cloud,
    },
    {
      "id": 2,
      "metric": "Energy Consumption",
      "value": 1875.3,
      "unit": "MWh",
      "target": 1800.0,
      "trend": "down",
      "change": -3.8,
      "color": warningColor,
      "icon": Icons.electric_bolt,
    },
    {
      "id": 3,
      "metric": "Water Usage",
      "value": 15420.0,
      "unit": "m³",
      "target": 15000.0,
      "trend": "up",
      "change": 2.8,
      "color": infoColor,
      "icon": Icons.water_drop,
    },
    {
      "id": 4,
      "metric": "Waste Generation",
      "value": 125.8,
      "unit": "tons",
      "target": 120.0,
      "trend": "up",
      "change": 4.8,
      "color": dangerColor,
      "icon": Icons.delete,
    },
  ];

  List<Map<String, dynamic>> emissionData = [
    {
      "id": 1,
      "source": "Direct Emissions (Scope 1)",
      "amount": 850.2,
      "percentage": 34.7,
      "change": -2.3,
      "target": 800.0,
      "status": "warning",
      "description": "Fuel combustion, company vehicles",
    },
    {
      "id": 2,
      "source": "Electricity (Scope 2)",
      "amount": 1200.8,
      "percentage": 49.0,
      "change": -6.8,
      "target": 1100.0,
      "status": "improving",
      "description": "Purchased electricity and heating",
    },
    {
      "id": 3,
      "source": "Other Indirect (Scope 3)",
      "amount": 399.5,
      "percentage": 16.3,
      "change": -8.1,
      "target": 400.0,
      "status": "good",
      "description": "Business travel, waste disposal",
    },
  ];

  List<Map<String, dynamic>> wasteData = [
    {
      "id": 1,
      "type": "Recycled Materials",
      "amount": 68.5,
      "percentage": 54.4,
      "cost": 1200,
      "revenue": 2800,
      "trend": "up",
      "target": 70.0,
    },
    {
      "id": 2,
      "type": "Composted Organic",
      "amount": 22.3,
      "percentage": 17.7,
      "cost": 800,
      "revenue": 0,
      "trend": "stable",
      "target": 25.0,
    },
    {
      "id": 3,
      "type": "Landfill Waste",
      "amount": 25.6,
      "percentage": 20.3,
      "cost": 3200,
      "revenue": 0,
      "trend": "down",
      "target": 20.0,
    },
    {
      "id": 4,
      "type": "Hazardous Waste",
      "amount": 9.4,
      "percentage": 7.5,
      "cost": 4500,
      "revenue": 0,
      "trend": "down",
      "target": 8.0,
    },
  ];

  List<Map<String, dynamic>> initiativeData = [
    {
      "id": 1,
      "initiative": "Solar Panel Installation",
      "category": "Energy",
      "progress": 75,
      "startDate": "2024-01-15",
      "targetDate": "2024-06-30",
      "investment": 125000,
      "savings": 28000,
      "co2Reduction": 45.2,
      "status": "on_track",
    },
    {
      "id": 2,
      "initiative": "Waste Reduction Program",
      "category": "Waste",
      "progress": 60,
      "startDate": "2024-02-01",
      "targetDate": "2024-12-31",
      "investment": 35000,
      "savings": 15000,
      "co2Reduction": 12.8,
      "status": "delayed",
    },
    {
      "id": 3,
      "initiative": "Water Conservation System",
      "category": "Water",
      "progress": 90,
      "startDate": "2023-11-15",
      "targetDate": "2024-03-31",
      "investment": 68000,
      "savings": 22000,
      "co2Reduction": 8.5,
      "status": "on_track",
    },
    {
      "id": 4,
      "initiative": "Green Transportation Fleet",
      "category": "Transport",
      "progress": 40,
      "startDate": "2024-01-01",
      "targetDate": "2024-09-30",
      "investment": 180000,
      "savings": 35000,
      "co2Reduction": 62.3,
      "status": "on_track",
    },
  ];

  List<Map<String, dynamic>> certificationData = [
    {
      "id": 1,
      "certification": "ISO 14001",
      "type": "Environmental Management",
      "status": "certified",
      "issueDate": "2023-06-15",
      "expiryDate": "2026-06-15",
      "auditScore": 92.5,
      "nextAudit": "2024-06-15",
    },
    {
      "id": 2,
      "certification": "LEED Gold",
      "type": "Green Building",
      "status": "certified",
      "issueDate": "2023-09-20",
      "expiryDate": "2028-09-20",
      "auditScore": 88.7,
      "nextAudit": "2024-09-20",
    },
    {
      "id": 3,
      "certification": "Carbon Trust Standard",
      "type": "Carbon Management",
      "status": "pending",
      "issueDate": "",
      "expiryDate": "",
      "auditScore": 0,
      "nextAudit": "2024-04-30",
    },
    {
      "id": 4,
      "certification": "Energy Star",
      "type": "Energy Efficiency",
      "status": "certified",
      "issueDate": "2023-12-10",
      "expiryDate": "2024-12-10",
      "auditScore": 95.2,
      "nextAudit": "2024-12-10",
    },
  ];

  Widget _buildEnvironmentalMetricCard(Map<String, dynamic> metric) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (metric["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  metric["icon"] as IconData,
                  color: metric["color"] as Color,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${metric["metric"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
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
                            "${(metric["value"] as num).toStringAsFixed(1)} ${metric["unit"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Target: ${(metric["target"] as num).toStringAsFixed(1)} ${metric["unit"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (metric["trend"] == "up" ? 
                               (metric["metric"] == "Carbon Footprint" || metric["metric"] == "Waste Generation" ? 
                                dangerColor : successColor) : 
                               (metric["metric"] == "Carbon Footprint" || metric["metric"] == "Waste Generation" ? 
                                successColor : warningColor)).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            metric["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                            size: 14,
                            color: (metric["trend"] == "up" ? 
                                   (metric["metric"] == "Carbon Footprint" || metric["metric"] == "Waste Generation" ? 
                                    dangerColor : successColor) : 
                                   (metric["metric"] == "Carbon Footprint" || metric["metric"] == "Waste Generation" ? 
                                    successColor : warningColor)),
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${(metric["change"] as num).abs().toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (metric["trend"] == "up" ? 
                                     (metric["metric"] == "Carbon Footprint" || metric["metric"] == "Waste Generation" ? 
                                      dangerColor : successColor) : 
                                     (metric["metric"] == "Carbon Footprint" || metric["metric"] == "Waste Generation" ? 
                                      successColor : warningColor)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: (metric["value"] as num) / (metric["target"] as num),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(metric["color"] as Color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmissionCard(Map<String, dynamic> emission) {
    Color statusColor = emission["status"] == "good" 
        ? successColor 
        : emission["status"] == "warning" 
            ? warningColor 
            : infoColor;

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${emission["source"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${emission["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${emission["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(emission["amount"] as num).toStringAsFixed(1)} tCO2e",
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
                      "Percentage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(emission["percentage"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "Change: ",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${(emission["change"] as num).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: (emission["change"] as num) < 0 ? successColor : dangerColor,
                ),
              ),
              Spacer(),
              Text(
                "Target: ${(emission["target"] as num).toStringAsFixed(0)} tCO2e",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (emission["amount"] as num) / (emission["target"] as num),
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ],
      ),
    );
  }

  Widget _buildWasteCard(Map<String, dynamic> waste) {
    Color trendColor = waste["trend"] == "up" 
        ? (waste["type"] == "Recycled Materials" ? successColor : dangerColor)
        : waste["trend"] == "down"
            ? (waste["type"] == "Recycled Materials" ? dangerColor : successColor)
            : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${waste["type"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: trendColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${waste["trend"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: trendColor,
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
                      "Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(waste["amount"] as num).toStringAsFixed(1)} tons",
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
                      "Percentage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(waste["percentage"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((waste["cost"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Revenue",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      waste["revenue"] == 0 
                          ? "None" 
                          : "\$${((waste["revenue"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: waste["revenue"] == 0 ? disabledBoldColor : successColor,
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
              Text(
                "Target: ${(waste["target"] as num).toStringAsFixed(1)} tons",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (waste["amount"] as num) / (waste["target"] as num),
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(trendColor),
          ),
        ],
      ),
    );
  }

  Widget _buildInitiativeCard(Map<String, dynamic> initiative) {
    Color statusColor = initiative["status"] == "on_track" 
        ? successColor 
        : initiative["status"] == "delayed" 
            ? warningColor 
            : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${initiative["initiative"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${initiative["category"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "Progress: ${(initiative["progress"] as int)}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${initiative["status"]}".replaceAll("_", " ").toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (initiative["progress"] as int) / 100,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Investment",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((initiative["investment"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Savings",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((initiative["savings"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
              Text(
                "CO2 Reduction: ${(initiative["co2Reduction"] as num).toStringAsFixed(1)} tCO2e",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "Target: ${initiative["targetDate"]}",
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

  Widget _buildCertificationCard(Map<String, dynamic> certification) {
    Color statusColor = certification["status"] == "certified" 
        ? successColor 
        : certification["status"] == "pending" 
            ? warningColor 
            : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${certification["certification"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${certification["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${certification["type"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          if (certification["status"] == "certified") ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Score",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(certification["auditScore"] as num).toStringAsFixed(1)}%",
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
                        "Expires",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${certification["expiryDate"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                Text(
                  "Next Audit: ${certification["nextAudit"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            LinearProgressIndicator(
              value: (certification["auditScore"] as num) / 100,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ] else ...[
            Text(
              "Next Audit: ${certification["nextAudit"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: warningColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Environmental Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: environmentalMetrics.map((metric) {
              return _buildEnvironmentalMetricCard(metric);
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Carbon Emissions Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: emissionData.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              return _buildEmissionCard(emissionData[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWasteTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Waste Management",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: wasteData.map((waste) {
              return _buildWasteCard(waste);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInitiativesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Environmental Initiatives",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: initiativeData.map((initiative) {
              return _buildInitiativeCard(initiative);
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Certifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: certificationData.map((certification) {
              return _buildCertificationCard(certification);
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Environmental Report",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Waste", icon: Icon(Icons.delete)),
        Tab(text: "Initiatives", icon: Icon(Icons.eco)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildWasteTab(),
        _buildInitiativesTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
