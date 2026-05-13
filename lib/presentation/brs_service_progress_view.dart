import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsServiceProgressView extends StatefulWidget {
  const BrsServiceProgressView({super.key});

  @override
  State<BrsServiceProgressView> createState() => _BrsServiceProgressViewState();
}

class _BrsServiceProgressViewState extends State<BrsServiceProgressView> {
  Map<String, dynamic> serviceData = {
    "booking_id": "BK001",
    "barber_name": "John Smith",
    "service": "Premium Haircut + Beard Trim",
    "start_time": "10:30 AM",
    "estimated_duration": 45,
    "current_step": 2,
    "barber_image": "https://picsum.photos/80/80?random=1&keyword=barber",
  };

  List<Map<String, dynamic>> serviceSteps = [
    {
      "title": "Consultation",
      "description": "Discussing your preferred style and requirements",
      "duration": 5,
      "status": "completed",
      "start_time": "10:30 AM",
      "end_time": "10:35 AM",
    },
    {
      "title": "Hair Washing",
      "description": "Pre-cut hair washing and conditioning",
      "duration": 10,
      "status": "completed",
      "start_time": "10:35 AM",
      "end_time": "10:45 AM",
    },
    {
      "title": "Hair Cutting",
      "description": "Precision haircut according to your style",
      "duration": 20,
      "status": "in_progress",
      "start_time": "10:45 AM",
      "end_time": null,
    },
    {
      "title": "Beard Trimming",
      "description": "Professional beard shaping and trimming",
      "duration": 8,
      "status": "pending",
      "start_time": null,
      "end_time": null,
    },
    {
      "title": "Finishing Touches",
      "description": "Final styling and grooming",
      "duration": 2,
      "status": "pending",
      "start_time": null,
      "end_time": null,
    },
  ];

  String currentTime = "10:52 AM";
  int elapsedMinutes = 22;
  int remainingMinutes = 23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Progress"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${serviceData["barber_image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${serviceData["barber_name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${serviceData["service"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Started at ${serviceData["start_time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs/2),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Time Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Time Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "$elapsedMinutes min",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Elapsed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledColor,
                      ),
                      Column(
                        children: [
                          Text(
                            "$remainingMinutes min",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Remaining",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Progress Bar
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: elapsedMinutes / (elapsedMinutes + remainingMinutes),
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Service Steps
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Service Steps",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...List.generate(serviceSteps.length, (index) {
                    final step = serviceSteps[index];
                    final isCompleted = step["status"] == "completed";
                    final isInProgress = step["status"] == "in_progress";
                    final isPending = step["status"] == "pending";

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isCompleted 
                                  ? successColor 
                                  : isInProgress 
                                    ? warningColor 
                                    : disabledColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isCompleted 
                                  ? Icons.check 
                                  : isInProgress 
                                    ? Icons.hourglass_empty 
                                    : Icons.schedule,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            if (index < serviceSteps.length - 1)
                              Container(
                                width: 2,
                                height: 40,
                                color: isCompleted ? successColor : disabledColor,
                              ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${step["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted || isInProgress ? Colors.black : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${step["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (step["start_time"] != null) ...[
                                Text(
                                  "${step["start_time"]} - ${step["end_time"] ?? "In Progress"}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                              Text(
                                "Duration: ${step["duration"]} minutes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${step["duration"]} min",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Current Activity
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.content_cut,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Currently: Hair Cutting",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your barber is currently working on your haircut. This step usually takes about 20 minutes.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Message Barber",
                          size: bs.sm,
                          onPressed: () {
                            // Message barber action
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Request Update",
                          size: bs.sm,
                          onPressed: () {
                            // Request update action
                            si("Update requested from your barber");
                          },
                        ),
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
