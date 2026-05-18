import 'package:flutter/material.dart';
import 'package:flutter_pat_application/features/invoice/presentation/screens/invoice_screen.dart';
import 'package:flutter_pat_application/features/payment_history/presentation/screens/payment_history_screen.dart';
import 'package:flutter_pat_application/features/receipt_tax_invoice/presentation/screens/receipt_tax_invoice_screen.dart';
import 'package:flutter_pat_application/features/receipt_tax_invoice/presentation/screens/receipt_tax_invoice_detail_screen.dart';
import 'package:flutter_pat_application/features/receipt_tax_invoice/presentation/screens/pdf_viewer_screen.dart';
import 'package:flutter_pat_application/features/ีีusageHistory/presentation/screens/usageHistory_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_pat_application/core/utils/navigator_key.dart';

import 'package:flutter_pat_application/features/auth/presentation/screens/login/login_screen.dart';
import 'package:flutter_pat_application/features/auth/presentation/screens/loginmain/login_main_screen.dart';
import 'package:flutter_pat_application/features/auth/presentation/screens/register/register_screen.dart';
import 'package:flutter_pat_application/features/appointment/domain/entities/Appointment_entity.dart';
import 'package:flutter_pat_application/features/appointment/presentation/screens/appointment_list_selete_screen.dart';
import 'package:flutter_pat_application/features/appointment/presentation/screens/appointment_reserve_screen.dart';
import 'package:flutter_pat_application/features/booking_confrim_queue/presentation/screens/booking_confirm_queue_screen.dart';
import 'package:flutter_pat_application/features/checkAppointments/presentation/screens/check_appointments_screen.dart';
import 'package:flutter_pat_application/features/communication/presentation/screens/communication_screen.dart';
import 'package:flutter_pat_application/features/attachFileDocuments/presentation/screens/attach_file_documents_screen.dart';
import 'package:flutter_pat_application/features/otp/presentation/screen/confirm_otp_screen.dart';
import 'package:flutter_pat_application/features/pin/presentation/confirm_pin_screen.dart';
import 'package:flutter_pat_application/features/pin/presentation/create_pin_screen.dart';
import 'package:flutter_pat_application/router/extras/confirm_otp_extra.dart';
import 'package:flutter_pat_application/router/extras/confirm_pin_extra.dart';
import 'package:flutter_pat_application/router/extras/create_pin_extra.dart';
import 'package:flutter_pat_application/features/contract/presentation/screens/contract_list_screen.dart';
import 'package:flutter_pat_application/features/contract/presentation/screens/create_contract_screen.dart';
import 'package:flutter_pat_application/features/contract/presentation/screens/scan_contract_screen.dart';
import 'package:flutter_pat_application/features/equipment/presentation/screens/equipmentDetail/equipmentDetailScreen.dart';
import 'package:flutter_pat_application/features/equipment/presentation/screens/equipmentList/equipmentListScreen.dart';
import 'package:flutter_pat_application/features/home/presentation/layout/bottomnavpage/navigationBarCustomScreen.dart';
import 'package:flutter_pat_application/features/home/presentation/layout/bottomnavpage/navigationBarScreen.dart';
import 'package:flutter_pat_application/features/home/presentation/screens/mainPage/main_screen.dart';
import 'package:flutter_pat_application/features/notifications/presentation/screens/notificationsPage/notifications_screen.dart';
import 'package:flutter_pat_application/features/payment/presentation/screens/payment_screen.dart';
import 'package:flutter_pat_application/features/payment_card/presentation/screens/payment_card_screen.dart';
import 'package:flutter_pat_application/features/property/presentation/screens/propertyListRegistrationDetails/property_list_registration_details_screen.dart';
import '../features/appointment/data/models/appointment_reserve_request_model.dart';
import '../features/auth/data/models/otp_model.dart';
import 'extras/payment_extra.dart';

class AppRouter {
  // Route Names (เธชเธณเธซเธฃเธฑเธเนเธเนเธญเนเธฒเธเธญเธดเธเนเธ GoRouter)
  static const String loginMain = 'loginMain';
  static const String login = 'login';
  static const String register = 'register';
  static const String mainPageScreen = 'mainPageScreen';
  static const String navigationBar = 'navigationBar';
  static const String navigationBarCustoms = 'navigationBarCustoms';
  static const String equipmentList = 'equipmentList';
  static const String equipmentDetail = 'equipmentDetail';
  static const String propertyListRegistrationDetails =
      'propertyListRegistrationDetails';
  static const String notifications = 'notifications';
  static const String appointmentRenewal = 'appointmentRenewal';
  static const String appointmentReserve = 'appointmentReserve';
  static const String appointmentConfirm = 'appointmentConfirm';
  // static const String appointmentConfirmBooking = 'appointmentConfirmBooking';
  static const String attachFileDocuments = 'attachFileDocuments';
  static const String checkAppointments = 'checkAppointments';
  static const String invoice = 'invoice';
  static const String communication = 'communication';
  static const String paymentHistory = 'paymentHistory';
  static const String contractList = 'contractList';
  static const String createContract = 'createContract';
  static const String scanContract = 'scanContract';
  static const String paymentCard = 'paymentCard';
  static const String confirmOtp = 'confirmOtp';
  static const String createPin = 'createPin';
  static const String confirmPin = 'confirmPin';
  static const String payment = 'payment';
  static const String receiptTaxInvoice = 'receiptTaxInvoice';
  static const String receiptTaxInvoiceDetail = 'receiptTaxInvoiceDetail';
  static const String pdfViewer = 'pdfViewer';
  static const String usageHistory = 'usageHistory';

