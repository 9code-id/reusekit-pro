import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaFiltersView extends StatefulWidget {
  const NmaFiltersView({super.key});

  @override
  State<NmaFiltersView> createState() => _NmaFiltersViewState();
}

class _NmaFiltersViewState extends State<NmaFiltersView> {
  String selectedCategory = "all";
  String selectedSource = "all";
  String selectedLanguage = "all";
  String selectedRegion = "all";
  String selectedDateRange = "anytime";
  String selectedSortBy = "newest";
  bool showBreakingNewsOnly = false;
  bool showVerifiedSourcesOnly = true;
  bool showWithImagesOnly = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Breaking News", "value": "breaking"},
    {"label": "Politics", "value": "politics"},
    {"label": "Business", "value": "business"},
    {"label": "Technology", "value": "technology"},
    {"label": "Sports", "value": "sports"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Health", "value": "health"},
    {"label": "Science", "value": "science"},
    {"label": "World News", "value": "world"},
    {"label": "Local News", "value": "local"},
  ];

  List<Map<String, dynamic>> sources = [
    {"label": "All Sources", "value": "all"},
    {"label": "BBC News", "value": "bbc"},
    {"label": "CNN", "value": "cnn"},
    {"label": "Reuters", "value": "reuters"},
    {"label": "Associated Press", "value": "ap"},
    {"label": "The Guardian", "value": "guardian"},
    {"label": "New York Times", "value": "nyt"},
    {"label": "Washington Post", "value": "wapo"},
    {"label": "Bloomberg", "value": "bloomberg"},
    {"label": "Financial Times", "value": "ft"},
  ];

  List<Map<String, dynamic>> languages = [
    {"label": "All Languages", "value": "all"},
    {"label": "English", "value": "en"},
    {"label": "Spanish", "value": "es"},
    {"label": "French", "value": "fr"},
    {"label": "German", "value": "de"},
    {"label": "Italian", "value": "it"},
    {"label": "Portuguese", "value": "pt"},
    {"label": "Russian", "value": "ru"},
    {"label": "Chinese", "value": "zh"},
    {"label": "Japanese", "value": "ja"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "All Regions", "value": "all"},
    {"label": "North America", "value": "na"},
    {"label": "Europe", "value": "eu"},
    {"label": "Asia", "value": "asia"},
    {"label": "Africa", "value": "africa"},
    {"label": "South America", "value": "sa"},
    {"label": "Oceania", "value": "oceania"},
    {"label": "Middle East", "value": "me"},
  ];

  List<Map<String, dynamic>> dateRanges = [
    {"label": "Anytime", "value": "anytime"},
    {"label": "Past Hour", "value": "hour"},
    {"label": "Past 24 Hours", "value": "day"},
    {"label": "Past Week", "value": "week"},
    {"label": "Past Month", "value": "month"},
    {"label": "Past Year", "value": "year"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Most Relevant", "value": "relevance"},
    {"label": "Most Popular", "value": "popular"},
    {"label": "Most Shared", "value": "shared"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          GestureDetector(
            onTap: () {
              _resetAllFilters();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Reset",
                  style: TextStyle(
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
            // Content Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Content Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "News Source",
                    items: sources,
                    value: selectedSource,
                    onChanged: (value, label) {
                      selectedSource = value;
                      setState(() {});
                    },
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
                    label: "Region",
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Time & Sorting Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time & Sorting",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Date Range",
                    items: dateRanges,
                    value: selectedDateRange,
                    onChanged: (value, label) {
                      selectedDateRange = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: selectedSortBy,
                    onChanged: (value, label) {
                      selectedSortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Advanced Options
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Advanced Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Breaking News Only",
                        "value": true,
                        "checked": showBreakingNewsOnly,
                      }
                    ],
                    value: [
                      if (showBreakingNewsOnly)
                        {
                          "label": "Breaking News Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showBreakingNewsOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Verified Sources Only",
                        "value": true,
                        "checked": showVerifiedSourcesOnly,
                      }
                    ],
                    value: [
                      if (showVerifiedSourcesOnly)
                        {
                          "label": "Verified Sources Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showVerifiedSourcesOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Articles with Images Only",
                        "value": true,
                        "checked": showWithImagesOnly,
                      }
                    ],
                    value: [
                      if (showWithImagesOnly)
                        {
                          "label": "Articles with Images Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showWithImagesOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Quick Filter Categories
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QHorizontalScroll(
                    children: [
                      _buildQuickFilterChip("Trending", Icons.trending_up),
                      _buildQuickFilterChip("Local", Icons.location_on),
                      _buildQuickFilterChip("International", Icons.public),
                      _buildQuickFilterChip("Sports", Icons.sports),
                      _buildQuickFilterChip("Tech", Icons.computer),
                      _buildQuickFilterChip("Business", Icons.business),
                    ],
                  ),
                ],
              ),
            ),

            // Apply Filters Button
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
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilterChip(String label, IconData icon) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {
          _applyQuickFilter(label.toLowerCase());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: primaryColor,
              ),
              SizedBox(width: spXs),
              Text(
                label,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetAllFilters() {
    selectedCategory = "all";
    selectedSource = "all";
    selectedLanguage = "all";
    selectedRegion = "all";
    selectedDateRange = "anytime";
    selectedSortBy = "newest";
    showBreakingNewsOnly = false;
    showVerifiedSourcesOnly = true;
    showWithImagesOnly = false;
    setState(() {});
    ss("All filters reset successfully");
  }

  void _applyQuickFilter(String filterType) {
    switch (filterType) {
      case "trending":
        selectedSortBy = "popular";
        selectedDateRange = "day";
        break;
      case "local":
        selectedRegion = "na";
        selectedCategory = "local";
        break;
      case "international":
        selectedCategory = "world";
        break;
      case "sports":
        selectedCategory = "sports";
        break;
      case "tech":
        selectedCategory = "technology";
        break;
      case "business":
        selectedCategory = "business";
        break;
    }
    setState(() {});
    ss("Quick filter '$filterType' applied");
  }

  void _applyFilters() {
    ss("Filters applied successfully");
    back();
  }
}
