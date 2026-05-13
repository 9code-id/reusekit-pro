import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaAttendeeManagementView extends StatefulWidget {
  const EmaAttendeeManagementView({super.key});

  @override
  State<EmaAttendeeManagementView> createState() => _EmaAttendeeManagementViewState();
}

class _EmaAttendeeManagementViewState extends State<EmaAttendeeManagementView> {
  final formKey = GlobalKey<FormState>();
  bool isEditing = false;
  
  // Personal Information
  String fullName = "";
  String email = "";
  String phone = "";
  String company = "";
  String jobTitle = "";
  String linkedinProfile = "";
  
  // Ticket Information
  String ticketType = "Regular";
  String ticketCategory = "General Admission";
  
  // Special Requirements
  String dietaryRequirements = "None";
  String accessibilityNeeds = "";
  String specialRequests = "";
  
  // Emergency Contact
  String emergencyName = "";
  String emergencyPhone = "";
  String emergencyRelationship = "";
  
  // Networking Preferences
  List<String> selectedInterests = [];
  List<String> selectedLookingFor = [];
  String networkingAvailability = "";
  
  List<Map<String, dynamic>> ticketTypeOptions = [
    {"label": "Regular", "value": "Regular"},
    {"label": "VIP", "value": "VIP"},
    {"label": "Student", "value": "Student"},
    {"label": "Corporate", "value": "Corporate"}
  ];
  
  List<Map<String, dynamic>> dietaryOptions = [
    {"label": "None", "value": "None"},
    {"label": "Vegetarian", "value": "Vegetarian"},
    {"label": "Vegan", "value": "Vegan"},
    {"label": "Gluten Free", "value": "Gluten Free"},
    {"label": "Halal", "value": "Halal"},
    {"label": "Kosher", "value": "Kosher"},
    {"label": "Other", "value": "Other"}
  ];
  
  List<String> interestOptions = [
    "Mobile Development", "UI/UX Design", "Backend Development", 
    "Cloud Computing", "AI/ML", "DevOps", "Blockchain", "IoT",
    "Cybersecurity", "Data Science", "Web Development", "Game Development"
  ];
  
