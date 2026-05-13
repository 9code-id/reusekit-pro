import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCodeEditorView extends StatefulWidget {
  const ElaCodeEditorView({super.key});

  @override
  State<ElaCodeEditorView> createState() => _ElaCodeEditorViewState();
}

class _ElaCodeEditorViewState extends State<ElaCodeEditorView> {
  String selectedLanguage = "dart";
  String selectedTheme = "dark";
  String currentCode = '''void main() {
  print('Hello, World!');
}''';
  
  bool isRunning = false;
  String output = "";
  
  List<Map<String, dynamic>> codeTemplates = [
    {
      "id": "1",
      "name": "Hello World",
      "language": "dart",
      "code": '''void main() {
  print('Hello, World!');
}''',
      "description": "Basic Hello World program",
      "difficulty": "Beginner"
    },
    {
      "id": "2", 
      "name": "Variables & Types",
      "language": "dart",
      "code": '''void main() {
  String name = 'Flutter';
  int version = 3;
  double rating = 4.8;
  bool isAwesome = true;
  
  print('Language: \$name');
  print('Version: \$version');
  print('Rating: \$rating');
  print('Is Awesome: \$isAwesome');
}''',
      "description": "Learn about variables and data types",
      "difficulty": "Beginner"
    },
    {
      "id": "3",
      "name": "Functions",
      "language": "dart", 
      "code": '''int add(int a, int b) {
  return a + b;
}

String greetUser(String name) {
  return 'Hello, \$name!';
}

void main() {
  int sum = add(5, 3);
  String greeting = greetUser('Developer');
  
  print('Sum: \$sum');
  print(greeting);
}''',
      "description": "Working with functions",
      "difficulty": "Intermediate"
    },
    {
      "id": "4",
      "name": "Classes & Objects",
      "language": "dart",
      "code": '''class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  void introduce() {
    print('Hi, I am \$name and I am \$age years old.');
  }
}

void main() {
  Person person = Person('Alice', 25);
  person.introduce();
}''',
      "description": "Object-oriented programming basics",
      "difficulty": "Intermediate"
    },
    {
      "id": "5",
      "name": "List Operations",
      "language": "dart",
      "code": '''void main() {
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  
  // Add items
  fruits.add('Grape');
  
  // Loop through list
  for (String fruit in fruits) {
    print('Fruit: \$fruit');
  }
  
  // Filter list
  List<String> longNames = fruits.where((fruit) => fruit.length > 5).toList();
  print('Long names: \$longNames');
}''',
      "description": "Working with lists and collections", 
      "difficulty": "Intermediate"
    },
    {
      "id": "6",
      "name": "Async Programming",
      "language": "dart",
      "code": '''Future<String> fetchUserData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'User data loaded!';
}

void main() async {
  print('Loading user data...');
  String data = await fetchUserData();
  print(data);
}''',
      "description": "Asynchronous programming with Future and async/await",
      "difficulty": "Advanced"
    }
  ];

  List<Map<String, dynamic>> supportedLanguages = [
    {"label": "Dart", "value": "dart", "icon": Icons.code},
    {"label": "JavaScript", "value": "javascript", "icon": Icons.javascript},
    {"label": "Python", "value": "python", "icon": Icons.code},
    {"label": "Java", "value": "java", "icon": Icons.code},
    {"label": "C++", "value": "cpp", "icon": Icons.code},
    {"label": "HTML", "value": "html", "icon": Icons.html},
    {"label": "CSS", "value": "css", "icon": Icons.css},
  ];

