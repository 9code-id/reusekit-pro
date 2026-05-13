import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPollCreationView extends StatefulWidget {
  const SmaPollCreationView({super.key});

  @override
  State<SmaPollCreationView> createState() => _SmaPollCreationViewState();
}

class _SmaPollCreationViewState extends State<SmaPollCreationView> {
  String pollQuestion = "";
  List<String> pollOptions = ["", ""];
  String pollDuration = "1_day";
  bool allowMultipleChoices = false;
  bool anonymousVoting = false;
  String pollType = "text";
  bool isLoading = false;

  List<Map<String, dynamic>> durationOptions = [
    {"label": "1 Hour", "value": "1_hour"},
    {"label": "6 Hours", "value": "6_hours"},
    {"label": "12 Hours", "value": "12_hours"},
    {"label": "1 Day", "value": "1_day"},
    {"label": "3 Days", "value": "3_days"},
    {"label": "1 Week", "value": "1_week"},
    {"label": "Never Expires", "value": "never"},
  ];

  List<Map<String, dynamic>> pollTypeOptions = [
    {"label": "Text Poll", "value": "text"},
    {"label": "Image Poll", "value": "image"},
    {"label": "Rating Poll", "value": "rating"},
  ];

  void _addPollOption() {
    if (pollOptions.length < 6) {
      pollOptions.add("");
      setState(() {});
    } else {
      sw("Maximum 6 poll options allowed");
    }
  }

  void _removePollOption(int index) {
    if (pollOptions.length > 2) {
      pollOptions.removeAt(index);
      setState(() {});
    } else {
      sw("Minimum 2 poll options required");
    }
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

    isLoading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    setState(() {});

    ss("Poll created successfully!");
    // navigateTo(SmaHomeFeedView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Poll"),
        actions: [
          QButton(
            label: isLoading ? "Creating..." : "Create Poll",
            size: bs.sm,
            onPressed: isLoading ? null : _createPoll,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poll Preview
            Container(
              width: double.infinity,
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
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "You",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.poll,
                        color: secondaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Text(
                    pollQuestion.isEmpty ? "Your poll question will appear here..." : pollQuestion,
                    style: TextStyle(
                      fontSize: 16,
                      color: pollQuestion.isEmpty ? Colors.grey : primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Poll Options Preview
                  Column(
                    children: pollOptions.asMap().entries.map((entry) {
                      int index = entry.key;
                      String option = entry.value;
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(
                                  color: primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                option.isEmpty ? "Option ${index + 1}" : option,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: option.isEmpty ? Colors.grey : primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "0%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Ends in ${durationOptions.firstWhere((d) => d["value"] == pollDuration)["label"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (allowMultipleChoices) ...[
                        SizedBox(width: spSm),
                        Icon(
                          Icons.check_box,
                          size: 14,
                          color: secondaryColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Multiple choices allowed",
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Poll Question Input
            QTextField(
              label: "Poll Question",
              value: pollQuestion,
              hint: "Ask something interesting...",
              validator: Validator.required,
              onChanged: (value) {
                pollQuestion = value;
                setState(() {});
              },
            ),

            // Poll Type Selection
            QDropdownField(
              label: "Poll Type",
              items: pollTypeOptions,
              value: pollType,
              onChanged: (value, label) {
                pollType = value;
                setState(() {});
              },
            ),

            // Poll Options
            Text(
              "Poll Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              children: pollOptions.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Option ${index + 1}",
                          value: option,
                          hint: "Enter poll option...",
                          onChanged: (value) {
                            pollOptions[index] = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      if (pollOptions.length > 2)
                        QButton(
                          icon: Icons.remove_circle,
                          size: bs.sm,
                          onPressed: () => _removePollOption(index),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Add Option Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add Another Option",
                icon: Icons.add,
                size: bs.sm,
                onPressed: pollOptions.length < 6 ? _addPollOption : null,
              ),
            ),

            // Poll Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Poll Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Duration
                  QDropdownField(
                    label: "Poll Duration",
                    items: durationOptions,
                    value: pollDuration,
                    onChanged: (value, label) {
                      pollDuration = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Multiple Choices Switch
                  QSwitch(
                    items: [
                      {
                        "label": "Allow multiple choices",
                        "value": true,
                        "checked": allowMultipleChoices,
                      }
                    ],
                    value: [
                      if (allowMultipleChoices)
                        {
                          "label": "Allow multiple choices",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      allowMultipleChoices = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),

                  // Anonymous Voting Switch
                  QSwitch(
                    items: [
                      {
                        "label": "Anonymous voting",
                        "value": true,
                        "checked": anonymousVoting,
                      }
                    ],
                    value: [
                      if (anonymousVoting)
                        {
                          "label": "Anonymous voting",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      anonymousVoting = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Poll Statistics Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "People will be able to see poll results and vote counts in real-time",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (isLoading)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(strokeWidth: 2),
                    SizedBox(width: spSm),
                    Text(
                      "Creating your poll...",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
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
