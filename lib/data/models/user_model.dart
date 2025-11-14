import 'dart:convert';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? gender;
  String? date;
  String? token;
  String? photo;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.gender,
    this.date,
    this.token,
    this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      date: json['date'],
      token: json['token'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email':email,
      'gender': gender,
      'date': date,
      'photo': photo,
    };
  }
}
