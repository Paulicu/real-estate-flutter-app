import 'package:flutter/material.dart';
import 'package:real_estate_flutter_app/models/house_model.dart';
import 'package:real_estate_flutter_app/utils/common/constants.dart';
import 'package:real_estate_flutter_app/utils/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ItemDetailScreen extends StatefulWidget {
  final House house;
  final int imgPathIndex;

  const ItemDetailScreen({super.key, required this.house, required this.imgPathIndex});

  @override
  ItemDetailScreenState createState() => ItemDetailScreenState();
}

class ItemDetailScreenState extends State<ItemDetailScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.imgPathIndex;
  }

  void goToNextHouse() {
    setState(() {
      currentIndex = (currentIndex + 1) % Constants.houseList.length;
    });
  }

  void goToPreviousHouse() {
    setState(() {
      currentIndex = (currentIndex - 1 + Constants.houseList.length) % Constants.houseList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("##,###,###", "en_INR");
    House currentHouse = Constants.houseList[currentIndex];

    return Scaffold(
      backgroundColor: ColorConstant.kWhiteColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 25, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    Constants.imageList[currentIndex],
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      right: 16,
                      left: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomButtonWidget(
                          icon: Icons.arrow_back,
                          iconColor: ColorConstant.kBlackColor,
                          backgroundColor: Colors.transparent,
                          onBtnTap: () {
                            Navigator.pop(context, Constants.houseList[currentIndex]);
                          },
                        ),
                        CustomButtonWidget(
                          icon: currentHouse.isFavorite ? Icons.favorite : Icons.favorite_border,
                          iconColor: currentHouse.isFavorite ? Colors.redAccent : ColorConstant.kBlackColor,
                          backgroundColor: Colors.transparent,
                          onBtnTap: () {
                            setState(() {
                              Constants.houseList[currentIndex].isFavorite =
                              !Constants.houseList[currentIndex].isFavorite;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${oCcy.format(currentHouse.price)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            currentHouse.address,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        height: 45,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.white24,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${Random().nextInt(24)} hours ago",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 16,
                ),
                child: Text(
                  "House Information",
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorConstant.kBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom: 20,
                ),
                child: Text(
                  "Flawless 2 story on a family friendly cul-de-sac in the heart of Blue Valley! Walk in to an open floor plan flooded w daylight, formal dining private office, screened-in lanai w fireplace, TV hookup & custom heaters that overlooks the lit basketball court.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstant.kGreyColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: goToPreviousHouse,
                    child: const Text('Previous House'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: goToNextHouse,
                    child: const Text('Next House'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
