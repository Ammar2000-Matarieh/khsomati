import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khsomati/business_logic/cubit/auth/auth_cubit.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/app_size.dart';
import 'package:khsomati/presentation/widget/text_feild.dart';
import 'package:khsomati/router/route_string.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isPicking = false;

  DateTime selectedDate = DateTime.now();
  String? _selectedGender; // متغير لتخزين الجنس المختار

  final TextEditingController fisrtNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    if (_isPicking) return;
    _isPicking = true;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxHeight: 800,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    } finally {
      _isPicking = false;
    }
  }

  void pickDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSize.height * 0.05),

              // صورة الملف الشخصي
              Center(
                child: GestureDetector(
                  onTap: _pickImageFromGallery,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                width: AppSize.width * 0.4,
                                height: AppSize.width * 0.4,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 130,
                                height: 130,
                                color: AppColors.primary,
                                child: Icon(
                                  Icons.person,
                                  size: AppSize.width * 0.1,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppColors.darkBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.add, size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppSize.height * 0.05),

              // الاسم الأول و الأخير
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: fisrtNameController,
                        hintText: 'First Name',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: AppSize.width * 0.06),
                    Expanded(
                      child: CustomTextFormField(
                        controller: lastNameController,
                        hintText: 'Last Name',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // الايميل
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 12,
                ),
                child: CustomTextFormField(
                  controller: emailController,
                  hintText: 'E-mail Address',
                  keyboardType: TextInputType.emailAddress,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              // Dropdown لاختيار الجنس
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 8,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('اختر الجنس'),
                    value: _selectedGender,
                    items: ['ذكر', 'أنثى'].map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    underline: const SizedBox(), // لإزالة الخط الافتراضي
                  ),
                ),
              ),

              // تاريخ الميلاد
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 8,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Birth Day:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.edit_calendar_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              SizedBox(
                height: 55,
                width: AppSize.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().createAccount(
                      firstName: fisrtNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      gender: _selectedGender ?? "",
                      date: selectedDate.toString(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primary,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        );
                      } else {
                        return Text("Submit");
                      }
                    },
                    listener: (context, state) {
                      if (state is AuthLogedIn) {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteString.layout,
                        );
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
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
    );
  }
}
