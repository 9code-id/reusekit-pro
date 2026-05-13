import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosStoreSetupView extends StatefulWidget {
  const PosStoreSetupView({super.key});

  @override
  State<PosStoreSetupView> createState() => _PosStoreSetupViewState();
}

class _PosStoreSetupViewState extends State<PosStoreSetupView> {
  final formKey = GlobalKey<FormState>();
  
  // Store Details
  String storeName = "";
  String storeCode = "";
  String storeDescription = "";
  String storeAddress = "";
  String storeCity = "";
  String storeState = "";
  String storeZipCode = "";
  String storeCountry = "United States";
  String storePhone = "";
  String storeEmail = "";
  String storeWebsite = "";
  
  // Business Hours
  Map<String, Map<String, dynamic>> businessHours = {
    "Monday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00"},
    "Tuesday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00"},
    "Wednesday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00"},
    "Thursday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00"},
    "Friday": {"isOpen": true, "openTime": "09:00", "closeTime": "18:00"},
    "Saturday": {"isOpen": true, "openTime": "10:00", "closeTime": "16:00"},
    "Sunday": {"isOpen": false, "openTime": "10:00", "closeTime": "16:00"},
  };
  
  // Store Settings
  String timezone = "America/New_York";
  String currency = "USD";
  String language = "English";
  bool enableNotifications = true;
  bool enableReceipts = true;
  bool enableLoyalty = false;
  
  final List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Other", "value": "Other"},
  ];

  final List<Map<String, dynamic>> timezones = [
    {"label": "Eastern Time (UTC-5)", "value": "America/New_York"},
    {"label": "Central Time (UTC-6)", "value": "America/Chicago"},
    {"label": "Mountain Time (UTC-7)", "value": "America/Denver"},
    {"label": "Pacific Time (UTC-8)", "value": "America/Los_Angeles"},
  ];

  final List<Map<String, dynamic>> currencies = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
  ];

  final List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "English"},
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
  ];

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Store Setup",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Basic Info", icon: Icon(Icons.store)),
        Tab(text: "Location", icon: Icon(Icons.location_on)),
        Tab(text: "Hours", icon: Icon(Icons.schedule)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildBasicInfoTab(),
        _buildLocationTab(),
        _buildHoursTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Store Information",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "Enter your store's basic information",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),

            QTextField(
              label: "Store Name",
              value: storeName,
              validator: Validator.required,
              onChanged: (value) {
                storeName = value;
                setState(() {});
              },
            ),

            QTextField(
              label: "Store Code",
              value: storeCode,
              hint: "Unique identifier for your store",
              onChanged: (value) {
                storeCode = value;
                setState(() {});
              },
            ),

            QMemoField(
              label: "Store Description",
              value: storeDescription,
              hint: "Brief description of your store",
              onChanged: (value) {
                storeDescription = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Phone Number",
                    value: storePhone,
                    validator: Validator.required,
                    onChanged: (value) {
                      storePhone = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QTextField(
                    label: "Email Address",
                    value: storeEmail,
                    validator: Validator.email,
                    onChanged: (value) {
                      storeEmail = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QTextField(
              label: "Website URL",
              value: storeWebsite,
              hint: "https://www.yourstore.com",
              onChanged: (value) {
                storeWebsite = value;
                setState(() {});
              },
            ),

            // Logo Upload Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Store Logo",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          size: 40,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Upload Store Logo",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Recommended: 200x200px",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Save Basic Information",
              size: bs.md,
              onPressed: () {
                _saveBasicInfo();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Store Location",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Enter your store's physical address",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          QMemoField(
            label: "Street Address",
            value: storeAddress,
            validator: Validator.required,
            onChanged: (value) {
              storeAddress = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "City",
                  value: storeCity,
                  validator: Validator.required,
                  onChanged: (value) {
                    storeCity = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "State/Province",
                  value: storeState,
                  onChanged: (value) {
                    storeState = value;
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
                  value: storeZipCode,
                  onChanged: (value) {
                    storeZipCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Country",
                  items: countries,
                  value: storeCountry,
                  onChanged: (value, label) {
                    storeCountry = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Map Preview Section
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Map Preview",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Location will be shown here",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          QButton(
            label: "Save Location",
            size: bs.md,
            onPressed: () {
              _saveLocation();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHoursTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Business Hours",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Set your store's operating hours",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),

          ...businessHours.entries.map((entry) {
            final day = entry.key;
            final hours = entry.value;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Open",
                              "value": true,
                              "checked": hours["isOpen"],
                            }
                          ],
                          value: [
                            if (hours["isOpen"])
                              {"label": "Open", "value": true, "checked": true}
                          ],
                          onChanged: (values, ids) {
                            businessHours[day]!["isOpen"] = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  if (hours["isOpen"]) ...[
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        SizedBox(width: 80),
                        Expanded(
                          child: QTimePicker(
                            label: "Open Time",
                            value: (hours["openTime"] as String).timeOfDay,
                            onChanged: (value) {
                              businessHours[day]!["openTime"] = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Close Time",
                            value: (hours["closeTime"] as String).timeOfDay,
                            onChanged: (value) {
                              businessHours[day]!["closeTime"] = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }).toList(),

          Container(
            margin: EdgeInsets.symmetric(vertical: spMd),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Copy Monday to All",
                    size: bs.sm,
                    onPressed: () {
                      _copyMondayToAll();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Set All Closed",
                    size: bs.sm,
                    onPressed: () {
                      _setAllClosed();
                    },
                  ),
                ),
              ],
            ),
          ),

          QButton(
            label: "Save Business Hours",
            size: bs.md,
            onPressed: () {
              _saveBusinessHours();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Store Settings",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Configure your store preferences",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Regional Settings
          Container(
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
                  "Regional Settings",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                QDropdownField(
                  label: "Timezone",
                  items: timezones,
                  value: timezone,
                  onChanged: (value, label) {
                    timezone = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Currency",
                        items: currencies,
                        value: currency,
                        onChanged: (value, label) {
                          currency = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Language",
                        items: languages,
                        value: language,
                        onChanged: (value, label) {
                          language = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Store Features
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
                Text(
                  "Store Features",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),

                QSwitch(
                  label: "Feature Options",
                  items: [
                    {
                      "label": "Enable notifications",
                      "value": "notifications",
                      "checked": enableNotifications,
                    },
                    {
                      "label": "Print receipts by default",
                      "value": "receipts",
                      "checked": enableReceipts,
                    },
                    {
                      "label": "Enable loyalty program",
                      "value": "loyalty",
                      "checked": enableLoyalty,
                    },
                  ],
                  value: [
                    if (enableNotifications) {"label": "Enable notifications", "value": "notifications", "checked": true},
                    if (enableReceipts) {"label": "Print receipts by default", "value": "receipts", "checked": true},
                    if (enableLoyalty) {"label": "Enable loyalty program", "value": "loyalty", "checked": true},
                  ],
                  onChanged: (values, ids) {
                    enableNotifications = values.any((v) => v["value"] == "notifications");
                    enableReceipts = values.any((v) => v["value"] == "receipts");
                    enableLoyalty = values.any((v) => v["value"] == "loyalty");
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          QButton(
            label: "Save All Settings",
            size: bs.md,
            onPressed: () {
              _saveAllSettings();
            },
          ),
        ],
      ),
    );
  }

  void _saveBasicInfo() {
    if (formKey.currentState!.validate()) {
      showLoading();
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        ss("Basic information saved successfully");
      });
    }
  }

  void _saveLocation() {
    showLoading();
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Location saved successfully");
    });
  }

  void _saveBusinessHours() {
    showLoading();
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Business hours saved successfully");
    });
  }

  void _saveAllSettings() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("All settings saved successfully");
    });
  }

  void _copyMondayToAll() {
    final mondayHours = businessHours["Monday"]!;
    businessHours.forEach((day, hours) {
      if (day != "Monday") {
        businessHours[day] = Map.from(mondayHours);
      }
    });
    setState(() {});
    si("Monday hours copied to all days");
  }

  void _setAllClosed() {
    businessHours.forEach((day, hours) {
      businessHours[day]!["isOpen"] = false;
    });
    setState(() {});
    si("All days set to closed");
  }
}
