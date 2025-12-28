import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project_craftoria/feautures/Expert1/view/uploade_exepertdata.dart';

import '../../auth/presentation/view/sign_up_view.dart';



class ExpertVerificationScreen extends StatefulWidget {
  @override
  _ExpertVerificationScreenState createState() =>
      _ExpertVerificationScreenState();
}

class _ExpertVerificationScreenState
    extends State<ExpertVerificationScreen> {
  List<Map<String, String>> uploadedFiles = []; // {name: "", type: ""}

  Future<void> pickFileOrImage() async {
    if (uploadedFiles.length >= 2) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.image, color: Color(0xFFB2876F)),
                title: Text("Upload Image"),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final XFile? img =
                  await picker.pickImage(source: ImageSource.gallery);

                  if (img != null) {
                    setState(() {
                      uploadedFiles.add({
                        "name": img.name,
                        "type": "IMAGE",
                      });
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.upload_file, color: Color(0xFFB2876F)),
                title: Text("Upload File (PDF / MP4)"),
                onTap: () async {
                  Navigator.pop(context);

                  final file = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'mp4'],
                  );

                  if (file != null) {
                    final fileName = file.files.first.name;
                    final ext = fileName.split('.').last.toUpperCase();

                    setState(() {
                      uploadedFiles.add({
                        "name": fileName,
                        "type": ext,
                      });
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void removeFile(int index) {
    setState(() {
      uploadedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ----- TOP APP BAR -----
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Expert Verification",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 5),

            // ----- STEPPER -----
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepCircle("1", isActive: true),

                // الخط بين 1 و 2
                Container(
                  width: 50,
                  height: 3,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  color: Color(0xFFBBA78C),
                ),

                _buildStepCircle("2", isActive: false),

                // الخط بين 2 و 3
                Container(
                  width: 50,
                  height: 3,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  color: Color(0xFFBBA78C),
                ),

                _buildStepCircle("3", isActive: false),
              ],
            ),

            SizedBox(height: 7),
            Container(
              height: 1,
              color: Color(0xFFECE7E4),
            ),


            const SizedBox(height: 5),

            const Text(
              "Upload Verification",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            const Text(
              "Upload 2 verification documents",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),

            // ----- UPLOAD BOX -----
            GestureDetector(
              onTap: pickFileOrImage,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.upload, size: 40, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      "${uploadedFiles.length}/2 uploaded",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ----- UPLOADED FILES LIST -----
            Column(
              children: [
                for (int i = 0; i < uploadedFiles.length; i++)
                  fileTile(uploadedFiles[i]["name"]!, uploadedFiles[i]["type"]!,
                      i),
              ],
            ),

            // ----- SUCCESS BOX -----
            if (uploadedFiles.length == 2) ...[
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF8EED9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.check, color: Colors.brown),
                    SizedBox(width: 10),
                    Text(
                      "All files uploaded successfully",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown),
                    ),
                  ],
                ),
              ),
            ],

            Spacer(),

            // ----- COMPLETE BUTTON -----
            GestureDetector(
              onTap: () {
                if (uploadedFiles.length == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpertExperienceScreen(), // ← الصفحة اللي عملتهالك
                    ),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 25),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: uploadedFiles.length == 2
                      ? Color(0xFF6E4E41)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "Complete Verification",
                    style: TextStyle(
                      color: uploadedFiles.length == 2
                          ? Colors.white
                          : Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  // ----- FILE TILE -----
  Widget fileTile(String name, String type, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Row(
        children: [
          // File name + type
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                type,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),

          Spacer(),

          // Delete icon
          GestureDetector(
            onTap: () => removeFile(index),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Icon(Icons.close, size: 18, color: Colors.grey.shade600),
            ),
          )
        ],
      ),
    );
  }

  Widget stepCircle(String number, {bool isActive = false}) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF6E4E41) : Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
Widget _buildStepCircle(String number,
    {bool isActive = false}) {
  return Container(
    width: 34,
    height: 34,
    decoration: BoxDecoration(
      color: isActive ? Color(0xFF6E4E41) : Color(0xFFE7D9CC),
      borderRadius: BorderRadius.circular(22),
      boxShadow: isActive
          ? [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        )
      ]
          : null,
    ),
    child: Center(
      child: Text(
        number,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.brown.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
