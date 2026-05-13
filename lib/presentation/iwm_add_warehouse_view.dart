import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmAddWarehouseView extends StatefulWidget {
  const IwmAddWarehouseView({super.key});

  @override
  State<IwmAddWarehouseView> createState() => _IwmAddWarehouseViewState();
}

class _IwmAddWarehouseViewState extends State<IwmAddWarehouseView> {
  final formKey = GlobalKey<FormState>();
  
  String warehouseName = "";
  String warehouseCode = "";
  String address = "";
  String city = "";
  String state = "";
  String zipCode = "";
  String country = "United States";
  String managerName = "";
  String managerEmail = "";
  String managerPhone = "";
  String warehouseType = "distribution";
  String temperatureControl = "ambient";
  String totalCapacity = "";
  String totalAisles = "";
  String totalShelves = "";
  String totalBins = "";
  String operatingHours = "24/7";
  bool hasLoadingDock = true;
  bool hasSecuritySystem = true;
  bool hasFireSafety = true;
  bool hasClimateControl = false;
  String notes = "";

  List<Map<String, dynamic>> warehouseTypes = [
    {"label": "Distribution Center", "value": "distribution"},
    {"label": "Fulfillment Center", "value": "fulfillment"},
    {"label": "Cold Storage", "value": "cold_storage"},
    {"label": "General Storage", "value": "general"},
    {"label": "Cross-Dock", "value": "cross_dock"},
  ];

  List<Map<String, dynamic>> temperatureTypes = [
    {"label": "Ambient Temperature", "value": "ambient"},
    {"label": "Climate Controlled", "value": "climate"},
    {"label": "Refrigerated", "value": "refrigerated"},
    {"label": "Frozen", "value": "frozen"},
  ];

  List<Map<String, dynamic>> operatingSchedules = [
    {"label": "24/7 Operations", "value": "24/7"},
    {"label": "Mon-Fri (8AM-6PM)", "value": "weekdays"},
    {"label": "Mon-Sat (6AM-8PM)", "value": "six_days"},
    {"label": "Custom Schedule", "value": "custom"},
  ];

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "Mexico", "value": "Mexico"},
    {"label": "United Kingdom", "value": "United Kingdom"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Warehouse"),
        actions: [
          TextButton(
            onPressed: _saveWarehouse,
            child: Text(
              "Save",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
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
              _buildBasicInformation(),
              _buildLocationDetails(),
              _buildManagerInformation(),
              _buildWarehouseSpecifications(),
              _buildCapacitySettings(),
              _buildFacilitiesFeatures(),
              _buildAdditionalNotes(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInformation() {
    return Container(
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
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Warehouse Name",
            value: warehouseName,
            validator: Validator.required,
            hint: "Enter warehouse name",
            onChanged: (value) {
              warehouseName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Warehouse Code",
                  value: warehouseCode,
                  validator: Validator.required,
                  hint: "WH001",
                  onChanged: (value) {
                    warehouseCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Warehouse Type",
                  items: warehouseTypes,
                  value: warehouseType,
                  onChanged: (value, label) {
                    warehouseType = value;
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

  Widget _buildLocationDetails() {
    return Container(
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
          Text(
            "Location Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Street Address",
            value: address,
            validator: Validator.required,
            hint: "1234 Industrial Blvd",
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  value: city,
                  validator: Validator.required,
                  hint: "Commerce City",
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
                  validator: Validator.required,
                  hint: "CO",
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
                  validator: Validator.required,
                  hint: "80022",
                  onChanged: (value) {
                    zipCode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Country",
            items: countries,
            value: country,
            onChanged: (value, label) {
              country = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildManagerInformation() {
    return Container(
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
          Text(
            "Manager Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Manager Name",
            value: managerName,
            validator: Validator.required,
            hint: "John Smith",
            onChanged: (value) {
              managerName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Manager Email",
                  value: managerEmail,
                  validator: Validator.email,
                  hint: "john.smith@company.com",
                  onChanged: (value) {
                    managerEmail = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Manager Phone",
                  value: managerPhone,
                  validator: Validator.required,
                  hint: "+1 (555) 123-4567",
                  onChanged: (value) {
                    managerPhone = value;
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

  Widget _buildWarehouseSpecifications() {
    return Container(
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
          Text(
            "Warehouse Specifications",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Temperature Control",
                  items: temperatureTypes,
                  value: temperatureControl,
                  onChanged: (value, label) {
                    temperatureControl = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Operating Hours",
                  items: operatingSchedules,
                  value: operatingHours,
                  onChanged: (value, label) {
                    operatingHours = value;
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

  Widget _buildCapacitySettings() {
    return Container(
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
          Text(
            "Capacity Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Total Capacity (sq ft)",
            value: totalCapacity,
            validator: Validator.required,
            hint: "125000",
            onChanged: (value) {
              totalCapacity = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Total Aisles",
                  value: totalAisles,
                  validator: Validator.required,
                  hint: "24",
                  onChanged: (value) {
                    totalAisles = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Total Shelves",
                  value: totalShelves,
                  validator: Validator.required,
                  hint: "480",
                  onChanged: (value) {
                    totalShelves = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Total Bins",
                  value: totalBins,
                  validator: Validator.required,
                  hint: "3840",
                  onChanged: (value) {
                    totalBins = value;
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

  Widget _buildFacilitiesFeatures() {
    return Container(
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
          Text(
            "Facilities & Features",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Loading Dock Available",
                "value": true,
                "checked": hasLoadingDock,
              }
            ],
            value: [if (hasLoadingDock) {"label": "Loading Dock Available", "value": true, "checked": true}],
            onChanged: (values, ids) {
              hasLoadingDock = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Security System",
                "value": true,
                "checked": hasSecuritySystem,
              }
            ],
            value: [if (hasSecuritySystem) {"label": "Security System", "value": true, "checked": true}],
            onChanged: (values, ids) {
              hasSecuritySystem = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Fire Safety System",
                "value": true,
                "checked": hasFireSafety,
              }
            ],
            value: [if (hasFireSafety) {"label": "Fire Safety System", "value": true, "checked": true}],
            onChanged: (values, ids) {
              hasFireSafety = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Climate Control System",
                "value": true,
                "checked": hasClimateControl,
              }
            ],
            value: [if (hasClimateControl) {"label": "Climate Control System", "value": true, "checked": true}],
            onChanged: (values, ids) {
              hasClimateControl = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalNotes() {
    return Container(
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
          Text(
            "Additional Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Any additional information about the warehouse...",
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
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.md,
                  onPressed: _saveDraft,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Warehouse",
                  size: bs.md,
                  onPressed: _saveWarehouse,
                ),
              ),
            ],
          ),
          Text(
            "Creating a warehouse will also initialize its zone structure and location mapping.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  void _saveDraft() {
    // Save as draft functionality
    ss("Warehouse draft saved successfully");
  }

  void _saveWarehouse() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Warehouse created successfully!");
      
      // Navigate back or to warehouse list
      back();
    } else {
      se("Please complete all required fields");
    }
  }
}
