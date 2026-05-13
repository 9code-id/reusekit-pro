import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaRestaurantSettingsView extends StatefulWidget {
  const RmaRestaurantSettingsView({super.key});

  @override
  State<RmaRestaurantSettingsView> createState() => _RmaRestaurantSettingsViewState();
}

class _RmaRestaurantSettingsViewState extends State<RmaRestaurantSettingsView> {
  String restaurantName = "The Golden Spoon";
  String phoneNumber = "+1 234 567 8900";
  String email = "contact@goldenspoon.com";
  String address = "123 Main Street, Downtown City";
  String description = "Authentic Italian cuisine with a modern twist. Family-owned restaurant serving fresh, locally sourced ingredients.";
  String operatingHours = "10:00 AM - 10:00 PM";
  String website = "www.goldenspoon.com";
  String deliveryRadius = "5";
  String minimumOrder = "25";
  bool acceptingOrders = true;
  bool deliveryEnabled = true;
  bool takeawayEnabled = true;
  bool dineInEnabled = true;
  String selectedCurrency = "USD";
  String taxRate = "8.5";
  String serviceCharge = "10";

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveSettings(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildBasicInfoSection(),
            _buildOperationalSettingsSection(),
            _buildServiceOptionsSection(),
            _buildPricingSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
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
        spacing: spSm,
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
            label: "Restaurant Name",
            value: restaurantName,
            onChanged: (value) {
              restaurantName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: phoneNumber,
            onChanged: (value) {
              phoneNumber = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Address",
            value: address,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: description,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Website URL",
            value: website,
            onChanged: (value) {
              website = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOperationalSettingsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Operational Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Operating Hours",
            value: operatingHours,
            hint: "e.g., 9:00 AM - 11:00 PM",
            onChanged: (value) {
              operatingHours = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Delivery Radius (km)",
                  value: deliveryRadius,
                  onChanged: (value) {
                    deliveryRadius = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Minimum Order (\$)",
                  value: minimumOrder,
                  onChanged: (value) {
                    minimumOrder = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            label: "Currently Accepting Orders",
            items: [
              {
                "label": "Accept new orders",
                "value": true,
                "checked": acceptingOrders,
              }
            ],
            value: [if (acceptingOrders) {"label": "Accept new orders", "value": true, "checked": true}],
            onChanged: (values, ids) {
              acceptingOrders = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceOptionsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Service Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            label: "Available Services",
            items: [
              {
                "label": "Delivery",
                "value": "delivery",
                "checked": deliveryEnabled,
              },
              {
                "label": "Takeaway",
                "value": "takeaway",
                "checked": takeawayEnabled,
              },
              {
                "label": "Dine-in",
                "value": "dinein",
                "checked": dineInEnabled,
              },
            ],
            value: [
              if (deliveryEnabled) {"label": "Delivery", "value": "delivery", "checked": true},
              if (takeawayEnabled) {"label": "Takeaway", "value": "takeaway", "checked": true},
              if (dineInEnabled) {"label": "Dine-in", "value": "dinein", "checked": true},
            ],
            onChanged: (values, ids) {
              deliveryEnabled = values.any((v) => v["value"] == "delivery");
              takeawayEnabled = values.any((v) => v["value"] == "takeaway");
              dineInEnabled = values.any((v) => v["value"] == "dinein");
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Pricing & Charges",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Currency",
            items: currencyOptions,
            value: selectedCurrency,
            onChanged: (value, label) {
              selectedCurrency = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Tax Rate (%)",
                  value: taxRate,
                  onChanged: (value) {
                    taxRate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Service Charge (%)",
                  value: serviceCharge,
                  onChanged: (value) {
                    serviceCharge = value;
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

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Changes",
            onPressed: () => _saveSettings(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Reset to Default",
            color: warningColor,
            onPressed: () => _resetSettings(),
          ),
        ),
      ],
    );
  }

  void _saveSettings() {
    ss("Restaurant settings saved successfully");
  }

  void _resetSettings() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all settings to default values?");
    if (isConfirmed) {
      restaurantName = "My Restaurant";
      phoneNumber = "";
      email = "";
      address = "";
      description = "";
      operatingHours = "9:00 AM - 9:00 PM";
      website = "";
      deliveryRadius = "3";
      minimumOrder = "20";
      acceptingOrders = true;
      deliveryEnabled = true;
      takeawayEnabled = true;
      dineInEnabled = true;
      selectedCurrency = "USD";
      taxRate = "0";
      serviceCharge = "0";
      setState(() {});
      si("Settings reset to default values");
    }
  }
}
