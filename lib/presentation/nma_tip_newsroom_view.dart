import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaTipNewsroomView extends StatefulWidget {
  const NmaTipNewsroomView({super.key});

  @override
  State<NmaTipNewsroomView> createState() => _NmaTipNewsroomViewState();
}

class _NmaTipNewsroomViewState extends State<NmaTipNewsroomView> {
  final formKey = GlobalKey<FormState>();
  
  String tipCategory = "General Tip";
  String tipTitle = "";
  String tipDescription = "";
  String location = "";
  String contactInformation = "";
  String whenDidItHappen = "";
  String peopleInvolved = "";
  String evidenceDescription = "";
  List<String> attachments = [];
  bool allowContact = true;
  bool requestAnonymity = false;
  bool agreeToTerms = false;
  bool isUrgent = false;

  List<String> categories = [
    "General Tip",
    "Government/Politics",
    "Business/Finance",
    "Crime/Safety",
    "Environment",
    "Education",
    "Healthcare",
    "Corruption",
    "Public Interest",
    "Community Issue",
    "Transportation",
    "Housing",
  ];

  List<Map<String, dynamic>> tipGuidelines = [
    {
      "icon": Icons.verified,
      "title": "Be Specific",
      "description": "Provide as much detail as possible about what you witnessed or know",
      "color": primaryColor,
    },
    {
      "icon": Icons.privacy_tip,
      "title": "Stay Safe",
      "description": "Don't put yourself at risk to gather information",
      "color": warningColor,
    },
    {
      "icon": Icons.fact_check,
      "title": "Stick to Facts",
      "description": "Share what you know to be true, avoid speculation",
      "color": successColor,
    },
    {
      "icon": Icons.folder,
      "title": "Include Evidence",
      "description": "Photos, documents, or other evidence helps verify your tip",
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> tipExamples = [
    {
      "category": "Government/Politics",
      "title": "City Council Meeting Irregularities",
      "description": "Information about meetings not being conducted according to proper procedures",
    },
    {
      "category": "Business/Finance",
      "title": "Local Business Practices",
      "description": "Concerns about business practices affecting the community",
    },
    {
      "category": "Environment",
      "title": "Environmental Violations",
      "description": "Illegal dumping, pollution, or environmental damage",
    },
    {
      "category": "Public Interest",
      "title": "Public Service Issues",
      "description": "Problems with public services that affect community members",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit News Tip"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showTipGuidelines();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Got a News Tip?",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Help us uncover important stories that matter to your community. All tips are treated confidentially.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Guidelines section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How to Submit a Good Tip",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      minItemWidth: 200,
                      children: tipGuidelines.map((guideline) {
                        return Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (guideline["color"] as Color).withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                guideline["icon"] as IconData,
                                size: 16,
                                color: guideline["color"] as Color,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${guideline["title"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${guideline["description"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Urgency flag
              QSwitch(
                items: [
                  {
                    "label": "This is urgent/time-sensitive",
                    "value": true,
                    "checked": isUrgent,
                  }
                ],
                value: isUrgent ? [{"label": "This is urgent/time-sensitive", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  isUrgent = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Basic Information
              Text(
                "Basic Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QDropdownField(
                label: "Tip Category",
                items: categories.map((category) => {
                  "label": category,
                  "value": category,
                }).toList(),
                value: tipCategory,
                onChanged: (value, label) {
                  tipCategory = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "Tip Title/Summary",
                value: tipTitle,
                hint: "Brief description of your tip",
                validator: Validator.required,
                onChanged: (value) {
                  tipTitle = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "Location",
                value: location,
                hint: "Where is this happening or has happened?",
                onChanged: (value) {
                  location = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "When did this happen?",
                value: whenDidItHappen,
                hint: "Specific date/time or ongoing situation",
                onChanged: (value) {
                  whenDidItHappen = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Detailed Information
              Text(
                "Detailed Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QMemoField(
                label: "Full Description",
                value: tipDescription,
                hint: "Provide as much detail as possible about what you know. Include who, what, when, where, why, and how.",
                validator: Validator.required,
                onChanged: (value) {
                  tipDescription = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "People Involved",
                value: peopleInvolved,
                hint: "Names, titles, or descriptions of people involved (if known)",
                onChanged: (value) {
                  peopleInvolved = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QMemoField(
                label: "Evidence Description",
                value: evidenceDescription,
                hint: "Describe any documents, photos, recordings, or other evidence you have or know about",
                onChanged: (value) {
                  evidenceDescription = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // File attachments
              Text(
                "Supporting Evidence",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      size: 20,
                      color: warningColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Files are encrypted and stored securely. Only authorized editorial staff can access them.",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),

              QAttachmentPicker(
                label: "Evidence Files",
                value: attachments,
                hint: "Upload documents, photos, videos, or audio files",
                maxAttachments: 10,
                allowedTypes: ['image', 'document', 'video', 'audio'],
                onChanged: (value) {
                  attachments = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Contact Information
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QMemoField(
                label: "How can we reach you?",
                value: contactInformation,
                hint: "Email, phone, or preferred contact method (optional but helpful for follow-up questions)",
                onChanged: (value) {
                  contactInformation = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              Column(
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "It's OK to contact me for follow-up questions",
                        "value": true,
                        "checked": allowContact,
                      }
                    ],
                    value: allowContact ? [{"label": "It's OK to contact me for follow-up questions", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      allowContact = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Keep my identity confidential",
                        "value": true,
                        "checked": requestAnonymity,
                      }
                    ],
                    value: requestAnonymity ? [{"label": "Keep my identity confidential", "value": true, "checked": true}] : [],
                    onChanged: (values, ids) {
                      requestAnonymity = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),

              // Examples section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Example Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Here are some examples of newsworthy tips:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: tipExamples.map((example) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(100),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${example["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${example["title"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${example["description"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Terms and agreements
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Important Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: [
                        _buildInfoItem("Your tip will be reviewed by our editorial team"),
                        _buildInfoItem("We may contact you for additional information"),
                        _buildInfoItem("Not all tips will result in published stories"),
                        _buildInfoItem("We protect the confidentiality of our sources"),
                        _buildInfoItem("False information may result in blocking future submissions"),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QSwitch(
                      items: [
                        {
                          "label": "I understand and agree to these terms",
                          "value": true,
                          "checked": agreeToTerms,
                        }
                      ],
                      value: agreeToTerms ? [{"label": "I understand and agree to these terms", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        agreeToTerms = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Tip preview
              if (tipTitle.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Tip Preview",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          if (isUrgent)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "URGENT",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          tipCategory,
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        tipTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (location.isNotEmpty) ...[
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              location,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (tipDescription.isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Text(
                          tipDescription,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (attachments.isNotEmpty) ...[
                        SizedBox(height: spSm),
                        Text(
                          "${attachments.length} file(s) attached",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: spMd),
              ],

              // Submit button
              Container(
                width: double.infinity,
                child: QButton(
                  label: isUrgent ? "Submit Urgent Tip" : "Submit Tip",
                  size: bs.md,
                  onPressed: agreeToTerms && tipTitle.isNotEmpty && tipDescription.isNotEmpty
                      ? () async {
                          if (formKey.currentState!.validate()) {
                            showLoading();
                            
                            // Simulate submission
                            await Future.delayed(Duration(seconds: 2));
                            
                            hideLoading();
                            
                            if (isUrgent) {
                              ss("Urgent tip submitted! Our editorial team will review it immediately.");
                            } else {
                              ss("Tip submitted successfully! Our team will review it and may contact you for follow-up.");
                            }
                            
                            // Clear form
                            _clearForm();
                          }
                        }
                      : null,
                ),
              ),
              SizedBox(height: spMd),

              // Contact information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.contact_support,
                          size: 20,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Alternative Contact Methods",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "If you prefer not to use this form, you can also:",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Column(
                      children: [
                        _buildContactMethod("Email: tips@newsroom.local"),
                        _buildContactMethod("Phone: (555) 123-NEWS"),
                        _buildContactMethod("Secure messaging through our website"),
                        _buildContactMethod("Anonymous tip hotline: (555) 123-TIPS"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethod(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Icon(
            Icons.arrow_right,
            size: 16,
            color: primaryColor,
          ),
          SizedBox(width: spXs),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showTipGuidelines() {
    // Show guidelines dialog or navigate to guidelines page
  }

  void _clearForm() {
    tipTitle = "";
    tipDescription = "";
    location = "";
    contactInformation = "";
    whenDidItHappen = "";
    peopleInvolved = "";
    evidenceDescription = "";
    attachments.clear();
    agreeToTerms = false;
    isUrgent = false;
    requestAnonymity = false;
    allowContact = true;
    tipCategory = "General Tip";
    setState(() {});
  }
}
