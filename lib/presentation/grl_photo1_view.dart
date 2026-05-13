import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPhoto1View extends StatefulWidget {
  @override
  State<GrlPhoto1View> createState() => _GrlPhoto1ViewState();
}

class _GrlPhoto1ViewState extends State<GrlPhoto1View> {
  String searchQuery = "";
  String selectedAlbum = "All Photos";
  bool isGridView = true;

  List<Map<String, dynamic>> albums = [
    {"label": "All Photos", "value": "All Photos"},
    {"label": "Recent", "value": "Recent"},
    {"label": "Favorites", "value": "Favorites"},
    {"label": "Portrait", "value": "Portrait"},
    {"label": "Landscape", "value": "Landscape"},
    {"label": "Nature", "value": "Nature"},
    {"label": "Travel", "value": "Travel"},
  ];

  List<Map<String, dynamic>> photos = [
    {
      "id": "1",
      "url": "https://picsum.photos/400/600?random=301&keyword=portrait",
      "title": "Beautiful Portrait",
      "album": "Portrait",
      "location": "New York, USA",
      "dateTaken": "2024-01-15",
      "camera": "iPhone 15 Pro",
      "size": "4.2 MB",
      "dimensions": "4032x3024",
      "isFavorite": true,
      "tags": ["portrait", "professional", "studio"],
    },
    {
      "id": "2",
      "url": "https://picsum.photos/600/400?random=302&keyword=landscape",
      "title": "Mountain Sunset",
      "album": "Landscape",
      "location": "Alps, Switzerland",
      "dateTaken": "2024-01-10",
      "camera": "Canon EOS R5",
      "size": "8.7 MB",
      "dimensions": "6720x4480",
      "isFavorite": false,
      "tags": ["landscape", "sunset", "mountains"],
    },
    {
      "id": "3",
      "url": "https://picsum.photos/400/400?random=303&keyword=nature",
      "title": "Forest Path",
      "album": "Nature",
      "location": "Oregon, USA",
      "dateTaken": "2024-01-12",
      "camera": "Sony A7R IV",
      "size": "6.3 MB",
      "dimensions": "5472x3648",
      "isFavorite": true,
      "tags": ["nature", "forest", "path"],
    },
    {
      "id": "4",
      "url": "https://picsum.photos/500/700?random=304&keyword=architecture",
      "title": "Modern Architecture",
      "album": "Travel",
      "location": "Tokyo, Japan",
      "dateTaken": "2024-01-08",
      "camera": "Fujifilm X-T4",
      "size": "5.1 MB",
      "dimensions": "4896x3264",
      "isFavorite": false,
      "tags": ["architecture", "modern", "urban"],
    },
    {
      "id": "5",
      "url": "https://picsum.photos/600/600?random=305&keyword=food",
      "title": "Gourmet Dish",
      "album": "Recent",
      "location": "Paris, France",
      "dateTaken": "2024-01-20",
      "camera": "iPhone 15 Pro Max",
      "size": "3.8 MB",
      "dimensions": "4032x4032",
      "isFavorite": true,
      "tags": ["food", "gourmet", "restaurant"],
    },
    {
      "id": "6",
      "url": "https://picsum.photos/700/500?random=306&keyword=beach",
      "title": "Ocean Waves",
      "album": "Travel",
      "location": "Maldives",
      "dateTaken": "2024-01-05",
      "camera": "GoPro Hero 12",
      "size": "4.5 MB",
      "dimensions": "5312x2988",
      "isFavorite": false,
      "tags": ["beach", "ocean", "waves"],
    },
    {
      "id": "7",
      "url": "https://picsum.photos/400/500?random=307&keyword=flowers",
      "title": "Spring Flowers",
      "album": "Nature",
      "location": "Amsterdam, Netherlands",
      "dateTaken": "2024-01-18",
      "camera": "Nikon D850",
      "size": "7.2 MB",
      "dimensions": "8256x5504",
      "isFavorite": true,
      "tags": ["flowers", "spring", "colorful"],
    },
    {
      "id": "8",
      "url": "https://picsum.photos/600/800?random=308&keyword=city",
      "title": "City Lights",
      "album": "Recent",
      "location": "Hong Kong",
      "dateTaken": "2024-01-22",
      "camera": "Canon EOS R6",
      "size": "6.8 MB",
      "dimensions": "6000x4000",
      "isFavorite": false,
      "tags": ["city", "night", "lights"],
    },
  ];

  List<Map<String, dynamic>> get filteredPhotos {
    return photos.where((photo) {
      bool matchesSearch = "${photo["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${photo["location"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (photo["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesAlbum = selectedAlbum == "All Photos" || photo["album"] == selectedAlbum;
      
      if (selectedAlbum == "Favorites") {
        matchesAlbum = photo["isFavorite"] as bool;
      } else if (selectedAlbum == "Recent") {
        matchesAlbum = photo["album"] == "Recent" ||
            DateTime.parse(photo["dateTaken"]).isAfter(DateTime.now().subtract(Duration(days: 7)));
      }
      
      return matchesSearch && matchesAlbum;
    }).toList();
  }

  Widget _buildPhotoCard(Map<String, dynamic> photo) {
    return GestureDetector(
      onTap: () {
        // Navigate to photo detail view
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                image: DecorationImage(
                  image: NetworkImage("${photo["url"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(128),
                  ],
                ),
              ),
            ),
            Positioned(
              top: spSm,
              right: spSm,
              child: GestureDetector(
                onTap: () {
                  photo["isFavorite"] = !photo["isFavorite"];
                  setState(() {});
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(179),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    photo["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                    color: photo["isFavorite"] as bool ? dangerColor : disabledBoldColor,
                    size: 20,
                  ),
                ),
              ),
            ),
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
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(204),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${photo["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white.withAlpha(204),
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${photo["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(204),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.white.withAlpha(204),
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${photo["camera"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListCard(Map<String, dynamic> photo) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${photo["url"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${photo["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: disabledBoldColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${photo["location"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${photo["dateTaken"]} • ${photo["camera"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${photo["dimensions"]} • ${photo["size"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: (photo["tags"] as List).take(2).map((tag) {
                      return Container(
                        margin: EdgeInsets.only(right: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    photo["isFavorite"] = !photo["isFavorite"];
                    setState(() {});
                  },
                  child: Icon(
                    photo["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                    color: photo["isFavorite"] as bool ? dangerColor : disabledBoldColor,
                    size: 20,
                  ),
                ),
                SizedBox(height: spSm),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.share,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
                SizedBox(height: spSm),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Gallery"),
        actions: [
          GestureDetector(
            onTap: () {
              isGridView = !isGridView;
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                isGridView ? Icons.list : Icons.grid_view,
                color: primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.camera_alt,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search photos...",
                    value: searchQuery,
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
            QCategoryPicker(
              label: "Albums",
              items: albums,
              value: selectedAlbum,
              onChanged: (index, label, value, item) {
                selectedAlbum = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredPhotos.length} Photos",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.sort,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.filter_list,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spMd),
            if (isGridView)
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredPhotos.map((photo) {
                  return AspectRatio(
                    aspectRatio: 0.8,
                    child: _buildPhotoCard(photo),
                  );
                }).toList(),
              )
            else
              Column(
                children: filteredPhotos.map((photo) {
                  return _buildListCard(photo);
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
