import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaAlbumsView extends StatefulWidget {
  const PpaAlbumsView({super.key});

  @override
  State<PpaAlbumsView> createState() => _PpaAlbumsViewState();
}

class _PpaAlbumsViewState extends State<PpaAlbumsView> {
  List<Map<String, dynamic>> albums = [
    {
      "id": 1,
      "name": "Nature & Travel",
      "coverPhoto": "https://picsum.photos/300/200?random=1&keyword=nature",
      "photoCount": 124,
      "videoCount": 8,
      "dateCreated": "2024-01-15",
      "lastModified": "2024-03-15",
      "size": "456.7 MB",
      "description": "Beautiful nature photos and travel memories from around the world",
      "isPrivate": false,
      "favoriteCount": 23,
      "shareCount": 12
    },
    {
      "id": 2,
      "name": "Family Moments",
      "coverPhoto": "https://picsum.photos/300/200?random=2&keyword=family",
      "photoCount": 89,
      "videoCount": 15,
      "dateCreated": "2023-12-01",
      "lastModified": "2024-03-14",
      "size": "234.2 MB",
      "description": "Precious family moments and celebrations",
      "isPrivate": true,
      "favoriteCount": 45,
      "shareCount": 0
    },
    {
      "id": 3,
      "name": "Work Projects",
      "coverPhoto": "https://picsum.photos/300/200?random=3&keyword=office",
      "photoCount": 67,
      "videoCount": 3,
      "dateCreated": "2024-02-10",
      "lastModified": "2024-03-13",
      "size": "189.4 MB",
      "description": "Project documentation and work-related photos",
      "isPrivate": false,
      "favoriteCount": 8,
      "shareCount": 25
    },
    {
      "id": 4,
      "name": "Food & Recipes",
      "coverPhoto": "https://picsum.photos/300/200?random=4&keyword=food",
      "photoCount": 156,
      "videoCount": 22,
      "dateCreated": "2023-11-20",
      "lastModified": "2024-03-12",
      "size": "378.9 MB",
      "description": "Delicious food photography and cooking videos",
      "isPrivate": false,
      "favoriteCount": 34,
      "shareCount": 18
    },
    {
      "id": 5,
      "name": "Pets & Animals",
      "coverPhoto": "https://picsum.photos/300/200?random=5&keyword=animals",
      "photoCount": 203,
      "videoCount": 45,
      "dateCreated": "2023-10-05",
      "lastModified": "2024-03-11",
      "size": "567.1 MB",
      "description": "Adorable pets and wildlife photography",
      "isPrivate": false,
      "favoriteCount": 78,
      "shareCount": 56
    },
    {
      "id": 6,
      "name": "Events & Parties",
      "coverPhoto": "https://picsum.photos/300/200?random=6&keyword=party",
      "photoCount": 95,
      "videoCount": 12,
      "dateCreated": "2024-01-01",
      "lastModified": "2024-03-10",
      "size": "298.3 MB",
      "description": "Special events, parties, and celebrations",
      "isPrivate": true,
      "favoriteCount": 29,
      "shareCount": 5
    },
  ];

  List<Map<String, dynamic>> filteredAlbums = [];
  String searchQuery = "";
  String sortBy = "name";
  bool showPrivateOnly = false;
  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    filteredAlbums = albums;
    _sortAlbums();
  }

  void _filterAlbums() {
    filteredAlbums = albums.where((album) {
      bool matchesPrivacy = !showPrivateOnly || (album["isPrivate"] as bool);
      bool matchesSearch = searchQuery.isEmpty ||
          "${album["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${album["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesPrivacy && matchesSearch;
    }).toList();
    _sortAlbums();
  }

  void _sortAlbums() {
    switch (sortBy) {
      case "name":
        filteredAlbums.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
        break;
      case "date":
        filteredAlbums.sort((a, b) => "${b["lastModified"]}".compareTo("${a["lastModified"]}"));
        break;
      case "size":
        filteredAlbums.sort((a, b) {
          double sizeA = double.tryParse("${a["size"]}".replaceAll(" MB", "")) ?? 0.0;
          double sizeB = double.tryParse("${b["size"]}".replaceAll(" MB", "")) ?? 0.0;
          return sizeB.compareTo(sizeA);
        });
        break;
      case "count":
        filteredAlbums.sort((a, b) {
          int countA = (a["photoCount"] as int) + (a["videoCount"] as int);
          int countB = (b["photoCount"] as int) + (b["videoCount"] as int);
          return countB.compareTo(countA);
        });
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.view_module),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Create new album");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search albums...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            _filterAlbums();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: _filterAlbums,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: [
                            {"label": "Name", "value": "name"},
                            {"label": "Last Modified", "value": "date"},
                            {"label": "Size", "value": "size"},
                            {"label": "Item Count", "value": "count"},
                          ],
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            _sortAlbums();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Private Albums Only",
                              "value": true,
                              "checked": showPrivateOnly,
                            }
                          ],
                          value: [
                            if (showPrivateOnly)
                              {
                                "label": "Private Albums Only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showPrivateOnly = values.isNotEmpty;
                            _filterAlbums();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Statistics Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Albums Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_album,
                                color: primaryColor,
                                size: 28,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${filteredAlbums.length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Albums",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_library,
                                color: successColor,
                                size: 28,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${albums.fold(0, (sum, album) => sum + (album["photoCount"] as int))}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Photos",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.videocam,
                                color: warningColor,
                                size: 28,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${albums.fold(0, (sum, album) => sum + (album["videoCount"] as int))}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Videos",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.storage,
                                color: dangerColor,
                                size: 28,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${((albums.fold(0.0, (sum, album) => sum + (double.tryParse("${album["size"]}".replaceAll(" MB", "")) ?? 0.0)))).toStringAsFixed(1)} MB",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Storage",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Albums Grid/List
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredAlbums.map((album) {
                  return GestureDetector(
                    onTap: () {
                      ss("Opening album: ${album["name"]}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${album["coverPhoto"]}",
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: spXs,
                                  right: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${(album["photoCount"] as int) + (album["videoCount"] as int)} items",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (album["isPrivate"] as bool)
                                  Positioned(
                                    top: spXs,
                                    left: spXs,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(200),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${album["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${album["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.photo,
                                      size: 12,
                                      color: successColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${album["photoCount"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.videocam,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${album["videoCount"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${album["size"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
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
                                      "${album["favoriteCount"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.share,
                                      size: 12,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${album["shareCount"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: infoColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${DateTime.parse(album["lastModified"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "Open Album",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Opening album: ${album["name"]}");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              Column(
                children: filteredAlbums.map((album) {
                  return GestureDetector(
                    onTap: () {
                      ss("Opening album: ${album["name"]}");
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Stack(
                              children: [
                                Image.network(
                                  "${album["coverPhoto"]}",
                                  width: 100,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                if (album["isPrivate"] as bool)
                                  Positioned(
                                    top: 4,
                                    left: 4,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(200),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  bottom: 4,
                                  right: 4,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${(album["photoCount"] as int) + (album["videoCount"] as int)}",
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
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${album["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${album["description"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.photo,
                                      size: 14,
                                      color: successColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${album["photoCount"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.videocam,
                                      size: 14,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${album["videoCount"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${album["size"]}",
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
                          SizedBox(width: spSm),
                          Column(
                            children: [
                              QButton(
                                icon: Icons.folder_open,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Opening album: ${album["name"]}");
                                },
                              ),
                              SizedBox(height: spXs),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Album options for: ${album["name"]}");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ss("Create new album");
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
