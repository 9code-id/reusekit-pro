import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPreferencesTrackingView extends StatefulWidget {
  const RfsPreferencesTrackingView({super.key});

  @override
  State<RfsPreferencesTrackingView> createState() => _RfsPreferencesTrackingViewState();
}

class _RfsPreferencesTrackingViewState extends State<RfsPreferencesTrackingView> {
  int currentTab = 0;
  
  // Customer Preferences State
  String searchQuery = "";
  String selectedCategory = "all";
  String sortBy = "name";
  
  // Tracking Settings State
  bool enableAutoTracking = true;
  bool trackDietaryRestrictions = true;
  bool trackSeatingPreferences = true;
  bool trackOrderHistory = true;
  bool sendPersonalizedOffers = true;
  String trackingFrequency = "visit";
  String dataRetention = "2years";
  
  // Insights State
  String insightsTimeframe = "month";
  String selectedInsight = "dietary";
  
  // Privacy State
  bool dataEncryption = true;
  bool anonymizeData = false;
  bool shareWithPartners = false;
  String consentStatus = "required";
  bool gdprCompliance = true;
  
  final List<Map<String, dynamic>> customerPreferences = [
    {
      "customerId": "CUST001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "preferences": {
        "dietary": ["Vegetarian", "Gluten-free"],
        "seating": ["Window table", "Quiet area"],
        "allergies": ["Nuts", "Dairy"],
        "favoriteItems": ["Cappuccino", "Avocado Toast", "Fresh Juice"],
        "avoidItems": ["Spicy food", "Seafood"],
        "temperature": "Warm",
        "musicVolume": "Low",
        "lighting": "Natural light"
      },
      "lastUpdated": "2024-01-15",
      "visits": 45,
      "satisfactionScore": 4.8
    },
    {
      "customerId": "CUST002",
      "name": "Michael Chen",
      "email": "m.chen@email.com",
      "preferences": {
        "dietary": ["Keto", "Low-carb"],
        "seating": ["Bar seating", "Quick service"],
        "allergies": [],
        "favoriteItems": ["Black Coffee", "Caesar Salad", "Grilled Chicken"],
        "avoidItems": ["Bread", "Pasta", "Rice"],
        "temperature": "Cool",
        "musicVolume": "Medium",
        "lighting": "Bright"
      },
      "lastUpdated": "2024-01-14",
      "visits": 28,
      "satisfactionScore": 4.5
    },
    {
      "customerId": "CUST003",
      "name": "Emma Wilson",
      "email": "emma.w@email.com",
      "preferences": {
        "dietary": ["Organic", "Local sourced"],
        "seating": ["Family table", "High chair available"],
        "allergies": ["Shellfish"],
        "favoriteItems": ["Pancakes", "Fresh Juice", "Fruit Bowl"],
        "avoidItems": ["Processed food"],
        "temperature": "Moderate",
        "musicVolume": "Low",
        "lighting": "Soft"
      },
      "lastUpdated": "2024-01-13",
      "visits": 12,
      "satisfactionScore": 4.7
    },
    {
      "customerId": "CUST004",
      "name": "David Rodriguez",
      "email": "d.rodriguez@email.com",
      "preferences": {
        "dietary": ["Regular", "Extra strong coffee"],
        "seating": ["Counter", "Near WiFi"],
        "allergies": [],
        "favoriteItems": ["Espresso", "Croissant", "Dark roast"],
        "avoidItems": ["Decaf", "Sweet drinks"],
        "temperature": "Hot",
        "musicVolume": "Background",
        "lighting": "Any"
      },
      "lastUpdated": "2024-01-16",
      "visits": 67,
      "satisfactionScore": 4.9
    }
  ];
  
  final List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Dietary Restrictions", "value": "dietary"},
    {"label": "Seating Preferences", "value": "seating"},
    {"label": "Food Allergies", "value": "allergies"},
    {"label": "Favorite Items", "value": "favorites"},
    {"label": "Environmental", "value": "environment"}
  ];
  
  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Customer Name", "value": "name"},
    {"label": "Last Updated", "value": "updated"},
    {"label": "Number of Visits", "value": "visits"},
    {"label": "Satisfaction Score", "value": "satisfaction"}
  ];
  
  final List<Map<String, dynamic>> trackingFrequencyOptions = [
    {"label": "Every Visit", "value": "visit"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "On Request", "value": "request"}
  ];
  
  final List<Map<String, dynamic>> retentionOptions = [
    {"label": "1 Year", "value": "1year"},
    {"label": "2 Years", "value": "2years"},
    {"label": "5 Years", "value": "5years"},
    {"label": "Until Deleted", "value": "permanent"}
  ];
  
  final List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"}
  ];
  
  final List<Map<String, dynamic>> insightOptions = [
    {"label": "Dietary Preferences", "value": "dietary"},
    {"label": "Seating Patterns", "value": "seating"},
    {"label": "Popular Items", "value": "items"},
    {"label": "Environment Settings", "value": "environment"},
    {"label": "Satisfaction Trends", "value": "satisfaction"}
  ];
  
  final List<Map<String, dynamic>> consentOptions = [
    {"label": "Required", "value": "required"},
    {"label": "Optional", "value": "optional"},
    {"label": "Implicit", "value": "implicit"}
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    var filtered = customerPreferences.where((customer) {
      bool matchesSearch = searchQuery.isEmpty ||
          (customer["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (customer["email"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" ||
          _hasPreferenceInCategory(customer["preferences"] as Map<String, dynamic>, selectedCategory);
      
      return matchesSearch && matchesCategory;
    }).toList();
    
    // Sort results
    switch (sortBy) {
      case "updated":
        filtered.sort((a, b) => (b["lastUpdated"] as String).compareTo(a["lastUpdated"] as String));
        break;
      case "visits":
        filtered.sort((a, b) => (b["visits"] as int).compareTo(a["visits"] as int));
        break;
      case "satisfaction":
        filtered.sort((a, b) => (b["satisfactionScore"] as double).compareTo(a["satisfactionScore"] as double));
        break;
      default:
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
    }
    
    return filtered;
  }
  
  bool _hasPreferenceInCategory(Map<String, dynamic> preferences, String category) {
    switch (category) {
      case "dietary":
        return (preferences["dietary"] as List).isNotEmpty;
      case "seating":
        return (preferences["seating"] as List).isNotEmpty;
      case "allergies":
        return (preferences["allergies"] as List).isNotEmpty;
      case "favorites":
        return (preferences["favoriteItems"] as List).isNotEmpty;
      case "environment":
        return preferences.containsKey("temperature") || 
               preferences.containsKey("musicVolume") || 
               preferences.containsKey("lighting");
      default:
        return true;
    }
  }

  void _saveTrackingSettings() {
    ss("Preference tracking settings saved successfully");
  }
  
  void _exportPreferences() {
    ss("Customer preferences exported successfully");
  }
  
  void _savePrivacySettings() {
    ss("Privacy settings saved successfully");
  }

  Widget _buildCustomerPreferences() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Search Customers",
                  value: searchQuery,
                  hint: "Name or email",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: QButton(
                    label: "Export Preferences",
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: _exportPreferences,
                  ),
                ),
              ),
            ],
          ),
          
          // Summary Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              {
                "title": "Total Customers",
                "value": "${filteredCustomers.length}",
                "icon": Icons.people,
                "color": primaryColor
              },
              {
                "title": "With Dietary Restrictions",
                "value": "${filteredCustomers.where((c) => (c["preferences"]["dietary"] as List).isNotEmpty).length}",
                "icon": Icons.restaurant_menu,
                "color": successColor
              },
              {
                "title": "With Allergies",
                "value": "${filteredCustomers.where((c) => (c["preferences"]["allergies"] as List).isNotEmpty).length}",
                "icon": Icons.warning,
                "color": dangerColor
              },
              {
                "title": "Avg Satisfaction",
                "value": "${filteredCustomers.isEmpty ? "0.0" : (filteredCustomers.map((c) => c["satisfactionScore"] as double).reduce((a, b) => a + b) / filteredCustomers.length).toStringAsFixed(1)}",
                "icon": Icons.star,
                "color": warningColor
              }
            ].map((stat) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    stat["icon"] as IconData,
                    color: stat["color"] as Color,
                    size: 20,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${stat["value"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${stat["title"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )).toList(),
          ),
          
          // Customer Preferences List
          ...filteredCustomers.map((customer) {
            final preferences = customer["preferences"] as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${customer["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${customer["email"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 10),
                            SizedBox(width: 2),
                            Text(
                              "${customer["satisfactionScore"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Dietary Restrictions
                  if ((preferences["dietary"] as List).isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.restaurant_menu, size: 12, color: successColor),
                              SizedBox(width: spXs),
                              Text(
                                "Dietary Preferences:",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Wrap(
                            spacing: spXs,
                            children: (preferences["dietary"] as List).map((diet) => Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$diet",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: successColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),
                  
                  // Allergies
                  if ((preferences["allergies"] as List).isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.warning, size: 12, color: dangerColor),
                              SizedBox(width: spXs),
                              Text(
                                "Allergies:",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Wrap(
                            spacing: spXs,
                            children: (preferences["allergies"] as List).map((allergy) => Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$allergy",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),
                  
                  // Seating Preferences
                  if ((preferences["seating"] as List).isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.chair, size: 12, color: infoColor),
                          SizedBox(width: spXs),
                          Text(
                            "Seating: ${(preferences["seating"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Favorite Items
                  if ((preferences["favoriteItems"] as List).isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite, size: 12, color: warningColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Favorites: ${(preferences["favoriteItems"] as List).take(3).join(", ")}${(preferences["favoriteItems"] as List).length > 3 ? "..." : ""}",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Customer Stats
                  Row(
                    children: [
                      Icon(Icons.history, size: 12, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${customer["visits"]} visits",
                        style: TextStyle(fontSize: 10, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Text(
                        "Updated: ${customer["lastUpdated"]}",
                        style: TextStyle(fontSize: 10, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTrackingSettings() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Auto Tracking Settings
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
                  "Automatic Preference Tracking",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Enable Auto-tracking",
                  items: [
                    {
                      "label": "Automatically learn customer preferences from orders",
                      "value": true,
                      "checked": enableAutoTracking,
                    }
                  ],
                  value: [if (enableAutoTracking) {"label": "Automatically learn customer preferences from orders", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    enableAutoTracking = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Tracking Frequency",
                  items: trackingFrequencyOptions,
                  value: trackingFrequency,
                  onChanged: (value, label) {
                    trackingFrequency = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Specific Tracking Options
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
                  "Tracking Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Dietary Restrictions & Allergies",
                  items: [
                    {
                      "label": "Track dietary needs, restrictions, and allergies",
                      "value": true,
                      "checked": trackDietaryRestrictions,
                    }
                  ],
                  value: [if (trackDietaryRestrictions) {"label": "Track dietary needs, restrictions, and allergies", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    trackDietaryRestrictions = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Seating Preferences",
                  items: [
                    {
                      "label": "Track preferred seating areas and table types",
                      "value": true,
                      "checked": trackSeatingPreferences,
                    }
                  ],
                  value: [if (trackSeatingPreferences) {"label": "Track preferred seating areas and table types", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    trackSeatingPreferences = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Order History Analysis",
                  items: [
                    {
                      "label": "Analyze order patterns to identify preferences",
                      "value": true,
                      "checked": trackOrderHistory,
                    }
                  ],
                  value: [if (trackOrderHistory) {"label": "Analyze order patterns to identify preferences", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    trackOrderHistory = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Personalization
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
                  "Personalization Features",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Personalized Offers",
                  items: [
                    {
                      "label": "Send personalized offers based on preferences",
                      "value": true,
                      "checked": sendPersonalizedOffers,
                    }
                  ],
                  value: [if (sendPersonalizedOffers) {"label": "Send personalized offers based on preferences", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    sendPersonalizedOffers = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Personalized offers will be generated based on tracked preferences and order history.",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Data Management
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
                  "Data Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QDropdownField(
                  label: "Data Retention Period",
                  items: retentionOptions,
                  value: dataRetention,
                  onChanged: (value, label) {
                    dataRetention = value;
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
                      Icon(Icons.warning, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Preference data older than the retention period will be automatically removed.",
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
            ),
          ),
          
          // Save Settings
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Tracking Settings",
              size: bs.md,
              onPressed: _saveTrackingSettings,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsights() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Insights Controls
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: timeframeOptions,
                  value: insightsTimeframe,
                  onChanged: (value, label) {
                    insightsTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Insight Type",
                  items: insightOptions,
                  value: selectedInsight,
                  onChanged: (value, label) {
                    selectedInsight = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Popular Preferences
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
                  "Popular Dietary Preferences",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...[
                  {"preference": "Vegetarian", "percentage": 35, "count": 438},
                  {"preference": "Gluten-free", "percentage": 28, "count": 350},
                  {"preference": "Vegan", "percentage": 22, "count": 275},
                  {"preference": "Keto/Low-carb", "percentage": 18, "count": 225},
                  {"preference": "Organic", "percentage": 15, "count": 188}
                ].map((pref) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${pref["preference"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${pref["count"]} customers",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (pref["percentage"] as int) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${pref["percentage"]}%",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          
          // Allergy Insights
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
                  "Common Allergies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 100,
                  children: [
                    {"allergy": "Nuts", "count": 156, "color": dangerColor},
                    {"allergy": "Dairy", "count": 134, "color": warningColor},
                    {"allergy": "Shellfish", "count": 89, "color": infoColor},
                    {"allergy": "Gluten", "count": 67, "color": successColor},
                    {"allergy": "Eggs", "count": 45, "color": secondaryColor}
                  ].map((allergy) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (allergy["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: (allergy["color"] as Color).withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning,
                          color: allergy["color"] as Color,
                          size: 16,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${allergy["allergy"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${allergy["count"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: allergy["color"] as Color,
                          ),
                        ),
                        Text(
                          "customers",
                          style: TextStyle(
                            fontSize: 9,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Seating Preferences
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
                  "Seating Preferences",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...[
                  {"seating": "Window tables", "percentage": 42},
                  {"seating": "Quiet area", "percentage": 38},
                  {"seating": "Counter/Bar", "percentage": 25},
                  {"seating": "Outdoor seating", "percentage": 20},
                  {"seating": "Family tables", "percentage": 15}
                ].map((seat) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.chair, color: infoColor, size: 16),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${seat["seating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${seat["percentage"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          
          // Trend Analysis
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
                  "Preference Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: successColor, size: 16),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Growing Trends",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Plant-based options (+25%), Organic ingredients (+18%)",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_down, color: warningColor, size: 16),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Declining Trends",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "High-sodium options (-12%), Large portions (-8%)",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Data Protection
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
                  "Data Protection",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Data Encryption",
                  items: [
                    {
                      "label": "Encrypt all preference data at rest and in transit",
                      "value": true,
                      "checked": dataEncryption,
                    }
                  ],
                  value: [if (dataEncryption) {"label": "Encrypt all preference data at rest and in transit", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    dataEncryption = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Data Anonymization",
                  items: [
                    {
                      "label": "Remove personally identifiable information from analytics",
                      "value": true,
                      "checked": anonymizeData,
                    }
                  ],
                  value: [if (anonymizeData) {"label": "Remove personally identifiable information from analytics", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    anonymizeData = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "GDPR Compliance",
                  items: [
                    {
                      "label": "Enable GDPR compliance features and data rights",
                      "value": true,
                      "checked": gdprCompliance,
                    }
                  ],
                  value: [if (gdprCompliance) {"label": "Enable GDPR compliance features and data rights", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    gdprCompliance = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Consent Management
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
                  "Customer Consent",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QDropdownField(
                  label: "Consent Collection",
                  items: consentOptions,
                  value: consentStatus,
                  onChanged: (value, label) {
                    consentStatus = value;
                    setState(() {});
                  },
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: infoColor, size: 16),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Consent Collection Methods:",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Required: Explicit consent before tracking\n• Optional: Allow opt-in/opt-out choices\n• Implicit: Track with privacy notice",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Data Sharing
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
                  "Data Sharing",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Share with Partners",
                  items: [
                    {
                      "label": "Share anonymized data with marketing partners",
                      "value": true,
                      "checked": shareWithPartners,
                    }
                  ],
                  value: [if (shareWithPartners) {"label": "Share anonymized data with marketing partners", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    shareWithPartners = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                if (shareWithPartners)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Ensure customer consent before sharing any preference data with third parties.",
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
            ),
          ),
          
          // Privacy Statistics
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
                  "Privacy Compliance Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 120,
                  children: [
                    {
                      "title": "Consented Users",
                      "value": "1,156",
                      "percentage": "92%",
                      "icon": Icons.check_circle,
                      "color": successColor
                    },
                    {
                      "title": "Opt-out Requests",
                      "value": "23",
                      "percentage": "2%",
                      "icon": Icons.block,
                      "color": warningColor
                    },
                    {
                      "title": "Data Requests",
                      "value": "8",
                      "percentage": "1%",
                      "icon": Icons.download,
                      "color": infoColor
                    },
                    {
                      "title": "Deletions",
                      "value": "12",
                      "percentage": "1%",
                      "icon": Icons.delete,
                      "color": dangerColor
                    }
                  ].map((stat) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (stat["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 20,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stat["value"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${stat["title"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${stat["percentage"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: stat["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Save Settings
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Privacy Settings",
              size: bs.md,
              onPressed: _savePrivacySettings,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Preferences Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Preferences", icon: Icon(Icons.favorite)),
        Tab(text: "Tracking", icon: Icon(Icons.track_changes)),
        Tab(text: "Insights", icon: Icon(Icons.insights)),
        Tab(text: "Privacy", icon: Icon(Icons.privacy_tip)),
      ],
      tabChildren: [
        _buildCustomerPreferences(),
        _buildTrackingSettings(),
        _buildInsights(),
        _buildPrivacySettings(),
      ],
    );
  }
}
