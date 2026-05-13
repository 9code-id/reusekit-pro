import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAddCustomerView extends StatefulWidget {
  const CmaAddCustomerView({super.key});

  @override
  State<CmaAddCustomerView> createState() => _CmaAddCustomerViewState();
}

class _CmaAddCustomerViewState extends State<CmaAddCustomerView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String company = "";
  String jobTitle = "";
  
  // Address Information
  String addressLine1 = "";
  String addressLine2 = "";
  String city = "";
  String state = "";
  String postalCode = "";
  String country = "United States";
  
  // Customer Details
  String customerType = "Individual";
  String customerSource = "Website";
  String assignedSalesperson = "";
  String preferredLanguage = "English";
  String preferredCommunication = "Email";
  
  // Tags and Notes
  List<String> selectedTags = [];
  String notes = "";
  
  // Settings
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool marketingEmails = true;
  bool isActive = true;
  
  int currentStep = 0;
  
  final List<Map<String, dynamic>> customerTypes = [
    {"label": "Individual", "value": "Individual"},
    {"label": "Business", "value": "Business"},
    {"label": "Enterprise", "value": "Enterprise"},
    {"label": "Government", "value": "Government"},
  ];
  
  final List<Map<String, dynamic>> customerSources = [
    {"label": "Website", "value": "Website"},
    {"label": "Referral", "value": "Referral"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Advertisement", "value": "Advertisement"},
    {"label": "Cold Call", "value": "Cold Call"},
    {"label": "Trade Show", "value": "Trade Show"},
    {"label": "Other", "value": "Other"},
  ];
  
  final List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Chinese", "value": "Chinese"},
    {"label": "Japanese", "value": "Japanese"},
  ];
  
  final List<Map<String, dynamic>> communicationPreferences = [
    {"label": "Email", "value": "Email"},
    {"label": "Phone", "value": "Phone"},
    {"label": "SMS", "value": "SMS"},
    {"label": "Mail", "value": "Mail"},
  ];
  
  final List<Map<String, dynamic>> salespeople = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Wilson", "value": "mike_wilson"},
    {"label": "Emily Davis", "value": "emily_davis"},
    {"label": "Unassigned", "value": "unassigned"},
  ];
  
  final List<Map<String, dynamic>> availableTags = [
    {"label": "VIP", "value": "vip", "color": "gold"},
    {"label": "Priority", "value": "priority", "color": "red"},
    {"label": "New Customer", "value": "new", "color": "green"},
    {"label": "Returning", "value": "returning", "color": "blue"},
    {"label": "Wholesale", "value": "wholesale", "color": "purple"},
    {"label": "Retail", "value": "retail", "color": "orange"},
    {"label": "B2B", "value": "b2b", "color": "teal"},
    {"label": "B2C", "value": "b2c", "color": "pink"},
  ];

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = currentStep >= index;
          final isCompleted = currentStep > index;
          
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? successColor
                        : isActive
                            ? primaryColor
                            : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check
                        : Icons.looks_one_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                if (index < 3) ...[
                  SizedBox(width: spXs),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: currentStep > index ? successColor : disabledColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBasicInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Basic Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          spacing: spSm,
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
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QTextField(
                label: "Company",
                value: company,
                onChanged: (value) {
                  company = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTextField(
                label: "Job Title",
                value: jobTitle,
                onChanged: (value) {
                  jobTitle = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Address Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QTextField(
          label: "Address Line 1",
          value: addressLine1,
          validator: Validator.required,
          onChanged: (value) {
            addressLine1 = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Address Line 2 (Optional)",
          value: addressLine2,
          onChanged: (value) {
            addressLine2 = value;
            setState(() {});
          },
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              flex: 2,
              child: QTextField(
                label: "City",
                value: city,
                validator: Validator.required,
                onChanged: (value) {
                  city = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTextField(
                label: "State",
                value: state,
                validator: Validator.required,
                onChanged: (value) {
                  state = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QTextField(
                label: "Postal Code",
                value: postalCode,
                validator: Validator.required,
                onChanged: (value) {
                  postalCode = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTextField(
                label: "Country",
                value: country,
                validator: Validator.required,
                onChanged: (value) {
                  country = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Customer Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Customer Type",
                items: customerTypes,
                value: customerType,
                onChanged: (value, label) {
                  customerType = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Source",
                items: customerSources,
                value: customerSource,
                onChanged: (value, label) {
                  customerSource = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        QDropdownField(
          label: "Assigned Salesperson",
          items: salespeople,
          value: assignedSalesperson,
          onChanged: (value, label) {
            assignedSalesperson = value;
            setState(() {});
          },
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Preferred Language",
                items: languages,
                value: preferredLanguage,
                onChanged: (value, label) {
                  preferredLanguage = value;
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QDropdownField(
                label: "Communication Preference",
                items: communicationPreferences,
                value: preferredCommunication,
                onChanged: (value, label) {
                  preferredCommunication = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        Text(
          "Customer Tags",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: availableTags.map((tag) {
            final isSelected = selectedTags.contains(tag["value"]);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  selectedTags.remove(tag["value"]);
                } else {
                  selectedTags.add(tag["value"]);
                }
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Text(
                  "${tag["label"]}",
                  style: TextStyle(
                    color: isSelected ? Colors.white : disabledBoldColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        
        QMemoField(
          label: "Notes",
          value: notes,
          hint: "Add any additional notes about this customer...",
          onChanged: (value) {
            notes = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPreferencesAndSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Communication Preferences",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Email Notifications",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Switch(
                    value: emailNotifications,
                    onChanged: (value) {
                      emailNotifications = value;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "SMS Notifications",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Switch(
                    value: smsNotifications,
                    onChanged: (value) {
                      smsNotifications = value;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Marketing Emails",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Switch(
                    value: marketingEmails,
                    onChanged: (value) {
                      marketingEmails = value;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Active Customer",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Switch(
                    value: isActive,
                    onChanged: (value) {
                      isActive = value;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        
        Text(
          "Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Customer Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text("Name: $firstName $lastName"),
              Text("Email: $email"),
              Text("Phone: $phone"),
              if (company.isNotEmpty) Text("Company: $company"),
              Text("Type: $customerType"),
              Text("Source: $customerSource"),
              if (selectedTags.isNotEmpty)
                Text("Tags: ${selectedTags.join(', ')}"),
            ],
          ),
        ),
      ],
    );
  }

  void _nextStep() {
    if (currentStep < 3) {
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

  void _saveCustomer() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Customer added successfully!");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Customer"),
        actions: [
          TextButton(
            onPressed: () {
              back();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            _buildStepIndicator(),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    if (currentStep == 0) _buildBasicInformation(),
                    if (currentStep == 1) _buildAddressInformation(),
                    if (currentStep == 2) _buildCustomerDetails(),
                    if (currentStep == 3) _buildPreferencesAndSettings(),
                  ],
                ),
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        size: bs.md,
                        onPressed: _previousStep,
                      ),
                    ),
                  
                  Expanded(
                    child: QButton(
                      label: currentStep == 3 ? "Create Customer" : "Next",
                      size: bs.md,
                      onPressed: currentStep == 3 ? _saveCustomer : _nextStep,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
