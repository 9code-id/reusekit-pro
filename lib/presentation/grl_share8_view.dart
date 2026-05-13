import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShare8View extends StatefulWidget {
  @override
  State<GrlShare8View> createState() => _GrlShare8ViewState();
}

class _GrlShare8ViewState extends State<GrlShare8View> {
  String selectedAudio = "";
  String audioTitle = "";
  String audioDescription = "";
  String selectedGenre = "podcast";
  String selectedCover = "";
  bool isPublic = true;
  bool allowDownload = false;
  bool enableComments = true;
  List<String> audioTags = [];
  String currentTag = "";
  String selectedCategory = "education";
  String episodeNumber = "";
  String duration = "";

  final List<Map<String, dynamic>> genres = [
    {"label": "Podcast", "value": "podcast", "icon": Icons.podcasts},
    {"label": "Music", "value": "music", "icon": Icons.music_note},
    {"label": "Audiobook", "value": "audiobook", "icon": Icons.menu_book},
    {"label": "Interview", "value": "interview", "icon": Icons.record_voice_over},
    {"label": "Educational", "value": "educational", "icon": Icons.school},
    {"label": "News", "value": "news", "icon": Icons.newspaper},
    {"label": "Comedy", "value": "comedy", "icon": Icons.sentiment_very_satisfied},
    {"label": "Story", "value": "story", "icon": Icons.auto_stories},
  ];

