import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaFiltersView extends StatefulWidget {
  const PpaFiltersView({super.key});

  @override
  State<PpaFiltersView> createState() => _PpaFiltersViewState();
}

class _PpaFiltersViewState extends State<PpaFiltersView> {
  String selectedCategory = "All";
  String selectedFilter = "";
  double filterIntensity = 100.0;
  bool beforeAfterMode = false;

  List<Map<String, dynamic>> filterCategories = [
    {"label": "All", "value": "All"},
    {"label": "Artistic", "value": "Artistic"},
    {"label": "Vintage", "value": "Vintage"},
    {"label": "Cinematic", "value": "Cinematic"},
    {"label": "Black & White", "value": "BW"},
    {"label": "Color Pop", "value": "ColorPop"},
  ];

  List<Map<String, dynamic>> allFilters = [
    {
      "name": "Natural",
      "category": "All",
      "description": "Enhance natural colors",
      "thumbnail": "https://picsum.photos/80/80?random=1",
      "color": Colors.green,
    },
    {
      "name": "Dramatic",
      "category": "Artistic",
      "description": "High contrast dramatic look",
      "thumbnail": "https://picsum.photos/80/80?random=2",
      "color": Colors.red,
    },
    {
      "name": "Vintage Film",
      "category": "Vintage",
      "description": "Classic film photography",
      "thumbnail": "https://picsum.photos/80/80?random=3",
      "color": Colors.brown,
    },
    {
      "name": "Cinema",
      "category": "Cinematic",
      "description": "Professional movie look",
      "thumbnail": "https://picsum.photos/80/80?random=4",
      "color": Colors.purple,
    },
    {
      "name": "Noir",
      "category": "BW",
      "description": "Classic black and white",
      "thumbnail": "https://picsum.photos/80/80?random=5",
      "color": Colors.grey,
    },
    {
      "name": "Sepia",
      "category": "Vintage",
      "description": "Warm sepia tones",
      "thumbnail": "https://picsum.photos/80/80?random=6",
      "color": Colors.amber,
    },
    {
      "name": "Cool Blue",
      "category": "ColorPop",
      "description": "Enhanced blue tones",
      "thumbnail": "https://picsum.photos/80/80?random=7",
      "color": Colors.blue,
    },
    {
      "name": "Warm Orange",
      "category": "ColorPop",
      "description": "Enhanced warm tones",
      "thumbnail": "https://picsum.photos/80/80?random=8",
      "color": Colors.orange,
    },
    {
      "name": "High Key",
      "category": "Artistic",
      "description": "Bright airy feel",
      "thumbnail": "https://picsum.photos/80/80?random=9",
      "color": Colors.yellow,
    },
    {
      "name": "Low Key",
      "category": "Artistic",
      "description": "Dark moody atmosphere",
      "thumbnail": "https://picsum.photos/80/80?random=10",
      "color": Colors.indigo,
    },
    {
      "name": "Matte",
      "category": "Cinematic",
      "description": "Lifted blacks matte look",
      "thumbnail": "https://picsum.photos/80/80?random=11",
      "color": Colors.blueGrey,
    },
    {
      "name": "Fade",
      "category": "Vintage",
      "description": "Faded vintage effect",
      "thumbnail": "https://picsum.photos/80/80?random=12",
      "color": Colors.teal,
    },
  ];

  List<Map<String, dynamic>> get filteredFilters {
    if (selectedCategory == "All") return allFilters;
    return allFilters.where((filter) => filter["category"] == selectedCategory).toList();
  }

  void _applyFilter(String filterName) {
    selectedFilter = filterName;
    setState(() {});
    ss("Applied $filterName filter");
  }

  void _resetFilter() {
    selectedFilter = "";
    filterIntensity = 100.0;
    setState(() {});
    si("Filter removed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(beforeAfterMode ? Icons.compare : Icons.filter),
            onPressed: () {
              beforeAfterMode = !beforeAfterMode;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFilter,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/250?random=13&keyword=model"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  if (selectedFilter.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        gradient: LinearGradient(
                          colors: [
                            _getFilterColor().withAlpha((filterIntensity * 1.28).toInt()),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  if (selectedFilter.isNotEmpty)
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          selectedFilter,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  if (beforeAfterMode && selectedFilter.isNotEmpty)
                    Positioned(
                      bottom: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Before/After",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            if (selectedFilter.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.tune, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Filter Intensity: ${filterIntensity.toInt()}%",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: filterIntensity,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        filterIntensity = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

            Text(
              "Filter Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: filterCategories.map((category) {
                bool isSelected = selectedCategory == category["value"];
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedCategory = category["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                          width: 2,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Text(
                        "${category["label"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            Text(
              "${selectedCategory == "All" ? "All" : selectedCategory} Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: filteredFilters.map((filter) {
                bool isSelected = selectedFilter == filter["name"];
                return GestureDetector(
                  onTap: () => _applyFilter(filter["name"]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 3 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            image: DecorationImage(
                              image: NetworkImage("${filter["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              gradient: LinearGradient(
                                colors: [
                                  (filter["color"] as Color).withAlpha(100),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (isSelected)
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${filter["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${filter["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: filter["color"] as Color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${filter["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
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
              }).toList(),
            ),

            if (selectedFilter.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Filter Applied: $selectedFilter",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Adjust intensity slider to fine-tune the effect. Use before/after mode to compare changes.",
                      style: TextStyle(color: disabledBoldColor, fontSize: 14),
                    ),
                  ],
                ),
              ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tips_and_updates, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Filter Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Start with lower intensity and gradually increase",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Combine filters with other adjustments for best results",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Use vintage filters for nostalgic photography",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Cinematic filters work great for portraits",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Remove Filter",
                    size: bs.md,
                    onPressed: _resetFilter,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Filter",
                    size: bs.md,
                    onPressed: () {
                      if (selectedFilter.isEmpty) {
                        se("Please select a filter first");
                        return;
                      }
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("$selectedFilter filter applied successfully!");
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getFilterColor() {
    if (selectedFilter.isEmpty) return Colors.transparent;
    
    final filter = allFilters.firstWhere(
      (f) => f["name"] == selectedFilter,
      orElse: () => {"color": Colors.grey},
    );
    
    return filter["color"] as Color;
  }
}
