import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsSeatingPreferencesView extends StatefulWidget {
  const RfsSeatingPreferencesView({super.key});

  @override
  State<RfsSeatingPreferencesView> createState() => _RfsSeatingPreferencesViewState();
}

class _RfsSeatingPreferencesViewState extends State<RfsSeatingPreferencesView> {
  String selectedGuestType = "All";
  bool showOnlyActive = true;
  
  String guestName = "";
  String guestPhone = "";
  String selectedPreference = "";
  String specialRequests = "";
  bool isVipGuest = false;

  List<Map<String, dynamic>> guestTypeFilters = [
    {"label": "All Guests", "value": "All"},
    {"label": "VIP Members", "value": "VIP"},
    {"label": "Regular Customers", "value": "Regular"},
    {"label": "First Time Visitors", "value": "New"},
  ];

  List<Map<String, dynamic>> seatingOptions = [
    {"label": "Window Table", "value": "Window"},
    {"label": "Booth Seating", "value": "Booth"},
    {"label": "Bar Counter", "value": "Bar"},
    {"label": "Outdoor Terrace", "value": "Outdoor"},
    {"label": "Private Room", "value": "Private"},
    {"label": "Quiet Area", "value": "Quiet"},
    {"label": "High Top Table", "value": "High Top"},
    {"label": "Corner Table", "value": "Corner"},
  ];

