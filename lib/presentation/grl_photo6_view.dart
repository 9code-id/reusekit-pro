import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPhoto6View extends StatefulWidget {
  @override
  State<GrlPhoto6View> createState() => _GrlPhoto6ViewState();
}

class _GrlPhoto6ViewState extends State<GrlPhoto6View> {
  String searchQuery = "";
  String selectedFilter = "Recent";
  bool isGridView = true;
  
  List<String> filters = ["Recent", "Popular", "Trending", "Favorites"];
  
  List<Map<String, dynamic>> photos = [
    {
      "id": "1",
      "url": "https://picsum.photos/300/400?random=1&keyword=portrait",
      "title": "Street Portrait",
      "photographer": "Anna Wilson",
      "tags": ["portrait", "street", "urban", "people"],
      "likes": 125,
      "isLiked": false,
      "date": "2024-12-20",
      "popularity": 85,
      "isFavorite": false,
    },
    {
      "id": "2",
      "url": "https://picsum.photos/300/500?random=2&keyword=nature",
      "title": "Forest Morning",
      "photographer": "Mark Johnson",
      "tags": ["nature", "forest", "morning", "trees"],
      "likes": 289,
      "isLiked": true,
      "date": "2024-12-19",
      "popularity": 92,
      "isFavorite": true,
    },
    {
      "id": "3",
      "url": "https://picsum.photos/300/350?random=3&keyword=architecture",
      "title": "Modern Building",
      "photographer": "Sarah Chen",
      "tags": ["architecture", "modern", "building", "city"],
      "likes": 167,
      "isLiked": false,
      "date": "2024-12-18",
      "popularity": 78,
      "isFavorite": false,
    },
    {
      "id": "4",
      "url": "https://picsum.photos/300/450?random=4&keyword=ocean",
      "title": "Ocean Waves",
      "photographer": "David Park",
      "tags": ["ocean", "waves", "beach", "water"],
      "likes": 342,
      "isLiked": true,
      "date": "2024-12-17",
      "popularity": 96,
      "isFavorite": true,
    },
    {
      "id": "5",
      "url": "https://picsum.photos/300/380?random=5&keyword=sunset",
      "title": "Golden Sunset",
      "photographer": "Emma Davis",
      "tags": ["sunset", "golden", "sky", "clouds"],
      "likes": 203,
      "isLiked": false,
      "date": "2024-12-16",
      "popularity": 88,
      "isFavorite": false,
    },
    {
      "id": "6",
      "url": "https://picsum.photos/300/420?random=6&keyword=wildlife",
      "title": "Wildlife Capture",
      "photographer": "Tom Anderson",
      "tags": ["wildlife", "animals", "nature", "wild"],
      "likes": 156,
      "isLiked": false,
      "date": "2024-12-15",
      "popularity": 82,
      "isFavorite": false,
    },
  ];

  void _toggleLike(int index) {
    setState(() {
      photos[index]["isLiked"] = !photos[index]["isLiked"];
      if (photos[index]["isLiked"]) {
        photos[index]["likes"] = (photos[index]["likes"] as int) + 1;
      } else {
        photos[index]["likes"] = (photos[index]["likes"] as int) - 1;
      }
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      photos[index]["isFavorite"] = !photos[index]["isFavorite"];
    });
  }

  List<Map<String, dynamic>> get filteredPhotos {
    List<Map<String, dynamic>> filtered = photos;
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((photo) {
        final title = (photo["title"] as String).toLowerCase();
        final photographer = (photo["photographer"] as String).toLowerCase();
        final tags = (photo["tags"] as List).join(" ").toLowerCase();
        final query = searchQuery.toLowerCase();
        
        return title.contains(query) || 
               photographer.contains(query) || 
               tags.contains(query);
      }).toList();
    }
    
    // Apply sort filter
    switch (selectedFilter) {
      case "Recent":
        filtered.sort((a, b) => (b["date"] as String).compareTo(a["date"] as String));
        break;
      case "Popular":
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "Trending":
        filtered.sort((a, b) => (b["popularity"] as int).compareTo(a["popularity"] as int));
        break;
      case "Favorites":
        filtered = filtered.where((photo) => photo["isFavorite"] as bool).toList();
        break;
    }
    
    return filtered;
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredPhotos.map((photo) {
        int index = photos.indexOf(photo);
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Image.network(
                        "${photo["url"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _toggleFavorite(index),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              (photo["isFavorite"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                              color: (photo["isFavorite"] as bool) ? warningColor : Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => _toggleLike(index),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              (photo["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                              color: (photo["isLiked"] as bool) ? dangerColor : Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Info
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${photo["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "by ${photo["photographer"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 12,
                          color: dangerColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${photo["likes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(photo["tags"] as List)[0]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
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
      }).toList(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredPhotos.length,
      itemBuilder: (context, i) {
        final photo = filteredPhotos[i];
        int index = photos.indexOf(photo);
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              // Photo
              Container(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                  child: Image.network(
                    "${photo["url"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Info
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${photo["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "by ${photo["photographer"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 12,
                            color: dangerColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${photo["likes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          ...(photo["tags"] as List).take(2).map((tag) => Container(
                            margin: EdgeInsets.only(right: 4),
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$tag",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Actions
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleFavorite(index),
                      child: Icon(
                        (photo["isFavorite"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                        color: (photo["isFavorite"] as bool) ? warningColor : disabledBoldColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(height: spXs),
                    GestureDetector(
                      onTap: () => _toggleLike(index),
                      child: Icon(
                        (photo["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                        color: (photo["isLiked"] as bool) ? dangerColor : disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Search"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search photos...",
                    value: searchQuery,
                    hint: "Title, photographer, or tags",
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
            
            SizedBox(height: spMd),
            
            // Filter Chips
            Row(
              children: [
                Text(
                  "Sort by:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QHorizontalScroll(
                    children: filters.map((filter) {
                      final isSelected = filter == selectedFilter;
                      return GestureDetector(
                        onTap: () {
                          selectedFilter = filter;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          margin: EdgeInsets.only(right: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Results Count
            Row(
              children: [
                Text(
                  "${filteredPhotos.length} photos found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  isGridView ? "Grid View" : "List View",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Photos
            if (filteredPhotos.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No photos found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search terms or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              isGridView ? _buildGridView() : _buildListView(),
          ],
        ),
      ),
    );
  }
}
