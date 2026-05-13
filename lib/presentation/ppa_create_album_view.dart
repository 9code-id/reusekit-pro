import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaCreateAlbumView extends StatefulWidget {
  const PpaCreateAlbumView({super.key});

  @override
  State<PpaCreateAlbumView> createState() => _PpaCreateAlbumViewState();
}

class _PpaCreateAlbumViewState extends State<PpaCreateAlbumView> {
  final formKey = GlobalKey<FormState>();
  String albumName = "";
  String albumDescription = "";
  String albumCover = "";
  bool isPrivate = false;
  bool allowDownloads = true;
  bool autoSync = false;
  Set<String> selectedPhotos = {};
  String sortBy = "date_desc";
  
  List<Map<String, dynamic>> sortOptions = [
    {"id": "date_desc", "label": "Newest First"},
    {"id": "date_asc", "label": "Oldest First"},
    {"id": "name_asc", "label": "Name A-Z"},
    {"id": "name_desc", "label": "Name Z-A"},
    {"id": "size_desc", "label": "Largest First"},
    {"id": "size_asc", "label": "Smallest First"},
  ];

  List<Map<String, dynamic>> availablePhotos = [
    {
      "id": "1",
      "url": "https://picsum.photos/300/300?random=1&keyword=landscape",
      "name": "Mountain View",
      "date": "2024-03-15",
      "size": "2.3 MB"
    },
    {
      "id": "2",
      "url": "https://picsum.photos/300/300?random=2&keyword=sunset",
      "name": "Ocean Sunset",
      "date": "2024-03-14",
      "size": "1.8 MB"
    },
    {
      "id": "3",
      "url": "https://picsum.photos/300/300?random=3&keyword=nature",
      "name": "Forest Path",
      "date": "2024-03-13",
      "size": "2.1 MB"
    },
    {
      "id": "4",
      "url": "https://picsum.photos/300/300?random=4&keyword=city",
      "name": "City Lights",
      "date": "2024-03-12",
      "size": "2.7 MB"
    },
    {
      "id": "5",
      "url": "https://picsum.photos/300/300?random=5&keyword=architecture",
      "name": "Modern Building",
      "date": "2024-03-11",
      "size": "1.9 MB"
    },
    {
      "id": "6",
      "url": "https://picsum.photos/300/300?random=6&keyword=food",
      "name": "Gourmet Dish",
      "date": "2024-03-10",
      "size": "1.5 MB"
    },
    {
      "id": "7",
      "url": "https://picsum.photos/300/300?random=7&keyword=travel",
      "name": "Travel Memory",
      "date": "2024-03-09",
      "size": "2.4 MB"
    },
    {
      "id": "8",
      "url": "https://picsum.photos/300/300?random=8&keyword=portrait",
      "name": "Portrait Shot",
      "date": "2024-03-08",
      "size": "2.0 MB"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Album"),
        actions: [
          GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                _createAlbum();
              }
            },
            child: Padding(
              padding: EdgeInsets.all(spSm),
              child: Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Album Basic Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.photo_album,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Album Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    QTextField(
                      label: "Album Name",
                      value: albumName,
                      hint: "Enter album name",
                      validator: Validator.required,
                      onChanged: (value) {
                        albumName = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    
                    QMemoField(
                      label: "Description",
                      value: albumDescription,
                      hint: "Add a description for your album (optional)",
                      onChanged: (value) {
                        albumDescription = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    
                    QImagePicker(
                      label: "Album Cover",
                      value: albumCover,
                      hint: "Choose a cover image for your album",
                      onChanged: (value) {
                        albumCover = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Album Settings
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.settings,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Album Settings",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Privacy Setting
                    Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Private Album",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Only you can view this album",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isPrivate,
                          onChanged: (value) {
                            isPrivate = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Download Setting
                    Row(
                      children: [
                        Icon(
                          Icons.download,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Allow Downloads",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Others can download photos from this album",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: allowDownloads,
                          onChanged: (value) {
                            allowDownloads = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Auto Sync Setting
                    Row(
                      children: [
                        Icon(
                          Icons.sync,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Auto Sync",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Automatically add new photos to this album",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: autoSync,
                          onChanged: (value) {
                            autoSync = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Sort Options
                    QDropdownField(
                      label: "Default Sort Order",
                      items: sortOptions,
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Photo Selection
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.photo_library,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Photos",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${selectedPhotos.length} photos selected",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectedPhotos.clear();
                                setState(() {});
                              },
                              child: Text(
                                "Clear All",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {
                                selectedPhotos = availablePhotos.map((p) => p["id"] as String).toSet();
                                setState(() {});
                              },
                              child: Text(
                                "Select All",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: availablePhotos.map((photo) {
                        final isSelected = selectedPhotos.contains(photo["id"]);
                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              selectedPhotos.remove(photo["id"]);
                            } else {
                              selectedPhotos.add(photo["id"]);
                            }
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    border: Border.all(
                                      color: isSelected ? primaryColor : Colors.transparent,
                                      width: 3,
                                    ),
                                    boxShadow: [shadowSm],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        "${photo["url"]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Selection Overlay
                                if (isSelected)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(100),
                                        borderRadius: BorderRadius.circular(radiusMd),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                
                                // Photo Info
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(radiusMd),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withAlpha(180),
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${photo["name"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${photo["size"]}",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
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
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Create Album Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Album",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _createAlbum();
                    }
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Album Preview
              if (albumName.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: successColor.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.preview,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Album Preview",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Name: $albumName",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (albumDescription.isNotEmpty)
                        Text(
                          "Description: $albumDescription",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      Text(
                        "Photos: ${selectedPhotos.length}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Privacy: ${isPrivate ? 'Private' : 'Public'}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _createAlbum() {
    if (selectedPhotos.isEmpty) {
      sw("Please select at least one photo for the album");
      return;
    }
    
    // Simulate album creation
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Album '$albumName' created successfully with ${selectedPhotos.length} photos!");
      back();
    });
  }
}