  // GoRouter Instance
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/loginMain',
    debugLogDiagnostics: true,
    routes: [
      // --- Auth Routes ---
      GoRoute(
        path: '/loginMain',
        name: loginMain,
        builder: (context, state) => const LoginMainScreen(),
      ),
      GoRoute(
        path: '/login',
        name: login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/confirmOtp',
        name: confirmOtp,
        builder: (context, state) {
          final extra = state.extra as ConfirmOtpExtra?;
          return ConfirmOtpScreen(
            empId: extra?.empId ?? '',
            otpData: extra?.otpData,
          );
        },
      ),
      GoRoute(
        path: '/createPin',
        name: createPin,
        builder: (context, state) {
          final extra = state.extra as CreatePinExtra?;
          return CreatePinScreen(empId: extra?.empId ?? '');
        },
      ),
      GoRoute(
        path: '/confirmPin',
        name: confirmPin,
        builder: (context, state) {
          final extra = state.extra as ConfirmPinExtra?;
          return ConfirmPinScreen(
            empId: extra?.empId ?? '',
            pin: extra?.pin ?? '',
            otpDataModel: extra?.otpDataModel ?? ResponseRequestOTPDataModel(),
          );
        },
      ),

      // --- Home Routes ---
      GoRoute(
        path: '/main',
        name: mainPageScreen,
        builder: (context, state) => MainPageScreen(),
      ),
      GoRoute(
        path: '/navigationBar',
        name: navigationBar,
        builder: (context, state) => NavigationBarScreen(),
      ),
      GoRoute(
        path: '/navigationBarCustoms',
        name: navigationBarCustoms,
        builder: (context, state) => NavigationBarCustomScreen(),
      ),

      // --- Equipment Routes ---
      GoRoute(
        path: '/equipment',
        name: equipmentList,
        builder: (context, state) => EquipmentListScreen(),
        routes: [
          GoRoute(
            path: 'detail',
            name: equipmentDetail,
            builder: (context, state) => EquipmentDetailScreen(),
          ),
        ],
      ),

      // --- Property Routes ---
      GoRoute(
        path: '/property',
        name: propertyListRegistrationDetails,
        builder: (context, state) => PropertyListRegistrationDetailsScreen(),
      ),

      // --- Notifications ---
      GoRoute(
        path: '/notifications',
        name: notifications,
        builder: (context, state) => NotificationsScreen(),
      ),

      // --- Communication ---
      GoRoute(
        path: '/communication',
        name: communication,
        builder: (context, state) => const CommunicationScreen(),
      ),

      // --- Check Appointments ---
      GoRoute(
        path: '/checkAppointments',
        name: checkAppointments,
        builder: (context, state) => const CheckAppointmentsScreen(),
      ),

      // --- Invoice ---
      GoRoute(
        path: '/invoice',
        name: invoice,
        builder: (context, state) => const InvoiceScreen(),
      ),
      GoRoute(
        path: '/paymentHistory',
        name: paymentHistory,
        builder: (context, state) => const PaymentHistoryScreen(),
      ),
      GoRoute(
        path: '/receiptTaxInvoice',
        name: receiptTaxInvoice,
        builder: (context, state) => const ReceiptTaxInvoiceScreen(),
      ),
      GoRoute(
        path: '/receiptTaxInvoiceDetail',
        name: receiptTaxInvoiceDetail,
        builder: (context, state) => const ReceiptTaxInvoiceDetailScreen(),
      ),
      GoRoute(
        path: '/pdfViewer',
        name: pdfViewer,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return PdfViewerScreen(
            pdfPath: extra['pdfPath'] as String,
            title: extra['title'] as String? ?? 'ดูตัวอย่างเอกสาร',
          );
        },
      ),
      GoRoute(
        path: '/usageHistory',
        name: usageHistory,
        builder: (context, state) {
          final initialIndex = state.extra as int? ?? 0;
          return UsageHistoryScreen(initialIndex: initialIndex);
        },
      ),

      // --- Appointment ---
      GoRoute(
        path: '/appointment',
        name: appointmentRenewal,
        builder: (context, state) => const AppointmentListSeleteScreen(),
        routes: [
          GoRoute(
            path: 'reserve',
            name: appointmentReserve,
            builder: (context, state) {
              final contract = state.extra as AppointmentEntity?;
              return AppointmentReserveScreen(contract: contract);
            },
          ),
          GoRoute(
            path: 'confirm',
            name: appointmentConfirm,
            builder: (context, state) {
              final req = state.extra as AppointmentReserveRequestModel;
              return BookingConfirmQueueScreen(request: req);
            },
          ),
          GoRoute(
            path: 'document',
            name: 'attachFileDocuments',
            builder: (context, state) => const AttachFileDocumentsScreen(),
          ),
        ],
      ),

      // --- Contract Routes ---
      GoRoute(
        path: '/contract',
        name: contractList,
        builder: (context, state) => const ContractListScreen(),
        routes: [
          GoRoute(
            path: 'create',
            name: createContract,
            builder: (context, state) => const CreateContractScreen(),
          ),
          GoRoute(
            path: 'scan',
            name: scanContract,
            builder: (context, state) {
              final isBarcodeSelected = state.extra as bool? ?? true;
              return ScanContractScreen(isBarcodeSelected: isBarcodeSelected);
            },
          ),
        ],
      ),

      // --- Payment Card ---
      GoRoute(
        path: '/paymentCard',
        name: paymentCard,
        builder: (context, state) => const PaymentCardScreen(),
      ),

      // --- Payment (เธเธณเธฃเธฐเน€เธเธดเธ) ---
      GoRoute(
        path: '/payment',
        name: payment,
        builder: (context, state) {
          final extra = state.extra as PaymentExtra?;
          return PaymentScreen(contractId: extra?.contractId ?? '');
        },
      ),
    ],

    // Error Page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.uri.path}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ),
  );
}
