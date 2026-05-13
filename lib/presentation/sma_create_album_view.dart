import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaCreateAlbumView extends StatefulWidget {
  const SmaCreateAlbumView({super.key});

  @override
  State<SmaCreateAlbumView> createState() => _SmaCreateAlbumViewState();
}

class _SmaCreateAlbumViewState extends State<SmaCreateAlbumView> {
  final formKey = GlobalKey<FormState>();
  String albumTitle = "";
  String albumDescription = "";
  String albumGenre = "";
  List<String> albumTracks = [];
  String albumCover = "";
  String albumType = "Single";
  String releaseDate = "";
  bool isExplicit = false;
  String artistName = "";
  String recordLabel = "";
  List<String> collaborators = [];
  String newTrackTitle = "";

  List<Map<String, dynamic>> genreItems = [
    {"label": "Pop", "value": "Pop"},
    {"label": "Rock", "value": "Rock"},
    {"label": "Hip Hop", "value": "Hip Hop"},
    {"label": "R&B", "value": "R&B"},
    {"label": "Electronic", "value": "Electronic"},
    {"label": "Country", "value": "Country"},
    {"label": "Jazz", "value": "Jazz"},
    {"label": "Classical", "value": "Classical"},
  ];

  List<Map<String, dynamic>> albumTypeItems = [
    {"label": "Single", "value": "Single"},
    {"label": "EP", "value": "EP"},
    {"label": "Album", "value": "Album"},
    {"label": "Compilation", "value": "Compilation"},
  ];

  void _addTrack() {
    if (newTrackTitle.isNotEmpty) {
      albumTracks.add(newTrackTitle);
      newTrackTitle = "";
      setState(() {});
    }
  }

  void _removeTrack(int index) {
    albumTracks.removeAt(index);
    setState(() {});
  }

  void _createAlbum() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Album created successfully!");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Album"),
        actions: [
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: _createAlbum,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Album Cover Section
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
                    Text(
                      "Album Cover",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QImagePicker(
                      label: "Album Cover",
                      value: albumCover,
                      hint: "Select album cover image",
                      validator: Validator.required,
                      onChanged: (value) {
                        albumCover = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Basic Information Section
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
                  spacing: spSm,
                  children: [
                    Text(
                      "Basic Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Album Title",
                      value: albumTitle,
                      hint: "Enter album title",
                      validator: Validator.required,
                      onChanged: (value) {
                        albumTitle = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Album Description",
                      value: albumDescription,
                      hint: "Enter album description",
                      onChanged: (value) {
                        albumDescription = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Artist Name",
                      value: artistName,
                      hint: "Enter artist name",
                      validator: Validator.required,
                      onChanged: (value) {
                        artistName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Record Label",
                      value: recordLabel,
                      hint: "Enter record label",
                      onChanged: (value) {
                        recordLabel = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Album Details Section
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
                  spacing: spSm,
                  children: [
                    Text(
                      "Album Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Album Type",
                      items: albumTypeItems,
                      value: albumType,
                      onChanged: (value, label) {
                        albumType = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Genre",
                      items: genreItems,
                      value: albumGenre,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        albumGenre = value;
                        setState(() {});
                      },
                    ),
                    QDatePicker(
                      label: "Release Date",
                      value: releaseDate.isNotEmpty ? DateTime.parse(releaseDate) : DateTime.now(),
                      onChanged: (value) {
                        releaseDate = value.toString();
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      label: "Explicit Content",
                      items: [
                        {
                          "label": "This album contains explicit content",
                          "value": true,
                          "checked": isExplicit,
                        }
                      ],
                      value: [if (isExplicit) {"label": "This album contains explicit content", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        isExplicit = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Tracks Section
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
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Tracks",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${albumTracks.length} tracks",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Track Title",
                            value: newTrackTitle,
                            hint: "Enter track title",
                            onChanged: (value) {
                              newTrackTitle = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _addTrack,
                        ),
                      ],
                    ),
                    if (albumTracks.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      ...List.generate(albumTracks.length, (index) {
                        final track = albumTracks[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  track,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _removeTrack(index),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: dangerColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),

              // Create Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Album",
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
