import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../main.dart';

class ShimmerEffectWidget extends StatelessWidget {
  const ShimmerEffectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return GridView.builder(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

      ),
      itemCount: 6, // Use actual item count
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade700,
            highlightColor: Colors.grey.shade100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                   Container(
                    height: mq.height*0.15,
                    width: mq.width*0.34,
                    color: Colors.white,
                  ),
                 SizedBox(height: mq.height*0.01,),
                 Container(
                    height: mq.height*0.017,
                    width: mq.width*0.33,
                    color: Colors.white,
                  ),
                SizedBox(height: mq.height*0.01,),
                   Container(
                    height: mq.height*0.014,
                    width: mq.width*0.3,
                    color: Colors.white,
                  ),

              ],
            ));
      },
    );
  }
}
