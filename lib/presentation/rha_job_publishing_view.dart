import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobPublishingView extends StatefulWidget {
  const RhaJobPublishingView({super.key});

  @override
  State<RhaJobPublishingView> createState() => _RhaJobPublishingViewState();
}

class _RhaJobPublishingViewState extends State<RhaJobPublishingView> {
  final formKey = GlobalKey<FormState>();
  
  String jobTitle = "Senior Flutter Developer";
  String publishDate = "2024-06-20";
  String expiryDate = "2024-08-20";
  String visibility = "Public";
  bool autoRenewal = false;
  bool featuredListing = true;
  bool urgentHiring = false;
  bool allowApplications = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  
  List<String> selectedJobBoards = ["Company Website", "LinkedIn"];
  List<Map<String, dynamic>> availableJobBoards = [
    {
      "name": "Company Website",
      "type": "Internal",
      "cost": "Free",
      "audience": "Direct visitors",
      "features": ["Company branding", "Direct applications"],
      "selected": true,
    },
    {
      "name": "LinkedIn",
      "type": "Professional",
      "cost": "\$299/month",
      "audience": "Professional network",
      "features": ["Professional targeting", "Large reach"],
      "selected": true,
    },
    {
      "name": "Indeed",
      "type": "General",
      "cost": "\$150/month",
      "audience": "General job seekers",
      "features": ["Wide reach", "Easy application"],
      "selected": false,
    },
    {
      "name": "Glassdoor",
      "type": "Professional",
      "cost": "\$200/month",
      "audience": "Company-conscious seekers",
      "features": ["Company reviews", "Salary insights"],
      "selected": false,
    },
    {
      "name": "Stack Overflow",
      "type": "Tech-focused",
      "cost": "\$350/month",
      "audience": "Developers",
      "features": ["Developer community", "Tech-specific"],
      "selected": false,
    },
    {
      "name": "AngelList",
      "type": "Startup",
      "cost": "\$250/month",
      "audience": "Startup enthusiasts",
      "features": ["Startup focus", "Equity options"],
      "selected": false,
    },
  ];
  
  List<Map<String, dynamic>> visibilityItems = [
    {"label": "Public", "value": "Public"},
    {"label": "Private", "value": "Private"},
    {"label": "Internal Only", "value": "Internal Only"},
    {"label": "Referral Only", "value": "Referral Only"},
  ];

