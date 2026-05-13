import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPost3View extends StatefulWidget {
  @override
  State<GrlPost3View> createState() => _GrlPost3ViewState();
}

class _GrlPost3ViewState extends State<GrlPost3View> {
  String pollQuestion = "";
  List<String> pollOptions = ["", ""];
  String pollDuration = "24 hours";
  bool allowMultipleAnswers = false;
  bool showResultsImmediately = true;
  String postCaption = "";
  
  List<String> durationOptions = [
    "1 hour",
    "6 hours", 
    "12 hours",
    "24 hours",
    "3 days",
    "1 week"
  ];

  List<Map<String, dynamic>> pollTemplates = [
    {
      "title": "This or That",
      "question": "Which do you prefer?",
      "options": ["Option A", "Option B"],
      "description": "Simple choice between two options"
    },
    {
      "title": "Rating Scale",
      "question": "How would you rate this?",
      "options": ["Excellent", "Good", "Average", "Poor"],
      "description": "Rate something on a scale"
    },
    {
      "title": "Yes or No",
      "question": "Do you agree?",
      "options": ["Yes", "No"],
      "description": "Simple yes/no question"
    },
    {
      "title": "Multiple Choice",
      "question": "What's your favorite?",
      "options": ["Option 1", "Option 2", "Option 3", "Option 4"],
      "description": "Choose from multiple options"
    }
  ];

  void _addOption() {
    if (pollOptions.length < 6) {
      setState(() {
        pollOptions.add("");
      });
    }
  }

  void _removeOption(int index) {
    if (pollOptions.length > 2) {
      setState(() {
        pollOptions.removeAt(index);
      });
    }
  }

  void _updateOption(int index, String value) {
    setState(() {
      pollOptions[index] = value;
    });
  }

  void _useTemplate(Map<String, dynamic> template) {
    setState(() {
      pollQuestion = template["question"];
      pollOptions = List<String>.from(template["options"]);
    });
  }

  void _createPoll() async {
    if (pollQuestion.trim().isEmpty) {
      se("Please enter a poll question");
      return;
    }

    if (pollOptions.where((option) => option.trim().isNotEmpty).length < 2) {
      se("Please provide at least 2 poll options");
      return;
    }

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Poll created and published successfully!");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Poll"),
        actions: [
          QButton(
            label: "Create Poll",
            size: bs.sm,
            onPressed: _createPoll,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Poll Templates
            Text(
              "Poll Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: pollTemplates.map((template) {
                  return GestureDetector(
                    onTap: () => _useTemplate(template),
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.poll,
                                  color: primaryColor,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${template["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${template["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            // Poll Question
            QTextField(
              label: "Poll Question",
              value: pollQuestion,
              hint: "What would you like to ask your audience?",
              validator: Validator.required,
              onChanged: (value) {
                setState(() {
                  pollQuestion = value;
                });
              },
            ),
            
            // Poll Options
            Text(
              "Poll Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            
            ...pollOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              
              return Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Option ${index + 1}",
                      value: option,
                      hint: "Enter poll option",
                      onChanged: (value) => _updateOption(index, value),
                    ),
                  ),
                  SizedBox(width: spSm),
                  if (pollOptions.length > 2)
                    QButton(
                      icon: Icons.remove,
                      size: bs.sm,
                      onPressed: () => _removeOption(index),
                    ),
                ],
              );
            }).toList(),
            
            // Add Option Button
            if (pollOptions.length < 6)
              Row(
                children: [
                  QButton(
                    label: "Add Option",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: _addOption,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${pollOptions.length}/6 options",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            
            // Poll Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Poll Settings",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Poll Duration
                  QDropdownField(
                    label: "Poll Duration",
                    items: durationOptions.map((duration) => {
                      "label": duration,
                      "value": duration,
                    }).toList(),
                    value: pollDuration,
                    onChanged: (value, label) {
                      setState(() {
                        pollDuration = value;
                      });
                    },
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Multiple Answers Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Allow Multiple Answers",
                              "value": true,
                              "checked": allowMultipleAnswers,
                            }
                          ],
                          value: allowMultipleAnswers ? [{
                            "label": "Allow Multiple Answers",
                            "value": true,
                            "checked": true
                          }] : [],
                          onChanged: (values, ids) {
                            setState(() {
                              allowMultipleAnswers = values.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Show Results Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show Results Immediately",
                              "value": true,
                              "checked": showResultsImmediately,
                            }
                          ],
                          value: showResultsImmediately ? [{
                            "label": "Show Results Immediately",
                            "value": true,
                            "checked": true
                          }] : [],
                          onChanged: (values, ids) {
                            setState(() {
                              showResultsImmediately = values.isNotEmpty;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Post Caption
            QMemoField(
              label: "Post Caption (Optional)",
              value: postCaption,
              hint: "Add a caption to provide context for your poll...",
              onChanged: (value) {
                setState(() {
                  postCaption = value;
                });
              },
            ),
            
            // Poll Preview
            if (pollQuestion.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Poll Preview",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    // User Header
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage("https://picsum.photos/100/100?random=220&keyword=profile"),
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
                                "John Doe",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Just now • Public",
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
                    
                    if (postCaption.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Text(
                        postCaption,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),
                    ],
                    
                    SizedBox(height: spSm),
                    
                    // Poll Container
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.poll, color: primaryColor, size: 20),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  pollQuestion,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          // Poll Options
                          ...pollOptions.where((option) => option.trim().isNotEmpty).map((option) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: primaryColor, width: 2),
                                      borderRadius: BorderRadius.circular(allowMultipleAnswers ? radiusXs : radiusLg),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          
                          SizedBox(height: spSm),
                          
                          // Poll Info
                          Row(
                            children: [
                              Text(
                                "Poll ends in $pollDuration",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              if (allowMultipleAnswers)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Multiple answers allowed",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Engagement Actions
                    Row(
                      children: [
                        Icon(Icons.how_to_vote, color: disabledBoldColor, size: 18),
                        SizedBox(width: spXs),
                        Text(
                          "0 votes",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(Icons.chat_bubble_outline, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(Icons.share, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "0",
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
            
            // Poll Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Poll Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• Ask clear, specific questions\n• Keep options concise and distinct\n• Consider your audience when choosing options\n• Use polls to gather feedback and engage your community",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
