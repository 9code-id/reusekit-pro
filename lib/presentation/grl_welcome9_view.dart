import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWelcome9View extends StatefulWidget {
  @override
  State<GrlWelcome9View> createState() => _GrlWelcome9ViewState();
}

class _GrlWelcome9ViewState extends State<GrlWelcome9View> {
  String selectedLanguage = "English";
  String selectedTheme = "Light";
  String selectedCurrency = "USD";
  String selectedRegion = "United States";
  bool enableDarkMode = false;
  bool enableNotifications = true;
  bool enableLocationServices = false;
  bool enableAnalytics = true;
  
  final List<Map<String, dynamic>> languages = [
    {"code": "en", "name": "English", "flag": "🇺🇸"},
    {"code": "es", "name": "Spanish", "flag": "🇪🇸"},
    {"code": "fr", "name": "French", "flag": "🇫🇷"},
    {"code": "de", "name": "German", "flag": "🇩🇪"},
    {"code": "it", "name": "Italian", "flag": "🇮🇹"},
    {"code": "pt", "name": "Portuguese", "flag": "🇵🇹"},
    {"code": "zh", "name": "Chinese", "flag": "🇨🇳"},
    {"code": "ja", "name": "Japanese", "flag": "🇯🇵"},
  ];
  
  final List<Map<String, dynamic>> currencies = [
    {"code": "USD", "name": "US Dollar", "symbol": "\$"},
    {"code": "EUR", "name": "Euro", "symbol": "€"},
    {"code": "GBP", "name": "British Pound", "symbol": "£"},
    {"code": "JPY", "name": "Japanese Yen", "symbol": "¥"},
    {"code": "CAD", "name": "Canadian Dollar", "symbol": "C\$"},
    {"code": "AUD", "name": "Australian Dollar", "symbol": "A\$"},
  ];
  
  final List<Map<String, dynamic>> regions = [
    {"code": "US", "name": "United States", "flag": "🇺🇸"},
    {"code": "UK", "name": "United Kingdom", "flag": "🇬🇧"},
    {"code": "CA", "name": "Canada", "flag": "🇨🇦"},
    {"code": "AU", "name": "Australia", "flag": "🇦🇺"},
    {"code": "DE", "name": "Germany", "flag": "🇩🇪"},
    {"code": "FR", "name": "France", "flag": "🇫🇷"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferences"),
        actions: [
          GestureDetector(
            onTap: () {
              // navigateTo('');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, infoColor],
                ),
                borderRadius: BorderRadius.circular(radiusXl),
              ),
              child: Icon(
                Icons.tune,
                size: 40,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Customize Your Experience",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              "Set your preferences to make the app work perfectly for you. Don't worry, you can change these settings anytime.",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Language Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Language & Region",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Language Selector
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Text(
                            languages.firstWhere((lang) => lang["name"] == selectedLanguage)["flag"],
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            selectedLanguage,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      children: languages.map((language) {
                        return GestureDetector(
                          onTap: () {
                            selectedLanguage = language["name"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            child: Row(
                              children: [
                                Text(
                                  "${language["flag"]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${language["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: selectedLanguage == language["name"] 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                      fontWeight: selectedLanguage == language["name"] 
                                          ? FontWeight.w600 
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (selectedLanguage == language["name"])
                                  Icon(
                                    Icons.check,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Region Selector
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Text(
                            regions.firstWhere((region) => region["name"] == selectedRegion)["flag"],
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            selectedRegion,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      children: regions.map((region) {
                        return GestureDetector(
                          onTap: () {
                            selectedRegion = region["name"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            child: Row(
                              children: [
                                Text(
                                  "${region["flag"]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${region["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: selectedRegion == region["name"] 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                      fontWeight: selectedRegion == region["name"] 
                                          ? FontWeight.w600 
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (selectedRegion == region["name"])
                                  Icon(
                                    Icons.check,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Display Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Display Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Dark Mode Toggle
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: enableDarkMode ? primaryColor.withAlpha(30) : disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          enableDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: enableDarkMode ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dark Mode",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Switch between light and dark themes",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          enableDarkMode = !enableDarkMode;
                          setState(() {});
                        },
                        child: Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            color: enableDarkMode ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: AnimatedAlign(
                            duration: Duration(milliseconds: 200),
                            alignment: enableDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              width: 26,
                              height: 26,
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                boxShadow: [shadowSm],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Currency Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Currency Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Currency Selector
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Text(
                            currencies.firstWhere((currency) => currency["code"] == selectedCurrency)["symbol"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${currencies.firstWhere((currency) => currency["code"] == selectedCurrency)["name"]} ($selectedCurrency)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      children: currencies.map((currency) {
                        return GestureDetector(
                          onTap: () {
                            selectedCurrency = currency["code"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  child: Text(
                                    "${currency["symbol"]}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${currency["name"]} (${currency["code"]})",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: selectedCurrency == currency["code"] 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                      fontWeight: selectedCurrency == currency["code"] 
                                          ? FontWeight.w600 
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (selectedCurrency == currency["code"])
                                  Icon(
                                    Icons.check,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Privacy Preferences
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.privacy_tip,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Privacy Preferences",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  _buildPrivacyToggle(
                    Icons.notifications,
                    "Notifications",
                    "Receive app notifications",
                    enableNotifications,
                    successColor,
                    (value) {
                      enableNotifications = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildPrivacyToggle(
                    Icons.location_on,
                    "Location Services",
                    "Allow location access",
                    enableLocationServices,
                    warningColor,
                    (value) {
                      enableLocationServices = value;
                      setState(() {});
                    },
                  ),
                  
                  _buildPrivacyToggle(
                    Icons.analytics,
                    "Analytics",
                    "Help improve the app",
                    enableAnalytics,
                    infoColor,
                    (value) {
                      enableAnalytics = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: sp2xl),
            
            // Save Preferences Button
            QButton(
              label: "Save Preferences",
              size: bs.md,
              onPressed: () {
                // navigateTo('');
              },
            ),
            
            SizedBox(height: spSm),
            
            Container(
              width: double.infinity,
              child: Text(
                "You can always change these settings later in the app preferences.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  height: 1.4,
                ),
              ),
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPrivacyToggle(
    IconData icon,
    String title,
    String description,
    bool value,
    Color color,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => onChanged(!value),
            child: Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                color: value ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: AnimatedAlign(
                duration: Duration(milliseconds: 200),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 26,
                  height: 26,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
