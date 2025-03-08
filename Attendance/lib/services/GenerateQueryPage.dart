import 'package:flutter/material.dart';

class GenerateQueryPage extends StatefulWidget {
  const GenerateQueryPage({super.key});

  @override
  _GenerateQueryPageState createState() => _GenerateQueryPageState();
}

class _GenerateQueryPageState extends State<GenerateQueryPage> {
  String? selectedReason;
  TextEditingController messageController = TextEditingController();

  final List<String> reasons = [
    "Forgot to scan QR",
    "Faced technical issues",
    "Absent due to illness",
    "Other (Mention Below)"
  ];

  void submitQuery() {
    if (selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a reason")),
      );
      return;
    }

    String finalMessage =
        "Reason: $selectedReason\nMessage: ${messageController.text}";

    // TODO: Send this data to Firestore or an API
    print(finalMessage); 

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Query sent successfully!")),
    );

    Navigator.pop(context); // Close the page after submission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate Attendance Query")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Reason", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedReason,
              items: reasons.map((reason) {
                return DropdownMenuItem(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedReason = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
            SizedBox(height: 20),
            Text("Additional Message", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Write your message here...",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: submitQuery,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Submit Query"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
