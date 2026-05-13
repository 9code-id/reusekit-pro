import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsAppTutorialView extends StatefulWidget {
  const BrsAppTutorialView({super.key});

  @override
  State<BrsAppTutorialView> createState() => _BrsAppTutorialViewState();
}

class _BrsAppTutorialViewState extends State<BrsAppTutorialView> {
  int currentStep = 0;
  bool showTutorialOnStartup = true;
  
  List<Map<String, dynamic>> tutorialSteps = [
    {
      "title": "Welcome to BarberShop Pro",
      "description": "Your premium barbershop booking platform. Let's get you started with a quick tour of the app's features.",
      "image": "https://picsum.photos/300/200?random=1&keyword=welcome",
      "icon": Icons.waving_hand,
      "color": Colors.blue,
    },
    {
      "title": "Find Your Perfect Barber",
      "description": "Browse through our extensive network of professional barbers. View profiles, ratings, and specialties to find the perfect match.",
      "image": "https://picsum.photos/300/200?random=2&keyword=barber",
      "icon": Icons.person_search,
      "color": Colors.green,
    },
    {
      "title": "Book Appointments Instantly",
      "description": "Select your preferred time slot and book appointments with just a few taps. Real-time availability ensures no conflicts.",
      "image": "https://picsum.photos/300/200?random=3&keyword=calendar",
      "icon": Icons.calendar_month,
      "color": Colors.orange,
    },
    {
      "title": "Choose Premium Services",
      "description": "Explore our wide range of services from classic cuts to premium grooming packages. Detailed descriptions help you choose.",
      "image": "https://picsum.photos/300/200?random=4&keyword=scissors",
      "icon": Icons.content_cut,
      "color": Colors.purple,
    },
    {
      "title": "Secure Payment Options",
      "description": "Pay safely with multiple payment methods. Digital receipts and transaction history keep your records organized.",
      "image": "https://picsum.photos/300/200?random=5&keyword=payment",
      "icon": Icons.payment,
      "color": Colors.teal,
    },
    {
      "title": "Track Your Appointments",
      "description": "Get real-time updates on your appointment status. Receive notifications for confirmations, reminders, and changes.",
      "image": "https://picsum.photos/300/200?random=6&keyword=notification",
      "icon": Icons.notifications_active,
      "color": Colors.indigo,
    },
    {
      "title": "Rate & Review Experience",
      "description": "Share your experience by rating services and leaving reviews. Help other customers make informed decisions.",
      "image": "https://picsum.photos/300/200?random=7&keyword=review",
      "icon": Icons.star_rate,
      "color": Colors.amber,
    },
    {
      "title": "You're All Set!",
      "description": "That's it! You're ready to start booking amazing barbershop experiences. Enjoy your premium grooming journey.",
      "image": "https://picsum.photos/300/200?random=8&keyword=success",
      "icon": Icons.check_circle,
      "color": Colors.green,
    },
  ];
  
  List<Map<String, dynamic>> quickTips = [
    {
      "title": "Booking Tips",
      "tips": [
        "Book during off-peak hours for better availability",
        "Add services during booking to save time",
        "Set booking reminders in your calendar",
        "Check barber specialties before booking",
      ],
      "icon": Icons.lightbulb,
      "color": Colors.yellow,
    },
    {
      "title": "Payment & Pricing",
      "tips": [
        "Compare prices across different barbers",
        "Look for promotional discounts",
        "Save multiple payment methods",
        "Keep digital receipts for tax purposes",
      ],
      "icon": Icons.account_balance_wallet,
      "color": Colors.green,
    },
    {
      "title": "Profile Management",
      "tips": [
        "Upload a clear profile photo",
        "Keep contact information updated",
        "Set notification preferences",
        "Review your booking history regularly",
      ],
      "icon": Icons.account_circle,
      "color": Colors.blue,
    },
    {
      "title": "App Features",
      "tips": [
        "Use filters to find specific services",
        "Enable location services for nearby barbers",
        "Try the barber comparison feature",
        "Use offline mode when internet is limited",
      ],
      "icon": Icons.apps,
      "color": Colors.purple,
    },
  ];
  
