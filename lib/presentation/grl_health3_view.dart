import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHealth3View extends StatefulWidget {
  @override
  State<GrlHealth3View> createState() => _GrlHealth3ViewState();
}

class _GrlHealth3ViewState extends State<GrlHealth3View> {
  String fullName = "";
  String email = "";
  String phone = "";
  String emergencyContact = "";
  String emergencyPhone = "";
  String dateOfBirth = "";
  String gender = "";
  String bloodType = "";
  String allergies = "";
  String currentMedications = "";
  String medicalConditions = "";
  String insuranceProvider = "";
  String policyNumber = "";
  String primaryCarePhysician = "";
  String physicianPhone = "";
  
  bool shareDataWithProviders = true;
  bool enableHealthReminders = true;
  bool allowDataExport = false;
  bool emergencyAccess = true;

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
    {"label": "Prefer not to say", "value": "prefer_not_to_say"}
  ];

  List<Map<String, dynamic>> bloodTypeOptions = [
    {"label": "A+", "value": "A+"},
    {"label": "A-", "value": "A-"},
    {"label": "B+", "value": "B+"},
    {"label": "B-", "value": "B-"},
    {"label": "AB+", "value": "AB+"},
    {"label": "AB-", "value": "AB-"},
    {"label": "O+", "value": "O+"},
    {"label": "O-", "value": "O-"},
    {"label": "Unknown", "value": "unknown"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Profile"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveProfile,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Personal Information Section
              _buildSectionHeader("Personal Information", Icons.person),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Full Name",
                      value: fullName,
                      validator: Validator.required,
                      onChanged: (value) {
                        fullName = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Email Address",
                            value: email,
                            validator: Validator.email,
                            onChanged: (value) {
                              email = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Phone Number",
                            value: phone,
                            validator: Validator.required,
                            onChanged: (value) {
                              phone = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Date of Birth",
                            value: dateOfBirth.isNotEmpty ? DateTime.parse(dateOfBirth) : DateTime.now(),
                            onChanged: (value) {
                              dateOfBirth = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Gender",
                            items: genderOptions,
                            value: gender,
                            onChanged: (value, label) {
                              gender = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Medical Information Section
              _buildSectionHeader("Medical Information", Icons.medical_information),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QDropdownField(
                      label: "Blood Type",
                      items: bloodTypeOptions,
                      value: bloodType,
                      onChanged: (value, label) {
                        bloodType = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Known Allergies",
                      value: allergies,
                      hint: "List any allergies (food, medications, environmental)",
                      onChanged: (value) {
                        allergies = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Current Medications",
                      value: currentMedications,
                      hint: "List all medications you are currently taking",
                      onChanged: (value) {
                        currentMedications = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Medical Conditions",
                      value: medicalConditions,
                      hint: "List any chronic conditions or ongoing health issues",
                      onChanged: (value) {
                        medicalConditions = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Emergency Contact Section
              _buildSectionHeader("Emergency Contact", Icons.emergency),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Emergency Contact Name",
                      value: emergencyContact,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyContact = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Emergency Contact Phone",
                      value: emergencyPhone,
                      validator: Validator.required,
                      onChanged: (value) {
                        emergencyPhone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Healthcare Provider Section
              _buildSectionHeader("Healthcare Provider", Icons.local_hospital),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Primary Care Physician",
                      value: primaryCarePhysician,
                      onChanged: (value) {
                        primaryCarePhysician = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Physician Phone Number",
                      value: physicianPhone,
                      onChanged: (value) {
                        physicianPhone = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Insurance Provider",
                            value: insuranceProvider,
                            onChanged: (value) {
                              insuranceProvider = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Policy Number",
                            value: policyNumber,
                            onChanged: (value) {
                              policyNumber = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Privacy & Data Settings Section
              _buildSectionHeader("Privacy & Data Settings", Icons.privacy_tip),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    _buildSwitchOption(
                      "Share Data with Healthcare Providers",
                      "Allow your health data to be shared with your doctors",
                      shareDataWithProviders,
                      (value) {
                        shareDataWithProviders = value;
                        setState(() {});
                      },
                    ),
                    
                    _buildSwitchOption(
                      "Enable Health Reminders",
                      "Receive notifications for medications and appointments",
                      enableHealthReminders,
                      (value) {
                        enableHealthReminders = value;
                        setState(() {});
                      },
                    ),
                    
                    _buildSwitchOption(
                      "Emergency Access",
                      "Allow emergency responders to access critical health info",
                      emergencyAccess,
                      (value) {
                        emergencyAccess = value;
                        setState(() {});
                      },
                    ),
                    
                    _buildSwitchOption(
                      "Allow Data Export",
                      "Enable exporting your health data to other apps",
                      allowDataExport,
                      (value) {
                        allowDataExport = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Quick Actions Section
              _buildSectionHeader("Quick Actions", Icons.flash_on),
              Container(
                padding: EdgeInsets.all(spSm),
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
                            label: "Export Data",
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {
                              _showExportDialog();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Backup Profile",
                            icon: Icons.backup,
                            size: bs.sm,
                            onPressed: () {
                              _backupProfile();
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Share with Doctor",
                            icon: Icons.share,
                            size: bs.sm,
                            onPressed: () {
                              _shareWithDoctor();
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Emergency Card",
                            icon: Icons.credit_card,
                            size: bs.sm,
                            onPressed: () {
                              _generateEmergencyCard();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Medical ID Card Preview
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: dangerColor.withAlpha(51)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medical_services, color: dangerColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Medical ID Preview",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: dangerColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MEDICAL ID",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: spXs),
                          
                          if (fullName.isNotEmpty)
                            _buildMedicalIdRow("Name:", fullName),
                          if (bloodType.isNotEmpty)
                            _buildMedicalIdRow("Blood Type:", bloodType),
                          if (allergies.isNotEmpty)
                            _buildMedicalIdRow("Allergies:", allergies),
                          if (emergencyContact.isNotEmpty)
                            _buildMedicalIdRow("Emergency:", "$emergencyContact ($emergencyPhone)"),
                          
                          if (fullName.isEmpty && bloodType.isEmpty && allergies.isEmpty && emergencyContact.isEmpty)
                            Text(
                              "Complete your profile to see Medical ID preview",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchOption(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
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
                SizedBox(height: spXxs),
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
          SizedBox(width: spSm),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalIdRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXxs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveProfile() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Health profile saved successfully!");
    }
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Export Health Data"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose export format:"),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "PDF",
                    icon: Icons.picture_as_pdf,
                    size: bs.sm,
                    onPressed: () {
                      back();
                      ss("Exporting as PDF...");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "CSV",
                    icon: Icons.table_chart,
                    size: bs.sm,
                    onPressed: () {
                      back();
                      ss("Exporting as CSV...");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _backupProfile() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Profile backed up to cloud storage");
  }

  void _shareWithDoctor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Share with Doctor"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter your doctor's email address:"),
            SizedBox(height: spSm),
            
            QTextField(
              label: "Doctor's Email",
              value: "",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            
            Text(
              "Your doctor will receive a secure link to view your health profile.",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Health profile shared with doctor");
            },
            child: Text("Share"),
          ),
        ],
      ),
    );
  }

  void _generateEmergencyCard() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Emergency Card Generated"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: successColor, size: 48),
            SizedBox(height: spSm),
            Text(
              "Your emergency medical ID card has been generated and saved to your device.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spSm),
            Text(
              "You can access it from your lock screen in case of emergency.",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
