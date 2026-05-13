import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaDeleteAccountView extends StatefulWidget {
  const SmaDeleteAccountView({super.key});

  @override
  State<SmaDeleteAccountView> createState() => _SmaDeleteAccountViewState();
}

class _SmaDeleteAccountViewState extends State<SmaDeleteAccountView> {
  String selectedReason = "";
  String additionalFeedback = "";
  String confirmationText = "";
  String currentPassword = "";
  bool understandPermanent = false;
  bool confirmDataLoss = false;
  bool backupComplete = false;
  bool finalConfirmation = false;
  
  List<Map<String, dynamic>> deletionReasons = [
    {
      "value": "privacy_concerns",
      "label": "Privacy and data concerns",
      "description": "I don't trust how my data is being handled",
    },
    {
      "value": "no_longer_need",
      "label": "No longer need the service",
      "description": "I've moved to other platforms or don't use social media",
    },
    {
      "value": "harassment",
      "label": "Harassment or safety issues",
      "description": "I've experienced harassment or feel unsafe",
    },
    {
      "value": "technical_issues",
      "label": "Persistent technical problems",
      "description": "The platform doesn't work properly for me",
    },
    {
      "value": "account_security",
      "label": "Account security compromised",
      "description": "My account was hacked or compromised",
    },
    {
      "value": "other",
      "label": "Other reason",
      "description": "Please provide details in the feedback section",
    },
  ];

  void _deleteAccount() async {
    // Validation
    if (selectedReason.isEmpty) {
      se("Please select a reason for deletion");
      return;
    }

    if (currentPassword.isEmpty) {
      se("Please enter your current password");
      return;
    }

    if (confirmationText.toLowerCase() != "delete my account") {
      se("Please type 'DELETE MY ACCOUNT' exactly as shown");
      return;
    }

    if (!understandPermanent || !confirmDataLoss || !backupComplete || !finalConfirmation) {
      se("Please confirm all checkboxes to proceed");
      return;
    }

    bool isConfirmed = await confirm("This is your final warning. Are you absolutely sure you want to permanently delete your account? This action CANNOT be undone.");
    if (isConfirmed) {
      // Show loading
      showLoading();
      
      // Simulate deletion process
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      ss("Account deletion initiated. You will receive a confirmation email shortly.");
      
      // Navigate to goodbye screen or login
      // navigateTo(AccountDeletedView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Account"),
        backgroundColor: dangerColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Danger Warning
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor, width: 2),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: dangerColor, size: 28),
                      SizedBox(width: spSm),
                      Text(
                        "PERMANENT DELETION",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "This action is irreversible. Once deleted, your account and all associated data will be permanently removed and cannot be recovered.",
                    style: TextStyle(
                      fontSize: 15,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // What Will Be Deleted
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "What will be permanently deleted:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    
                    _buildDeletionItem(
                      Icons.person,
                      "Profile & Personal Information",
                      "Your profile, bio, personal details, and settings",
                    ),
                    
                    _buildDeletionItem(
                      Icons.article,
                      "Posts & Content",
                      "All your posts, photos, videos, stories, and comments",
                    ),
                    
                    _buildDeletionItem(
                      Icons.people,
                      "Connections & Social Data",
                      "Your friends, followers, following lists, and social connections",
                    ),
                    
                    _buildDeletionItem(
                      Icons.chat,
                      "Messages & Conversations",
                      "All private messages, group chats, and conversation history",
                    ),
                    
                    _buildDeletionItem(
                      Icons.photo_library,
                      "Media Files",
                      "All uploaded photos, videos, and other media content",
                    ),
                    
                    _buildDeletionItem(
                      Icons.analytics,
                      "Activity & Analytics",
                      "Your activity history, insights, and usage analytics",
                    ),
                  ],
                ),
              ),
            ),

            // Before You Delete
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
                      "Before you delete your account:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(40)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.download, color: infoColor, size: 20),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Download your data first",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "Get a copy of your posts, photos, and messages",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Download",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(DownloadDataView());
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(40)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.pause_circle, color: warningColor, size: 20),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Consider deactivation instead",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "Temporarily disable your account - you can come back anytime",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Deactivate",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(DeactivateAccountView());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Reason for Deletion
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
                      "Why are you deleting your account?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    ...deletionReasons.map((reason) {
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
                                  color: isSelected ? dangerColor : disabledOutlineBorderColor,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(radiusSm),
                                color: isSelected ? dangerColor.withAlpha(10) : Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isSelected ? dangerColor : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected ? dangerColor : disabledColor,
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
                                            color: isSelected ? dangerColor : Colors.black,
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
              hint: "Help us understand what went wrong or how we could improve...",
              onChanged: (value) {
                additionalFeedback = value;
                setState(() {});
              },
            ),

            // Security Verification
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
                      "Security Verification",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    QTextField(
                      label: "Current Password",
                      value: currentPassword,
                      hint: "Enter your current password to verify identity",
                      obscureText: true,
                      validator: Validator.required,
                      onChanged: (value) {
                        currentPassword = value;
                        setState(() {});
                      },
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type 'DELETE MY ACCOUNT' to confirm:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QTextField(
                          label: "Confirmation Text",
                          value: confirmationText,
                          hint: "DELETE MY ACCOUNT",
                          onChanged: (value) {
                            confirmationText = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Final Confirmations
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
                      "Final Confirmations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "I understand this action is permanent and irreversible",
                          "value": true,
                          "checked": understandPermanent,
                        }
                      ],
                      value: [if (understandPermanent) {"label": "I understand this action is permanent and irreversible", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        understandPermanent = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "I acknowledge that all my data will be permanently lost",
                          "value": true,
                          "checked": confirmDataLoss,
                        }
                      ],
                      value: [if (confirmDataLoss) {"label": "I acknowledge that all my data will be permanently lost", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        confirmDataLoss = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "I have backed up any important data I want to keep",
                          "value": true,
                          "checked": backupComplete,
                        }
                      ],
                      value: [if (backupComplete) {"label": "I have backed up any important data I want to keep", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        backupComplete = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "I confirm that I want to permanently delete my account",
                          "value": true,
                          "checked": finalConfirmation,
                        }
                      ],
                      value: [if (finalConfirmation) {"label": "I confirm that I want to permanently delete my account", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        finalConfirmation = values.isNotEmpty;
                        setState(() {});
                      },
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
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _deleteAccount,
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spMd),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_forever, color: Colors.white, size: 20),
                              SizedBox(width: spSm),
                              Text(
                                "Delete Account",
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

  Widget _buildDeletionItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: dangerColor, size: 20),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