  List<Map<String, dynamic>> frequentlyAsked = [
    {
      "question": "How do I cancel a booking?",
      "answer": "Go to 'My Bookings', select the appointment, and tap 'Cancel Booking'. Note the cancellation policy for refunds.",
    },
    {
      "question": "Can I reschedule an appointment?",
      "answer": "Yes, tap on your booking and select 'Reschedule'. Choose a new time slot based on availability.",
    },
    {
      "question": "How do payments work?",
      "answer": "You can pay during booking or after service completion. We accept cards, digital wallets, and cash.",
    },
    {
      "question": "What if I'm running late?",
      "answer": "Contact your barber directly through the app or call the barbershop. Most accept short delays.",
    },
    {
      "question": "How do I find my booking details?",
      "answer": "All bookings are stored in 'My Bookings' section with complete details and status updates.",
    },
  ];
  
  void _nextStep() {
    if (currentStep < tutorialSteps.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      _completeTutorial();
    }
  }
  
  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }
  
  void _skipTutorial() {
    _completeTutorial();
  }
  
  void _completeTutorial() {
    ss("Tutorial completed! Welcome to BarberShop Pro");
    back();
  }
  
  void _restartTutorial() {
    setState(() {
      currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Tutorial"),
        actions: [
          if (currentStep < tutorialSteps.length - 1)
            TextButton(
              onPressed: _skipTutorial,
              child: Text(
                "Skip",
                style: TextStyle(color: primaryColor),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Tutorial Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.school, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Step ${currentStep + 1} of ${tutorialSteps.length}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(((currentStep + 1) / tutorialSteps.length) * 100).round()}%",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: (currentStep + 1) / tutorialSteps.length,
                    backgroundColor: Colors.grey.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            ),
            
            // Tutorial Content Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  // Step Icon and Title
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (tutorialSteps[currentStep]["color"] as Color).withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          tutorialSteps[currentStep]["icon"] as IconData,
                          color: tutorialSteps[currentStep]["color"] as Color,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${tutorialSteps[currentStep]["title"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Tutorial Image
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      image: DecorationImage(
                        image: NetworkImage("${tutorialSteps[currentStep]["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Description
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${tutorialSteps[currentStep]["description"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  // Navigation Buttons
                  Row(
                    children: [
                      if (currentStep > 0)
                        Expanded(
                          child: QButton(
                            label: "Previous",
                            icon: Icons.arrow_back,
                            onPressed: _previousStep,
                          ),
                        ),
                      if (currentStep > 0) SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: currentStep < tutorialSteps.length - 1 ? "Next" : "Get Started",
                          icon: currentStep < tutorialSteps.length - 1 ? Icons.arrow_forward : Icons.check,
                          onPressed: _nextStep,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Quick Tips Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tips_and_updates, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Quick Tips",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: quickTips.map((tipCategory) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (tipCategory["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  tipCategory["icon"] as IconData,
                                  color: tipCategory["color"] as Color,
                                  size: 20,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${tipCategory["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              spacing: spXs,
                              children: (tipCategory["tips"] as List<String>).map((tip) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.fiber_manual_record, size: 6, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        tip,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // FAQ Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.help, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Frequently Asked Questions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: frequentlyAsked.map((faq) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.question_mark, color: primaryColor, size: 16),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${faq["question"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${faq["answer"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Tutorial Settings
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Tutorial Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show tutorial on app startup",
                        "value": true,
                        "checked": showTutorialOnStartup,
                      }
                    ],
                    value: [
                      if (showTutorialOnStartup)
                        {
                          "label": "Show tutorial on app startup",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        showTutorialOnStartup = values.isNotEmpty;
                      });
                      ss(showTutorialOnStartup 
                        ? "Tutorial will show on startup" 
                        : "Tutorial disabled on startup");
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Restart Tutorial",
                      icon: Icons.restart_alt,
                      onPressed: _restartTutorial,
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
