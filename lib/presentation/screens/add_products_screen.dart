import 'package:flutter/material.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  // قائمة المحلات (تجيبها من API أو Firebase)
  List<String> storesList = []; // مثال: ['Store 1', 'Store 2'];
  String? selectedStore;

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  void _loadStores() {
    // هون بتحمل المحلات من الداتا
    // مثال:
    // storesList = await MyAPI.getStores();
    setState(() {
      storesList = ["zara", "one_minute"]; // اتركها فاضية كمثال
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: storesList.isEmpty
            ? _noStoreWidget(context)
            : _addProductForm(context),
      ),
    );
  }

  // *************** لا يوجد محلات ***************
  Widget _noStoreWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.store_mall_directory, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            "لا يوجد أي محل مضاف",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // روح على صفحة إنشاء محل
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateStoreScreen()),
              ).then((value) {
                // بعد ما يرجع من صفحة إنشاء محل
                _loadStores();
              });
            },
            child: const Text("إنشاء محل"),
          ),
        ],
      ),
    );
  }

  // *************** يوجد محلات : عرض فورم المنتج ***************
  Widget _addProductForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("اختر المحل", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),

        // Dropdown اختيار المحل
        DropdownButtonFormField<String>(
          value: selectedStore,
          items: storesList
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (value) {
            setState(() => selectedStore = value);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "اختر المحل",
          ),
        ),

        const SizedBox(height: 30),

        if (selectedStore != null) ...[
          const Text(
            "أدخل بيانات المنتج",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "اسم المنتج",
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "السعر",
            ),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // عملية إضافة المنتج
            },
            child: const Text("إضافة المنتج"),
          ),
        ],
      ],
    );
  }
}

// ************ صفحة إنشاء محل (مثال بسيط) ************
class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء محل")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "اسم المحل",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "created");
              },
              child: const Text("حفظ"),
            ),
          ],
        ),
      ),
    );
  }
}
