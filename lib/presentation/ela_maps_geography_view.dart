import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaMapsGeographyView extends StatefulWidget {
  const ElaMapsGeographyView({super.key});

  @override
  State<ElaMapsGeographyView> createState() => _ElaMapsGeographyViewState();
}

class _ElaMapsGeographyViewState extends State<ElaMapsGeographyView> {
  String selectedContinent = "All";
  String selectedMapType = "Political";
  String searchQuery = "";
  bool loading = false;
  int currentQuestionIndex = 0;
  bool showQuiz = false;

  List<Map<String, dynamic>> continents = [
    {"label": "All", "value": "All"},
    {"label": "Asia", "value": "Asia"},
    {"label": "Europe", "value": "Europe"},
    {"label": "North America", "value": "North America"},
    {"label": "South America", "value": "South America"},
    {"label": "Africa", "value": "Africa"},
    {"label": "Oceania", "value": "Oceania"},
  ];

  List<Map<String, dynamic>> mapTypes = [
    {"label": "Political", "value": "Political"},
    {"label": "Physical", "value": "Physical"},
    {"label": "Climate", "value": "Climate"},
    {"label": "Population", "value": "Population"},
  ];

  List<Map<String, dynamic>> countries = [
    {
      "name": "Indonesia",
      "continent": "Asia",
      "capital": "Jakarta",
      "population": 273523615,
      "area": 1904569,
      "currency": "Indonesian Rupiah",
      "language": "Indonesian",
      "flag": "https://picsum.photos/200/120?random=1&keyword=indonesia",
      "mapImage": "https://picsum.photos/400/300?random=101&keyword=indonesia",
      "coordinates": {"lat": -6.2088, "lng": 106.8456},
      "facts": [
        "World's largest archipelago",
        "Over 17,000 islands",
        "Fourth most populous country",
        "Home to Komodo dragons"
      ],
      "climate": "Tropical",
      "timeZone": "WIB, WITA, WIT",
    },
    {
      "name": "Japan",
      "continent": "Asia",
      "capital": "Tokyo",
      "population": 125836021,
      "area": 377975,
      "currency": "Japanese Yen",
      "language": "Japanese",
      "flag": "https://picsum.photos/200/120?random=2&keyword=japan",
      "mapImage": "https://picsum.photos/400/300?random=102&keyword=japan",
      "coordinates": {"lat": 35.6762, "lng": 139.6503},
      "facts": [
        "Land of the Rising Sun",
        "Over 6,800 islands",
        "Technology innovation hub",
        "Rich cultural heritage"
      ],
      "climate": "Temperate",
      "timeZone": "JST",
    },
    {
      "name": "Germany",
      "continent": "Europe",
      "capital": "Berlin",
      "population": 83783942,
      "area": 357022,
      "currency": "Euro",
      "language": "German",
      "flag": "https://picsum.photos/200/120?random=3&keyword=germany",
      "mapImage": "https://picsum.photos/400/300?random=103&keyword=germany",
      "coordinates": {"lat": 52.5200, "lng": 13.4050},
      "facts": [
        "Economic powerhouse of Europe",
        "Birthplace of many innovations",
        "Rich history and culture",
        "Environmental leader"
      ],
      "climate": "Temperate",
      "timeZone": "CET",
    },
    {
      "name": "Brazil",
      "continent": "South America",
      "capital": "Brasília",
      "population": 212559417,
      "area": 8514877,
      "currency": "Brazilian Real",
      "language": "Portuguese",
      "flag": "https://picsum.photos/200/120?random=4&keyword=brazil",
      "mapImage": "https://picsum.photos/400/300?random=104&keyword=brazil",
      "coordinates": {"lat": -15.8267, "lng": -47.9218},
      "facts": [
        "Largest country in South America",
        "Amazon rainforest",
        "Famous for football",
        "Diverse culture and music"
      ],
      "climate": "Tropical/Subtropical",
      "timeZone": "BRT",
    },
    {
      "name": "Egypt",
      "continent": "Africa",
      "capital": "Cairo",
      "population": 102334404,
      "area": 1001449,
      "currency": "Egyptian Pound",
      "language": "Arabic",
      "flag": "https://picsum.photos/200/120?random=5&keyword=egypt",
      "mapImage": "https://picsum.photos/400/300?random=105&keyword=egypt",
      "coordinates": {"lat": 30.0444, "lng": 31.2357},
      "facts": [
        "Ancient civilization",
        "Great Pyramids of Giza",
        "Nile River",
        "Rich archaeological heritage"
      ],
      "climate": "Desert",
      "timeZone": "EET",
    },
    {
      "name": "Australia",
      "continent": "Oceania",
      "capital": "Canberra",
      "population": 25499884,
      "area": 7692024,
      "currency": "Australian Dollar",
      "language": "English",
      "flag": "https://picsum.photos/200/120?random=6&keyword=australia",
      "mapImage": "https://picsum.photos/400/300?random=106&keyword=australia",
      "coordinates": {"lat": -35.2809, "lng": 149.1300},
      "facts": [
        "Island continent",
        "Unique wildlife",
        "Great Barrier Reef",
        "Diverse landscapes"
      ],
      "climate": "Varied",
      "timeZone": "Multiple",
    },
  ];

