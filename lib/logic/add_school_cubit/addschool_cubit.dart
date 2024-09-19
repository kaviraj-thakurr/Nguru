import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:nguru/local_database/add_school_list_hive_box.dart';
import 'package:nguru/logic/add_school_cubit/addschool_state.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/utils/shared_prefrences/shared_prefrences.dart';

class AddSchoolCubit extends Cubit<AddSchoolState> {
  final AuthRepo? authRepo;

  AddSchoolCubit(this.authRepo) : super(AddSchoolInitState());

  Box<UserModel>? box;
  List<UserModel>? addSchoolList;

  Future<void> openAddSchoolBox() async {
    box = await Hive.openBox<UserModel>('listItems');

    addSchoolList = box?.values.toSet().toList() ?? [];
    removeDuplicateSchools(addSchoolList);
    log("length: ${addSchoolList?.length}");
  }

  void removeDuplicateSchools(List<UserModel>? addSchoolList) {
    if (addSchoolList == null) return;

    // Set to track unique subDomains
    final uniqueSubDomains = <String>{};

    // Retain only the first occurrence of each unique subDomain
    addSchoolList.retainWhere((user) => uniqueSubDomains.add(user.subDomain));
  }

  Future<void> addSchool(
      String schoolName, String subDomain, String schoolNickName,
      {bool isNavigating = true}) async {
    try {
      if (isNavigating) {
        emit(AddSchoolLoadingState());
      }

      final result = await authRepo?.addSchool(
        schoolName,
        subDomain,schoolNickName
      );
      await SharedPref.saveUrl(schoolName+"mobileappservice/Api/");
          log("schooooooooooooooolurl ----------->${schoolName+"mobileappservice/Api/"}");

      openAddSchoolBox();
      if (result != null) {
        if (result.responseCode == "200" ||
            result.schoolName != null ||
            result.schoolPhoto != null) {
          // if (addSchoolList == null) {
          //   Hive.box<UserModel>('listItems').add(UserModel(
          //     schoolUrl: "$schoolName",
          //     subDomain: "$subDomain",
          //     schoolNickName: "$schoolNickName",
          //   ));
          // }
          // bool exists = addSchoolList!.any(
          //     (e) => e.schoolUrl == schoolName && e.subDomain == subDomain);

          // if (!exists) {
          //   Hive.box<UserModel>('listItems').add(UserModel(
          //     schoolUrl: "$schoolName",
          //     subDomain: "$subDomain",
          //     schoolNickName: "$schoolNickName",
          //   ));
          // }
          

          if (isNavigating) {
            emit(AddSchoolSuccessState(
              schoolName: result.schoolName,
              schoolPhoto: result.schoolPhoto,
            ));
          } else {
            emit(AddSchoolSuccessUpdated(
              schoolName: result.schoolName,
              schoolPhoto: result.schoolPhoto,
            ));
          }
        } else {
          emit(AddSchoolErrorState(result.responseMessage ?? "Error occured"));
        }
      }
    } catch (e) {
      emit(AddSchoolErrorState(e.toString()));
    }
  }

  saveToHive(String schoolUrl, String subDomain, String schoolNickName) async {
    final box =   Hive.box<UserModel>('listItems');
    final user = UserModel(
      schoolUrl: schoolUrl,
      subDomain: subDomain,
      schoolNickName: schoolNickName,
    );
    var userModel = box.values.toList();
    UserModel existingUser = userModel.isEmpty?UserModel(schoolUrl: "", subDomain: "", schoolNickName: ""): userModel.firstWhere(
      (user) => user.schoolUrl == schoolUrl && user.subDomain == subDomain,
    );
    if (existingUser.isInBox) {
      box.put(existingUser.key, existingUser);
    } else {
      box.add(user).then((value) async {
        debugPrint("Success");
        var box = await Hive.openBox<UserModel>('listItems');
        var userModel = box.values.toList();
        debugPrint("fetching: $userModel");
      }).onError((error, stackTrace) {
        debugPrint("Failed!!!");
      });
    }
  }
}
