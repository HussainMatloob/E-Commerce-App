import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:e_commerce_app/widgets/reuseable_gridview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  List<ProductDetails> list = [];
  List<ProductDetails> _searchList = [];

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: Container(
      //       height: mq.height*0.06,
      //       width: mq.width*0.7,
      //       decoration: BoxDecoration(
      //
      //       ),
      //       child: TextField(
      //         decoration: InputDecoration(
      //         hintText: "Search",
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(100),
      //           ),
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(100),
      //             borderSide: BorderSide(
      //               color: Colors.green, // Set the border color here
      //
      //             ),
      //           ),
      //           contentPadding: EdgeInsets.symmetric(vertical: mq.height*0.01, horizontal:mq.width*0.04),
      //
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      child: Scaffold(
        appBar: AppBar(
          title: Container(
              height: mq.height * 0.06,
              width: mq.width * 0.7,
              decoration: BoxDecoration(),
              child: TextField(
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: Colors.green,
                    ), // Set the border color here
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: mq.height * 0.01, horizontal: mq.width * 0.04),
                ),
                autofocus: true,
                onChanged: (val) {
                  _searchList.clear();
                  for (var i in list) {
                    // _searchList.clear();
                    if (val != "") {
                      if ((i.productName ?? "")
                          .toLowerCase()
                          .contains(val.toLowerCase())) {
                        _searchList.add(i);
                      }
                    }

                    setState(() {
                      _searchList;
                    });
                  }
                },
              )),
        ),
        body: StreamBuilder(
          stream: ServicesOrApis.fireStore
              .collection("EasyShoppingProducts")
              .snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child:Text(""));
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list  = data
                        ?.map((e) => ProductDetails.fromJson(e.data()))
                        .toList() ??
                    [];
            }
            if (list.isNotEmpty) {
                    return GridViewWidget(details: _searchList);
            } else {
              return Center(
                  child: Text(
                "",
                style: TextStyle(fontSize: 20),
              ));
            }
          },
        ),
      ),
    );
  }
}
