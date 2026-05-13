import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaHighlightsView extends StatefulWidget {
  const GeaHighlightsView({super.key});

  @override
  State<GeaHighlightsView> createState() => _GeaHighlightsViewState();
}

class _GeaHighlightsViewState extends State<GeaHighlightsView> {
  String selectedCategory = "All";
  String selectedGame = "All Games";
  String searchQuery = "";
  bool isCreatingHighlight = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Kills", "value": "Kills"},
    {"label": "Clutches", "value": "Clutches"},
    {"label": "Headshots", "value": "Headshots"},
    {"label": "Aces", "value": "Aces"},
    {"label": "Funny", "value": "Funny"},
  ];

  List<Map<String, dynamic>> games = [
    {"label": "All Games", "value": "All Games"},
    {"label": "Valorant", "value": "Valorant"},
    {"label": "CS2", "value": "CS2"},
    {"label": "Apex Legends", "value": "Apex Legends"},
    {"label": "Overwatch 2", "value": "Overwatch 2"},
  ];

  List<Map<String, dynamic>> highlights = [
    {
      "id": 1,
      "title": "Insane 1v5 Clutch on Ascent",
      "game": "Valorant",
      "category": "Clutches",
      "duration": "0:45",
      "views": 12500,
      "likes": 847,
      "player": "ProGamer123",
      "thumbnail": "https://picsum.photos/400/225?random=1&keyword=gaming",
      "uploadedAt": "2 hours ago",
      "featured": true,
    },
    {
      "id": 2,
      "title": "Perfect Headshot Montage",
      "game": "CS2",
      "category": "Headshots",
      "duration": "2:15",
      "views": 8200,
      "likes": 623,
      "player": "AimBot_Real",
      "thumbnail": "https://picsum.photos/400/225?random=2&keyword=gaming",
      "uploadedAt": "5 hours ago",
      "featured": false,
    },
    {
      "id": 3,
      "title": "Ace with Sheriff Only",
      "game": "Valorant",
      "category": "Aces",
      "duration": "1:30",
      "views": 15800,
      "likes": 1200,
      "player": "SheriffKing",
      "thumbnail": "https://picsum.photos/400/225?random=3&keyword=gaming",
      "uploadedAt": "1 day ago",
      "featured": true,
    },
    {
      "id": 4,
      "title": "Funny Teammate Reactions",
      "game": "Apex Legends",
      "category": "Funny",
      "duration": "3:22",
      "views": 6700,
      "likes": 445,
      "player": "ComedyGamer",
      "thumbnail": "https://picsum.photos/400/225?random=4&keyword=gaming",
      "uploadedAt": "2 days ago",
      "featured": false,
    },
    {
      "id": 5,
      "title": "Triple Kill with Sniper",
      "game": "Overwatch 2",
      "category": "Kills",
      "duration": "0:35",
      "views": 9300,
      "likes": 567,
      "player": "SniperElite",
      "thumbnail": "https://picsum.photos/400/225?random=5&keyword=gaming",
      "uploadedAt": "3 days ago",
      "featured": false,
    },
  ];

  List<Map<String, dynamic>> get filteredHighlights {
    return highlights.where((highlight) {
      bool matchesCategory = selectedCategory == "All" || highlight["category"] == selectedCategory;
      bool matchesGame = selectedGame == "All Games" || highlight["game"] == selectedGame;
      bool matchesSearch = searchQuery.isEmpty || 
          (highlight["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (highlight["player"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesGame && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GEA Highlights"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _createHighlight(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchAndFilters(),
            _buildFeaturedHighlights(),
            _buildAllHighlights(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search highlights...",
                value: searchQuery,
                hint: "Search by title or player",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.search,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Game",
                items: games,
                value: selectedGame,
                onChanged: (value, label) {
                  selectedGame = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedHighlights() {
    final featuredHighlights = highlights.where((h) => h["featured"] as bool).toList();
    
    if (featuredHighlights.isEmpty) return SizedBox.shrink();

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Highlights",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: featuredHighlights.map((highlight) => _buildFeaturedHighlightCard(highlight)).toList(),
        ),
      ],
    );
  }

  Widget _buildFeaturedHighlightCard(Map<String, dynamic> highlight) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${highlight["thumbnail"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "FEATURED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spXs,
                left: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${highlight["duration"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white, size: 12),
                      SizedBox(width: 2),
                      Text(
                        "${((highlight["views"] as int) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${highlight["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${highlight["game"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${highlight["category"]}",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.person, color: disabledBoldColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${highlight["player"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.favorite, color: dangerColor, size: 14),
        SizedBox(width: 2),
                    Text(
                      "${highlight["likes"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllHighlights() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "All Highlights",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredHighlights.length} highlights",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
        ...filteredHighlights.map((highlight) => _buildHighlightListItem(highlight)).toList(),
      ],
    );
  }

  Widget _buildHighlightListItem(Map<String, dynamic> highlight) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${highlight["thumbnail"]}",
                  width: 120,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${highlight["duration"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${highlight["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${highlight["game"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${highlight["category"]}",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${highlight["player"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "•",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${highlight["uploadedAt"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.play_arrow, color: disabledBoldColor, size: 12),
                    SizedBox(width: 2),
                    Text(
                      "${((highlight["views"] as int) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Icon(Icons.favorite, color: dangerColor, size: 12),
                    SizedBox(width: 2),
                    Text(
                      "${highlight["likes"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.play_arrow,
            size: bs.sm,
            onPressed: () => _playHighlight(highlight),
          ),
        ],
      ),
    );
  }

  void _createHighlight() {
    ss("Highlight creation started");
  }

  void _playHighlight(Map<String, dynamic> highlight) {
    ss("Playing: ${highlight["title"]}");
  }
}
