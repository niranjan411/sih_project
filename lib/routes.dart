import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_school_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/student_list_screen.dart';
import 'screens/camera_attendance_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/report_view_daily.dart';
import 'screens/report_view_weekly.dart';
import 'screens/report_view_monthly.dart';
import 'screens/school_approve_pending.dart';

class Routes {
  static const String login = '/';
  static const String signup = '/signup';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String students = '/students';
  static const String camera = '/camera';
  static const String reports = '/reports';
  static const String daily = '/report/daily';
  static const String weekly = '/report/weekly';
  static const String monthly = '/report/monthly';
  static const String approvePending = '/approve_pending';

  static Map<String, WidgetBuilder> getRoutes({String username = ''}) => {
        login: (c) => LoginScreen(),
        signup: (c) => SignUpScreen(),
        register: (c) => RegisterSchoolScreen(username: ''), // <-- provide a default or pass actual username
        dashboard: (c) => DashboardScreen(),
        students: (c) => StudentListScreen(),
        camera: (c) => CameraAttendanceScreen(),
        reports: (c) => ReportsScreen(),
        daily: (c) => DailyReportView(),
        weekly: (c) => WeeklyReportView(),
        monthly: (c) => MonthlyReportView(),
        approvePending: (c) => SchoolApprovePendingScreen(),
      };
}
