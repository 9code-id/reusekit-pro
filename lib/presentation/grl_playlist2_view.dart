import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlaylist2View extends StatefulWidget {
  @override
  State<GrlPlaylist2View> createState() => _GrlPlaylist2ViewState();
}

class _GrlPlaylist2ViewState extends State<GrlPlaylist2View> {
  bool isEditing = false;
  String searchQuery = "";
  List<String> selectedTracks = [];

  Map<String, dynamic> playlistInfo = {
    "name": "My Favorites",
    "description": "A collection of my all-time favorite songs",
    "artwork": "https://picsum.photos/80/80?random=80&keyword=favorite",
    "isPrivate": false,
    "tracks": 24,
    "duration": "1h 47m",
    "owner": "You",
    "created": "Created 3 months ago",
  };

  List<Map<String, dynamic>> tracks = [
    {
      "id": "1",
      "title": "Bohemian Rhapsody",
      "artist": "Queen",
      "album": "A Night at the Opera",
      "duration": "5:55",
      "artwork": "https://picsum.photos/60/60?random=81&keyword=queen",
      "isLiked": true,
      "addedDate": "2024-03-15",
    },
    {
      "id": "2", 
      "title": "Hotel California",
      "artist": "Eagles",
      "album": "Hotel California",
      "duration": "6:30",
      "artwork": "https://picsum.photos/60/60?random=82&keyword=hotel",
      "isLiked": true,
      "addedDate": "2024-03-14",
    },
    {
      "id": "3",
      "title": "Stairway to Heaven",
      "artist": "Led Zeppelin",
      "album": "Led Zeppelin IV",
      "duration": "8:02",
      "artwork": "https://picsum.photos/60/60?random=83&keyword=stairway",
      "isLiked": true,
      "addedDate": "2024-03-13",
    },
    {
      "id": "4",
      "title": "Imagine",
      "artist": "John Lennon",
      "album": "Imagine",
      "duration": "3:03",
      "artwork": "https://picsum.photos/60/60?random=84&keyword=imagine",
      "isLiked": false,
      "addedDate": "2024-03-12",
    },
    {
      "id": "5",
      "title": "Sweet Child O' Mine",
      "artist": "Guns N' Roses",
      "album": "Appetite for Destruction",
      "duration": "5:03",
      "artwork": "https://picsum.photos/60/60?random=85&keyword=sweet",
      "isLiked": true,
      "addedDate": "2024-03-11",
    },
  ];

