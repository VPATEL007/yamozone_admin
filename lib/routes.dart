import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamazone/views/apps/CRM/contacts_page.dart';
import 'package:yamazone/views/apps/CRM/opportunities.dart';
import 'package:yamazone/views/apps/calender.dart';
import 'package:yamazone/views/apps/driver_monitoring/driver_profile_page.dart';
import 'package:yamazone/views/apps/driver_monitoring/driver_task_detail_page.dart';
import 'package:yamazone/views/apps/kyc/kyc_approval_page.dart';
import 'package:yamazone/views/apps/contacts/edit_profile.dart';
import 'package:yamazone/views/apps/contacts/member_list.dart';
import 'package:yamazone/views/apps/contacts/profile.dart';
import 'package:yamazone/views/apps/ecommerce/add_product.dart';
import 'package:yamazone/views/apps/listing_moderation/listing_detail_view.dart';
import 'package:yamazone/views/apps/listing_moderation/listing_reported_detail_view.dart';
import 'package:yamazone/views/apps/orders_escrow/order_detail_page.dart';
import 'package:yamazone/views/apps/suggestions/suggestions_page.dart';
import 'package:yamazone/views/apps/system_setting/audit_log_detail.dart';
import 'package:yamazone/views/apps/user_management/user_management_page.dart';
import 'package:yamazone/views/apps/kyc/kyc_review_page.dart';
import 'package:yamazone/views/apps/user_management/user_detail.dart';
import 'package:yamazone/views/apps/ecommerce/products.dart';
import 'package:yamazone/views/apps/file/file_manager.dart';
import 'package:yamazone/views/apps/file/file_uploader.dart';
import 'package:yamazone/views/apps/driver_monitoring/driver_monitoring_page.dart';
import 'package:yamazone/views/apps/kanban_page.dart';
import 'package:yamazone/views/apps/system_setting/system_setting_page.dart';
import 'package:yamazone/views/apps/projects/create_project.dart';
import 'package:yamazone/views/apps/projects/project_detail.dart';
import 'package:yamazone/views/apps/projects/project_list.dart';
import 'package:yamazone/views/apps/dispute_center/dispute_center_page.dart';
import 'package:yamazone/views/apps/withdrawal/withdrawal_view.dart';
import 'package:yamazone/views/auth/forgot_password.dart';
import 'package:yamazone/views/auth/forgot_password_2.dart';
import 'package:yamazone/views/auth/locked.dart';
import 'package:yamazone/views/auth/login.dart';
import 'package:yamazone/views/auth/login_2.dart';
import 'package:yamazone/views/auth/register.dart';
import 'package:yamazone/views/auth/register_2.dart';
import 'package:yamazone/views/auth/reset_password.dart';
import 'package:yamazone/views/auth/reset_password_2.dart';
import 'package:yamazone/views/forms/basic_page.dart';
import 'package:yamazone/views/forms/form_mask.dart';
import 'package:yamazone/views/forms/quill_editor.dart';
import 'package:yamazone/views/forms/validation.dart';
import 'package:yamazone/views/forms/wizard.dart';
import 'package:yamazone/views/other/basic_table.dart';
import 'package:yamazone/views/other/fl_chart_screen.dart';
import 'package:yamazone/views/other/google_map.dart';
import 'package:yamazone/views/other/sfmap_page.dart';
import 'package:yamazone/views/other/synsfusion_chart.dart';
import 'package:yamazone/views/apps/system_setting/audit_logs.dart';
import 'package:yamazone/views/ui/buttons_page.dart';
import 'package:yamazone/views/ui/cards_page.dart';
import 'package:yamazone/views/ui/carousels.dart';
import 'package:yamazone/views/ui/dialogs.dart';
import 'package:yamazone/views/ui/drag_drop.dart';
import 'package:yamazone/views/ui/notifications.dart';
import 'package:yamazone/views/ui/reviews_page.dart';
import 'package:yamazone/views/ui/tabs_page.dart';