  List<String> lookingForOptions = [
    "Job Opportunities", "Collaboration", "Mentorship", "Investment",
    "Co-founder", "Learning", "Networking", "Speaking Opportunities"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Attendee" : "Add Attendee"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveAttendee();
            },
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
              _buildPersonalInformationSection(),
              _buildTicketInformationSection(),
              _buildSpecialRequirementsSection(),
              _buildEmergencyContactSection(),
              _buildNetworkingPreferencesSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInformationSection() {
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
          Row(
            children: [
              Icon(Icons.person, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Full Name",
            value: fullName,
            hint: "Enter your full name",
            validator: Validator.required,
            onChanged: (value) {
              fullName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: email,
            hint: "Enter your email address",
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: phone,
            hint: "Enter your phone number",
            validator: Validator.required,
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Company",
            value: company,
            hint: "Enter your company name",
            onChanged: (value) {
              company = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Job Title",
            value: jobTitle,
            hint: "Enter your job title",
            onChanged: (value) {
              jobTitle = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "LinkedIn Profile (Optional)",
            value: linkedinProfile,
            hint: "linkedin.com/in/yourprofile",
            onChanged: (value) {
              linkedinProfile = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTicketInformationSection() {
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
          Row(
            children: [
              Icon(Icons.confirmation_number, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Ticket Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Ticket Type",
            items: ticketTypeOptions,
            value: ticketType,
            onChanged: (value, label) {
              ticketType = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Ticket Benefits:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                ..._getTicketBenefits(ticketType).map((benefit) => Row(
                  children: [
                    Icon(Icons.check, size: 16, color: successColor),
                    SizedBox(width: spSm),
                    Text(
                      benefit,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getTicketBenefits(String type) {
    switch (type) {
      case "VIP":
        return [
          "Conference Access",
          "Premium Seating",
          "VIP Lunch & Refreshments",
          "Exclusive Networking Session",
          "Welcome Kit with Premium Swag",
          "Meet & Greet with Speakers"
        ];
      case "Student":
        return [
          "Conference Access",
          "Student Lunch",
          "Welcome Kit",
          "Student Networking Session"
        ];
      case "Corporate":
        return [
          "Conference Access",
          "Corporate Lunch",
          "Welcome Kit",
          "Corporate Networking Session",
          "Group Seating"
        ];
      default:
        return [
          "Conference Access",
          "Lunch Included",
          "Welcome Kit",
          "Networking Session"
        ];
    }
  }

  Widget _buildSpecialRequirementsSection() {
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
          Row(
            children: [
              Icon(Icons.accessibility, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Special Requirements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Dietary Requirements",
            items: dietaryOptions,
            value: dietaryRequirements,
            onChanged: (value, label) {
              dietaryRequirements = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Accessibility Needs",
            value: accessibilityNeeds,
            hint: "Wheelchair access, hearing assistance, etc.",
            onChanged: (value) {
              accessibilityNeeds = value;
              setState(() {});
            },
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Special Requests",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Any additional requests or information we should know...",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      specialRequests = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactSection() {
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
          Row(
            children: [
              Icon(Icons.emergency, color: dangerColor),
              SizedBox(width: spSm),
              Text(
                "Emergency Contact",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Emergency Contact Name",
            value: emergencyName,
            hint: "Full name of emergency contact",
            validator: Validator.required,
            onChanged: (value) {
              emergencyName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Emergency Contact Phone",
            value: emergencyPhone,
            hint: "Phone number of emergency contact",
            validator: Validator.required,
            onChanged: (value) {
              emergencyPhone = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Relationship",
            value: emergencyRelationship,
            hint: "Spouse, Parent, Sibling, Friend, etc.",
            validator: Validator.required,
            onChanged: (value) {
              emergencyRelationship = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkingPreferencesSection() {
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
          Row(
            children: [
              Icon(Icons.network_check, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Networking Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Areas of Interest",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: interestOptions.map((interest) {
                  final isSelected = selectedInterests.contains(interest);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedInterests.remove(interest);
                      } else {
                        selectedInterests.add(interest);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        interest,
                        style: TextStyle(
                          color: isSelected ? Colors.white : primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Looking For",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: lookingForOptions.map((option) {
                  final isSelected = selectedLookingFor.contains(option);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        selectedLookingFor.remove(option);
                      } else {
                        selectedLookingFor.add(option);
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? successColor : successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? Colors.white : successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Networking Availability",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "When are you available for networking? (e.g., during breaks, after sessions, etc.)",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      networkingAvailability = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: isEditing ? "Update Attendee" : "Add Attendee",
            icon: isEditing ? Icons.update : Icons.add,
            size: bs.md,
            onPressed: () {
              _saveAttendee();
            },
          ),
        ),
        if (isEditing)
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Delete Attendee",
                  icon: Icons.delete,
                  size: bs.md,
                  onPressed: () {
                    _deleteAttendee();
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Duplicate",
                  icon: Icons.copy,
                  size: bs.md,
                  onPressed: () {
                    _duplicateAttendee();
                  },
                ),
              ),
            ],
          ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Preview Profile",
            icon: Icons.preview,
            size: bs.md,
            onPressed: () {
              _previewProfile();
            },
          ),
        ),
      ],
    );
  }

  void _saveAttendee() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    if (fullName.isEmpty || email.isEmpty || phone.isEmpty) {
      se("Please fill in all required personal information");
      return;
    }

    if (emergencyName.isEmpty || emergencyPhone.isEmpty || emergencyRelationship.isEmpty) {
      se("Please fill in emergency contact information");
      return;
    }

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss(isEditing ? "Attendee updated successfully" : "Attendee added successfully");
    Navigator.of(context).pop();
  }

  void _deleteAttendee() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this attendee? This action cannot be undone.");
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      
      hideLoading();
      
      ss("Attendee deleted successfully");
      Navigator.of(context).pop();
    }
  }

  void _duplicateAttendee() {
    // Reset name and email to create a duplicate
    fullName = "$fullName (Copy)";
    email = "";
    isEditing = false;
    setState(() {});
    
    si("Attendee duplicated. Please update the name and email before saving.");
  }

  void _previewProfile() {
    if (fullName.isEmpty) {
      se("Please enter attendee name to preview profile");
      return;
    }
    
    //navigateTo EmaAttendeeView with current form data
    ss("Opening attendee profile preview");
  }
}
