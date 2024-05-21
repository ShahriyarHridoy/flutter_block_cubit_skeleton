// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/drawer.dart';
import 'package:flutter_block_cubit_skeleton/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/data/model/profile_response.dart';
import 'package:flutter_block_cubit_skeleton/features/update_profile/presentation/screen/edit_profile_widget.dart';

class ProfileWidget extends StatefulWidget {
  ProfileResponse? profileData;

  ProfileWidget({
    Key? key,
    this.profileData,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                          profileData: widget.profileData,
                        )));
          },
          child: const Icon(Icons.edit),
        ),
        drawer: const UserDetailDrawer(),
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24.0),
                const CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('assets/images/pp.jpg'),
                ),
                const SizedBox(height: 24.0),
                Text(
                  "${widget.profileData!.data!.fullName}",
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff341f97),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${widget.profileData!.data!.email}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24.0),
                _buildProfileItem(
                    Icons.phone,
                    widget.profileData!.data!.phone == null
                        ? ''
                        : '${widget.profileData!.data!.phone}'),
                _buildProfileItem(
                    Icons.calendar_today,
                    widget.profileData!.data!.dateOfBirth == null
                        ? ''
                        : '${widget.profileData!.data!.dateOfBirth}'),
                _buildProfileItem(
                    Icons.location_on,
                    widget.profileData!.data!.address == null
                        ? ''
                        : '${widget.profileData!.data!.address}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24.0,
            color: Color(0xff341f97),
          ),
          const SizedBox(width: 30.0),
          Text(
            value,
            style: const TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
