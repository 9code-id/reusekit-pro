import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPreferencesView extends StatefulWidget {
  const RmaPreferencesView({Key? key}) : super(key: key);

  @override
  State<RmaPreferencesView> createState() => _RmaPreferencesViewState();
}

class _RmaPreferencesViewState extends State<RmaPreferencesView> {
  // Search Preferences
  String preferredLocation = "All";
  String preferredPropertyType = "All";
  String minPrice = "500000";
  String maxPrice = "5000000";
  int minBedrooms = 2;
  int maxBedrooms = 6;
  bool includeCondos = true;
  bool includeHouses = true;
  bool includeApartments = true;
  bool includeLuxury = false;

  // Display Preferences
  String currency = "USD";
  String measurementUnit = "sqft";
  String dateFormat = "MM/dd/yyyy";
  String timeFormat = "12hour";
  bool showMapView = true;
  bool showListView = true;
  bool showPriceHistory = true;
  String defaultSortBy = "price_low";

  // Investment Preferences
  double targetCapRate = 7.0;
  double targetROI = 12.0;
  bool focusOnAppreciation = true;
  bool focusOnCashFlow = true;
  bool considerTaxBenefits = true;
  String investmentStrategy = "buy_hold";

  // Notification Preferences
  bool priceAlerts = true;
  bool marketUpdates = false;
  bool investmentOpportunities = true;
  String alertFrequency = "daily";

