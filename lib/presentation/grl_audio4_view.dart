import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAudio4View extends StatefulWidget {
  @override
  State<GrlAudio4View> createState() => _GrlAudio4ViewState();
}

class _GrlAudio4ViewState extends State<GrlAudio4View> {
  String selectedCategory = "Popular";
  String searchQuery = "";
  int currentPlayingIndex = -1;
  bool isPlaying = false;
  double playbackPosition = 0.0;

  List<Map<String, dynamic>> categories = [
    {"label": "Popular", "value": "Popular"},
    {"label": "Recent", "value": "Recent"},
    {"label": "Trending", "value": "Trending"},
    {"label": "Favorites", "value": "Favorites"},
  ];

  List<Map<String, dynamic>> audioBooks = [
    {
      "title": "The Psychology of Money",
      "author": "Morgan Housel",
      "duration": "5h 42m",
      "progress": 0.65,
      "cover": "https://picsum.photos/120/120?random=1&keyword=book",
      "rating": 4.8,
      "downloads": 125000,
      "category": "Finance",
      "description": "Timeless lessons on wealth, greed, and happiness doing well with money isn't necessarily about what you know."
    },
    {
      "title": "Atomic Habits",
      "author": "James Clear",
      "duration": "5h 35m",
      "progress": 0.32,
      "cover": "https://picsum.photos/120/120?random=2&keyword=book",
      "rating": 4.9,
      "downloads": 200000,
      "category": "Self Help",
      "description": "An Easy & Proven Way to Build Good Habits & Break Bad Ones"
    },
    {
      "title": "The Midnight Library",
      "author": "Matt Haig",
      "duration": "8h 15m",
      "progress": 0.0,
      "cover": "https://picsum.photos/120/120?random=3&keyword=book",
      "rating": 4.6,
      "downloads": 98000,
      "category": "Fiction",
      "description": "Between life and death there is a library, and within that library, the shelves go on forever."
    },
    {
      "title": "Educated",
      "author": "Tara Westover",
      "duration": "12h 10m",
      "progress": 0.78,
      "cover": "https://picsum.photos/120/120?random=4&keyword=book",
      "rating": 4.7,
      "downloads": 156000,
      "category": "Biography",
      "description": "A memoir about a young girl who, kept out of school, leaves her survivalist family and goes on to earn a PhD from Cambridge University."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.queue_music),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            _buildCategoryFilter(),
            _buildNowPlayingCard(),
            _buildLibraryStats(),
            _buildAudioBooksList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search audiobooks...",
            value: searchQuery,
            hint: "Title, author, or genre",
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
    );
  }

  Widget _buildCategoryFilter() {
    return QCategoryPicker(
      label: "Browse Categories",
      items: categories,
      value: selectedCategory,
      onChanged: (index, label, value, item) {
        selectedCategory = value;
        setState(() {});
      },
    );
  }

  Widget _buildNowPlayingCard() {
    if (currentPlayingIndex == -1) return SizedBox.shrink();

    final book = audioBooks[currentPlayingIndex];
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withAlpha(20),
            secondaryColor.withAlpha(10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${book["cover"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Now Playing",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${book["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${book["author"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 40,
                  color: primaryColor,
                ),
                onPressed: () {
                  isPlaying = !isPlaying;
                  setState(() {});
                },
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${(playbackPosition * 100).toInt()}% complete",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${book["duration"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: playbackPosition,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                minHeight: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryStats() {
    return Row(
      children: [
        _buildStatCard("Total Books", "2,543", Icons.library_books),
        SizedBox(width: spSm),
        _buildStatCard("Hours Listened", "432h", Icons.headphones),
        SizedBox(width: spSm),
        _buildStatCard("Completed", "87", Icons.check_circle),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioBooksList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Library",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ...List.generate(audioBooks.length, (index) {
          final book = audioBooks[index];
          return _buildAudioBookCard(book, index);
        }),
      ],
    );
  }

  Widget _buildAudioBookCard(Map<String, dynamic> book, int index) {
    final isCurrentlyPlaying = currentPlayingIndex == index;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isCurrentlyPlaying ? primaryColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isCurrentlyPlaying 
          ? Border.all(color: primaryColor.withAlpha(50), width: 1)
          : null,
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${book["cover"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${book["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${book["author"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: warningColor,
                        ),
                        Text(
                          "${book["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${book["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${book["description"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if ((book["progress"] as double) > 0) ...[
            Column(
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${((book["progress"] as double) * 100).toInt()}% completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${book["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: book["progress"] as double,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  minHeight: 3,
                ),
              ],
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QButton(
                label: isCurrentlyPlaying ? "Pause" : "Play",
                icon: isCurrentlyPlaying ? Icons.pause : Icons.play_arrow,
                size: bs.sm,
                onPressed: () {
                  if (isCurrentlyPlaying) {
                    currentPlayingIndex = -1;
                    isPlaying = false;
                  } else {
                    currentPlayingIndex = index;
                    isPlaying = true;
                    playbackPosition = book["progress"] as double;
                  }
                  setState(() {});
                },
              ),
              QButton(
                label: "Download",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
              QButton(
                label: "Share",
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
