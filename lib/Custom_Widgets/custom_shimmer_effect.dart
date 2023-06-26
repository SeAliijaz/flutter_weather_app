import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerEffect extends StatelessWidget {
  const CustomShimmerEffect({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Color(0xFFC0C0C0),
      child: ListView(
        children: [
          ///Header Div
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            color: Colors.white,
          ),

          ///SizedBox
          SizedBox(height: 5),

          ///Grid View
          _shimmerGridView(),

          ///ListTile
          _shimmerTile(),
          _shimmerTile(),
          _shimmerTile(),
          _shimmerTile(),
        ],
      ),
    );
  }

  GridView _shimmerGridView() {
    return GridView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      children: [
        Container(
          color: Colors.white,
        ),
        Container(
          color: Colors.white,
        ),
      ],
    );
  }

  ListTile _shimmerTile() {
    return ListTile(
      leading: Container(
        height: 56,
        width: 56,
        color: Colors.white,
      ),
      title: Container(
        height: 16,
        width: double.infinity,
        color: Colors.white,
      ),
      subtitle: Container(
        height: 12,
        width: 100,
        color: Colors.white,
      ),
    );
  }
}