  // Privacy Preferences
  bool shareSearchHistory = false;
  bool allowAnalytics = true;
  bool personalizedRecommendations = true;
  bool marketingEmails = false;

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": "All"},
    {"label": "New York", "value": "new_york"},
    {"label": "Los Angeles", "value": "los_angeles"},  
    {"label": "Chicago", "value": "chicago"},
    {"label": "Miami", "value": "miami"},
    {"label": "San Francisco", "value": "san_francisco"},
  ];

  List<Map<String, dynamic>> propertyTypeOptions = [
    {"label": "All Types", "value": "All"},
    {"label": "Single Family", "value": "single_family"},
    {"label": "Multi-Family", "value": "multi_family"},
    {"label": "Condo", "value": "condo"},
    {"label": "Townhouse", "value": "townhouse"},
    {"label": "Commercial", "value": "commercial"},
  ];

  List<Map<String, dynamic>> currencyOptions = [
    {"label": "US Dollar (\$)", "value": "USD"},
    {"label": "Euro (€)", "value": "EUR"},
    {"label": "British Pound (£)", "value": "GBP"},
    {"label": "Canadian Dollar (C\$)", "value": "CAD"},
  ];

  List<Map<String, dynamic>> measurementOptions = [
    {"label": "Square Feet (sqft)", "value": "sqft"},
    {"label": "Square Meters (m²)", "value": "sqm"},
  ];

  List<Map<String, dynamic>> investmentStrategyOptions = [
    {"label": "Buy & Hold", "value": "buy_hold"},
    {"label": "Fix & Flip", "value": "fix_flip"},
    {"label": "BRRRR", "value": "brrrr"},
    {"label": "Wholesale", "value": "wholesale"},
    {"label": "Commercial", "value": "commercial"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferences"),
        actions: [
          QButton(
            icon: Icons.restore,
            size: bs.sm,
            onPressed: () => _resetToDefaults(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Preferences
            _buildSectionHeader("Search Preferences", Icons.search),
            _buildSearchPreferences(),

            // Display Preferences
            _buildSectionHeader("Display Preferences", Icons.display_settings),
            _buildDisplayPreferences(),

            // Investment Preferences
            _buildSectionHeader("Investment Preferences", Icons.trending_up),
            _buildInvestmentPreferences(),

            // Alert Preferences
            _buildSectionHeader("Alert Preferences", Icons.notifications),
            _buildAlertPreferences(),

            // Privacy Preferences
            _buildSectionHeader("Privacy Preferences", Icons.privacy_tip),
            _buildPrivacyPreferences(),

            // Save Settings
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Preferences",
                    onPressed: () => _savePreferences(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
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
    );
  }

  Widget _buildSearchPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          // Location and Property Type
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Preferred Location",
                  items: locationOptions,
                  value: preferredLocation,
                  onChanged: (value, label) {
                    preferredLocation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Property Type",
                  items: propertyTypeOptions,
                  value: preferredPropertyType,
                  onChanged: (value, label) {
                    preferredPropertyType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Price Range
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Min Price (\$)",
                  value: minPrice,
                  onChanged: (value) {
                    minPrice = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Max Price (\$)",
                  value: maxPrice,
                  onChanged: (value) {
                    maxPrice = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Bedroom Range
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bedroom Range: $minBedrooms - $maxBedrooms",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text("Min:", style: TextStyle(fontSize: 12)),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Slider(
                        value: minBedrooms.toDouble(),
                        min: 1,
                        max: 8,
                        divisions: 7,
                        onChanged: (value) {
                          minBedrooms = value.round();
                          if (minBedrooms > maxBedrooms) {
                            maxBedrooms = minBedrooms;
                          }
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ),
                    Text("Max:", style: TextStyle(fontSize: 12)),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Slider(
                        value: maxBedrooms.toDouble(),
                        min: 1,
                        max: 8,
                        divisions: 7,
                        onChanged: (value) {
                          maxBedrooms = value.round();
                          if (maxBedrooms < minBedrooms) {
                            minBedrooms = maxBedrooms;
                          }
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Property Type Filters
          Text(
            "Include Property Types:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spXs,
            children: [
              _buildPreferenceRow("Condominiums", includeCondos, (value) {
                includeCondos = value;
                setState(() {});
              }),
              _buildPreferenceRow("Houses", includeHouses, (value) {
                includeHouses = value;
                setState(() {});
              }),
              _buildPreferenceRow("Apartments", includeApartments, (value) {
                includeApartments = value;
                setState(() {});
              }),
              _buildPreferenceRow("Luxury Properties", includeLuxury, (value) {
                includeLuxury = value;
                setState(() {});
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          // Currency and Measurement
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Currency",
                  items: currencyOptions,
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
                  label: "Measurement Unit",
                  items: measurementOptions,
                  value: measurementUnit,
                  onChanged: (value, label) {
                    measurementUnit = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Format Settings
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Date Format",
                  value: dateFormat,
                  hint: "MM/dd/yyyy",
                  onChanged: (value) {
                    dateFormat = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Format",
                  items: [
                    {"label": "12 Hour", "value": "12hour"},
                    {"label": "24 Hour", "value": "24hour"},
                  ],
                  value: timeFormat,
                  onChanged: (value, label) {
                    timeFormat = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // View Preferences
          Text(
            "Default Views:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spXs,
            children: [
              _buildPreferenceRow("Show Map View", showMapView, (value) {
                showMapView = value;
                setState(() {});
              }),
              _buildPreferenceRow("Show List View", showListView, (value) {
                showListView = value;
                setState(() {});
              }),
              _buildPreferenceRow("Show Price History", showPriceHistory, (value) {
                showPriceHistory = value;
                setState(() {});
              }),
            ],
          ),

          // Default Sort
          QDropdownField(
            label: "Default Sort Order",
            items: [
              {"label": "Price: Low to High", "value": "price_low"},
              {"label": "Price: High to Low", "value": "price_high"},
              {"label": "Newest First", "value": "newest"},
              {"label": "Best Match", "value": "relevance"},
            ],
            value: defaultSortBy,
            onChanged: (value, label) {
              defaultSortBy = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          // Target Metrics
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Target Cap Rate: ${targetCapRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Slider(
                      value: targetCapRate,
                      min: 1.0,
                      max: 15.0,
                      divisions: 140,
                      onChanged: (value) {
                        targetCapRate = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Target ROI: ${targetROI.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Slider(
                      value: targetROI,
                      min: 5.0,
                      max: 30.0,
                      divisions: 250,
                      onChanged: (value) {
                        targetROI = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Investment Strategy
          QDropdownField(
            label: "Investment Strategy",
            items: investmentStrategyOptions,
            value: investmentStrategy,
            onChanged: (value, label) {
              investmentStrategy = value;
              setState(() {});
            },
          ),

          // Investment Focus
          Text(
            "Investment Focus:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spXs,
            children: [
              _buildPreferenceRow("Focus on Appreciation", focusOnAppreciation, (value) {
                focusOnAppreciation = value;
                setState(() {});
              }),
              _buildPreferenceRow("Focus on Cash Flow", focusOnCashFlow, (value) {
                focusOnCashFlow = value;
                setState(() {});
              }),
              _buildPreferenceRow("Consider Tax Benefits", considerTaxBenefits, (value) {
                considerTaxBenefits = value;
                setState(() {});
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          // Alert Types
          Column(
            spacing: spXs,
            children: [
              _buildPreferenceRow("Price Alerts", priceAlerts, (value) {
                priceAlerts = value;
                setState(() {});
              }),
              _buildPreferenceRow("Market Updates", marketUpdates, (value) {
                marketUpdates = value;
                setState(() {});
              }),
              _buildPreferenceRow("Investment Opportunities", investmentOpportunities, (value) {
                investmentOpportunities = value;
                setState(() {});
              }),
            ],
          ),

          // Alert Frequency
          QDropdownField(
            label: "Alert Frequency",
            items: [
              {"label": "Immediate", "value": "immediate"},
              {"label": "Daily", "value": "daily"},
              {"label": "Weekly", "value": "weekly"},
              {"label": "Monthly", "value": "monthly"},
            ],
            value: alertFrequency,
            onChanged: (value, label) {
              alertFrequency = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          _buildPreferenceRow("Share Search History", shareSearchHistory, (value) {
            shareSearchHistory = value;
            setState(() {});
          }),
          _buildPreferenceRow("Allow Analytics", allowAnalytics, (value) {
            allowAnalytics = value;
            setState(() {});
          }),
          _buildPreferenceRow("Personalized Recommendations", personalizedRecommendations, (value) {
            personalizedRecommendations = value;
            setState(() {});
          }),
          _buildPreferenceRow("Marketing Emails", marketingEmails, (value) {
            marketingEmails = value;
            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget _buildPreferenceRow(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: primaryColor,
        ),
      ],
    );
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all preferences to default values?");
    if (isConfirmed) {
      // Search Preferences
      preferredLocation = "All";
      preferredPropertyType = "All";
      minPrice = "500000";
      maxPrice = "5000000";
      minBedrooms = 2;
      maxBedrooms = 6;
      includeCondos = true;
      includeHouses = true;
      includeApartments = true;
      includeLuxury = false;

      // Display Preferences
      currency = "USD";
      measurementUnit = "sqft";
      dateFormat = "MM/dd/yyyy";
      timeFormat = "12hour";
      showMapView = true;
      showListView = true;
      showPriceHistory = true;
      defaultSortBy = "price_low";

      // Investment Preferences
      targetCapRate = 7.0;
      targetROI = 12.0;
      focusOnAppreciation = true;
      focusOnCashFlow = true;
      considerTaxBenefits = true;
      investmentStrategy = "buy_hold";

      // Alert Preferences
      priceAlerts = true;
      marketUpdates = false;
      investmentOpportunities = true;
      alertFrequency = "daily";

      // Privacy Preferences
      shareSearchHistory = false;
      allowAnalytics = true;
      personalizedRecommendations = true;
      marketingEmails = false;

      setState(() {});
      ss("Preferences reset to defaults");
    }
  }

  void _savePreferences() {
    // Validate preferences
    if (double.tryParse(minPrice) == null || double.tryParse(maxPrice) == null) {
      se("Please enter valid price values");
      return;
    }

    if ((double.tryParse(minPrice) ?? 0) >= (double.tryParse(maxPrice) ?? 0)) {
      se("Maximum price must be greater than minimum price");
      return;
    }

    if (!includeCondos && !includeHouses && !includeApartments && !includeLuxury) {
      se("Please select at least one property type");
      return;
    }

    // Save preferences (in a real app, this would save to database/API)
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Preferences saved successfully");
    });
  }
}
