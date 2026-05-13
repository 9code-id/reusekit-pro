import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSoilAnalysisView extends StatefulWidget {
  const AmaSoilAnalysisView({super.key});

  @override
  State<AmaSoilAnalysisView> createState() => _AmaSoilAnalysisViewState();
}

class _AmaSoilAnalysisViewState extends State<AmaSoilAnalysisView> {
  List<Map<String, dynamic>> soilSamples = [
    {
      "id": "SP001",
      "location": "North Field",
      "date": "2024-06-10",
      "ph": 6.8,
      "nitrogen": 45,
      "phosphorus": 32,
      "potassium": 28,
      "organicMatter": 3.2,
      "status": "Analyzed",
      "coordinates": "40.7128, -74.0060",
      "depth": "0-20cm",
      "texture": "Clay Loam",
      "moisture": 18.5,
      "recommendations": [
        "Increase nitrogen levels by 15%",
        "Add organic compost",
        "pH is optimal for most crops"
      ]
    },
    {
      "id": "SP002", 
      "location": "South Field",
      "date": "2024-06-08",
      "ph": 5.5,
      "nitrogen": 38,
      "phosphorus": 25,
      "potassium": 22,
      "organicMatter": 2.8,
      "status": "Pending",
      "coordinates": "40.7580, -73.9855",
      "depth": "0-20cm",
      "texture": "Sandy Loam",
      "moisture": 15.2,
      "recommendations": [
        "Apply lime to increase pH",
        "Boost phosphorus levels",
        "Regular organic matter addition needed"
      ]
    },
    {
      "id": "SP003",
      "location": "East Field",
      "date": "2024-06-12",
      "ph": 7.2,
      "nitrogen": 52,
      "phosphorus": 38,
      "potassium": 35,
      "organicMatter": 4.1,
      "status": "Analyzed",
      "coordinates": "40.6892, -74.0445",
      "depth": "0-20cm", 
      "texture": "Silt Loam",
      "moisture": 22.8,
      "recommendations": [
        "Excellent soil condition",
        "Maintain current practices",
        "Minor potassium supplement recommended"
      ]
    },
  ];

  String selectedField = "All Fields";
  String selectedTimeframe = "Last 30 Days";
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soil Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('new-soil-test')
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.science,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Soil Health Overview",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Monitor and analyze soil conditions across your fields",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Field Location",
                    items: [
                      {"label": "All Fields", "value": "All Fields"},
                      {"label": "North Field", "value": "North Field"},
                      {"label": "South Field", "value": "South Field"},
                      {"label": "East Field", "value": "East Field"},
                      {"label": "West Field", "value": "West Field"},
                    ],
                    value: selectedField,
                    onChanged: (value, label) {
                      selectedField = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: [
                      {"label": "Last 7 Days", "value": "Last 7 Days"},
                      {"label": "Last 30 Days", "value": "Last 30 Days"},
                      {"label": "Last 3 Months", "value": "Last 3 Months"},
                      {"label": "Last 6 Months", "value": "Last 6 Months"},
                    ],
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Soil Health Metrics
            Text(
              "Soil Health Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildMetricCard(
                  "Average pH",
                  "6.5",
                  "Optimal Range: 6.0-7.0",
                  Icons.water_drop,
                  successColor,
                ),
                _buildMetricCard(
                  "Nitrogen (N)",
                  "45 ppm",
                  "Good level",
                  Icons.eco,
                  primaryColor,
                ),
                _buildMetricCard(
                  "Phosphorus (P)",
                  "32 ppm",
                  "Moderate level",
                  Icons.local_florist,
                  warningColor,
                ),
                _buildMetricCard(
                  "Potassium (K)",
                  "28 ppm",
                  "Low level",
                  Icons.grass,
                  dangerColor,
                ),
                _buildMetricCard(
                  "Organic Matter",
                  "3.4%",
                  "Good content",
                  Icons.compost,
                  successColor,
                ),
                _buildMetricCard(
                  "Soil Moisture",
                  "18.8%",
                  "Adequate",
                  Icons.opacity,
                  infoColor,
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Soil Samples Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Soil Samples",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "New Sample",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo('new-soil-sample')
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: soilSamples.length,
              itemBuilder: (context, index) {
                final sample = soilSamples[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: "${sample["status"]}" == "Analyzed" 
                                  ? successColor.withAlpha(20)
                                  : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${sample["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: "${sample["status"]}" == "Analyzed" 
                                    ? successColor
                                    : warningColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${sample["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${sample["location"]} (${sample["id"]})",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                                  "pH Level",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${sample["ph"]}",
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
                                  "Nitrogen",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${sample["nitrogen"]} ppm",
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
                                  "Phosphorus",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${sample["phosphorus"]} ppm",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
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
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo('soil-sample-detail')
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.share,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
