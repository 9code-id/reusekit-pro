import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaAskQuestionView extends StatefulWidget {
  const ElaAskQuestionView({super.key});

  @override
  State<ElaAskQuestionView> createState() => _ElaAskQuestionViewState();
}

class _ElaAskQuestionViewState extends State<ElaAskQuestionView> {
  final formKey = GlobalKey<FormState>();
  
  String questionTitle = "";
  String questionContent = "";
  String selectedSubject = "";
  String selectedDifficulty = "";
  String selectedTags = "";
  int bountyAmount = 0;
  bool isAnonymous = false;
  List<String> attachments = [];

  List<Map<String, dynamic>> subjectItems = [
    {"label": "Select Subject", "value": ""},
    {"label": "Mathematics", "value": "mathematics"},
    {"label": "Physics", "value": "physics"},
    {"label": "Chemistry", "value": "chemistry"},
    {"label": "Biology", "value": "biology"},
    {"label": "Computer Science", "value": "computer_science"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Economics", "value": "economics"},
    {"label": "Statistics", "value": "statistics"},
  ];

  List<Map<String, dynamic>> difficultyItems = [
    {"label": "Select Difficulty Level", "value": ""},
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"},
    {"label": "Expert", "value": "expert"},
  ];

  List<Map<String, dynamic>> bountyOptions = [
    {"label": "No Bounty", "value": 0},
    {"label": "10 Points", "value": 10},
    {"label": "25 Points", "value": 25},
    {"label": "50 Points", "value": 50},
    {"label": "100 Points", "value": 100},
  ];

  List<String> popularTags = [
    "Calculus", "Algebra", "Geometry", "Physics", "Mechanics", 
    "Thermodynamics", "Quantum", "Organic Chemistry", "Inorganic",
    "Cell Biology", "Genetics", "Evolution", "Programming", 
    "Algorithms", "Data Structures", "Machine Learning"
  ];

  List<String> selectedTagsList = [];

  void _toggleTag(String tag) {
    setState(() {
      if (selectedTagsList.contains(tag)) {
        selectedTagsList.remove(tag);
      } else if (selectedTagsList.length < 5) {
        selectedTagsList.add(tag);
      } else {
        sw("You can select maximum 5 tags");
      }
      selectedTags = selectedTagsList.join(", ");
    });
  }

  void _submitQuestion() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Question posted successfully!");
      back();
    }
  }

  void _saveDraft() async {
    showLoading();
    
    // Simulate saving draft
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    si("Question saved as draft");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask a Question"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDraft,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Help Card
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Tips for asking a great question:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "• Be specific and clear in your title\n"
                      "• Provide context and show what you've tried\n"
                      "• Include relevant formulas or code\n"
                      "• Choose appropriate tags and difficulty level",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Question Title
              QTextField(
                label: "Question Title",
                value: questionTitle,
                hint: "What is your specific question?",
                validator: Validator.required,
                onChanged: (value) {
                  questionTitle = value;
                  setState(() {});
                },
              ),

              // Subject and Difficulty
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Subject",
                      items: subjectItems,
                      value: selectedSubject,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedSubject = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Difficulty Level",
                      items: difficultyItems,
                      value: selectedDifficulty,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedDifficulty = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Question Content
              QMemoField(
                label: "Question Details",
                value: questionContent,
                hint: "Provide detailed explanation of your question. Include any formulas, code, or specific examples that help explain your problem.",
                validator: Validator.required,
                onChanged: (value) {
                  questionContent = value;
                  setState(() {});
                },
              ),

              // Tags Section
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Tags (Select up to 5)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    // Selected Tags Display
                    if (selectedTagsList.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(30)),
                        ),
                        child: Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: selectedTagsList.map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tag,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () => _toggleTag(tag),
                                    child: Icon(
                                      Icons.close,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    
                    // Popular Tags
                    Text(
                      "Popular Tags:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: popularTags.map((tag) {
                        bool isSelected = selectedTagsList.contains(tag);
                        return GestureDetector(
                          onTap: () => _toggleTag(tag),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? primaryColor.withAlpha(20)
                                  : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: isSelected ? primaryColor : disabledBoldColor,
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Custom Tags Input
                    QTextField(
                      label: "Custom Tags",
                      value: selectedTags,
                      hint: "Add custom tags separated by commas",
                      onChanged: (value) {
                        selectedTags = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Attachments
              QAttachmentPicker(
                label: "Attachments (Optional)",
                value: attachments,
                hint: "Add images, documents, or code files",
                maxAttachments: 5,
                allowedTypes: ['image', 'document'],
                onChanged: (value) {
                  attachments = value;
                  setState(() {});
                },
              ),

              // Bounty Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.emoji_events, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Offer Bounty (Optional)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Offering points as bounty increases visibility and attracts quality answers.",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 12,
                      ),
                    ),
                    
                    QCategoryPicker(
                      items: bountyOptions.map((option) => {
                        "label": option["label"],
                        "value": option["value"],
                      }).toList(),
                      value: bountyAmount,
                      onChanged: (index, label, value, item) {
                        bountyAmount = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Privacy Options
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Privacy Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "Post anonymously",
                          "value": true,
                          "checked": isAnonymous,
                        }
                      ],
                      value: [if (isAnonymous) {"label": "Post anonymously", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        setState(() {
                          isAnonymous = values.isNotEmpty;
                        });
                      },
                    ),
                    
                    if (isAnonymous)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Your identity will be hidden, but you can still receive notifications for answers and comments.",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Question Preview
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.preview, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Preview",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (questionTitle.isNotEmpty)
                      Text(
                        questionTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (questionContent.isNotEmpty)
                      Text(
                        questionContent,
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (selectedTagsList.isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        children: selectedTagsList.map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),

              // Action Buttons
              Column(
                spacing: spSm,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Post Question",
                      size: bs.md,
                      onPressed: _submitQuestion,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Save as Draft",
                          size: bs.sm,
                          onPressed: _saveDraft,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          size: bs.sm,
                          onPressed: () {
                            back();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
