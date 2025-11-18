import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:khsomati/business_logic/cubit/store/store_state.dart';
import 'package:khsomati/data/models/store_model.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(Default());
  List<StoreModel> myStores = [];
  Future<void> creatStore({
    required String userId,
    required String name,
    required String description,
    required String phone,
    required String whatsapp,
    required Uint8List? mainImage,
    required List<Uint8List> extraImages,
  }) async {
    emit(Loading());

    try {
      String mainImageUrl = "";
      if (mainImage != null) {
        mainImageUrl = await uploadToImgbb(mainImage);
      }
      List<String> extraImagesUrls = [];
      if (extraImages.isNotEmpty) {
        for (Uint8List image in extraImages) {
          String url = await uploadToImgbb(image);
          extraImagesUrls.add(url);
        }
      }
      final doc = FirebaseFirestore.instance.collection('store').doc();
      final id = doc.id;
      StoreModel store = StoreModel(
        id: id,
        userId: userId,
        name: name,
        description: description,
        phone: phone,
        whatsapp: whatsapp,
        mainImageUrl: mainImageUrl,
        extraImagesUrls: extraImagesUrls,
      );
      await doc.set(store.toJson());
      myStores.add(store);
      emit(StoreCreated());
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

  Future<void> getMyStores({required String userId}) async {
    try {
      myStores.clear();
      final doc = await FirebaseFirestore.instance
          .collection('store')
          .where('userId', isEqualTo: userId)
          .get();
      if (doc.docs.isNotEmpty) {
        myStores = doc.docs.map((doc) {
          return StoreModel.fromJson(doc.data());
        }).toList();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
