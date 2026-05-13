import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmAddCustomerView extends StatefulWidget {
  const FsmAddCustomerView({super.key});

  @override
  State<FsmAddCustomerView> createState() => _FsmAddCustomerViewState();
}

class _FsmAddCustomerViewState extends State<FsmAddCustomerView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String customerName = "";
  String customerType = "commercial";
  String customerStatus = "active";
  String customerPriority = "medium";
  String industry = "";
  String companySize = "";
  String website = "";
  
  // Contact Information
  String contactPerson = "";
  String contactTitle = "";
  String email = "";
  String phone = "";
  String mobile = "";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  
  // Service Information
  String serviceLevel = "standard";
  String accountManager = "";
  String paymentTerms = "net_30";
  String billingAddress = "";
  String notes = "";
  
  // Additional Information
  bool emergencySupport = false;
  bool maintenanceContract = false;
  bool newsletter = true;
  
  List<Map<String, dynamic>> customerTypeOptions = [
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "Commercial", "value": "commercial"},
    {"label": "Residential", "value": "residential"},
    {"label": "Government", "value": "government"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Suspended", "value": "suspended"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];
  
  List<Map<String, dynamic>> serviceLevelOptions = [
    {"label": "Basic", "value": "basic"},
    {"label": "Standard", "value": "standard"},
    {"label": "Premium", "value": "premium"},
    {"label": "Premium Plus", "value": "premium_plus"},
    {"label": "Enterprise", "value": "enterprise"},
  ];
  
  List<Map<String, dynamic>> paymentTermsOptions = [
    {"label": "Net 15", "value": "net_15"},
    {"label": "Net 30", "value": "net_30"},
    {"label": "Net 45", "value": "net_45"},
    {"label": "Net 60", "value": "net_60"},
    {"label": "Due on Receipt", "value": "due_on_receipt"},
  ];
  
  List<Map<String, dynamic>> accountManagerOptions = [
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Wilson", "value": "mike_wilson"},
    {"label": "Lisa Park", "value": "lisa_park"},
    {"label": "Tom Anderson", "value": "tom_anderson"},
    {"label": "Alex Thompson", "value": "alex_thompson"},
    {"label": "Jenny Kim", "value": "jenny_kim"},
  ];

  void _saveCustomer() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    ss("Customer added successfully!");
    
    // Navigate back or to customer detail
    back();
  }

  Widget _buildBasicInfoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Customer Name",
            value: customerName,
            validator: Validator.required,
            onChanged: (value) {
              customerName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Customer Type",
                  items: customerTypeOptions,
                  value: customerType,
                  onChanged: (value, label) {
                    customerType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: customerStatus,
                  onChanged: (value, label) {
                    customerStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: priorityOptions,
                  value: customerPriority,
                  onChanged: (value, label) {
                    customerPriority = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Industry",
                  value: industry,
                  onChanged: (value) {
                    industry = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Company Size",
                  value: companySize,
                  hint: "e.g., 50-100 employees",
                  onChanged: (value) {
                    companySize = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Website",
                  value: website,
                  hint: "www.example.com",
                  onChanged: (value) {
                    website = value;
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

  Widget _buildContactInfoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Contact Person",
                  value: contactPerson,
                  validator: Validator.required,
                  onChanged: (value) {
                    contactPerson = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Title/Position",
                  value: contactTitle,
                  onChanged: (value) {
                    contactTitle = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Email Address",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Mobile Number",
                  value: mobile,
                  onChanged: (value) {
                    mobile = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Address",
            value: address,
            validator: Validator.required,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                flex: 2,
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
              SizedBox(width: spSm),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceInfoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Service Level",
                  items: serviceLevelOptions,
                  value: serviceLevel,
                  onChanged: (value, label) {
                    serviceLevel = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Account Manager",
                  items: accountManagerOptions,
                  value: accountManager,
                  onChanged: (value, label) {
                    accountManager = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Payment Terms",
            items: paymentTermsOptions,
            value: paymentTerms,
            onChanged: (value, label) {
              paymentTerms = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Billing Address",
            value: billingAddress,
            hint: "Leave empty to use same as contact address",
            onChanged: (value) {
              billingAddress = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Additional notes about the customer...",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalOptionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QSwitch(
            label: "Services",
            items: [
              {
                "label": "24/7 Emergency Support",
                "value": "emergency",
                "checked": emergencySupport,
              },
              {
                "label": "Preventive Maintenance Contract",
                "value": "maintenance",
                "checked": maintenanceContract,
              },
              {
                "label": "Newsletter & Updates",
                "value": "newsletter",
                "checked": newsletter,
              },
            ],
            value: [
              if (emergencySupport) {"label": "24/7 Emergency Support", "value": "emergency", "checked": true},
              if (maintenanceContract) {"label": "Preventive Maintenance Contract", "value": "maintenance", "checked": true},
              if (newsletter) {"label": "Newsletter & Updates", "value": "newsletter", "checked": true},
            ],
            onChanged: (values, ids) {
              emergencySupport = values.any((v) => v["value"] == "emergency");
              maintenanceContract = values.any((v) => v["value"] == "maintenance");
              newsletter = values.any((v) => v["value"] == "newsletter");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Customer"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              _buildBasicInfoSection(),
              _buildContactInfoSection(),
              _buildServiceInfoSection(),
              _buildAdditionalOptionsSection(),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      onPressed: () {
                        back();
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Save Customer",
                      onPressed: _saveCustomer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
