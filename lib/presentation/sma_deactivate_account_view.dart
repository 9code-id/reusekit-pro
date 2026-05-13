import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaDeactivateAccountView extends StatefulWidget {
  const SmaDeactivateAccountView({super.key});

  @override
  State<SmaDeactivateAccountView> createState() => _SmaDeactivateAccountViewState();
}

class _SmaDeactivateAccountViewState extends State<SmaDeactivateAccountView> {
  String selectedReason = "";
  String additionalFeedback = "";
  bool understandConsequences = false;
  bool wantUpdates = true;
  String reactivationEmail = "";
  bool confirmDeactivation = false;

  List<Map<String, dynamic>> deactivationReasons = [
    {
      "value": "privacy_concerns",
      "label": "Privacy concerns",
      "description": "I'm worried about how my data is being used",
    },
    {
      "value": "too_much_time",
      "label": "Spending too much time on social media",
      "description": "I want to take a break and focus on other things",
    },
    {
      "value": "harassment",
      "label": "Harassment or bullying",
      "description": "I'm experiencing negative interactions",
    },
    {
      "value": "not_useful",
      "label": "Not finding it useful anymore",
      "description": "The platform doesn't meet my needs",
    },
    {
      "value": "technical_issues",
      "label": "Technical problems",
      "description": "I'm having trouble with the app or website",
    },
    {
      "value": "other",
      "label": "Other reason",
      "description": "Please specify in the additional feedback section",
    },
  ];

  void _deactivateAccount() async {
    if (selectedReason.isEmpty) {
      se("Please select a reason for deactivation");
      return;
    }

    if (!understandConsequences) {
      se("Please confirm you understand the consequences");
      return;
    }

    if (!confirmDeactivation) {
      se("Please confirm you want to deactivate your account");
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to deactivate your account? You can reactivate it anytime by logging back in.");
    if (isConfirmed) {
      ss("Account deactivated successfully. You can reactivate by logging in anytime.");
      // navigateTo(LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deactivate Account"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Warning Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber, color: warningColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Account Deactivation",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "We're sorry to see you go! Before you deactivate your account, please let us know why you're leaving so we can improve our service.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // What Happens Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "What happens when you deactivate?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    // Immediate effects
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.visibility_off, color: warningColor, size: 20),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your profile will be hidden",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Other users won't be able to find or view your profile",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.chat_bubble_outline, color: infoColor, size: 20),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Messages will be preserved",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Your chat history remains intact for when you return",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.restore, color: successColor, size: 20),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Easy reactivation",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Simply log in again to reactivate your account",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Reason for Deactivation
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Why are you leaving?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Your feedback helps us improve the platform for everyone",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    ...deactivationReasons.map((reason) {
                      bool isSelected = selectedReason == reason["value"];
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              selectedReason = reason["value"];
                              setState(() {});
                            },
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(radiusSm),
                                color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isSelected ? primaryColor : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected ? primaryColor : disabledColor,
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: isSelected
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 12,
                                          )
                                        : null,
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${reason["label"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected ? primaryColor : Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "${reason["description"]}",
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
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            // Additional Feedback
            QMemoField(
              label: "Additional feedback (optional)",
              value: additionalFeedback,
              hint: "Tell us more about your decision or how we could improve...",
              onChanged: (value) {
                additionalFeedback = value;
                setState(() {});
              },
            ),

            // Reactivation Email
            QTextField(
              label: "Email for reactivation reminders (optional)",
              value: reactivationEmail,
              hint: "We'll send friendly reminders about new features",
              onChanged: (value) {
                reactivationEmail = value;
                setState(() {});
              },
            ),

            // Checkboxes
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Updates checkbox
                    QSwitch(
                      items: [
                        {
                          "label": "Keep me updated about new features and improvements",
                          "value": true,
                          "checked": wantUpdates,
                        }
                      ],
                      value: [if (wantUpdates) {"label": "Keep me updated about new features and improvements", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        wantUpdates = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    // Understanding consequences
                    QSwitch(
                      items: [
                        {
                          "label": "I understand the consequences of deactivating my account",
                          "value": true,
                          "checked": understandConsequences,
                        }
                      ],
                      value: [if (understandConsequences) {"label": "I understand the consequences of deactivating my account", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        understandConsequences = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    // Final confirmation
                    QSwitch(
                      items: [
                        {
                          "label": "I confirm that I want to deactivate my account",
                          "value": true,
                          "checked": confirmDeactivation,
                        }
                      ],
                      value: [if (confirmDeactivation) {"label": "I confirm that I want to deactivate my account", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        confirmDeactivation = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Alternative Actions
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    Text(
                      "Maybe try these alternatives first?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Privacy Settings",
                            icon: Icons.privacy_tip,
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(PrivacySettingsView());
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Notification Settings",
                            icon: Icons.notifications,
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(NotificationSettingsView());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: warningColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _deactivateAccount,
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.pause_circle, color: Colors.white, size: 20),
                              SizedBox(width: spSm),
                              Text(
                                "Deactivate Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
