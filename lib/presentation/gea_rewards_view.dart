import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaRewardsView extends StatefulWidget {
  const GeaRewardsView({super.key});

  @override
  State<GeaRewardsView> createState() => _GeaRewardsViewState();
}

class _GeaRewardsViewState extends State<GeaRewardsView> {
  int selectedCategory = 0;
  
  List<String> categories = ["All", "Achievements", "Battle Pass", "Events", "Daily"];
  
  List<Map<String, dynamic>> availableRewards = [
    {
      "id": 1,
      "title": "Victory Chest",
      "description": "Win 10 matches to unlock rare items",
      "type": "Achievement",
      "rarity": "Rare",
      "progress": 7,
      "required": 10,
      "rewards": ["500 Coins", "Rare Weapon Skin", "XP Boost"],
      "expiry": null,
      "unlocked": false,
      "claimed": false
    },
    {
      "id": 2,
      "title": "Daily Login Bonus",
      "description": "Login for 7 consecutive days",
      "type": "Daily",
      "rarity": "Common",
      "progress": 5,
      "required": 7,
      "rewards": ["200 Coins", "Health Potion x3"],
      "expiry": "2024-12-31",
      "unlocked": false,
      "claimed": false
    },
    {
      "id": 3,
      "title": "Elite Battle Pass",
      "description": "Tier 25 Battle Pass reward",
      "type": "Battle Pass",
      "rarity": "Epic",
      "progress": 25,
      "required": 25,
      "rewards": ["1000 Coins", "Epic Character Skin", "Emote Pack"],
      "expiry": "2024-12-15",
      "unlocked": true,
      "claimed": false
    },
    {
      "id": 4,
      "title": "Legendary Hunter",
      "description": "Complete 100 eliminations with sniper rifles",
      "type": "Achievement",
      "rarity": "Legendary",
      "progress": 89,
      "required": 100,
      "rewards": ["2000 Coins", "Legendary Sniper Skin", "Title: Sniper Elite"],
      "expiry": null,
      "unlocked": false,
      "claimed": false
    },
    {
      "id": 5,
      "title": "Season Champion",
      "description": "Complete seasonal tournament",
      "type": "Event",
      "rarity": "Legendary",
      "progress": 1,
      "required": 1,
      "rewards": ["5000 Coins", "Champion Trophy", "Exclusive Avatar"],
      "expiry": "2024-12-10",
      "unlocked": true,
      "claimed": true
    },
  ];

  List<Map<String, dynamic>> claimedRewards = [
    {
      "title": "First Victory",
      "description": "Win your first match",
      "rewards": ["100 Coins", "Welcome Package"],
      "claimedDate": "2024-11-15",
      "rarity": "Common"
    },
    {
      "title": "Sharpshooter",
      "description": "Get 50 headshots",
      "rewards": ["300 Coins", "Precision Badge"],
      "claimedDate": "2024-11-20",
      "rarity": "Rare"
    },
    {
      "title": "Team Player",
      "description": "Assist teammates 100 times",
      "rewards": ["500 Coins", "Support Badge"],
      "claimedDate": "2024-11-25",
      "rarity": "Epic"
    },
  ];

