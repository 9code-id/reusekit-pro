import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaAnswerQuestionView extends StatefulWidget {
  const ElaAnswerQuestionView({super.key});

  @override
  State<ElaAnswerQuestionView> createState() => _ElaAnswerQuestionViewState();
}

class _ElaAnswerQuestionViewState extends State<ElaAnswerQuestionView> {
  final formKey = GlobalKey<FormState>();
  
  String answerContent = "";
  List<String> attachments = [];
  bool isMarkdownMode = false;
  bool isAnonymous = false;

  // Sample question data
  Map<String, dynamic> question = {
    "id": 1,
    "title": "How to solve complex integration by parts?",
    "content": "I'm struggling with integration by parts when dealing with complex functions like ∫ x²e^x dx and ∫ ln(x)dx. Can someone provide a step-by-step approach with clear explanations?\n\nI understand the basic formula ∫udv = uv - ∫vdu, but I'm confused about choosing the right u and dv parts. When should I choose which function as u?",
    "subject": "Mathematics",
    "difficulty": "Advanced",
    "author": "Sarah Johnson",
    "authorAvatar": "https://picsum.photos/40/40?random=1&keyword=student",
    "timestamp": "2024-01-15 10:30:00",
    "votes": 15,
    "views": 89,
    "bounty": 50,
    "tags": ["Calculus", "Integration", "Advanced Math"],
  };

  List<Map<String, dynamic>> existingAnswers = [
    {
      "id": 1,
      "author": "Dr. Michael Chen",
      "authorAvatar": "https://picsum.photos/40/40?random=2&keyword=teacher",
      "content": "Great question! The key to integration by parts is the LIATE rule for choosing u:\n\nL - Logarithmic functions (ln x, log x)\nI - Inverse trigonometric functions (arcsin x, arccos x)\nA - Algebraic functions (x², x³, polynomials)\nT - Trigonometric functions (sin x, cos x)\nE - Exponential functions (e^x, 2^x)\n\nFor ∫ x²e^x dx:\n- Choose u = x² (algebraic)\n- Choose dv = e^x dx (exponential)\n\nThis gives us du = 2x dx and v = e^x\n\nApplying the formula: ∫ x²e^x dx = x²e^x - ∫ e^x(2x) dx\n\nYou'll need to apply integration by parts again to solve ∫ 2xe^x dx.",
      "timestamp": "2024-01-15 11:15:00",
      "votes": 23,
      "isAccepted": true,
      "isUpvoted": false,
      "isDownvoted": false,
    },
    {
      "id": 2,
      "author": "Alex Rodriguez",
      "authorAvatar": "https://picsum.photos/40/40?random=3&keyword=student",
      "content": "I found this memory trick helpful: think of LIATE as the priority order. Always choose the function that comes first in LIATE as your 'u'.\n\nFor ln(x), since L comes first, ln(x) is always your u when paired with other functions.",
      "timestamp": "2024-01-15 12:30:00",
      "votes": 8,
      "isAccepted": false,
      "isUpvoted": true,
      "isDownvoted": false,
    },
  ];

