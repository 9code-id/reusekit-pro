import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms2View extends StatefulWidget {
  @override
  State<GrlTerms2View> createState() => _GrlTerms2ViewState();
}

class _GrlTerms2ViewState extends State<GrlTerms2View> {
  int currentStep = 0;
  List<bool> stepCompleted = [false, false, false, false];

  List<Map<String, dynamic>> termsSteps = [
    {
      "title": "User Agreement",
      "icon": Icons.person,
      "content": "By using our service, you agree to comply with and be bound by these terms and conditions. You must be at least 18 years old to use our services.",
      "details": "This agreement governs your use of our application and services. You are responsible for maintaining the confidentiality of your account credentials.",
    },
    {
      "title": "Data Usage",
      "icon": Icons.security,
      "content": "We collect and process your data in accordance with our Privacy Policy. Your personal information is protected and will not be shared without consent.",
      "details": "We use industry-standard security measures to protect your data. You have the right to access, modify, or delete your personal information at any time.",
    },
    {
      "title": "Service Limitations",
      "icon": Icons.warning,
      "content": "Our services are provided 'as is' without warranties. We reserve the right to modify or discontinue services with notice.",
      "details": "Service availability may be affected by maintenance, updates, or technical issues. We are not liable for any interruptions or data loss.",
    },
    {
      "title": "Legal Compliance",
      "icon": Icons.gavel,
      "content": "You agree to use our services only for lawful purposes and in compliance with all applicable laws and regulations.",
      "details": "Any violation of these terms may result in account suspension or termination. Disputes will be resolved according to applicable jurisdiction.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms Agreement"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step-by-Step Agreement",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Review each section carefully before proceeding",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${currentStep + 1}/${termsSteps.length}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: List.generate(termsSteps.length, (index) {
                bool isActive = index == currentStep;
                bool isCompleted = stepCompleted[index];
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCompleted ? successColor : (isActive ? primaryColor : disabledColor),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCompleted ? Icons.check : termsSteps[index]["icon"],
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${termsSteps[index]["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: isActive ? primaryColor : disabledBoldColor,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                termsSteps[currentStep]["icon"],
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${termsSteps[currentStep]["title"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${termsSteps[currentStep]["content"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.5,
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: infoColor.withAlpha(100),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: infoColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Additional Details",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${termsSteps[currentStep]["details"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (!stepCompleted[currentStep])
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "I Understand and Agree",
                        onPressed: () {
                          stepCompleted[currentStep] = true;
                          setState(() {});
                          ss("Section ${currentStep + 1} accepted");
                        },
                      ),
                    ),

                  if (stepCompleted[currentStep])
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: successColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Section Completed",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              spacing: spSm,
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                
                if (currentStep < termsSteps.length - 1 && stepCompleted[currentStep])
                  Expanded(
                    child: QButton(
                      label: "Next Section",
                      onPressed: () {
                        currentStep++;
                        setState(() {});
                      },
                    ),
                  ),

                if (currentStep == termsSteps.length - 1 && stepCompleted[currentStep])
                  Expanded(
                    child: QButton(
                      label: "Complete Agreement",
                      onPressed: () {
                        bool allCompleted = stepCompleted.every((completed) => completed);
                        if (allCompleted) {
                          ss("All terms accepted successfully");
                        } else {
                          se("Please complete all sections");
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