  final List<Map<String, dynamic>> categories = [
    {"label": "Education", "value": "education"},
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Health", "value": "health"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Sports", "value": "sports"},
    {"label": "Science", "value": "science"},
    {"label": "Arts", "value": "arts"},
  ];

  final List<Map<String, dynamic>> uploadProgress = [
    {"step": "Uploading Audio", "status": "completed", "progress": 100},
    {"step": "Processing", "status": "in_progress", "progress": 75},
    {"step": "Generating Waveform", "status": "pending", "progress": 0},
    {"step": "Publishing", "status": "pending", "progress": 0},
  ];

  final List<Map<String, dynamic>> recentAudios = [
    {
      "title": "Flutter Development Tips",
      "cover": "https://picsum.photos/300/300?random=1&keyword=podcast",
      "duration": "45:30",
      "listens": 1250,
      "likes": 89,
      "date": "2024-01-15",
      "genre": "podcast",
      "category": "technology"
    },
    {
      "title": "Morning Meditation Session",
      "cover": "https://picsum.photos/300/300?random=2&keyword=meditation",
      "duration": "20:15",
      "listens": 856,
      "likes": 124,
      "date": "2024-01-12",
      "genre": "educational",
      "category": "health"
    },
    {
      "title": "Business Strategy Podcast",
      "cover": "https://picsum.photos/300/300?random=3&keyword=business",
      "duration": "38:45",
      "listens": 2100,
      "likes": 245,
      "date": "2024-01-10",
      "genre": "podcast",
      "category": "business"
    },
  ];

  final List<Map<String, dynamic>> popularTags = [
    {"name": "podcast", "count": 1200},
    {"name": "education", "count": 890},
    {"name": "technology", "count": 650},
    {"name": "interview", "count": 420},
    {"name": "motivation", "count": 380},
    {"name": "startup", "count": 320},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Audio"),
        actions: [
          QButton(
            label: "Publish",
            size: bs.sm,
            onPressed: () {
              _publishAudio();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAudioUpload(),
            _buildUploadProgress(),
            _buildAudioDetails(),
            _buildCoverArt(),
            _buildGenreAndCategory(),
            _buildAudioTags(),
            _buildAudioSettings(),
            _buildPopularTags(),
            _buildRecentAudios(),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioUpload() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Audio",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QAttachmentPicker(
            label: "Choose Audio File",
            value: selectedAudio.isNotEmpty ? [selectedAudio] : [],
            hint: "Select audio file to upload",
            allowedTypes: ['audio'],
            maxAttachments: 1,
            onChanged: (value) {
              selectedAudio = value.isNotEmpty ? value[0] : "";
              setState(() {});
            },
          ),
          if (selectedAudio.isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.audiotrack,
                    color: successColor,
                    size: 40,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "audio.mp3",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "25.6 MB • 45:30 duration • 128kbps",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      _previewAudio();
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      selectedAudio = "";
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUploadProgress() {
    if (selectedAudio.isEmpty) return Container();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...uploadProgress.map((step) => _buildProgressStep(step)).toList(),
        ],
      ),
    );
  }

  Widget _buildProgressStep(Map<String, dynamic> step) {
    Color statusColor;
    IconData statusIcon;
    
    switch (step["status"]) {
      case "completed":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "in_progress":
        statusColor = warningColor;
        statusIcon = Icons.radio_button_checked;
        break;
      default:
        statusColor = disabledColor;
        statusIcon = Icons.radio_button_unchecked;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${step["step"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (step["status"] == "in_progress") ...[
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (step["progress"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${step["progress"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioDetails() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Audio Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Audio Title",
            value: audioTitle,
            hint: "Enter an engaging title",
            onChanged: (value) {
              audioTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Description",
            value: audioDescription,
            hint: "Describe your audio content...",
            onChanged: (value) {
              audioDescription = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Episode Number (Optional)",
                  value: episodeNumber,
                  hint: "e.g., Episode 1",
                  onChanged: (value) {
                    episodeNumber = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Duration",
                  value: duration,
                  hint: "e.g., 45:30",
                  onChanged: (value) {
                    duration = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoverArt() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cover Art",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              if (selectedCover.isNotEmpty) ...[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "https://picsum.photos/100/100?random=1&keyword=podcast",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
              ],
              Expanded(
                child: QImagePicker(
                  label: "Upload Cover Image",
                  value: selectedCover,
                  hint: "Upload square image (1400x1400 recommended)",
                  onChanged: (value) {
                    selectedCover = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Auto-generated Covers",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: List.generate(4, (index) {
              return GestureDetector(
                onTap: () {
                  selectedCover = "auto_$index";
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: selectedCover == "auto_$index" ? primaryColor : disabledOutlineBorderColor,
                      width: selectedCover == "auto_$index" ? 3 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        "https://picsum.photos/80/80?random=${index + 10}&keyword=cover",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreAndCategory() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Genre & Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Select Genre",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: genres.map((genre) {
              bool isSelected = selectedGenre == genre["value"];
              return GestureDetector(
                onTap: () {
                  selectedGenre = genre["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        genre["icon"],
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${genre["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Category",
            items: categories,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAudioTags() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tags",
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
                child: QTextField(
                  label: "Add Tag",
                  value: currentTag,
                  hint: "Enter tag to improve discoverability",
                  onChanged: (value) {
                    currentTag = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: currentTag.isNotEmpty ? () {
                  if (!audioTags.contains(currentTag) && audioTags.length < 10) {
                    audioTags.add(currentTag);
                    currentTag = "";
                    setState(() {});
                  }
                } : null,
              ),
            ],
          ),
          if (audioTags.isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: audioTags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXl),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "#$tag",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () {
                          audioTags.remove(tag);
                          setState(() {});
                        },
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spXs),
            Text(
              "${audioTags.length}/10 tags",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAudioSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Audio Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Make Public",
                "value": "public",
                "checked": isPublic,
              }
            ],
            value: isPublic ? [{"label": "Make Public", "value": "public", "checked": true}] : [],
            onChanged: (values, ids) {
              isPublic = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Allow Download",
                "value": "download",
                "checked": allowDownload,
              }
            ],
            value: allowDownload ? [{"label": "Allow Download", "value": "download", "checked": true}] : [],
            onChanged: (values, ids) {
              allowDownload = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Enable Comments",
                "value": "comments",
                "checked": enableComments,
              }
            ],
            value: enableComments ? [{"label": "Enable Comments", "value": "comments", "checked": true}] : [],
            onChanged: (values, ids) {
              enableComments = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPopularTags() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
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
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: popularTags.map((tag) {
              return GestureDetector(
                onTap: () {
                  if (!audioTags.contains(tag["name"]) && audioTags.length < 10) {
                    audioTags.add(tag["name"]);
                    setState(() {});
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusXl),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "#${tag["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${tag["count"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildRecentAudios() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                "Recent Audios",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...recentAudios.map((audio) => _buildAudioItem(audio)).toList(),
        ],
      ),
    );
  }

  Widget _buildAudioItem(Map<String, dynamic> audio) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Container(
                  width: 60,
                  height: 60,
                  child: Image.network(
                    "${audio["cover"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(200),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${audio["duration"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${audio["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${audio["genre"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.headphones, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${audio["listens"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.favorite, size: 12, color: Colors.red),
                    SizedBox(width: spXs),
                    Text(
                      "${audio["likes"]}",
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
          QButton(
            icon: Icons.play_arrow,
            size: bs.sm,
            onPressed: () {
              _playAudio(audio);
            },
          ),
        ],
      ),
    );
  }

  void _previewAudio() {
    si("Playing audio preview");
  }

  void _playAudio(Map<String, dynamic> audio) {
    si("Playing: ${audio["title"]}");
  }

  void _publishAudio() {
    if (selectedAudio.isEmpty) {
      se("Please select an audio file");
      return;
    }

    if (audioTitle.isEmpty) {
      se("Please add audio title");
      return;
    }

    if (audioDescription.isEmpty) {
      se("Please add audio description");
      return;
    }

    if (selectedCover.isEmpty) {
      se("Please select cover art");
      return;
    }

    ss("Audio published successfully!");
  }
}
