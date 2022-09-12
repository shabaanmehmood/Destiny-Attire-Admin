import 'package:Rishta_Nagar/app/modules/categories/add_new_product.dart';
import 'package:Rishta_Nagar/app/modules/categories/new_category.dart';
import 'package:get/get.dart';

import '../modules/authentication/view/basic_information.dart';
import '../modules/authentication/view/family_information.dart';
import '../modules/authentication/view/login.dart';
import '../modules/authentication/view/required_proposal.dart';
import '../modules/filter/filter_screen.dart';
import '../modules/main_page/edit_profile.dart';
import '../modules/main_page/main_page.dart';
import '../modules/main_page/main_page_all_castes.dart';
import '../modules/matrimonial/view/slider_screen.dart';
import '../modules/matrimonial/view/splash.dart';
import '../modules/policies/webview.dart';
import '../modules/proposals/proposal_detail.dart';
import '../modules/proposals/proposals_list.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;
 

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreen(),
    ),GetPage(
      name: _Paths.SLIDER_SCREEN,
      page: () => SliderScreen(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => LoginScreen(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_SCREEN,
      page: () => MainScreen(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_CATEGORY,
      page: () => NewCategory(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PRODUCT,
      page: () => NewProduct(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BASIC_INFORMATION,
      page: () => BasicInformation(),
    ),
    GetPage(
      name: _Paths.FAMILY_INFORMATION,
      page: () => FamilyInformation(),
    ),
    GetPage(
      name: _Paths.REQUIRED_PROPOSAL,
      page: () => RequiredProposal(),
    ),
    GetPage(
      name: _Paths.ALL_CASTES_MAIN_PAGE,
      page: () => AllCastesMainPage(),
    ),
    GetPage(
      name: _Paths.PROPOSALS_LIST,
      page: () => ProposalsList(),
    ),
    GetPage(
      name: _Paths.PROPOSALS_DETAIL,
      page: () => ProposalDetails(),
    ),
    GetPage(
      name: _Paths.FILTER_SCREEN,
      page: () => FilterScreen(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfile(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => WebViewClass(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITIONS,
      page: () => WebViewClass(),
    ),
    // GetPage(
    //   name: _Paths.CREATE_ACCOUNT,
    //   page: () => CreateAccount(),
    // ),
    // GetPage(
    //   name: _Paths.CONNECT_WITH,
    //   page: () => ConnectWith(),
    // ),
    // GetPage(
    //   name: _Paths.INTRO_SCREEN,
    //   page: () => IntroScreen(),
    // ),
    // GetPage(
    //   name: _Paths.LOGIN,
    //   page: () => LoginView(),
    //   binding: LoginBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SPLASH_SCREEN,
    //   page: () => SplashScreen(),
    //   binding: SplashScreenBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SELECTION_SCREEN,
    //   page: () => SelectionScreen(),
    //   binding: SplashScreenBinding()
    // ),
    // GetPage(
    //   name: _Paths.ADMIN_LOGIN,
    //   page: () => LoginView(),
    //   binding: LoginBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MEMBER_LOGIN,
    //   page: () => MemberLogin(),
    //   binding: SplashScreenBinding()
    // ),
    // GetPage(
    //   name: _Paths.ADMIN_DASHBOARD,
    //   page: () => AdminDashboard(),
    //   binding: AdminBinding()
    // ),
    // GetPage(
    //   name: _Paths.CALENDER_TASK_LIST,
    //   page: () => AdminCalendarTaskListView(),
    //   binding: AdminBinding()
    //
    // ),
    // GetPage(
    //   name: _Paths.PLANS_LIST,
    //   page: () => PlansList(),
    //   binding: SharedBinding(),
    //
    // ),
    // GetPage(
    //   name: _Paths.ADD_PLAN,
    //   page: () => AddPlan(),
    //   binding: SharedBinding(),
    //
    //
    // ),
    // GetPage(
    //   name: _Paths.PLAN_DETAIL,
    //   page: () => PlanDetail(),
    //   binding: PlanDetailBinding()
    // ),
    // GetPage(
    //   name: _Paths.EDIT_PLAN,
    //   page: () => EditPlanDetail(),
    //   binding: SharedBinding(),
    // ),
    // GetPage(
    //   name: _Paths.INSTRUCTOR_LIST,
    //   page: () => InstructorListView(),
    //   binding: SharedBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MEMBER_LIST,
    //   page: () => MemberListView(),
    //   binding: SharedBinding(),
    // ),
    // GetPage(
    //   name: _Paths.INSTRUCTOR_PROFILE,
    //   page: () => InstructorProfile(),
    //   binding: InstructorBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MY_INSTRUCTOR_PROFILE,
    //   page: () => MyInstructorProfile(),
    //   binding: MyInstructorProfileBinding(),
    // ),
    // GetPage(
    //   name: _Paths.INSTRUCTOR_PROFILE_EDIT,
    //   page: () => InstructorProfileEdit(),
    //   binding: InstructorBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ADMIN_INSTRUCTOR_PROFILE_EDIT,
    //   page: () => AdminInstructorProfileEdit(),
    //   binding: InstructorBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ADD_INSTRUCTOR,
    //   page: () => AddInstructor(),
    //   binding: InstructorBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MEMBER_PROFILE,
    //   page: () => MemberProfile(),
    //   binding: MemberBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MY_MEMBER_PROFILE,
    //   page: () => MyMemberProfile(),
    //   binding: MemberProfileBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MEMBER_PROFILE_EDIT,
    //   page: () => MemberEditProfile(),
    //   binding: MemberBinding(),
    //
    // ),
    // GetPage(
    //   name: _Paths.MY_MEMBER_PROFILE_EDIT,
    //   page: () => MyMemberEditProfile(),
    //   binding: EditMemberProfileBinding(),
    //
    // ),
    // GetPage(
    //   name: _Paths.ADD_MEMBER,
    //   page: () => AddMember(),
    //   binding: MemberBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ADMIN_PROFILE,
    //   page: () => AdminProfile(),
    //     binding: AdminEditViewBinding()
    // ),
    // GetPage(
    //   name: _Paths.ADMIN_PROFILE_EDIT,
    //   page: () => AdminEditProfile(),
    //     binding: AdminEditViewBinding()
    // ),
    // GetPage(
    //   name: _Paths.ADD_ADMIN,
    //   page: () => AdminSignUp(),
    //   binding: AdminSignUpBinding()
    // ),
    // GetPage(
    //   name: _Paths.WORKOUT_DETAIL,
    //   page: () => WorkoutDetail(),
    //     binding: SharedBinding()
    // ),
    // GetPage(
    //     name: _Paths.WORKOUT_ADD,
    //     page: () => WorkoutADD(),
    //     binding: SharedBinding()
    // ),
    // GetPage(
    //   name: _Paths.WORKOUT_LIST,
    //   page: () => WorkoutList(),
    //   binding: SharedBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MEMBER_DASHBOARD,
    //   page: () => MemberDashboard(),
    //   binding: MemberDashboardBinding()
    // ),
    // // GetPage(
    // //   name: _Paths.MEMBER_PLAN_DETAIL,
    // //   page: () => MemberPlanDetail(),
    // //   binding: MemberDashboardBinding()
    // // ),
    // GetPage(
    //   name: _Paths.INSTRUCTOR_DASHBOARD,
    //   page: () => InstructorDashboard(),
    //   binding: InstructorBinding()
    // ),
    // GetPage(
    //   name: _Paths.SELECT_PLANS,
    //   page: () => SelectPlans(),
    // ),
    // GetPage(
    //   name: _Paths.SELECT_WORKOUTS,
    //   page: () => SelectWorkout(),
    //   binding: SharedBinding()
    // ),
    // GetPage(
    //   name: _Paths.SELECT_MEMBERS,
    //   page: () => SelectMembers(),
    // ),
    // GetPage(
    //   name: _Paths.SELECT_INSTRUCTORS,
    //   page: () => SelectInstructors(),
    // ),
    // GetPage(
    //   name: _Paths.SELECT_INSTRUCTORS_ON_UPDATE,
    //   page: () => SelectInstructorsOnUpdate(),
    // ),
    // GetPage(
    //   name: _Paths.SELECT_MEMBERS_ON_UPDATE,
    //   page: () => SelectMembersOnUpdate(),
    // ),
    // GetPage(
    //   name: _Paths.SELECT_WORKOUTS_ON_UPDATE,
    //   page: () => SelectWorkoutOnUpdate(),
    // ),
    // GetPage(
    //   name: _Paths.INSTRUCTOR_TASK_LIST,
    //   page: () => InstructorTaskListView(),
    // ),
    // GetPage(
    //   name: _Paths.INSTRUCTOR_PLANS_LIST,
    //   page: () => InstructorPlans(),
    // ),
    // GetPage(
    //   name: _Paths.INSTRUCTOR_MEMBERS_LIST,
    //   page: () => InstructorMemberListView(),
    // ),
  ];
}