  List<Map<String, dynamic>> quizQuestions = [
    {
      "question": "What is the capital of Indonesia?",
      "options": ["Jakarta", "Surabaya", "Bandung", "Medan"],
      "correctAnswer": 0,
      "explanation": "Jakarta is the capital and largest city of Indonesia."
    },
    {
      "question": "Which continent has the largest population?",
      "options": ["Africa", "Europe", "Asia", "North America"],
      "correctAnswer": 2,
      "explanation": "Asia is the most populous continent with over 4.5 billion people."
    },
    {
      "question": "What is the largest country by area?",
      "options": ["Canada", "China", "USA", "Russia"],
      "correctAnswer": 3,
      "explanation": "Russia is the largest country by land area, covering over 17 million square kilometers."
    },
  ];

  List<Map<String, dynamic>> get filteredCountries {
    return countries.where((country) {
      bool continentMatch = selectedContinent == "All" || country["continent"] == selectedContinent;
      bool searchMatch = searchQuery.isEmpty ||
          country["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          country["capital"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return continentMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("World Geography"),
        actions: [
          IconButton(
            icon: Icon(Icons.quiz),
            onPressed: () {
              showQuiz = true;
              currentQuestionIndex = 0;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Navigate to interactive map
            },
          ),
        ],
      ),
      body: showQuiz ? _buildQuizView() : _buildMainView(),
    );
  }

  Widget _buildMainView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.public,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore the World",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Discover countries, capitals, and geographical features",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Search & Filter",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QTextField(
                  label: "Search countries or capitals...",
                  value: searchQuery,
                  hint: "Enter country or capital name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Continent",
                        items: continents,
                        value: selectedContinent,
                        onChanged: (value, label) {
                          selectedContinent = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Map Type",
                        items: mapTypes,
                        value: selectedMapType,
                        onChanged: (value, label) {
                          selectedMapType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Statistics Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${filteredCountries.length}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Countries",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${continents.length - 1}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Continents",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${((filteredCountries.map((c) => c["population"] as int).reduce((a, b) => a + b)) / 1000000).toInt()}M",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Population",
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
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Take Quiz",
                        icon: Icons.quiz,
                        size: bs.sm,
                        onPressed: () {
                          showQuiz = true;
                          currentQuestionIndex = 0;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "World Map",
                        icon: Icons.map,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to interactive map
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Countries Grid
          Text(
            "Countries (${filteredCountries.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredCountries.map((country) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Flag and Map
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${country["mapImage"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: spXs,
                          right: spXs,
                          child: Container(
                            width: 40,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              boxShadow: [shadowSm],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusXs),
                              child: Image.network(
                                "${country["flag"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: spXs,
                          left: spXs,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${country["continent"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${country["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${country["capital"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${((country["population"] as int) / 1000000).toStringAsFixed(1)}M",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.square_foot,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${((country["area"] as int) / 1000).toStringAsFixed(0)}K km²",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.language,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${country["language"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                _showCountryDetails(country);
                              },
                            ),
                          ),
                        ],
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

  Widget _buildQuizView() {
    final question = quizQuestions[currentQuestionIndex];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  showQuiz = false;
                  setState(() {});
                },
              ),
              Expanded(
                child: Text(
                  "Geography Quiz",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "${currentQuestionIndex + 1}/${quizQuestions.length}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Progress
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (currentQuestionIndex + 1) / quizQuestions.length,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),

          // Question
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "${question["question"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...List.generate(question["options"].length, (index) {
                  return GestureDetector(
                    onTap: () {
                      _handleQuizAnswer(index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                String.fromCharCode(65 + index),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${question["options"][index]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleQuizAnswer(int selectedIndex) {
    final question = quizQuestions[currentQuestionIndex];
    bool isCorrect = selectedIndex == question["correctAnswer"];
    
    // Show result dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? "Correct!" : "Incorrect"),
        content: Text("${question["explanation"]}"),
        actions: [
          QButton(
            label: "Continue",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              if (currentQuestionIndex < quizQuestions.length - 1) {
                currentQuestionIndex++;
                setState(() {});
              } else {
                // Quiz completed
                showQuiz = false;
                setState(() {});
                ss("Quiz completed!");
              }
            },
          ),
        ],
      ),
    );
  }

  void _showCountryDetails(Map<String, dynamic> country) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXs),
                            boxShadow: [shadowSm],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${country["flag"]}",
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
                                "${country["name"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${country["continent"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Map
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${country["mapImage"]}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    // Basic Info
                    _buildInfoSection("Basic Information", [
                      {"label": "Capital", "value": "${country["capital"]}"},
                      {"label": "Population", "value": "${((country["population"] as int) / 1000000).toStringAsFixed(1)}M people"},
                      {"label": "Area", "value": "${((country["area"] as int) / 1000).toStringAsFixed(0)}K km²"},
                      {"label": "Currency", "value": "${country["currency"]}"},
                      {"label": "Language", "value": "${country["language"]}"},
                      {"label": "Climate", "value": "${country["climate"]}"},
                      {"label": "Time Zone", "value": "${country["timeZone"]}"},
                    ]),

                    // Interesting Facts
                    Container(
                      padding: EdgeInsets.all(spSm),
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
                            "Interesting Facts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...((country["facts"] as List).map((fact) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  margin: EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "$fact",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList()),
                        ],
                      ),
                    ),

                    // Close Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Close",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
  }

  Widget _buildInfoSection(String title, List<Map<String, String>> info) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...info.map((item) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    "${item["label"]}:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${item["value"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
