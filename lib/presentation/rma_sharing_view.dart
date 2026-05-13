import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaSharingView extends StatefulWidget {
  const RmaSharingView({super.key});

  @override
  State<RmaSharingView> createState() => _RmaSharingViewState();
}

class _RmaSharingViewState extends State<RmaSharingView> {
  String selectedReport = "portfolio_summary";
  String shareMethod = "link";
  String recipientEmail = "";
  String message = "";
  List<String> selectedContacts = [];
  bool includeGraphs = true;
  bool includeDetailedData = true;
  bool allowEditing = false;

  List<Map<String, dynamic>> availableReports = [
    {
      "id": "portfolio_summary",
      "title": "Portfolio Summary",
      "description": "Overview of all properties and key metrics",
      "icon": Icons.dashboard,
      "size": "2.3 MB"
    },
    {
      "id": "financial_report",
      "title": "Financial Report",
      "description": "Income, expenses, and profitability analysis",
      "icon": Icons.account_balance,
      "size": "1.8 MB"
    },
    {
      "id": "property_details",
      "title": "Property Details",
      "description": "Detailed information for each property",
      "icon": Icons.home,
      "size": "3.1 MB"
    },
    {
      "id": "tenant_report",
      "title": "Tenant Report",
      "description": "Tenant information and lease details",
      "icon": Icons.people,
      "size": "1.5 MB"
    },
    {
      "id": "maintenance_log",
      "title": "Maintenance Log",
      "description": "Property maintenance history and scheduled tasks",
      "icon": Icons.build,
      "size": "2.7 MB"
    },
    {
      "id": "market_analysis",
      "title": "Market Analysis",
      "description": "Local market trends and property valuations",
      "icon": Icons.trending_up,
      "size": "4.2 MB"
    },
  ];

  List<Map<String, dynamic>> shareMethods = [
    {
      "id": "link",
      "title": "Share Link",
      "description": "Generate a secure link to view the report",
      "icon": Icons.link,
      "features": ["Password protected", "Expiration date", "View tracking"]
    },
    {
      "id": "email",
      "title": "Email Report",
      "description": "Send report directly to email addresses",
      "icon": Icons.email,
      "features": ["PDF attachment", "Custom message", "Delivery confirmation"]
    },
    {
      "id": "download",
      "title": "Download & Share",
      "description": "Download file to share manually",
      "icon": Icons.download,
      "features": ["Multiple formats", "High resolution", "Offline access"]
    },
    {
      "id": "collaborate",
      "title": "Collaborative View",
      "description": "Allow others to view and comment",
      "icon": Icons.group,
      "features": ["Real-time comments", "Edit permissions", "Version history"]
    },
  ];

  List<Map<String, dynamic>> recentContacts = [
    {
      "name": "John Smith",
      "email": "john.smith@email.com",
      "role": "Property Manager",
      "avatar": "https://picsum.photos/50/50?random=1",
      "lastShared": "2024-01-10"
    },
    {
      "name": "Sarah Johnson",
      "email": "sarah.johnson@realty.com",
      "role": "Real Estate Agent",
      "avatar": "https://picsum.photos/50/50?random=2",
      "lastShared": "2024-01-08"
    },
    {
      "name": "Mike Davis",
      "email": "mike.davis@investments.com",
      "role": "Investment Partner",
      "avatar": "https://picsum.photos/50/50?random=3",
      "lastShared": "2024-01-05"
    },
    {
      "name": "Emily Brown",
      "email": "emily.brown@accounting.com",
      "role": "Accountant",
      "avatar": "https://picsum.photos/50/50?random=4",
      "lastShared": "2024-01-03"
    },
  ];

