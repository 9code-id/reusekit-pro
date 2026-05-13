import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaMathSolverView extends StatefulWidget {
  const ElaMathSolverView({super.key});

  @override
  State<ElaMathSolverView> createState() => _ElaMathSolverViewState();
}

class _ElaMathSolverViewState extends State<ElaMathSolverView> {
  String mathProblem = "";
  String solution = "";
  bool loading = false;
  String selectedDifficulty = "Beginner";
  String selectedType = "Algebra";
  
  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];
  
  List<Map<String, dynamic>> problemTypes = [
    {"label": "Algebra", "value": "Algebra"},
    {"label": "Geometry", "value": "Geometry"},
    {"label": "Calculus", "value": "Calculus"},
    {"label": "Statistics", "value": "Statistics"},
    {"label": "Trigonometry", "value": "Trigonometry"},
    {"label": "Linear Algebra", "value": "Linear Algebra"},
  ];
  
  List<Map<String, dynamic>> recentProblems = [
    {
      "problem": "Solve for x: 2x + 5 = 15",
      "solution": "x = 5",
      "type": "Algebra",
      "difficulty": "Beginner",
      "timestamp": "2024-01-15 14:30:00"
    },
    {
      "problem": "Find the derivative of f(x) = x² + 3x + 2",
      "solution": "f'(x) = 2x + 3",
      "type": "Calculus",
      "difficulty": "Intermediate",
      "timestamp": "2024-01-15 13:45:00"
    },
    {
      "problem": "Calculate the area of a circle with radius 5",
      "solution": "Area = πr² = 25π ≈ 78.54",
      "type": "Geometry",
      "difficulty": "Beginner",
      "timestamp": "2024-01-15 12:20:00"
    },
  ];
  
  List<Map<String, dynamic>> quickExamples = [
    {
      "title": "Linear Equations",
      "example": "2x + 3 = 7",
      "type": "Algebra",
      "difficulty": "Beginner"
    },
    {
      "title": "Quadratic Formula",
      "example": "x² - 5x + 6 = 0",
      "type": "Algebra",
      "difficulty": "Intermediate"
    },
    {
      "title": "Integration",
      "example": "∫(2x + 1)dx",
      "type": "Calculus",
      "difficulty": "Advanced"
    },
    {
      "title": "Pythagorean Theorem",
      "example": "Find c if a=3, b=4",
      "type": "Geometry",
      "difficulty": "Beginner"
    },
  ];

  void _solveProblem() async {
    if (mathProblem.trim().isEmpty) {
      se("Please enter a math problem");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate AI solving process
    await Future.delayed(Duration(seconds: 2));
    
    // Generate mock solution based on problem type
    String mockSolution = _generateMockSolution();
    
    solution = mockSolution;
    loading = false;
    setState(() {});
    
    ss("Problem solved successfully!");
  }
  
  String _generateMockSolution() {
    switch (selectedType) {
      case "Algebra":
        return "Step 1: Isolate the variable\nStep 2: Simplify both sides\nStep 3: Solve for x\nAnswer: x = 5";
      case "Geometry":
        return "Step 1: Identify the shape properties\nStep 2: Apply relevant formulas\nStep 3: Calculate the result\nAnswer: Area = 25π square units";
      case "Calculus":
        return "Step 1: Apply differentiation rules\nStep 2: Simplify the expression\nStep 3: Final derivative\nAnswer: f'(x) = 2x + 3";
      default:
        return "Step 1: Analyze the problem\nStep 2: Apply mathematical principles\nStep 3: Calculate the solution\nAnswer: Solution provided";
    }
  }
  
  void _useProblemExample(String example) {
    mathProblem = example;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Math Solver AI"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              ss("Viewing problem history");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.calculate,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "AI-Powered Math Solver",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Solve complex math problems with step-by-step explanations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Problem Input Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Your Math Problem",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QMemoField(
                    label: "Math Problem",
                    value: mathProblem,
                    hint: "e.g., Solve for x: 2x + 5 = 15",
                    maxLines: 4,
                    onChanged: (value) {
                      mathProblem = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Problem Type",
                          items: problemTypes,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Difficulty",
                          items: difficultyLevels,
                          value: selectedDifficulty,
                          onChanged: (value, label) {
                            selectedDifficulty = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: loading ? "Solving..." : "Solve Problem",
                      icon: loading ? Icons.hourglass_empty : Icons.psychology,
                      size: bs.md,
                      onPressed: loading ? null : _solveProblem,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Examples
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Examples",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: quickExamples.map((example) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lightbulb,
                                  color: warningColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${example["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${example["example"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${example["type"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                QButton(
                                  label: "Use",
                                  size: bs.sm,
                                  onPressed: () => _useProblemExample(example["example"] as String),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Solution Section
            if (solution.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Solution",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.copy,
                          size: bs.sm,
                          onPressed: () {
                            ss("Solution copied to clipboard");
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: successColor.withAlpha(50),
                        ),
                      ),
                      child: Text(
                        solution,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.6,
                        ),
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Save Solution",
                            icon: Icons.bookmark,
                            size: bs.sm,
                            onPressed: () {
                              ss("Solution saved to bookmarks");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Share",
                            icon: Icons.share,
                            size: bs.sm,
                            onPressed: () {
                              ss("Solution shared successfully");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Recent Problems
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Problems",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...recentProblems.map((problem) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${problem["type"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${problem["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${DateTime.parse(problem["timestamp"] as String).dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${problem["problem"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Solution: ${problem["solution"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: successColor,
                            ),
                          ),
                        ],
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
}
