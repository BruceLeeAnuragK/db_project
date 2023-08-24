import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/category images.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int borderIndex = 0;
    ImageByteFormat imageByte;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              ...List.generate(
                allCategoryImages.length,
                (index) => GestureDetector(
                  onTap: () async {
                    setState(() {
                      borderIndex = index;
                      imageByte = await rootBundle
                          .load(allCategoryImages[index]["image"]);
                    });
                  },
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                      border: Border.all(
                        width: 2,
                        color: (borderIndex == index)
                            ? Colors.black
                            : Colors.transparent,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            foregroundImage:
                                AssetImage(allCategoryImages[index]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("${allCategoryImages[index]["label"]}"),
                          TextField(
                            decoration: InputDecoration(
                              label: Text("Category Name"),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
