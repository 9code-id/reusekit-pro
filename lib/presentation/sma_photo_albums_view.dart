import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPhotoAlbumsView extends StatefulWidget {
  const SmaPhotoAlbumsView({super.key});

  @override
  State<SmaPhotoAlbumsView> createState() => _SmaPhotoAlbumsViewState();
}

class _SmaPhotoAlbumsViewState extends State<SmaPhotoAlbumsView> {
  String searchQuery = "";
  String selectedSort = "recent";
  String selectedView = "grid";
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "recent"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Most Photos", "value": "photo_count"},
    {"label": "Album Name", "value": "name"},
  ];
  
  List<Map<String, dynamic>> albums = [
    {
      "id": "album_001",
      "name": "Summer Vacation 2024",
      "description": "Amazing summer trip to Europe with family",
      "photo_count": 156,
      "video_count": 12,
      "created_date": "2024-06-01",
      "updated_date": "2024-06-15",
      "cover_photo": "https://picsum.photos/300/300?random=1&keyword=vacation",
      "privacy": "public",
      "tags": ["vacation", "summer", "europe", "family"],
      "location": "Europe",
      "photos": [
        "https://picsum.photos/300/300?random=1&keyword=vacation",
        "https://picsum.photos/300/300?random=2&keyword=beach",
        "https://picsum.photos/300/300?random=3&keyword=city",
      ]
    },
    {
      "id": "album_002",
      "name": "Wedding Memories",
      "description": "Our special day captured forever",
      "photo_count": 89,
      "video_count": 5,
      "created_date": "2024-03-15",
      "updated_date": "2024-03-20",
      "cover_photo": "https://picsum.photos/300/300?random=4&keyword=wedding",
      "privacy": "private",
      "tags": ["wedding", "celebration", "love"],
      "location": "Grand Hotel Ballroom",
      "photos": [
        "https://picsum.photos/300/300?random=4&keyword=wedding",
        "https://picsum.photos/300/300?random=5&keyword=ceremony",
        "https://picsum.photos/300/300?random=6&keyword=reception",
      ]
    },
    {
      "id": "album_003",
      "name": "Birthday Party 2024",
      "description": "Celebrating another year of life with friends",
      "photo_count": 67,
      "video_count": 8,
      "created_date": "2024-04-20",
      "updated_date": "2024-04-21",
      "cover_photo": "https://picsum.photos/300/300?random=7&keyword=birthday",
      "privacy": "friends",
      "tags": ["birthday", "party", "friends", "celebration"],
      "location": "Home",
      "photos": [
        "https://picsum.photos/300/300?random=7&keyword=birthday",
        "https://picsum.photos/300/300?random=8&keyword=cake",
        "https://picsum.photos/300/300?random=9&keyword=friends",
      ]
    },
    {
      "id": "album_004",
      "name": "Work Events",
      "description": "Professional events and team building activities",
      "photo_count": 34,
      "video_count": 3,
      "created_date": "2024-02-10",
      "updated_date": "2024-05-30",
      "cover_photo": "https://picsum.photos/300/300?random=10&keyword=office",
      "privacy": "public",
      "tags": ["work", "team", "professional"],
      "location": "Office",
      "photos": [
        "https://picsum.photos/300/300?random=10&keyword=office",
        "https://picsum.photos/300/300?random=11&keyword=meeting",
        "https://picsum.photos/300/300?random=12&keyword=team",
      ]
    },
    {
      "id": "album_005",
      "name": "Nature Photography",
      "description": "Beautiful landscapes and wildlife shots",
      "photo_count": 123,
      "video_count": 15,
      "created_date": "2024-01-05",
      "updated_date": "2024-06-10",
      "cover_photo": "https://picsum.photos/300/300?random=13&keyword=nature",
      "privacy": "public",
      "tags": ["nature", "landscape", "wildlife", "photography"],
      "location": "Various National Parks",
      "photos": [
        "https://picsum.photos/300/300?random=13&keyword=nature",
        "https://picsum.photos/300/300?random=14&keyword=mountain",
        "https://picsum.photos/300/300?random=15&keyword=forest",
      ]
    },
    {
      "id": "album_006",
      "name": "Food Adventures",
      "description": "Delicious meals and culinary experiences",
      "photo_count": 78,
      "video_count": 6,
      "created_date": "2023-12-01",
      "updated_date": "2024-06-14",
      "cover_photo": "https://picsum.photos/300/300?random=16&keyword=food",
      "privacy": "public",
      "tags": ["food", "cooking", "restaurant", "culinary"],
      "location": "Various Restaurants",
      "photos": [
        "https://picsum.photos/300/300?random=16&keyword=food",
        "https://picsum.photos/300/300?random=17&keyword=restaurant",
        "https://picsum.photos/300/300?random=18&keyword=cooking",
      ]
    },
  ];
  
  List<Map<String, dynamic>> get filteredAlbums {
    List<Map<String, dynamic>> filtered = albums;
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((album) {
        return (album["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (album["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (album["tags"] as List).any((tag) => (tag as String).toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Apply sorting
    switch (selectedSort) {
      case "recent":
        filtered.sort((a, b) => DateTime.parse(b["updated_date"] as String).compareTo(DateTime.parse(a["updated_date"] as String)));
        break;
      case "oldest":
        filtered.sort((a, b) => DateTime.parse(a["created_date"] as String).compareTo(DateTime.parse(b["created_date"] as String)));
        break;
      case "photo_count":
        filtered.sort((a, b) => (b["photo_count"] as int).compareTo(a["photo_count"] as int));
        break;
      case "name":
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
    }
    
    return filtered;
  }
  
  IconData getPrivacyIcon(String privacy) {
    switch (privacy) {
      case "public":
        return Icons.public;
      case "friends":
        return Icons.group;
      case "private":
        return Icons.lock;
      default:
        return Icons.public;
    }
  }
  
  Color getPrivacyColor(String privacy) {
    switch (privacy) {
      case "public":
        return successColor;
      case "friends":
        return warningColor;
      case "private":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  void _createNewAlbum() {
    si("Create new album");
    // Navigate to create album page
  }
  
  void _viewAlbum(Map<String, dynamic> album) {
    si("Viewing album: ${album["name"]}");
    // Navigate to album detail page
  }
  
  void _shareAlbum(Map<String, dynamic> album) {
    ss("Album shared successfully");
  }
  
  void _deleteAlbum(Map<String, dynamic> album) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this album?");
    if (isConfirmed) {
      ss("Album deleted successfully");
      // Remove album from list
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Albums"),
        actions: [
          IconButton(
            icon: Icon(selectedView == "grid" ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              selectedView = selectedView == "grid" ? "list" : "grid";
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewAlbum,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Albums",
                    value: searchQuery,
                    hint: "Search by name, description, or tags",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: selectedSort,
                          onChanged: (value, label) {
                            selectedSort = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.add,
                        label: "New Album",
                        size: bs.sm,
                        onPressed: _createNewAlbum,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Albums Count
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${filteredAlbums.length} ${filteredAlbums.length == 1 ? 'album' : 'albums'} found",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${albums.map((a) => a["photo_count"] as int).reduce((a, b) => a + b)} total photos",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // Albums Grid/List
            if (filteredAlbums.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.photo_library_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No albums found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Create your first album to get started!",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Create Album",
                      size: bs.md,
                      onPressed: _createNewAlbum,
                    ),
                  ],
                ),
              )
            else if (selectedView == "grid")
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredAlbums.map((album) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Album Cover
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              child: Image.network(
                                "${album["cover_photo"]}",
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Privacy Badge
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  getPrivacyIcon(album["privacy"] as String),
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                            // Photo Count Badge
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${album["photo_count"]} photos",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Album Info
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${album["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${album["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    child: Text(
                                      "${album["location"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Updated ${DateTime.parse(album["updated_date"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "View",
                                      size: bs.sm,
                                      onPressed: () => _viewAlbum(album),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.more_vert,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Show options menu
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                          padding: EdgeInsets.all(spMd),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.share),
                                                title: Text('Share Album'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  _shareAlbum(album);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.edit),
                                                title: Text('Edit Album'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  si("Edit album");
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.delete, color: dangerColor),
                                                title: Text('Delete Album', style: TextStyle(color: dangerColor)),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  _deleteAlbum(album);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
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
              )
            else
              // List View
              Column(
                spacing: spSm,
                children: filteredAlbums.map((album) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        // Album Thumbnail
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${album["cover_photo"]}",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${album["photo_count"]}",
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
                        
                        // Album Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${album["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    getPrivacyIcon(album["privacy"] as String),
                                    color: getPrivacyColor(album["privacy"] as String),
                                    size: 16,
                                  ),
                                ],
                              ),
                              Text(
                                "${album["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${album["photo_count"]} photos",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if ((album["video_count"] as int) > 0) ...[
                                    Text(" • ", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                                    Text(
                                      "${album["video_count"]} videos",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: infoColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                  Spacer(),
                                  Text(
                                    "Updated ${DateTime.parse(album["updated_date"] as String).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Action Button
                        QButton(
                          icon: Icons.arrow_forward,
                          size: bs.sm,
                          onPressed: () => _viewAlbum(album),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
