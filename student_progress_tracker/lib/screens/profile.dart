import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:student_progress_tracker/bloc/data_cubit.dart';
import '../sdk/responsive_sdk.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _startAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(
                Icons.logout,
                color: Colors.red.shade600,
                size: 28,
              ),
              SizedBox(width: ResponsiveSdk.paddingMedium(context)),
              const Text('Logout'),
            ],
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<DataCubit>().signout();
                Get.offAllNamed('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? currentUser = context.watch<DataCubit>().state;
    
    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo.shade600,
              Colors.blue.shade600,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Custom App Bar
                _buildCustomAppBar(),
                
                SizedBox(height: ResponsiveSdk.paddingLarge(context)),

                // Profile Header
                _buildProfileHeader(currentUser),

                SizedBox(height: ResponsiveSdk.paddingLarge(context)),

                // Profile Info Cards
                _buildProfileInfoCards(currentUser),

                SizedBox(height: ResponsiveSdk.paddingLarge(context) * 2),

                // Logout Button
                _buildLogoutButton(),

                SizedBox(height: ResponsiveSdk.paddingLarge(context)),
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
        margin: EdgeInsets.all(ResponsiveSdk.paddingMedium(context)),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(width: ResponsiveSdk.paddingMedium(context)),
            Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: ResponsiveSdk.paddingMedium(context)),
            Text(
              'Student Profile',
              style: TextStyle(
                fontSize: ResponsiveSdk.fontSizeLarge(context),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> currentUser) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveSdk.paddingLarge(context),
          ),
          child: Column(
            children: [
              // Profile Avatar
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.indigo.shade600,
                ),
              ),
              
              SizedBox(height: ResponsiveSdk.paddingLarge(context)),
              
              // Student Name
              Text(
                currentUser['name'],
                style: TextStyle(
                  fontSize: ResponsiveSdk.fontSizeLarge(context) * 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: ResponsiveSdk.paddingSmall(context)),
              
              // Student Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveSdk.paddingMedium(context),
                  vertical: ResponsiveSdk.paddingSmall(context),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: ResponsiveSdk.paddingSmall(context)),
                    Text(
                      'Student',
                      style: TextStyle(
                        fontSize: ResponsiveSdk.fontSizeMedium(context),
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
      ),
    );
  }

  Widget _buildProfileInfoCards(Map<String, dynamic> currentUser) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveSdk.paddingLarge(context),
        ),
        child: Column(
          children: [
            // Student ID Card
            _buildInfoCard(
              icon: Icons.badge,
              title: 'Student ID',
              value: currentUser['id'] ?? "NA",
              color: Colors.blue,
            ),
            
            SizedBox(height: ResponsiveSdk.paddingMedium(context)),
            
            // Class Card
            _buildInfoCard(
              icon: Icons.school,
              title: 'Class',
              value: 'Class ${currentUser['class']}',
              color: Colors.green,
            ),
            
            SizedBox(height: ResponsiveSdk.paddingMedium(context)),
            
            // Attendance Card
            _buildInfoCard(
              icon: Icons.check_circle,
              title: 'Attendance',
              value: currentUser['attendance'],
              color: Colors.orange,
            ),
            
            SizedBox(height: ResponsiveSdk.paddingMedium(context)),
            
            // Courses Count Card
            _buildInfoCard(
              icon: Icons.library_books,
              title: 'Enrolled Courses',
              value: '${(currentUser['coursesTaken'] as List).length} Courses',
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(ResponsiveSdk.paddingLarge(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveSdk.paddingMedium(context)),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          
          SizedBox(width: ResponsiveSdk.paddingLarge(context)),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveSdk.fontSizeSmall(context),
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: ResponsiveSdk.paddingSmall(context) / 2),
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
          ),
          
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveSdk.paddingLarge(context),
        ),
        child: SizedBox(
          width: double.infinity,
          height: ResponsiveSdk.buttonHeight(context) * 1.2,
          child: ElevatedButton(
            onPressed: _showLogoutDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(width: ResponsiveSdk.paddingMedium(context)),
                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: ResponsiveSdk.fontSizeMedium(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}