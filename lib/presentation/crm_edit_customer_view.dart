import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmEditCustomerView extends StatefulWidget {
  const CrmEditCustomerView({super.key});

  @override
  State<CrmEditCustomerView> createState() => _CrmEditCustomerViewState();
}

class _CrmEditCustomerViewState extends State<CrmEditCustomerView> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "John";
  String lastName = "Smith";
  String email = "john.smith@email.com";
  String phone = "+1 (555) 123-4567";
  String company = "Tech Solutions Inc";
  String position = "Marketing Director";
  String address = "123 Business Ave";
  String city = "San Francisco";
  String state = "CA";
  String zipCode = "94102";
  String country = "United States";
  String selectedSegment = "vip";
  String selectedSource = "referral";
  String notes = "High-value customer with multiple successful projects";
  String profileImage = "https://picsum.photos/200/200?random=1&keyword=person";
  bool isActive = true;
  bool emailSubscription = true;
  bool smsNotifications = true;

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "Regular Customer", "value": "regular"},
    {"label": "VIP Customer", "value": "vip"},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "Small Business", "value": "small_business"},
  ];

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "Website", "value": "website"},
    {"label": "Social Media", "value": "social_media"},
    {"label": "Referral", "value": "referral"},
    {"label": "Advertisement", "value": "advertisement"},
    {"label": "Cold Call", "value": "cold_call"},
    {"label": "Trade Show", "value": "trade_show"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Customer"),
        actions: [
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () => _showMoreOptions(),
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () => _updateCustomer(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Status Alert
              _buildStatusAlert(),
              
              // Profile Picture Section
              _buildProfileSection(),
              
              // Personal Information
              _buildPersonalInfoSection(),
              
              // Contact Information
              _buildContactInfoSection(),
              
              // Company Information
              _buildCompanyInfoSection(),
              
              // Address Information
              _buildAddressSection(),
              
              // Customer Segmentation
              _buildSegmentationSection(),
              
              // Account History Summary
              _buildHistorySummary(),
              
              // Preferences
              _buildPreferencesSection(),
              
              // Notes Section
              _buildNotesSection(),
              
              // Action Buttons
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusAlert() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified,
            color: successColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "Active VIP Customer since March 2023",
              style: TextStyle(
                color: successColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile Picture",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QImagePicker(
            label: "Customer Photo",
            value: profileImage,
            hint: "Update customer profile picture",
            onChanged: (value) {
              profileImage = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
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
              SizedBox(width: spSm),
              Text(
                "Personal Information",
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
        ],
      ),
    );
  }

  Widget _buildContactInfoSection() {
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
                Icons.notifications,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Communication Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Email Subscription",
                "value": true,
                "checked": emailSubscription,
              }
            ],
            value: [
              if (emailSubscription)
                {
                  "label": "Email Subscription",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              emailSubscription = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "SMS Notifications",
                "value": true,
                "checked": smsNotifications,
              }
            ],
            value: [
              if (smsNotifications)
                {
                  "label": "SMS Notifications",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              smsNotifications = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyInfoSection() {
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
                Icons.business,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Company Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Company Name",
            value: company,
            onChanged: (value) {
              company = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Position/Title",
            value: position,
            onChanged: (value) {
              position = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
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
                Icons.location_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Address Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Street Address",
            value: address,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "City",
                  value: city,
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "State",
                  value: state,
                  onChanged: (value) {
                    state = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  value: zipCode,
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Country",
                  value: country,
                  onChanged: (value) {
                    country = value;
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

  Widget _buildSegmentationSection() {
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
                Icons.category,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Customer Segmentation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Customer Segment",
            items: segmentOptions,
            value: selectedSegment,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedSegment = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Lead Source",
            items: sourceOptions,
            value: selectedSource,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedSource = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySummary() {
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
                Icons.history,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Account Summary",
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Orders",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "24",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$45,230",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
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
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Account Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Active Customer",
                "value": true,
                "checked": isActive,
              }
            ],
            value: [
              if (isActive)
                {
                  "label": "Active Customer",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              isActive = values.isNotEmpty;
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
              SizedBox(width: spSm),
              Text(
                "Customer Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Add or update customer notes",
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
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Update Customer",
            size: bs.md,
            onPressed: () => _updateCustomer(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "View History",
                size: bs.md,
                onPressed: () => _viewHistory(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Delete Customer",
                size: bs.md,
                onPressed: () => _deleteCustomer(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showMoreOptions() {
    // Show additional options menu
    si("More options menu");
  }

  void _updateCustomer() {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Customer updated successfully!");
      });
    }
  }

  void _viewHistory() {
    // Navigate to customer history
    si("Navigate to customer history");
  }

  Future<void> _deleteCustomer() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this customer? This action cannot be undone.");
    
    if (isConfirmed) {
      showLoading();
      
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Customer deleted successfully");
        back();
      });
    }
  }
}
