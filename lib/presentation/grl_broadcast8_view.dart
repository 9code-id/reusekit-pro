import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast8View extends StatefulWidget {
  @override
  State<GrlBroadcast8View> createState() => _GrlBroadcast8ViewState();
}

class _GrlBroadcast8ViewState extends State<GrlBroadcast8View> {
  String broadcastTitle = "";
  String description = "";
  String selectedCategory = "Technology";
  String streamKey = "sk-live-abc123def456";
  bool isScheduled = false;
  DateTime scheduledDate = DateTime.now().add(Duration(hours: 2));
  TimeOfDay scheduledTime = TimeOfDay.now();
  bool enableChat = true;
  bool allowComments = true;
  bool recordStream = true;
  String visibility = "Public";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Technology", "value": "Technology"},
    {"label": "Gaming", "value": "Gaming"},
    {"label": "Education", "value": "Education"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
    {"label": "News", "value": "News"},
    {"label": "Lifestyle", "value": "Lifestyle"},
  ];

  List<Map<String, dynamic>> visibilityOptions = [
    {"label": "Public", "value": "Public"},
    {"label": "Unlisted", "value": "Unlisted"},
    {"label": "Private", "value": "Private"},
  ];

  List<Map<String, dynamic>> recentTemplates = [
    {
      "id": 1,
      "name": "Tech Talk Template",
      "description": "Weekly technology discussion",
      "category": "Technology",
      "thumbnail": "https://picsum.photos/100/80?random=1&keyword=tech",
      "useCount": 12
    },
    {
      "id": 2,
      "name": "Q&A Session",
      "description": "Interactive question and answer",
      "category": "Education",
      "thumbnail": "https://picsum.photos/100/80?random=2&keyword=qa",
      "useCount": 8
    },
    {
      "id": 3,
      "name": "Product Demo",
      "description": "Product demonstration and review",
      "category": "Technology",
      "thumbnail": "https://picsum.photos/100/80?random=3&keyword=product",
      "useCount": 6
    }
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: spLg),
              _buildQuickTemplates(),
              SizedBox(height: spLg),
              _buildBasicSettings(),
              SizedBox(height: spLg),
              _buildScheduleSettings(),
              SizedBox(height: spLg),
              _buildStreamSettings(),
              SizedBox(height: spLg),
              _buildAdvancedSettings(),
              SizedBox(height: spLg),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.settings_applications,
            color: Colors.white,
            size: 28,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Broadcast Settings",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Configure your stream settings and preferences",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: successColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: successColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Ready to Stream",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickTemplates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.description,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Quick Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "Create Template",
              size: bs.sm,
              onPressed: () {
                si("Template creation opened");
              },
            ),
          ],
        ),
        SizedBox(height: spMd),
        QHorizontalScroll(
          children: recentTemplates.map((template) {
            return Container(
              width: 250,
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                    child: Image.network(
                      "${template["thumbnail"]}",
                      width: double.infinity,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${template["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${template["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Used ${template["useCount"]}x",
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
                          child: QButton(
                            label: "Use Template",
                            size: bs.sm,
                            onPressed: () {
                              broadcastTitle = "${template["name"]}";
                              description = "${template["description"]}";
                              selectedCategory = "${template["category"]}";
                              setState(() {});
                              ss("Template applied successfully");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBasicSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Broadcast Title",
            value: broadcastTitle,
            hint: "Enter an engaging title for your stream",
            validator: Validator.required,
            onChanged: (value) {
              broadcastTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Describe what your broadcast is about",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Visibility",
                  items: visibilityOptions,
                  value: visibility,
                  onChanged: (value, label) {
                    visibility = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Schedule Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Schedule for later",
                      "value": "schedule",
                      "checked": isScheduled,
                    }
                  ],
                  value: [
                    if (isScheduled)
                      {
                        "label": "Schedule for later",
                        "value": "schedule",
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    isScheduled = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (isScheduled) ...[
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Broadcast Date",
                    value: scheduledDate,
                    onChanged: (value) {
                      scheduledDate = value!;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTimePicker(
                    label: "Broadcast Time",
                    value: scheduledTime,
                    onChanged: (value) {
                      scheduledTime = value!;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStreamSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings_input_antenna,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Stream Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stream Key",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Text(
                          streamKey,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "monospace",
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.copy,
                      size: bs.sm,
                      onPressed: () {
                        ss("Stream key copied to clipboard");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {
                        streamKey = "sk-live-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
                        setState(() {});
                        si("Stream key regenerated");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          _buildQualitySettings(),
        ],
      ),
    );
  }

  Widget _buildQualitySettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quality Settings",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildQualityOption("HD", "720p", true),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildQualityOption("FHD", "1080p", false),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildQualityOption("4K", "2160p", false),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQualityOption(String label, String resolution, bool isSelected) {
    return GestureDetector(
      onTap: () {
        si("Quality set to $label");
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
            ),
            Text(
              resolution,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedSettings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tune,
                color: secondaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Advanced Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Enable live chat",
                          "value": "chat",
                          "checked": enableChat,
                        }
                      ],
                      value: [
                        if (enableChat)
                          {
                            "label": "Enable live chat",
                            "value": "chat",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        enableChat = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Allow comments and reactions",
                          "value": "comments",
                          "checked": allowComments,
                        }
                      ],
                      value: [
                        if (allowComments)
                          {
                            "label": "Allow comments and reactions",
                            "value": "comments",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        allowComments = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Record stream for later viewing",
                          "value": "record",
                          "checked": recordStream,
                        }
                      ],
                      value: [
                        if (recordStream)
                          {
                            "label": "Record stream for later viewing",
                            "value": "record",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        recordStream = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "Save as Template",
            size: bs.md,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ss("Settings saved as template");
              }
            },
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          flex: 2,
          child: QButton(
            label: isScheduled ? "Schedule Broadcast" : "Start Broadcasting",
            size: bs.md,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (broadcastTitle.isEmpty) {
                  se("Please enter broadcast title");
                  return;
                }
                
                if (isScheduled) {
                  ss("Broadcast scheduled successfully");
                } else {
                  ss("Broadcast started successfully");
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
