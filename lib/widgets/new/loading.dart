import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SavingsInvestmentLoadingWidget extends StatelessWidget {
  const SavingsInvestmentLoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
            ShimmerLoading()
          ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          if(index == 0){
            return  Row(
              children: [
                SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }
          return  SizedBox(
            width: 200.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: 40.0,
                height: 8.0,
                color: Colors.white,
              ),
            ),
          );
        },itemCount: 4,

        ),
      ),
    );
  }
}