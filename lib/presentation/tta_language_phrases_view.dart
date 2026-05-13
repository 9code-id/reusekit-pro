import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaLanguagePhrasesView extends StatefulWidget {
  const TtaLanguagePhrasesView({super.key});

  @override
  State<TtaLanguagePhrasesView> createState() => _TtaLanguagePhrasesViewState();
}

class _TtaLanguagePhrasesViewState extends State<TtaLanguagePhrasesView> {
  String selectedLanguage = "Spanish";
  String selectedCategory = "Basic";
  String searchQuery = "";

  List<Map<String, dynamic>> languageItems = [
    {"label": "Spanish", "value": "Spanish"},
    {"label": "French", "value": "French"},
    {"label": "German", "value": "German"},
    {"label": "Italian", "value": "Italian"},
    {"label": "Portuguese", "value": "Portuguese"},
    {"label": "Mandarin", "value": "Mandarin"},
    {"label": "Japanese", "value": "Japanese"},
    {"label": "Korean", "value": "Korean"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "Basic", "value": "Basic", "icon": Icons.language},
    {"label": "Greetings", "value": "Greetings", "icon": Icons.waving_hand},
    {"label": "Food & Dining", "value": "Food", "icon": Icons.restaurant},
    {"label": "Transportation", "value": "Transport", "icon": Icons.directions_car},
    {"label": "Shopping", "value": "Shopping", "icon": Icons.shopping_bag},
    {"label": "Emergency", "value": "Emergency", "icon": Icons.warning},
    {"label": "Numbers", "value": "Numbers", "icon": Icons.numbers},
    {"label": "Time & Date", "value": "Time", "icon": Icons.access_time},
  ];

  List<Map<String, dynamic>> phrases = [
    {"english": "Hello", "translation": "Hola", "pronunciation": "OH-lah", "category": "Greetings"},
    {"english": "Good morning", "translation": "Buenos días", "pronunciation": "BWAY-nohs DEE-ahs", "category": "Greetings"},
    {"english": "Thank you", "translation": "Gracias", "pronunciation": "GRAH-see-ahs", "category": "Basic"},
    {"english": "Please", "translation": "Por favor", "pronunciation": "por fah-VOR", "category": "Basic"},
    {"english": "Excuse me", "translation": "Disculpe", "pronunciation": "dees-KOOL-peh", "category": "Basic"},
    {"english": "I would like...", "translation": "Me gustaría...", "pronunciation": "meh goos-tah-REE-ah", "category": "Food"},
    {"english": "Where is the bathroom?", "translation": "¿Dónde está el baño?", "pronunciation": "DOHN-deh ehs-TAH el BAH-nyoh", "category": "Basic"},
    {"english": "How much does this cost?", "translation": "¿Cuánto cuesta esto?", "pronunciation": "KWAN-toh KWEH-stah EH-stoh", "category": "Shopping"},
    {"english": "Call the police", "translation": "Llame a la policía", "pronunciation": "YAH-meh ah lah po-lee-SEE-ah", "category": "Emergency"},
    {"english": "I need help", "translation": "Necesito ayuda", "pronunciation": "neh-seh-SEE-toh ah-YOO-dah", "category": "Emergency"},
  ];

  List<Map<String, dynamic>> favorites = [
    {"english": "Hello", "translation": "Hola", "pronunciation": "OH-lah"},
    {"english": "Thank you", "translation": "Gracias", "pronunciation": "GRAH-see-ahs"},
    {"english": "Please", "translation": "Por favor", "pronunciation": "por fah-VOR"},
  ];

  List<Map<String, dynamic>> get filteredPhrases {
    List<Map<String, dynamic>> filtered = phrases;

    if (selectedCategory != "All") {
      filtered = filtered.where((phrase) => phrase["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((phrase) => 
        phrase["english"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        phrase["translation"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  void _playAudio(String text) {
    // Simulate audio playback
    ss("Playing pronunciation: $text");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language Phrases"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Selection
            QDropdownField(
              label: "Select Language",
              items: languageItems,
              value: selectedLanguage,
              onChanged: (value, label) {
                selectedLanguage = value;
                setState(() {});
              },
            ),

            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search phrases...",
                    value: searchQuery,
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
            ),

            // Categories
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                bool isSelected = selectedCategory == category["value"];
                
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedCategory = category["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          Icon(
                            category["icon"] as IconData,
                            size: 18,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                          Text(
                            "${category["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),

            // Phrases List
            Text(
              "Phrases (${filteredPhrases.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: List.generate(filteredPhrases.length, (index) {
                final phrase = filteredPhrases[index];
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${phrase["english"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${phrase["translation"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Pronunciation: ${phrase["pronunciation"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            spacing: spXs,
                            children: [
                              GestureDetector(
                                onTap: () => _playAudio("${phrase["translation"]}"),
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(30),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.volume_up,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ss("Added to favorites");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(30),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.star_border,
                                    color: warningColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${phrase["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            // Favorites Section
            if (favorites.isNotEmpty) ...[
              Text(
                "Favorite Phrases",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: List.generate(favorites.length, (index) {
                    final favorite = favorites[index];
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: index < favorites.length - 1 
                          ? Border(bottom: BorderSide(color: disabledColor))
                          : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXxs,
                              children: [
                                Text(
                                  "${favorite["english"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${favorite["translation"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${favorite["pronunciation"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _playAudio("${favorite["translation"]}"),
                            child: Icon(
                              Icons.volume_up,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
