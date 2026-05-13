import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaRegionSettingsView extends StatefulWidget {
  const SpaRegionSettingsView({super.key});

  @override
  State<SpaRegionSettingsView> createState() => _SpaRegionSettingsViewState();
}

class _SpaRegionSettingsViewState extends State<SpaRegionSettingsView> {
  String selectedCountry = "united_states";
  String selectedRegion = "north_america";
  String selectedTimezone = "eastern";
  String selectedCurrency = "usd";
  String selectedLanguage = "english";
  String selectedDateFormat = "mm_dd_yyyy";
  String selectedTimeFormat = "12_hour";
  String selectedNumberFormat = "comma_dot";
  bool useMetricSystem = false;
  bool autoDetectLocation = true;
  
  List<Map<String, dynamic>> countryItems = [
    {"label": "United States", "value": "united_states", "region": "north_america"},
    {"label": "Canada", "value": "canada", "region": "north_america"},
    {"label": "United Kingdom", "value": "united_kingdom", "region": "europe"},
    {"label": "Germany", "value": "germany", "region": "europe"},
    {"label": "France", "value": "france", "region": "europe"},
    {"label": "Japan", "value": "japan", "region": "asia_pacific"},
    {"label": "Australia", "value": "australia", "region": "asia_pacific"},
    {"label": "Singapore", "value": "singapore", "region": "asia_pacific"},
    {"label": "Brazil", "value": "brazil", "region": "south_america"},
    {"label": "Mexico", "value": "mexico", "region": "north_america"},
  ];
  
  List<Map<String, dynamic>> regionItems = [
    {"label": "North America", "value": "north_america"},
    {"label": "Europe", "value": "europe"},
    {"label": "Asia Pacific", "value": "asia_pacific"},
    {"label": "South America", "value": "south_america"},
    {"label": "Middle East", "value": "middle_east"},
    {"label": "Africa", "value": "africa"},
  ];
  
  List<Map<String, dynamic>> timezoneItems = [
    {"label": "Eastern Time (UTC-5)", "value": "eastern"},
    {"label": "Central Time (UTC-6)", "value": "central"},
    {"label": "Mountain Time (UTC-7)", "value": "mountain"},
    {"label": "Pacific Time (UTC-8)", "value": "pacific"},
    {"label": "Greenwich Mean Time (UTC+0)", "value": "gmt"},
    {"label": "Central European Time (UTC+1)", "value": "cet"},
    {"label": "Japan Standard Time (UTC+9)", "value": "jst"},
    {"label": "Australian Eastern Time (UTC+10)", "value": "aest"},
  ];
  
  List<Map<String, dynamic>> currencyItems = [
    {"label": "US Dollar (USD)", "value": "usd"},
    {"label": "Euro (EUR)", "value": "eur"},
    {"label": "British Pound (GBP)", "value": "gbp"},
    {"label": "Japanese Yen (JPY)", "value": "jpy"},
    {"label": "Canadian Dollar (CAD)", "value": "cad"},
    {"label": "Australian Dollar (AUD)", "value": "aud"},
    {"label": "Singapore Dollar (SGD)", "value": "sgd"},
    {"label": "Brazilian Real (BRL)", "value": "brl"},
  ];
  
