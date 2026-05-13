import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaFilterProductsView extends StatefulWidget {
  const SpaFilterProductsView({Key? key}) : super(key: key);

  @override
  State<SpaFilterProductsView> createState() => _SpaFilterProductsViewState();
}

class _SpaFilterProductsViewState extends State<SpaFilterProductsView> {
  String selectedCategory = "All";
  String priceRange = "all";
  String duration = "all";
  double minPrice = 0;
  double maxPrice = 500;
  List<String> selectedServices = [];
  List<String> selectedSpas = [];
  String sortBy = "popularity";
  bool showAvailableOnly = false;
  bool showDiscountedOnly = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All"},
    {"label": "Facial Treatments", "value": "Facial"},
    {"label": "Body Treatments", "value": "Body"},
    {"label": "Massage Therapy", "value": "Massage"},
    {"label": "Skincare", "value": "Skincare"},
    {"label": "Nail Services", "value": "Nails"},
    {"label": "Hair Services", "value": "Hair"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "All Prices", "value": "all"},
    {"label": "Under \$50", "value": "under50"},
    {"label": "\$50 - \$100", "value": "50-100"},
    {"label": "\$100 - \$200", "value": "100-200"},
    {"label": "Over \$200", "value": "over200"},
  ];

  List<Map<String, dynamic>> durationOptions = [
    {"label": "Any Duration", "value": "all"},
    {"label": "30 minutes", "value": "30"},
    {"label": "60 minutes", "value": "60"},
    {"label": "90 minutes", "value": "90"},
    {"label": "120+ minutes", "value": "120"},
  ];

  List<Map<String, dynamic>> serviceTypes = [
    {"label": "Deep Cleansing", "value": "deep_cleansing", "checked": false},
    {"label": "Anti-Aging", "value": "anti_aging", "checked": false},
    {"label": "Hydrating", "value": "hydrating", "checked": false},
    {"label": "Exfoliation", "value": "exfoliation", "checked": false},
    {"label": "Acne Treatment", "value": "acne", "checked": false},
    {"label": "Brightening", "value": "brightening", "checked": false},
  ];

  List<Map<String, dynamic>> spaLocations = [
    {"label": "Luxury Spa & Wellness", "value": "luxury_spa", "checked": false},
    {"label": "Elite Beauty Center", "value": "elite_beauty", "checked": false},
    {"label": "Natural Spa Retreat", "value": "natural_spa", "checked": false},
    {"label": "Premium Skin Clinic", "value": "premium_skin", "checked": false},
    {"label": "Urban Wellness Hub", "value": "urban_wellness", "checked": false},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Popular", "value": "popularity"},
    {"label": "Price: Low to High", "value": "price_asc"},
    {"label": "Price: High to Low", "value": "price_desc"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Newest First", "value": "newest"},
    {"label": "Duration: Short to Long", "value": "duration_asc"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Products"),
        actions: [
          QButton(
            label: "Reset",
            size: bs.sm,
            color: secondaryColor,
            onPressed: () {
              _resetFilters();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Category Filter
                  _buildFilterSection(
                    title: "Category",
                    child: QDropdownField(
                      label: "Select Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),

                  // Price Range
                  _buildFilterSection(
                    title: "Price Range",
                    child: Column(
                      spacing: spSm,
                      children: [
                        QDropdownField(
                          label: "Quick Price Range",
                          items: priceRanges,
                          value: priceRange,
                          onChanged: (value, label) {
                            priceRange = value;
                            _updatePriceFromRange(value);
                            setState(() {});
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QNumberField(
                                label: "Min Price (\$)",
                                value: minPrice.toStringAsFixed(0),
                                onChanged: (value) {
                                  minPrice = double.tryParse(value) ?? 0;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QNumberField(
                                label: "Max Price (\$)",
                                value: maxPrice.toStringAsFixed(0),
                                onChanged: (value) {
                                  maxPrice = double.tryParse(value) ?? 500;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Price range: \$${minPrice.toStringAsFixed(0)} - \$${maxPrice.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Duration Filter
                  _buildFilterSection(
                    title: "Treatment Duration",
                    child: QDropdownField(
                      label: "Select Duration",
                      items: durationOptions,
                      value: duration,
                      onChanged: (value, label) {
                        duration = value;
                        setState(() {});
                      },
                    ),
                  ),

                  // Service Types
                  _buildFilterSection(
                    title: "Service Types",
                    child: Column(
                      spacing: spSm,
                      children: serviceTypes.map((service) {
                        return QSwitch(
                          items: [
                            {
                              "label": service["label"],
                              "value": service["value"],
                              "checked": service["checked"],
                            }
                          ],
                          value: (service["checked"] as bool)
                              ? [
                                  {
                                    "label": service["label"],
                                    "value": service["value"],
                                    "checked": true,
                                  }
                                ]
                              : [],
                          onChanged: (values, ids) {
                            service["checked"] = values.isNotEmpty;
                            if (values.isNotEmpty) {
                              if (!selectedServices.contains(service["value"])) {
                                selectedServices.add(service["value"]);
                              }
                            } else {
                              selectedServices.remove(service["value"]);
                            }
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  // Spa Locations
                  _buildFilterSection(
                    title: "Spa Locations",
                    child: Column(
                      spacing: spSm,
                      children: spaLocations.map((spa) {
                        return QSwitch(
                          items: [
                            {
                              "label": spa["label"],
                              "value": spa["value"],
                              "checked": spa["checked"],
                            }
                          ],
                          value: (spa["checked"] as bool)
                              ? [
                                  {
                                    "label": spa["label"],
                                    "value": spa["value"],
                                    "checked": true,
                                  }
                                ]
                              : [],
                          onChanged: (values, ids) {
                            spa["checked"] = values.isNotEmpty;
                            if (values.isNotEmpty) {
                              if (!selectedSpas.contains(spa["value"])) {
                                selectedSpas.add(spa["value"]);
                              }
                            } else {
                              selectedSpas.remove(spa["value"]);
                            }
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  // Availability & Offers
                  _buildFilterSection(
                    title: "Availability & Offers",
                    child: Column(
                      spacing: spSm,
                      children: [
                        QSwitch(
                          items: [
                            {
                              "label": "Show available appointments only",
                              "value": "available",
                              "checked": showAvailableOnly,
                            }
                          ],
                          value: showAvailableOnly
                              ? [
                                  {
                                    "label": "Show available appointments only",
                                    "value": "available",
                                    "checked": true,
                                  }
                                ]
                              : [],
                          onChanged: (values, ids) {
                            showAvailableOnly = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                        QSwitch(
                          items: [
                            {
                              "label": "Show discounted treatments only",
                              "value": "discounted",
                              "checked": showDiscountedOnly,
                            }
                          ],
                          value: showDiscountedOnly
                              ? [
                                  {
                                    "label": "Show discounted treatments only",
                                    "value": "discounted",
                                    "checked": true,
                                  }
                                ]
                              : [],
                          onChanged: (values, ids) {
                            showDiscountedOnly = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),

                  // Sort Options
                  _buildFilterSection(
                    title: "Sort Results By",
                    child: QDropdownField(
                      label: "Sort by",
                      items: sortOptions,
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                  ),

                  // Filter Summary
                  _buildFilterSummary(),
                ],
              ),
            ),
          ),

          // Bottom Action Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear All Filters",
                    size: bs.md,
                    color: secondaryColor,
                    onPressed: () {
                      _resetFilters();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: "Apply Filters (${_getFilterCount()})",
                    size: bs.md,
                    onPressed: () {
                      _applyFilters();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          child,
        ],
      ),
    );
  }

  Widget _buildFilterSummary() {
    int activeFilters = _getFilterCount();
    
    if (activeFilters == 0) {
      return Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: infoColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "No filters applied - showing all products",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: primaryColor.withAlpha(100),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Active Filters ($activeFilters)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: _buildFilterChips(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips() {
    List<Widget> chips = [];

    if (selectedCategory != "All") {
      chips.add(_buildFilterChip("Category: $selectedCategory", () {
        selectedCategory = "All";
        setState(() {});
      }));
    }

    if (priceRange != "all") {
      chips.add(_buildFilterChip("Price: ${_getPriceRangeLabel()}", () {
        priceRange = "all";
        minPrice = 0;
        maxPrice = 500;
        setState(() {});
      }));
    }

    if (duration != "all") {
      chips.add(_buildFilterChip("Duration: ${_getDurationLabel()}", () {
        duration = "all";
        setState(() {});
      }));
    }

    for (String service in selectedServices) {
      String label = serviceTypes.firstWhere((s) => s["value"] == service)["label"];
      chips.add(_buildFilterChip("Service: $label", () {
        selectedServices.remove(service);
        serviceTypes.firstWhere((s) => s["value"] == service)["checked"] = false;
        setState(() {});
      }));
    }

    for (String spa in selectedSpas) {
      String label = spaLocations.firstWhere((s) => s["value"] == spa)["label"];
      chips.add(_buildFilterChip("Spa: $label", () {
        selectedSpas.remove(spa);
        spaLocations.firstWhere((s) => s["value"] == spa)["checked"] = false;
        setState(() {});
      }));
    }

    if (showAvailableOnly) {
      chips.add(_buildFilterChip("Available Only", () {
        showAvailableOnly = false;
        setState(() {});
      }));
    }

    if (showDiscountedOnly) {
      chips.add(_buildFilterChip("Discounted Only", () {
        showDiscountedOnly = false;
        setState(() {});
      }));
    }

    return chips;
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _updatePriceFromRange(String range) {
    switch (range) {
      case "under50":
        minPrice = 0;
        maxPrice = 50;
        break;
      case "50-100":
        minPrice = 50;
        maxPrice = 100;
        break;
      case "100-200":
        minPrice = 100;
        maxPrice = 200;
        break;
      case "over200":
        minPrice = 200;
        maxPrice = 500;
        break;
      default:
        minPrice = 0;
        maxPrice = 500;
    }
  }

  String _getPriceRangeLabel() {
    switch (priceRange) {
      case "under50":
        return "Under \$50";
      case "50-100":
        return "\$50 - \$100";
      case "100-200":
        return "\$100 - \$200";
      case "over200":
        return "Over \$200";
      default:
        return "All Prices";
    }
  }

  String _getDurationLabel() {
    switch (duration) {
      case "30":
        return "30 minutes";
      case "60":
        return "60 minutes";
      case "90":
        return "90 minutes";
      case "120":
        return "120+ minutes";
      default:
        return "Any Duration";
    }
  }

  int _getFilterCount() {
    int count = 0;
    if (selectedCategory != "All") count++;
    if (priceRange != "all") count++;
    if (duration != "all") count++;
    count += selectedServices.length;
    count += selectedSpas.length;
    if (showAvailableOnly) count++;
    if (showDiscountedOnly) count++;
    return count;
  }

  void _resetFilters() {
    selectedCategory = "All";
    priceRange = "all";
    duration = "all";
    minPrice = 0;
    maxPrice = 500;
    selectedServices.clear();
    selectedSpas.clear();
    sortBy = "popularity";
    showAvailableOnly = false;
    showDiscountedOnly = false;

    for (var service in serviceTypes) {
      service["checked"] = false;
    }
    for (var spa in spaLocations) {
      spa["checked"] = false;
    }

    setState(() {});
  }

  void _applyFilters() {
    // Apply filters logic here
    ss("Filters applied successfully!");
  }
}