  List<Map<String, dynamic>> editorThemes = [
    {"label": "Dark Theme", "value": "dark"},
    {"label": "Light Theme", "value": "light"},
    {"label": "Monokai", "value": "monokai"},
    {"label": "Solarized", "value": "solarized"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Editor"),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'templates') {
                _showTemplatesDialog();
              } else if (value == 'settings') {
                _showSettingsDialog();
              } else if (value == 'save') {
                ss("Code saved successfully!");
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'templates', child: Text('Code Templates')),
              PopupMenuItem(value: 'settings', child: Text('Editor Settings')),
              PopupMenuItem(value: 'save', child: Text('Save Code')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildCodeEditor(),
                ),
                Container(
                  width: 1,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  flex: 1,
                  child: _buildOutputPanel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.code, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Text(
            "Language:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(width: spXs),
          Container(
            width: 120,
            child: QDropdownField(
              items: supportedLanguages,
              value: selectedLanguage,
              onChanged: (value, label) {
                selectedLanguage = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spMd),
          QButton(
            label: isRunning ? "Running..." : "Run Code",
            icon: isRunning ? Icons.hourglass_empty : Icons.play_arrow,
            size: bs.sm,
            onPressed: isRunning ? null : _runCode,
          ),
          Spacer(),
          QButton(
            label: "Clear",
            icon: Icons.clear,
            size: bs.sm,
            onPressed: () {
              currentCode = "";
              output = "";
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Format",
            icon: Icons.format_align_left,
            size: bs.sm,
            onPressed: () {
              ss("Code formatted successfully!");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCodeEditor() {
    return Container(
      color: selectedTheme == "dark" 
          ? Color(0xFF1E1E1E) 
          : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: selectedTheme == "dark" 
                  ? Color(0xFF2D2D30) 
                  : Colors.grey.withAlpha(50),
              border: Border(
                bottom: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  size: 16,
                  color: selectedTheme == "dark" ? Colors.white70 : Colors.black54,
                ),
                SizedBox(width: spXs),
                Text(
                  "main.${selectedLanguage}",
                  style: TextStyle(
                    fontSize: 12,
                    color: selectedTheme == "dark" ? Colors.white70 : Colors.black54,
                  ),
                ),
                Spacer(),
                Text(
                  "Line 1, Column 1",
                  style: TextStyle(
                    fontSize: 10,
                    color: selectedTheme == "dark" ? Colors.white54 : Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Line numbers
                  Container(
                    width: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (int i = 1; i <= (currentCode.split('\n').length); i++)
                          Container(
                            height: 20,
                            child: Text(
                              "$i",
                              style: TextStyle(
                                fontSize: 12,
                                color: selectedTheme == "dark" 
                                    ? Colors.white54 
                                    : Colors.black38,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: spSm),
                  // Code editor
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: currentCode),
                      maxLines: null,
                      expands: true,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color: selectedTheme == "dark" ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Start typing your code here...",
                        hintStyle: TextStyle(
                          color: selectedTheme == "dark" 
                              ? Colors.white38 
                              : Colors.black38,
                        ),
                      ),
                      onChanged: (value) {
                        currentCode = value;
                      },
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

  Widget _buildOutputPanel() {
    return Container(
      color: selectedTheme == "dark" 
          ? Color(0xFF252526) 
          : Colors.grey.withAlpha(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: selectedTheme == "dark" 
                  ? Color(0xFF2D2D30) 
                  : Colors.grey.withAlpha(50),
              border: Border(
                bottom: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.terminal,
                  size: 16,
                  color: selectedTheme == "dark" ? Colors.white70 : Colors.black54,
                ),
                SizedBox(width: spXs),
                Text(
                  "Output",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selectedTheme == "dark" ? Colors.white70 : Colors.black54,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    output = "";
                    setState(() {});
                  },
                  child: Icon(
                    Icons.clear,
                    size: 16,
                    color: selectedTheme == "dark" ? Colors.white54 : Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: output.isEmpty
                  ? Center(
                      child: Text(
                        "Run your code to see output here",
                        style: TextStyle(
                          color: selectedTheme == "dark" 
                              ? Colors.white54 
                              : Colors.black38,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Text(
                        output,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: selectedTheme == "dark" 
                              ? Colors.green.shade300 
                              : Colors.green.shade700,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _runCode() async {
    isRunning = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    // Simulate code execution
    if (currentCode.contains('print')) {
      String result = "Hello, World!\n";
      if (currentCode.contains('variables')) {
        result += "Language: Flutter\nVersion: 3\nRating: 4.8\nIs Awesome: true\n";
      }
      if (currentCode.contains('add(')) {
        result += "Sum: 8\n";
      }
      if (currentCode.contains('greetUser')) {
        result += "Hello, Developer!\n";
      }
      output = result;
    } else {
      output = "Code executed successfully!\n";
    }

    isRunning = false;
    setState(() {});
  }

  void _showTemplatesDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.code_outlined, color: primaryColor),
                  SizedBox(width: spSm),
                  Text(
                    "Code Templates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: codeTemplates.length,
                itemBuilder: (context, index) {
                  final template = codeTemplates[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${template["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: template["difficulty"] == "Beginner"
                                          ? successColor.withAlpha(20)
                                          : template["difficulty"] == "Intermediate"
                                              ? warningColor.withAlpha(20)
                                              : dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${template["difficulty"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: template["difficulty"] == "Beginner"
                                            ? successColor
                                            : template["difficulty"] == "Intermediate"
                                                ? warningColor
                                                : dangerColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${template["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Use Template",
                                  size: bs.sm,
                                  onPressed: () {
                                    currentCode = template["code"];
                                    selectedLanguage = template["language"];
                                    Navigator.pop(context);
                                    setState(() {});
                                    ss("Template loaded successfully!");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.settings, color: primaryColor),
                  SizedBox(width: spSm),
                  Text(
                    "Editor Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.color_lens, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Theme:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            items: editorThemes,
                            value: selectedTheme,
                            onChanged: (value, label) {
                              selectedTheme = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.text_fields, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Font Size:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Text("14px", style: TextStyle(color: disabledBoldColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.format_indent_increase, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Auto Indent:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Switch(
                          value: true,
                          onChanged: (value) {},
                        ),
                      ],
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
}
