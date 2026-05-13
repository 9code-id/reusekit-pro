import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaEditCustomerView extends StatefulWidget {
  const CmaEditCustomerView({super.key});

  @override
  State<CmaEditCustomerView> createState() => _CmaEditCustomerViewState();
}

class _CmaEditCustomerViewState extends State<CmaEditCustomerView> {
  final formKey = GlobalKey<FormState>();
  
  // Customer data - loaded from API/database
  String customerId = "CUST-001";
  String firstName = "John";
  String lastName = "Smith";
  String email = "john.smith@email.com";
  String phone = "+1 (555) 123-4567";
  String company = "Tech Solutions Inc";
  String jobTitle = "Software Engineer";
  
  // Address Information
  String addressLine1 = "123 Main Street";
  String addressLine2 = "Suite 100";
  String city = "New York";
  String state = "NY";
  String postalCode = "10001";
  String country = "United States";
  
  // Customer Details
  String customerType = "Business";
  String customerSource = "Website";
  String assignedSalesperson = "sarah_johnson";
  String preferredLanguage = "English";
  String preferredCommunication = "Email";
  
  // Tags and Notes
  List<String> selectedTags = ["VIP", "priority", "b2b"];
  String notes = "Important client with multiple projects. Requires priority support.";
  
  // Settings
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool marketingEmails = true;
  bool isActive = true;
  
  // Customer Status
  String customerStatus = "Active";
  String accountManager = "Sarah Johnson";
  DateTime joinDate = DateTime(2023, 6, 15);
  DateTime lastContact = DateTime(2024, 1, 8);
  
  bool hasUnsavedChanges = false;
  
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
  
  final List<Map<String, dynamic>> customerStatuses = [
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Suspended", "value": "Suspended"},
    {"label": "Pending", "value": "Pending"},
  ];
  
  final List<Map<String, dynamic>> availableTags = [
    {"label": "VIP", "value": "VIP", "color": "gold"},
    {"label": "Priority", "value": "priority", "color": "red"},
    {"label": "New Customer", "value": "new", "color": "green"},
    {"label": "Returning", "value": "returning", "color": "blue"},
    {"label": "Wholesale", "value": "wholesale", "color": "purple"},
    {"label": "Retail", "value": "retail", "color": "orange"},
    {"label": "B2B", "value": "b2b", "color": "teal"},
    {"label": "B2C", "value": "b2c", "color": "pink"},
  ];

  Widget _buildCustomerHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
          
          SizedBox(width: spMd),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$firstName $lastName",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "$email",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Customer ID: $customerId",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              customerStatus,
              style: TextStyle(
                color: successColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
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
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Phone Number",
            value: phone,
            validator: Validator.required,
            onChanged: (value) {
              phone = value;
              hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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

  Widget _buildAddressInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Address Information",
            style: TextStyle(
              fontSize: fsH6,
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
              hasUnsavedChanges = true;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Address Line 2 (Optional)",
            value: addressLine2,
            onChanged: (value) {
              addressLine2 = value;
              hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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

  Widget _buildCustomerDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Customer Details",
            style: TextStyle(
              fontSize: fsH6,
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
                    hasUnsavedChanges = true;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: customerStatuses,
                  value: customerStatus,
                  onChanged: (value, label) {
                    customerStatus = value;
                    hasUnsavedChanges = true;
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
                child: QDropdownField(
                  label: "Source",
                  items: customerSources,
                  value: customerSource,
                  onChanged: (value, label) {
                    customerSource = value;
                    hasUnsavedChanges = true;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Assigned Salesperson",
                  items: salespeople,
                  value: assignedSalesperson,
                  onChanged: (value, label) {
                    assignedSalesperson = value;
                    hasUnsavedChanges = true;
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
                child: QDropdownField(
                  label: "Preferred Language",
                  items: languages,
                  value: preferredLanguage,
                  onChanged: (value, label) {
                    preferredLanguage = value;
                    hasUnsavedChanges = true;
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
                    hasUnsavedChanges = true;
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
                  hasUnsavedChanges = true;
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
              hasUnsavedChanges = true;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferences() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Communication Preferences",
            style: TextStyle(
              fontSize: fsH6,
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
                        hasUnsavedChanges = true;
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
                        hasUnsavedChanges = true;
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
                        hasUnsavedChanges = true;
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
                        hasUnsavedChanges = true;
                        setState(() {});
                      },
                      activeColor: primaryColor,
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

  Widget _buildAccountInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Account Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer Since",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${joinDate.dMMMy}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Contact",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${lastContact.dMMMy}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveChanges() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      hasUnsavedChanges = false;
      setState(() {});
      ss("Customer updated successfully!");
    }
  }

  void _discardChanges() async {
    if (hasUnsavedChanges) {
      bool isConfirmed = await confirm("Discard all unsaved changes?");
      if (isConfirmed) {
        back();
      }
    } else {
      back();
    }
  }

  void _deleteCustomer() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this customer? This action cannot be undone.");
    if (isConfirmed) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Customer deleted successfully!");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Customer"),
        actions: [
          if (hasUnsavedChanges)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Unsaved",
                style: TextStyle(
                  color: warningColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'delete') {
                _deleteCustomer();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: dangerColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Delete Customer",
                      style: TextStyle(color: dangerColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: spMd,
            children: [
              _buildCustomerHeader(),
              
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    _buildBasicInformation(),
                    _buildAddressInformation(),
                    _buildCustomerDetails(),
                    _buildPreferences(),
                    _buildAccountInformation(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Discard",
                size: bs.md,
                onPressed: _discardChanges,
              ),
            ),
            
            Expanded(
              child: QButton(
                label: hasUnsavedChanges ? "Save Changes" : "Update Customer",
                size: bs.md,
                onPressed: _saveChanges,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
