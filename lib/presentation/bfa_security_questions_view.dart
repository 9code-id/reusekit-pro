import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaSecurityQuestionsView extends StatefulWidget {
  const BfaSecurityQuestionsView({super.key});

  @override
  State<BfaSecurityQuestionsView> createState() => _BfaSecurityQuestionsViewState();
}

class _BfaSecurityQuestionsViewState extends State<BfaSecurityQuestionsView> {
  final formKey = GlobalKey<FormState>();
  String selectedQuestion1 = "";
  String answer1 = "";
  String selectedQuestion2 = "";
  String answer2 = "";
  String selectedQuestion3 = "";
  String answer3 = "";
  bool loading = false;

  List<Map<String, dynamic>> securityQuestions = [
    {"label": "What was the name of your first pet?", "value": "first_pet"},
    {"label": "What is your mother's maiden name?", "value": "mother_maiden"},
    {"label": "What was the name of your first school?", "value": "first_school"},
    {"label": "What city were you born in?", "value": "birth_city"},
    {"label": "What was your childhood nickname?", "value": "childhood_nickname"},
    {"label": "What is the name of your favorite teacher?", "value": "favorite_teacher"},
    {"label": "What was the make of your first car?", "value": "first_car"},
    {"label": "What is your favorite book?", "value": "favorite_book"},
    {"label": "What street did you live on in third grade?", "value": "third_grade_street"},
    {"label": "What is your favorite food?", "value": "favorite_food"},
    {"label": "Where did you meet your spouse/partner?", "value": "meet_partner"},
    {"label": "What was the name of your first boss?", "value": "first_boss"},
  ];

  List<Map<String, dynamic>> getAvailableQuestions(String excludeValue1, String excludeValue2) {
    return securityQuestions.where((q) => 
      q["value"] != excludeValue1 && q["value"] != excludeValue2
    ).toList();
  }

  Future<void> _submitQuestions() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedQuestion1.isEmpty || selectedQuestion2.isEmpty || selectedQuestion3.isEmpty) {
      se("Please select all three security questions");
      return;
    }

    if (selectedQuestion1 == selectedQuestion2 || 
        selectedQuestion1 == selectedQuestion3 || 
        selectedQuestion2 == selectedQuestion3) {
      se("Please select different questions for each field");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Security questions saved successfully");
    // navigateTo(BfaHomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Questions"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spLg),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 60,
                      color: primaryColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Setup Security Questions",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Create security questions to help verify your identity and recover your account if needed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: sp2xl),

              // Question 1
              Text(
                "Security Question 1",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),

              QDropdownField(
                label: "Select First Question",
                items: securityQuestions,
                value: selectedQuestion1,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedQuestion1 = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              QTextField(
                label: "Your Answer",
                value: answer1,
                validator: Validator.required,
                hint: "Enter your answer",
                onChanged: (value) {
                  answer1 = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spXl),

              // Question 2
              Text(
                "Security Question 2",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),

              QDropdownField(
                label: "Select Second Question",
                items: getAvailableQuestions(selectedQuestion1, selectedQuestion3),
                value: selectedQuestion2,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedQuestion2 = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              QTextField(
                label: "Your Answer",
                value: answer2,
                validator: Validator.required,
                hint: "Enter your answer",
                onChanged: (value) {
                  answer2 = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spXl),

              // Question 3
              Text(
                "Security Question 3",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),

              QDropdownField(
                label: "Select Third Question",
                items: getAvailableQuestions(selectedQuestion1, selectedQuestion2),
                value: selectedQuestion3,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedQuestion3 = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spMd),

              QTextField(
                label: "Your Answer",
                value: answer3,
                validator: Validator.required,
                hint: "Enter your answer",
                onChanged: (value) {
                  answer3 = value;
                  setState(() {});
                },
              ),

              SizedBox(height: sp2xl),

              // Security Tips
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Security Tips",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• ", style: TextStyle(color: disabledBoldColor, fontSize: 14)),
                        Expanded(
                          child: Text(
                            "Choose questions with answers only you know",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• ", style: TextStyle(color: disabledBoldColor, fontSize: 14)),
                        Expanded(
                          child: Text(
                            "Avoid answers that can be easily guessed or found online",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• ", style: TextStyle(color: disabledBoldColor, fontSize: 14)),
                        Expanded(
                          child: Text(
                            "Remember your answers exactly as you type them",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• ", style: TextStyle(color: disabledBoldColor, fontSize: 14)),
                        Expanded(
                          child: Text(
                            "Keep your answers confidential and secure",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: sp2xl),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Saving Questions..." : "Save Security Questions",
                  size: bs.md,
                  onPressed: loading ? null : _submitQuestions,
                ),
              ),

              SizedBox(height: spMd),

              // Skip Option
              Container(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledBoldColor),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // navigateTo(BfaHomeView());
                    },
                    child: Text(
                      "Skip for Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: spXl),

              // Important Note
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(50)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Important Note",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "These questions will be used to verify your identity if you forget your login credentials. Please ensure your answers are memorable and accurate.",
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
            ],
          ),
        ),
      ),
    );
  }
}
