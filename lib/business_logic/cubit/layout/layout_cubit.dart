import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:khsomati/presentation/screens/home_screen.dart';
import 'package:khsomati/presentation/screens/notifications_screen.dart';
import 'package:khsomati/presentation/screens/profile_screen.dart';
import 'package:khsomati/presentation/screens/shop_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  void changeNavigationBar(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  Widget screen(BuildContext context) {
    switch (state.currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        // return NotificationsScreen();
        return ComingSoonScreen();
      case 2:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }
}
