
import 'package:get/get.dart';
import 'package:online_clothing_admin/categories/update_product.dart';

import '../authentication/view/login.dart';
import '../authentication/view/register.dart';
import '../categories/add_new_product.dart';
import '../categories/new_category.dart';
import '../main_page/all_categories.dart';
import '../main_page/all_featured.dart';
import '../main_page/main_page.dart';
import '../main_page/product_details.dart';
import '../views/splash.dart';
import '../views/widget/products_of_category.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;
 

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreen(),
    ),
    // ),GetPage(
    //   name: _Paths.SLIDER_SCREEN,
    //   page: () => SliderScreen(),
    // ),
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
      name: _Paths.PRODUCTS_DETAIL,
      page: () => ProductDetails(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS_OF_CATEGORY,
      page: () => ProductsOfCategory(),
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
      name: _Paths.REGISTER_NOW,
      page: () => Register(),
    ),
    GetPage(
      name: _Paths.ALL_FEATURED,
      page: () => AllFeatured(),
    ),
    GetPage(
      name: _Paths.ALL_CATEGORIES,
      page: () => AllCategories(),
    ),
    // GetPage(
    //   name: _Paths.UPDATE,
    //   page: () => UpdateProduct(),
    // ),
    // GetPage(
    //   name: _Paths.CART,
    //   page: () => CartScreen(),
    // ),
    // GetPage(
    //   name: _Paths.CHECKOUT_SCREEN,
    //   page: () => CheckoutScreen(),
    // ),
    // GetPage(
    //   name: _Paths.SUCCESS_SCREEN,
    //   page: () => SuccessScreen(),
    // ),
    // GetPage(
    //   name: _Paths.MY_ORDERS,
    //   page: () => MyOrders(),
    // ),
    // GetPage(
    //   name: _Paths.PRIVACY_POLICY,
    //   page: () => WebViewClass(),
    // ),
    // GetPage(
    //   name: _Paths.TERMS_CONDITIONS,
    //   page: () => WebViewClass(),
    // ),
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
