import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:async';

class GrlLoading9View extends StatefulWidget {
  @override
  State<GrlLoading9View> createState() => _GrlLoading9ViewState();
}

class _GrlLoading9ViewState extends State<GrlLoading9View>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _floatController;
  bool isLoading = true;
  String loadingMessage = "Preparing your medical dashboard...";
  int currentStep = 0;

  List<Map<String, dynamic>> medicalSteps = [
    {
      "title": "Patient Records",
      "icon": Icons.person,
      "description": "Loading patient database...",
      "color": Colors.blue,
    },
    {
      "title": "Medical History",
      "icon": Icons.history,
      "description": "Syncing medical records...",
      "color": Colors.green,
    },
    {
      "title": "Appointments",
      "icon": Icons.calendar_today,
      "description": "Updating appointment schedule...",
      "color": Colors.orange,
    },
    {
      "title": "Lab Results",
      "icon": Icons.science,
      "description": "Fetching latest lab reports...",
      "color": Colors.purple,
    },
    {
      "title": "Prescriptions",
      "icon": Icons.medication,
      "description": "Loading prescription data...",
      "color": Colors.red,
    },
    {
      "title": "Health Analytics",
      "icon": Icons.analytics,
      "description": "Generating health insights...",
      "color": Colors.teal,
    },
  ];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _floatController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    _waveController.repeat();
    _floatController.repeat(reverse: true);
    
    _startMedicalLoading();
  }

  void _startMedicalLoading() async {
    for (int i = 0; i < medicalSteps.length; i++) {
      if (!mounted) return;
      
      currentStep = i;
      loadingMessage = medicalSteps[i]["description"];
      setState(() {});
      
      await Future.delayed(Duration(milliseconds: 2000));
    }
    
    isLoading = false;
    loadingMessage = "MedCore is ready for patient care!";
    setState(() {});
  }

  @override
  void dispose() {
    _waveController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade100,
              Colors.blue.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                
                // Medical Cross Logo
                AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -15 * _floatController.value),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radius4xl),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade300.withAlpha(100),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.local_hospital,
                              size: 80,
                              color: Colors.red.shade500,
                            ),
                            if (isLoading)
                              Positioned.fill(
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  color: Colors.blue.shade600,
                                  backgroundColor: Colors.blue.shade100,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                SizedBox(height: spXl),
                
                // App Title
                Text(
                  "MedCore",
                  style: TextStyle(
                    fontSize: fsH1,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Text(
                  "Comprehensive Medical Management System",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                SizedBox(height: spXl),
                
                // Current Status Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  margin: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXl),
                    boxShadow: [shadowLg],
                  ),
                  child: Column(
                    children: [
                      if (isLoading && currentStep < medicalSteps.length) ...[
                        Icon(
                          medicalSteps[currentStep]["icon"],
                          size: 40,
                          color: medicalSteps[currentStep]["color"],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          medicalSteps[currentStep]["title"],
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: medicalSteps[currentStep]["color"],
                          ),
                        ),
                      ] else if (!isLoading) ...[
                        Icon(
                          Icons.check_circle,
                          size: 40,
                          color: Colors.green.shade600,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "System Ready",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                      SizedBox(height: spMd),
                      Text(
                        loadingMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      if (isLoading) ...[
                        SizedBox(height: spMd),
                        LinearProgressIndicator(
                          backgroundColor: Colors.blue.shade100,
                          color: isLoading && currentStep < medicalSteps.length
                              ? medicalSteps[currentStep]["color"]
                              : Colors.green.shade600,
                        ),
                      ],
                    ],
                  ),
                ),
                
                SizedBox(height: spXl),
                
                // Medical Steps Grid
                Text(
                  "System Components",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: spMd,
                    mainAxisSpacing: spMd,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: medicalSteps.length,
                  itemBuilder: (context, index) {
                    bool isCompleted = !isLoading || index < currentStep;
                    bool isActive = isLoading && index == currentStep;
                    var step = medicalSteps[index];
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isActive 
                              ? step["color"]
                              : isCompleted 
                                  ? Colors.green.shade300
                                  : Colors.blue.shade100,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isActive 
                                ? step["color"].withAlpha(50)
                                : Colors.blue.shade100.withAlpha(50),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isCompleted && !isActive ? Icons.check_circle : step["icon"],
                            size: 32,
                            color: isCompleted && !isActive 
                                ? Colors.green.shade600
                                : isActive 
                                    ? step["color"]
                                    : Colors.grey.shade400,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            step["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isCompleted && !isActive 
                                  ? Colors.green.shade600
                                  : isActive 
                                      ? step["color"]
                                      : Colors.grey.shade600,
                            ),
                          ),
                          if (isActive) ...[
                            SizedBox(height: spSm),
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: step["color"],
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
                
                SizedBox(height: spXl),
                
                // Medical Features
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Healthcare Features",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildHealthFeature(
                            Icons.favorite,
                            "Heart Rate\nMonitoring",
                            Colors.red,
                          ),
                          _buildHealthFeature(
                            Icons.healing,
                            "Treatment\nPlanning",
                            Colors.green,
                          ),
                          _buildHealthFeature(
                            Icons.psychology,
                            "AI\nDiagnosis",
                            Colors.purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spXl),
                
                // Medical Certifications
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: Colors.green.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.green.shade600,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "HIPAA Compliant",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                              ),
                            ),
                            Text(
                              "Secure healthcare data management",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Version Info
                Text(
                  "MedCore v3.2.1 • Licensed Medical Software",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHealthFeature(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: color.withAlpha(100),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