  List<Map<String, dynamic>> languageItems = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Japanese", "value": "japanese"},
    {"label": "Portuguese", "value": "portuguese"},
    {"label": "Italian", "value": "italian"},
    {"label": "Chinese", "value": "chinese"},
  ];
  
  List<Map<String, dynamic>> dateFormatItems = [
    {"label": "MM/DD/YYYY", "value": "mm_dd_yyyy"},
    {"label": "DD/MM/YYYY", "value": "dd_mm_yyyy"},
    {"label": "YYYY-MM-DD", "value": "yyyy_mm_dd"},
    {"label": "DD-MM-YYYY", "value": "dd_mm_yyyy_dash"},
  ];
  
  List<Map<String, dynamic>> timeFormatItems = [
    {"label": "12 Hour (AM/PM)", "value": "12_hour"},
    {"label": "24 Hour", "value": "24_hour"},
  ];
  
  List<Map<String, dynamic>> numberFormatItems = [
    {"label": "Comma Dot (1,234.56)", "value": "comma_dot"},
    {"label": "Dot Comma (1.234,56)", "value": "dot_comma"},
    {"label": "Space Dot (1 234.56)", "value": "space_dot"},
    {"label": "Apostrophe Dot (1'234.56)", "value": "apostrophe_dot"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Region Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () => _resetToDefaults(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildLocationSection(),
            _buildCurrencyLanguageSection(),
            _buildFormatSection(),
            _buildMeasurementSection(),
            _buildPreviewSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLocationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Location Settings",
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
                "label": "Auto-detect location",
                "value": true,
                "checked": autoDetectLocation,
              }
            ],
            value: [if (autoDetectLocation) {"label": "Auto-detect location", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                autoDetectLocation = values.isNotEmpty;
              });
            },
          ),
          QDropdownField(
            label: "Country",
            items: countryItems,
            value: selectedCountry,
            onChanged: (value, label) {
              selectedCountry = value;
              // Auto-update region based on country
              String countryRegion = countryItems.firstWhere(
                (item) => item["value"] == value,
                orElse: () => {"region": "north_america"},
              )["region"];
              selectedRegion = countryRegion;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Region",
            items: regionItems,
            value: selectedRegion,
            onChanged: (value, label) {
              selectedRegion = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Timezone",
            items: timezoneItems,
            value: selectedTimezone,
            onChanged: (value, label) {
              selectedTimezone = value;
              setState(() {});
            },
          ),
          if (autoDetectLocation)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Location will be automatically detected based on your IP address. You can still manually override these settings.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildCurrencyLanguageSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.language,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Currency & Language",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Currency",
            items: currencyItems,
            value: selectedCurrency,
            onChanged: (value, label) {
              selectedCurrency = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Language",
            items: languageItems,
            value: selectedLanguage,
            onChanged: (value, label) {
              selectedLanguage = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Language changes will take effect after restarting the app. Some languages may not be fully supported.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFormatSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.format_list_numbered,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Format Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Date Format",
            items: dateFormatItems,
            value: selectedDateFormat,
            onChanged: (value, label) {
              selectedDateFormat = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Time Format",
            items: timeFormatItems,
            value: selectedTimeFormat,
            onChanged: (value, label) {
              selectedTimeFormat = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Number Format",
            items: numberFormatItems,
            value: selectedNumberFormat,
            onChanged: (value, label) {
              selectedNumberFormat = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildMeasurementSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.straighten,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Measurement System",
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
                "label": "Use Metric System (cm, km, °C)",
                "value": true,
                "checked": useMetricSystem,
              }
            ],
            value: [if (useMetricSystem) {"label": "Use Metric System (cm, km, °C)", "value": true, "checked": true}],
            onChanged: (values, ids) {
              setState(() {
                useMetricSystem = values.isNotEmpty;
              });
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  useMetricSystem ? "Metric System" : "Imperial System",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  useMetricSystem 
                    ? "• Distance: kilometers, meters, centimeters\n• Temperature: Celsius\n• Weight: kilograms, grams"
                    : "• Distance: miles, feet, inches\n• Temperature: Fahrenheit\n• Weight: pounds, ounces",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPreviewSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.preview,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildPreviewItem("Date", _getFormattedDate()),
                _buildPreviewItem("Time", _getFormattedTime()),
                _buildPreviewItem("Currency", _getFormattedCurrency()),
                _buildPreviewItem("Number", _getFormattedNumber()),
                _buildPreviewItem("Temperature", _getFormattedTemperature()),
                _buildPreviewItem("Distance", _getFormattedDistance()),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPreviewItem(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Settings",
            size: bs.md,
            onPressed: () => _saveSettings(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Apply and Restart",
            size: bs.md,
            onPressed: () => _applyAndRestart(),
          ),
        ),
      ],
    );
  }
  
  String _getFormattedDate() {
    DateTime now = DateTime.now();
    switch (selectedDateFormat) {
      case "mm_dd_yyyy":
        return "${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}/${now.year}";
      case "dd_mm_yyyy":
        return "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
      case "yyyy_mm_dd":
        return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      case "dd_mm_yyyy_dash":
        return "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
      default:
        return "${now.month}/${now.day}/${now.year}";
    }
  }
  
  String _getFormattedTime() {
    DateTime now = DateTime.now();
    if (selectedTimeFormat == "24_hour") {
      return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    } else {
      int hour = now.hour;
      String period = hour >= 12 ? "PM" : "AM";
      hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return "${hour}:${now.minute.toString().padLeft(2, '0')} $period";
    }
  }
  
  String _getFormattedCurrency() {
    double amount = 125.99;
    switch (selectedCurrency) {
      case "usd":
        return "\$${amount.toStringAsFixed(2)}";
      case "eur":
        return "€${amount.toStringAsFixed(2)}";
      case "gbp":
        return "£${amount.toStringAsFixed(2)}";
      case "jpy":
        return "¥${amount.toStringAsFixed(0)}";
      default:
        return "\$${amount.toStringAsFixed(2)}";
    }
  }
  
  String _getFormattedNumber() {
    double number = 1234.56;
    switch (selectedNumberFormat) {
      case "comma_dot":
        return "1,234.56";
      case "dot_comma":
        return "1.234,56";
      case "space_dot":
        return "1 234.56";
      case "apostrophe_dot":
        return "1'234.56";
      default:
        return "1,234.56";
    }
  }
  
  String _getFormattedTemperature() {
    int temp = 25;
    return useMetricSystem ? "${temp}°C" : "${((temp * 9/5) + 32).toInt()}°F";
  }
  
  String _getFormattedDistance() {
    double distance = 1000;
    return useMetricSystem ? "${distance / 1000} km" : "${(distance * 0.000621371).toStringAsFixed(2)} miles";
  }
  
  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all region settings to defaults?");
    if (isConfirmed) {
      setState(() {
        selectedCountry = "united_states";
        selectedRegion = "north_america";
        selectedTimezone = "eastern";
        selectedCurrency = "usd";
        selectedLanguage = "english";
        selectedDateFormat = "mm_dd_yyyy";
        selectedTimeFormat = "12_hour";
        selectedNumberFormat = "comma_dot";
        useMetricSystem = false;
        autoDetectLocation = true;
      });
      ss("Settings reset to defaults");
    }
  }
  
  void _saveSettings() {
    ss("Region settings saved successfully");
  }
  
  void _applyAndRestart() async {
    bool isConfirmed = await confirm("Apply settings and restart the app? This is required for some changes to take effect.");
    if (isConfirmed) {
      ss("Settings applied. Restarting app...");
      // Simulate restart
      await Future.delayed(Duration(seconds: 2));
      back();
    }
  }
}