  void _submitAnswer() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Answer submitted successfully!");
      back();
    }
  }

  void _saveDraft() async {
    showLoading();
    
    // Simulate saving draft
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    si("Answer saved as draft");
  }

  void _toggleVote(Map<String, dynamic> answer, bool isUpvote) {
    setState(() {
      bool currentUpvoted = answer["isUpvoted"] as bool;
      bool currentDownvoted = answer["isDownvoted"] as bool;
      int currentVotes = answer["votes"] as int;
      
      if (isUpvote) {
        if (currentUpvoted) {
          answer["isUpvoted"] = false;
          answer["votes"] = currentVotes - 1;
        } else {
          answer["isUpvoted"] = true;
          answer["isDownvoted"] = false;
          answer["votes"] = currentVotes + 1 + (currentDownvoted ? 1 : 0);
        }
      } else {
        if (currentDownvoted) {
          answer["isDownvoted"] = false;
          answer["votes"] = currentVotes + 1;
        } else {
          answer["isDownvoted"] = true;
          answer["isUpvoted"] = false;
          answer["votes"] = currentVotes - 1 - (currentUpvoted ? 1 : 0);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Answer Question"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDraft,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Question Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  // Question Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage("${question["authorAvatar"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${question["author"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(question["timestamp"]).dMMMy}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if ((question["bounty"] as int) > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.emoji_events,
                                size: 12,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${question["bounty"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  // Question Title
                  Text(
                    "${question["title"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Question Content
                  Text(
                    "${question["content"]}",
                    style: TextStyle(
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),

                  // Tags
                  Wrap(
                    spacing: spXs,
                    children: (question["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Question Stats
                  Row(
                    children: [
                      Icon(Icons.thumb_up, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${question["votes"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${question["views"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Existing Answers
            if (existingAnswers.isNotEmpty)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Existing Answers (${existingAnswers.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    ...existingAnswers.map((answer) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: answer["isAccepted"] as bool 
                              ? Border.all(color: successColor, width: 2)
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            // Answer Header
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage("${answer["authorAvatar"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${answer["author"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          if (answer["isAccepted"] as bool) ...[
                                            SizedBox(width: spXs),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                              decoration: BoxDecoration(
                                                color: successColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    size: 10,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(
                                                    "ACCEPTED",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${DateTime.parse(answer["timestamp"]).dMMMy}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Answer Content
                            Text(
                              "${answer["content"]}",
                              style: TextStyle(
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),

                            // Voting
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _toggleVote(answer, true),
                                        child: Container(
                                          padding: EdgeInsets.all(spXs),
                                          child: Icon(
                                            Icons.keyboard_arrow_up,
                                            size: 20,
                                            color: answer["isUpvoted"] as bool 
                                                ? primaryColor 
                                                : disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${answer["votes"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: answer["isUpvoted"] as bool 
                                              ? primaryColor 
                                              : answer["isDownvoted"] as bool 
                                                  ? dangerColor 
                                                  : Colors.black87,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _toggleVote(answer, false),
                                        child: Container(
                                          padding: EdgeInsets.all(spXs),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 20,
                                            color: answer["isDownvoted"] as bool 
                                                ? dangerColor 
                                                : disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                Spacer(),
                                
                                QButton(
                                  label: "Comment",
                                  size: bs.sm,
                                  onPressed: () {
                                    // navigateTo('CommentView')
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            // Writing Guidelines
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
                        "Tips for writing a great answer:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Provide step-by-step explanations\n"
                    "• Include examples and formulas\n"
                    "• Explain the reasoning behind your approach\n"
                    "• Use clear formatting with code blocks or math notation",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Answer Form
            Form(
              key: formKey,
              child: Column(
                spacing: spMd,
                children: [
                  // Mode Toggle
                  Row(
                    children: [
                      Text(
                        "Your Answer",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            "Markdown",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMarkdownMode = !isMarkdownMode;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 20,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: isMarkdownMode ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AnimatedAlign(
                                alignment: isMarkdownMode ? Alignment.centerRight : Alignment.centerLeft,
                                duration: Duration(milliseconds: 200),
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Answer Content
                  QMemoField(
                    label: "Answer Content",
                    value: answerContent,
                    hint: isMarkdownMode 
                        ? "Write your answer using Markdown formatting...\n\n**Bold text**\n*Italic text*\n```code```\n> Quote\n- List item"
                        : "Provide a detailed, step-by-step answer to help the questioner understand the solution...",
                    validator: Validator.required,
                    onChanged: (value) {
                      answerContent = value;
                      setState(() {});
                    },
                  ),

                  // Attachments
                  QAttachmentPicker(
                    label: "Supporting Files (Optional)",
                    value: attachments,
                    hint: "Add images, diagrams, or code files to support your answer",
                    maxAttachments: 3,
                    allowedTypes: ['image', 'document'],
                    onChanged: (value) {
                      attachments = value;
                      setState(() {});
                    },
                  ),

                  // Privacy Options
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: QSwitch(
                      items: [
                        {
                          "label": "Post answer anonymously",
                          "value": true,
                          "checked": isAnonymous,
                        }
                      ],
                      value: [if (isAnonymous) {"label": "Post answer anonymously", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        setState(() {
                          isAnonymous = values.isNotEmpty;
                        });
                      },
                    ),
                  ),

                  // Preview
                  if (answerContent.isNotEmpty)
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
                                "Answer Preview",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            answerContent,
                            style: TextStyle(
                              color: Colors.black87,
                              height: 1.5,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
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
                          label: "Submit Answer",
                          size: bs.md,
                          onPressed: _submitAnswer,
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
          ],
        ),
      ),
    );
  }
}
