import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCodingPlaygroundView extends StatefulWidget {
  const ElaCodingPlaygroundView({super.key});

  @override
  State<ElaCodingPlaygroundView> createState() => _ElaCodingPlaygroundViewState();
}

class _ElaCodingPlaygroundViewState extends State<ElaCodingPlaygroundView> {
  String selectedLanguage = "Python";
  String selectedDifficulty = "Beginner";
  String code = "";
  String output = "";
  bool isRunning = false;
  bool loading = false;
  int currentChallengeIndex = 0;

  List<Map<String, dynamic>> languages = [
    {"label": "Python", "value": "Python"},
    {"label": "JavaScript", "value": "JavaScript"},
    {"label": "Java", "value": "Java"},
    {"label": "C++", "value": "C++"},
    {"label": "HTML/CSS", "value": "HTML/CSS"},
  ];

  List<Map<String, dynamic>> difficulties = [
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> challenges = [
    {
      "title": "Hello World",
      "language": "Python",
      "difficulty": "Beginner",
      "description": "Write a program that prints 'Hello, World!' to the console",
      "instructions": [
        "Use the print() function in Python",
        "Make sure the text is exactly 'Hello, World!'",
        "Don't forget the comma and exclamation mark"
      ],
      "starterCode": "# Write your code here\n",
      "expectedOutput": "Hello, World!",
      "hints": [
        "Use print('Hello, World!')",
        "Python is case-sensitive",
        "Strings need quotes"
      ],
      "category": "Basics",
      "points": 10,
    },
    {
      "title": "Calculate Sum",
      "language": "Python",
      "difficulty": "Beginner",
      "description": "Create a function that adds two numbers and returns the result",
      "instructions": [
        "Define a function named 'add_numbers'",
        "Function should take two parameters",
        "Return the sum of the two numbers"
      ],
      "starterCode": "def add_numbers(a, b):\n    # Your code here\n    pass\n\n# Test your function\nresult = add_numbers(5, 3)\nprint(result)",
      "expectedOutput": "8",
      "hints": [
        "Use the + operator to add",
        "Don't forget to return the result",
        "Replace 'pass' with your code"
      ],
      "category": "Functions",
      "points": 15,
    },
    {
      "title": "Create a Button",
      "language": "HTML/CSS",
      "difficulty": "Beginner",
      "description": "Create a styled button using HTML and CSS",
      "instructions": [
        "Create a button element in HTML",
        "Style it with CSS to be blue with white text",
        "Add hover effect that changes color"
      ],
      "starterCode": "<!DOCTYPE html>\n<html>\n<head>\n<style>\n/* Your CSS here */\n</style>\n</head>\n<body>\n<!-- Your HTML here -->\n</body>\n</html>",
      "expectedOutput": "A blue button with white text",
      "hints": [
        "Use <button> tag",
        "Use background-color and color properties",
        "Use :hover selector for hover effect"
      ],
      "category": "Web Development",
      "points": 20,
    },
    {
      "title": "Array Operations",
      "language": "JavaScript",
      "difficulty": "Intermediate",
      "description": "Find the largest number in an array",
      "instructions": [
        "Create a function named 'findLargest'",
        "Function should take an array as parameter",
        "Return the largest number in the array"
      ],
      "starterCode": "function findLargest(numbers) {\n    // Your code here\n}\n\n// Test your function\nconst result = findLargest([3, 7, 2, 9, 1]);\nconsole.log(result);",
      "expectedOutput": "9",
      "hints": [
        "Use Math.max() or a loop",
        "Consider using spread operator",
        "Don't forget to return the result"
      ],
      "category": "Arrays",
      "points": 25,
    },
    {
      "title": "Class Creation",
      "language": "Java",
      "difficulty": "Intermediate",
      "description": "Create a simple Car class with properties and methods",
      "instructions": [
        "Create a class named 'Car'",
        "Add properties: brand, model, year",
        "Add a method to display car information"
      ],
      "starterCode": "public class Car {\n    // Your code here\n}\n\n// Test code\nCar myCar = new Car(\"Toyota\", \"Camry\", 2022);\nmyCar.displayInfo();",
      "expectedOutput": "Car: Toyota Camry (2022)",
      "hints": [
        "Use constructor to initialize properties",
        "Use System.out.println for output",
        "Format the output properly"
      ],
      "category": "Object-Oriented Programming",
      "points": 30,
    },
    {
      "title": "Binary Search",
      "language": "C++",
      "difficulty": "Advanced",
      "description": "Implement binary search algorithm",
      "instructions": [
        "Create a function that performs binary search",
        "Function should find target in sorted array",
        "Return the index of target or -1 if not found"
      ],
      "starterCode": "#include <iostream>\n#include <vector>\nusing namespace std;\n\nint binarySearch(vector<int>& arr, int target) {\n    // Your code here\n}\n\nint main() {\n    vector<int> arr = {1, 3, 5, 7, 9, 11};\n    int result = binarySearch(arr, 7);\n    cout << result << endl;\n    return 0;\n}",
      "expectedOutput": "3",
      "hints": [
        "Use two pointers: left and right",
        "Calculate mid point",
        "Compare with target and adjust pointers"
      ],
      "category": "Algorithms",
      "points": 50,
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "name": "Python Function",
      "language": "Python",
      "code": "def function_name(parameter):\n    \"\"\"\n    Function description\n    \"\"\"\n    # Your code here\n    return result\n\n# Test your function\nresult = function_name(argument)\nprint(result)",
    },
    {
      "name": "JavaScript Function",
      "language": "JavaScript",
      "code": "function functionName(parameter) {\n    // Your code here\n    return result;\n}\n\n// Test your function\nconst result = functionName(argument);\nconsole.log(result);",
    },
    {
      "name": "HTML Page",
      "language": "HTML/CSS",
      "code": "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>Document</title>\n    <style>\n        /* Your CSS here */\n    </style>\n</head>\n<body>\n    <!-- Your HTML here -->\n</body>\n</html>",
    },
    {
      "name": "Java Class",
      "language": "Java",
      "code": "public class ClassName {\n    // Properties\n    private String property;\n    \n    // Constructor\n    public ClassName(String property) {\n        this.property = property;\n    }\n    \n    // Methods\n    public void method() {\n        // Your code here\n    }\n}",
    },
    {
      "name": "C++ Program",
      "language": "C++",
      "code": "#include <iostream>\nusing namespace std;\n\nint main() {\n    // Your code here\n    \n    return 0;\n}",
    },
  ];

  List<Map<String, dynamic>> get filteredChallenges {
    return challenges.where((challenge) {
      bool languageMatch = selectedLanguage == "All" || challenge["language"] == selectedLanguage;
      bool difficultyMatch = selectedDifficulty == "All" || challenge["difficulty"] == selectedDifficulty;
      return languageMatch && difficultyMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get availableTemplates {
    return templates.where((template) => template["language"] == selectedLanguage).toList();
  }

  @override
  void initState() {
    super.initState();
    code = "# Welcome to the Coding Playground!\n# Select a challenge or start coding\n\nprint('Hello, World!')";
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
        title: Text("Coding Playground"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showHelpDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share code
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                      Icons.code,
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
                          "Interactive Coding Environment",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Write, run, and test your code in real-time",
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

            // Language and Difficulty Selection
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
                    "Environment Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Language",
                          items: languages,
                          value: selectedLanguage,
                          onChanged: (value, label) {
                            selectedLanguage = value;
                            _loadTemplate();
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Difficulty",
                          items: difficulties,
                          value: selectedDifficulty,
                          onChanged: (value, label) {
                            selectedDifficulty = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
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
                          label: "New Template",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            _showTemplateSelector();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Clear Code",
                          icon: Icons.clear,
                          size: bs.sm,
                          onPressed: () {
                            code = "";
                            output = "";
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Code Editor
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Editor Header
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.code,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Code Editor - $selectedLanguage",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: isRunning ? "Running..." : "Run Code",
                          icon: isRunning ? Icons.hourglass_empty : Icons.play_arrow,
                          size: bs.sm,
                          onPressed: isRunning ? null : _runCode,
                        ),
                      ],
                    ),
                  ),
                  // Code Input
                  Container(
                    padding: EdgeInsets.all(spSm),
                    child: QMemoField(
                      label: "Write your code here...",
                      value: code,
                      hint: "Start typing your ${selectedLanguage} code",
                      onChanged: (value) {
                        code = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Output Section
            if (output.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Output Header
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.terminal,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Output",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              output = "";
                              setState(() {});
                            },
                            child: Icon(
                              Icons.close,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Output Content
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      child: Text(
                        output,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'monospace',
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Challenges Section
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Coding Challenges",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${filteredChallenges.length} challenges",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            if (filteredChallenges.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No challenges available",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try selecting a different language or difficulty",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredChallenges.map((challenge) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Challenge Header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(challenge["difficulty"]).withAlpha(20),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(challenge["difficulty"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${challenge["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${challenge["points"]} pts",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Challenge Content
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${challenge["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${challenge["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${challenge["language"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${challenge["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Start Challenge",
                                  size: bs.sm,
                                  onPressed: () {
                                    _loadChallenge(challenge);
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
      ),
    );
  }

  void _loadTemplate() {
    final template = availableTemplates.isNotEmpty ? availableTemplates.first : null;
    if (template != null) {
      code = template["code"];
      output = "";
      setState(() {});
    }
  }

  void _loadChallenge(Map<String, dynamic> challenge) {
    selectedLanguage = challenge["language"];
    code = challenge["starterCode"];
    output = "";
    setState(() {});
    
    // Show challenge details
    _showChallengeDetails(challenge);
  }

  void _runCode() async {
    setState(() {
      isRunning = true;
    });

    // Simulate code execution
    await Future.delayed(Duration(seconds: 2));

    // Generate mock output based on language
    String mockOutput;
    switch (selectedLanguage) {
      case "Python":
        if (code.contains("print('Hello, World!')")) {
          mockOutput = "Hello, World!";
        } else if (code.contains("add_numbers")) {
          mockOutput = "8";
        } else {
          mockOutput = "Code executed successfully";
        }
        break;
      case "JavaScript":
        mockOutput = "9\nCode executed in browser console";
        break;
      case "HTML/CSS":
        mockOutput = "HTML page rendered successfully";
        break;
      case "Java":
        mockOutput = "Car: Toyota Camry (2022)\nCompiled and executed successfully";
        break;
      case "C++":
        mockOutput = "3\nProgram executed successfully";
        break;
      default:
        mockOutput = "Code executed successfully";
    }

    setState(() {
      output = mockOutput;
      isRunning = false;
    });

    ss("Code executed successfully!");
  }

  void _showTemplateSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Select Template",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...availableTemplates.map((template) {
                    return GestureDetector(
                      onTap: () {
                        code = template["code"];
                        output = "";
                        setState(() {});
                        Navigator.pop(context);
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
                            Icon(
                              Icons.code,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: primaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChallengeDetails(Map<String, dynamic> challenge) {
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${challenge["title"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(challenge["difficulty"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${challenge["difficulty"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${challenge["points"]} points",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Description
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Challenge Description",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${challenge["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Instructions
                    _buildListSection("Instructions", challenge["instructions"]),

                    // Hints
                    _buildListSection("Hints", challenge["hints"]),

                    // Expected Output
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Expected Output",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${challenge["expectedOutput"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'monospace',
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Close Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Coding",
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

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Coding Playground Help"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Select a programming language from the dropdown"),
            Text("• Choose a template or start a coding challenge"),
            Text("• Write your code in the editor"),
            Text("• Click 'Run Code' to execute your program"),
            Text("• View the output in the terminal section"),
            Text("• Complete challenges to earn points"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(String title, List<dynamic> items) {
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
          ...items.map((item) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  margin: EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "$item",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
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

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      case "Expert":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
