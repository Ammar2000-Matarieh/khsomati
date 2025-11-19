import 'package:flutter/material.dart';
import 'package:khsomati/constants/app_colors.dart';

class StoreItem extends StatelessWidget {
  final String storeName;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const StoreItem({
    super.key,
    required this.storeName,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 130,
            height: 130,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة المتجر
                Container(
                  width: 130,
                  height: 95,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),

                const SizedBox(height: 5),

                // اسم المتجر
                Text(
                  storeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          /// ✔ علامة الصح لما يكون مختار
          if (isSelected)
            const Positioned(
              bottom: 2,
              right: 2,
              child: Icon(Icons.check_circle, color: Colors.white, size: 24),
            ),
        ],
      ),
    );
  }
}
