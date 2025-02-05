import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/models/product_details.dart';
import 'package:e_commerce_app/services/services.dart';
import 'package:e_commerce_app/views/screens/add_to_cart_screen.dart';
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
                return const Center(child: Text(""));
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data
                        ?.map((e) => ProductDetails.fromJson(e.data()))
                        .toList() ??
                    [];
            }
            if (list.isNotEmpty) {
              return GridView.builder(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _searchList.length, // Use actual item count
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(mq.width * 0.02),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddToCart(
                                          productDetails: _searchList[index],
                                        )));
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: mq.width * 0.02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: mq.height * 0.17,
                                width: mq.width * 0.5,
                                imageUrl:
                                    _searchList[index].image![0].toString(),
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Center(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            _searchList[index].productName.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        _searchList[index].sale == "Sale"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Rs:" +
                                          _searchList[index]
                                              .salePrice
                                              .toString(),
                                      style: TextStyle(fontSize: 10),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: mq.width * 0.01,
                                  ),
                                  Center(
                                    child: Text(
                                      _searchList[index].price.toString(),
                                      style: TextStyle(
                                          fontSize: 10,
                                          decoration:
                                              TextDecoration.lineThrough),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  "Rs:" + _searchList[index].price.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ],
                    ),
                  );
                },
              );
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
