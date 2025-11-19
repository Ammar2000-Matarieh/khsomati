import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:khsomati/business_logic/cubit/product/product_state.dart';
import 'package:khsomati/data/models/product_model.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(Default());
  List<ProductModel> products = [];
  Future<void> addProduct({
    required String storeId,
    required String name,
    required String description,
    required String price,
    required Uint8List image,
  }) async {
    emit(ProductLoading());

    try {
      String imageUrl = "";
      if (image != null) {
        imageUrl = await uploadToImgbb(image);
      }

      final doc = FirebaseFirestore.instance.collection('product').doc();
      final id = doc.id;
      ProductModel product = ProductModel(
        id: id,
        storeId: storeId,
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      await doc.set(product.toJson());

      emit(ProductAdded());
    } catch (e) {
      emit(Erorr(message: "message $e"));
    }
  }

  Future<String> uploadToImgbb(Uint8List imageBytes) async {
    const String apiKey = "7c73a5e0c7e02448504113661dd53a81";

    try {
      final url = Uri.parse("https://api.imgbb.com/1/upload?key=$apiKey");

      var request = http.MultipartRequest("POST", url);

      // حط الصورة مباشرة بدون Base64
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: "${DateTime.now().millisecondsSinceEpoch}.jpg",
        ),
      );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Status: ${response.statusCode}");
      print("Body: $responseBody");

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        return data["data"]["url"];
      } else {
        return "";
      }
    } catch (e) {
      print("Upload Error: $e");
      return "";
    }
  }

  Future<void> getProduct({required String id}) async {
    try {
      products.clear();
      final doc = await FirebaseFirestore.instance
          .collection('product')
          .where('storeId', isEqualTo: id)
          .get();
      if (doc.docs.isNotEmpty) {
        products = doc.docs.map((doc) {
          return ProductModel.fromJson(doc.data());
        }).toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
