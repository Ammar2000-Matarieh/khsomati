import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/product/product_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/app_size.dart';
import 'package:khsomati/data/models/product_model.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = context.read<ProductCubit>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: products.isEmpty
            ? const Center(
                child: Text(
                  "No products available",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : ListView.separated(
                itemCount: products.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return CustomItem(
                    name: products[index].name!,
                    desc: products[index].description!,
                    imageUrl: products[index].imageUrl!,
                    price: products[index].price!,
                  );
                },
              ),
      ),
    );
  }
}

class CustomItem extends StatefulWidget {
  const CustomItem({
    super.key,
    required this.name,
    required this.desc,
    required this.imageUrl,
    required this.price,
  });

  final String name;
  final String desc;
  final String imageUrl;
  final String price;

  @override
  State<CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.height * 0.22,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          /// Product Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(
              widget.imageUrl,
              height: double.infinity,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),

          /// Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  /// Description
                  Text(
                    widget.desc,
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(),

                  /// Price + Favorite Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 22,
                          child: Icon(
                            Icons.favorite,
                            color: isFavorite ? Colors.red : Colors.grey[400],
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
