import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaParentalControlsView extends StatefulWidget {
  const GeaParentalControlsView({super.key});

  @override
  State<GeaParentalControlsView> createState() => _GeaParentalControlsViewState();
}

class _GeaParentalControlsViewState extends State<GeaParentalControlsView> {
  bool contentFiltering = true;
  bool timeLimits = true;
  bool socialFeatures = false;
  bool purchaseRestrictions = true;
  bool locationServices = false;
  
  String selectedTimeLimit = "2 hours";
  String selectedContentRating = "E for Everyone";
  String parentPin = "";
  
  List<Map<String, dynamic>> timeLimitOptions = [
    {"label": "30 minutes", "value": "30 minutes"},
    {"label": "1 hour", "value": "1 hour"},
    {"label": "2 hours", "value": "2 hours"},
    {"label": "3 hours", "value": "3 hours"},
    {"label": "No limit", "value": "No limit"},
  ];

  List<Map<String, dynamic>> contentRatingOptions = [
    {"label": "Early Childhood (EC)", "value": "Early Childhood"},
    {"label": "Everyone (E)", "value": "E for Everyone"},
    {"label": "Everyone 10+ (E10+)", "value": "E10+"},
    {"label": "Teen (T)", "value": "Teen"},
  ];

  List<Map<String, dynamic>> activityLog = [
    {
      "activity": "Played 'Adventure Quest'",
      "duration": "45 minutes",
      "timestamp": "Today, 3:30 PM",
      "rating": "E",
    },
    {
      "activity": "Attempted to access 'Battle Arena'",
      "duration": "Blocked",
      "timestamp": "Today, 2:15 PM",
      "rating": "T",
    },
    {
      "activity": "Completed 'Math Puzzles'",
      "duration": "30 minutes",
      "timestamp": "Yesterday, 4:20 PM",
      "rating": "E",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parental Controls"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              //navigateTo('ParentalControlsHelpView')
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
            // Child Profile Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: primaryColor,
                    child: Text(
                      "JD",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Doe (Age 10)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Child Account • Active Now",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
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
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Protected",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.pause_circle,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Pause Gaming",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.bedtime,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Bedtime Mode",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.analytics,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "View Report",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Control Settings
            Text(
              "Control Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            // Content Filtering
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.filter_alt,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Content Filtering",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Switch(
                        value: contentFiltering,
                        onChanged: (value) {
                          contentFiltering = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  if (contentFiltering) ...[
                    Text(
                      "Block inappropriate content based on age rating",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    QDropdownField(
                      label: "Maximum Content Rating",
                      items: contentRatingOptions,
                      value: selectedContentRating,
                      onChanged: (value, label) {
                        selectedContentRating = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Time Limits
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Daily Time Limits",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Switch(
                        value: timeLimits,
                        onChanged: (value) {
                          timeLimits = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  if (timeLimits) ...[
                    Text(
                      "Set maximum daily gaming time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    QDropdownField(
                      label: "Daily Time Limit",
                      items: timeLimitOptions,
                      value: selectedTimeLimit,
                      onChanged: (value, label) {
                        selectedTimeLimit = value;
                        setState(() {});
                      },
                    ),
                    
                    // Time remaining today
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "1 hour 15 minutes remaining today",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Other Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildControlRow(
                    "Social Features",
                    "Chat, friend requests, and community features",
                    Icons.group,
                    socialFeatures,
                    (value) => setState(() => socialFeatures = value),
                  ),
                  Divider(),
                  _buildControlRow(
                    "Purchase Restrictions",
                    "Block in-app purchases and premium content",
                    Icons.block,
                    purchaseRestrictions,
                    (value) => setState(() => purchaseRestrictions = value),
                  ),
                  Divider(),
                  _buildControlRow(
                    "Location Services",
                    "Allow location-based features and games",
                    Icons.location_on,
                    locationServices,
                    (value) => setState(() => locationServices = value),
                  ),
                ],
              ),
            ),

            // Parent PIN
            Text(
              "Security",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Parent PIN Protection",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Require PIN to modify parental controls",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  QButton(
                    label: parentPin.isEmpty ? "Set Parent PIN" : "Change Parent PIN",
                    size: bs.sm,
                    onPressed: () {
                      //showParentPinDialog()
                    },
                  ),
                ],
              ),
            ),

            // Activity Log
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: activityLog.asMap().entries.map((entry) {
                  final index = entry.key;
                  final activity = entry.value;
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index < activityLog.length - 1 
                          ? Border(bottom: BorderSide(color: disabledColor))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: activity["duration"] == "Blocked" 
                                ? dangerColor
                                : successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${activity["rating"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["activity"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${activity["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${activity["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: activity["duration"] == "Blocked" 
                                ? dangerColor
                                : successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Full Report",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('ActivityReportView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Emergency Override",
                    size: bs.md,
                    onPressed: () {
                      //showEmergencyOverrideDialog()
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlRow(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
