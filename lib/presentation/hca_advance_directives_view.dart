import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaAdvanceDirectivesView extends StatefulWidget {
  const HcaAdvanceDirectivesView({super.key});

  @override
  State<HcaAdvanceDirectivesView> createState() => _HcaAdvanceDirectivesViewState();
}

class _HcaAdvanceDirectivesViewState extends State<HcaAdvanceDirectivesView> {
  bool hasAdvanceDirective = true;
  bool hasLivingWill = true;
  bool hasPowerOfAttorney = true;
  bool hasHIPAAAuthorization = true;
  
  String livingWillPreferences = "I do not want my life to be prolonged if I am in a persistent vegetative state with no reasonable expectation of recovery. I prefer comfort care and pain management.";
  String powerOfAttorneyName = "Sarah Johnson";
  String powerOfAttorneyPhone = "(555) 123-4567";
  String powerOfAttorneyEmail = "sarah.johnson@email.com";
  String alternateAttorneyName = "Michael Johnson";
  String alternateAttorneyPhone = "(555) 987-6543";
  String alternateAttorneyEmail = "mike.johnson@email.com";
  String additionalInstructions = "Please contact my spiritual advisor Father Martinez at St. Mary's Church before making any major medical decisions.";
  
  DateTime directiveDate = DateTime(2023, 8, 15);
  DateTime lastUpdated = DateTime(2024, 11, 20);
  String witnessName1 = "Dr. Emily Chen";
  String witnessName2 = "Robert Wilson";
  
  List<Map<String, dynamic>> medicalPreferences = [
    {
      "category": "Life Support",
      "preference": "Limited",
      "description": "Use life support only if there's reasonable chance of recovery",
      "selected": true,
      "icon": Icons.monitor_heart
    },
    {
      "category": "Resuscitation (CPR)",
      "preference": "Yes",
      "description": "Attempt resuscitation in case of cardiac arrest",
      "selected": true,
      "icon": Icons.healing
    },
    {
      "category": "Artificial Nutrition",
      "preference": "Temporary",
      "description": "Use feeding tubes only for short-term recovery",
      "selected": true,
      "icon": Icons.restaurant
    },
    {
      "category": "Dialysis",
      "preference": "Yes",
      "description": "Use dialysis if medically appropriate",
      "selected": true,
      "icon": Icons.water_drop
    },
    {
      "category": "Antibiotics",
      "preference": "Yes",
      "description": "Use antibiotics to treat infections",
      "selected": true,
      "icon": Icons.medication
    },
    {
      "category": "Pain Management",
      "preference": "Maximum",
      "description": "Prioritize comfort and pain relief",
      "selected": true,
      "icon": Icons.self_improvement
    },
  ];
  
