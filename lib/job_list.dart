import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'custom_job_card.dart';

class JobList extends StatelessWidget {
  final String companyId ;
 
  final List<Job> jobs; // List of jobs

  JobList({required this.jobs, required this.companyId});

  Future<void> deleteJob(Job job) async {
    try {
      await FirebaseFirestore.instance.collection('jobs').doc(job.id).delete();
    } catch (e) {
      print("Error deleting job: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Add back arrow icon
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Navigate back when the button is pressed
            },
          ),
          automaticallyImplyLeading: false,
          title: Text(
            "Posted Jobs",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
              height: 1.50,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('jobs')
               .where('componyId', isEqualTo: companyId) // Filter by companyId
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
              
            }
            
            var jobList = snapshot.data!.docs;
            if (jobList.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 271.0, left: 70.0),
                child: Text(
                  'Sorry, No Posted Jobs Yet',
                  style: TextStyle(
                    color: Color(0xFF585858),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.88,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: jobList.length,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              itemBuilder: (context, index) {
                var jobData = jobList[index].data() as Map<String, dynamic>;
                return CustomJobCard(
                  job: Job(
                    position: jobData['position'] ?? '',
                    workplaceType: jobData['workPlaceType'] ?? '',
                    jobType: jobData['jobType'] ?? '',
                    location: jobData['location'] ?? '',
                    id: jobData['id'] ?? '',
                    companyId: jobData['componyId'] ?? '',
                    
                  ),
                  onDelete: (jobToDelete) {
                    // Delete the job from Firestore when onDelete is called
                    deleteJob(jobToDelete);
                  },
                );
              },
            );
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}