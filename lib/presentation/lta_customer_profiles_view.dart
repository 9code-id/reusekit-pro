import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaCustomerProfilesView extends StatefulWidget {
  const LtaCustomerProfilesView({super.key});

  @override
  State<LtaCustomerProfilesView> createState() => _LtaCustomerProfilesViewState();
}

class _LtaCustomerProfilesViewState extends State<LtaCustomerProfilesView> {
  bool loading = true;
  Map<String, dynamic> selectedCustomer = {};
  
  List<Map<String, dynamic>> customerProfiles = [
    {
      "id": "prof_001",
      "customer_id": "cust_001",
      "name": "ABC Manufacturing Corp",
      "type": "Corporate",
      "status": "Active",
      "created_date": "2023-06-15",
      "last_updated": "2024-01-10",
      "profile": {
        "company_size": "Large (500+ employees)",
        "industry": "Manufacturing",
        "annual_revenue": 25000000.00,
        "shipping_volume": "High",
        "preferred_services": ["Express Delivery", "Same Day", "Freight"],
        "payment_terms": "Net 30",
        "credit_rating": "AAA",
        "tax_id": "12-3456789",
        "duns_number": "123456789"
      },
      "preferences": {
        "notification_method": "Email + SMS",
        "pickup_instructions": "Loading dock available 8AM-5PM",
        "delivery_instructions": "Ring bell at reception",
        "insurance_required": true,
        "signature_required": true,
        "weekend_delivery": false,
        "evening_delivery": true
      },
      "contacts": [
        {
          "name": "John Smith",
          "title": "Logistics Manager",
          "email": "john.smith@abcmanufacturing.com",
          "phone": "+1 (555) 123-4567",
          "is_primary": true,
          "department": "Operations"
        },
        {
          "name": "Sarah Johnson",
          "title": "Accounts Payable",
          "email": "sarah.johnson@abcmanufacturing.com",
          "phone": "+1 (555) 123-4568",
          "is_primary": false,
          "department": "Finance"
        }
      ],
      "addresses": [
        {
          "type": "Headquarters",
          "street": "1234 Industrial Blvd",
          "city": "Chicago",
          "state": "IL",
          "zip": "60601",
          "country": "USA",
          "is_default": true,
          "business_hours": "8:00 AM - 5:00 PM"
        },
        {
          "type": "Warehouse",
          "street": "5678 Distribution Center Dr",
          "city": "Chicago",
          "state": "IL",
          "zip": "60602",
          "country": "USA",
          "is_default": false,
          "business_hours": "6:00 AM - 10:00 PM"
        }
      ],
      "service_history": {
        "total_shipments": 145,
        "on_time_delivery": 94.5,
        "avg_shipment_value": 1250.75,
        "preferred_carrier": "Express",
        "damage_rate": 0.8,
        "customer_satisfaction": 4.8
      }
    },
    {
      "id": "prof_002",
      "customer_id": "cust_002",
      "name": "Tech Solutions Inc",
      "type": "Business",
      "status": "Active",
      "created_date": "2023-08-22",
      "last_updated": "2024-01-08",
      "profile": {
        "company_size": "Medium (50-499 employees)",
        "industry": "Technology",
        "annual_revenue": 8500000.00,
        "shipping_volume": "Medium",
        "preferred_services": ["Standard Delivery", "Express Delivery"],
        "payment_terms": "Net 15",
        "credit_rating": "AA",
        "tax_id": "98-7654321",
        "duns_number": "987654321"
      },
      "preferences": {
        "notification_method": "Email",
        "pickup_instructions": "Security desk on first floor",
        "delivery_instructions": "Reception desk, sign for packages",
        "insurance_required": true,
        "signature_required": true,
        "weekend_delivery": false,
        "evening_delivery": false
      },
      "contacts": [
        {
          "name": "Sarah Johnson",
          "title": "Operations Director",
          "email": "sarah.johnson@techsolutions.com",
          "phone": "+1 (555) 987-6543",
          "is_primary": true,
          "department": "Operations"
        }
      ],
      "addresses": [
        {
          "type": "Main Office",
          "street": "789 Tech Park Dr",
          "city": "Austin",
          "state": "TX",
          "zip": "73301",
          "country": "USA",
          "is_default": true,
          "business_hours": "9:00 AM - 6:00 PM"
        }
      ],
      "service_history": {
        "total_shipments": 89,
        "on_time_delivery": 92.1,
        "avg_shipment_value": 514.38,
        "preferred_carrier": "Standard",
        "damage_rate": 1.2,
        "customer_satisfaction": 4.5
      }
    },
    {
      "id": "prof_003",
      "customer_id": "cust_003",
      "name": "Emma Rodriguez",
      "type": "Individual",
      "status": "Active",
      "created_date": "2023-12-05",
      "last_updated": "2024-01-05",
      "profile": {
        "company_size": "Individual",
        "industry": "Retail Consumer",
        "annual_revenue": 0,
        "shipping_volume": "Low",
        "preferred_services": ["Standard Delivery"],
        "payment_terms": "Payment on Delivery",
        "credit_rating": "B",
        "tax_id": "",
        "duns_number": ""
      },
      "preferences": {
        "notification_method": "SMS",
        "pickup_instructions": "Ring doorbell",
        "delivery_instructions": "Leave at front door if no answer",
        "insurance_required": false,
        "signature_required": false,
        "weekend_delivery": true,
        "evening_delivery": true
      },
      "contacts": [
        {
          "name": "Emma Rodriguez",
          "title": "Customer",
          "email": "emma.rodriguez@email.com",
          "phone": "+1 (555) 234-5678",
          "is_primary": true,
          "department": "Personal"
        }
      ],
      "addresses": [
        {
          "type": "Home",
          "street": "123 Residential Ave",
          "city": "Miami",
          "state": "FL",
          "zip": "33101",
          "country": "USA",
          "is_default": true,
          "business_hours": "Any time"
        }
      ],
      "service_history": {
        "total_shipments": 12,
        "on_time_delivery": 91.7,
        "avg_shipment_value": 104.23,
        "preferred_carrier": "Standard",
        "damage_rate": 0.0,
        "customer_satisfaction": 4.2
      }
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    if (customerProfiles.isNotEmpty) {
      selectedCustomer = customerProfiles[0];
    }
    loading = false;
    setState(() {});
  }

  void _showEditProfileDialog() {
    if (selectedCustomer.isEmpty) return;

    Map<String, dynamic> profile = selectedCustomer["profile"];
    String companySize = "${profile["company_size"]}";
    String industry = "${profile["industry"]}";
    String shippingVolume = "${profile["shipping_volume"]}";
    String paymentTerms = "${profile["payment_terms"]}";
    String creditRating = "${profile["credit_rating"]}";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Customer Profile"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDropdownField(
                label: "Company Size",
                items: [
                  {"label": "Individual", "value": "Individual"},
                  {"label": "Small (1-49 employees)", "value": "Small (1-49 employees)"},
                  {"label": "Medium (50-499 employees)", "value": "Medium (50-499 employees)"},
                  {"label": "Large (500+ employees)", "value": "Large (500+ employees)"},
                ],
                value: companySize,
                onChanged: (value, label) => companySize = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Industry",
                value: industry,
                onChanged: (value) => industry = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Shipping Volume",
                items: [
                  {"label": "Low", "value": "Low"},
                  {"label": "Medium", "value": "Medium"},
                  {"label": "High", "value": "High"},
                  {"label": "Very High", "value": "Very High"},
                ],
                value: shippingVolume,
                onChanged: (value, label) => shippingVolume = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Payment Terms",
                items: [
                  {"label": "Payment on Delivery", "value": "Payment on Delivery"},
                  {"label": "Net 15", "value": "Net 15"},
                  {"label": "Net 30", "value": "Net 30"},
                  {"label": "Net 45", "value": "Net 45"},
                  {"label": "Net 60", "value": "Net 60"},
                ],
                value: paymentTerms,
                onChanged: (value, label) => paymentTerms = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Credit Rating",
                items: [
                  {"label": "AAA", "value": "AAA"},
                  {"label": "AA", "value": "AA"},
                  {"label": "A", "value": "A"},
                  {"label": "BBB", "value": "BBB"},
                  {"label": "BB", "value": "BB"},
                  {"label": "B", "value": "B"},
                  {"label": "C", "value": "C"},
                ],
                value: creditRating,
                onChanged: (value, label) => creditRating = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Customer profile updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showEditPreferencesDialog() {
    if (selectedCustomer.isEmpty) return;

    Map<String, dynamic> preferences = selectedCustomer["preferences"];
    String notificationMethod = "${preferences["notification_method"]}";
    String pickupInstructions = "${preferences["pickup_instructions"]}";
    String deliveryInstructions = "${preferences["delivery_instructions"]}";
    bool insuranceRequired = preferences["insurance_required"];
    bool signatureRequired = preferences["signature_required"];
    bool weekendDelivery = preferences["weekend_delivery"];
    bool eveningDelivery = preferences["evening_delivery"];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Edit Delivery Preferences"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QDropdownField(
                  label: "Notification Method",
                  items: [
                    {"label": "Email", "value": "Email"},
                    {"label": "SMS", "value": "SMS"},
                    {"label": "Email + SMS", "value": "Email + SMS"},
                    {"label": "Phone Call", "value": "Phone Call"},
                  ],
                  value: notificationMethod,
                  onChanged: (value, label) {
                    notificationMethod = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QMemoField(
                  label: "Pickup Instructions",
                  value: pickupInstructions,
                  onChanged: (value) {
                    pickupInstructions = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QMemoField(
                  label: "Delivery Instructions",
                  value: deliveryInstructions,
                  onChanged: (value) {
                    deliveryInstructions = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Insurance Required",
                      "value": true,
                      "checked": insuranceRequired,
                    }
                  ],
                  value: [if (insuranceRequired) {"label": "Insurance Required", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    insuranceRequired = values.isNotEmpty;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Signature Required",
                      "value": true,
                      "checked": signatureRequired,
                    }
                  ],
                  value: [if (signatureRequired) {"label": "Signature Required", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    signatureRequired = values.isNotEmpty;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Weekend Delivery",
                      "value": true,
                      "checked": weekendDelivery,
                    }
                  ],
                  value: [if (weekendDelivery) {"label": "Weekend Delivery", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    weekendDelivery = values.isNotEmpty;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Evening Delivery",
                      "value": true,
                      "checked": eveningDelivery,
                    }
                  ],
                  value: [if (eveningDelivery) {"label": "Evening Delivery", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    eveningDelivery = values.isNotEmpty;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Save Changes",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Delivery preferences updated successfully");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddContactDialog() {
    String name = "";
    String title = "";
    String email = "";
    String phone = "";
    String department = "";
    bool isPrimary = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Add Contact"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QTextField(
                  label: "Contact Name",
                  value: name,
                  onChanged: (value) {
                    name = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Title",
                  value: title,
                  onChanged: (value) {
                    title = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Email",
                        value: email,
                        onChanged: (value) {
                          email = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Phone",
                        value: phone,
                        onChanged: (value) {
                          phone = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Department",
                  value: department,
                  onChanged: (value) {
                    department = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Primary Contact",
                      "value": true,
                      "checked": isPrimary,
                    }
                  ],
                  value: [if (isPrimary) {"label": "Primary Contact", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isPrimary = values.isNotEmpty;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Add Contact",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Contact added successfully");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAddressDialog() {
    String type = "Office";
    String street = "";
    String city = "";
    String state = "";
    String zip = "";
    String country = "USA";
    String businessHours = "";
    bool isDefault = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Add Address"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QTextField(
                  label: "Address Type",
                  value: type,
                  onChanged: (value) {
                    type = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Street Address",
                  value: street,
                  onChanged: (value) {
                    street = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "City",
                        value: city,
                        onChanged: (value) {
                          city = value;
                          setDialogState(() {});
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
                          setDialogState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "ZIP",
                        value: zip,
                        onChanged: (value) {
                          zip = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Business Hours",
                  value: businessHours,
                  onChanged: (value) {
                    businessHours = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Default Address",
                      "value": true,
                      "checked": isDefault,
                    }
                  ],
                  value: [if (isDefault) {"label": "Default Address", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isDefault = values.isNotEmpty;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Add Address",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Address added successfully");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    if (selectedCustomer.isEmpty) return Container();

    Map<String, dynamic> profile = selectedCustomer["profile"];
    
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Customer Profile",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: _showEditProfileDialog,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spXs,
            children: [
              _buildProfileRow("Company Size", "${profile["company_size"]}"),
              _buildProfileRow("Industry", "${profile["industry"]}"),
              _buildProfileRow("Annual Revenue", profile["annual_revenue"] > 0 ? "\$${((profile["annual_revenue"] as num).toDouble()).currency}" : "N/A"),
              _buildProfileRow("Shipping Volume", "${profile["shipping_volume"]}"),
              _buildProfileRow("Payment Terms", "${profile["payment_terms"]}"),
              _buildProfileRow("Credit Rating", "${profile["credit_rating"]}"),
              if (profile["tax_id"].toString().isNotEmpty)
                _buildProfileRow("Tax ID", "${profile["tax_id"]}"),
              if (profile["duns_number"].toString().isNotEmpty)
                _buildProfileRow("DUNS Number", "${profile["duns_number"]}"),
            ],
          ),
          if (profile["preferred_services"] != null) ...[
            SizedBox(height: spSm),
            Text(
              "Preferred Services:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (profile["preferred_services"] as List).map((service) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$service",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPreferencesCard() {
    if (selectedCustomer.isEmpty) return Container();

    Map<String, dynamic> preferences = selectedCustomer["preferences"];
    
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: _showEditPreferencesDialog,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spXs,
            children: [
              _buildProfileRow("Notification Method", "${preferences["notification_method"]}"),
              _buildProfileRow("Pickup Instructions", "${preferences["pickup_instructions"]}"),
              _buildProfileRow("Delivery Instructions", "${preferences["delivery_instructions"]}"),
              _buildProfileRow("Insurance Required", preferences["insurance_required"] ? "Yes" : "No"),
              _buildProfileRow("Signature Required", preferences["signature_required"] ? "Yes" : "No"),
              _buildProfileRow("Weekend Delivery", preferences["weekend_delivery"] ? "Yes" : "No"),
              _buildProfileRow("Evening Delivery", preferences["evening_delivery"] ? "Yes" : "No"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactsCard() {
    if (selectedCustomer.isEmpty) return Container();

    List<dynamic> contacts = selectedCustomer["contacts"];
    
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Contacts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: _showAddContactDialog,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: contacts.map((contact) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: contact["is_primary"] ? Border.all(color: primaryColor, width: 2) : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${contact["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (contact["is_primary"])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "PRIMARY",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${contact["title"]} - ${contact["department"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${contact["email"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${contact["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressesCard() {
    if (selectedCustomer.isEmpty) return Container();

    List<dynamic> addresses = selectedCustomer["addresses"];
    
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Addresses",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: _showAddAddressDialog,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: addresses.map((address) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: address["is_default"] ? Border.all(color: primaryColor, width: 2) : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${address["type"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (address["is_default"])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "DEFAULT",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${address["street"]}\n${address["city"]}, ${address["state"]} ${address["zip"]}\n${address["country"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (address["business_hours"] != null) ...[
                      SizedBox(height: spXs),
                      Text(
                        "Hours: ${address["business_hours"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceHistoryCard() {
    if (selectedCustomer.isEmpty) return Container();

    Map<String, dynamic> serviceHistory = selectedCustomer["service_history"];
    
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
            "Service History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spXs,
            children: [
              _buildProfileRow("Total Shipments", "${serviceHistory["total_shipments"]}"),
              _buildProfileRow("On-Time Delivery", "${(serviceHistory["on_time_delivery"] as num).toStringAsFixed(1)}%"),
              _buildProfileRow("Avg Shipment Value", "\$${((serviceHistory["avg_shipment_value"] as num).toDouble()).currency}"),
              _buildProfileRow("Preferred Carrier", "${serviceHistory["preferred_carrier"]}"),
              _buildProfileRow("Damage Rate", "${(serviceHistory["damage_rate"] as num).toStringAsFixed(1)}%"),
              _buildProfileRow("Customer Satisfaction", "${(serviceHistory["customer_satisfaction"] as num).toStringAsFixed(1)} ⭐"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Profiles"),
      ),
      body: Row(
        children: [
          // Customer List Sidebar
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    border: Border(
                      bottom: BorderSide(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Customer Profiles",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: customerProfiles.length,
                    itemBuilder: (context, index) {
                      final profile = customerProfiles[index];
                      bool isSelected = selectedCustomer["id"] == profile["id"];
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor.withAlpha(50),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              selectedCustomer = profile;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${profile["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? primaryColor : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${profile["type"]} • ${profile["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Updated: ${profile["last_updated"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Profile Details
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: selectedCustomer.isEmpty 
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Select a customer profile",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer Header
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                Icons.business,
                                color: primaryColor,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${selectedCustomer["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH5,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${selectedCustomer["type"]} Customer",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "ID: ${selectedCustomer["id"]} • Created: ${selectedCustomer["created_date"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: selectedCustomer["status"] == "Active" 
                                    ? successColor.withAlpha(20) 
                                    : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${selectedCustomer["status"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: selectedCustomer["status"] == "Active" 
                                      ? successColor 
                                      : disabledColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                      
                      // Profile Information Cards
                      Column(
                        spacing: spMd,
                        children: [
                          _buildProfileCard(),
                          _buildPreferencesCard(),
                          _buildContactsCard(),
                          _buildAddressesCard(),
                          _buildServiceHistoryCard(),
                        ],
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
