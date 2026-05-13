import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaFlashcardsView extends StatefulWidget {
  const ElaFlashcardsView({super.key});

  @override
  State<ElaFlashcardsView> createState() => _ElaFlashcardsViewState();
}

class _ElaFlashcardsViewState extends State<ElaFlashcardsView> {
  String selectedDeck = "Python Basics";
  int currentCardIndex = 0;
  bool showAnswer = false;
  
  Map<String, List<Map<String, dynamic>>> flashcardDecks = {
    "Python Basics": [
      {
        "question": "What is a variable in Python?",
        "answer": "A variable is a storage location with an associated name that stores data that can be changed during program execution.",
        "difficulty": "Easy",
        "mastered": true,
      },
      {
        "question": "What are the basic data types in Python?",
        "answer": "Integer (int), Float (float), String (str), Boolean (bool), List, Tuple, Dictionary, Set",
        "difficulty": "Medium",
        "mastered": false,
      },
      {
        "question": "What is the difference between append() and extend()?",
        "answer": "append() adds a single element to the end of the list, while extend() adds multiple elements from an iterable.",
        "difficulty": "Hard",
        "mastered": false,
      },
    ],
    "Data Structures": [
      {
        "question": "What is Big O notation?",
        "answer": "Big O notation describes the upper bound of the time complexity of an algorithm, expressing how the runtime grows with input size.",
        "difficulty": "Medium",
        "mastered": true,
      },
      {
        "question": "What is a Stack?",
        "answer": "A Stack is a linear data structure that follows LIFO (Last In First Out) principle. Elements are added and removed from the same end called the top.",
        "difficulty": "Easy",
        "mastered": true,
      },
    ],
  };

  List<String> get deckNames => flashcardDecks.keys.toList();
  List<Map<String, dynamic>> get currentDeck => flashcardDecks[selectedDeck] ?? [];
  Map<String, dynamic>? get currentCard => 
    currentDeck.isNotEmpty ? currentDeck[currentCardIndex] : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flashcards"),
        actions: [
          QButton(
            icon: Icons.shuffle,
            size: bs.sm,
            onPressed: () {
              // Shuffle cards
              if (currentDeck.isNotEmpty) {
                currentDeck.shuffle();
                currentCardIndex = 0;
                showAnswer = false;
                setState(() {});
              }
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deck Selection
            QDropdownField(
              label: "Select Deck",
              items: deckNames.map((deck) => {"label": deck, "value": deck}).toList(),
              value: selectedDeck,
              onChanged: (value, label) {
                selectedDeck = value;
                currentCardIndex = 0;
                showAnswer = false;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),

            // Deck Stats
            if (currentDeck.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${currentDeck.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Cards",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 1, height: 30, color: primaryColor.withAlpha(100)),
                    Column(
                      children: [
                        Text(
                          "${currentDeck.where((c) => c["mastered"] == true).length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Mastered",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Container(width: 1, height: 30, color: primaryColor.withAlpha(100)),
                    Column(
                      children: [
                        Text(
                          "${currentCardIndex + 1}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Current",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),

              // Progress Bar
              LinearProgressIndicator(
                value: (currentCardIndex + 1) / currentDeck.length,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              SizedBox(height: spXs),
              Text(
                "Card ${currentCardIndex + 1} of ${currentDeck.length}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Flashcard
              if (currentCard != null) ...[
                GestureDetector(
                  onTap: () {
                    showAnswer = !showAnswer;
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowMd],
                      border: Border.all(
                        color: _getDifficultyColor(currentCard!["difficulty"]),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Card Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(currentCard!["difficulty"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${currentCard!["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _getDifficultyColor(currentCard!["difficulty"]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            if (currentCard!["mastered"] == true) ...[
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 20,
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: spMd),
                        
                        // Card Content
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!showAnswer) ...[
                                  Icon(
                                    Icons.help_outline,
                                    color: primaryColor,
                                    size: 32,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "Question",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${currentCard!["question"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: primaryColor,
                                    ),
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.lightbulb_outline,
                                    color: Colors.amber,
                                    size: 32,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "Answer",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${currentCard!["answer"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        
                        // Tap instruction
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            showAnswer ? "Tap to show question" : "Tap to show answer",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: spLg),

                // Action Buttons
                if (showAnswer) ...[
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Hard",
                          icon: Icons.close,
                          size: bs.sm,
                          onPressed: () {
                            _nextCard();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Good",
                          icon: Icons.check,
                          size: bs.sm,
                          onPressed: () {
                            _nextCard();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Easy",
                          icon: Icons.done_all,
                          size: bs.sm,
                          onPressed: () {
                            currentCard!["mastered"] = true;
                            _nextCard();
                          },
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Previous",
                          icon: Icons.arrow_back,
                          size: bs.sm,
                          onPressed: currentCardIndex > 0 ? () {
                            currentCardIndex--;
                            showAnswer = false;
                            setState(() {});
                          } : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Next",
                          icon: Icons.arrow_forward,
                          size: bs.sm,
                          onPressed: currentCardIndex < currentDeck.length - 1 ? () {
                            currentCardIndex++;
                            showAnswer = false;
                            setState(() {});
                          } : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ] else ...[
              // Empty State
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.style,
                        color: disabledColor,
                        size: 48,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No flashcards available",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Select a different deck or create new cards",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _nextCard() {
    if (currentCardIndex < currentDeck.length - 1) {
      currentCardIndex++;
    } else {
      currentCardIndex = 0; // Loop back to start
    }
    showAnswer = false;
    setState(() {});
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return Colors.green;
      case "Medium":
        return Colors.orange;
      case "Hard":
        return Colors.red;
      default:
        return primaryColor;
    }
  }
}
