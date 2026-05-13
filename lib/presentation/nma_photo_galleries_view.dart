import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPhotoGalleriesView extends StatefulWidget {
  const NmaPhotoGalleriesView({super.key});

  @override
  State<NmaPhotoGalleriesView> createState() => _NmaPhotoGalleriesViewState();
}

class _NmaPhotoGalleriesViewState extends State<NmaPhotoGalleriesView> {
  List<Map<String, dynamic>> galleries = [
    {
      "id": 1,
      "title": "Breaking News: City Council Meeting",
      "description": "Photos from today's emergency city council session discussing budget allocations",
      "coverImage": "https://picsum.photos/400/300?random=1",
      "photoCount": 24,
      "date": "2025-06-16",
      "category": "Politics",
      "photographer": "Sarah Johnson",
      "location": "City Hall",
      "isBreaking": true,
      "viewCount": 1520,
      "likeCount": 89,
    },
    {
      "id": 2,
      "title": "Local Sports Championship Finals",
      "description": "Highlights from the thrilling championship match between local teams",
      "coverImage": "https://picsum.photos/400/300?random=2",
      "photoCount": 36,
      "date": "2025-06-15",
      "category": "Sports",
      "photographer": "Mike Chen",
      "location": "Sports Stadium",
      "isBreaking": false,
      "viewCount": 2890,
      "likeCount": 156,
    },
    {
      "id": 3,
      "title": "Community Festival Celebration",
      "description": "Annual community festival brings together families for food, music, and fun",
      "coverImage": "https://picsum.photos/400/300?random=3",
      "photoCount": 45,
      "date": "2025-06-14",
      "category": "Community",
      "photographer": "Lisa Wang",
      "location": "Central Park",
      "isBreaking": false,
      "viewCount": 980,
      "likeCount": 67,
    },
    {
      "id": 4,
      "title": "Weather Alert: Storm Damage",
      "description": "Photos documenting damage from yesterday's severe thunderstorm",
      "coverImage": "https://picsum.photos/400/300?random=4",
      "photoCount": 18,
      "date": "2025-06-13",
      "category": "Weather",
      "photographer": "David Lee",
      "location": "Downtown Area",
      "isBreaking": true,
      "viewCount": 3450,
      "likeCount": 234,
    },
    {
      "id": 5,
      "title": "Business District Development",
      "description": "Construction progress on new commercial complex in the business district",
      "coverImage": "https://picsum.photos/400/300?random=5",
      "photoCount": 28,
      "date": "2025-06-12",
      "category": "Business",
      "photographer": "Emma Davis",
      "location": "Business District",
      "isBreaking": false,
      "viewCount": 567,
      "likeCount": 34,
    },
    {
      "id": 6,
      "title": "School Graduation Ceremony",
      "description": "Students celebrate their achievements at the annual graduation ceremony",
      "coverImage": "https://picsum.photos/400/300?random=6",
      "photoCount": 52,
      "date": "2025-06-11",
      "category": "Education",
      "photographer": "John Martinez",
      "location": "High School Auditorium",
      "isBreaking": false,
      "viewCount": 1234,
      "likeCount": 98,
    },
  ];

  List<String> categories = ["All", "Politics", "Sports", "Community", "Weather", "Business", "Education"];
  String selectedCategory = "All";
  String searchQuery = "";
  String sortBy = "Newest";
  List<String> sortOptions = ["Newest", "Oldest", "Most Viewed", "Most Liked"];

  List<Map<String, dynamic>> get filteredGalleries {
    List<Map<String, dynamic>> filtered = galleries;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((gallery) => gallery["category"] == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((gallery) {
        final title = (gallery["title"] as String).toLowerCase();
        final description = (gallery["description"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    }

    // Sort
    switch (sortBy) {
      case "Oldest":
        filtered.sort((a, b) => a["date"].compareTo(b["date"]));
        break;
      case "Most Viewed":
        filtered.sort((a, b) => (b["viewCount"] as int).compareTo(a["viewCount"] as int));
        break;
      case "Most Liked":
        filtered.sort((a, b) => (b["likeCount"] as int).compareTo(a["likeCount"] as int));
        break;
      default: // Newest
        filtered.sort((a, b) => b["date"].compareTo(a["date"]));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Galleries"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            padding: EdgeInsets.all(spSm),
            child: QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          // Search Results Info
          if (searchQuery.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Row(
                children: [
                  Icon(Icons.search, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "Search results for \"$searchQuery\"",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Icon(Icons.clear, size: 16, color: dangerColor),
                  ),
                ],
              ),
            ),

          // Gallery Grid
          Expanded(
            child: filteredGalleries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No galleries found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (searchQuery.isNotEmpty || selectedCategory != "All") ...[
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : ResponsiveGridView(
                    padding: EdgeInsets.all(spSm),
                    minItemWidth: 200,
                    children: filteredGalleries.map((gallery) {
                      return _buildGalleryCard(gallery);
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryCard(Map<String, dynamic> gallery) {
    final isBreaking = gallery["isBreaking"] as bool;

    return GestureDetector(
      onTap: () => _viewGallery(gallery),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                    image: DecorationImage(
                      image: NetworkImage("${gallery["coverImage"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Breaking badge
                if (isBreaking)
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "BREAKING",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                // Photo count overlay
                Positioned(
                  bottom: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.photo_library,
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${gallery["photoCount"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Gallery Info
            Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${gallery["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${gallery["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: spSm),

                  // Date and Category
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${gallery["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${DateTime.parse(gallery["date"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),

                  // Photographer and Location
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${gallery["photographer"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${gallery["location"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Stats
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${(gallery["viewCount"] as int).toString()}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.favorite, size: 14, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${(gallery["likeCount"] as int).toString()}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View",
                        icon: Icons.photo_library,
                        size: bs.sm,
                        onPressed: () => _viewGallery(gallery),
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

  void _showSearchDialog() {
    String tempSearch = searchQuery;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Galleries"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Search term",
              value: tempSearch,
              hint: "Enter title, description, or keyword",
              onChanged: (value) {
                tempSearch = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              searchQuery = tempSearch;
              setState(() {});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort by",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...sortOptions.map((option) => ListTile(
              title: Text(option),
              trailing: sortBy == option ? Icon(Icons.check, color: primaryColor) : null,
              onTap: () {
                sortBy = option;
                setState(() {});
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _viewGallery(Map<String, dynamic> gallery) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${gallery["title"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("${gallery["coverImage"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${gallery["description"]}",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.photo_library, size: 16, color: primaryColor),
                SizedBox(width: spXs),
                Text("${gallery["photoCount"]} photos"),
                Spacer(),
                Text("By ${gallery["photographer"]}"),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "View Gallery",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Opening gallery: ${gallery["title"]}");
            },
          ),
        ],
      ),
    );
  }
}
