import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSortOptionsView extends StatefulWidget {
  const NmaSortOptionsView({super.key});

  @override
  State<NmaSortOptionsView> createState() => _NmaSortOptionsViewState();
}

class _NmaSortOptionsViewState extends State<NmaSortOptionsView> {
  String selectedSort = "newest";
  
  List<Map<String, dynamic>> sortOptions = [
    {
      "id": "newest",
      "title": "Newest First",
      "description": "Show the most recent articles first",
      "icon": Icons.schedule,
    },
    {
      "id": "oldest",
      "title": "Oldest First", 
      "description": "Show older articles first",
      "icon": Icons.history,
    },
    {
      "id": "relevance",
      "title": "Most Relevant",
      "description": "Show articles most relevant to your search",
      "icon": Icons.search,
    },
    {
      "id": "popularity",
      "title": "Most Popular",
      "description": "Show articles with the most views and engagement",
      "icon": Icons.trending_up,
    },
    {
      "id": "rating",
      "title": "Highest Rated",
      "description": "Show articles with highest reader ratings",
      "icon": Icons.star,
    },
    {
      "id": "shared",
      "title": "Most Shared",
      "description": "Show articles that have been shared the most",
      "icon": Icons.share,
    },
    {
      "id": "commented",
      "title": "Most Commented",
      "description": "Show articles with the most reader comments",
      "icon": Icons.comment,
    },
    {
      "id": "alphabetical",
      "title": "Alphabetical (A-Z)",
      "description": "Sort articles by title alphabetically",
      "icon": Icons.sort_by_alpha,
    },
    {
      "id": "source",
      "title": "By Source",
      "description": "Group articles by news source",
      "icon": Icons.source,
    },
    {
      "id": "category",
      "title": "By Category",
      "description": "Group articles by category",
      "icon": Icons.category,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort Options"),
        actions: [
          GestureDetector(
            onTap: () {
              _applySortOption();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Apply",
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
            // Current Sort Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Sort",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _getCurrentSortTitle(),
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Sort Options List
            Text(
              "Choose Sort Option",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...sortOptions.map((option) => _buildSortOptionItem(option)),

            // Quick Sort Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reset to Default",
                          size: bs.sm,
                          onPressed: () {
                            _resetToDefault();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Random Order",
                          size: bs.sm,
                          onPressed: () {
                            _randomSort();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOptionItem(Map<String, dynamic> option) {
    bool isSelected = selectedSort == option["id"];
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: () {
          selectedSort = option["id"];
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: isSelected ? primaryColor : disabledOutlineBorderColor,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  option["icon"] as IconData,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${option["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? primaryColor : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${option["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: primaryColor,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCurrentSortTitle() {
    Map<String, dynamic>? currentOption = sortOptions.firstWhere(
      (option) => option["id"] == selectedSort,
      orElse: () => sortOptions[0],
    );
    return "${currentOption["title"]}";
  }

  void _applySortOption() {
    String sortTitle = _getCurrentSortTitle();
    ss("Sort option '$sortTitle' applied successfully");
    back();
  }

  void _resetToDefault() {
    selectedSort = "newest";
    setState(() {});
    ss("Sort option reset to default (Newest First)");
  }

  void _randomSort() {
    selectedSort = "random";
    setState(() {});
    ss("Articles will be displayed in random order");
  }
}
