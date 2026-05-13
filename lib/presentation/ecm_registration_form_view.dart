import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmRegistrationFormView extends StatefulWidget {
  const EcmRegistrationFormView({super.key});

  @override
  State<EcmRegistrationFormView> createState() => _EcmRegistrationFormViewState();
}

class _EcmRegistrationFormViewState extends State<EcmRegistrationFormView> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int currentTab = 0;

  // Form fields
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String company = "";
  String jobTitle = "";
  String eventChoice = "";
  String dietaryRestrictions = "";
  String accommodationNeeds = "";
  String emergencyContact = "";
  String emergencyPhone = "";
  String tshirtSize = "M";
  bool newsletter = false;
  bool termsAccepted = false;
  bool privacyAccepted = false;

  List<Map<String, dynamic>> eventOptions = [
    {"label": "Tech Conference 2025", "value": "tech_conf"},
    {"label": "Business Summit", "value": "business_summit"},
    {"label": "Developer Workshop", "value": "dev_workshop"},
    {"label": "Leadership Forum", "value": "leadership_forum"},
  ];

  List<Map<String, dynamic>> tshirtOptions = [
    {"label": "Small (S)", "value": "S"},
    {"label": "Medium (M)", "value": "M"},
    {"label": "Large (L)", "value": "L"},
    {"label": "Extra Large (XL)", "value": "XL"},
    {"label": "XXL", "value": "XXL"},
  ];

  List<Map<String, dynamic>> registrations = [
    {
      "id": 1,
      "name": "John Smith",
      "email": "john.smith@example.com",
      "event": "Tech Conference 2025", 
      "registration_date": "2025-01-28",
      "status": "confirmed",
      "ticket_type": "VIP Package",
      "amount_paid": 250.0,
      "phone": "+1-555-0123",
      "company": "Tech Solutions Inc.",
      "job_title": "Software Engineer"
    },
    {
      "id": 2,
      "name": "Sarah Johnson",
      "email": "s.johnson@company.com",
      "event": "Business Summit",
      "registration_date": "2025-01-27",
      "status": "pending",
      "ticket_type": "General Admission",
      "amount_paid": 150.0,
      "phone": "+1-555-0456",
      "company": "Business Corp",
      "job_title": "Marketing Manager"
    },
    {
      "id": 3,
      "name": "Mike Wilson",
      "email": "mike.w@startup.com",
      "event": "Developer Workshop",
      "registration_date": "2025-01-26",
      "status": "confirmed",
      "ticket_type": "Student Discount",
      "amount_paid": 75.0,
      "phone": "+1-555-0789",
      "company": "StartupHub",
      "job_title": "Junior Developer"
    },
    {
      "id": 4,
      "name": "Emily Davis",
      "email": "emily.davis@corp.com",
      "event": "Leadership Forum",
      "registration_date": "2025-01-25",
      "status": "cancelled",
      "ticket_type": "Premium Package",
      "amount_paid": 300.0,
      "phone": "+1-555-0321",
      "company": "Corporate Solutions",
      "job_title": "Director of Operations"
    }
  ];

  Widget _buildRegistrationForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(Icons.event, color: primaryColor, size: 24),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event Registration Form",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Fill out the form below to register for the event",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Text(
              "Personal Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "First Name",
                    value: firstName,
                    validator: Validator.required,
                    onChanged: (value) {
                      firstName = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Last Name",
                    value: lastName,
                    validator: Validator.required,
                    onChanged: (value) {
                      lastName = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            QTextField(
              label: "Email Address",
              value: email,
              validator: Validator.email,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            
            QTextField(
              label: "Phone Number",
              value: phone,
              validator: Validator.required,
              onChanged: (value) {
                phone = value;
                setState(() {});
              },
            ),
            
            Text(
              "Professional Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QTextField(
              label: "Company/Organization",
              value: company,
              onChanged: (value) {
                company = value;
                setState(() {});
              },
            ),
            
            QTextField(
              label: "Job Title",
              value: jobTitle,
              onChanged: (value) {
                jobTitle = value;
                setState(() {});
              },
            ),
            
            Text(
              "Event Selection",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QDropdownField(
              label: "Select Event",
              items: eventOptions,
              value: eventChoice,
              validator: Validator.required,
              onChanged: (value, label) {
                eventChoice = value;
                setState(() {});
              },
            ),
            
            QDropdownField(
              label: "T-Shirt Size",
              items: tshirtOptions,
              value: tshirtSize,
              onChanged: (value, label) {
                tshirtSize = value;
                setState(() {});
              },
            ),
            
            Text(
              "Special Requirements",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QMemoField(
              label: "Dietary Restrictions",
              value: dietaryRestrictions,
              hint: "Please specify any dietary restrictions or allergies",
              onChanged: (value) {
                dietaryRestrictions = value;
                setState(() {});
              },
            ),
            
            QMemoField(
              label: "Accommodation Needs",
              value: accommodationNeeds,
              hint: "Any accessibility or accommodation requirements",
              onChanged: (value) {
                accommodationNeeds = value;
                setState(() {});
              },
            ),
            
            Text(
              "Emergency Contact",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Emergency Contact Name",
                    value: emergencyContact,
                    validator: Validator.required,
                    onChanged: (value) {
                      emergencyContact = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Emergency Phone",
                    value: emergencyPhone,
                    validator: Validator.required,
                    onChanged: (value) {
                      emergencyPhone = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            Text(
              "Preferences & Agreements",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QSwitch(
              label: "Subscribe to Newsletter",
              items: [
                {
                  "label": "Yes, I want to receive event updates and newsletters",
                  "value": true,
                  "checked": newsletter,
                }
              ],
              value: [if (newsletter) {"label": "Yes, I want to receive event updates and newsletters", "value": true, "checked": true}],
              onChanged: (values, ids) {
                newsletter = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            QSwitch(
              label: "Terms and Conditions",
              items: [
                {
                  "label": "I accept the terms and conditions",
                  "value": true,
                  "checked": termsAccepted,
                }
              ],
              value: [if (termsAccepted) {"label": "I accept the terms and conditions", "value": true, "checked": true}],
              onChanged: (values, ids) {
                termsAccepted = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            QSwitch(
              label: "Privacy Policy",
              items: [
                {
                  "label": "I agree to the privacy policy",
                  "value": true,
                  "checked": privacyAccepted,
                }
              ],
              value: [if (privacyAccepted) {"label": "I agree to the privacy policy", "value": true, "checked": true}],
              onChanged: (values, ids) {
                privacyAccepted = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            Container(
              width: double.infinity,
              child: QButton(
                label: isLoading ? "Processing..." : "Complete Registration",
                size: bs.md,
                onPressed: isLoading ? null : _submitRegistration,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationCard(Map<String, dynamic> registration) {
    Color statusColor = registration["status"] == "confirmed" 
        ? successColor 
        : registration["status"] == "pending" 
            ? warningColor 
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "REG-${registration["id"].toString().padLeft(4, '0')}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${registration["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${registration["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${registration["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((registration["amount_paid"] as double)).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "${registration["ticket_type"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.event, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${registration["event"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.business, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${registration["company"]} - ${registration["job_title"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Registered: ${DateTime.parse(registration["registration_date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.phone, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${registration["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewRegistrationDetails(registration),
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.email,
                size: bs.sm,
                onPressed: () => _sendEmail(registration),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editRegistration(registration),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationsTab() {
    int totalRegistrations = registrations.length;
    int confirmedRegistrations = registrations.where((reg) => reg["status"] == "confirmed").length;
    double totalRevenue = registrations.fold(0.0, (sum, reg) => sum + (reg["amount_paid"] as double));
    int pendingRegistrations = registrations.where((reg) => reg["status"] == "pending").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.people, color: primaryColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Total Registrations",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$totalRegistrations",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
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
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.check_circle, color: successColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Confirmed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$confirmedRegistrations",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
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
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.pending, color: warningColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "$pendingRegistrations",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
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
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(Icons.attach_money, color: infoColor, size: 20),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Total Revenue",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "\$${(totalRevenue).currency}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Text(
                "Recent Registrations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: _filterRegistrations,
              ),
            ],
          ),
          SizedBox(height: spSm),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else
            ...registrations.map((registration) => _buildRegistrationCard(registration)).toList(),
        ],
      ),
    );
  }

  void _submitRegistration() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    if (!termsAccepted) {
      se("Please accept the terms and conditions");
      return;
    }

    if (!privacyAccepted) {
      se("Please accept the privacy policy");
      return;
    }

    isLoading = true;
    setState(() {});

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      ss("Registration completed successfully!");
      
      // Reset form
      firstName = "";
      lastName = "";
      email = "";
      phone = "";
      company = "";
      jobTitle = "";
      eventChoice = "";
      dietaryRestrictions = "";
      accommodationNeeds = "";
      emergencyContact = "";
      emergencyPhone = "";
      tshirtSize = "M";
      newsletter = false;
      termsAccepted = false;
      privacyAccepted = false;
      
    } catch (e) {
      se("Registration failed. Please try again.");
    }

    isLoading = false;
    setState(() {});
  }

  void _viewRegistrationDetails(Map<String, dynamic> registration) {
    // Show registration details
  }

  void _sendEmail(Map<String, dynamic> registration) {
    // Send email to registrant
  }

  void _editRegistration(Map<String, dynamic> registration) {
    // Edit registration
  }

  void _filterRegistrations() {
    // Show filter options
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Registration Form",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "New Registration", icon: Icon(Icons.person_add)),
        Tab(text: "Registrations", icon: Icon(Icons.list)),
      ],
      tabChildren: [
        _buildRegistrationForm(),
        _buildRegistrationsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
