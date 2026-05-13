import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState1View extends StatefulWidget {
  @override
  State<GrlEmptyState1View> createState() => _GrlEmptyState1ViewState();
}

class _GrlEmptyState1ViewState extends State<GrlEmptyState1View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Empty State Illustration
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXl),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 80,
                      color: primaryColor.withAlpha(120),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Tasks",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Title and Description
              Text(
                "You're all caught up!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "No tasks to complete today. Take a moment to relax or create a new task to stay productive.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Action Buttons
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create New Task",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(CreateTaskView());
                  },
                ),
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Browse Templates",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(TaskTemplatesView());
                  },
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Quick Actions
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 32,
                            color: successColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Set Reminder",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.category,
                            size: 32,
                            color: warningColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Categories",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.analytics,
                            size: 32,
                            color: infoColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Statistics",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(CreateTaskView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
