import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:student_progress_tracker/bloc/data_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import '../sdk/responsive_sdk.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _chartController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _chartAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _chartController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _chartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _chartController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _chartController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _chartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? currentUser = context.watch<DataCubit>().state;
    if (currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveSdk.paddingLarge(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar
                _buildCustomAppBar(),

                SizedBox(height: ResponsiveSdk.paddingLarge(context)),

                // Student Info Card
                _buildStudentInfoCard(currentUser),

                SizedBox(height: ResponsiveSdk.paddingLarge(context)),

                // Quick Stats Row
                _buildQuickStatsRow(currentUser),

                SizedBox(height: ResponsiveSdk.paddingLarge(context)),

                // Courses Section
                _buildCoursesSection(currentUser),

                SizedBox(height: ResponsiveSdk.paddingLarge(context)),

                // Attendance Section with Pie Chart
                _buildAttendanceSection(currentUser),

                SizedBox(height: ResponsiveSdk.paddingLarge(context)),

                // Upcoming Tests Section
                _buildUpcomingTestsSection(currentUser),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: EdgeInsets.all(ResponsiveSdk.paddingMedium(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.shade100.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade600, Colors.blue.shade600],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.dashboard, color: Colors.white, size: 24),
            ),
            SizedBox(width: ResponsiveSdk.paddingMedium(context)),
            Text(
              'Student Dashboard',
              style: TextStyle(
                fontSize: ResponsiveSdk.fontSizeMedium(context),
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Get.toNamed('/profile');
              },
              icon: Icon(
                Icons.person_outline,
                color: Colors.indigo.shade600,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentInfoCard(Map<String, dynamic> currentUser) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: EdgeInsets.all(ResponsiveSdk.paddingLarge(context)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.indigo.shade600,
                Colors.blue.shade600,
                Colors.purple.shade600,
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.shade300.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              SizedBox(width: ResponsiveSdk.paddingLarge(context)),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: TextStyle(
                        fontSize: ResponsiveSdk.fontSizeSmall(context),
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: ResponsiveSdk.paddingSmall(context) / 2),
                    Text(
                      currentUser['name'],
                      style: TextStyle(
                        fontSize: ResponsiveSdk.fontSizeLarge(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: ResponsiveSdk.paddingSmall(context)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.school, size: 16, color: Colors.white),
                          SizedBox(
                            width: ResponsiveSdk.paddingSmall(context) / 2,
                          ),
                          Text(
                            'Class ${currentUser['class']}',
                            style: TextStyle(
                              fontSize: ResponsiveSdk.fontSizeSmall(context),
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStatsRow(Map<String, dynamic> currentUser) {
    final attendanceValue = double.parse(
      currentUser['attendance'].replaceAll('%', ''),
    );
    final coursesCount = (currentUser['coursesTaken'] as List).length;
    final testsCount = (currentUser['upcomingTests'] as List).length;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.check_circle_outline,
              title: 'Attendance',
              value: currentUser['attendance'],
              color: Colors.green,
            ),
          ),
          SizedBox(width: ResponsiveSdk.paddingMedium(context)),
          Expanded(
            child: _buildStatCard(
              icon: Icons.book_outlined,
              title: 'Courses',
              value: '$coursesCount',
              color: Colors.blue,
            ),
          ),
          SizedBox(width: ResponsiveSdk.paddingMedium(context)),
          Expanded(
            child: _buildStatCard(
              icon: Icons.assignment_outlined,
              title: 'Tests',
              value: '$testsCount',
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(ResponsiveSdk.paddingMedium(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: ResponsiveSdk.paddingSmall(context)),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveSdk.fontSizeMedium(context),
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: ResponsiveSdk.fontSizeExtraSmall(context),
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesSection(Map<String, dynamic> currentUser) {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.library_books,
                  color: Colors.indigo.shade600,
                  size: 20,
                ),
              ),
              SizedBox(width: ResponsiveSdk.paddingMedium(context)),
              Text(
                'Your Courses',
                style: TextStyle(
                  fontSize: ResponsiveSdk.fontSizeLarge(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveSdk.paddingMedium(context)),
          Wrap(
            spacing: ResponsiveSdk.paddingMedium(context),
            runSpacing: ResponsiveSdk.paddingMedium(context),
            children: (currentUser['coursesTaken'] as List)
                .map<Widget>(
                  (course) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo.shade100, Colors.blue.shade100],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.indigo.shade200,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      course,
                      style: TextStyle(
                        fontSize: ResponsiveSdk.fontSizeSmall(context),
                        color: Colors.indigo.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceSection(Map<String, dynamic> currentUser) {
    final attendanceValue = double.parse(
      currentUser['attendance'].replaceAll('%', ''),
    );
    final absentValue = 100 - attendanceValue;

    return FadeTransition(
      opacity: _chartAnimation,
      child: Container(
        padding: EdgeInsets.all(ResponsiveSdk.paddingLarge(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.pie_chart,
                    color: Colors.green.shade600,
                    size: 20,
                  ),
                ),
                SizedBox(width: ResponsiveSdk.paddingMedium(context)),
                Text(
                  'Attendance Overview',
                  style: TextStyle(
                    fontSize: ResponsiveSdk.fontSizeMedium(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: ResponsiveSdk.paddingLarge(context)),
            Row(
              children: [
                // Pie Chart
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: attendanceValue,
                            title: '${attendanceValue.toInt()}%',
                            color: Colors.green.shade600,
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: absentValue,
                            title: '${absentValue.toInt()}%',
                            color: Colors.red.shade400,
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveSdk.paddingLarge(context)),
                // Legend
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem(
                        color: Colors.green.shade600,
                        label: 'Present',
                        value: '${attendanceValue.toInt()}%',
                      ),
                      SizedBox(height: ResponsiveSdk.paddingMedium(context)),
                      _buildLegendItem(
                        color: Colors.red.shade400,
                        label: 'Absent',
                        value: '${absentValue.toInt()}%',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: ResponsiveSdk.paddingSmall(context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveSdk.fontSizeSmall(context),
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: ResponsiveSdk.fontSizeMedium(context),
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingTestsSection(Map<String, dynamic> currentUser) {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.assignment_outlined,
                  color: Colors.orange.shade600,
                  size: 20,
                ),
              ),
              SizedBox(width: ResponsiveSdk.paddingMedium(context)),
              Text(
                'Upcoming Tests',
                style: TextStyle(
                  fontSize: ResponsiveSdk.fontSizeLarge(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveSdk.paddingMedium(context)),
          ...(currentUser['upcomingTests'] as List).map<Widget>(
            (test) => Container(
              margin: EdgeInsets.only(
                bottom: ResponsiveSdk.paddingMedium(context),
              ),
              padding: EdgeInsets.all(ResponsiveSdk.paddingMedium(context)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.assignment,
                      color: Colors.orange.shade600,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: ResponsiveSdk.paddingMedium(context)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          test['subject'],
                          style: TextStyle(
                            fontSize: ResponsiveSdk.fontSizeMedium(context),
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(
                          height: ResponsiveSdk.paddingSmall(context) / 2,
                        ),
                        Text(
                          test['date'],
                          style: TextStyle(
                            fontSize: ResponsiveSdk.fontSizeSmall(context),
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
