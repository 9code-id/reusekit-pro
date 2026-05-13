import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPhoto3View extends StatefulWidget {
  @override
  State<GrlPhoto3View> createState() => _GrlPhoto3ViewState();
}

class _GrlPhoto3ViewState extends State<GrlPhoto3View> {
  String selectedFolder = "Camera Roll";
  bool isSelectionMode = false;
  List<String> selectedPhotos = [];
  String sortBy = "Date";
  
  List<Map<String, dynamic>> folders = [
    {
      "name": "Camera Roll",
      "count": 247,
      "thumbnail": "https://picsum.photos/200/200?random=1&keyword=camera",
      "lastModified": "Today",
    },
    {
      "name": "Screenshots",
      "count": 84,
      "thumbnail": "https://picsum.photos/200/200?random=2&keyword=screenshot",
      "lastModified": "Yesterday",
    },
    {
      "name": "WhatsApp Images",
      "count": 156,
      "thumbnail": "https://picsum.photos/200/200?random=3&keyword=whatsapp",
      "lastModified": "2 days ago",
    },
    {
      "name": "Downloads",
      "count": 32,
      "thumbnail": "https://picsum.photos/200/200?random=4&keyword=download",
      "lastModified": "3 days ago",
    },
    {
      "name": "Social Media",
      "count": 98,
      "thumbnail": "https://picsum.photos/200/200?random=5&keyword=social",
      "lastModified": "1 week ago",
    },
    {
      "name": "Vacation 2024",
      "count": 145,
      "thumbnail": "https://picsum.photos/200/200?random=6&keyword=vacation",
      "lastModified": "2 weeks ago",
    },
  ];

  List<Map<String, dynamic>> photos = [
    {
      "id": "1",
      "url": "https://picsum.photos/400/400?random=10&keyword=nature",
      "date": "Today, 2:30 PM",
      "size": "2.4 MB",
      "resolution": "1920x1080",
      "location": "New York, USA",
      "isFavorite": false,
    },
    {
      "id": "2",
      "url": "https://picsum.photos/400/600?random=11&keyword=portrait",
      "date": "Today, 1:15 PM",
      "size": "3.1 MB",
      "resolution": "1440x1920",
      "location": "Los Angeles, USA",
      "isFavorite": true,
    },
    {
      "id": "3",
      "url": "https://picsum.photos/600/400?random=12&keyword=landscape",
      "date": "Yesterday, 5:45 PM",
      "size": "4.2 MB",
      "resolution": "2560x1440",
      "location": "San Francisco, USA",
      "isFavorite": false,
    },
    {
      "id": "4",
      "url": "https://picsum.photos/400/400?random=13&keyword=food",
      "date": "Yesterday, 12:30 PM",
      "size": "1.8 MB",
      "resolution": "1080x1080",
      "location": "Chicago, USA",
      "isFavorite": false,
    },
    {
      "id": "5",
      "url": "https://picsum.photos/400/500?random=14&keyword=art",
      "date": "2 days ago, 4:20 PM",
      "size": "2.9 MB",
      "resolution": "1280x1600",
      "location": "Miami, USA",
      "isFavorite": true,
    },
    {
      "id": "6",
      "url": "https://picsum.photos/500/400?random=15&keyword=architecture",
      "date": "2 days ago, 10:15 AM",
      "size": "3.5 MB",
      "resolution": "2048x1536",
      "location": "Boston, USA",
      "isFavorite": false,
    },
    {
      "id": "7",
      "url": "https://picsum.photos/400/400?random=16&keyword=animals",
      "date": "3 days ago, 3:45 PM",
      "size": "2.2 MB",
      "resolution": "1200x1200",
      "location": "Seattle, USA",
      "isFavorite": false,
    },
    {
      "id": "8",
      "url": "https://picsum.photos/400/600?random=17&keyword=fashion",
      "date": "3 days ago, 11:30 AM",
      "size": "2.7 MB",
      "resolution": "1080x1620",
      "location": "Las Vegas, USA",
      "isFavorite": true,
    },
    {
      "id": "9",
      "url": "https://picsum.photos/600/400?random=18&keyword=sports",
      "date": "1 week ago, 6:00 PM",
      "size": "3.8 MB",
      "resolution": "1920x1280",
      "location": "Denver, USA",
      "isFavorite": false,
    },
    {
      "id": "10",
      "url": "https://picsum.photos/400/400?random=19&keyword=technology",
      "date": "1 week ago, 2:15 PM",
      "size": "2.1 MB",
      "resolution": "1440x1440",
      "location": "Austin, USA",
      "isFavorite": false,
    },
    {
      "id": "11",
      "url": "https://picsum.photos/400/500?random=20&keyword=travel",
      "date": "2 weeks ago, 7:30 AM",
      "size": "4.1 MB",
      "resolution": "1536x1920",
      "location": "Phoenix, USA",
      "isFavorite": true,
    },
    {
      "id": "12",
      "url": "https://picsum.photos/500/400?random=21&keyword=music",
      "date": "2 weeks ago, 9:45 PM",
      "size": "2.6 MB",
      "resolution": "1600x1280",
      "location": "Nashville, USA",
      "isFavorite": false,
    },
  ];

