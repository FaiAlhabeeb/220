import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class Job {
  final String id;
  final String position;
  final String workplaceType;
  final String jobType;
  final String location;
  final String companyId;
  Job({
    required this.id,
    required this.position,
    required this.workplaceType,
    required this.jobType,
    required this.location,
    required this.companyId,
    
  });
}

class CustomJobCard extends StatelessWidget {
  final Job job;
  final Function(Job) onDelete; // Callback for delete action
  CustomJobCard({required this.job, required this.onDelete});

  get jobData => null;

  delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this job?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onDelete(
                    job); // Call the onDelete callback with the job parameter
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: false,
        // dragDismissible: true,
        // dismissible: DismissiblePane(onDismissed: () {
        //   delete(context);
        // }),
        children: [
          SlidableAction(
            onPressed: (context) {
              delete(context);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.position,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.88,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 6),
              Container(
                color: Colors.grey[300], // Grey line
                height: 1,
                width: double.infinity,
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      job.jobType,
                      style: TextStyle(
                        color: Color(0xFF585858),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.88,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      job.workplaceType,
                      style: TextStyle(
                        color: Color(0xFF585858),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.88,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Text(
                job.location,
                style: TextStyle(
                  color: Color(0xFF3A7BFE),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 2.14,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}