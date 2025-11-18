import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomati/business_logic/cubit/store/store_cubit.dart';
import 'package:khsomati/business_logic/cubit/store/store_state.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/data/models/store_model.dart';
import 'package:khsomati/presentation/screens/create_store_screen.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD

  String? selectedStore; // المتجر المختار
=======
  final List stores = ["Zara", "Nike", "Adidas", "H&M", "Pull&Bear", "Bershka"];
  String? selectedStore;
>>>>>>> c3816330cb234fb423a3843f0da4400f928e8d7a

  // Controllers
  final TextEditingController productName = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<StoreModel> stores = context.read<StoreCubit>().myStores;
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Select store or create one",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            /// ------------------- Stores Row -------------------
            SizedBox(
              height: 110,
              child: Row(
                children: [
                  const customButton(),
                  const SizedBox(width: 20),

                  Expanded(
                    child: BlocBuilder<StoreCubit, StoreState>(
                      builder: (context, state) {
                        if (state is StoreCreated) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return StoreItemWidget(
                                storeName: stores[index].name!,
                                isSelected:
                                    selectedStore == stores[index].name!,
                                onTap: () {
                                  setState(() {
                                    selectedStore = stores[index].name!;
                                  });
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 20),
                            itemCount: stores.length,
                          );
                        } else {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return StoreItemWidget(
                                storeName: stores[index].name!,
                                isSelected:
                                    selectedStore == stores[index].name!,
                                onTap: () {
                                  setState(() {
                                    selectedStore = stores[index].name!;
                                  });
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 20),
                            itemCount: stores.length,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ------------------- Product Form -------------------
            ///
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
                                  color: Colors.deepPurple,
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
                                    if (_formKey.currentState!.validate()) {
                                      // إذا كلشي صح
                                      print("Saving product...");
                                    }
                                  },
                                  child: const Text(
                                    "Save Product",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
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
            // AnimatedSwitcher(
            //   duration: const Duration(milliseconds: 300),
            //   child: selectedStore == null
            //       ? const SizedBox()
            //       : Padding(
            //           padding: const EdgeInsets.all(16.0),
            //           child: AnimatedContainer(
            //             duration: const Duration(milliseconds: 300),
            //             padding: const EdgeInsets.all(20),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(20),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey.withOpacity(0.3),
            //                   blurRadius: 10,
            //                   offset: const Offset(0, 5),
            //                 ),
            //               ],
            //             ),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "Selected store: $selectedStore",
            //                   style: const TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 16,
            //                     color: Colors.deepPurple,
            //                   ),
            //                 ),
            //                 const SizedBox(height: 20),

            //                 _inputField(productName, "Product Name"),
            //                 const SizedBox(height: 12),

            //                 _inputField(
            //                   productPrice,
            //                   "Price",
            //                   type: TextInputType.number,
            //                 ),
            //                 const SizedBox(height: 12),

            //                 _inputField(
            //                   productDesc,
            //                   "Description",
            //                   maxLines: 3,
            //                 ),
            //                 const SizedBox(height: 20),

            //                 /// Save Button
            //                 SizedBox(
            //                   width: double.infinity,
            //                   child: ElevatedButton(
            //                     style: ElevatedButton.styleFrom(
            //                       padding: const EdgeInsets.symmetric(
            //                         vertical: 14,
            //                       ),
            //                       shape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(15),
            //                       ),
            //                       backgroundColor: Colors.deepPurple,
            //                     ),
            //                     onPressed: () {
            //                       // حفظ المنتج
            //                     },
            //                     child: const Text(
            //                       "Save Product",
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 16,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            // ),
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

//   Widget _inputField(
//     TextEditingController controller,
//     String hint, {
//     int maxLines = 1,
//     TextInputType type = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       maxLines: maxLines,
//       keyboardType: type,
//       decoration: InputDecoration(
//         hintText: hint,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 12,
//         ),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
// }

/// =================================================================
///                            CREATE STORE BUTTON
/// =================================================================
class customButton extends StatelessWidget {
  const customButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => CreateStoreScreen())),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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

/// =================================================================
///                        STORE ITEM WITH SELECTION
/// =================================================================
class StoreItemWidget extends StatelessWidget {
  final String storeName;
  final bool isSelected;
  final VoidCallback onTap;

  const StoreItemWidget({
    super.key,
    required this.storeName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.purple.withOpacity(0.5)
                  : Colors.blueAccent.withOpacity(0.35),
              blurRadius: isSelected ? 15 : 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                storeName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            /// Check icon when selected
            if (isSelected)
              const Positioned(
                top: 6,
                right: 6,
                child: Icon(Icons.check_circle, color: Colors.white, size: 22),
              ),
          ],
        ),
      ),
    );
  }
}
