import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaVirtualExperimentsView extends StatefulWidget {
  const ElaVirtualExperimentsView({super.key});

  @override
  State<ElaVirtualExperimentsView> createState() => _ElaVirtualExperimentsViewState();
}

class _ElaVirtualExperimentsViewState extends State<ElaVirtualExperimentsView> {
  String selectedExperimentId = "exp_001";
  bool isExperimentRunning = false;
  double currentStep = 0;
  int totalSteps = 5;
  
  Map<String, dynamic> currentExperiment = {
    "id": "exp_001",
    "title": "Virtual Chemistry Lab: Acid-Base Reactions",
    "subject": "Chemistry",
    "difficulty": "Intermediate",
    "duration": "45 min",
    "description": "Explore acid-base reactions through safe virtual experiments",
    "materials": [
      {"name": "Hydrochloric Acid (HCl)", "amount": "50ml", "molarity": "0.1M"},
      {"name": "Sodium Hydroxide (NaOH)", "amount": "50ml", "molarity": "0.1M"},
      {"name": "pH Indicator", "amount": "5ml", "type": "Phenolphthalein"},
      {"name": "Beaker", "size": "250ml", "quantity": 2},
      {"name": "Burette", "size": "50ml", "quantity": 1},
      {"name": "pH Meter", "type": "Digital", "quantity": 1},
    ],
    "steps": [
      {
        "step": 1,
        "title": "Prepare Solutions",
        "instruction": "Measure 25ml of HCl solution into a clean beaker",
        "image": "https://picsum.photos/400/300?random=1&keyword=beaker",
        "completed": true
      },
      {
        "step": 2,
        "title": "Add pH Indicator",
        "instruction": "Add 2-3 drops of phenolphthalein to the HCl solution",
        "image": "https://picsum.photos/400/300?random=2&keyword=laboratory",
        "completed": true
      },
      {
        "step": 3,
        "title": "Set Up Burette",
        "instruction": "Fill the burette with NaOH solution and note the initial volume",
        "image": "https://picsum.photos/400/300?random=3&keyword=chemistry",
        "completed": false
      },
      {
        "step": 4,
        "title": "Begin Titration",
        "instruction": "Slowly add NaOH to HCl while stirring constantly",
        "image": "https://picsum.photos/400/300?random=4&keyword=experiment",
        "completed": false
      },
      {
        "step": 5,
        "title": "Observe Color Change",
        "instruction": "Stop when the solution turns pink and record the volume",
        "image": "https://picsum.photos/400/300?random=5&keyword=chemical",
        "completed": false
      }
    ],
    "results": {
      "pH_initial": 1.2,
      "pH_final": 7.0,
      "volume_used": 25.2,
      "molarity_calculated": 0.098
    },
    "safety_notes": [
      "Always wear safety goggles when handling chemicals",
      "Work in a well-ventilated area",
      "Never mix chemicals without proper knowledge",
      "Wash hands thoroughly after experiment"
    ]
  };
  
  List<Map<String, dynamic>> availableExperiments = [
    {
      "id": "exp_001",
      "title": "Acid-Base Reactions",
      "subject": "Chemistry",
      "difficulty": "Intermediate",
      "thumbnail": "https://picsum.photos/200/150?random=1&keyword=chemistry"
    },
    {
      "id": "exp_002",
      "title": "Newton's Laws Demo",
      "subject": "Physics",
      "difficulty": "Beginner",
      "thumbnail": "https://picsum.photos/200/150?random=2&keyword=physics"
    },
    {
      "id": "exp_003",
      "title": "Cell Division Process",
      "subject": "Biology",
      "difficulty": "Advanced",
      "thumbnail": "https://picsum.photos/200/150?random=3&keyword=biology"
    },
    {
      "id": "exp_004",
      "title": "Electrical Circuits",
      "subject": "Physics",
      "difficulty": "Intermediate",
      "thumbnail": "https://picsum.photos/200/150?random=4&keyword=electronics"
    },
  ];
  
  List<Map<String, dynamic>> observations = [];
  String currentObservation = "";

  void _startExperiment() {
    isExperimentRunning = true;
    currentStep = 0;
    observations.clear();
    setState(() {});
    ss("Experiment started successfully!");
  }

  void _completeStep() {
    if (currentStep < totalSteps - 1) {
      currentStep++;
      _addObservation("Completed step ${(currentStep).toInt()}: ${currentExperiment["steps"][(currentStep - 1).toInt()]["title"]}");
    } else {
      _finishExperiment();
    }
    setState(() {});
  }

