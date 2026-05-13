import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaAdvancedSearchView extends StatefulWidget {
  const NmaAdvancedSearchView({super.key});

  @override
  State<NmaAdvancedSearchView> createState() => _NmaAdvancedSearchViewState();
}

class _NmaAdvancedSearchViewState extends State<NmaAdvancedSearchView> {
  String keyword = "";
  String author = "";
  String source = "";
  String category = "all";
  String sortBy = "relevance";
  String dateRange = "anytime";
  String language = "all";
  String region = "all";
  bool excludeDuplicates = true;
  bool onlyWithImages = false;
  bool onlyWithVideos = false;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Politics", "value": "politics"},
    {"label": "Business", "value": "business"},
    {"label": "Technology", "value": "technology"},
    {"label": "Sports", "value": "sports"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Health", "value": "health"},
    {"label": "Science", "value": "science"},
    {"label": "World", "value": "world"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Relevance", "value": "relevance"},
    {"label": "Date (Newest First)", "value": "newest"},
    {"label": "Date (Oldest First)", "value": "oldest"},
    {"label": "Popularity", "value": "popularity"},
  ];

  List<Map<String, dynamic>> dateRangeItems = [
    {"label": "Anytime", "value": "anytime"},
    {"label": "Past Hour", "value": "hour"},
    {"label": "Past 24 Hours", "value": "day"},
    {"label": "Past Week", "value": "week"},
    {"label": "Past Month", "value": "month"},
    {"label": "Past Year", "value": "year"},
  ];

  List<Map<String, dynamic>> languageItems = [
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
    {"label": "Korean", "value": "ko"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "All Regions", "value": "all"},
    {"label": "United States", "value": "us"},
    {"label": "United Kingdom", "value": "uk"},
    {"label": "Canada", "value": "ca"},
    {"label": "Australia", "value": "au"},
    {"label": "Germany", "value": "de"},
    {"label": "France", "value": "fr"},
    {"label": "India", "value": "in"},
    {"label": "China", "value": "cn"},
    {"label": "Japan", "value": "jp"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Search"),
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
            // Search Keywords Section
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
                    "Search Keywords",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Keywords",
                    hint: "Enter search keywords",
                    value: keyword,
                    onChanged: (value) {
                      keyword = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Author",
                    hint: "Filter by author name",
                    value: author,
                    onChanged: (value) {
                      author = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Source",
                    hint: "Filter by news source",
                    value: source,
                    onChanged: (value) {
                      source = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Filters Section
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
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: category,
                    onChanged: (value, label) {
                      category = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Sort By",
                    items: sortItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Date Range",
                    items: dateRangeItems,
                    value: dateRange,
                    onChanged: (value, label) {
                      dateRange = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Language",
                    items: languageItems,
                    value: language,
                    onChanged: (value, label) {
                      language = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Region",
                    items: regionItems,
                    value: region,
                    onChanged: (value, label) {
                      region = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Additional Options Section
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
                    "Additional Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Exclude Duplicates",
                        "value": true,
                        "checked": excludeDuplicates,
                      }
                    ],
                    value: [
                      if (excludeDuplicates)
                        {
                          "label": "Exclude Duplicates",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      excludeDuplicates = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Only Articles with Images",
                        "value": true,
                        "checked": onlyWithImages,
                      }
                    ],
                    value: [
                      if (onlyWithImages)
                        {
                          "label": "Only Articles with Images",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      onlyWithImages = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Only Articles with Videos",
                        "value": true,
                        "checked": onlyWithVideos,
                      }
                    ],
                    value: [
                      if (onlyWithVideos)
                        {
                          "label": "Only Articles with Videos",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      onlyWithVideos = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Search Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Search Articles",
                size: bs.md,
                onPressed: () {
                  _performAdvancedSearch();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetFilters() {
    keyword = "";
    author = "";
    source = "";
    category = "all";
    sortBy = "relevance";
    dateRange = "anytime";
    language = "all";
    region = "all";
    excludeDuplicates = true;
    onlyWithImages = false;
    onlyWithVideos = false;
    setState(() {});
    ss("Filters reset successfully");
  }

  void _performAdvancedSearch() {
    if (keyword.isEmpty) {
      se("Please enter search keywords");
      return;
    }

    // Simulate search
    ss("Searching with advanced filters...");
    // Navigate to search results
    // ss('Next page'));
  }
}