  Map<String, dynamic> playerInventory = {
    "coins": 12580,
    "gems": 350,
    "tokens": 75,
    "chests": 8
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rewards"),
        actions: [
          IconButton(
            icon: Icon(Icons.inventory),
            onPressed: () {
              // Navigate to inventory
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCurrencyBalance(),
            _buildCategoryFilter(),
            _buildAvailableRewards(),
            _buildClaimedRewards(),
            _buildRewardStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyBalance() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Text(
            "Your Balance",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildCurrencyItem("Coins", "${(playerInventory["coins"] as int).currency}", Icons.monetization_on, Colors.amber),
              ),
              Expanded(
                child: _buildCurrencyItem("Gems", "${playerInventory["gems"]}", Icons.diamond, Colors.cyan),
              ),
              Expanded(
                child: _buildCurrencyItem("Tokens", "${playerInventory["tokens"]}", Icons.toll, Colors.purple),
              ),
              Expanded(
                child: _buildCurrencyItem("Chests", "${playerInventory["chests"]}", Icons.inbox, Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QCategoryPicker(
        items: categories.asMap().entries.map((entry) {
          return {
            "label": entry.value,
            "value": entry.key,
          };
        }).toList(),
        value: selectedCategory,
        onChanged: (index, label, value, item) {
          selectedCategory = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildAvailableRewards() {
    List<Map<String, dynamic>> filteredRewards = availableRewards.where((reward) {
      if (selectedCategory == 0) return true; // All
      return reward["type"] == categories[selectedCategory];
    }).toList();

    return Container(
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
              Icon(Icons.card_giftcard, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Available Rewards",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${filteredRewards.length} rewards",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: filteredRewards.map((reward) => _buildRewardItem(reward)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardItem(Map<String, dynamic> reward) {
    bool canClaim = reward["unlocked"] && !reward["claimed"];
    bool isCompleted = reward["progress"] >= reward["required"];
    double progress = (reward["progress"] as int) / (reward["required"] as int);
    Color rarityColor = _getRarityColor(reward["rarity"]);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: canClaim ? rarityColor.withAlpha(20) : Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: canClaim ? rarityColor.withAlpha(50) : Colors.grey.withAlpha(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${reward["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        _buildRarityBadge(reward["rarity"]),
                        if (reward["expiry"] != null) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.schedule, size: 12, color: dangerColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Expires ${DateTime.parse(reward["expiry"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${reward["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (canClaim)
                QButton(
                  label: "Claim",
                  size: bs.sm,
                  onPressed: () {
                    _claimReward(reward);
                  },
                ),
            ],
          ),
          if (!isCompleted) ...[
            SizedBox(height: spMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${reward["progress"]}/${reward["required"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(progress * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(rarityColor),
                ),
              ],
            ),
          ],
          SizedBox(height: spMd),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (reward["rewards"] as List<String>).map((rewardItem) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  rewardItem,
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRarityBadge(String rarity) {
    Color color = _getRarityColor(rarity);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        rarity,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildClaimedRewards() {
    return Container(
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
              Icon(Icons.check_circle, color: successColor),
              SizedBox(width: spSm),
              Text(
                "Recently Claimed",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigate to full claimed rewards history
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: claimedRewards.take(3).map((reward) => _buildClaimedRewardItem(reward)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimedRewardItem(Map<String, dynamic> reward) {
    Color rarityColor = _getRarityColor(reward["rarity"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: successColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${reward["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    _buildRarityBadge(reward["rarity"]),
                  ],
                ),
                Text(
                  "${reward["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  children: (reward["rewards"] as List<String>).map((item) => 
                    Text(
                      item,
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ).toList(),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Claimed",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${DateTime.parse(reward["claimedDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardStats() {
    int totalClaimed = claimedRewards.length;
    int availableCount = availableRewards.where((r) => r["unlocked"] && !r["claimed"]).length;
    int inProgressCount = availableRewards.where((r) => !r["unlocked"]).length;
    
    return Container(
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
            "Reward Statistics",
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
                child: _buildStatCard("Total Claimed", "$totalClaimed", successColor, Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Available", "$availableCount", warningColor, Icons.card_giftcard),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("In Progress", "$inProgressCount", infoColor, Icons.hourglass_empty),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "Common":
        return Colors.grey;
      case "Rare":
        return Colors.blue;
      case "Epic":
        return Colors.purple;
      case "Legendary":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _claimReward(Map<String, dynamic> reward) {
    // Simulate claiming reward
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      
      // Update reward status
      reward["claimed"] = true;
      
      // Add to claimed rewards
      claimedRewards.insert(0, {
        "title": reward["title"],
        "description": reward["description"],
        "rewards": reward["rewards"],
        "claimedDate": DateTime.now().toIso8601String(),
        "rarity": reward["rarity"]
      });
      
      // Update currency (simulate adding coins from first reward)
      if (reward["rewards"].isNotEmpty) {
        String firstReward = reward["rewards"][0];
        if (firstReward.contains("Coins")) {
          String coinsStr = firstReward.replaceAll(RegExp(r'[^0-9]'), '');
          int coins = int.tryParse(coinsStr) ?? 0;
          playerInventory["coins"] = (playerInventory["coins"] as int) + coins;
        }
      }
      
      setState(() {});
      ss("${reward["title"]} claimed successfully!");
    });
  }
}
