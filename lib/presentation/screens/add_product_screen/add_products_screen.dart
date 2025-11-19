import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khsomati/business_logic/cubit/product/product_cubit.dart';
import 'package:khsomati/business_logic/cubit/product/product_state.dart';
import 'package:khsomati/business_logic/cubit/store/store_cubit.dart';
import 'package:khsomati/business_logic/cubit/store/store_state.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/data/models/store_model.dart';
import 'package:khsomati/presentation/screens/add_product_screen/component/store_item.dart';
import 'package:khsomati/presentation/screens/create_store_screen.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedStore;
  String? id;

  final TextEditingController productName = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productDesc = TextEditingController();

  Uint8List? image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      image = await picked.readAsBytes();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<StoreModel> stores = context.read<StoreCubit>().myStores;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.white),
        ),
        title: const Text(
          "Add Product",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
      ),

      backgroundColor: AppColors.thirdWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Select store or create one",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 130,
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  const customButton(),
                  const SizedBox(width: 20),

                  Expanded(
                    child: BlocBuilder<StoreCubit, StoreState>(
                      builder: (context, state) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return StoreItem(
                              storeName: stores[index].name!,
                              isSelected: selectedStore == stores[index].name!,
                              onTap: () {
                                setState(() {
                                  selectedStore = stores[index].name!;
                                  id = stores[index].id!;
                                });
                              },
                              imageUrl: stores[index].mainImageUrl!,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 20),
                          itemCount: stores.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ======================== PRODUCT FORM ========================
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedStore == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selected store: $selectedStore",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.primary,
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// ================= Upload Product Image =================
                              GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: image == null
                                      ? const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_photo_alternate,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(height: 8),
                                              Text("Upload Product Image"),
                                            ],
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          child: Image.memory(
                                            image!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              _inputField(
                                productName,
                                "Product Name",
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Product name is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),

                              _inputField(
                                productPrice,
                                "Price",
                                type: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Price is required";
                                  }
                                  if (double.tryParse(value) == null) {
                                    return "Price must be a valid number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),

                              _inputField(
                                productDesc,
                                "Description",
                                maxLines: 3,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Description is required";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    backgroundColor: AppColors.primary,
                                  ),
                                  onPressed: () {
                                    if (image == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please upload product image",
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    if (_formKey.currentState!.validate()) {
                                      context.read<ProductCubit>().addProduct(
                                        storeId: id!,
                                        name: productName.text.trim(),
                                        description: productDesc.text.trim(),
                                        price: productPrice.text.trim(),
                                        image: image!,
                                      );
                                    }
                                  },
                                  child:
                                      BlocBuilder<ProductCubit, ProductState>(
                                        builder: (context, state) {
                                          if (state is ProductLoading) {
                                            return CircularProgressIndicator(
                                              color: AppColors.white,
                                            );
                                          } else {
                                            return Text(
                                              "Save Product",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            );
                                          }
                                        },
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
      ),
    );
  }

  Widget _inputField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    TextInputType type = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: type,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class customButton extends StatelessWidget {
  const customButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => CreateStoreScreen())),
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_business_rounded, color: Colors.white, size: 35),
            SizedBox(height: 6),
            Text(
              "Create",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
