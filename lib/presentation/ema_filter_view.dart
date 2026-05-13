import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaFilterView extends StatefulWidget {
  const EmaFilterView({super.key});

  @override
  State<EmaFilterView> createState() => _EmaFilterViewState();
}

class _EmaFilterViewState extends State<EmaFilterView> {
  // Filter state
  String selectedCategory = "All";
  String selectedPriceRange = "All";
  String selectedDistance = "All";
  String selectedDateRange = "All";
  String selectedRating = "All";
  String selectedEventType = "All";
  bool onlineEvents = false;
  bool freeEvents = false;
  bool paidEvents = false;
  bool earlyBirdDeals = false;
  bool weekendEvents = false;
  bool eveningEvents = false;
  
  // Filter Options
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Food & Drinks", "value": "Food"},
    {"label": "Business", "value": "Business"},
    {"label": "Arts", "value": "Arts"},
    {"label": "Health", "value": "Health"},
    {"label": "Education", "value": "Education"},
    {"label": "Entertainment", "value": "Entertainment"},
  ];

  List<Map<String, dynamic>> priceRangeOptions = [
    {"label": "Any Price", "value": "All"},
    {"label": "Free", "value": "free"},
    {"label": "Under \$25", "value": "under_25"},
    {"label": "\$25 - \$50", "value": "25_50"},
    {"label": "\$50 - \$100", "value": "50_100"},
    {"label": "\$100 - \$200", "value": "100_200"},
    {"label": "Over \$200", "value": "over_200"},
  ];

  List<Map<String, dynamic>> distanceOptions = [
    {"label": "Any Distance", "value": "All"},
    {"label": "Within 1 km", "value": "1km"},
    {"label": "Within 5 km", "value": "5km"},
    {"label": "Within 10 km", "value": "10km"},
    {"label": "Within 25 km", "value": "25km"},
    {"label": "Within 50 km", "value": "50km"},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Any Date", "value": "All"},
    {"label": "Today", "value": "today"},
    {"label": "Tomorrow", "value": "tomorrow"},
    {"label": "This Week", "value": "this_week"},
    {"label": "This Weekend", "value": "this_weekend"},
    {"label": "Next Week", "value": "next_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Next Month", "value": "next_month"},
  ];

  List<Map<String, dynamic>> ratingOptions = [
    {"label": "Any Rating", "value": "All"},
    {"label": "4.5+ Stars", "value": "4.5"},
    {"label": "4.0+ Stars", "value": "4.0"},
    {"label": "3.5+ Stars", "value": "3.5"},
    {"label": "3.0+ Stars", "value": "3.0"},
  ];

  List<Map<String, dynamic>> eventTypeOptions = [
    {"label": "All Types", "value": "All"},
    {"label": "Conference", "value": "Conference"},
    {"label": "Workshop", "value": "Workshop"},
    {"label": "Meetup", "value": "Meetup"},
    {"label": "Seminar", "value": "Seminar"},
    {"label": "Festival", "value": "Festival"},
    {"label": "Competition", "value": "Competition"},
  ];

  void _resetFilters() {
    selectedCategory = "All";
    selectedPriceRange = "All";
    selectedDistance = "All";
    selectedDateRange = "All";
    selectedRating = "All";
    selectedEventType = "All";
    onlineEvents = false;
    freeEvents = false;
    paidEvents = false;
    earlyBirdDeals = false;
    weekendEvents = false;
    eveningEvents = false;
    setState(() {});
  }

  void _applyFilters() {
    Map<String, dynamic> filters = {
      "category": selectedCategory,
      "priceRange": selectedPriceRange,
      "distance": selectedDistance,
      "dateRange": selectedDateRange,
      "rating": selectedRating,
      "eventType": selectedEventType,
      "onlineEvents": onlineEvents,
      "freeEvents": freeEvents,
      "paidEvents": paidEvents,
      "earlyBirdDeals": earlyBirdDeals,
      "weekendEvents": weekendEvents,
      "eveningEvents": eveningEvents,
    };
    
    ss("Filters applied successfully");
    //navigateTo previous screen with filters
  }

  int get activeFiltersCount {
    int count = 0;
    if (selectedCategory != "All") count++;
    if (selectedPriceRange != "All") count++;
    if (selectedDistance != "All") count++;
    if (selectedDateRange != "All") count++;
    if (selectedRating != "All") count++;
    if (selectedEventType != "All") count++;
    if (onlineEvents) count++;
    if (freeEvents) count++;
    if (paidEvents) count++;
    if (earlyBirdDeals) count++;
    if (weekendEvents) count++;
    if (eveningEvents) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Events"),
        actions: [
          GestureDetector(
            onTap: _resetFilters,
            child: Icon(
              Icons.refresh,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [warningColor, warningColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Filter Events",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Customize your search criteria",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "$activeFiltersCount active filters",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Category Filter
            Text(
              "Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            QCategoryPicker(
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Basic Filters
            Text(
              "Basic Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Price Range",
                          items: priceRangeOptions,
                          value: selectedPriceRange,
                          onChanged: (value, label) {
                            selectedPriceRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Distance",
                          items: distanceOptions,
                          value: selectedDistance,
                          onChanged: (value, label) {
                            selectedDistance = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Date Range",
                          items: dateRangeOptions,
                          value: selectedDateRange,
                          onChanged: (value, label) {
                            selectedDateRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Minimum Rating",
                          items: ratingOptions,
                          value: selectedRating,
                          onChanged: (value, label) {
                            selectedRating = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Event Type",
                    items: eventTypeOptions,
                    value: selectedEventType,
                    onChanged: (value, label) {
                      selectedEventType = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Event Properties
            Text(
              "Event Properties",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Online events",
                        "value": true,
                        "checked": onlineEvents,
                      }
                    ],
                    value: [if (onlineEvents) {"label": "Online events", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      onlineEvents = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Free events",
                              "value": true,
                              "checked": freeEvents,
                            }
                          ],
                          value: [if (freeEvents) {"label": "Free events", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            freeEvents = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Paid events",
                              "value": true,
                              "checked": paidEvents,
                            }
                          ],
                          value: [if (paidEvents) {"label": "Paid events", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            paidEvents = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Early bird deals",
                        "value": true,
                        "checked": earlyBirdDeals,
                      }
                    ],
                    value: [if (earlyBirdDeals) {"label": "Early bird deals", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      earlyBirdDeals = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Time Preferences
            Text(
              "Time Preferences",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Weekend events",
                        "value": true,
                        "checked": weekendEvents,
                      }
                    ],
                    value: [if (weekendEvents) {"label": "Weekend events", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      weekendEvents = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Evening events (after 6 PM)",
                        "value": true,
                        "checked": eveningEvents,
                      }
                    ],
                    value: [if (eveningEvents) {"label": "Evening events (after 6 PM)", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      eveningEvents = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Summary
            if (activeFiltersCount > 0)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "Active Filters ($activeFiltersCount)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Your search will be filtered based on the selected criteria. You can always reset or modify these filters.",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),

            if (activeFiltersCount > 0) SizedBox(height: spLg),

            // Popular Filter Presets
            Text(
              "Quick Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            QHorizontalScroll(
              children: [
                _buildQuickFilterCard("Free Events", Icons.money_off, () {
                  _resetFilters();
                  freeEvents = true;
                  selectedPriceRange = "free";
                  setState(() {});
                }),
                _buildQuickFilterCard("This Weekend", Icons.weekend, () {
                  _resetFilters();
                  weekendEvents = true;
                  selectedDateRange = "this_weekend";
                  setState(() {});
                }),
                _buildQuickFilterCard("Tech Events", Icons.computer, () {
                  _resetFilters();
                  selectedCategory = "Technology";
                  setState(() {});
                }),
                _buildQuickFilterCard("Nearby", Icons.location_on, () {
                  _resetFilters();
                  selectedDistance = "5km";
                  setState(() {});
                }),
                _buildQuickFilterCard("High Rated", Icons.star, () {
                  _resetFilters();
                  selectedRating = "4.5";
                  setState(() {});
                }),
              ],
            ),

            SizedBox(height: spXl),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset All",
                    size: bs.md,
                    onPressed: _resetFilters,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Filters",
                    size: bs.md,
                    onPressed: _applyFilters,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilterCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: primaryColor.withAlpha(100)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                icon,
                color: primaryColor,
                size: 24,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
