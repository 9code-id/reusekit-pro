import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter6View extends StatefulWidget {
  @override
  State<GrlFilter6View> createState() => _GrlFilter6ViewState();
}

class _GrlFilter6ViewState extends State<GrlFilter6View> {
  String selectedGenre = "";
  String selectedPlatform = "";
  String selectedRating = "";
  String selectedYear = "";
  String selectedLanguage = "";
  List<String> selectedMoods = [];
  List<String> selectedActors = [];
  String selectedDuration = "";
  String selectedQuality = "";
  bool withSubtitles = false;
  bool recentlyAdded = false;
  bool trending = false;
  bool awardWinning = false;

  List<Map<String, dynamic>> genreItems = [
    {"label": "All Genres", "value": ""},
    {"label": "Action", "value": "action"},
    {"label": "Comedy", "value": "comedy"},
    {"label": "Drama", "value": "drama"},
    {"label": "Horror", "value": "horror"},
    {"label": "Romance", "value": "romance"},
    {"label": "Thriller", "value": "thriller"},
    {"label": "Sci-Fi", "value": "scifi"},
    {"label": "Documentary", "value": "documentary"},
    {"label": "Animation", "value": "animation"},
    {"label": "Fantasy", "value": "fantasy"},
  ];

  List<Map<String, dynamic>> platformItems = [
    {"label": "All Platforms", "value": ""},
    {"label": "Netflix", "value": "netflix"},
    {"label": "Amazon Prime", "value": "prime"},
    {"label": "Disney+", "value": "disney"},
    {"label": "HBO Max", "value": "hbo"},
    {"label": "Hulu", "value": "hulu"},
    {"label": "Apple TV+", "value": "apple"},
    {"label": "Paramount+", "value": "paramount"},
    {"label": "YouTube Premium", "value": "youtube"},
  ];

  List<Map<String, dynamic>> ratingItems = [
    {"label": "Any Rating", "value": ""},
    {"label": "G - General", "value": "g"},
    {"label": "PG - Parental Guidance", "value": "pg"},
    {"label": "PG-13 - Parents Cautioned", "value": "pg13"},
    {"label": "R - Restricted", "value": "r"},
    {"label": "NC-17 - Adults Only", "value": "nc17"},
  ];

  List<Map<String, dynamic>> yearItems = [
    {"label": "Any Year", "value": ""},
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
    {"label": "2020s", "value": "2020s"},
    {"label": "2010s", "value": "2010s"},
    {"label": "2000s", "value": "2000s"},
    {"label": "1990s", "value": "1990s"},
    {"label": "Before 1990", "value": "before_1990"},
  ];

  List<Map<String, dynamic>> languageItems = [
    {"label": "Any Language", "value": ""},
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Italian", "value": "italian"},
    {"label": "Japanese", "value": "japanese"},
    {"label": "Korean", "value": "korean"},
    {"label": "Mandarin", "value": "mandarin"},
  ];

  List<Map<String, dynamic>> durationItems = [
    {"label": "Any Duration", "value": ""},
    {"label": "Short (< 90 min)", "value": "short"},
    {"label": "Medium (90-120 min)", "value": "medium"},
    {"label": "Long (120-180 min)", "value": "long"},
    {"label": "Very Long (> 180 min)", "value": "very_long"},
  ];

  List<Map<String, dynamic>> qualityItems = [
    {"label": "Any Quality", "value": ""},
    {"label": "4K Ultra HD", "value": "4k"},
    {"label": "Full HD (1080p)", "value": "1080p"},
    {"label": "HD (720p)", "value": "720p"},
    {"label": "Standard Definition", "value": "sd"},
  ];

  List<String> moodsList = [
    "Feel Good",
    "Dark & Gritty",
    "Lighthearted",
    "Intense",
    "Emotional",
    "Suspenseful",
    "Funny",
    "Romantic",
    "Adventurous",
    "Mind-bending",
    "Inspirational",
    "Nostalgic",
  ];

