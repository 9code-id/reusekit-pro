import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaCitizenJournalismView extends StatefulWidget {
  const NmaCitizenJournalismView({super.key});

  @override
  State<NmaCitizenJournalismView> createState() => _NmaCitizenJournalismViewState();
}

class _NmaCitizenJournalismViewState extends State<NmaCitizenJournalismView> {
  int currentStep = 0;
  String selectedReportType = "";
  String location = "";
  String title = "";
  String description = "";
  String urgencyLevel = "Medium";
  List<String> attachments = [];
  bool isAnonymous = false;
  bool agreeToTerms = false;

  final List<Map<String, dynamic>> reportTypes = [
    {
      "type": "Breaking News",
      "icon": Icons.flash_on,
      "color": Colors.red,
      "description": "Urgent news happening right now"
    },
    {
      "type": "Community Issue",
      "icon": Icons.group,
      "color": Colors.blue,
      "description": "Problems affecting the community"
    },
    {
      "type": "Infrastructure",
      "icon": Icons.construction,
      "color": Colors.orange,
      "description": "Roads, utilities, public facilities"
    },
    {
      "type": "Public Safety",
      "icon": Icons.security,
      "color": Colors.purple,
      "description": "Safety concerns and incidents"
    },
    {
      "type": "Environmental",
      "icon": Icons.eco,
      "color": Colors.green,
      "description": "Environmental issues and concerns"
    },
    {
      "type": "Local Event",
      "icon": Icons.event,
      "color": Colors.teal,
      "description": "Community events and gatherings"
    },
    {
      "type": "Government",
      "icon": Icons.account_balance,
      "color": Colors.indigo,
      "description": "Government activities and decisions"
    },
    {
      "type": "Business",
      "icon": Icons.business,
      "color": Colors.brown,
      "description": "Local business news and updates"
    }
  ];

  final List<Map<String, dynamic>> submittedReports = [
    {
      "id": "RPT001",
      "title": "Pothole on Main Street",
      "type": "Infrastructure",
      "location": "Main Street & 5th Ave",
      "submittedDate": "2024-01-15",
      "status": "Under Review",
      "urgency": "High",
      "views": 234,
      "upvotes": 45
    },
    {
      "id": "RPT002",
      "title": "Community Park Vandalism",
      "type": "Public Safety",
      "location": "Central Park",
      "submittedDate": "2024-01-12",
      "status": "Published",
      "urgency": "Medium",
      "views": 567,
      "upvotes": 78
    },
    {
      "id": "RPT003",
      "title": "New Local Business Opening",
      "type": "Business",
      "location": "Downtown District",
      "submittedDate": "2024-01-10",
      "status": "Published",
      "urgency": "Low",
      "views": 890,
      "upvotes": 123
    }
  ];

  final List<Map<String, dynamic>> guidelines = [
    {
      "title": "Accuracy First",
      "description": "Ensure all information is factual and verified. Double-check details before submitting.",
      "icon": Icons.fact_check
    },
    {
      "title": "Clear Evidence",
      "description": "Include photos, videos, or documents that support your report when possible.",
      "icon": Icons.photo_camera
    },
    {
      "title": "Respectful Reporting",
      "description": "Report responsibly without bias, discrimination, or inflammatory language.",
      "icon": Icons.balance
    },
    {
      "title": "Privacy Protection",
      "description": "Respect individual privacy. Avoid sharing personal information without consent.",
      "icon": Icons.privacy_tip
    },
    {
      "title": "Timely Submission",
      "description": "Report news and issues as soon as possible while they are still relevant.",
      "icon": Icons.schedule
    },
    {
      "title": "Community Impact",
      "description": "Focus on stories that matter to the local community and public interest.",
      "icon": Icons.public
    }
  ];

