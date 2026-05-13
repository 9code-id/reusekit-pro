import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaCalorieTrackerView extends StatefulWidget {
  const FwaCalorieTrackerView({super.key});

  @override
  State<FwaCalorieTrackerView> createState() => _FwaCalorieTrackerViewState();
}

class _FwaCalorieTrackerViewState extends State<FwaCalorieTrackerView> {
  DateTime selectedDate = DateTime.now();
  int dailyGoal = 2200;
  int consumedCalories = 1650;
  int burnedCalories = 320;
  
  final List<Map<String, dynamic>> todayMeals = [
    {
      "type": "Breakfast",
      "time": "08:30",
      "foods": [
        {"name": "Oatmeal with berries", "calories": 280, "image": "https://picsum.photos/60/60?random=1&keyword=oatmeal"},
        {"name": "Greek yogurt", "calories": 150, "image": "https://picsum.photos/60/60?random=2&keyword=yogurt"},
        {"name": "Orange juice", "calories": 110, "image": "https://picsum.photos/60/60?random=3&keyword=orange"}
      ],
      "totalCalories": 540
    },
    {
      "type": "Lunch",
      "time": "12:45",
      "foods": [
        {"name": "Grilled chicken salad", "calories": 420, "image": "https://picsum.photos/60/60?random=4&keyword=salad"},
        {"name": "Quinoa bowl", "calories": 220, "image": "https://picsum.photos/60/60?random=5&keyword=quinoa"},
        {"name": "Green tea", "calories": 5, "image": "https://picsum.photos/60/60?random=6&keyword=tea"}
      ],
      "totalCalories": 645
    },
    {
      "type": "Snack",
      "time": "15:20",
      "foods": [
        {"name": "Apple with almond butter", "calories": 190, "image": "https://picsum.photos/60/60?random=7&keyword=apple"},
        {"name": "Water", "calories": 0, "image": "https://picsum.photos/60/60?random=8&keyword=water"}
      ],
      "totalCalories": 190
    },
    {
      "type": "Dinner",
      "time": "19:00",
      "foods": [
        {"name": "Salmon with vegetables", "calories": 275, "image": "https://picsum.photos/60/60?random=9&keyword=salmon"},
      ],
      "totalCalories": 275
    }
  ];

  final List<Map<String, dynamic>> quickAddFoods = [
    {"name": "Banana", "calories": 105, "icon": Icons.sports_bar},
    {"name": "Greek Yogurt", "calories": 150, "icon": Icons.icecream},
    {"name": "Almonds (28g)", "calories": 164, "icon": Icons.grain},
    {"name": "Green Tea", "calories": 5, "icon": Icons.local_cafe},
    {"name": "Apple", "calories": 95, "icon": Icons.eco},
    {"name": "Protein Bar", "calories": 200, "icon": Icons.fitness_center}
  ];

  final List<Map<String, dynamic>> weeklyProgress = [
    {"day": "Mon", "calories": 2100, "goal": 2200},
    {"day": "Tue", "calories": 2180, "goal": 2200},
    {"day": "Wed", "calories": 2050, "goal": 2200},
    {"day": "Thu", "calories": 2250, "goal": 2200},
    {"day": "Fri", "calories": 2150, "goal": 2200},
    {"day": "Sat", "calories": 2300, "goal": 2200},
    {"day": "Today", "calories": 1650, "goal": 2200}
  ];

  int get remainingCalories => dailyGoal - consumedCalories + burnedCalories;
  double get progressPercentage => (consumedCalories / dailyGoal).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calorie Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                selectedDate = date;
                setState(() {});
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              ss("Settings opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${selectedDate.dMMMy}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: remainingCalories >= 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${remainingCalories >= 0 ? remainingCalories : -remainingCalories} cal ${remainingCalories >= 0 ? 'remaining' : 'over'}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: remainingCalories >= 0 ? successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Calorie Progress Circle
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Progress Circle
                  Container(
                    width: 180,
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: CircularProgressIndicator(
                            value: progressPercentage,
                            strokeWidth: 12,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progressPercentage < 0.8 ? successColor : 
                              progressPercentage < 1.0 ? warningColor : dangerColor
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$consumedCalories",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "of $dailyGoal cal",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (burnedCalories > 0)
                              Container(
                                margin: EdgeInsets.only(top: spXs),
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "+$burnedCalories burned",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.restaurant,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "$consumedCalories",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Consumed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.local_fire_department,
                              color: warningColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "$burnedCalories",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Burned",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (remainingCalories >= 0 ? infoColor : dangerColor).withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              remainingCalories >= 0 ? Icons.check_circle : Icons.warning,
                              color: remainingCalories >= 0 ? infoColor : dangerColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${remainingCalories >= 0 ? remainingCalories : -remainingCalories}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            remainingCalories >= 0 ? "Remaining" : "Over",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Quick Add Foods
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quick Add",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ss("Food search opened");
                        },
                        child: Text(
                          "Search Foods",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: spSm,
                      mainAxisSpacing: spSm,
                    ),
                    itemCount: quickAddFoods.length,
                    itemBuilder: (context, index) {
                      final food = quickAddFoods[index];
                      return GestureDetector(
                        onTap: () async {
                          bool isConfirmed = await confirm("Add ${food["name"]} (${food["calories"]} cal) to your intake?");
                          if (isConfirmed) {
                            consumedCalories += food["calories"] as int;
                            setState(() {});
                            ss("${food["name"]} added!");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledColor),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                food["icon"] as IconData,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${food["name"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${food["calories"]} cal",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Today's Meals
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Meals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Add Food",
                        size: bs.sm,
                        onPressed: () {
                          ss("Add food opened");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  ...todayMeals.map((meal) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${meal["type"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${meal["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${meal["totalCalories"]} cal",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          
                          ...(meal["foods"] as List<Map<String, dynamic>>).map((food) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      image: DecorationImage(
                                        image: NetworkImage("${food["image"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${food["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${food["calories"]} cal",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Weekly Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: weeklyProgress.map((day) {
                      final progress = ((day["calories"] as int) / (day["goal"] as int)).clamp(0.0, 1.0);
                      final isToday = day["day"] == "Today";
                      
                      return Column(
                        children: [
                          Container(
                            width: 35,
                            height: 80,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: 35,
                                  height: 80 * progress,
                                  decoration: BoxDecoration(
                                    color: isToday ? primaryColor : 
                                           progress >= 0.9 && progress <= 1.1 ? successColor :
                                           progress > 1.1 ? dangerColor : warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${day["day"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                              color: isToday ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${day["calories"]}",
                            style: TextStyle(
                              fontSize: 9,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ss("Barcode scanner opened");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }
}