  List<String> actorsList = [
    "Tom Hanks",
    "Meryl Streep",
    "Leonardo DiCaprio",
    "Jennifer Lawrence",
    "Denzel Washington",
    "Scarlett Johansson",
    "Robert Downey Jr.",
    "Emma Stone",
    "Ryan Gosling",
    "Margot Robbie",
    "Brad Pitt",
    "Natalie Portman",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie & TV Filters"),
        actions: [
          GestureDetector(
            onTap: () {
              _resetFilters();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Genre and Platform
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Genre",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Genre",
                        items: genreItems,
                        value: selectedGenre,
                        onChanged: (value, label) {
                          selectedGenre = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Platform",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Platform",
                        items: platformItems,
                        value: selectedPlatform,
                        onChanged: (value, label) {
                          selectedPlatform = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Rating and Year
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rating",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Rating",
                        items: ratingItems,
                        value: selectedRating,
                        onChanged: (value, label) {
                          selectedRating = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Release Year",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Year",
                        items: yearItems,
                        value: selectedYear,
                        onChanged: (value, label) {
                          selectedYear = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Language and Duration
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Language",
                        items: languageItems,
                        value: selectedLanguage,
                        onChanged: (value, label) {
                          selectedLanguage = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Duration",
                        items: durationItems,
                        value: selectedDuration,
                        onChanged: (value, label) {
                          selectedDuration = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Quality
            Text(
              "Video Quality",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Quality",
              items: qualityItems,
              value: selectedQuality,
              onChanged: (value, label) {
                selectedQuality = value;
                setState(() {});
              },
            ),

            // Special Features
            Text(
              "Special Features",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "With Subtitles",
                        "value": true,
                        "checked": withSubtitles,
                      }
                    ],
                    value: [
                      if (withSubtitles)
                        {"label": "With Subtitles", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      withSubtitles = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Recently Added",
                        "value": true,
                        "checked": recentlyAdded,
                      }
                    ],
                    value: [
                      if (recentlyAdded)
                        {"label": "Recently Added", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      recentlyAdded = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Trending Now",
                        "value": true,
                        "checked": trending,
                      }
                    ],
                    value: [
                      if (trending)
                        {"label": "Trending Now", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      trending = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Award Winning",
                        "value": true,
                        "checked": awardWinning,
                      }
                    ],
                    value: [
                      if (awardWinning)
                        {"label": "Award Winning", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      awardWinning = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Mood Selection
            Text(
              "Mood",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
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
                    "What mood are you in?",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: moodsList.map((mood) {
                      bool isSelected = selectedMoods.contains(mood);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedMoods.remove(mood);
                          } else {
                            selectedMoods.add(mood);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            mood,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Favorite Actors
            Text(
              "Favorite Actors",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
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
                    "Select your favorite actors:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: actorsList.map((actor) {
                      bool isSelected = selectedActors.contains(actor);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedActors.remove(actor);
                          } else {
                            selectedActors.add(actor);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? warningColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? warningColor : Colors.grey.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            actor,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Apply Filter Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  _applyFilters();
                },
              ),
            ),

            SizedBox(height: spSm),

            // Clear Filters Button
            Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _resetFilters();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Center(
                    child: Text(
                      "Clear All Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    Map<String, dynamic> filters = {
      'genre': selectedGenre,
      'platform': selectedPlatform,
      'rating': selectedRating,
      'year': selectedYear,
      'language': selectedLanguage,
      'duration': selectedDuration,
      'quality': selectedQuality,
      'moods': selectedMoods,
      'actors': selectedActors,
      'withSubtitles': withSubtitles,
      'recentlyAdded': recentlyAdded,
      'trending': trending,
      'awardWinning': awardWinning,
    };

    ss("Movie & TV filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedGenre = "";
    selectedPlatform = "";
    selectedRating = "";
    selectedYear = "";
    selectedLanguage = "";
    selectedDuration = "";
    selectedQuality = "";
    selectedMoods.clear();
    selectedActors.clear();
    withSubtitles = false;
    recentlyAdded = false;
    trending = false;
    awardWinning = false;
    setState(() {});
  }
}
