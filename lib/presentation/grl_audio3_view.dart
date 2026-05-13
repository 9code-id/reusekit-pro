import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAudio3View extends StatefulWidget {
  @override
  State<GrlAudio3View> createState() => _GrlAudio3ViewState();
}

class _GrlAudio3ViewState extends State<GrlAudio3View> {
  String playlistName = "My Playlist";
  String playlistDescription = "";
  bool isPublic = false;
  String selectedCover = "https://picsum.photos/300/300?random=1&keyword=music";

  List<Map<String, dynamic>> availableTracks = [
    {
      "id": 1,
      "title": "Ocean Waves",
      "artist": "Nature Sounds",
      "album": "Relaxing Ocean",
      "duration": "5:30",
      "image": "https://picsum.photos/200/200?random=1&keyword=ocean",
      "genre": "Nature",
      "isSelected": true
    },
    {
      "id": 2,
      "title": "Forest Birds",
      "artist": "Wildlife Audio",
      "album": "Forest Collection",
      "duration": "4:15",
      "image": "https://picsum.photos/200/200?random=2&keyword=forest",
      "genre": "Nature",
      "isSelected": false
    },
    {
      "id": 3,
      "title": "Rain on Roof",
      "artist": "Weather Sounds",
      "album": "Rainy Day",
      "duration": "6:45",
      "image": "https://picsum.photos/200/200?random=3&keyword=rain",
      "genre": "Ambient",
      "isSelected": true
    },
    {
      "id": 4,
      "title": "City Traffic",
      "artist": "Urban Audio",
      "album": "City Life",
      "duration": "3:20",
      "image": "https://picsum.photos/200/200?random=4&keyword=city",
      "genre": "Urban",
      "isSelected": false
    },
    {
      "id": 5,
      "title": "Campfire Crackle",
      "artist": "Outdoor Sounds",
      "album": "Camping Experience",
      "duration": "7:12",
      "image": "https://picsum.photos/200/200?random=5&keyword=fire",
      "genre": "Nature",
      "isSelected": true
    },
    {
      "id": 6,
      "title": "Wind Through Trees",
      "artist": "Natural Elements",
      "album": "Wind Series",
      "duration": "4:55",
      "image": "https://picsum.photos/200/200?random=6&keyword=wind",
      "genre": "Nature",
      "isSelected": false
    },
    {
      "id": 7,
      "title": "Thunderstorm",
      "artist": "Storm Audio",
      "album": "Weather Phenomena",
      "duration": "8:30",
      "image": "https://picsum.photos/200/200?random=7&keyword=storm",
      "genre": "Weather",
      "isSelected": false
    },
    {
      "id": 8,
      "title": "White Noise",
      "artist": "Focus Sounds",
      "album": "Concentration Aid",
      "duration": "10:00",
      "image": "https://picsum.photos/200/200?random=8&keyword=focus",
      "genre": "Ambient",
      "isSelected": true
    }
  ];

  List<String> genreFilters = ["All", "Nature", "Ambient", "Urban", "Weather"];
  String selectedGenre = "All";

  List<String> coverOptions = [
    "https://picsum.photos/300/300?random=1&keyword=music",
    "https://picsum.photos/300/300?random=2&keyword=nature",
    "https://picsum.photos/300/300?random=3&keyword=abstract",
    "https://picsum.photos/300/300?random=4&keyword=art",
    "https://picsum.photos/300/300?random=5&keyword=color",
    "https://picsum.photos/300/300?random=6&keyword=pattern"
  ];

