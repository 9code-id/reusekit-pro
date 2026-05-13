import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaWaterIntakeView extends StatefulWidget {
  const MhaWaterIntakeView({super.key});

  @override
  State<MhaWaterIntakeView> createState() => _MhaWaterIntakeViewState();
}

class _MhaWaterIntakeViewState extends State<MhaWaterIntakeView> {
  int currentTab = 0;
  Map<String, dynamic> dailyIntake = {
    "currentGlasses": 5,
    "targetGlasses": 8,
    "currentLiters": 1.25,
    "targetLiters": 2.0,
    "lastDrink": "14:30",
  };

  List<Map<String, dynamic>> todayLog = [
    {
      "time": "07:00",
      "amount": 250,
      "type": "water",
      "icon": Icons.water_drop,
      "color": primaryColor,
    },
    {
      "time": "09:30",
      "amount": 200,
      "type": "coffee",
      "icon": Icons.coffee,
      "color": Colors.brown,
    },
    {
      "time": "11:15",
      "amount": 300,
      "type": "water",
      "icon": Icons.water_drop,
      "color": primaryColor,
    },
    {
      "time": "13:00",
      "amount": 250,
      "type": "water",
      "icon": Icons.water_drop,
      "color": primaryColor,
    },
    {
      "time": "14:30",
      "amount": 250,
      "type": "water",
      "icon": Icons.water_drop,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> weeklyProgress = [
    {
      "day": "Mon",
      "glasses": 7,
      "target": 8,
      "liters": 1.75,
    },
    {
      "day": "Tue",
      "glasses": 8,
      "target": 8,
      "liters": 2.0,
    },
    {
      "day": "Wed",
      "glasses": 6,
      "target": 8,
      "liters": 1.5,
    },
    {
      "day": "Thu",
      "glasses": 9,
      "target": 8,
      "liters": 2.25,
    },
    {
      "day": "Fri",
      "glasses": 8,
      "target": 8,
      "liters": 2.0,
    },
    {
      "day": "Sat",
      "glasses": 5,
      "target": 8,
      "liters": 1.25,
    },
    {
      "day": "Sun",
      "glasses": 5,
      "target": 8,
      "liters": 1.25,
    },
  ];

  List<Map<String, dynamic>> drinkTypes = [
    {
      "name": "Water",
      "amount": 250,
      "unit": "ml",
      "icon": Icons.water_drop,
      "color": primaryColor,
    },
    {
      "name": "Large Glass",
      "amount": 500,
      "unit": "ml",
      "icon": Icons.local_drink,
      "color": infoColor,
    },
    {
      "name": "Coffee",
      "amount": 200,
      "unit": "ml",
      "icon": Icons.coffee,
      "color": Colors.brown,
    },
    {
      "name": "Tea",
      "amount": 200,
      "unit": "ml",
      "icon": Icons.emoji_food_beverage,
      "color": successColor,
    },
    {
      "name": "Juice",
      "amount": 300,
      "unit": "ml",
      "icon": Icons.local_cafe,
      "color": warningColor,
    },
    {
      "name": "Bottle",
      "amount": 600,
      "unit": "ml",
      "icon": Icons.sports_bar,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> reminders = [
    {
      "time": "08:00",
      "message": "Good morning! Start your day with water",
      "active": true,
    },
    {
      "time": "10:00",
      "message": "Time for a hydration break",
      "active": true,
    },
    {
      "time": "12:00",
      "message": "Lunch time hydration",
      "active": false,
    },
    {
      "time": "15:00",
      "message": "Afternoon water break",
      "active": true,
    },
    {
      "time": "18:00",
      "message": "Evening hydration",
      "active": true,
    },
    {
      "time": "21:00",
      "message": "Last call for water today",
      "active": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Water Intake",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Log", icon: Icon(Icons.history)),
        Tab(text: "Progress", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildTodayTab(),
        _buildLogTab(),
        _buildProgressTab(),
      ],
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDailyProgress(),
          _buildQuickAdd(),
          _buildWaterReminders(),
        ],
      ),
    );
  }

  Widget _buildDailyProgress() {
    int currentGlasses = dailyIntake["currentGlasses"] as int;
    int targetGlasses = dailyIntake["targetGlasses"] as int;
    double currentLiters = dailyIntake["currentLiters"] as double;
    double targetLiters = dailyIntake["targetLiters"] as double;
    double progress = (currentGlasses / targetGlasses).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.water_drop,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Today's Hydration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withAlpha(20),
                    border: Border.all(
                      color: primaryColor.withAlpha(50),
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: 160,
                  height: 160,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress >= 1.0 ? successColor : primaryColor,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$currentGlasses",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "of $targetGlasses glasses",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${currentLiters.toStringAsFixed(2)}L / ${targetLiters.toStringAsFixed(1)}L",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildStatCard("Completed", "${(progress * 100).toInt()}%", Icons.check_circle, progress >= 1.0 ? successColor : primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Remaining", "${targetGlasses - currentGlasses}", Icons.water_drop, infoColor),
              SizedBox(width: spSm),
              _buildStatCard("Last Drink", "${dailyIntake["lastDrink"]}", Icons.schedule, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAdd() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.add_circle,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Add",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 100,
            children: drinkTypes.map((drink) {
              return GestureDetector(
                onTap: () {
                  _addDrink(drink);
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (drink["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: drink["color"] as Color,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Icon(
                        drink["icon"] as IconData,
                        color: drink["color"] as Color,
                        size: 24,
                      ),
                      Text(
                        "${drink["name"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${drink["amount"]}${drink["unit"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _addDrink(Map<String, dynamic> drink) {
    setState(() {
      // Update daily intake based on drink amount
      int amount = drink["amount"] as int;
      double glasses = amount / 250.0; // Assuming 250ml = 1 glass
      
      dailyIntake["currentGlasses"] = (dailyIntake["currentGlasses"] as int) + glasses.round();
      dailyIntake["currentLiters"] = (dailyIntake["currentLiters"] as double) + (amount / 1000.0);
      dailyIntake["lastDrink"] = TimeOfDay.now().format(context);
      
      // Add to today's log
      todayLog.add({
        "time": TimeOfDay.now().format(context),
        "amount": amount,
        "type": drink["name"].toString().toLowerCase(),
        "icon": drink["icon"],
        "color": drink["color"],
      });
    });
    
    ss("${drink["name"]} added successfully!");
  }

  Widget _buildWaterReminders() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.notifications,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Hydration Reminders",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...reminders.take(3).map((reminder) => _buildReminderCard(reminder)).toList(),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Manage All Reminders",
              size: bs.sm,
              onPressed: () {
                //navigateTo('ManageRemindersView')
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    bool isActive = reminder["active"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isActive ? primaryColor.withAlpha(20) : Colors.grey[100],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isActive ? primaryColor : disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.alarm_on : Icons.alarm_off,
            color: isActive ? primaryColor : disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  "${reminder["time"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isActive ? primaryColor : disabledBoldColor,
                  ),
                ),
                Text(
                  "${reminder["message"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? disabledBoldColor : disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: (value) {
              setState(() {
                reminder["active"] = value;
              });
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildLogTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTodayStats(),
          _buildDrinkLog(),
        ],
      ),
    );
  }

  Widget _buildTodayStats() {
    int totalAmount = todayLog.fold(0, (sum, log) => sum + (log["amount"] as int));
    int waterCount = todayLog.where((log) => log["type"] == "water").length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Today's Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildSummaryCard("Total", "${(totalAmount / 1000).toStringAsFixed(2)}L", Icons.water_drop, primaryColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Water", "$waterCount", Icons.local_drink, infoColor),
              SizedBox(width: spSm),
              _buildSummaryCard("Drinks", "${todayLog.length}", Icons.emoji_food_beverage, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrinkLog() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Drink Log",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...todayLog.reversed.map((log) => _buildLogCard(log)).toList(),
        ],
      ),
    );
  }

  Widget _buildLogCard(Map<String, dynamic> log) {
    Color drinkColor = log["color"] as Color;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: drinkColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: drinkColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: drinkColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              log["icon"] as IconData,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${log["type"].toString().toUpperCase()}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${log["amount"]}ml",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${log["time"]}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: drinkColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildWeeklyChart(),
          _buildHydrationTips(),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Weekly Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            child: Column(
              spacing: spXs,
              children: weeklyProgress.map((day) {
                int glasses = day["glasses"] as int;
                int target = day["target"] as int;
                double progress = (glasses / target).clamp(0.0, 1.0);
                Color barColor = progress >= 1.0 ? successColor : progress >= 0.7 ? warningColor : primaryColor;
                
                return Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        "${day["day"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: barColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    SizedBox(
                      width: 50,
                      child: Text(
                        "$glasses/$target",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHydrationTips() {
    List<Map<String, dynamic>> tips = [
      {
        "title": "Start Your Day",
        "description": "Drink a glass of water as soon as you wake up",
        "icon": Icons.wb_sunny,
        "color": warningColor,
      },
      {
        "title": "Before Meals",
        "description": "Drink water 30 minutes before eating",
        "icon": Icons.restaurant,
        "color": successColor,
      },
      {
        "title": "Exercise Hydration",
        "description": "Drink extra water before, during, and after exercise",
        "icon": Icons.fitness_center,
        "color": primaryColor,
      },
      {
        "title": "Track Your Color",
        "description": "Monitor urine color as a hydration indicator",
        "icon": Icons.visibility,
        "color": infoColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Hydration Tips",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...tips.map((tip) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (tip["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: tip["color"] as Color,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tip["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      tip["icon"] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${tip["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${tip["description"]}",
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
          }).toList(),
        ],
      ),
    );
  }
}