  void _finishExperiment() {
    isExperimentRunning = false;
    _addObservation("Experiment completed successfully! Results recorded.");
    ss("Experiment completed! Check your results.");
    setState(() {});
  }

  void _addObservation(String observation) {
    observations.insert(0, {
      "text": observation,
      "timestamp": DateTime.now().toIso8601String(),
    });
    setState(() {});
  }

  void _pauseExperiment() {
    isExperimentRunning = false;
    setState(() {});
    si("Experiment paused. You can resume anytime.");
  }

  void _resetExperiment() {
    isExperimentRunning = false;
    currentStep = 0;
    observations.clear();
    setState(() {});
    sw("Experiment reset. All progress lost.");
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> steps = currentExperiment["steps"] as List<Map<String, dynamic>>;
    Map<String, dynamic> currentStepData = steps.isNotEmpty && currentStep < steps.length 
        ? steps[currentStep.toInt()] 
        : steps.last;

    return Scaffold(
      appBar: AppBar(
        title: Text("Virtual Experiments"),
        actions: [
          IconButton(
            icon: Icon(Icons.science),
            onPressed: () {
              // Show experiment selector
            },
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              ss("Help and safety guidelines opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Experiment Header
            Container(
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${currentExperiment["subject"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(currentExperiment["difficulty"] as String).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${currentExperiment["difficulty"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getDifficultyColor(currentExperiment["difficulty"] as String),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${currentExperiment["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${currentExperiment["title"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${currentExperiment["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Progress Indicator
            Container(
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
                      Text(
                        "Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Step ${(currentStep + 1).toInt()} of ${totalSteps}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  LinearProgressIndicator(
                    value: (currentStep + 1) / totalSteps,
                    backgroundColor: disabledColor.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation(successColor),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      if (!isExperimentRunning && currentStep == 0)
                        Expanded(
                          child: QButton(
                            label: "Start Experiment",
                            icon: Icons.play_arrow,
                            size: bs.md,
                            color: successColor,
                            onPressed: _startExperiment,
                          ),
                        ),
                      if (isExperimentRunning) ...[
                        Expanded(
                          child: QButton(
                            label: "Complete Step",
                            icon: Icons.check,
                            size: bs.md,
                            color: primaryColor,
                            onPressed: _completeStep,
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.pause,
                          size: bs.md,
                          color: warningColor,
                          onPressed: _pauseExperiment,
                        ),
                      ],
                      if (!isExperimentRunning && currentStep > 0) ...[
                        Expanded(
                          child: QButton(
                            label: "Resume",
                            icon: Icons.play_arrow,
                            size: bs.md,
                            color: successColor,
                            onPressed: () {
                              isExperimentRunning = true;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.refresh,
                          size: bs.md,
                          color: dangerColor,
                          onPressed: _resetExperiment,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Current Step
            if (isExperimentRunning || currentStep > 0)
              Container(
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${currentStepData["step"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Text(
                            "${currentStepData["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${currentStepData["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: infoColor.withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${currentStepData["instruction"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Materials List
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Required Materials",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...((currentExperiment["materials"] as List<Map<String, dynamic>>).map((material) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.science,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${material["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                if (material["amount"] != null)
                                  Text(
                                    "Amount: ${material["amount"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                if (material["molarity"] != null)
                                  Text(
                                    "Molarity: ${material["molarity"]}",
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
                    );
                  }).toList()),
                ],
              ),
            ),

            // Observations
            Container(
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
                      Text(
                        "Lab Observations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          if (currentObservation.trim().isNotEmpty) {
                            _addObservation(currentObservation);
                            currentObservation = "";
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QMemoField(
                    label: "Add Observation",
                    value: currentObservation,
                    hint: "Record what you observe during the experiment...",
                    maxLines: 3,
                    onChanged: (value) {
                      currentObservation = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  if (observations.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Center(
                        child: Text(
                          "No observations recorded yet",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    )
                  else
                    ...observations.map((obs) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: disabledOutlineBorderColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${obs["text"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${DateTime.parse(obs["timestamp"] as String).dMMMy} at ${DateTime.parse(obs["timestamp"] as String).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),

            // Safety Notes
            Container(
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
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Safety Guidelines",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...((currentExperiment["safety_notes"] as List<String>).map((note) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: warningColor.withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              note,
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