  @override
  Widget build(BuildContext context) {
    final selectedTracks = availableTracks.where((track) => track["isSelected"] == true).toList();
    final filteredTracks = selectedGenre == "All" 
        ? availableTracks 
        : availableTracks.where((track) => track["genre"] == selectedGenre).toList();

    final totalDuration = selectedTracks.fold(0, (sum, track) {
      final duration = track["duration"].toString().split(":");
      return sum + (int.parse(duration[0]) * 60) + int.parse(duration[1]);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Playlist"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              _savePlaylist();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Playlist Details
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Playlist Details",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),

                  // Cover Selection
                  Text(
                    "Choose Cover",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  QHorizontalScroll(
                    children: coverOptions.map((cover) {
                      return GestureDetector(
                        onTap: () {
                          selectedCover = cover;
                          setState(() {});
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage(cover),
                              fit: BoxFit.cover,
                            ),
                            border: selectedCover == cover
                                ? Border.all(color: primaryColor, width: 3)
                                : Border.all(color: disabledColor, width: 1),
                          ),
                          child: selectedCover == cover
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    color: primaryColor.withAlpha(100),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: spLg),

                  // Playlist Name
                  QTextField(
                    label: "Playlist Name",
                    value: playlistName,
                    onChanged: (value) {
                      playlistName = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spSm),

                  // Playlist Description
                  QMemoField(
                    label: "Description (optional)",
                    value: playlistDescription,
                    onChanged: (value) {
                      playlistDescription = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spSm),

                  // Public/Private Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Make playlist public",
                              "value": true,
                              "checked": isPublic,
                            }
                          ],
                          value: [
                            if (isPublic)
                              {
                                "label": "Make playlist public",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isPublic = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Playlist Summary
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor.withAlpha(50), secondaryColor.withAlpha(30)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage(selectedCover),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [shadowSm],
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlistName,
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${selectedTracks.length} tracks",
                          style: TextStyle(
                            fontSize: 14,
                            color: secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${(totalDuration ~/ 60)}h ${(totalDuration % 60)}m",
                          style: TextStyle(
                            fontSize: 14,
                            color: secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isPublic)
                          Container(
                            margin: EdgeInsets.only(top: spXs),
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Public",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Track Selection
            Text(
              "Add Tracks",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Genre Filter
            QCategoryPicker(
              label: "Filter by Genre",
              items: genreFilters.map((genre) => {
                "label": genre,
                "value": genre,
              }).toList(),
              value: selectedGenre,
              onChanged: (index, label, value, item) {
                selectedGenre = value;
                setState(() {});
              },
            ),

            SizedBox(height: spSm),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Select All",
                    size: bs.sm,
                    onPressed: () {
                      for (var track in filteredTracks) {
                        track["isSelected"] = true;
                      }
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Deselect All",
                    size: bs.sm,
                    onPressed: () {
                      for (var track in filteredTracks) {
                        track["isSelected"] = false;
                      }
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Available Tracks
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: filteredTracks.map((track) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: track["isSelected"] == true 
                          ? primaryColor.withAlpha(50) 
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: track["isSelected"] == true 
                          ? Border.all(color: primaryColor.withAlpha(100), width: 1)
                          : null,
                    ),
                    child: CheckboxListTile(
                      value: track["isSelected"],
                      onChanged: (bool? value) {
                        track["isSelected"] = value ?? false;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                      title: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${track["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${track["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${track["artist"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: secondaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(50),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${track["genre"]}",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${track["duration"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
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
                }).toList(),
              ),
            ),

            SizedBox(height: spLg),

            // Selected Tracks Preview
            if (selectedTracks.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Selected Tracks (${selectedTracks.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          icon: Icons.shuffle,
                          size: bs.sm,
                          onPressed: () {
                            // Shuffle selected tracks
                            selectedTracks.shuffle();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: selectedTracks.take(5).map((track) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  image: DecorationImage(
                                    image: NetworkImage("${track["image"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${track["title"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${track["duration"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    if (selectedTracks.length > 5)
                      Padding(
                        padding: EdgeInsets.only(top: spXs),
                        child: Text(
                          "... and ${selectedTracks.length - 5} more tracks",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _savePlaylist() {
    if (playlistName.isEmpty) {
      se("Please enter a playlist name");
      return;
    }

    final selectedTracks = availableTracks.where((track) => track["isSelected"] == true).toList();
    
    if (selectedTracks.isEmpty) {
      se("Please select at least one track");
      return;
    }

    // Simulate saving playlist
    ss("Playlist '$playlistName' created successfully with ${selectedTracks.length} tracks!");
    
    // Navigate back or to playlist view
    //navigateTo('back');
  }
}
