import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestPreferencesView extends StatefulWidget {
  const HhaGuestPreferencesView({super.key});

  @override
  State<HhaGuestPreferencesView> createState() => _HhaGuestPreferencesViewState();
}

class _HhaGuestPreferencesViewState extends State<HhaGuestPreferencesView> {
  // Room Preferences
  String roomTemperature = "22";
  String bedType = "king";
  String pillowType = "soft";
  bool doNotDisturb = false;
  String wakeUpCall = "07:00";
  bool dailyHousekeeping = true;
  
  // Dining Preferences
  String dietaryRestrictions = "";
  bool vegetarian = false;
  bool vegan = false;
  bool glutenFree = false;
  bool dairyFree = false;
  String drinkPreference = "coffee";
  
  // Communication Preferences
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool promotionalEmails = true;
  String preferredLanguage = "english";
  
  // Service Preferences
  String newspaperType = "the_times";
  bool airportTransfer = false;
  bool laundryService = false;
  bool carRental = false;
  
  // Accessibility Needs
  bool mobilityAssistance = false;
  bool hearingAssistance = false;
  bool visualAssistance = false;
  String accessibilityNotes = "";

  List<Map<String, dynamic>> temperatureItems = [
    {"label": "18°C", "value": "18"},
    {"label": "20°C", "value": "20"},
    {"label": "22°C", "value": "22"},
    {"label": "24°C", "value": "24"},
    {"label": "26°C", "value": "26"},
  ];

  List<Map<String, dynamic>> bedTypeItems = [
    {"label": "Single Bed", "value": "single"},
    {"label": "Double Bed", "value": "double"},
    {"label": "Queen Bed", "value": "queen"},
    {"label": "King Bed", "value": "king"},
  ];

  List<Map<String, dynamic>> pillowTypeItems = [
    {"label": "Soft Pillow", "value": "soft"},
    {"label": "Medium Pillow", "value": "medium"},
    {"label": "Firm Pillow", "value": "firm"},
    {"label": "Memory Foam", "value": "memory_foam"},
  ];

  List<Map<String, dynamic>> drinkItems = [
    {"label": "Coffee", "value": "coffee"},
    {"label": "Tea", "value": "tea"},
    {"label": "Hot Chocolate", "value": "hot_chocolate"},
    {"label": "Herbal Tea", "value": "herbal_tea"},
  ];

