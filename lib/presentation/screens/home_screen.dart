import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:khsomati/constants/app_size.dart';
import 'package:khsomati/data/models/on_boarding_model.dart';
import 'package:khsomati/presentation/widget/text_feild.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppSize.height * 0.06,
                    width: AppSize.width * 0.9,
                    child: CustomTextFormField(
                      controller: searchController,
                      validator: (value) {},
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),

                  SizedBox(height: AppSize.height * 0.03),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Top Discounts',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSize.height * 0.05),
                  CarouselSlider.builder(
                    carouselController: buttonCarouselController,
                    itemCount: onBoardingData.length,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          onBoardingData[index].image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 180,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      onPageChanged: (index, reason) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
