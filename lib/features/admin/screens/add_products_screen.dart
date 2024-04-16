import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfiled.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utilis.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/addProduct";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();

  final AdminServices adminServices = AdminServices();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _qualityController.dispose();
    _subCategoryController.dispose();
  }

  String Category = 'Fashion';

  List<File> images = [];
  final _addKey = GlobalKey<FormState>();

  List<String> ProductsCategories = [
    'Fashion',
    'Mobiles',
    'Electronics',
    'Beauty',
  ];

  void sellProduct() {
    if (_addKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(context: context, name: _productNameController.text, description: _descriptionController.text, price: double.parse(_priceController.text), quantity: double.parse(_qualityController.text), category: Category, images: images, subCategory: _subCategoryController.text);
    }
  }

  void SelectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF84d8e2),
                  Color(0xFF92deda),
                  Color(0xFFa5e6d0),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          title: Text(
            'Add Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 20, right: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(
                              builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 230,
                                  ));
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 230,
                        ),
                      )
                    : GestureDetector(
                        onTap: SelectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),
                          dashPattern: [
                            10,
                            4
                          ],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Select Product Image',
                                  style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                customTextField(controller: _productNameController, hintText: 'Product Name', obSecureChar: false),
                SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: _descriptionController,
                  hintText: 'Description',
                  obSecureChar: false,
                  maxLines: 6,
                ),
                SizedBox(
                  height: 10,
                ),
                customTextField(controller: _priceController, hintText: 'Price', obSecureChar: false),
                SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: _qualityController,
                  hintText: 'Quality',
                  obSecureChar: false,
                ),
                SizedBox(
                  height: 10,
                ),
                customTextField(
                  controller: _subCategoryController,
                  hintText: 'Mobile Name',
                  obSecureChar: false,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: Category,
                    items: ProductsCategories.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        Category = newValue!;
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                customButton(text: 'Sell', onTap: sellProduct)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
