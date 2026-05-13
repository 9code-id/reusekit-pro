import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaDeleteAccountView extends StatefulWidget {
  const SpaDeleteAccountView({super.key});

  @override
  State<SpaDeleteAccountView> createState() => _SpaDeleteAccountViewState();
}

class _SpaDeleteAccountViewState extends State<SpaDeleteAccountView> {
  bool confirmDeletion = false;
  String deleteReason = "";
  String feedbackText = "";
  String currentPassword = "";
  bool showPasswordField = false;
  int currentStep = 0;
  
  List<String> selectedReasons = [];
  
  List<Map<String, dynamic>> deleteReasons = [
    {
      "label": "Not using the spa services frequently enough",
      "value": "infrequent_use",
      "icon": Icons.schedule,
    },
    {
      "label": "Found better spa services elsewhere",
      "value": "better_alternative",
      "icon": Icons.star,
    },
    {
      "label": "Disappointed with service quality",
      "value": "poor_quality",
      "icon": Icons.thumb_down,
    },
    {
      "label": "Too expensive for my budget",
      "value": "expensive",
      "icon": Icons.attach_money,
    },
    {
      "label": "Privacy concerns",
      "value": "privacy",
      "icon": Icons.privacy_tip,
    },
    {
      "label": "Moving to a different location",
      "value": "relocation",
      "icon": Icons.location_off,
    },
    {
      "label": "Technical issues with the app",
      "value": "technical_issues",
      "icon": Icons.bug_report,
    },
    {
      "label": "Other reason",
      "value": "other",
      "icon": Icons.more_horiz,
    },
  ];

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
            // Warning Header
            _buildWarningHeader(),

            // Stepper Content
            _buildStepperContent(),

            // Navigation Buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor, width: 2),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            Icons.warning_amber,
            color: dangerColor,
            size: 48,
          ),
          Text(
            "Account Deletion Warning",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: dangerColor,
            ),
          ),
          Text(
            "This action cannot be undone. All your spa bookings, loyalty points, treatment history, and personal data will be permanently deleted.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Step Indicator
          _buildStepIndicator(),
          
          // Step Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: _buildCurrentStepContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusMd),
          topRight: Radius.circular(radiusMd),
        ),
      ),
      child: Row(
        children: [
          _buildStepIcon(0, "Reason", Icons.help_outline),
          _buildStepConnector(currentStep > 0),
          _buildStepIcon(1, "Feedback", Icons.rate_review),
          _buildStepConnector(currentStep > 1),
          _buildStepIcon(2, "Confirm", Icons.security),
        ],
      ),
    );
  }

  Widget _buildStepIcon(int step, String label, IconData icon) {
    bool isActive = currentStep == step;
    bool isCompleted = currentStep > step;
    
    return Column(
      spacing: spXs,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isCompleted 
                ? successColor 
                : isActive 
                    ? primaryColor 
                    : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: isCompleted || isActive ? Colors.white : disabledBoldColor,
            size: 20,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? primaryColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(bool isCompleted) {
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.only(bottom: 20),
        color: isCompleted ? successColor : Colors.grey[300],
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 0:
        return _buildReasonStep();
      case 1:
        return _buildFeedbackStep();
      case 2:
        return _buildConfirmStep();
      default:
        return Container();
    }
  }

  Widget _buildReasonStep() {
    return Column(
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
        Text(
          "Help us improve by telling us why you're leaving. Select all that apply:",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        // Reason Options
        Column(
          spacing: spSm,
          children: deleteReasons.map((reason) {
            bool isSelected = selectedReasons.contains(reason["value"]);
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedReasons.remove(reason["value"]);
                  } else {
                    selectedReasons.add(reason["value"]);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(25) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      reason["icon"] as IconData,
                      color: isSelected ? primaryColor : disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${reason["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: primaryColor,
                        size: 20,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFeedbackStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Additional Feedback (Optional)",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Is there anything specific you'd like us to know? Your feedback helps us improve our services.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        
        QMemoField(
          label: "Your feedback",
          value: feedbackText,
          hint: "Tell us more about your experience or what could have been better...",
          onChanged: (value) {
            feedbackText = value;
            setState(() {});
          },
        ),
        
        // Selected Reasons Summary
        if (selectedReasons.isNotEmpty) ...[
          Text(
            "Selected Reasons:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: selectedReasons.map((reasonValue) {
              final reason = deleteReasons.firstWhere(
                (r) => r["value"] == reasonValue,
              );
              
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      reason["icon"] as IconData,
                      size: 14,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${reason["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildConfirmStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Final Confirmation",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        // What will be deleted
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: dangerColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: dangerColor.withAlpha(100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "The following data will be permanently deleted:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: dangerColor,
                ),
              ),
              
              // Data List
              ...[
                "All booking history and upcoming appointments",
                "Loyalty points and rewards",
                "Treatment preferences and notes",
                "Personal profile information",
                "Payment methods and billing history",
                "Reviews and ratings",
                "Communication preferences",
              ].map((item) => Row(
                children: [
                  Icon(Icons.close, color: dangerColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
        
        // Password Confirmation
        QTextField(
          label: "Enter your password to confirm",
          value: currentPassword,
          obscureText: true,
          validator: Validator.required,
          onChanged: (value) {
            currentPassword = value;
            setState(() {});
          },
        ),
        
        // Final Confirmation Checkbox
        Row(
          children: [
            Checkbox(
              value: confirmDeletion,
              onChanged: (value) {
                confirmDeletion = value ?? false;
                setState(() {});
              },
              activeColor: dangerColor,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  confirmDeletion = !confirmDeletion;
                  setState(() {});
                },
                child: Text(
                  "I understand that this action cannot be undone and all my data will be permanently deleted.",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        
        // Alternative Options
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb, color: infoColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "Consider These Alternatives:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
              Text(
                "• Temporarily deactivate your account instead\n• Update your preferences to reduce notifications\n• Contact our support team to resolve any issues",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      spacing: spSm,
      children: [
        if (currentStep > 0)
          Expanded(
            child: QButton(
              label: "Previous",
              color: Colors.grey,
              size: bs.md,
              onPressed: () {
                setState(() {
                  currentStep--;
                });
              },
            ),
          ),
        
        Expanded(
          child: QButton(
            label: currentStep == 2 ? "Delete Account" : "Next",
            color: currentStep == 2 ? dangerColor : primaryColor,
            size: bs.md,
            onPressed: _canProceed() ? () {
              if (currentStep == 2) {
                _deleteAccount();
              } else {
                setState(() {
                  currentStep++;
                });
              }
            } : null,
          ),
        ),
      ],
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return selectedReasons.isNotEmpty;
      case 1:
        return true; // Feedback is optional
      case 2:
        return confirmDeletion && currentPassword.isNotEmpty;
      default:
        return false;
    }
  }

  void _deleteAccount() async {
    bool isConfirmed = await confirm(
      "Are you absolutely sure you want to delete your account? This action cannot be undone."
    );
    
    if (isConfirmed) {
      ss("Account deletion initiated");
      // Navigate back or to login screen
      //navigateTo ( LoginView )
    }
  }
}
