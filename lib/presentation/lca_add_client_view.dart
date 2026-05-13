import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaAddClientView extends StatefulWidget {
  const LcaAddClientView({super.key});

  @override
  State<LcaAddClientView> createState() => _LcaAddClientViewState();
}

class _LcaAddClientViewState extends State<LcaAddClientView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String clientName = "";
  String clientEmail = "";
  String clientPhone = "";
  String company = "";
  String clientType = "Individual";
  String priority = "Medium";
  String industry = "";
  String referralSource = "";
  
  // Contact Information
  String primaryContact = "";
  String secondaryContact = "";
  String address = "";
  String preferredCommunication = "Email";
  
  // Financial Information
  String retainerAmount = "";
  String hourlyRate = "";
  
  // Additional Information
  String notes = "";
  String specialRequirements = "";
  
  bool isActive = true;
  bool requiresRetainer = false;
  bool hasConflictCheck = false;

  List<Map<String, dynamic>> clientTypes = [
    {"label": "Individual", "value": "Individual"},
    {"label": "Corporate", "value": "Corporate"},
    {"label": "Small Business", "value": "Small Business"},
    {"label": "Non-Profit", "value": "Non-Profit"},
    {"label": "Government", "value": "Government"},
  ];

  List<Map<String, dynamic>> priorityLevels = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> communicationMethods = [
    {"label": "Email", "value": "Email"},
    {"label": "Phone", "value": "Phone"},
    {"label": "Text Message", "value": "Text Message"},
    {"label": "In-Person Meeting", "value": "In-Person Meeting"},
    {"label": "Video Call", "value": "Video Call"},
  ];

  List<Map<String, dynamic>> industries = [
    {"label": "Technology", "value": "Technology"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Real Estate", "value": "Real Estate"},
    {"label": "Manufacturing", "value": "Manufacturing"},
    {"label": "Retail", "value": "Retail"},
    {"label": "Education", "value": "Education"},
    {"label": "Transportation", "value": "Transportation"},
    {"label": "Energy", "value": "Energy"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> referralSources = [
    {"label": "Bar Association", "value": "Bar Association"},
    {"label": "Existing Client", "value": "Existing Client"},
    {"label": "Website", "value": "Website"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Advertising", "value": "Advertising"},
    {"label": "Professional Network", "value": "Professional Network"},
    {"label": "Cold Call", "value": "Cold Call"},
    {"label": "Other", "value": "Other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Client"),
        actions: [
          TextButton(
            onPressed: _saveClient,
            child: Text(
              "Save",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildBasicInformationSection(),
              _buildContactInformationSection(),
              _buildFinancialInformationSection(),
              _buildAdditionalSettingsSection(),
              _buildNotesSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInformationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Client Name",
            value: clientName,
            hint: "Enter full name",
            validator: Validator.required,
            onChanged: (value) {
              clientName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Email Address",
                  value: clientEmail,
                  hint: "client@email.com",
                  validator: Validator.email,
                  onChanged: (value) {
                    clientEmail = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: clientPhone,
                  hint: "+1 (555) 123-4567",
                  validator: Validator.required,
                  onChanged: (value) {
                    clientPhone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Company/Organization",
            value: company,
            hint: "Enter company name (if applicable)",
            onChanged: (value) {
              company = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Client Type",
                  items: clientTypes,
                  value: clientType,
                  onChanged: (value, label) {
                    clientType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority Level",
                  items: priorityLevels,
                  value: priority,
                  onChanged: (value, label) {
                    priority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Industry",
                  items: industries,
                  value: industry,
                  onChanged: (value, label) {
                    industry = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Referral Source",
                  items: referralSources,
                  value: referralSource,
                  onChanged: (value, label) {
                    referralSource = value;
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

  Widget _buildContactInformationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Primary Contact Person",
            value: primaryContact,
            hint: "Main point of contact",
            onChanged: (value) {
              primaryContact = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Secondary Contact Person",
            value: secondaryContact,
            hint: "Alternative contact (optional)",
            onChanged: (value) {
              secondaryContact = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Address",
            value: address,
            hint: "Street address, city, state, ZIP code",
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Preferred Communication Method",
            items: communicationMethods,
            value: preferredCommunication,
            onChanged: (value, label) {
              preferredCommunication = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialInformationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Financial Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Hourly Rate (\$)",
                  value: hourlyRate,
                  hint: "Standard hourly rate",
                  validator: Validator.required,
                  onChanged: (value) {
                    hourlyRate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Retainer Amount (\$)",
                  value: retainerAmount,
                  hint: "Initial retainer amount",
                  onChanged: (value) {
                    retainerAmount = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Requires Retainer",
            items: [
              {
                "label": "Client must pay retainer before work begins",
                "value": true,
                "checked": requiresRetainer,
              }
            ],
            value: [
              if (requiresRetainer)
                {
                  "label": "Client must pay retainer before work begins",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              requiresRetainer = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalSettingsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Additional Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            label: "Client Status",
            items: [
              {
                "label": "Active Client",
                "value": true,
                "checked": isActive,
              }
            ],
            value: [
              if (isActive)
                {
                  "label": "Active Client",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isActive = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            label: "Conflict Check",
            items: [
              {
                "label": "Conflict check completed",
                "value": true,
                "checked": hasConflictCheck,
              }
            ],
            value: [
              if (hasConflictCheck)
                {
                  "label": "Conflict check completed",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              hasConflictCheck = values.isNotEmpty;
              setState(() {});
            },
          ),
          QTextField(
            label: "Special Requirements",
            value: specialRequirements,
            hint: "Any special handling requirements",
            onChanged: (value) {
              specialRequirements = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Notes & Comments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Client Notes",
            value: notes,
            hint: "Add any important notes about this client...",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save & Add Case",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    _saveClientAndAddCase();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Client",
                  icon: Icons.save,
                  size: bs.md,
                  onPressed: () {
                    _saveClient();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.sm,
                  onPressed: () {
                    _saveDraft();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () {
                    _cancelAddClient();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveClient() {
    if (formKey.currentState!.validate()) {
      // Validation passed
      if (!hasConflictCheck && clientType != "Individual") {
        sw("Please complete conflict check for corporate clients");
        return;
      }

      if (requiresRetainer && retainerAmount.isEmpty) {
        se("Retainer amount is required when retainer is enabled");
        return;
      }

      // Save client logic here
      Map<String, dynamic> clientData = {
        "name": clientName,
        "email": clientEmail,
        "phone": clientPhone,
        "company": company,
        "type": clientType,
        "priority": priority,
        "industry": industry,
        "referralSource": referralSource,
        "primaryContact": primaryContact,
        "secondaryContact": secondaryContact,
        "address": address,
        "preferredCommunication": preferredCommunication,
        "hourlyRate": double.tryParse(hourlyRate) ?? 0.0,
        "retainerAmount": double.tryParse(retainerAmount) ?? 0.0,
        "requiresRetainer": requiresRetainer,
        "isActive": isActive,
        "hasConflictCheck": hasConflictCheck,
        "specialRequirements": specialRequirements,
        "notes": notes,
        "createdDate": DateTime.now().toIso8601String(),
      };

      ss("Client saved successfully");
      back();
    } else {
      se("Please fill in all required fields");
    }
  }

  void _saveClientAndAddCase() {
    if (formKey.currentState!.validate()) {
      if (!hasConflictCheck && clientType != "Individual") {
        sw("Please complete conflict check before adding cases");
        return;
      }

      // Save client and navigate to add case
      _saveClient();
      
      // Navigate to add case view for this client
      si("Client saved. Add a case for this client");
    }
  }

  void _saveDraft() {
    // Save as draft without validation
    Map<String, dynamic> draftData = {
      "name": clientName,
      "email": clientEmail,
      "phone": clientPhone,
      "company": company,
      "type": clientType,
      "priority": priority,
      "industry": industry,
      "referralSource": referralSource,
      "primaryContact": primaryContact,
      "secondaryContact": secondaryContact,
      "address": address,
      "preferredCommunication": preferredCommunication,
      "hourlyRate": hourlyRate,
      "retainerAmount": retainerAmount,
      "requiresRetainer": requiresRetainer,
      "isActive": isActive,
      "hasConflictCheck": hasConflictCheck,
      "specialRequirements": specialRequirements,
      "notes": notes,
      "isDraft": true,
      "lastModified": DateTime.now().toIso8601String(),
    };

    si("Client information saved as draft");
    back();
  }

  void _cancelAddClient() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel? All entered information will be lost.");
    if (isConfirmed) {
      back();
    }
  }
}