  List<Map<String, dynamic>> get filteredTracks {
    if (searchQuery.isEmpty) return tracks;
    return tracks.where((track) {
      return track["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             track["artist"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             track["album"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(),
          _buildPlaylistHeader(),
          if (isEditing) _buildEditingControls(),
          _buildSearchSection(),
          Expanded(child: _buildTracksList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spSm, spMd, spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (isEditing) {
                isEditing = false;
                selectedTracks.clear();
                setState(() {});
              } else {
                back();
              }
            },
            child: Icon(
              isEditing ? Icons.close : Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              isEditing ? "${selectedTracks.length} selected" : "Edit Playlist",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (!isEditing)
            GestureDetector(
              onTap: () {
                isEditing = true;
                setState(() {});
              },
              child: Text(
                "Edit",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            GestureDetector(
              onTap: () {
                isEditing = false;
                selectedTracks.clear();
                setState(() {});
              },
              child: Text(
                "Done",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaylistHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${playlistInfo["artwork"]}"),
                fit: BoxFit.cover,
              ),
              boxShadow: [shadowSm],
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${playlistInfo["name"]}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${playlistInfo["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      playlistInfo["isPrivate"] ? Icons.lock : Icons.public,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${playlistInfo["owner"]} • ${playlistInfo["tracks"]} tracks",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isEditing)
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEditingControls() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Select All",
              size: bs.sm,
              onPressed: () {
                if (selectedTracks.length == tracks.length) {
                  selectedTracks.clear();
                } else {
                  selectedTracks = tracks.map((track) => track["id"] as String).toList();
                }
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Remove",
              size: bs.sm,
              onPressed: selectedTracks.isNotEmpty ? () async {
                bool isConfirmed = await confirm("Remove ${selectedTracks.length} track${selectedTracks.length > 1 ? 's' : ''} from playlist?");
                if (isConfirmed) {
                  tracks.removeWhere((track) => selectedTracks.contains(track["id"]));
                  selectedTracks.clear();
                  setState(() {});
                  ss("Tracks removed from playlist");
                }
              } : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(spMd, 0, spMd, spMd),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search in playlist",
                        hintStyle: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  if (searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        searchQuery = "";
                        setState(() {});
                      },
                      child: Icon(
                        Icons.clear,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(width: spMd),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.sort,
                color: disabledBoldColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTracksList() {
    return Container(
      color: Colors.white,
      child: filteredTracks.isEmpty 
        ? _buildEmptyState()
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredTracks.length,
            itemBuilder: (context, index) {
              final track = filteredTracks[index];
              final trackId = track["id"] as String;
              final isSelected = selectedTracks.contains(trackId);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: GestureDetector(
                  onTap: () {
                    if (isEditing) {
                      if (isSelected) {
                        selectedTracks.remove(trackId);
                      } else {
                        selectedTracks.add(trackId);
                      }
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(26) : disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: isSelected ? Border.all(color: primaryColor, width: 1) : null,
                    ),
                    child: Row(
                      children: [
                        if (isEditing)
                          Container(
                            margin: EdgeInsets.only(right: spSm),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: isSelected 
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                : null,
                            ),
                          ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${track["artwork"]}"),
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
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${track["artist"]} • ${track["album"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Added ${_formatDate(track["addedDate"])}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isEditing) ...[
                          GestureDetector(
                            onTap: () {
                              track["isLiked"] = !(track["isLiked"] as bool);
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              child: Icon(
                                (track["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                                color: (track["isLiked"] as bool) ? Colors.red : disabledBoldColor,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${track["duration"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () => _showTrackOptions(track),
                            child: Icon(
                              Icons.more_vert,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ] else ...[
                          Text(
                            "${track["duration"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            color: disabledBoldColor,
            size: 64,
          ),
          SizedBox(height: spMd),
          Text(
            "No tracks found",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Try searching with different keywords",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    int daysDiff = now.difference(date).inDays;
    
    if (daysDiff == 0) return "today";
    if (daysDiff == 1) return "yesterday";
    if (daysDiff < 7) return "$daysDiff days ago";
    if (daysDiff < 30) return "${(daysDiff / 7).floor()} weeks ago";
    return "${(daysDiff / 30).floor()} months ago";
  }

  void _showTrackOptions(Map<String, dynamic> track) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${track["artwork"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${track["title"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${track["artist"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Column(
                children: [
                  _buildOptionItem(Icons.play_arrow, "Play", () {}),
                  _buildOptionItem(Icons.playlist_add, "Add to playlist", () {}),
                  _buildOptionItem(Icons.album, "Go to album", () {}),
                  _buildOptionItem(Icons.person, "Go to artist", () {}),
                  _buildOptionItem(Icons.share, "Share", () {}),
                  _buildOptionItem(
                    Icons.remove_circle_outline, 
                    "Remove from playlist", 
                    () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Remove \"${track["title"]}\" from playlist?");
                      if (isConfirmed) {
                        tracks.removeWhere((t) => t["id"] == track["id"]);
                        setState(() {});
                        ss("Track removed from playlist");
                      }
                    },
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(height: spMd),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionItem(IconData icon, String label, VoidCallback onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spMd),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? Colors.black,
              size: 24,
            ),
            SizedBox(width: spMd),
            Text(
              label,
              style: TextStyle(
                color: color ?? Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
