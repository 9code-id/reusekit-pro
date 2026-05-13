import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosAddCustomerView extends StatefulWidget {
  const PosAddCustomerView({super.key});

  @override
  State<PosAddCustomerView> createState() => _PosAddCustomerViewState();
}

class _PosAddCustomerViewState extends State<PosAddCustomerView> {
  final formKey = GlobalKey<FormState>();

  // Basic Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  DateTime? dateOfBirth;

  // Address Information
  String streetAddress = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";

  // Customer Preferences
  String customerTier = "Bronze";
  String preferredPayment = "Credit Card";
  String preferredDelivery = "Standard";
  String customerStatus = "Active";

  // Additional Information
  String notes = "";
  bool emailMarketing = true;
  bool smsMarketing = false;
  bool loyaltyProgram = true;

  List<Map<String, dynamic>> tierOptions = [
    {"label": "Bronze", "value": "Bronze"},
    {"label": "Silver", "value": "Silver"},
    {"label": "Gold", "value": "Gold"},
    {"label": "VIP", "value": "VIP"},
  ];

  List<Map<String, dynamic>> paymentOptions = [
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Debit Card", "value": "Debit Card"},
    {"label": "PayPal", "value": "PayPal"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
    {"label": "Cash", "value": "Cash"},
  ];

  List<Map<String, dynamic>> deliveryOptions = [
    {"label": "Standard", "value": "Standard"},
    {"label": "Express", "value": "Express"},
    {"label": "Same Day", "value": "Same Day"},
    {"label": "Pickup", "value": "Pickup"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> countryOptions = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Other", "value": "Other"},
  ];

  void _saveCustomer() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      ss("Customer created successfully!");
      
      // Navigate back or to customer list
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Customer"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveCustomer,
          ),
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
              // Basic Information Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                          "Basic Information",
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
                    QDatePicker(
                      label: "Date of Birth",
                      value: dateOfBirth,
                      onChanged: (value) {
                        dateOfBirth = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Address Information Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                        SizedBox(width: spXs),
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
                      value: streetAddress,
                      validator: Validator.required,
                      onChanged: (value) {
                        streetAddress = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
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
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "State/Province",
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
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "ZIP/Postal Code",
                            value: zipCode,
                            validator: Validator.required,
                            onChanged: (value) {
                              zipCode = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Country",
                            items: countryOptions,
                            value: country,
                            onChanged: (value, label) {
                              country = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Customer Preferences Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                        SizedBox(width: spXs),
                        Text(
                          "Customer Preferences",
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
                          child: QDropdownField(
                            label: "Customer Tier",
                            items: tierOptions,
                            value: customerTier,
                            onChanged: (value, label) {
                              customerTier = value;
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
                    QDropdownField(
                      label: "Preferred Payment Method",
                      items: paymentOptions,
                      value: preferredPayment,
                      onChanged: (value, label) {
                        preferredPayment = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Preferred Delivery Method",
                      items: deliveryOptions,
                      value: preferredDelivery,
                      onChanged: (value, label) {
                        preferredDelivery = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Marketing Preferences Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                          Icons.mail,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Marketing Preferences",
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
                          "label": "Email Marketing",
                          "value": "email",
                          "checked": emailMarketing,
                        }
                      ],
                      value: [
                        if (emailMarketing)
                          {
                            "label": "Email Marketing",
                            "value": "email",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        emailMarketing = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "SMS Marketing",
                          "value": "sms",
                          "checked": smsMarketing,
                        }
                      ],
                      value: [
                        if (smsMarketing)
                          {
                            "label": "SMS Marketing",
                            "value": "sms",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        smsMarketing = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Loyalty Program",
                          "value": "loyalty",
                          "checked": loyaltyProgram,
                        }
                      ],
                      value: [
                        if (loyaltyProgram)
                          {
                            "label": "Loyalty Program",
                            "value": "loyalty",
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        loyaltyProgram = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Additional Information Section
              Container(
                padding: EdgeInsets.all(spSm),
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
                          "Additional Information",
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
                      hint: "Any additional notes about the customer",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Customer",
                  icon: Icons.add,
                  onPressed: _saveCustomer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
