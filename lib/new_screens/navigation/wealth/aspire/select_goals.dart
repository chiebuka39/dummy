import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/name_goal_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class SelectGoalScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SelectGoalScreen(),
        settings:
        RouteSettings(name: SelectGoalScreen().toStringShort()));
  }
  @override
  _SelectGoalScreenState createState() => _SelectGoalScreenState();
}

class _SelectGoalScreenState extends State<SelectGoalScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> goals = ['Rent', 'Vacation', 'Gift', 'Wedding', 'Education', 'Business'];
    return Scaffold(

      bottomNavigationBar: Container(
        height: 105,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),
              topRight: Radius.circular(25)),
          boxShadow: [BoxShadow(
            offset: Offset(0,-16),
            blurRadius: 60,
            color: Colors.black.withOpacity(0.18)
          )]
        ),
        child: Column(children: [
          YMargin(20),
          PrimaryButtonNew(
            onTap: (){
              Navigator.push(context, NameYourGoalScreen.route());
            },
            title: 'Create Custom goal',
          )
        ],),
      ),
      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined,size: 20,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            title: Text("Create Zimvest Aspire",
              style: TextStyle(color: Colors.black87,fontSize: 14, fontFamily: AppStrings.fontMedium),),
          ),
          SliverList(delegate: SliverChildListDelegate([
            YMargin(52),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Choose Savings Goal",
                style: TextStyle(fontSize: 15,fontFamily: AppStrings.fontBold),),
            ),
            YMargin(30),
          ]),),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30,
              children: [
                ...List.generate(goals.length, (index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, NameYourGoalScreen.route(goalName: goals[index]));
                    },
                    child: Container(
                      
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/v0/b/tick-bc0e3.appspot.com/o/pexels-anete-lusina-5723322.'
                                'jpg?alt=media&token=4858ef91-820b-4ff3-aae7-a02ce3507c6d',height: 154,fit: BoxFit.fill,),
                          ),
                          Container(
                            height: 154,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.4)
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Text(goals[index], style: TextStyle(color: AppColors.kWhite),),
                                  Spacer(),
                                ],
                              ),
                            ],
                          )



                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          )

      ],),
    );
  }
}
