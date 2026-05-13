import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmRegistrationQuestionsView extends StatefulWidget {
  const EcmRegistrationQuestionsView({super.key});

  @override
  State<EcmRegistrationQuestionsView> createState() => _EcmRegistrationQuestionsViewState();
}

class _EcmRegistrationQuestionsViewState extends State<EcmRegistrationQuestionsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedType = "All";
  String selectedStatus = "All";

  // Form states
  String questionText = "";
  String questionType = "text";
  String category = "general";
  String helpText = "";
  bool isRequired = false;
  bool isConditional = false;
  String conditionField = "";
  String conditionValue = "";
  List<String> options = [];
  String newOption = "";

  final List<Map<String, dynamic>> questions = [
    {
      "id": "q1",
      "question": "What is your primary motivation for attending this event?",
      "type": "multiple_choice",
      "category": "general",
      "required": true,
      "status": "active",
      "responses": 245,
      "options": ["Networking", "Learning", "Business Development", "Personal Interest"],
      "created_date": "2024-01-15",
      "last_modified": "2024-01-20",
      "conditional": false,
    },
    {
      "id": "q2", 
      "question": "Do you have any dietary restrictions?",
      "type": "checkbox",
      "category": "logistics",
      "required": false,
      "status": "active",
      "responses": 198,
      "options": ["Vegetarian", "Vegan", "Gluten-free", "Halal", "Kosher", "No restrictions"],
      "created_date": "2024-01-10",
      "last_modified": "2024-01-18",
      "conditional": false,
    },
    {
      "id": "q3",
      "question": "What topics would you like to see covered in breakout sessions?",
      "type": "text",
      "category": "content",
      "required": false,
      "status": "active", 
      "responses": 156,
      "created_date": "2024-01-12",
      "last_modified": "2024-01-22",
      "conditional": false,
    },
    {
      "id": "q4",
      "question": "How did you hear about this event?",
      "type": "dropdown",
      "category": "marketing",
      "required": true,
      "status": "active",
      "responses": 289,
      "options": ["Social Media", "Email Newsletter", "Website", "Word of Mouth", "Advertisement", "Partner Organization"],
      "created_date": "2024-01-08",
      "last_modified": "2024-01-25",
      "conditional": false,
    },
    {
      "id": "q5",
      "question": "Please specify which social media platform",
      "type": "dropdown",
      "category": "marketing",
      "required": true,
      "status": "active",
      "responses": 89,
      "options": ["Facebook", "LinkedIn", "Twitter", "Instagram", "TikTok"],
      "created_date": "2024-01-08",
      "last_modified": "2024-01-25",
      "conditional": true,
      "condition_field": "q4",
      "condition_value": "Social Media",
    },
    {
      "id": "q6",
      "question": "What is your experience level with the event topic?",
      "type": "rating",
      "category": "demographics",
      "required": false,
      "status": "draft",
      "responses": 0,
      "scale": 5,
      "created_date": "2024-01-28",
      "last_modified": "2024-01-28",
      "conditional": false,
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "General", "value": "general"},
    {"label": "Demographics", "value": "demographics"},
    {"label": "Content", "value": "content"},
    {"label": "Logistics", "value": "logistics"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Feedback", "value": "feedback"},
  ];

  final List<Map<String, dynamic>> questionTypes = [
    {"label": "All", "value": "All"},
    {"label": "Text", "value": "text"},
    {"label": "Multiple Choice", "value": "multiple_choice"},
    {"label": "Checkbox", "value": "checkbox"},
    {"label": "Dropdown", "value": "dropdown"},
    {"label": "Rating", "value": "rating"},
    {"label": "Date", "value": "date"},
    {"label": "Number", "value": "number"},
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Draft", "value": "draft"},
    {"label": "Archived", "value": "archived"},
  ];

  final List<Map<String, dynamic>> newQuestionTypes = [
    {"label": "Text", "value": "text"},
    {"label": "Multiple Choice", "value": "multiple_choice"},
    {"label": "Checkbox", "value": "checkbox"},
    {"label": "Dropdown", "value": "dropdown"},
    {"label": "Rating", "value": "rating"},
    {"label": "Date", "value": "date"},
    {"label": "Number", "value": "number"},
  ];

  final List<Map<String, dynamic>> questionCategories = [
    {"label": "General", "value": "general"},
    {"label": "Demographics", "value": "demographics"},
    {"label": "Content", "value": "content"},
    {"label": "Logistics", "value": "logistics"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Feedback", "value": "feedback"},
  ];

  List<Map<String, dynamic>> get filteredQuestions {
    return questions.where((question) {
      bool matchesSearch = question["question"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || question["category"] == selectedCategory;
      bool matchesType = selectedType == "All" || question["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || question["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesType && matchesStatus;
    }).toList();
  }

  void _addOption() {
    if (newOption.trim().isNotEmpty) {
      options.add(newOption.trim());
      newOption = "";
      setState(() {});
    }
  }

  void _removeOption(int index) {
    options.removeAt(index);
    setState(() {});
  }

  void _clearForm() {
    questionText = "";
    questionType = "text";
    category = "general";
    helpText = "";
    isRequired = false;
    isConditional = false;
    conditionField = "";
    conditionValue = "";
    options.clear();
    newOption = "";
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'draft':
        return warningColor;
      case 'archived':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'general':
        return primaryColor;
      case 'demographics':
        return infoColor;
      case 'content':
        return successColor;
      case 'logistics':
        return warningColor;
      case 'marketing':
        return dangerColor;
      case 'feedback':
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildQuestionsList() {
    return Column(
      children: [
        // Search and Filters
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              QTextField(
                label: "Search Questions",
                value: searchQuery,
                hint: "Search by question text...",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Type",
                      items: questionTypes,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),

        // Questions List
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: filteredQuestions.map((question) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getCategoryColor("${question["category"]}").withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getCategoryColor("${question["category"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${question["category"]}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${question["status"]}"),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${question["status"]}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${question["question"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.quiz,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${question["type"]}".replaceAll('_', ' ').toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        if (question["required"] == true) ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "REQUIRED",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (question["conditional"] == true) ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.alt_route,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "CONDITIONAL",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${question["responses"]} responses",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Modified: ${question["last_modified"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Edit",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Edit question: ${question["question"]}");
                                },
                              ),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                ss("More options for question");
                              },
                            ),
                          ],
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
    );
  }

  Widget _buildCreateQuestion() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
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
                  "Create New Question",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QMemoField(
                  label: "Question Text",
                  value: questionText,
                  hint: "Enter your question here...",
                  validator: Validator.required,
                  onChanged: (value) {
                    questionText = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Question Type",
                        items: newQuestionTypes,
                        value: questionType,
                        onChanged: (value, label) {
                          questionType = value;
                          if (!["multiple_choice", "checkbox", "dropdown"].contains(value)) {
                            options.clear();
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: questionCategories,
                        value: category,
                        onChanged: (value, label) {
                          category = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QMemoField(
                  label: "Help Text (Optional)",
                  value: helpText,
                  hint: "Provide additional context or instructions...",
                  onChanged: (value) {
                    helpText = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Required Question",
                      "value": true,
                      "checked": isRequired,
                    }
                  ],
                  value: [if (isRequired) {"label": "Required Question", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isRequired = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Conditional Question",
                      "value": true,
                      "checked": isConditional,
                    }
                  ],
                  value: [if (isConditional) {"label": "Conditional Question", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isConditional = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                if (isConditional) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Condition Field ID",
                          value: conditionField,
                          hint: "e.g., question_1",
                          onChanged: (value) {
                            conditionField = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Condition Value",
                          value: conditionValue,
                          hint: "e.g., Yes",
                          onChanged: (value) {
                            conditionValue = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                if (["multiple_choice", "checkbox", "dropdown"].contains(questionType)) ...[
                  SizedBox(height: spMd),
                  Text(
                    "Answer Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "New Option",
                          value: newOption,
                          hint: "Enter option text...",
                          onChanged: (value) {
                            newOption = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Add",
                        size: bs.sm,
                        onPressed: _addOption,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _removeOption(index),
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Question",
                        onPressed: () {
                          ss("Question created successfully!");
                          _clearForm();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Clear",
                      color: dangerColor,
                      onPressed: _clearForm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalytics() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Overview Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.quiz,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Questions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${questions.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Active: ${questions.where((q) => q["status"] == "active").length}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Draft: ${questions.where((q) => q["status"] == "draft").length}",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.people,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Responses",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${questions.fold(0, (sum, q) => sum + (q["responses"] as int))}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Avg per Question: ${(questions.fold(0.0, (sum, q) => sum + (q["responses"] as int)) / questions.length).toStringAsFixed(1)}",
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
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.star,
                            color: dangerColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Required Questions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${questions.where((q) => q["required"] == true).length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "${((questions.where((q) => q["required"] == true).length / questions.length) * 100).toStringAsFixed(1)}% of total",
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
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.alt_route,
                            color: warningColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Conditional Questions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${questions.where((q) => q["conditional"] == true).length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Logic-based questions",
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
            ],
          ),
          SizedBox(height: spMd),

          // Category Distribution
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
                  "Questions by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...["general", "demographics", "content", "logistics", "marketing", "feedback"].map((cat) {
                  int count = questions.where((q) => q["category"] == cat).length;
                  double percentage = questions.isEmpty ? 0 : (count / questions.length) * 100;
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _getCategoryColor(cat),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                cat.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "$count (${percentage.toStringAsFixed(1)}%)",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(_getCategoryColor(cat)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Registration Questions",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Questions", icon: Icon(Icons.quiz)),
        Tab(text: "Create", icon: Icon(Icons.add)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildQuestionsList(),
        _buildCreateQuestion(),
        _buildAnalytics(),
      ],
    );
  }
}