  void _nextStep() {
    if (currentStep < 4) {
      currentStep++;
      setState(() {});
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _submitReport() {
    if (title.isNotEmpty && description.isNotEmpty && selectedReportType.isNotEmpty && agreeToTerms) {
      ss("Report submitted successfully for review");
      // Reset form
      currentStep = 0;
      selectedReportType = "";
      location = "";
      title = "";
      description = "";
      urgencyLevel = "Medium";
      attachments = [];
      isAnonymous = false;
      agreeToTerms = false;
      setState(() {});
    } else {
      se("Please fill in all required fields and agree to terms");
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Published":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: List.generate(5, (index) {
          final isActive = index <= currentStep;
          final isCompleted = index < currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isActive ? primaryColor : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(Icons.check, color: Colors.white, size: 16)
                        : Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                if (index < 4)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isCompleted ? primaryColor : Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildReportTypeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Report Type",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Choose the category that best describes your report",
          style: TextStyle(
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          minItemWidth: 200,
          children: reportTypes.map((type) {
            final isSelected = selectedReportType == type["type"];
            
            return GestureDetector(
              onTap: () {
                selectedReportType = type["type"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? (type["color"] as Color).withAlpha(30) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? type["color"] : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Icon(
                      type["icon"],
                      color: type["color"],
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${type["type"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${type["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLocationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location & Urgency",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Provide location details and set urgency level",
          style: TextStyle(
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Location *",
          value: location,
          hint: "Enter specific location (e.g., 123 Main St, Downtown)",
          onChanged: (value) {
            location = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        QDropdownField(
          label: "Urgency Level",
          items: [
            {"label": "Low - Can wait", "value": "Low"},
            {"label": "Medium - Should be addressed", "value": "Medium"},
            {"label": "High - Needs immediate attention", "value": "High"},
          ],
          value: urgencyLevel,
          onChanged: (value, label) {
            urgencyLevel = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: _getUrgencyColor(urgencyLevel).withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: _getUrgencyColor(urgencyLevel)),
          ),
          child: Row(
            children: [
              Icon(
                urgencyLevel == "High" ? Icons.warning : 
                urgencyLevel == "Medium" ? Icons.info : Icons.check_circle,
                color: _getUrgencyColor(urgencyLevel),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  urgencyLevel == "High" 
                      ? "High priority reports are reviewed within 1 hour"
                      : urgencyLevel == "Medium"
                          ? "Medium priority reports are reviewed within 24 hours"
                          : "Low priority reports are reviewed within 3 days",
                  style: TextStyle(
                    color: _getUrgencyColor(urgencyLevel),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Report Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Provide a clear title and detailed description",
          style: TextStyle(
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QTextField(
          label: "Title *",
          value: title,
          hint: "Brief, descriptive title for your report",
          onChanged: (value) {
            title = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        QMemoField(
          label: "Description *",
          value: description,
          hint: "Provide detailed information about what happened, when, and any relevant context",
          onChanged: (value) {
            description = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.tips_and_updates, color: infoColor),
                  SizedBox(width: spSm),
                  Text(
                    "Writing Tips",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "• Use clear, factual language\n• Include specific details (who, what, when, where)\n• Mention any witnesses or sources\n• Avoid speculation or opinion",
                style: TextStyle(
                  color: infoColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attachments & Evidence",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Add photos, videos, or documents to support your report",
          style: TextStyle(
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        QMultiImagePicker(
          label: "Evidence Files",
          value: attachments,
          hint: "Upload photos, videos, or documents",
          maxImages: 10,
          onChanged: (value) {
            attachments = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: warningColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.privacy_tip, color: warningColor),
                  SizedBox(width: spSm),
                  Text(
                    "Privacy Notice",
                    style: TextStyle(
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "• Avoid including personal information of individuals\n• Don't upload copyrighted material\n• Ensure you have permission to share the content",
                style: TextStyle(
                  color: warningColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review & Submit",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Review your report before submitting",
          style: TextStyle(
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      selectedReportType,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getUrgencyColor(urgencyLevel),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$urgencyLevel Priority",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                description,
                style: TextStyle(
                  color: disabledBoldColor,
                  height: 1.4,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    location,
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
              if (attachments.isNotEmpty) ...[
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(Icons.attachment, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${attachments.length} attachments",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        Row(
          children: [
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Submit anonymously",
                    "value": true,
                    "checked": isAnonymous,
                  }
                ],
                value: [
                  if (isAnonymous)
                    {
                      "label": "Submit anonymously",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  isAnonymous = values.isNotEmpty;
                  setState(() {});
                },
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
                    "label": "I agree to the terms and conditions",
                    "value": true,
                    "checked": agreeToTerms,
                  }
                ],
                value: [
                  if (agreeToTerms)
                    {
                      "label": "I agree to the terms and conditions",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  agreeToTerms = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReportingForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildStepIndicator(),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                if (currentStep == 0) _buildReportTypeStep(),
                if (currentStep == 1) _buildLocationStep(),
                if (currentStep == 2) _buildDetailsStep(),
                if (currentStep == 3) _buildAttachmentsStep(),
                if (currentStep == 4) _buildReviewStep(),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    if (currentStep > 0)
                      Expanded(
                        child: QButton(
                          label: "Previous",
                          size: bs.md,
                          onPressed: _previousStep,
                        ),
                      ),
                    if (currentStep > 0) SizedBox(width: spMd),
                    Expanded(
                      child: QButton(
                        label: currentStep == 4 ? "Submit Report" : "Next",
                        size: bs.md,
                        onPressed: () {
                          if (currentStep == 4) {
                            _submitReport();
                          } else if (currentStep == 0 && selectedReportType.isEmpty) {
                            se("Please select a report type");
                          } else if (currentStep == 1 && location.isEmpty) {
                            se("Please enter a location");
                          } else if (currentStep == 2 && (title.isEmpty || description.isEmpty)) {
                            se("Please fill in title and description");
                          } else {
                            _nextStep();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Icon(Icons.article, color: primaryColor, size: 32),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Reports",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Track the status of your submitted reports",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          ...submittedReports.map((report) {
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${report["type"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor(report["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${report["status"]}",
                          style: TextStyle(
                            color: _getStatusColor(report["status"]),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${report["title"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${report["location"]}", style: TextStyle(color: disabledBoldColor)),
                      SizedBox(width: spMd),
                      Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${report["submittedDate"]}", style: TextStyle(color: disabledBoldColor)),
                    ],
                  ),
                  if (report["status"] == "Published") ...[
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text("${report["views"]}", style: TextStyle(color: disabledBoldColor)),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Row(
                          children: [
                            Icon(Icons.thumb_up, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text("${report["upvotes"]}", style: TextStyle(color: disabledBoldColor)),
                          ],
                        ),
                        Spacer(),
                        QButton(
                          label: "View",
                          size: bs.sm,
                          onPressed: () {
                            ss("View report feature coming soon");
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGuidelinesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Icon(Icons.rule, color: Colors.white, size: 32),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reporting Guidelines",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Best practices for citizen journalism",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          ...guidelines.map((guideline) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      guideline["icon"],
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${guideline["title"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${guideline["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Citizen Journalism",
      selectedIndex: currentStep == 0 && selectedReportType.isEmpty ? 0 : 0,
      tabs: [
        Tab(text: "Submit Report", icon: Icon(Icons.add_circle)),
        Tab(text: "My Reports", icon: Icon(Icons.list_alt)),
        Tab(text: "Guidelines", icon: Icon(Icons.rule)),
      ],
      tabChildren: [
        _buildReportingForm(),
        _buildMyReportsTab(),
        _buildGuidelinesTab(),
      ],
    );
  }
}