import 'helpers/services/auth_services.dart';
import 'views/auth/locked_2.dart';
import 'views/dashboard.dart';
import 'views/error_pages/coming_soon_page.dart';
import 'views/error_pages/error_404.dart';
import 'views/error_pages/error_500.dart';
import 'views/error_pages/maintenance_page.dart';
import 'views/extra_pages/faqs_page.dart';
import 'views/extra_pages/pricing.dart';
import 'views/apps/orders_escrow/orders_escrow_page.dart';
import 'views/apps/system_setting/notifications_broadcasr_page.dart';
import 'views/apps/listing_moderation/listing_moderation_view.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn
        ? null
        : const RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  var routes = [
    GetPage(
      name: '/',
      page: () => const DashboardScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(name: '/faqs', page: () => const FaqsPage()),

    GetPage(
      name: '/pricing',
      page: () => const Pricing(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/audit-logs',
      page: () => const AuditLogsScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dashboard',
      page: () => const DashboardScreen(),
      middlewares: [AuthMiddleware()],
    ),

    ///--------------- Ecommerce ---------------///
    GetPage(
      name: '/apps/ecommerce/products',
      page: () => const ProductPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/suggestions',
      page: () => const SuggestionsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/ecommerce/add_product',
      page: () => const AddProduct(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/user/userdetail',
      page: () => const UserDetailsScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/user-management',
      page: () => const UserManagementPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/kyc-review',
      page: () => const KycReviewPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/orders',
      page: () => const OrdersEscrowScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/orders/detail',
      page: () => const OrderDetailPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Ntf ----------------///
    GetPage(
      name: '/listing-moderation',
      page: () => const ListingModerationPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/listing-detail',
      page: () => const ListingDetailView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/reported/listing-detail',
      page: () => const ReportedListingReviewScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/calender',
      page: () => const Calender(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/dispute-center',
      page: () => const DisputeCenterPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/driver-monitoring',
      page: () => const DriverMonitoringScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/driver/profile',
      page: () => const DriverProfileDetailPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/driver/taskdetail',
      page: () => const DriverTaskDetailPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/setting',
      page: () => const SystemSettingsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/audit/detail',
      page: () => const AuditLogDetailScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/withdrawal',
      page: () => const WithdrawalRequestsPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- KanBan ----------------///
    GetPage(
      name: '/kanban',
      page: () => const KanBanPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Projects ----------------///
    GetPage(
      name: '/projects/project-list',
      page: () => const ProjectListPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/projects/project-detail',
      page: () => const ProjectDetail(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Contacts ----------------///
    GetPage(
      name: '/contacts/profile',
      page: () => const ProfilePage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/contacts/members',
      page: () => const MemberList(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/contacts/edit-profile',
      page: () => const EditProfile(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- CRM ----------------///
    GetPage(
      name: '/crm/contacts',
      page: () => const ContactsPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/crm/opportunities',
      page: () => const OpportunitiesPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Auth ----------------///
    GetPage(name: '/auth/login', page: () => const AdminLoginPage()),
    GetPage(name: '/auth/login1', page: () => const Login2()),
    GetPage(name: '/auth/forgot_password', page: () => const ForgotPassword()),
    GetPage(
      name: '/auth/forgot_password1',
      page: () => const ForgotPassword2(),
    ),
    GetPage(name: '/auth/register', page: () => const Register()),
    GetPage(name: '/auth/register1', page: () => const Register2()),
    GetPage(name: '/auth/reset_password', page: () => const ResetPassword()),
    GetPage(name: '/auth/reset_password1', page: () => const ResetPassword2()),
    GetPage(
      name: '/auth/locked',
      page: () => const LockedPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/auth/locked1',
      page: () => const LockedPage2(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- UI ----------------///
    GetPage(
      name: '/ui/buttons',
      page: () => const ButtonsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/cards',
      page: () => const CardsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/tabs',
      page: () => const TabsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/dialogs',
      page: () => const Dialogs(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/carousels',
      page: () => const Carousels(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/drag-drop',
      page: () => const DragDropPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/notification',
      page: () => const Notifications(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/reviews',
      page: () => const ReviewsPage(),
      middlewares: [AuthMiddleware()],
    ),
    // GetPage(
    //     name: '/ui/discover',
    //     page: () => const DiscoverJobs(),
    //     middlewares: [AuthMiddleware()]),
    GetPage(
      name: '/notification',
      page: () => const NotificationsPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Error ----------------///
    GetPage(
      name: '/coming-soon',
      page: () => const ComingSoonPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/error-404',
      page: () => const Error404(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/error-500',
      page: () => const Error500(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/maintenance',
      page: () => const MaintenancePage(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Chat ----------------///
    GetPage(
      name: '/kyc-approval',
      page: () => const KYCApprovalsScreen(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Form ----------------///
    GetPage(
      name: '/form/basic',
      page: () => const BasicPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/form/validation',
      page: () => const ValidationPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/form/quill-editor',
      page: () => const QuillEditor(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/form/form-mask',
      page: () => const FormMaskPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/form/wizard',
      page: () => const Wizard(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Other ----------------///
    GetPage(
      name: '/other/basic_tables',
      page: () => const BasicTable(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/other/syncfusion_charts',
      page: () => const SyncFusionChart(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/other/fl_chart',
      page: () => const FlChartScreen(),
      middlewares: [AuthMiddleware()],
    ),

    ///---------------- Maps ----------------///
    GetPage(
      name: '/maps/sf-maps',
      page: () => const SfMapPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/maps/google-maps',
      page: () => const GoogleMapPage(),
      middlewares: [AuthMiddleware()],
    ),
  ];
  return routes
      .map(
        (e) => GetPage(
          name: e.name,
          page: e.page,
          middlewares: e.middlewares,
          transition: Transition.noTransition,
        ),
      )
      .toList();
}