  List<Map<String, dynamic>> shareHistory = [
    {
      "report": "Portfolio Summary",
      "recipient": "john.smith@email.com",
      "method": "Email",
      "date": "2024-01-15",
      "status": "Delivered",
      "views": 3
    },
    {
      "report": "Financial Report",
      "recipient": "Shared Link",
      "method": "Link",
      "date": "2024-01-12",
      "status": "Active",
      "views": 12
    },
    {
      "report": "Market Analysis",
      "recipient": "sarah.johnson@realty.com",
      "method": "Collaborative",
      "date": "2024-01-10",
      "status": "Viewed",
      "views": 8
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Reports"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Share Your Reports",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Collaborate with your team and stakeholders",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHeaderStat(
                          "Reports Shared",
                          "147",
                          Icons.share,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat(
                          "Active Links",
                          "23",
                          Icons.link,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat(
                          "Total Views",
                          "1,284",
                          Icons.visibility,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Select Report
            Text(
              "Select Report to Share",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: availableReports.map((report) {
                bool isSelected = selectedReport == report["id"];
                return GestureDetector(
                  onTap: () {
                    selectedReport = report["id"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isSelected 
                                  ? primaryColor 
                                  : primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                report["icon"] as IconData,
                                color: isSelected ? Colors.white : primaryColor,
                                size: 24,
                              ),
                            ),
                            Spacer(),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                                size: 24,
                              ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${report["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${report["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${report["size"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Share Method
            Text(
              "Choose Sharing Method",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...shareMethods.map((method) {
              bool isSelected = shareMethod == method["id"];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: GestureDetector(
                  onTap: () {
                    shareMethod = method["id"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected 
                              ? primaryColor 
                              : primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            method["icon"] as IconData,
                            color: isSelected ? Colors.white : primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${method["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${method["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Wrap(
                                spacing: spSm,
                                children: (method["features"] as List<String>).map((feature) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      feature,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.radio_button_checked,
                            color: primaryColor,
                            size: 24,
                          )
                        else
                          Icon(
                            Icons.radio_button_unchecked,
                            color: disabledColor,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: spLg),

            // Sharing Options
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sharing Configuration",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  if (shareMethod == "email" || shareMethod == "collaborate") ...[
                    QTextField(
                      label: "Recipient Email",
                      value: recipientEmail,
                      hint: "Enter email address",
                      onChanged: (value) {
                        recipientEmail = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                  ],

                  QMemoField(
                    label: "Message (Optional)",
                    value: message,
                    hint: "Add a personal message...",
                    onChanged: (value) {
                      message = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),

                  // Options
                  Text(
                    "Report Options",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Include Graphs and Charts",
                        "value": "graphs",
                        "checked": includeGraphs,
                      }
                    ],
                    value: [
                      if (includeGraphs)
                        {
                          "label": "Include Graphs and Charts",
                          "value": "graphs",
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      includeGraphs = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  
                  QSwitch(
                    items: [
                      {
                        "label": "Include Detailed Data",
                        "value": "detailed",
                        "checked": includeDetailedData,
                      }
                    ],
                    value: [
                      if (includeDetailedData)
                        {
                          "label": "Include Detailed Data",
                          "value": "detailed",
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      includeDetailedData = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  if (shareMethod == "collaborate") ...[
                    SizedBox(height: spSm),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow Editing",
                          "value": "editing",
                          "checked": allowEditing,
                        }
                      ],
                      value: [
                        if (allowEditing)
                          {
                            "label": "Allow Editing",
                            "value": "editing",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        allowEditing = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],

                  SizedBox(height: spLg),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: _getShareButtonText(),
                      size: bs.md,
                      onPressed: () {
                        _shareReport();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Recent Contacts (if email or collaborate)
            if (shareMethod == "email" || shareMethod == "collaborate") ...[
              Text(
                "Recent Contacts",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...recentContacts.map((contact) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${contact["avatar"]}",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${contact["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${contact["email"]} • ${contact["role"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Last shared: ${contact["lastShared"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Share",
                        size: bs.sm,
                        onPressed: () {
                          recipientEmail = contact["email"];
                          setState(() {});
                          ss("Contact selected: ${contact["name"]}");
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: spLg),
            ],

            // Share History
            Text(
              "Recent Shares",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...shareHistory.map((share) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getMethodIcon(share["method"]),
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${share["report"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${share["recipient"]} • ${share["method"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${share["date"]} • ${share["views"]} views",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
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
                        color: _getStatusColor(share["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${share["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(share["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  String _getShareButtonText() {
    switch (shareMethod) {
      case "link":
        return "Generate Share Link";
      case "email":
        return "Send Email";
      case "download":
        return "Download Report";
      case "collaborate":
        return "Create Collaborative View";
      default:
        return "Share Report";
    }
  }

  void _shareReport() {
    String reportTitle = availableReports.firstWhere(
      (report) => report["id"] == selectedReport,
      orElse: () => {"title": "Report"}
    )["title"];

    switch (shareMethod) {
      case "link":
        ss("Share link generated for $reportTitle! Link copied to clipboard.");
        break;
      case "email":
        if (recipientEmail.isEmpty) {
          se("Please enter recipient email address");
          return;
        }
        ss("$reportTitle sent successfully to $recipientEmail!");
        break;
      case "download":
        ss("$reportTitle downloaded successfully!");
        break;
      case "collaborate":
        if (recipientEmail.isEmpty) {
          se("Please enter collaborator email address");
          return;
        }
        ss("Collaborative view created for $reportTitle! Invitation sent to $recipientEmail.");
        break;
    }

    // Reset form
    recipientEmail = "";
    message = "";
    setState(() {});
  }

  IconData _getMethodIcon(String method) {
    switch (method) {
      case "Link":
        return Icons.link;
      case "Email":
        return Icons.email;
      case "Download":
        return Icons.download;
      case "Collaborative":
        return Icons.group;
      default:
        return Icons.share;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "Active":
        return warningColor;
      case "Viewed":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
