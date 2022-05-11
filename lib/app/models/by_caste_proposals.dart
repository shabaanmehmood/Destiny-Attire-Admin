// To parse this JSON data, do
//
//     final byCasteProposalsModel = byCasteProposalsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ByCasteProposalsModel byCasteProposalsModelFromJson(String str) => ByCasteProposalsModel.fromJson(json.decode(str));

String byCasteProposalsModelToJson(ByCasteProposalsModel data) => json.encode(data.toJson());

class ByCasteProposalsModel {
  ByCasteProposalsModel({
    required this.serverResponse,
  });

  List<ServerResponse> serverResponse;

  factory ByCasteProposalsModel.fromJson(Map<String, dynamic> json) => ByCasteProposalsModel(
    serverResponse: List<ServerResponse>.from(json["server_response"].map((x) => ServerResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "server_response": List<dynamic>.from(serverResponse.map((x) => x.toJson())),
  };
}

class ServerResponse {
  ServerResponse({
    required this.basicDetails,
    required this.familyDetails,
    required this.demands,
    required this.others,
  });

  BasicDetails basicDetails;
  FamilyDetails familyDetails;
  Demands demands;
  Others others;

  factory ServerResponse.fromJson(Map<String, dynamic> json) => ServerResponse(
    basicDetails: BasicDetails.fromJson(json["basic_details"]),
    familyDetails: FamilyDetails.fromJson(json["family_details"]),
    demands: Demands.fromJson(json["demands"]),
    others: Others.fromJson(json["others"]),
  );

  Map<String, dynamic> toJson() => {
    "basic_details": basicDetails.toJson(),
    "family_details": familyDetails.toJson(),
    "demands": demands.toJson(),
    "others": others.toJson(),
  };
}

class BasicDetails {
  BasicDetails({
    required this.id,
    required this.token,
    required this.profileCreatedBy,
    required this.maritalStatus,
    required this.reasonForSecondMarriage,
    required this.marriagePeriod,
    required this.separationPeriod,
    required this.kids,
    required this.kidsOwnership,
    required this.gender,
    required this.dob,
    required this.city,
    required this.area,
    required this.address,
    required this.height,
    required this.email,
    required this.password,
    required this.primaryPhone,
    required this.secondaryPhone,
    required this.motherTongue,
    required this.religion,
    required this.sect,
    required this.caste,
    required this.subcaste,
    required this.profession,
    required this.qualification,
    required this.occupation,
    required this.monthlyIncome,
  });

  String id;
  String token;
  String profileCreatedBy;
  String maritalStatus;
  String reasonForSecondMarriage;
  String marriagePeriod;
  String separationPeriod;
  String kids;
  String kidsOwnership;
  String gender;
  String dob;
  String city;
  String area;
  String address;
  String height;
  String email;
  String password;
  String primaryPhone;
  String secondaryPhone;
  String motherTongue;
  String religion;
  String sect;
  String caste;
  String subcaste;
  String profession;
  String qualification;
  String occupation;
  String monthlyIncome;

  factory BasicDetails.fromJson(Map<String, dynamic> json) => BasicDetails(
    id: json["id"],
    token: json["token"],
    profileCreatedBy: json["profile_created_by"],
    maritalStatus: json["marital_status"],
    reasonForSecondMarriage: json["reason_for_second_marriage"],
    marriagePeriod: json["marriage_period"],
    separationPeriod: json["separation_period"],
    kids: json["kids"],
    kidsOwnership: json["kids_ownership"],
    gender: json["gender"],
    dob: json["dob"],
    city: json["city"],
    area: json["area"],
    address: json["address"],
    height: json["height"],
    email: json["email"],
    password: json["password"],
    primaryPhone: json["primary_phone"],
    secondaryPhone: json["secondary_phone"],
    motherTongue: json["mother_tongue"],
    religion: json["religion"],
    sect: json["sect"],
    caste: json["caste"],
    subcaste: json["subcaste"],
    profession: json["profession"],
    qualification: json["qualification"],
    occupation: json["occupation"],
    monthlyIncome: json["monthly_income"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "profile_created_by": profileCreatedBy,
    "marital_status": maritalStatus,
    "reason_for_second_marriage": reasonForSecondMarriage,
    "marriage_period": marriagePeriod,
    "separation_period": separationPeriod,
    "kids": kids,
    "kids_ownership": kidsOwnership,
    "gender": gender,
    "dob": dob,
    "city": city,
    "area": area,
    "address": address,
    "height": height,
    "email": email,
    "password": password,
    "primary_phone": primaryPhone,
    "secondary_phone": secondaryPhone,
    "mother_tongue": motherTongue,
    "religion": religion,
    "sect": sect,
    "caste": caste,
    "subcaste": subcaste,
    "profession": profession,
    "qualification": qualification,
    "occupation": occupation,
    "monthly_income": monthlyIncome,
  };
}

class Demands {
  Demands({
    required this.professionDemand,
    required this.casteDemand,
    required this.ageLimit,
    required this.heightDemand,
    required this.housingDemandLocation,
    required this.housingDemandPossession,
    required this.housingDemandIn,
    required this.housingDemandArea,
    required this.cityDemand,
    required this.additionalDemand,
  });

  String professionDemand;
  String casteDemand;
  String ageLimit;
  String heightDemand;
  String housingDemandLocation;
  String housingDemandPossession;
  String housingDemandIn;
  String housingDemandArea;
  String cityDemand;
  String additionalDemand;

  factory Demands.fromJson(Map<String, dynamic> json) => Demands(
    professionDemand: json["profession_demand"],
    casteDemand: json["caste_demand"],
    ageLimit: json["age_limit"],
    heightDemand: json["height_demand"],
    housingDemandLocation: json["housing_demand_location"],
    housingDemandPossession: json["housing_demand_possession"],
    housingDemandIn: json["housing_demand_in"],
    housingDemandArea: json["housing_demand_area"],
    cityDemand: json["city_demand"],
    additionalDemand: json["additional_demand"],
  );

  Map<String, dynamic> toJson() => {
    "profession_demand": professionDemand,
    "caste_demand": casteDemand,
    "age_limit": ageLimit,
    "height_demand": heightDemand,
    "housing_demand_location": housingDemandLocation,
    "housing_demand_possession": housingDemandPossession,
    "housing_demand_in": housingDemandIn,
    "housing_demand_area": housingDemandArea,
    "city_demand": cityDemand,
    "additional_demand": additionalDemand,
  };
}

class FamilyDetails {
  FamilyDetails({
    required this.motherAlive,
    required this.fatherAlive,
    required this.siblings,
    required this.marriedBrothers,
    required this.marriedSisters,
    required this.unmarriedBrothers,
    required this.unmarriedSisters,
    required this.fathersOccupation,
    required this.houseIn,
    required this.possession,
    required this.houseArea,
    required this.additionalInfo,
  });

  String motherAlive;
  String fatherAlive;
  String siblings;
  String marriedBrothers;
  String marriedSisters;
  String unmarriedBrothers;
  String unmarriedSisters;
  String fathersOccupation;
  String houseIn;
  String possession;
  String houseArea;
  String additionalInfo;

  factory FamilyDetails.fromJson(Map<String, dynamic> json) => FamilyDetails(
    motherAlive: json["mother_alive"],
    fatherAlive: json["father_alive"],
    siblings: json["siblings"],
    marriedBrothers: json["married_brothers"],
    marriedSisters: json["married_sisters"],
    unmarriedBrothers: json["unmarried_brothers"],
    unmarriedSisters: json["unmarried_sisters"],
    fathersOccupation: json["fathers_occupation"],
    houseIn: json["house_in"],
    possession: json["possession"],
    houseArea: json["house_area"],
    additionalInfo: json["additional_info"],
  );

  Map<String, dynamic> toJson() => {
    "mother_alive": motherAlive,
    "father_alive": fatherAlive,
    "siblings": siblings,
    "married_brothers": marriedBrothers,
    "married_sisters": marriedSisters,
    "unmarried_brothers": unmarriedBrothers,
    "unmarried_sisters": unmarriedSisters,
    "fathers_occupation": fathersOccupation,
    "house_in": houseIn,
    "possession": possession,
    "house_area": houseArea,
    "additional_info": additionalInfo,
  };
}

class Others {
  Others({
    required this.accountCreatedAt,
    required this.isFeatured,
    required this.featuredStartDate,
    required this.featuredEndDate,
    required this.profileViewsHis,
    required this.profileViewsOthers,
    required this.isPaidUser,
    required this.packageType,
    required this.favourites,
    required this.activateCallCheck,
    required this.numberOfCallViews,
    required this.involveInIssue,
    required this.issueDetail,
    required this.isActiveAccount,
    required this.paymentStartDate,
    required this.paymentEndDate,
    required this.name,
  });

  DateTime accountCreatedAt;
  String isFeatured;
  String featuredStartDate;
  String featuredEndDate;
  String profileViewsHis;
  String profileViewsOthers;
  String isPaidUser;
  String packageType;
  String favourites;
  String activateCallCheck;
  String numberOfCallViews;
  String involveInIssue;
  String issueDetail;
  String isActiveAccount;
  String paymentStartDate;
  String paymentEndDate;
  String name;

  factory Others.fromJson(Map<String, dynamic> json) => Others(
    accountCreatedAt: DateTime.parse(json["account_created_at"]),
    isFeatured: json["is_featured"],
    featuredStartDate: json["featured_start_date"],
    featuredEndDate: json["featured_end_date"],
    profileViewsHis: json["profile_views_his"],
    profileViewsOthers: json["profile_views_others"],
    isPaidUser: json["is_paid_user"],
    packageType: json["package_type"],
    favourites: json["favourites"],
    activateCallCheck: json["activate_call_check"],
    numberOfCallViews: json["number_of_call_views"],
    involveInIssue: json["involve_in_issue"],
    issueDetail: json["issue_detail"],
    isActiveAccount: json["is_active_account"],
    paymentStartDate: json["payment_start_date"],
    paymentEndDate: json["payment_end_date"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "account_created_at": accountCreatedAt.toIso8601String(),
    "is_featured": isFeatured,
    "featured_start_date": featuredStartDate,
    "featured_end_date": featuredEndDate,
    "profile_views_his": profileViewsHis,
    "profile_views_others": profileViewsOthers,
    "is_paid_user": isPaidUser,
    "package_type": packageType,
    "favourites": favourites,
    "activate_call_check": activateCallCheck,
    "number_of_call_views": numberOfCallViews,
    "involve_in_issue": involveInIssue,
    "issue_detail": issueDetail,
    "is_active_account": isActiveAccount,
    "payment_start_date": paymentStartDate,
    "payment_end_date": paymentEndDate,
    "name": name,
  };
}
