import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/by_caste_proposals.dart';
import '../models/featured.dart';
import '../models/loginModel.dart';
import '../models/proposalDetailModel.dart';
import '../models/proposal_list_model.dart';
import '../utils/global_variables.dart';
import '../utils/urls.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  factory ApiService() {
    return _singleton;
  }
  ApiService._internal();

  Future<dynamic> userSignUp({required Map<String, dynamic> apiParams}) async {
    var res;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http
          .post(Uri.parse('${AppUrls.userSignUp}'),
        // body: jsonEncode(apiParams),
        body: {

        'token' : prefs.getString('token'),
        'profile_created_by' : GlobalVariables.profileCreatedBy,
        'marital_status' : GlobalVariables.maritalStatus,
        'reason_for_second_marriage' : GlobalVariables.reason_for_second_marriage,
        'marriage_period' : GlobalVariables.marriage_period,

        'separation_period' : GlobalVariables.separation_period,
        'kids' : GlobalVariables.kids,
        'kids_ownership' : GlobalVariables.kids_ownership.contains('\u0027') ?
        GlobalVariables.kids_ownership.replaceAll('\u0027', '@'):
        GlobalVariables.kids_ownership,
        'gender' : GlobalVariables.gender,
        'name' : GlobalVariables.name,

        'dob' : GlobalVariables.dob,
        'city' : GlobalVariables.city,
        'area' : GlobalVariables.area,
        'address' : GlobalVariables.address.contains('\u0027') ?
        GlobalVariables.address.replaceAll('\u0027', '@') :
        GlobalVariables.address,
        'height' : GlobalVariables.height.contains('\u0027') ?
        GlobalVariables.height.replaceAll('\u0027', '@') :
        GlobalVariables.height,//GlobalVariables.height,

        'email' : GlobalVariables.email,
        'password' : GlobalVariables.password,
        'primary_phone' : GlobalVariables.primary_phone,
        'secondary_phone' : GlobalVariables.primary_phone,
        'mother_tongue' : GlobalVariables.mother_tongue,

        'religion' : GlobalVariables.religion,
        'sect' : GlobalVariables.sect,
        'caste' : GlobalVariables.caste.contains('\u0027') ?
        GlobalVariables.caste.replaceAll('\u0027', '@') :
        GlobalVariables.caste,
        'subcaste' : GlobalVariables.subcaste.contains('\u0027') ?
        GlobalVariables.subcaste.replaceAll('\u0027', '@') :
        GlobalVariables.subcaste,
        'profession' : GlobalVariables.profession,

        'qualification' : GlobalVariables.qualificatiion.contains('\u0027') ?
        GlobalVariables.qualificatiion.replaceAll('\u0027', '@') :
        GlobalVariables.qualificatiion,
        'occupation' :  GlobalVariables.occupation.contains('\u0027') ?
        GlobalVariables.occupation.replaceAll('\u0027', '@') :
        GlobalVariables.occupation,
        'monthly_income' : GlobalVariables.monthly_income.contains('\u0027') ?
        GlobalVariables.monthly_income.replaceAll('\u0027', '@') :
        GlobalVariables.monthly_income,
        'mother_alive' : GlobalVariables.mother_alive,
        'father_alive' : GlobalVariables.father_alive,

        'siblings' : GlobalVariables.siblings,
        'married_brothers' : GlobalVariables.married_brothers,
        'married_sisters' : GlobalVariables.married_sisters,
        'unmarried_brothers' : GlobalVariables.unmarried_brothers,
        'unmarried_sisters' : GlobalVariables.unmarried_sisters,

        'fathers_occupation' : GlobalVariables.fathers_occupation.contains('\u0027') ?
        GlobalVariables.fathers_occupation.replaceAll('\u0027', '@') :
        GlobalVariables.fathers_occupation,
        'house_in' : GlobalVariables.house_in,
        'possession' : GlobalVariables.possession,
        'house_area' : GlobalVariables.house_area,
        'additional_info' : GlobalVariables.additional_info.contains('\u0027') ?
        GlobalVariables.additional_info.replaceAll('\u0027', '@') :
        GlobalVariables.additional_info,// GlobalVariables.additional_info,

        'profession_demand' : GlobalVariables.profession_demand,
        'caste_demand' : GlobalVariables.caste_demand,
        'age_limit' : GlobalVariables.age_limit,
        'height_demand' :GlobalVariables.height_demand.contains('\u0027') ?
        GlobalVariables.height_demand.replaceAll('\u0027', '@') :
        GlobalVariables.height_demand,// GlobalVariables.height_demand,
        'housing_demand_location' : GlobalVariables.housing_demand_location,

        'housing_demand_possession' : GlobalVariables.housing_demand_possession,
        'housing_demand_in' : GlobalVariables.housing_demand_in,
        'housing_demand_area' : GlobalVariables.housing_demand_area,
        'city_demand' : GlobalVariables.city_demand,
        'additional_demand' :GlobalVariables.additional_demand.contains('\u0027') ?
        GlobalVariables.additional_demand.replaceAll('\u0027', '@') :
        GlobalVariables.additional_demand,// GlobalVariables.additional_demand,

          'account_created_at' : GlobalVariables.account_created_at,
          'is_featured' : '0',
          'featured_start_date' : '0',
          'featured_end_date' :  '0',
          'profile_views_his' : '0',

          'profile_views_others' : '0',
          'is_paid_user' : '0',
          'package_type' : 'trial',
          'favourites' : '0',
          'activate_call_check' :'0',

          'number_of_call_views' : '0',
          'involve_in_issue' : '0',
          'issue_detail' : '0',
          'is_active_account' : '1',
          'payment_start_date' : '0',

          'payment_end_date' : '0',
        },
      )
          .timeout(Duration(seconds: 25));
      print('Signup response: ${response.body}');
      if (response.body.contains('Data Submitted')) {
        // fetchId
        GlobalVariables.signUpResponse = response.body;
        print('GlobalVariables.signUpResponse');
        res = true;
      } else {
        res = false;
        // res = errorResponseFromJson(response.body);
      }
      return res;
    } on TimeoutException catch (e) {
      return false;
    } on SocketException catch (e) {
      return false;
    } on Error catch (e) {
      print('Error : $e');
      return false;
    }
  }

  Future<dynamic> userLogin({required Map<String, dynamic> apiParams}) async {
    var res;
    var newRes;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http
          .post(Uri.parse('${AppUrls.userLogin}'),
        // body: jsonEncode(apiParams),
        body: {
          'email' : GlobalVariables.email,
          'password' : GlobalVariables.password,
        },
      )
          .timeout(Duration(seconds: 25));
      print('Login response: ${response.body}');
      if (response.body.contains('server_response')) {
        // fetchId
        GlobalVariables.loginResponse = response.body;
        newRes = loginModelFromJson(response.body);
        print('GlobalVariables.loginResponse '+ GlobalVariables.loginResponse);
        return newRes;
      } else {
        res = false;
        // res = errorResponseFromJson(response.body);
      }
      return res;
    } on TimeoutException catch (e) {
      return false;
    } on SocketException catch (e) {
      return false;
    } on Error catch (e) {
      print('Error : $e');
      return false;
    }
  }

  Future<dynamic> byProfession({required Map<String, dynamic> apiParams}) async {
    var res;
    var newRes;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http
          .post(Uri.parse('${AppUrls.byProfession}'),
        // body: jsonEncode(apiParams),
        body: {
          'gender' : prefs.getString('gender'),
          'profession' : GlobalVariables.valueChosen,
        },
      )
          .timeout(Duration(seconds: 25));
      print('by Profeession response: ${response.body}');
      if (response.body.contains('server_response')) {
        // fetchId
        GlobalVariables.byProfessionResponse = response.body;
        newRes = proposalListModelFromJson(response.body);
        print('GlobalVariables.byProfessionResponse '+ GlobalVariables.byProfessionResponse);
        return newRes;
      } else {
        res = false;
        // res = errorResponseFromJson(response.body);
      }
      return res;
    } on TimeoutException catch (e) {
      return false;
    } on SocketException catch (e) {
      return false;
    } on Error catch (e) {
      print('Error : $e');
      return false;
    }
  }

  Future<dynamic> byCaste({required Map<String, dynamic> apiParams}) async {
    var res;
    var newRes;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http
          .post(Uri.parse('${AppUrls.byCaste}'),
        // body: jsonEncode(apiParams),
        body: {
          'gender' : prefs.getString('gender'),
          'caste' : GlobalVariables.valueChosen,
        },
      )
          .timeout(Duration(seconds: 25));
      print('by caste response: ${response.body}');
      if (response.body.contains('server_response')) {
        // fetchId
        GlobalVariables.byCasteResponse = response.body;
        newRes = byCasteProposalsModelFromJson(response.body);
        print('GlobalVariables.byCasteResponse '+ GlobalVariables.byCasteResponse);
        return newRes;
      } else {
        res = false;
        // res = errorResponseFromJson(response.body);
      }
      return res;
    } on TimeoutException catch (e) {
      return false;
    } on SocketException catch (e) {
      return false;
    } on Error catch (e) {
      print('Error : $e');
      return false;
    }
  }


  Future<dynamic> getFeaturedProposals({required Map<String, dynamic> apiParams}) async {
    var res;
    var newRes;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http
          .post(Uri.parse('${AppUrls.getFeatured}'),
        // body: jsonEncode(apiParams),
        body: {
          'gender' : prefs.getString('gender'),
          'is_featured' : '1',
        },
      )
          .timeout(Duration(seconds: 25));
      print('is_featured response: ${response.body}');
      if (response.body.contains('server_response')) {
        // fetchId
        GlobalVariables.isFeaturedResponse = response.body;
        newRes = featuredModelFromJson(response.body);
        print('GlobalVariables.isFeaturedResponse '+ GlobalVariables.isFeaturedResponse);
        // GlobalVariables.featuredModel = newRes;
        return newRes;
      } else {
        res = false;
        // res = errorResponseFromJson(response.body);
      }
      return res;
    } on TimeoutException catch (e) {
      return false;
    } on SocketException catch (e) {
      return false;
    } on Error catch (e) {
      print('Error : $e');
      return false;
    }
  }

  Future<dynamic> proposalDetail({required Map<String, dynamic> apiParams}) async {
    var res;
    var newRes;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http
          .post(Uri.parse('${AppUrls.proposalDetail}'),
        // body: jsonEncode(apiParams),
        body: {
          'id' : GlobalVariables.idOfProposal,
        },
      )
          .timeout(Duration(seconds: 25));
      print('Proposal Detail response: ${response.body}');
      if (response.body.contains('server_response')) {
        // fetchId
        GlobalVariables.proposalDetail = response.body;
        newRes = proposalDetailModelFromJson(response.body);
        print('GlobalVariables.proposalDetail '+ GlobalVariables.proposalDetail);
        return newRes;
      } else {
        res = false;
        // res = errorResponseFromJson(response.body);
      }
      return res;
    } on TimeoutException catch (e) {
      return false;
    } on SocketException catch (e) {
      return false;
    } on Error catch (e) {
      print('Error : $e');
      return false;
    }
  }

  formattedDate(){
    DateTime dateTime = DateTime.now();
    return dateTime.toString();
  }
  // Future<dynamic> otpVerificationResponse(String otp, String phone) async {
  //   var res;
  //   int timeout = 40 ;
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${Constants.BASE_URL}/otpverification'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         "mobile_number": phone,
  //         "otp": otp
  //       }),
  //     ).timeout(Duration(seconds: timeout));
  //     // 1458
  //     print('OTP response: ${response.statusCode}');
  //     print('OTP response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       print(response.body.toString());
  //       res = otpVerificationResponseFromJson(response.body);
  //     } else{
  //       res = errorMessageFromJson(response.body);
  //     }
  //
  //     print("this is url ${Constants.BASE_URL}/otpverification");
  //     return res;
  //   } on TimeoutException catch (e) {
  //     return ('Slow Internet try again');
  //   } on SocketException catch (e) {
  //     return ('No internet');
  //   } on Error catch (e) {
  //     return ('$e');
  //   }
  // }
  // Future<dynamic> userLogin({required Map<String, dynamic> apiParams}) async {
  //   var res;
  //   int timeout = 40;
  //   try {
  //     final response = await http
  //         .post(
  //       Uri.parse('${AppUrls.BASE_URL}/signin'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(apiParams),
  //     )
  //         .timeout(Duration(seconds: timeout));
  //     // 1458
  //     print('LOGIN response: ${response.statusCode}');
  //     print('LOGIN response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       print(response.body.toString());
  //       res = loginResponseFromJson(response.body);
  //     } else{
  //       res = errorResponseFromJson(response.body);
  //     }
  //
  //     print("this is url ${AppUrls.BASE_URL}/signin");
  //     return res;
  //   } on TimeoutException catch (e) {
  //     print(e);
  //     return ('Slow Internet try again');
  //   } on SocketException catch (e) {
  //     print(e);
  //     return ('No internet');
  //   } on Error catch (e) {
  //     print(e);
  //     return ('$e');
  //   }
  // }
  // Future<dynamic> staffLogin({required Map<String, dynamic> apiParams}) async {
  //   var res;
  //   int timeout = 40;
  //   try {
  //     final response = await http
  //         .post(
  //       Uri.parse('${AppUrls.BASE_URL}/staffsignin'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(apiParams),
  //     )
  //         .timeout(Duration(seconds: timeout));
  //     // 1458
  //     print('staffsignin response: ${response.statusCode}');
  //     print('staffsignin response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       print(response.body.toString());
  //       res = staffLoginResFromJson(response.body);
  //     } else{
  //       res = errorResponseFromJson(response.body);
  //     }
  //
  //     print("this is url ${AppUrls.BASE_URL}/staffsignin");
  //     return res;
  //   } on TimeoutException catch (e) {
  //     print(e);
  //     return ('Slow Internet try again');
  //   } on SocketException catch (e) {
  //     print(e);
  //     return ('No internet');
  //   } on Error catch (e) {
  //     print(e);
  //     return ('$e');
  //   }
  // }
  // Future<dynamic> otpVerifyFirstTime({required Map<String, dynamic> apiParams}) async {
  //   var res;
  //   int timeout = 40 ;
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${AppUrls.BASE_URL}/otpverification'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(apiParams),
  //     ).timeout(Duration(seconds: timeout));
  //     // 1458
  //     print('otpverification response: ${response.statusCode}');
  //     print('otpverification response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       print(response.body.toString());
  //       res = otpVerificationResponseFromJson(response.body);
  //     } else{
  //       res = errorResponseFromJson(response.body);
  //     }
  //
  //     print("this is url ${AppUrls.BASE_URL}/otpverification");
  //     return res;
  //   } on TimeoutException catch (e) {
  //     print(e);
  //     return ('Slow Internet try again');
  //   } on SocketException catch (e) {
  //     print(e);
  //     return ('No internet');
  //   } on Error catch (e) {
  //     print(e);
  //     return ('$e');
  //   }
  // }
  // Future<dynamic> resendOtp({required Map<String, dynamic> apiParams}) async {
  //   var res;
  //   int timeout = 40 ;
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${AppUrls.BASE_URL}/resendotpmobile'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(apiParams),
  //     ).timeout(Duration(seconds: timeout));
  //     // 1458
  //     print('RESEND OTP response: ${response.statusCode}');
  //     print('RESEND OTP response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       print(response.body.toString());
  //       res = errorResponseFromJson(response.body);
  //     } else{
  //       res = errorResponseFromJson(response.body);
  //     }
  //
  //     print("this is url ${AppUrls.BASE_URL}/resendotpmobile");
  //     return res;
  //   } on TimeoutException catch (e) {
  //     print(e);
  //     return ('Slow Internet try again');
  //   } on SocketException catch (e) {
  //     print(e);
  //     return ('No internet');
  //   } on Error catch (e) {
  //     print(e);
  //     return ('$e');
  //   }
  // }
// Future<dynamic> forgotPassword(String phone) async {
//   var res;
//   int timeout = 40 ;
//   try {
//     final response = await http.post(
//       Uri.parse('${Constants.BASE_URL}/forgotpassword'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         "mobile_number": phone,
//       }),
//     ).timeout(Duration(seconds: timeout));
//     // 1458
//     print('FORGOT PASSWORD response: ${response.statusCode}');
//     print('FORGOT PASSWORD response: ${response.body}');
//     if (response.statusCode == 200) {
//       print(response.body.toString());
//       res = errorMessageFromJson(response.body);
//     } else{
//       print(response.body.toString());
//       res = errorMessageFromJson(response.body);
//     }
//
//     print("this is url ${Constants.BASE_URL}/forgotpassword");
//     return res;
//   } on TimeoutException catch (e) {
//     return ('Slow Internet try again');
//   } on SocketException catch (e) {
//     return ('No internet');
//   } on Error catch (e) {
//     return ('$e');
//   }
// }
}