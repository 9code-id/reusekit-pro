import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPhoto7View extends StatefulWidget {
  @override
  State<GrlPhoto7View> createState() => _GrlPhoto7ViewState();
}

class _GrlPhoto7ViewState extends State<GrlPhoto7View> {
  String albumName = "";
  String albumDescription = "";
  bool isPrivate = false;
  List<String> selectedPhotos = [];
  
  List<Map<String, dynamic>> availablePhotos = [
    {
      "id": "1",
      "url": "https://picsum.photos/200/200?random=1&keyword=nature",
      "title": "Mountain View",
      "selected": false,
    },
    {
      "id": "2",
      "url": "https://picsum.photos/200/200?random=2&keyword=ocean",
      "title": "Ocean Sunset",
      "selected": false,
    },
    {
      "id": "3",
      "url": "https://picsum.photos/200/200?random=3&keyword=forest",
      "title": "Forest Path",
      "selected": false,
    },
    {
      "id": "4",
      "url": "https://picsum.photos/200/200?random=4&keyword=city",
      "title": "City Lights",
      "selected": false,
    },
    {
      "id": "5",
      "url": "https://picsum.photos/200/200?random=5&keyword=desert",
      "title": "Desert Dunes",
      "selected": false,
    },
    {
      "id": "6",
      "url": "https://picsum.photos/200/200?random=6&keyword=lake",
      "title": "Alpine Lake",
      "selected": false,
    },
    {
      "id": "7",
      "url": "https://picsum.photos/200/200?random=7&keyword=architecture",
      "title": "Modern Building",
      "selected": false,
    },
    {
      "id": "8",
      "url": "https://picsum.photos/200/200?random=8&keyword=flower",
      "title": "Spring Flowers",
      "selected": false,
    },
    {
      "id": "9",
      "url": "https://picsum.photos/200/200?random=9&keyword=snow",
      "title": "Snow Mountain",
      "selected": false,
    },
    {
      "id": "10",
      "url": "https://picsum.photos/200/200?random=10&keyword=wildlife",
      "title": "Wildlife",
      "selected": false,
    },
  ];

  final formKey = GlobalKey<FormState>();

  void _togglePhotoSelection(int index) {
    setState(() {
      availablePhotos[index]["selected"] = !availablePhotos[index]["selected"];
      
      if (availablePhotos[index]["selected"]) {
        selectedPhotos.add(availablePhotos[index]["id"]);
      } else {
        selectedPhotos.remove(availablePhotos[index]["id"]);
      }
    });
  }

  void _selectAll() {
    setState(() {
      bool allSelected = availablePhotos.every((photo) => photo["selected"]);
      
      for (int i = 0; i < availablePhotos.length; i++) {
        availablePhotos[i]["selected"] = !allSelected;
      }
      
      if (allSelected) {
        selectedPhotos.clear();
      } else {
        selectedPhotos = availablePhotos.map((photo) => photo["id"] as String).toList();
      }
    });
  }

  void _createAlbum() {
    if (formKey.currentState!.validate() && selectedPhotos.isNotEmpty) {
      // Create album logic here
      ss("Album '${albumName}' created successfully with ${selectedPhotos.length} photos");
      back();
    } else if (selectedPhotos.isEmpty) {
      se("Please select at least one photo for the album");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Album"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
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
              // Album Info Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Album Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Album Name
                    QTextField(
                      label: "Album Name",
                      value: albumName,
                      hint: "Enter a name for your album",
                      validator: Validator.required,
                      onChanged: (value) {
                        albumName = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Album Description
                    QMemoField(
                      label: "Description",
                      value: albumDescription,
                      hint: "Optional description for your album",
                      onChanged: (value) {
                        albumDescription = value;
                        setState(() {});
                      },
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Privacy Setting
                    QSwitch(
                      label: "Privacy Settings",
                      items: [
                        {
                          "label": "Make this album private",
                          "value": true,
                          "checked": isPrivate,
                        }
                      ],
                      value: [
                        if (isPrivate)
                          {
                            "label": "Make this album private",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          isPrivate = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Photo Selection Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Select Photos",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: _selectAll,
                          child: Text(
                            availablePhotos.every((photo) => photo["selected"]) 
                                ? "Deselect All" 
                                : "Select All",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Selected Count
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: selectedPhotos.isNotEmpty ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${selectedPhotos.length} of ${availablePhotos.length} photos selected",
                        style: TextStyle(
                          fontSize: 12,
                          color: selectedPhotos.isNotEmpty ? primaryColor : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Photo Grid
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 120,
                      children: availablePhotos.map((photo) {
                        int index = availablePhotos.indexOf(photo);
                        bool isSelected = photo["selected"];
                        
                        return GestureDetector(
                          onTap: () => _togglePhotoSelection(index),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${photo["url"]}",
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              
                              // Selection Overlay
                              if (isSelected)
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(100),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              
                              // Photo Title
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withAlpha(150),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusSm)),
                                  ),
                                  child: Text(
                                    "${photo["title"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Preview Section
              if (selectedPhotos.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Album Preview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Album Name: ${albumName.isNotEmpty ? albumName : 'Untitled Album'}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (albumDescription.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(height: 4),
                            Text(
                              "Description: ${albumDescription}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Privacy: ${isPrivate ? 'Private' : 'Public'}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            isPrivate ? Icons.lock : Icons.public,
                            size: 14,
                            color: isPrivate ? warningColor : successColor,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedPhotos.length,
                          itemBuilder: (context, index) {
                            final photoId = selectedPhotos[index];
                            final photo = availablePhotos.firstWhere((p) => p["id"] == photoId);
                            
                            return Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(right: spXs),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${photo["url"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              
              SizedBox(height: spLg),
              
              // Create Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: selectedPhotos.isNotEmpty 
                      ? "Create Album with ${selectedPhotos.length} Photos"
                      : "Create Album",
                  size: bs.md,
                  onPressed: _createAlbum,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
