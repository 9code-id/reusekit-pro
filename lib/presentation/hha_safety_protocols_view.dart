import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaSafetyProtocolsView extends StatefulWidget {
  const HhaSafetyProtocolsView({super.key});

  @override
  State<HhaSafetyProtocolsView> createState() => _HhaSafetyProtocolsViewState();
}

class _HhaSafetyProtocolsViewState extends State<HhaSafetyProtocolsView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  bool loading = false;

  List<Map<String, dynamic>> protocols = [
    {
      "id": "1",
      "title": "Fire Safety Protocol",
      "category": "Emergency",
      "status": "Active",
      "priority": "High",
      "lastUpdated": "2024-03-15T10:00:00Z",
      "description": "Complete fire safety procedures including evacuation routes, fire extinguisher locations, and emergency contacts.",
      "steps": 8,
      "completedBy": 45,
      "totalStaff": 50,
      "color": 0xFFFF6B6B,
    },
    {
      "id": "2",
      "title": "Guest Data Protection",
      "category": "Privacy",
      "status": "Active",
      "priority": "High",
      "description": "Guidelines for handling guest personal information and payment data securely.",
      "lastUpdated": "2024-03-14T14:30:00Z",
      "steps": 12,
      "completedBy": 48,
      "totalStaff": 50,
      "color": 0xFF4ECDC4,
    },
    {
      "id": "3",
      "title": "Food Safety Standards",
      "category": "Health",
      "status": "Active",
      "priority": "High",
      "description": "Kitchen hygiene, food storage, and preparation safety guidelines.",
      "lastUpdated": "2024-03-13T09:15:00Z",
      "steps": 15,
      "completedBy": 38,
      "totalStaff": 42,
      "color": 0xFF45B7D1,
    },
    {
      "id": "4",
      "title": "Pool Area Safety",
      "category": "Recreation",
      "status": "Active",
      "priority": "Medium",
      "description": "Swimming pool safety measures, lifeguard duties, and water quality maintenance.",
      "lastUpdated": "2024-03-12T16:45:00Z",
      "steps": 10,
      "completedBy": 25,
      "totalStaff": 28,
      "color": 0xFF96CEB4,
    },
    {
      "id": "5",
      "title": "Chemical Storage Safety",
      "category": "Maintenance",
      "status": "Under Review",
      "priority": "High",
      "description": "Safe handling and storage of cleaning chemicals and maintenance supplies.",
      "lastUpdated": "2024-03-11T11:20:00Z",
      "steps": 9,
      "completedBy": 12,
      "totalStaff": 15,
      "color": 0xFFFECE2F,
    },
    {
      "id": "6",
      "title": "Guest Room Security",
      "category": "Security",
      "status": "Active",
      "priority": "Medium",
      "description": "Room access protocols, key card management, and guest privacy measures.",
      "lastUpdated": "2024-03-10T13:00:00Z",
      "steps": 7,
      "completedBy": 35,
      "totalStaff": 40,
      "color": 0xFFFF8A95,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "Privacy", "value": "Privacy"},
    {"label": "Health", "value": "Health"},
    {"label": "Recreation", "value": "Recreation"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Security", "value": "Security"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> get filteredProtocols {
    return protocols.where((protocol) {
      bool matchesSearch = searchQuery.isEmpty || 
          (protocol["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (protocol["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || protocol["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || protocol["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safety Protocols"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(HhaAddSafetyProtocolView());
            },
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) :
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search and Filters
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search protocols...",
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
              SizedBox(height: spSm),
              
              // Filter Row
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
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
                ],
              ),
              SizedBox(height: spLg),

              // Overview Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.shield_outlined, color: successColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "Active Protocols",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${protocols.where((p) => p["status"] == "Active").length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.pending_outlined, color: warningColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "Under Review",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${protocols.where((p) => p["status"] == "Under Review").length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),

              // Protocols List
              Text(
                "Safety Protocols (${filteredProtocols.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredProtocols.length,
                itemBuilder: (context, index) {
                  final protocol = filteredProtocols[index];
                  final completionRate = ((protocol["completedBy"] as int) / (protocol["totalStaff"] as int)) * 100;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: Color(protocol["color"] as int),
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
                                    "${protocol["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(protocol["color"] as int).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${protocol["category"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(protocol["color"] as int),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: protocol["status"] == "Active" 
                                            ? successColor.withAlpha(20)
                                            : warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${protocol["status"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: protocol["status"] == "Active" 
                                              ? successColor
                                              : warningColor,
                                            fontWeight: FontWeight.w600,
                                          ),
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
                                color: protocol["priority"] == "High" 
                                  ? dangerColor.withAlpha(20)
                                  : infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${protocol["priority"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: protocol["priority"] == "High" 
                                    ? dangerColor
                                    : infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        Text(
                          "${protocol["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: spSm),
                        
                        // Progress Info
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Staff Completion",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  LinearProgressIndicator(
                                    value: completionRate / 100,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      completionRate >= 80 ? successColor : 
                                      completionRate >= 50 ? warningColor : dangerColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${protocol["completedBy"]}/${protocol["totalStaff"]} staff (${completionRate.toStringAsFixed(0)}%)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Steps",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${protocol["steps"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        Row(
                          children: [
                            Text(
                              "Updated: ${DateTime.parse(protocol["lastUpdated"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo(HhaSafetyProtocolDetailView(protocol: protocol));
                              },
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
}
