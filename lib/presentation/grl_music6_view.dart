import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMusic6View extends StatefulWidget {
  @override
  State<GrlMusic6View> createState() => _GrlMusic6ViewState();
}

class _GrlMusic6ViewState extends State<GrlMusic6View> {
  String selectedGenre = "All";
  bool isGridView = false;

  List<String> genres = [
    "All",
    "Pop",
    "Rock",
    "Hip Hop",
    "Jazz",
    "Electronic",
    "Classical",
    "Country",
  ];

  List<Map<String, dynamic>> artists = [
    {
      "name": "Taylor Swift",
      "genre": "Pop",
      "followers": 89500000,
      "monthlyListeners": 85200000,
      "image": "https://picsum.photos/200/200?random=1&keyword=singer",
      "verified": true,
      "albums": 10,
      "topSong": "Anti-Hero",
    },
    {
      "name": "Drake",
      "genre": "Hip Hop",
      "followers": 78300000,
      "monthlyListeners": 82100000,
      "image": "https://picsum.photos/200/200?random=2&keyword=rapper",
      "verified": true,
      "albums": 13,
      "topSong": "God's Plan",
    },
    {
      "name": "Ed Sheeran",
      "genre": "Pop",
      "followers": 72800000,
      "monthlyListeners": 77500000,
      "image": "https://picsum.photos/200/200?random=3&keyword=musician",
      "verified": true,
      "albums": 5,
      "topSong": "Shape of You",
    },
    {
      "name": "Ariana Grande",
      "genre": "Pop",
      "followers": 67200000,
      "monthlyListeners": 71800000,
      "image": "https://picsum.photos/200/200?random=4&keyword=pop",
      "verified": true,
      "albums": 6,
      "topSong": "Thank U, Next",
    },
    {
      "name": "The Weeknd",
      "genre": "Pop",
      "followers": 63100000,
      "monthlyListeners": 69300000,
      "image": "https://picsum.photos/200/200?random=5&keyword=artist",
      "verified": true,
      "albums": 5,
      "topSong": "Blinding Lights",
    },
    {
      "name": "Billie Eilish",
      "genre": "Pop",
      "followers": 58900000,
      "monthlyListeners": 62400000,
      "image": "https://picsum.photos/200/200?random=6&keyword=indie",
      "verified": true,
      "albums": 3,
      "topSong": "Bad Guy",
    },
  ];

  List<Map<String, dynamic>> get filteredArtists {
    if (selectedGenre == "All") return artists;
    return artists.where((artist) => artist["genre"] == selectedGenre).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artists"),
        actions: [
          GestureDetector(
            onTap: () {
              isGridView = !isGridView;
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Icon(
                isGridView ? Icons.list : Icons.grid_view,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            child: QCategoryPicker(
              items: genres.map((genre) => {
                "label": genre,
                "value": genre,
              }).toList(),
              value: selectedGenre,
              onChanged: (index, label, value, item) {
                selectedGenre = value;
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredArtists.length,
      itemBuilder: (context, index) {
        final artist = filteredArtists[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${artist["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: artist["verified"] == true
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${artist["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${artist["genre"]} • ${artist["albums"]} albums",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${((artist["followers"] as int) / 1000000).toStringAsFixed(1)}M followers",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.headphones,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${((artist["monthlyListeners"] as int) / 1000000).toStringAsFixed(1)}M monthly",
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
              Column(
                children: [
                  QButton(
                    label: "Follow",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(height: spSm),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: filteredArtists.map((artist) {
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${artist["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (artist["verified"] == true)
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "${artist["name"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${artist["genre"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${((artist["followers"] as int) / 1000000).toStringAsFixed(1)}M",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "Top: ${artist["topSong"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Follow",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