  List<Map<String, dynamic>> preferences = [
    {
      "id": "P001",
      "guestName": "John Smith",
      "phone": "+1 234-567-8901",
      "email": "john.smith@email.com",
      "guestType": "VIP",
      "primaryPreference": "Window",
      "secondaryPreference": "Quiet",
      "specialRequests": "Away from kitchen noise, good lighting for reading",
      "dietaryRestrictions": "No seafood",
      "accessibility": false,
      "temperature": "Cooler area",
      "lastUpdated": "2025-06-15",
      "visitCount": 45,
      "isActive": true,
    },
    {
      "id": "P002",
      "guestName": "Sarah Johnson",
      "phone": "+1 234-567-8902",
      "email": "sarah.j@email.com",
      "guestType": "Regular",
      "primaryPreference": "Booth",
      "secondaryPreference": "Window",
      "specialRequests": "Family-friendly area, high chair access",
      "dietaryRestrictions": "Vegetarian options",
      "accessibility": false,
      "temperature": "Normal",
      "lastUpdated": "2025-06-12",
      "visitCount": 18,
      "isActive": true,
    },
    {
      "id": "P003",
      "guestName": "Michael Davis",
      "phone": "+1 234-567-8903",
      "email": "m.davis@email.com",
      "guestType": "VIP",
      "primaryPreference": "Private",
      "secondaryPreference": "Corner",
      "specialRequests": "Business meetings, quiet atmosphere, good wifi",
      "dietaryRestrictions": null,
      "accessibility": false,
      "temperature": "Cooler area",
      "lastUpdated": "2025-06-18",
      "visitCount": 32,
      "isActive": true,
    },
    {
      "id": "P004",
      "guestName": "Emily Brown",
      "phone": "+1 234-567-8904",
      "email": "emily.brown@email.com",
      "guestType": "New",
      "primaryPreference": "Outdoor",
      "secondaryPreference": "Window",
      "specialRequests": "Pet-friendly area if available",
      "dietaryRestrictions": "Gluten-free",
      "accessibility": false,
      "temperature": "Fresh air preferred",
      "lastUpdated": "2025-06-17",
      "visitCount": 2,
      "isActive": true,
    },
    {
      "id": "P005",
      "guestName": "David Wilson",
      "phone": "+1 234-567-8905",
      "email": "david.w@email.com",
      "guestType": "Regular",
      "primaryPreference": "Bar",
      "secondaryPreference": "High Top",
      "specialRequests": "Close to bar, social atmosphere",
      "dietaryRestrictions": "No nuts",
      "accessibility": true,
      "temperature": "Normal",
      "lastUpdated": "2025-06-10",
      "visitCount": 23,
      "isActive": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPreferences {
    return preferences.where((pref) {
      bool matchesType = selectedGuestType == "All" || pref["guestType"] == selectedGuestType;
      bool matchesActive = !showOnlyActive || pref["isActive"] == true;
      return matchesType && matchesActive;
    }).toList();
  }

  Color _getGuestTypeColor(String type) {
    switch (type) {
      case "VIP":
        return Color(0xFFFFD700);
      case "Regular":
        return successColor;
      case "New":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getPreferenceIcon(String preference) {
    switch (preference) {
      case "Window":
        return Icons.window;
      case "Booth":
        return Icons.chair;
      case "Bar":
        return Icons.local_bar;
      case "Outdoor":
        return Icons.outdoor_grill;
      case "Private":
        return Icons.meeting_room;
      case "Quiet":
        return Icons.volume_off;
      case "High Top":
        return Icons.table_bar;
      case "Corner":
        return Icons.crop_square;
      default:
        return Icons.table_restaurant;
    }
  }

  void _addPreference() async {
    if (guestName.isEmpty || guestPhone.isEmpty || selectedPreference.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    bool isConfirmed = await confirm("Save seating preference for $guestName?");
    if (isConfirmed) {
      setState(() {
        preferences.add({
          "id": "P${(preferences.length + 1).toString().padLeft(3, '0')}",
          "guestName": guestName,
          "phone": guestPhone,
          "email": "",
          "guestType": isVipGuest ? "VIP" : "Regular",
          "primaryPreference": selectedPreference,
          "secondaryPreference": "",
          "specialRequests": specialRequests,
          "dietaryRestrictions": null,
          "accessibility": false,
          "temperature": "Normal",
          "lastUpdated": "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}",
          "visitCount": 1,
          "isActive": true,
        });

        // Reset form
        guestName = "";
        guestPhone = "";
        selectedPreference = "";
        specialRequests = "";
        isVipGuest = false;
      });

      ss("Seating preference saved successfully!");
    }
  }

  void _editPreference(Map<String, dynamic> preference) {
    si("Editing preference for ${preference["guestName"]}");
  }

  void _toggleActiveStatus(Map<String, dynamic> preference) async {
    String action = preference["isActive"] ? "deactivate" : "activate";
    bool isConfirmed = await confirm("${action.capitalize()} preference for ${preference["guestName"]}?");
    if (isConfirmed) {
      setState(() {
        preference["isActive"] = !preference["isActive"];
      });
      ss("Preference ${action}d successfully");
    }
  }

  void _deletePreference(Map<String, dynamic> preference) async {
    bool isConfirmed = await confirm("Delete seating preference for ${preference["guestName"]}? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        preferences.remove(preference);
      });
      ss("Preference deleted successfully");
    }
  }

  void _applyPreference(Map<String, dynamic> preference) {
    si("Applying seating preference for ${preference["guestName"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seating Preferences"),
        actions: [
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              si("Viewing seating analytics");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Preferences", "${preferences.length}", Icons.favorite, primaryColor),
                _buildStatCard("VIP Members", "${preferences.where((p) => p["guestType"] == "VIP").length}", Icons.star, Color(0xFFFFD700)),
                _buildStatCard("Active", "${preferences.where((p) => p["isActive"] == true).length}", Icons.check_circle, successColor),
                _buildStatCard("This Month", "${preferences.where((p) => p["lastUpdated"].startsWith("2025-06")).length}", Icons.calendar_today, infoColor),
              ],
            ),

            // Add New Preference Form
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add_circle, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Add Seating Preference",
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
                          label: "Guest Name*",
                          value: guestName,
                          hint: "Enter guest name",
                          onChanged: (value) {
                            guestName = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Phone Number*",
                          value: guestPhone,
                          hint: "+1 234-567-8900",
                          onChanged: (value) {
                            guestPhone = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QDropdownField(
                    label: "Primary Seating Preference*",
                    items: seatingOptions,
                    value: selectedPreference,
                    onChanged: (value, label) {
                      selectedPreference = value;
                      setState(() {});
                    },
                  ),

                  QMemoField(
                    label: "Special Requests",
                    value: specialRequests,
                    hint: "Any specific seating requirements, accessibility needs, etc.",
                    onChanged: (value) {
                      specialRequests = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "VIP Guest",
                              "value": true,
                              "checked": isVipGuest,
                            }
                          ],
                          value: [
                            if (isVipGuest)
                              {
                                "label": "VIP Guest",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isVipGuest = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Save Preference",
                        onPressed: _addPreference,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Guest Type",
                    items: guestTypeFilters,
                    value: selectedGuestType,
                    onChanged: (value, label) {
                      selectedGuestType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show only active preferences",
                        "value": true,
                        "checked": showOnlyActive,
                      }
                    ],
                    value: [
                      if (showOnlyActive)
                        {
                          "label": "Show only active preferences",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showOnlyActive = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Preferences List
            Text(
              "Seating Preferences (${filteredPreferences.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: filteredPreferences.map((preference) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getGuestTypeColor(preference["guestType"]),
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      // Guest Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getGuestTypeColor(preference["guestType"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${preference["guestType"]}",
                              style: TextStyle(
                                color: preference["guestType"] == "VIP" ? Colors.black : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: preference["isActive"] ? successColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              preference["isActive"] ? "Active" : "Inactive",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Guest Info
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              spacing: spXs,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${preference["guestName"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 14, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${preference["phone"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.api, size: 14, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${preference["visitCount"]} visits",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            spacing: spXs,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Updated",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${preference["lastUpdated"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Seating Preferences
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _getPreferenceIcon(preference["primaryPreference"]),
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Primary: ${preference["primaryPreference"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            if (preference["secondaryPreference"].isNotEmpty)
                              Row(
                                children: [
                                  Icon(
                                    _getPreferenceIcon(preference["secondaryPreference"]),
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Secondary: ${preference["secondaryPreference"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      // Special Requests
                      if (preference["specialRequests"].isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.note, size: 12, color: infoColor),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${preference["specialRequests"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: infoColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Additional Info
                      if (preference["dietaryRestrictions"] != null || preference["accessibility"] == true) ...[
                        Row(
                          children: [
                            if (preference["dietaryRestrictions"] != null) ...[
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.restaurant, size: 12, color: warningColor),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        "Dietary: ${preference["dietaryRestrictions"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: warningColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            if (preference["accessibility"] == true) ...[
                              Row(
                                children: [
                                  Icon(Icons.accessible, size: 12, color: infoColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "Accessibility",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ],

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Apply Now",
                              size: bs.sm,
                              onPressed: () => _applyPreference(preference),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: preference["isActive"] ? "Deactivate" : "Activate",
                              size: bs.sm,
                              onPressed: () => _toggleActiveStatus(preference),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () => _editPreference(preference),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.delete,
                            size: bs.sm,
                            onPressed: () => _deletePreference(preference),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
