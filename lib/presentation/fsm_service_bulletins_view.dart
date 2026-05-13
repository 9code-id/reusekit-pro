import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmServiceBulletinsView extends StatefulWidget {
  const FsmServiceBulletinsView({super.key});

  @override
  State<FsmServiceBulletinsView> createState() => _FsmServiceBulletinsViewState();
}

class _FsmServiceBulletinsViewState extends State<FsmServiceBulletinsView> {
  List<Map<String, dynamic>> bulletins = [
    {
      "id": "SB001",
      "title": "Critical Security Update for Fire Safety Systems v3.1",
      "category": "Security Update",
      "priority": "Critical",
      "manufacturer": "SafeTech Systems",
      "affectedModels": ["Fire Safety System v3.1", "Fire Safety System v3.0"],
      "publishDate": "2024-06-18",
      "effectiveDate": "2024-06-20",
      "expiryDate": "2024-12-20",
      "status": "Active",
      "description": "Important security update addressing vulnerability in network communication protocols. Immediate action required for all installations.",
      "actionRequired": "Install firmware update v3.1.2 within 48 hours",
      "estimatedTime": "2 hours",
      "skillLevel": "Advanced",
      "safetyRating": "High Risk",
      "attachments": ["security_patch_v3.1.2.zip", "installation_guide.pdf"],
      "affectedCount": 15,
      "isRead": false,
      "isBookmarked": true
    },
    {
      "id": "SB002",
      "title": "Preventive Maintenance Update - HVAC Pro Series 500",
      "category": "Maintenance",
      "priority": "High",
      "manufacturer": "Climate Solutions Corp",
      "affectedModels": ["HVAC System Pro Series 500", "HVAC System Pro Series 400"],
      "publishDate": "2024-06-15",
      "effectiveDate": "2024-07-01",
      "expiryDate": "2024-12-31",
      "status": "Active",
      "description": "Updated maintenance schedule and procedures to improve system efficiency and extend component lifespan.",
      "actionRequired": "Update maintenance procedures and schedule quarterly filter replacements",
      "estimatedTime": "30 minutes",
      "skillLevel": "Intermediate",
      "safetyRating": "Low Risk",
      "attachments": ["maintenance_schedule_v2.pdf", "filter_specs.pdf"],
      "affectedCount": 8,
      "isRead": true,
      "isBookmarked": false
    },
    {
      "id": "SB003",
      "title": "Product Recall Notice - Conveyor Belt MK4 Drive Motors",
      "category": "Recall",
      "priority": "Critical",
      "manufacturer": "Industrial Motion Ltd",
      "affectedModels": ["Conveyor Belt System MK4"],
      "publishDate": "2024-06-10",
      "effectiveDate": "2024-06-12",
      "expiryDate": "2024-09-12",
      "status": "Active",
      "description": "Voluntary recall of drive motors manufactured between Jan-Mar 2024 due to potential overheating issues.",
      "actionRequired": "Inspect motor serial numbers and contact manufacturer for replacement if affected",
      "estimatedTime": "4 hours",
      "skillLevel": "Expert",
      "safetyRating": "High Risk",
      "attachments": ["recall_notice.pdf", "serial_check_tool.exe", "replacement_procedure.pdf"],
      "affectedCount": 3,
      "isRead": true,
      "isBookmarked": true
    },
    {
      "id": "SB004",
      "title": "Performance Enhancement - Generator X200 Fuel Efficiency",
      "category": "Enhancement",
      "priority": "Medium",
      "manufacturer": "PowerTech Industries",
      "affectedModels": ["Industrial Generator Model X200", "Industrial Generator Model X150"],
      "publishDate": "2024-06-05",
      "effectiveDate": "2024-07-15",
      "expiryDate": "2025-01-15",
      "status": "Active",
      "description": "Optional performance enhancement to improve fuel efficiency by up to 15% through ECU calibration update.",
      "actionRequired": "Schedule ECU calibration update during next maintenance window",
      "estimatedTime": "1 hour",
      "skillLevel": "Intermediate",
      "safetyRating": "Low Risk",
      "attachments": ["ecu_update_v2.4.bin", "calibration_guide.pdf"],
      "affectedCount": 5,
      "isRead": false,
      "isBookmarked": false
    },
    {
      "id": "SB005",
      "title": "Software Update - Security Camera Network HD Analytics",
      "category": "Software Update",
      "priority": "Medium",
      "manufacturer": "SecureVision Technologies",
      "affectedModels": ["Security Camera Network HD", "Security Camera Network SD"],
      "publishDate": "2024-05-28",
      "effectiveDate": "2024-06-30",
      "expiryDate": "2024-11-30",
      "status": "Active",
      "description": "New analytics features and improved motion detection algorithms. Enhanced facial recognition capabilities included.",
      "actionRequired": "Update camera firmware to version 4.2.1 and configure new analytics settings",
      "estimatedTime": "45 minutes",
      "skillLevel": "Beginner",
      "safetyRating": "No Risk",
      "attachments": ["firmware_v4.2.1.zip", "analytics_config.pdf", "feature_guide.pdf"],
      "affectedCount": 12,
      "isRead": true,
      "isBookmarked": false
    },
    {
      "id": "SB006",
      "title": "Safety Alert - Electrical Safety in Wet Conditions",
      "category": "Safety Alert",
      "priority": "High",
      "manufacturer": "Safety First Corp",
      "affectedModels": ["All Electrical Equipment"],
      "publishDate": "2024-05-20",
      "effectiveDate": "2024-05-22",
      "expiryDate": "2024-11-22",
      "status": "Active",
      "description": "Important safety reminder regarding electrical equipment operation in wet or humid conditions during summer months.",
      "actionRequired": "Review electrical safety procedures and ensure proper protective equipment is available",
      "estimatedTime": "15 minutes",
      "skillLevel": "All Levels",
      "safetyRating": "Medium Risk",
      "attachments": ["electrical_safety_guide.pdf", "ppe_checklist.pdf"],
      "affectedCount": 25,
      "isRead": false,
      "isBookmarked": true
    }
  ];