  List<Map<String, dynamic>> documents = [
    {
      "title": "Living Will",
      "status": "Active",
      "lastUpdated": "Nov 20, 2024",
      "type": "living_will",
      "icon": Icons.description,
      "color": successColor
    },
    {
      "title": "Healthcare Power of Attorney",
      "status": "Active",
      "lastUpdated": "Nov 20, 2024",
      "type": "power_of_attorney",
      "icon": Icons.person,
      "color": primaryColor
    },
    {
      "title": "HIPAA Authorization",
      "status": "Active",
      "lastUpdated": "Aug 15, 2023",
      "type": "hipaa",
      "icon": Icons.security,
      "color": infoColor
    },
    {
      "title": "DNR Order",
      "status": "Not Set",
      "lastUpdated": "N/A",
      "type": "dnr",
      "icon": Icons.block,
      "color": warningColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advance Directives"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareDirectives();
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              _printDirectives();
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
            _buildStatusOverview(),
            _buildDocumentsStatus(),
            _buildMedicalPreferences(),
            _buildLivingWill(),
            _buildPowerOfAttorney(),
            _buildWitnessInformation(),
            _buildAdditionalInstructions(),
            _buildLegalInformation(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasAdvanceDirective 
              ? [successColor, successColor.withAlpha(180)]
              : [warningColor, warningColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  hasAdvanceDirective ? Icons.verified : Icons.warning,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasAdvanceDirective 
                          ? "Advance Directives Complete"
                          : "Advance Directives Incomplete",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      hasAdvanceDirective 
                          ? "Your medical wishes are documented and legally binding"
                          : "Complete your advance directives to ensure your wishes are known",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (hasAdvanceDirective) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                _buildStatusItem("Documents", "3/4 Complete"),
                _buildStatusItem("Last Updated", "${lastUpdated.dMMMy}"),
                _buildStatusItem("Valid Until", "Indefinite"),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(50),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
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
      ),
    );
  }

  Widget _buildDocumentsStatus() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Documents Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: documents.map((doc) => _buildDocumentCard(doc)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> doc) {
    bool isActive = doc["status"] == "Active";
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isActive ? (doc["color"] as Color).withAlpha(25) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isActive ? (doc["color"] as Color).withAlpha(100) : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                doc["icon"],
                color: isActive ? (doc["color"] as Color) : disabledBoldColor,
                size: 20,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? (doc["color"] as Color) : disabledBoldColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  doc["status"],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${doc["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isActive ? (doc["color"] as Color) : disabledBoldColor,
            ),
          ),
          Text(
            "Updated: ${doc["lastUpdated"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: isActive ? "Edit" : "Create",
              size: bs.sm,
              onPressed: () {
                _editDocument(doc["type"]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalPreferences() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Medical Care Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...medicalPreferences.map((pref) => _buildPreferenceItem(pref)),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(Map<String, dynamic> pref) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: pref["selected"] ? primaryColor.withAlpha(25) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: pref["selected"] ? primaryColor.withAlpha(100) : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            pref["icon"],
            color: pref["selected"] ? primaryColor : disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${pref["category"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: pref["selected"] ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: pref["selected"] ? primaryColor : disabledBoldColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${pref["preference"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${pref["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Edit",
            size: bs.sm,
            onPressed: () {
              _editPreference(pref);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLivingWill() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Living Will",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Living Will",
            items: [
              {
                "label": "I have a living will",
                "value": true,
                "checked": hasLivingWill,
              }
            ],
            value: [
              if (hasLivingWill)
                {
                  "label": "I have a living will",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                hasLivingWill = values.isNotEmpty;
              });
            },
          ),
          if (hasLivingWill) ...[
            QMemoField(
              label: "Living Will Preferences",
              value: livingWillPreferences,
              onChanged: (value) {
                livingWillPreferences = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPowerOfAttorney() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Healthcare Power of Attorney",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Power of Attorney",
            items: [
              {
                "label": "I have designated a healthcare power of attorney",
                "value": true,
                "checked": hasPowerOfAttorney,
              }
            ],
            value: [
              if (hasPowerOfAttorney)
                {
                  "label": "I have designated a healthcare power of attorney",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                hasPowerOfAttorney = values.isNotEmpty;
              });
            },
          ),
          if (hasPowerOfAttorney) ...[
            Text(
              "Primary Healthcare Agent",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            QTextField(
              label: "Full Name",
              value: powerOfAttorneyName,
              onChanged: (value) {
                powerOfAttorneyName = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Phone Number",
                    value: powerOfAttorneyPhone,
                    onChanged: (value) {
                      powerOfAttorneyPhone = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Email",
                    value: powerOfAttorneyEmail,
                    onChanged: (value) {
                      powerOfAttorneyEmail = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "Alternate Healthcare Agent",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            QTextField(
              label: "Full Name",
              value: alternateAttorneyName,
              onChanged: (value) {
                alternateAttorneyName = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Phone Number",
                    value: alternateAttorneyPhone,
                    onChanged: (value) {
                      alternateAttorneyPhone = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Email",
                    value: alternateAttorneyEmail,
                    onChanged: (value) {
                      alternateAttorneyEmail = value;
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

  Widget _buildWitnessInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Witness Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Witness 1",
                  value: witnessName1,
                  onChanged: (value) {
                    witnessName1 = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Witness 2",
                  value: witnessName2,
                  onChanged: (value) {
                    witnessName2 = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDatePicker(
            label: "Directive Date",
            value: directiveDate,
            onChanged: (value) {
              directiveDate = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInstructions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Additional Instructions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Special Instructions",
            value: additionalInstructions,
            onChanged: (value) {
              additionalInstructions = value;
              setState(() {});
            },
          ),
          QSwitch(
            label: "HIPAA Authorization",
            items: [
              {
                "label": "I authorize sharing my medical information with designated agents",
                "value": true,
                "checked": hasHIPAAAuthorization,
              }
            ],
            value: [
              if (hasHIPAAAuthorization)
                {
                  "label": "I authorize sharing my medical information with designated agents",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                hasHIPAAAuthorization = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegalInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.gavel,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Legal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "• Advance directives are legally binding documents\n"
            "• They take effect only when you cannot make decisions\n"
            "• You can change or revoke them at any time while competent\n"
            "• Healthcare agents must follow your documented wishes\n"
            "• Keep copies with family, doctors, and healthcare agents\n"
            "• Review and update annually or after major life events",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save Changes",
                  size: bs.md,
                  onPressed: () {
                    setState(() {
                      lastUpdated = DateTime.now();
                    });
                    ss("Advance directives saved successfully");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Legal Review",
                  size: bs.md,
                  onPressed: () {
                    _requestLegalReview();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editDocument(String type) {
    String title = "";
    switch (type) {
      case "living_will":
        title = "Living Will";
        break;
      case "power_of_attorney":
        title = "Healthcare Power of Attorney";
        break;
      case "hipaa":
        title = "HIPAA Authorization";
        break;
      case "dnr":
        title = "DNR Order";
        break;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $title"),
        content: Text("This would open the $title editor with legal templates and guidance."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Open Editor",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("$title editor opened");
            },
          ),
        ],
      ),
    );
  }

  void _editPreference(Map<String, dynamic> pref) {
    String currentPreference = pref["preference"];
    
    List<Map<String, dynamic>> options = [
      {"label": "Yes", "value": "Yes"},
      {"label": "No", "value": "No"},
      {"label": "Limited", "value": "Limited"},
      {"label": "Temporary", "value": "Temporary"},
      {"label": "Maximum", "value": "Maximum"},
    ];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit ${pref["category"]}"),
        content: StatefulBuilder(
          builder: (context, setDialogState) => QDropdownField(
            label: "Preference",
            items: options,
            value: currentPreference,
            onChanged: (value, label) {
              currentPreference = value;
              setDialogState(() {});
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                pref["preference"] = currentPreference;
              });
              ss("Preference updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _shareDirectives() {
    ss("Advance directives shared successfully");
  }

  void _printDirectives() {
    ss("Advance directives sent to printer");
  }

  void _requestLegalReview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Legal Review"),
        content: Text(
          "Request a legal review of your advance directives to ensure they comply with state laws and your current wishes.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Request Review",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Legal review requested");
            },
          ),
        ],
      ),
    );
  }
}
