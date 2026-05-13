import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaAdvancedSearchView extends StatefulWidget {
  const EmaAdvancedSearchView({super.key});

  @override
  State<EmaAdvancedSearchView> createState() => _EmaAdvancedSearchViewState();
}

class _EmaAdvancedSearchViewState extends State<EmaAdvancedSearchView> {
  String keywords = "";
  String eventTitle = "";
  String organizer = "";
  String location = "";
  String selectedCategory = "All";
  String selectedPriceRange = "All";
  String selectedDateRange = "All";
  String selectedRating = "All";
  bool onlineOnly = false;
  bool freeOnly = false;
  bool earlyBirdOnly = false;
  bool withReminders = false;
  
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

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Any Date", "value": "All"},
    {"label": "Today", "value": "today"},
    {"label": "Tomorrow", "value": "tomorrow"},
    {"label": "This Week", "value": "this_week"},
    {"label": "This Weekend", "value": "this_weekend"},
    {"label": "Next Week", "value": "next_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Next Month", "value": "next_month"},
    {"label": "Next 3 Months", "value": "next_3_months"},
  ];

  List<Map<String, dynamic>> ratingOptions = [
    {"label": "Any Rating", "value": "All"},
    {"label": "4.5+ Stars", "value": "4.5"},
    {"label": "4.0+ Stars", "value": "4.0"},
    {"label": "3.5+ Stars", "value": "3.5"},
    {"label": "3.0+ Stars", "value": "3.0"},
  ];

  void _clearAllFilters() {
    keywords = "";
    eventTitle = "";
    organizer = "";
    location = "";
    selectedCategory = "All";
    selectedPriceRange = "All";
    selectedDateRange = "All";
    selectedRating = "All";
    onlineOnly = false;
    freeOnly = false;
    earlyBirdOnly = false;
    withReminders = false;
    setState(() {});
  }

  void _searchEvents() {
    // Collect all search criteria
    Map<String, dynamic> searchCriteria = {
      "keywords": keywords,
      "eventTitle": eventTitle,
      "organizer": organizer,
      "location": location,
      "category": selectedCategory,
      "priceRange": selectedPriceRange,
      "dateRange": selectedDateRange,
      "rating": selectedRating,
      "onlineOnly": onlineOnly,
      "freeOnly": freeOnly,
      "earlyBirdOnly": earlyBirdOnly,
      "withReminders": withReminders,
    };
    
    ss("Searching with advanced criteria");
    //navigateTo search results view with criteria
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Search"),
        actions: [
          GestureDetector(
            onTap: _clearAllFilters,
            child: Icon(
              Icons.clear_all,
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
                  colors: [successColor, successColor.withAlpha(180)],
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
                        Icons.search,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Advanced Search",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Find exactly what you're looking for",
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
                  Text(
                    "Use multiple criteria to narrow down your search and discover the perfect events.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Basic Search Fields
            Text(
              "Basic Information",
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
                  QTextField(
                    label: "Keywords",
                    value: keywords,
                    hint: "e.g., tech, programming, conference",
                    onChanged: (value) {
                      keywords = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Event Title",
                    value: eventTitle,
                    hint: "Search by specific event name",
                    onChanged: (value) {
                      eventTitle = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Organizer",
                    value: organizer,
                    hint: "Search by organizer name",
                    onChanged: (value) {
                      organizer = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Location",
                    value: location,
                    hint: "City, venue, or address",
                    onChanged: (value) {
                      location = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Category and Filters
            Text(
              "Categories & Filters",
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
                          label: "Category",
                          items: categoryOptions,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
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
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Special Options
            Text(
              "Special Options",
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
                        "label": "Online events only",
                        "value": true,
                        "checked": onlineOnly,
                      }
                    ],
                    value: [if (onlineOnly) {"label": "Online events only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      onlineOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Free events only",
                        "value": true,
                        "checked": freeOnly,
                      }
                    ],
                    value: [if (freeOnly) {"label": "Free events only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      freeOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Early bird discounts only",
                        "value": true,
                        "checked": earlyBirdOnly,
                      }
                    ],
                    value: [if (earlyBirdOnly) {"label": "Early bird discounts only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      earlyBirdOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Events with reminders",
                        "value": true,
                        "checked": withReminders,
                      }
                    ],
                    value: [if (withReminders) {"label": "Events with reminders", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      withReminders = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Search Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Search Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• Use specific keywords for better results",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "• Combine multiple filters to narrow down results",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "• Leave fields empty to search all options",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spXl),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear All",
                    size: bs.md,
                    onPressed: _clearAllFilters,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Search Events",
                    size: bs.md,
                    onPressed: _searchEvents,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
