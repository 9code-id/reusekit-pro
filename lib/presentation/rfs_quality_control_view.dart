import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsQualityControlView extends StatefulWidget {
  const RfsQualityControlView({super.key});

  @override
  State<RfsQualityControlView> createState() => _RfsQualityControlViewState();
}

class _RfsQualityControlViewState extends State<RfsQualityControlView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Passed", "value": "Passed"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Review", "value": "Review"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Food Safety", "value": "Food Safety"},
    {"label": "Temperature", "value": "Temperature"},
    {"label": "Visual", "value": "Visual"},
    {"label": "Taste", "value": "Taste"},
    {"label": "Hygiene", "value": "Hygiene"},
  ];

  List<Map<String, dynamic>> qualityChecks = [
    {
      "id": "QC001",
      "itemName": "Grilled Salmon",
      "category": "Food Safety",
      "status": "Passed",
      "inspector": "Chef Marco",
      "checkTime": "2025-06-19T14:30:00",
      "temperature": 145,
      "score": 95,
      "notes": "Perfect temperature and texture",
      "criteria": ["Temperature", "Appearance", "Smell", "Texture"],
      "results": [true, true, true, true],
      "priority": "high",
      "image": "https://picsum.photos/300/200?random=1&keyword=salmon"
    },
    {
      "id": "QC002",
      "itemName": "Caesar Salad",
      "category": "Visual",
      "status": "Failed",
      "inspector": "Chef Anna",
      "checkTime": "2025-06-19T14:15:00",
      "temperature": 45,
      "score": 65,
      "notes": "Lettuce appears wilted, needs replacement",
      "criteria": ["Freshness", "Presentation", "Portion", "Cleanliness"],
      "results": [false, true, true, true],
      "priority": "medium",
      "image": "https://picsum.photos/300/200?random=2&keyword=salad"
    },
    {
      "id": "QC003",
      "itemName": "Beef Steak",
      "category": "Temperature",
      "status": "Pending",
      "inspector": "Chef John",
      "checkTime": "2025-06-19T14:45:00",
      "temperature": 160,
      "score": 0,
      "notes": "Awaiting temperature stabilization",
      "criteria": ["Internal Temp", "Surface Temp", "Color", "Doneness"],
      "results": [true, false, true, true],
      "priority": "high",
      "image": "https://picsum.photos/300/200?random=3&keyword=steak"
    },
    {
      "id": "QC004",
      "itemName": "Chocolate Cake",
      "category": "Taste",
      "status": "Review",
      "inspector": "Chef Maria",
      "checkTime": "2025-06-19T13:30:00",
      "temperature": 68,
      "score": 85,
      "notes": "Good flavor but slightly dry texture",
      "criteria": ["Sweetness", "Texture", "Moisture", "Flavor"],
      "results": [true, false, false, true],
      "priority": "low",
      "image": "https://picsum.photos/300/200?random=4&keyword=cake"
    },
    {
      "id": "QC005",
      "itemName": "Kitchen Station",
      "category": "Hygiene",
      "status": "Passed",
      "inspector": "Health Inspector",
      "checkTime": "2025-06-19T12:00:00",
      "temperature": 0,
      "score": 98,
      "notes": "Excellent cleanliness standards maintained",
      "criteria": ["Surface Clean", "Equipment", "Storage", "Handwashing"],
      "results": [true, true, true, true],
      "priority": "high",
      "image": "https://picsum.photos/300/200?random=5&keyword=kitchen"
    },
  ];

  List<Map<String, dynamic>> get filteredChecks {
    return qualityChecks.where((check) {
      bool matchesSearch = "${check["itemName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${check["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || check["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || check["category"] == selectedCategory;
      
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Passed": return successColor;
      case "Failed": return dangerColor;
      case "Pending": return warningColor;
      case "Review": return infoColor;
      default: return disabledColor;
    }
  }

  Color getScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 70) return warningColor;
    if (score >= 50) return dangerColor;
    return disabledColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quality Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Quality Checks",
                    value: searchQuery,
                    hint: "Search by item name or ID...",
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
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
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

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${qualityChecks.where((check) => check["status"] == "Passed").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Passed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.cancel, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${qualityChecks.where((check) => check["status"] == "Failed").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Failed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.pending, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${qualityChecks.where((check) => check["status"] == "Pending").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
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

            // Quality Checks List
            ...filteredChecks.map((check) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getStatusColor("${check["status"]}"),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${check["image"]}",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${check["itemName"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: getStatusColor("${check["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                          border: Border.all(
                                            color: getStatusColor("${check["status"]}").withAlpha(100),
                                          ),
                                        ),
                                        child: Text(
                                          "${check["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: getStatusColor("${check["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "ID: ${check["id"]} • ${check["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(Icons.person_outline, size: 14, color: disabledBoldColor),
                                      SizedBox(width: 4),
                                      Text(
                                        "${check["inspector"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      if ("${check["status"]}" != "Pending")
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: getScoreColor(check["score"] as int).withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Score: ${check["score"]}%",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: getScoreColor(check["score"] as int),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        if ("${check["notes"]}".isNotEmpty) ...[
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${check["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],

                        SizedBox(height: spSm),
                        
                        // Quality Criteria Checklist
                        Column(
                          children: [
                            Text(
                              "Quality Criteria",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(check["criteria"] as List).asMap().entries.map((entry) {
                              int index = entry.key;
                              String criteria = entry.value;
                              bool passed = (check["results"] as List)[index] as bool;
                              
                              return Container(
                                margin: EdgeInsets.only(bottom: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      passed ? Icons.check_circle : Icons.cancel,
                                      color: passed ? successColor : dangerColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      criteria,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusMd),
                        bottomRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          DateTime.parse("${check["checkTime"]}").dMMMy,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "${check["status"]}" == "Pending" ? "Check" : "Recheck",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.add_task, color: Colors.white),
      ),
    );
  }
}
