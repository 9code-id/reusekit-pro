import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGallery5View extends StatefulWidget {
  @override
  State<GrlGallery5View> createState() => _GrlGallery5ViewState();
}

class _GrlGallery5ViewState extends State<GrlGallery5View> {
  String searchQuery = "";
  String selectedTag = "All";
  bool loading = false;

  final List<Map<String, dynamic>> tags = [
    {"label": "All", "value": "All", "count": 45},
    {"label": "Nature", "value": "Nature", "count": 12},
    {"label": "Urban", "value": "Urban", "count": 8},
    {"label": "Food", "value": "Food", "count": 6},
    {"label": "Travel", "value": "Travel", "count": 10},
    {"label": "Portrait", "value": "Portrait", "count": 9},
  ];

  final List<Map<String, dynamic>> photos = [
    {
      "id": 1,
      "title": "Morning Coffee",
      "url": "https://picsum.photos/400/500?random=60&keyword=coffee",
      "tags": ["Food", "Morning", "Coffee"],
      "author": "Emma Wilson",
      "likes": 234,
      "comments": 18,
      "date": "2024-01-20",
      "location": "Seattle, WA"
    },
    {
      "id": 2,
      "title": "City Lights",
      "url": "https://picsum.photos/400/600?random=61&keyword=city",
      "tags": ["Urban", "Night", "Lights"],
      "author": "Michael Chen",
      "likes": 567,
      "comments": 42,
      "date": "2024-01-19",
      "location": "New York, NY"
    },
    {
      "id": 3,
      "title": "Mountain Reflection",
      "url": "https://picsum.photos/400/400?random=62&keyword=mountain",
      "tags": ["Nature", "Mountain", "Water"],
      "author": "Sarah Johnson",
      "likes": 891,
      "comments": 76,
      "date": "2024-01-18",
      "location": "Banff, Canada"
    },
    {
      "id": 4,
      "title": "Street Portrait",
      "url": "https://picsum.photos/300/400?random=63&keyword=portrait",
      "tags": ["Portrait", "Street", "Urban"],
      "author": "David Rodriguez",
      "likes": 445,
      "comments": 29,
      "date": "2024-01-17",
      "location": "Barcelona, Spain"
    },
    {
      "id": 5,
      "title": "Tropical Paradise",
      "url": "https://picsum.photos/400/500?random=64&keyword=tropical",
      "tags": ["Travel", "Beach", "Nature"],
      "author": "Lisa Thompson",
      "likes": 1234,
      "comments": 156,
      "date": "2024-01-16",
      "location": "Maldives"
    },
    {
      "id": 6,
      "title": "Rustic Bread",
      "url": "https://picsum.photos/400/300?random=65&keyword=bread",
      "tags": ["Food", "Artisan", "Rustic"],
      "author": "Marco Rossi",
      "likes": 389,
      "comments": 34,
      "date": "2024-01-15",
      "location": "Tuscany, Italy"
    },
  ];

  List<Map<String, dynamic>> get filteredPhotos {
    var filtered = photos;

    // Filter by tag
    if (selectedTag != "All") {
      filtered = filtered.where((photo) {
        final photoTags = photo["tags"] as List<String>;
        return photoTags.contains(selectedTag);
      }).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((photo) {
        final title = (photo["title"] as String).toLowerCase();
        final author = (photo["author"] as String).toLowerCase();
        final location = (photo["location"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return title.contains(query) || author.contains(query) || location.contains(query);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Community"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // navigateTo(BookmarksView());
            },
          ),
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              si("Upload photo feature coming soon!");
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discover & Share",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Connect with photographers worldwide",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                  // Search Bar
                  QTextField(
                    label: "Search photos, authors, locations...",
                    value: searchQuery,
                    hint: "What are you looking for?",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),

                  // Tags Section
                  Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Popular Tags",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      QHorizontalScroll(
                        children: tags.map((tag) {
                          final isSelected = selectedTag == tag["value"];
                          return GestureDetector(
                            onTap: () {
                              selectedTag = tag["value"];
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: spSm),
                              padding: EdgeInsets.symmetric(
                                horizontal: spMd,
                                vertical: spSm,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? primaryColor 
                                    : primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: isSelected 
                                      ? primaryColor 
                                      : primaryColor.withAlpha(30),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${tag["label"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected 
                                          ? Colors.white 
                                          : primaryColor,
                                    ),
                                  ),
                                  if (tag["value"] != "All") ...[
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected 
                                            ? Colors.white.withAlpha(50) 
                                            : primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${tag["count"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected 
                                              ? Colors.white 
                                              : primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Stats Bar
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${filteredPhotos.length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Photos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 40, color: disabledColor),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${(filteredPhotos.fold(0, (sum, photo) => sum + (photo["likes"] as int)))}", 
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Total Likes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 40, color: disabledColor),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${(filteredPhotos.fold(0, (sum, photo) => sum + (photo["comments"] as int)))}", 
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Comments",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Photos Feed
                  if (filteredPhotos.isNotEmpty)
                    ...filteredPhotos.map((photo) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Photo Header
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${photo["author"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${photo["location"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${photo["date"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Photo Image
                            Image.network(
                              "${photo["url"]}",
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),

                            // Photo Info
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                spacing: spSm,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and Actions
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${photo["title"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          ss("Added to favorites!");
                                        },
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: dangerColor,
                                          size: 24,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      GestureDetector(
                                        onTap: () {
                                          si("Share feature coming soon!");
                                        },
                                        child: Icon(
                                          Icons.share,
                                          color: disabledBoldColor,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Tags
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (photo["tags"] as List<String>).map((tag) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "#${tag.toLowerCase()}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),

                                  // Engagement Stats
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        size: 16,
                                        color: dangerColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${photo["likes"]} likes",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: spMd),
                                      Icon(
                                        Icons.comment,
                                        size: 16,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${photo["comments"]} comments",
                                        style: TextStyle(
                                          fontSize: 13,
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
                      );
                    }).toList(),

                  // No Results
                  if (filteredPhotos.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXl),
                      child: Column(
                        spacing: spMd,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            size: 60,
                            color: disabledColor,
                          ),
                          Text(
                            "No photos found",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try a different search term or tag",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Load More
                  if (filteredPhotos.isNotEmpty)
                    Center(
                      child: QButton(
                        label: "Load More Posts",
                        size: bs.md,
                        onPressed: () async {
                          loading = true;
                          setState(() {});
                          
                          await Future.delayed(Duration(seconds: 2));
                          
                          loading = false;
                          setState(() {});
                          
                          si("More posts loaded!");
                        },
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