  Map<String, dynamic> publishingStats = {
    "estimatedReach": 15000,
    "estimatedApplications": 45,
    "totalCost": 549,
    "publishingDuration": 60,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publish Job"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              _showPublishingPreview();
            },
          ),
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              _schedulePublishing();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              // Job Information Section
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
                    Text(
                      "Job Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Job Title",
                      value: jobTitle,
                      validator: Validator.required,
                      onChanged: (value) {
                        jobTitle = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Publish Date",
                            value: DateTime.parse(publishDate),
                            onChanged: (value) {
                              publishDate = value.toString().split(' ')[0];
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Expiry Date",
                            value: DateTime.parse(expiryDate),
                            onChanged: (value) {
                              expiryDate = value.toString().split(' ')[0];
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Visibility",
                      items: visibilityItems,
                      value: visibility,
                      onChanged: (value, label) {
                        visibility = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Publishing Options Section
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
                    Text(
                      "Publishing Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Featured Listing (+\$99/month)",
                          "value": true,
                          "checked": featuredListing,
                        }
                      ],
                      value: [
                        if (featuredListing)
                          {
                            "label": "Featured Listing (+\$99/month)",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        featuredListing = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Urgent Hiring Badge (+\$49/month)",
                          "value": true,
                          "checked": urgentHiring,
                        }
                      ],
                      value: [
                        if (urgentHiring)
                          {
                            "label": "Urgent Hiring Badge (+\$49/month)",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        urgentHiring = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Auto-Renewal",
                          "value": true,
                          "checked": autoRenewal,
                        }
                      ],
                      value: [
                        if (autoRenewal)
                          {
                            "label": "Auto-Renewal",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        autoRenewal = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow Applications",
                          "value": true,
                          "checked": allowApplications,
                        }
                      ],
                      value: [
                        if (allowApplications)
                          {
                            "label": "Allow Applications",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        allowApplications = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Job Boards Selection Section
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
                        Expanded(
                          child: Text(
                            "Select Job Boards",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Select All",
                          size: bs.sm,
                          onPressed: () {
                            for (var board in availableJobBoards) {
                              board["selected"] = true;
                            }
                            selectedJobBoards = availableJobBoards
                                .map((board) => board["name"] as String)
                                .toList();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    ...availableJobBoards.map((board) {
                      return Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (board["selected"] as bool)
                              ? primaryColor.withAlpha(10)
                              : Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(
                            color: (board["selected"] as bool)
                                ? primaryColor.withAlpha(30)
                                : Colors.grey.withAlpha(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: board["selected"] as bool,
                              onChanged: (value) {
                                board["selected"] = value ?? false;
                                if (value == true) {
                                  if (!selectedJobBoards.contains(board["name"])) {
                                    selectedJobBoards.add(board["name"]);
                                  }
                                } else {
                                  selectedJobBoards.remove(board["name"]);
                                }
                                setState(() {});
                              },
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${board["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${board["type"]}",
                                          style: TextStyle(
                                            color: infoColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${board["cost"]}",
                                        style: TextStyle(
                                          color: board["cost"] == "Free"
                                              ? successColor
                                              : warningColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Audience: ${board["audience"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: spXs,
                                    children: (board["features"] as List).map((feature) {
                                      return Text(
                                        "• $feature",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 10,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Notification Settings Section
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
                    Text(
                      "Notification Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Email Notifications",
                          "value": true,
                          "checked": emailNotifications,
                        }
                      ],
                      value: [
                        if (emailNotifications)
                          {
                            "label": "Email Notifications",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        emailNotifications = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "SMS Notifications",
                          "value": true,
                          "checked": smsNotifications,
                        }
                      ],
                      value: [
                        if (smsNotifications)
                          {
                            "label": "SMS Notifications",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        smsNotifications = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Publishing Stats Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Publishing Estimates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${(publishingStats["estimatedReach"] as int) ~/ 1000}K",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Est. Reach",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${publishingStats["estimatedApplications"]}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Est. Applications",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "\$${publishingStats["totalCost"]}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "Total Cost",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Draft",
                      size: bs.md,
                      onPressed: () {
                        ss("Publishing settings saved as draft");
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Publish Now",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _confirmPublishing();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPublishingPreview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Publishing Preview"),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  jobTitle,
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text("Publish Date: $publishDate"),
                Text("Expiry Date: $expiryDate"),
                Text("Visibility: $visibility"),
                SizedBox(height: spSm),
                Text(
                  "Selected Job Boards:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...selectedJobBoards.map((board) => Text("• $board")).toList(),
                SizedBox(height: spSm),
                Text(
                  "Special Features:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (featuredListing) Text("• Featured Listing"),
                if (urgentHiring) Text("• Urgent Hiring Badge"),
                if (autoRenewal) Text("• Auto-Renewal Enabled"),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _schedulePublishing() {
    String scheduledDate = publishDate;
    String scheduledTime = "09:00";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Schedule Publishing"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDatePicker(
                label: "Scheduled Date",
                value: DateTime.parse(scheduledDate),
                onChanged: (value) => scheduledDate = value.toString().split(' ')[0],
              ),
              QTimePicker(
                label: "Scheduled Time",
                value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $scheduledTime:00")),
                onChanged: (value) => scheduledTime = value!.kkmm,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Publishing scheduled for $scheduledDate at $scheduledTime");
            },
            child: Text("Schedule"),
          ),
        ],
      ),
    );
  }

  void _confirmPublishing() async {
    bool isConfirmed = await confirm(
        "Publish job to ${selectedJobBoards.length} job boards?\n\nTotal cost: \$${publishingStats["totalCost"]}/month");
    
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Job published successfully to all selected platforms");
    }
  }
}
