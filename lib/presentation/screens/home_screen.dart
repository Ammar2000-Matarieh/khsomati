import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/product/product_cubit.dart';
import 'package:khsomati/business_logic/cubit/store/store_cubit.dart';
import 'package:khsomati/business_logic/cubit/store/store_state.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/app_size.dart';
import 'package:khsomati/data/models/on_boarding_model.dart';
import 'package:khsomati/data/models/store_model.dart';
import 'package:khsomati/presentation/widget/text_feild.dart';
import 'package:khsomati/router/route_string.dart';

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
    final List<StoreModel> stores = context.read<StoreCubit>().allStores;
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
                      validator: (value) {
                        return null;
                      },
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
                  BlocBuilder<StoreCubit, StoreState>(
                    builder: (context, state) {
                      return CarouselSlider.builder(
                        carouselController: buttonCarouselController,
                        itemCount: stores.length,
                        itemBuilder: (context, index, realIndex) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              stores[index].mainImageUrl!,
                              fit: BoxFit.cover,
                              width: AppSize.width * 0.9,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 300,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          onPageChanged: (index, reason) {},
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSize.height * 0.04),
                  Row(
                    children: [
                      Text(
                        "Discounts",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // return
                        },
                        child: Text("See all", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.height * 0.02),

                  SizedBox(
                    height: 130,
                    child: BlocBuilder<StoreCubit, StoreState>(
                      builder: (context, state) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: stores.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: AppSize.width * 0.09);
                          },
                          itemBuilder: (context, index) {
                            return CustomStoresInYourArea(
                              imageUrl: stores[index].mainImageUrl!,
                              id: stores[index].id!,
                            );
                          },
                        );
                      },
                    ),
                  ),

                  SizedBox(height: AppSize.height * 0.03),

                  Row(
                    children: [
                      Text(
                        "Stores in Your Area",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // return
                          Navigator.pushNamed(context, RouteString.viewProduct);
                        },
                        child: Text("See all", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 130,
                    child: BlocBuilder<StoreCubit, StoreState>(
                      builder: (context, state) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: AppSize.width * 0.09);
                          },
                          itemBuilder: (context, index) {
                            return CustomStoresInYourArea(
                              imageUrl: stores[index].mainImageUrl!,
                              id: stores[index].id!,
                            );
                          },
                          itemCount: stores.length,
                        );
                      },
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

// icons
// final class CustemIcons extends StatelessWidget {
//   final int index;
//   const CustemIcons({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Column(
//         children: [
//           Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(400),
//               color: Colors.amber,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadiusGeometry.circular(100),
//               child: Center(child: Icon(_icons[index])),
//             ),
//           ),

//           Text("Ccccccc"),
//         ],
//       ),
//     );
//   }
// }

// List<IconData> _icons = [
//   Icons.shopping_cart,
//   Icons.checkroom,
//   Icons.devices,
//   Icons.home_filled,
//   Icons.spa,
// ];

//StoresInYourArea
class CustomStoresInYourArea extends StatelessWidget {
  const CustomStoresInYourArea({
    super.key,
    required this.imageUrl,
    required this.id,
  });
  final String imageUrl;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<ProductCubit>().getProduct(id: id);
        Navigator.pushNamed(context, RouteString.viewProduct);
      },
      child: Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.thirdWhite,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
