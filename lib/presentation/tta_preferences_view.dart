import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaPreferencesView extends StatefulWidget {
  const TtaPreferencesView({super.key});

  @override
  State<TtaPreferencesView> createState() => _TtaPreferencesViewState();
}

class _TtaPreferencesViewState extends State<TtaPreferencesView> {
  String selectedBudgetRange = "";
  String preferredAccommodation = "";
  String travelStyle = "";
  List<String> selectedInterests = [];
  List<String> selectedActivities = [];
  String selectedLanguage = "";
  String selectedCurrency = "";
  bool enableNotifications = true;
  bool enableLocationServices = true;
  bool shareProfile = false;
  bool loading = false;

  List<Map<String, dynamic>> budgetRanges = [
    {"label": "Budget (\$0 - \$500)", "value": "budget"},
    {"label": "Mid-range (\$500 - \$1,500)", "value": "mid_range"},
    {"label": "Luxury (\$1,500 - \$5,000)", "value": "luxury"},
    {"label": "Ultra Luxury (\$5,000+)", "value": "ultra_luxury"},
  ];

  List<Map<String, dynamic>> accommodationTypes = [
    {"label": "Hotels", "value": "hotel"},
    {"label": "Hostels", "value": "hostel"},
    {"label": "Vacation Rentals", "value": "rental"},
    {"label": "Bed & Breakfast", "value": "bnb"},
    {"label": "Camping", "value": "camping"},
    {"label": "Resort", "value": "resort"},
  ];

  List<Map<String, dynamic>> travelStyles = [
    {"label": "Solo Traveler", "value": "solo"},
    {"label": "Couple", "value": "couple"},
    {"label": "Family", "value": "family"},
    {"label": "Group Travel", "value": "group"},
    {"label": "Business Travel", "value": "business"},
  ];

  List<Map<String, dynamic>> interests = [
    {"label": "Adventure", "value": "adventure"},
    {"label": "Culture & History", "value": "culture"},
    {"label": "Food & Dining", "value": "food"},
    {"label": "Nature & Wildlife", "value": "nature"},
    {"label": "Beaches", "value": "beaches"},
    {"label": "Mountains", "value": "mountains"},
    {"label": "Photography", "value": "photography"},
    {"label": "Architecture", "value": "architecture"},
  ];

  List<Map<String, dynamic>> activities = [
    {"label": "Hiking", "value": "hiking"},
    {"label": "Water Sports", "value": "water_sports"},
    {"label": "Sightseeing", "value": "sightseeing"},
    {"label": "Shopping", "value": "shopping"},
    {"label": "Nightlife", "value": "nightlife"},
    {"label": "Museums", "value": "museums"},
    {"label": "Local Tours", "value": "tours"},
    {"label": "Extreme Sports", "value": "extreme_sports"},
  ];

  List<Map<String, dynamic>> languages = [
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Italian", "value": "it"},
    {"label": "Portuguese", "value": "pt"},
    {"label": "Japanese", "value": "jp"},
    {"label": "Chinese", "value": "zh"},
  ];

  List<Map<String, dynamic>> currencies = [
    {"label": "USD (\$)", "value": "usd"},
    {"label": "EUR (€)", "value": "eur"},
    {"label": "GBP (£)", "value": "gbp"},
    {"label": "JPY (¥)", "value": "jpy"},
    {"label": "CAD (C\$)", "value": "cad"},
    {"label": "AUD (A\$)", "value": "aud"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Preferences"),
        actions: [
          TextButton(
            onPressed: () {
              // Skip preferences
              ss("Preferences saved with defaults");
            },
            child: Text(
              "Skip",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tune,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Customize Your Experience",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Help us recommend the perfect destinations and experiences tailored just for you",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Budget & Accommodation
            Text(
              "Budget & Accommodation",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QDropdownField(
              label: "Budget Range per Trip",
              items: budgetRanges,
              value: selectedBudgetRange,
              onChanged: (value, label) {
                selectedBudgetRange = value;
                setState(() {});
              },
            ),

            QDropdownField(
              label: "Preferred Accommodation",
              items: accommodationTypes,
              value: preferredAccommodation,
              onChanged: (value, label) {
                preferredAccommodation = value;
                setState(() {});
              },
            ),

            QDropdownField(
              label: "Travel Style",
              items: travelStyles,
              value: travelStyle,
              onChanged: (value, label) {
                travelStyle = value;
                setState(() {});
              },
            ),

            // Interests
            Text(
              "Travel Interests",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Text(
              "Select your interests (choose multiple)",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: interests.map((interest) {
                bool isSelected = selectedInterests.contains(interest["value"]);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedInterests.remove(interest["value"]);
                    } else {
                      selectedInterests.add(interest["value"]);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.check_circle : Icons.circle_outlined,
                          color: isSelected ? Colors.white : disabledBoldColor,
                          size: 18,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${interest["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Activities
            Text(
              "Preferred Activities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Text(
              "What activities do you enjoy? (choose multiple)",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: activities.map((activity) {
                bool isSelected = selectedActivities.contains(activity["value"]);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedActivities.remove(activity["value"]);
                    } else {
                      selectedActivities.add(activity["value"]);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? successColor : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? successColor : disabledOutlineBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.check_circle : Icons.circle_outlined,
                          color: isSelected ? Colors.white : disabledBoldColor,
                          size: 18,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${activity["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Language & Currency
            Text(
              "App Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QDropdownField(
              label: "Language",
              items: languages,
              value: selectedLanguage,
              onChanged: (value, label) {
                selectedLanguage = value;
                setState(() {});
              },
            ),

            QDropdownField(
              label: "Currency",
              items: currencies,
              value: selectedCurrency,
              onChanged: (value, label) {
                selectedCurrency = value;
                setState(() {});
              },
            ),

            // Privacy & Notifications
            Text(
              "Privacy & Notifications",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QSwitch(
              items: [
                {
                  "label": "Enable push notifications",
                  "value": true,
                  "checked": enableNotifications,
                }
              ],
              value: [
                if (enableNotifications)
                  {
                    "label": "Enable push notifications",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  enableNotifications = values.isNotEmpty;
                });
              },
            ),

            QSwitch(
              items: [
                {
                  "label": "Enable location services",
                  "value": true,
                  "checked": enableLocationServices,
                }
              ],
              value: [
                if (enableLocationServices)
                  {
                    "label": "Enable location services",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  enableLocationServices = values.isNotEmpty;
                });
              },
            ),

            QSwitch(
              items: [
                {
                  "label": "Make my profile discoverable by other travelers",
                  "value": true,
                  "checked": shareProfile,
                }
              ],
              value: [
                if (shareProfile)
                  {
                    "label": "Make my profile discoverable by other travelers",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  shareProfile = values.isNotEmpty;
                });
              },
            ),

            SizedBox(height: spXl),

            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Saving Preferences..." : "Save Preferences",
                size: bs.md,
                onPressed: loading ? null : () async {
                  loading = true;
                  setState(() {});

                  // Simulate saving preferences
                  await Future.delayed(Duration(seconds: 2));

                  loading = false;
                  setState(() {});

                  ss("Preferences saved successfully!");
                  // Navigate to home
                },
              ),
            ),

            // Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "You can change these preferences anytime",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Go to Settings > Travel Preferences to update your choices and discover new experiences.",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