  void _toggleSelection(String photoId) {
    if (selectedPhotos.contains(photoId)) {
      selectedPhotos.remove(photoId);
    } else {
      selectedPhotos.add(photoId);
    }
    
    if (selectedPhotos.isEmpty) {
      isSelectionMode = false;
    }
    
    setState(() {});
  }

  void _startSelectionMode(String photoId) {
    isSelectionMode = true;
    selectedPhotos.add(photoId);
    setState(() {});
  }

  void _exitSelectionMode() {
    isSelectionMode = false;
    selectedPhotos.clear();
    setState(() {});
  }

  void _showPhotoActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "${selectedPhotos.length} ${selectedPhotos.length == 1 ? 'Photo' : 'Photos'} Selected",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.share, "Share", () {
                  Navigator.pop(context);
                  ss("${selectedPhotos.length} photos shared");
                  _exitSelectionMode();
                }),
                _buildActionButton(Icons.favorite, "Favorite", () {
                  Navigator.pop(context);
                  ss("${selectedPhotos.length} photos added to favorites");
                  _exitSelectionMode();
                }),
                _buildActionButton(Icons.edit, "Edit", () {
                  Navigator.pop(context);
                  ss("Opening photo editor");
                  _exitSelectionMode();
                }),
                _buildActionButton(Icons.delete, "Delete", () async {
                  Navigator.pop(context);
                  bool isConfirmed = await confirm("Are you sure you want to delete ${selectedPhotos.length} ${selectedPhotos.length == 1 ? 'photo' : 'photos'}?");
                  if (isConfirmed) {
                    ss("${selectedPhotos.length} photos deleted");
                    _exitSelectionMode();
                  }
                }),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Move to Album",
                size: bs.md,
                onPressed: () {
                  Navigator.pop(context);
                  _showMoveToAlbumDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showMoveToAlbumDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Move to Album"),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Image.network(
                      "${folder["thumbnail"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text("${folder["name"]}"),
                subtitle: Text("${folder["count"]} photos"),
                onTap: () {
                  Navigator.pop(context);
                  ss("${selectedPhotos.length} photos moved to ${folder["name"]}");
                  _exitSelectionMode();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...[
              "Date (Newest first)",
              "Date (Oldest first)",
              "Name (A-Z)",
              "Name (Z-A)",
              "Size (Largest first)",
              "Size (Smallest first)",
            ].map((option) => ListTile(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionMode ? "${selectedPhotos.length} Selected" : "Photo Manager"),
        leading: isSelectionMode
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: _exitSelectionMode,
              )
            : null,
        actions: isSelectionMode
            ? [
                IconButton(
                  icon: Icon(Icons.select_all),
                  onPressed: () {
                    if (selectedPhotos.length == photos.length) {
                      selectedPhotos.clear();
                    } else {
                      selectedPhotos = photos.map((photo) => photo["id"] as String).toList();
                    }
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: _showPhotoActions,
                ),
              ]
            : [
                IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: _showSortOptions,
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    si("Search functionality coming soon");
                  },
                ),
              ],
      ),
      body: Column(
        children: [
          // Folders Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Albums",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    si("View all albums");
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Folders Horizontal List
          Container(
            height: 100,
            child: QHorizontalScroll(
              children: folders.map((folder) {
                bool isSelected = selectedFolder == folder["name"];
                return GestureDetector(
                  onTap: () {
                    selectedFolder = folder["name"];
                    setState(() {});
                  },
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(right: spSm),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                            boxShadow: [shadowSm],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${folder["thumbnail"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${folder["name"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${folder["count"]}",
                          style: TextStyle(
                            fontSize: 9,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Selected Folder Info
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedFolder,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${photos.length} photos",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Photos Grid
          Expanded(
            child: ResponsiveGridView(
              padding: EdgeInsets.all(spMd),
              minItemWidth: 120,
              children: photos.map((photo) {
                bool isSelected = selectedPhotos.contains(photo["id"]);
                bool isFavorite = photo["isFavorite"];
                
                return GestureDetector(
                  onTap: () {
                    if (isSelectionMode) {
                      _toggleSelection(photo["id"]);
                    } else {
                      // Navigate to photo detail view
                      si("Opening photo viewer");
                    }
                  },
                  onLongPress: () {
                    if (!isSelectionMode) {
                      _startSelectionMode(photo["id"]);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: isSelected ? Border.all(color: primaryColor, width: 3) : null,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              "${photo["url"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        // Selection overlay
                        if (isSelectionMode)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor.withAlpha(100) : Colors.black.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                            ),
                          ),
                        
                        // Selection indicator
                        if (isSelectionMode)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.white.withAlpha(200),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                            ),
                          ),
                        
                        // Favorite indicator
                        if (isFavorite && !isSelectionMode)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 16,
                              ),
                            ),
                          ),
                        
                        // Photo info overlay
                        if (!isSelectionMode)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusLg)),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black.withAlpha(180)],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${photo["date"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${photo["size"]} • ${photo["resolution"]}",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(200),
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: isSelectionMode
          ? null
          : FloatingActionButton(
              onPressed: () {
                si("Opening camera");
              },
              backgroundColor: primaryColor,
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
    );
  }
}
