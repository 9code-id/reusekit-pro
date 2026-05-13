import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter8View extends StatefulWidget {
  @override
  State<GrlFilter8View> createState() => _GrlFilter8ViewState();
}

class _GrlFilter8ViewState extends State<GrlFilter8View> {
  String selectedLocation = "";
  String selectedEventType = "";
  String selectedCategory = "";
  String selectedPriceRange = "";
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? timeEnd;
  List<String> selectedAgeGroups = [];
  List<String> selectedInterests = [];
  String selectedVenue = "";
  bool freeEvents = false;
  bool familyFriendly = false;
  bool accessibleVenue = false;
  bool onlineEvent = false;
  double maxDistance = 25;

  List<Map<String, dynamic>> locationItems = [
    {"label": "Any Location", "value": ""},
    {"label": "New York, NY", "value": "new_york"},
    {"label": "Los Angeles, CA", "value": "los_angeles"},
    {"label": "Chicago, IL", "value": "chicago"},
    {"label": "Houston, TX", "value": "houston"},
    {"label": "Miami, FL", "value": "miami"},
    {"label": "San Francisco, CA", "value": "san_francisco"},
    {"label": "Boston, MA", "value": "boston"},
  ];

  List<Map<String, dynamic>> eventTypeItems = [
    {"label": "All Event Types", "value": ""},
    {"label": "Conference", "value": "conference"},
    {"label": "Workshop", "value": "workshop"},
    {"label": "Concert", "value": "concert"},
    {"label": "Festival", "value": "festival"},
    {"label": "Networking", "value": "networking"},
    {"label": "Exhibition", "value": "exhibition"},
    {"label": "Sports", "value": "sports"},
    {"label": "Theater", "value": "theater"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": ""},
    {"label": "Business", "value": "business"},
    {"label": "Technology", "value": "technology"},
    {"label": "Arts & Culture", "value": "arts_culture"},
    {"label": "Food & Drink", "value": "food_drink"},
    {"label": "Health & Wellness", "value": "health_wellness"},
    {"label": "Music", "value": "music"},
    {"label": "Sports & Fitness", "value": "sports_fitness"},
    {"label": "Education", "value": "education"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "Any Price", "value": ""},
    {"label": "Free", "value": "free"},
    {"label": "Under \$25", "value": "under_25"},
    {"label": "\$25 - \$50", "value": "25_50"},
    {"label": "\$50 - \$100", "value": "50_100"},
    {"label": "Over \$100", "value": "over_100"},
  ];

  List<Map<String, dynamic>> venueItems = [
    {"label": "Any Venue", "value": ""},
    {"label": "Convention Center", "value": "convention_center"},
    {"label": "Hotel", "value": "hotel"},
    {"label": "Restaurant", "value": "restaurant"},
    {"label": "Park", "value": "park"},
    {"label": "Theater", "value": "theater"},
    {"label": "Museum", "value": "museum"},
    {"label": "Stadium", "value": "stadium"},
    {"label": "Online", "value": "online"},
  ];

  List<String> ageGroupsList = [
    "Children (0-12)",
    "Teens (13-17)",
    "Young Adults (18-25)",
    "Adults (26-40)",
    "Middle Age (41-55)",
    "Seniors (55+)",
    "All Ages",
  ];

  List<String> interestsList = [
    "Networking",
    "Learning",
    "Entertainment",
    "Socializing",
    "Career Development",
    "Art & Culture",
    "Technology",
    "Health & Fitness",
    "Food & Cooking",
    "Travel",
    "Music",
    "Photography",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Filters"),
        actions: [
          GestureDetector(
            onTap: () {
              _resetFilters();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
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
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location
            Text(
              "Location",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Location",
              items: locationItems,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),

            // Distance
            if (selectedLocation.isNotEmpty) ...[
              Text(
                "Distance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Within ${maxDistance.toInt()} miles",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${maxDistance.toInt()} mi",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: maxDistance,
                      min: 1,
                      max: 100,
                      divisions: 99,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        maxDistance = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Event Type and Category
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Type",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Type",
                        items: eventTypeItems,
                        value: selectedEventType,
                        onChanged: (value, label) {
                          selectedEventType = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Category",
                        items: categoryItems,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Date Range
            Text(
              "Date Range",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDatePicker(
                          label: "Start Date",
                          value: startDate ?? DateTime.now(),
                          onChanged: (value) {
                            startDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDatePicker(
                          label: "End Date",
                          value: endDate ?? DateTime.now().add(Duration(days: 30)),
                          onChanged: (value) {
                            endDate = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Time Range
            Text(
              "Time Range",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QTimePicker(
                      label: "Start Time",
                      value: startTime ?? TimeOfDay(hour: 9, minute: 0),
                      onChanged: (value) {
                        startTime = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTimePicker(
                      label: "End Time",
                      value: timeEnd ?? TimeOfDay(hour: 17, minute: 0),
                      onChanged: (value) {
                        timeEnd = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Price Range and Venue
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price Range",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Price",
                        items: priceRangeItems,
                        value: selectedPriceRange,
                        onChanged: (value, label) {
                          selectedPriceRange = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Venue Type",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Venue",
                        items: venueItems,
                        value: selectedVenue,
                        onChanged: (value, label) {
                          selectedVenue = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Age Groups
            Text(
              "Age Groups",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
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
                  Text(
                    "Select suitable age groups:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: ageGroupsList.map((ageGroup) {
                      bool isSelected = selectedAgeGroups.contains(ageGroup);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedAgeGroups.remove(ageGroup);
                          } else {
                            selectedAgeGroups.add(ageGroup);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            ageGroup,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Interests
            Text(
              "Interests",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
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
                  Text(
                    "Select your interests:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: interestsList.map((interest) {
                      bool isSelected = selectedInterests.contains(interest);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedInterests.remove(interest);
                          } else {
                            selectedInterests.add(interest);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? successColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? successColor : Colors.grey.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            interest,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Special Features
            Text(
              "Special Features",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Free Events Only",
                        "value": true,
                        "checked": freeEvents,
                      }
                    ],
                    value: [
                      if (freeEvents)
                        {"label": "Free Events Only", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      freeEvents = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Family Friendly",
                        "value": true,
                        "checked": familyFriendly,
                      }
                    ],
                    value: [
                      if (familyFriendly)
                        {"label": "Family Friendly", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      familyFriendly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Accessible Venue",
                        "value": true,
                        "checked": accessibleVenue,
                      }
                    ],
                    value: [
                      if (accessibleVenue)
                        {"label": "Accessible Venue", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      accessibleVenue = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Online Event",
                        "value": true,
                        "checked": onlineEvent,
                      }
                    ],
                    value: [
                      if (onlineEvent)
                        {"label": "Online Event", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      onlineEvent = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Apply Filter Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  _applyFilters();
                },
              ),
            ),

            SizedBox(height: spSm),

            // Clear Filters Button
            Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _resetFilters();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Center(
                    child: Text(
                      "Clear All Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    Map<String, dynamic> filters = {
      'location': selectedLocation,
      'maxDistance': maxDistance,
      'eventType': selectedEventType,
      'category': selectedCategory,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'startTime': startTime?.kkmm,
      'endTime': timeEnd?.kkmm,
      'priceRange': selectedPriceRange,
      'venue': selectedVenue,
      'ageGroups': selectedAgeGroups,
      'interests': selectedInterests,
      'freeEvents': freeEvents,
      'familyFriendly': familyFriendly,
      'accessibleVenue': accessibleVenue,
      'onlineEvent': onlineEvent,
    };

    ss("Event filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedLocation = "";
    selectedEventType = "";
    selectedCategory = "";
    selectedPriceRange = "";
    selectedVenue = "";
    selectedAgeGroups.clear();
    selectedInterests.clear();
    startDate = null;
    endDate = null;
    startTime = null;
    timeEnd = null;
    freeEvents = false;
    familyFriendly = false;
    accessibleVenue = false;
    onlineEvent = false;
    maxDistance = 25;
    setState(() {});
  }
}