  List<Map<String, dynamic>> languageItems = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Italian", "value": "italian"},
    {"label": "Japanese", "value": "japanese"},
    {"label": "Chinese", "value": "chinese"},
  ];

  List<Map<String, dynamic>> newspaperItems = [
    {"label": "The Times", "value": "the_times"},
    {"label": "Wall Street Journal", "value": "wsj"},
    {"label": "Financial Times", "value": "ft"},
    {"label": "USA Today", "value": "usa_today"},
    {"label": "Local Newspaper", "value": "local"},
    {"label": "No Newspaper", "value": "none"},
  ];

  void _savePreferences() async {
    showLoading();
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Preferences saved successfully");
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Are you sure you want to reset all preferences to defaults?");
    if (isConfirmed) {
      setState(() {
        roomTemperature = "22";
        bedType = "king";
        pillowType = "soft";
        doNotDisturb = false;
        wakeUpCall = "07:00";
        dailyHousekeeping = true;
        
        dietaryRestrictions = "";
        vegetarian = false;
        vegan = false;
        glutenFree = false;
        dairyFree = false;
        drinkPreference = "coffee";
        
        emailNotifications = true;
        smsNotifications = false;
        promotionalEmails = true;
        preferredLanguage = "english";
        
        newspaperType = "the_times";
        airportTransfer = false;
        laundryService = false;
        carRental = false;
        
        mobilityAssistance = false;
        hearingAssistance = false;
        visualAssistance = false;
        accessibilityNotes = "";
      });
      
      si("Preferences reset to defaults");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Preferences"),
        actions: [
          TextButton(
            onPressed: _resetToDefaults,
            child: Text(
              "Reset",
              style: TextStyle(
                color: dangerColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.tune,
                    size: 32,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Customize Your Stay",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Set your preferences to personalize your hotel experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Room Preferences Section
            _buildSectionCard(
              "Room Preferences",
              Icons.hotel,
              [
                QDropdownField(
                  label: "Preferred Room Temperature",
                  items: temperatureItems,
                  value: roomTemperature,
                  onChanged: (value, label) {
                    roomTemperature = value;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Bed Type",
                  items: bedTypeItems,
                  value: bedType,
                  onChanged: (value, label) {
                    bedType = value;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Pillow Type",
                  items: pillowTypeItems,
                  value: pillowType,
                  onChanged: (value, label) {
                    pillowType = value;
                    setState(() {});
                  },
                ),
                
                QTimePicker(
                  label: "Wake-up Call Time",
                  value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${wakeUpCall}:00")),
                  onChanged: (value) {
                    wakeUpCall = value!.kkmm;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Do Not Disturb (Default)",
                      "value": true,
                      "checked": doNotDisturb,
                    }
                  ],
                  value: doNotDisturb ? [{"label": "Do Not Disturb (Default)", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    doNotDisturb = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Daily Housekeeping",
                      "value": true,
                      "checked": dailyHousekeeping,
                    }
                  ],
                  value: dailyHousekeeping ? [{"label": "Daily Housekeeping", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    dailyHousekeeping = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Dining Preferences Section
            _buildSectionCard(
              "Dining Preferences",
              Icons.restaurant,
              [
                QMemoField(
                  label: "Dietary Restrictions & Allergies",
                  value: dietaryRestrictions,
                  hint: "Please list any allergies or dietary restrictions",
                  onChanged: (value) {
                    dietaryRestrictions = value;
                    setState(() {});
                  },
                ),
                
                Text(
                  "Dietary Preferences",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  items: [
                    {"label": "Vegetarian", "value": "vegetarian", "checked": vegetarian},
                    {"label": "Vegan", "value": "vegan", "checked": vegan},
                    {"label": "Gluten-Free", "value": "gluten_free", "checked": glutenFree},
                    {"label": "Dairy-Free", "value": "dairy_free", "checked": dairyFree},
                  ],
                  value: [
                    if (vegetarian) {"label": "Vegetarian", "value": "vegetarian", "checked": true},
                    if (vegan) {"label": "Vegan", "value": "vegan", "checked": true},
                    if (glutenFree) {"label": "Gluten-Free", "value": "gluten_free", "checked": true},
                    if (dairyFree) {"label": "Dairy-Free", "value": "dairy_free", "checked": true},
                  ],
                  onChanged: (values, ids) {
                    vegetarian = values.any((v) => v["value"] == "vegetarian");
                    vegan = values.any((v) => v["value"] == "vegan");
                    glutenFree = values.any((v) => v["value"] == "gluten_free");
                    dairyFree = values.any((v) => v["value"] == "dairy_free");
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Preferred Welcome Drink",
                  items: drinkItems,
                  value: drinkPreference,
                  onChanged: (value, label) {
                    drinkPreference = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Communication Preferences Section
            _buildSectionCard(
              "Communication Preferences",
              Icons.notifications,
              [
                QDropdownField(
                  label: "Preferred Language",
                  items: languageItems,
                  value: preferredLanguage,
                  onChanged: (value, label) {
                    preferredLanguage = value;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Email Notifications",
                      "value": true,
                      "checked": emailNotifications,
                    }
                  ],
                  value: emailNotifications ? [{"label": "Email Notifications", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    emailNotifications = values.isNotEmpty;
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
                  value: smsNotifications ? [{"label": "SMS Notifications", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    smsNotifications = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Promotional Emails",
                      "value": true,
                      "checked": promotionalEmails,
                    }
                  ],
                  value: promotionalEmails ? [{"label": "Promotional Emails", "value": true, "checked": true}] : [],
                  onChanged: (values, ids) {
                    promotionalEmails = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Service Preferences Section
            _buildSectionCard(
              "Service Preferences",
              Icons.room_service,
              [
                QDropdownField(
                  label: "Daily Newspaper",
                  items: newspaperItems,
                  value: newspaperType,
                  onChanged: (value, label) {
                    newspaperType = value;
                    setState(() {});
                  },
                ),
                
                Text(
                  "Additional Services",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  items: [
                    {"label": "Airport Transfer Service", "value": "airport", "checked": airportTransfer},
                    {"label": "Laundry Service", "value": "laundry", "checked": laundryService},
                    {"label": "Car Rental Service", "value": "car_rental", "checked": carRental},
                  ],
                  value: [
                    if (airportTransfer) {"label": "Airport Transfer Service", "value": "airport", "checked": true},
                    if (laundryService) {"label": "Laundry Service", "value": "laundry", "checked": true},
                    if (carRental) {"label": "Car Rental Service", "value": "car_rental", "checked": true},
                  ],
                  onChanged: (values, ids) {
                    airportTransfer = values.any((v) => v["value"] == "airport");
                    laundryService = values.any((v) => v["value"] == "laundry");
                    carRental = values.any((v) => v["value"] == "car_rental");
                    setState(() {});
                  },
                ),
              ],
            ),

            // Accessibility Needs Section
            _buildSectionCard(
              "Accessibility & Special Needs",
              Icons.accessible,
              [
                Text(
                  "Assistance Required",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  items: [
                    {"label": "Mobility Assistance", "value": "mobility", "checked": mobilityAssistance},
                    {"label": "Hearing Assistance", "value": "hearing", "checked": hearingAssistance},
                    {"label": "Visual Assistance", "value": "visual", "checked": visualAssistance},
                  ],
                  value: [
                    if (mobilityAssistance) {"label": "Mobility Assistance", "value": "mobility", "checked": true},
                    if (hearingAssistance) {"label": "Hearing Assistance", "value": "hearing", "checked": true},
                    if (visualAssistance) {"label": "Visual Assistance", "value": "visual", "checked": true},
                  ],
                  onChanged: (values, ids) {
                    mobilityAssistance = values.any((v) => v["value"] == "mobility");
                    hearingAssistance = values.any((v) => v["value"] == "hearing");
                    visualAssistance = values.any((v) => v["value"] == "visual");
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Additional Accessibility Notes",
                  value: accessibilityNotes,
                  hint: "Please describe any other special needs or requirements",
                  onChanged: (value) {
                    accessibilityNotes = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Preferences",
                size: bs.md,
                onPressed: _savePreferences,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }
}
