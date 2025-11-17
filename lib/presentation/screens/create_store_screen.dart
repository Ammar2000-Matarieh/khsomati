import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({super.key});

  @override
  State<CreateStoreScreen> createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController minOrderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? selectedCategory;
  bool deliveryAvailable = false;
  bool isActive = true;

  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  Uint8List? mainImage;
  List<Uint8List> extraImages = [];

  Future<void> pickMainImage() async {
    // 1. اطلب صلاحيات
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Photo permission denied")));
      return;
    }

    // 2. افتح معرض الصور
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    // 3. حول الصورة Uint8List
    final Uint8List imgBytes = await picked.readAsBytes();

    // 4. خزّنها و أعرضها
    setState(() => mainImage = imgBytes);
  }

  Future<void> pickExtraImages() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) return;

    final picker = ImagePicker();
    final List<XFile> files = await picker.pickMultiImage();

    for (var f in files) {
      extraImages.add(await f.readAsBytes());
    }

    setState(() {});
  }

  Future<void> createNewStore() async {
    try {
      print("success create ");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Create Store", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// MAIN IMAGE PICKER
            _buildMainImagePicker(),

            const SizedBox(height: 16),

            /// EXTRA IMAGES
            _buildExtraImagesPicker(),

            const SizedBox(height: 20),

            _buildTextField("Store Name", nameController),
            _buildTextField("Description", descriptionController, maxLines: 3),

            const SizedBox(height: 10),
            Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            _buildCategoryDropdown(),

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField("Phone Number", phoneController),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField("Whatsapp", whatsappController),
                ),
              ],
            ),

            const SizedBox(height: 16),
            _buildLocationPicker(),

            const SizedBox(height: 16),
            _buildWorkingHours(),

            const SizedBox(height: 16),
            _buildDeliverySwitch(),

            if (deliveryAvailable) ...[
              const SizedBox(height: 10),
              _buildTextField("Minimum Order (Optional)", minOrderController),
            ],

            const SizedBox(height: 16),
            _buildTextField("Notes (Optional)", notesController, maxLines: 3),

            const SizedBox(height: 16),
            _buildActiveSwitch(),

            const SizedBox(height: 30),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // ---------------- WIDGETS ----------------

  Widget _buildMainImagePicker() {
    return GestureDetector(
      onTap: () => pickMainImage(),
      // onTap: () async {
      //   // pick image
      // },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: mainImage == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                    SizedBox(height: 6),
                    Text(
                      "Upload Main Image",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(mainImage!, fit: BoxFit.cover),
              ),
      ),
    );
  }

  Widget _buildExtraImagesPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Extra Images", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () => pickExtraImages(),
                // onTap: () async {
                //   // pick multiple images
                // },
                child: Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: Icon(Icons.add, size: 40, color: Colors.grey),
                ),
              ),
              ...extraImages.map(
                (img) => Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(img, fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String title,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text("Select Category"),
          value: selectedCategory,
          items: [
            "Restaurant",
            "Café",
            "Clothes",
            "Supermarket",
            "Furniture",
            "Electronics",
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) => setState(() => selectedCategory = v),
        ),
      ),
    );
  }

  Widget _buildLocationPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            // pick from map
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    addressController.text.isEmpty
                        ? "Pick Location From Map"
                        : addressController.text,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Working Hours", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildTimeBox("Open", openTime, () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (t != null) setState(() => openTime = t);
              }),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildTimeBox("Close", closeTime, () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (t != null) setState(() => closeTime = t);
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeBox(String title, TimeOfDay? time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              time == null ? "--:--" : time.format(context),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliverySwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Delivery Available",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Switch(
          value: deliveryAvailable,
          onChanged: (v) => setState(() => deliveryAvailable = v),
        ),
      ],
    );
  }

  Widget _buildActiveSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Store Active", style: TextStyle(fontWeight: FontWeight.bold)),
        Switch(value: isActive, onChanged: (v) => setState(() => isActive = v)),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(18),
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          await createNewStore();
        },
        child: Text(
          "Create Store",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