  List<Map<String, dynamic>> filteredBulletins = [];
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedPriority = "All";
  bool showUnreadOnly = false;
  bool showBookmarkedOnly = false;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Security Update", "value": "Security Update"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Recall", "value": "Recall"},
    {"label": "Enhancement", "value": "Enhancement"},
    {"label": "Software Update", "value": "Software Update"},
    {"label": "Safety Alert", "value": "Safety Alert"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  @override
  void initState() {
    super.initState();
    filteredBulletins = bulletins;
  }

  void _filterBulletins() {
    filteredBulletins = bulletins.where((bulletin) {
      bool matchesSearch = bulletin["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          bulletin["manufacturer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          (bulletin["affectedModels"] as List).any((model) => model.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      bool matchesCategory = selectedCategory == "All" || bulletin["category"] == selectedCategory;
      bool matchesPriority = selectedPriority == "All" || bulletin["priority"] == selectedPriority;
      bool matchesUnread = !showUnreadOnly || bulletin["isRead"] == false;
      bool matchesBookmarked = !showBookmarkedOnly || bulletin["isBookmarked"] == true;
      
      return matchesSearch && matchesCategory && matchesPriority && matchesUnread && matchesBookmarked;
    }).toList();
    setState(() {});
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Security Update":
        return dangerColor;
      case "Maintenance":
        return infoColor;
      case "Recall":
        return dangerColor;
      case "Enhancement":
        return successColor;
      case "Software Update":
        return primaryColor;
      case "Safety Alert":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildBulletinCard(Map<String, dynamic> bulletin) {
    bool isRead = bulletin["isRead"] as bool;
    bool isBookmarked = bulletin["isBookmarked"] as bool;
    int affectedCount = bulletin["affectedCount"] as int;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(bulletin["priority"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (!isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              if (!isRead) SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${bulletin["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  bulletin["isBookmarked"] = !isBookmarked;
                  setState(() {});
                },
                child: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  size: 20,
                  color: isBookmarked ? warningColor : disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(bulletin["category"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${bulletin["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getCategoryColor(bulletin["category"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(bulletin["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${bulletin["priority"]} Priority",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor(bulletin["priority"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Published: ${bulletin["publishDate"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manufacturer: ${bulletin["manufacturer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${bulletin["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Action Required:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${bulletin["actionRequired"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Affected Equipment", "$affectedCount units", Icons.inventory),
              ),
              Expanded(
                child: _buildInfoItem("Estimated Time", "${bulletin["estimatedTime"]}", Icons.timer),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Skill Level", "${bulletin["skillLevel"]}", Icons.engineering),
              ),
              Expanded(
                child: _buildInfoItem("Safety Rating", "${bulletin["safetyRating"]}", Icons.security),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Effective Date", "${bulletin["effectiveDate"]}", Icons.calendar_today),
              ),
              Expanded(
                child: _buildInfoItem("Expiry Date", "${bulletin["expiryDate"]}", Icons.event_busy),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Affected Models:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: 4),
          Wrap(
            spacing: spXs,
            runSpacing: 4,
            children: (bulletin["affectedModels"] as List).map((model) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$model",
                  style: TextStyle(
                    fontSize: 9,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          if ((bulletin["attachments"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Text(
              "Attachments (${(bulletin["attachments"] as List).length}):",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: 4),
            ...(bulletin["attachments"] as List).map((attachment) {
              return Container(
                margin: EdgeInsets.only(bottom: 4),
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attachment,
                      size: 14,
                      color: successColor,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "$attachment",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.download,
                      size: 14,
                      color: successColor,
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              if (!isRead)
                Expanded(
                  child: QButton(
                    label: "Mark as Read",
                    size: bs.sm,
                    onPressed: () {
                      bulletin["isRead"] = true;
                      setState(() {});
                    },
                  ),
                ),
              if (!isRead) SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to bulletin details
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Take Action",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to action screen
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    int totalBulletins = bulletins.length;
    int unreadBulletins = bulletins.where((b) => b["isRead"] == false).length;
    int criticalBulletins = bulletins.where((b) => b["priority"] == "Critical").length;
    int bookmarkedBulletins = bulletins.where((b) => b["isBookmarked"] == true).length;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Total Bulletins", "$totalBulletins", Icons.announcement, primaryColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Unread", "$unreadBulletins", Icons.mark_email_unread, warningColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Critical", "$criticalBulletins", Icons.priority_high, dangerColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Bookmarked", "$bookmarkedBulletins", Icons.bookmark, infoColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Bulletins"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications settings
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Advanced filters
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCards(),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Bulletins",
                    value: searchQuery,
                    hint: "Search by title, manufacturer, or model...",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterBulletins();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      _filterBulletins();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorityItems,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      _filterBulletins();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Unread Only",
                        "value": true,
                        "checked": showUnreadOnly,
                      }
                    ],
                    value: [if (showUnreadOnly) {"label": "Unread Only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showUnreadOnly = values.isNotEmpty;
                      _filterBulletins();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Bookmarked Only",
                        "value": true,
                        "checked": showBookmarkedOnly,
                      }
                    ],
                    value: [if (showBookmarkedOnly) {"label": "Bookmarked Only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showBookmarkedOnly = values.isNotEmpty;
                      _filterBulletins();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Service Bulletins (${filteredBulletins.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...filteredBulletins.map((bulletin) => _buildBulletinCard(bulletin)).toList(),
          ],
        ),
      ),
    );
  }
}
