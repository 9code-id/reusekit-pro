import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVideo8View extends StatefulWidget {
  @override
  State<GrlVideo8View> createState() => _GrlVideo8ViewState();
}

class _GrlVideo8ViewState extends State<GrlVideo8View> {
  int selectedChannel = 0;
  String selectedGenre = "All";
  bool isLive = false;

  List<Map<String, dynamic>> genres = [
    {"label": "All", "value": "All"},
    {"label": "News", "value": "News"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Movies", "value": "Movies"},
    {"label": "Documentary", "value": "Documentary"},
    {"label": "Music", "value": "Music"},
    {"label": "Kids", "value": "Kids"},
  ];

  List<Map<String, dynamic>> channels = [
    {
      "id": "1",
      "name": "Global News Network",
      "logo": "https://picsum.photos/80/80?random=81&keyword=news",
      "currentShow": "Breaking News Live",
      "genre": "News",
      "viewers": 125000,
      "isLive": true,
      "thumbnail": "https://picsum.photos/400/300?random=181&keyword=news",
      "description": "Stay updated with the latest breaking news and current affairs from around the world.",
      "schedule": [
        {"time": "6:00 AM", "show": "Morning Update", "duration": "30 min"},
        {"time": "12:00 PM", "show": "Midday Report", "duration": "60 min"},
        {"time": "6:00 PM", "show": "Evening News", "duration": "90 min"},
        {"time": "10:00 PM", "show": "Late Night Brief", "duration": "30 min"},
      ],
    },
    {
      "id": "2",
      "name": "Sports Central",
      "logo": "https://picsum.photos/80/80?random=82&keyword=sports",
      "currentShow": "Premier League Highlights",
      "genre": "Sports",
      "viewers": 89000,
      "isLive": true,
      "thumbnail": "https://picsum.photos/400/300?random=182&keyword=sports",
      "description": "Your ultimate destination for live sports coverage, highlights, and analysis.",
      "schedule": [
        {"time": "8:00 AM", "show": "Sports Morning", "duration": "120 min"},
        {"time": "2:00 PM", "show": "Live Match", "duration": "180 min"},
        {"time": "7:00 PM", "show": "Sports Tonight", "duration": "60 min"},
        {"time": "11:00 PM", "show": "Highlights Reel", "duration": "30 min"},
      ],
    },
    {
      "id": "3",
      "name": "Cinema Plus",
      "logo": "https://picsum.photos/80/80?random=83&keyword=movie",
      "currentShow": "The Dark Knight",
      "genre": "Movies",
      "viewers": 245000,
      "isLive": false,
      "thumbnail": "https://picsum.photos/400/300?random=183&keyword=movie",
      "description": "Premium movie channel featuring blockbusters, classics, and exclusive premieres.",
      "schedule": [
        {"time": "2:00 PM", "show": "Action Adventure", "duration": "120 min"},
        {"time": "4:30 PM", "show": "Comedy Special", "duration": "90 min"},
        {"time": "8:00 PM", "show": "Prime Time Movie", "duration": "150 min"},
        {"time": "11:00 PM", "show": "Late Night Classic", "duration": "105 min"},
      ],
    },
    {
      "id": "4",
      "name": "Nature Discovery",
      "logo": "https://picsum.photos/80/80?random=84&keyword=nature",
      "currentShow": "Wildlife Safari",
      "genre": "Documentary",
      "viewers": 67000,
      "isLive": true,
      "thumbnail": "https://picsum.photos/400/300?random=184&keyword=nature",
      "description": "Explore the wonders of nature with stunning documentaries and wildlife shows.",
      "schedule": [
        {"time": "6:00 AM", "show": "Planet Earth", "duration": "60 min"},
        {"time": "10:00 AM", "show": "Ocean Deep", "duration": "45 min"},
        {"time": "3:00 PM", "show": "Wildlife Safari", "duration": "90 min"},
        {"time": "9:00 PM", "show": "Space Exploration", "duration": "75 min"},
      ],
    },
    {
      "id": "5",
      "name": "Music Vibe",
      "logo": "https://picsum.photos/80/80?random=85&keyword=music",
      "currentShow": "Top Hits Live",
      "genre": "Music",
      "viewers": 156000,
      "isLive": true,
      "thumbnail": "https://picsum.photos/400/300?random=185&keyword=music",
      "description": "Non-stop music entertainment with live performances and music videos.",
      "schedule": [
        {"time": "7:00 AM", "show": "Morning Mix", "duration": "180 min"},
        {"time": "1:00 PM", "show": "Acoustic Session", "duration": "60 min"},
        {"time": "6:00 PM", "show": "Top Hits Live", "duration": "120 min"},
        {"time": "10:00 PM", "show": "Night Beats", "duration": "240 min"},
      ],
    },
    {
      "id": "6",
      "name": "Kids World",
      "logo": "https://picsum.photos/80/80?random=86&keyword=kids",
      "currentShow": "Cartoon Adventures",
      "genre": "Kids",
      "viewers": 198000,
      "isLive": false,
      "thumbnail": "https://picsum.photos/400/300?random=186&keyword=cartoon",
      "description": "Safe and educational content for children with cartoons and learning shows.",
      "schedule": [
        {"time": "6:00 AM", "show": "Early Learners", "duration": "30 min"},
        {"time": "9:00 AM", "show": "Cartoon Time", "duration": "120 min"},
        {"time": "2:00 PM", "show": "Educational Fun", "duration": "60 min"},
        {"time": "7:00 PM", "show": "Bedtime Stories", "duration": "30 min"},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredChannels {
    if (selectedGenre == "All") return channels;
    return channels.where((channel) => channel["genre"] == selectedGenre).toList();
  }

  Widget _buildLivePlayer() {
    final currentChannel = filteredChannels[selectedChannel];
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${currentChannel["thumbnail"]}"),
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
          if (currentChannel["isLive"] as bool)
            Positioned(
              top: spMd,
              left: spMd,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            top: spMd,
            right: spMd,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(179),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${((currentChannel["viewers"] as int) / 1000).toInt()}K",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                isLive = !isLive;
                setState(() {});
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(230),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLive ? Icons.pause : Icons.play_arrow,
                  color: primaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(spMd),
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
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${currentChannel["logo"]}"),
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
                          "${currentChannel["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${currentChannel["currentShow"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: currentChannel["genre"] == "News" ? infoColor :
                             currentChannel["genre"] == "Sports" ? successColor :
                             currentChannel["genre"] == "Movies" ? warningColor :
                             primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${currentChannel["genre"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelCard(Map<String, dynamic> channel, int index) {
    bool isSelected = selectedChannel == index;
    return GestureDetector(
      onTap: () {
        selectedChannel = index;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(26) : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("${channel["logo"]}"),
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
                    Row(
                      children: [
                        Text(
                          "${channel["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (channel["isLive"] as bool)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "LIVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${channel["currentShow"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: channel["genre"] == "News" ? infoColor.withAlpha(26) :
                                   channel["genre"] == "Sports" ? successColor.withAlpha(26) :
                                   channel["genre"] == "Movies" ? warningColor.withAlpha(26) :
                                   primaryColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${channel["genre"]}",
                            style: TextStyle(
                              color: channel["genre"] == "News" ? infoColor :
                                     channel["genre"] == "Sports" ? successColor :
                                     channel["genre"] == "Movies" ? warningColor :
                                     primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.visibility,
                          color: disabledBoldColor,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${((channel["viewers"] as int) / 1000).toInt()}K",
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
            ),
            Padding(
              padding: EdgeInsets.all(spSm),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.favorite_border,
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
      ),
    );
  }

  Widget _buildSchedule() {
    final currentChannel = filteredChannels[selectedChannel];
    return Container(
      margin: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusXs),
                    image: DecorationImage(
                      image: NetworkImage("${currentChannel["logo"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Today's Schedule - ${currentChannel["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: disabledColor),
          Column(
            children: (currentChannel["schedule"] as List).map((schedule) {
              bool isCurrentShow = schedule["show"] == currentChannel["currentShow"];
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isCurrentShow ? primaryColor.withAlpha(26) : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(color: disabledColor, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Text(
                        "${schedule["time"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isCurrentShow ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${schedule["show"]}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: isCurrentShow ? primaryColor : primaryColor,
                            ),
                          ),
                          Text(
                            "${schedule["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isCurrentShow)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "NOW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live TV"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.cast,
                color: primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.settings,
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
            _buildLivePlayer(),
            SizedBox(height: spMd),
            QCategoryPicker(
              label: "Genres",
              items: genres,
              value: selectedGenre,
              onChanged: (index, label, value, item) {
                selectedGenre = value;
                selectedChannel = 0;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Text(
              "Channels (${filteredChannels.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Column(
              children: filteredChannels.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> channel = entry.value;
                return _buildChannelCard(channel, index);
              }).toList(),
            ),
            _buildSchedule(),
          ],
        ),
      ),
    );
  }
}
