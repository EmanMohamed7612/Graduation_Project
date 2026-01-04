import 'package:flutter/material.dart';

import '../../../auth/presentation/view/sign_up_view.dart';



class ExpertExperienceScreen extends StatefulWidget {
  @override
  _ExpertExperienceScreenState createState() => _ExpertExperienceScreenState();
}

class _ExpertExperienceScreenState extends State<ExpertExperienceScreen> {
  Widget _buildStepCircle(String number, {bool isActive = false}) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF6E4E41) : Color(0xFFE7D9CC),
        borderRadius: BorderRadius.circular(22),
        boxShadow: isActive
            ? [
          BoxShadow(
            color: Colors.black26,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Expert Verification",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      // **Scroll to avoid yellow overflow**
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),

              // ------------ STEPPER ------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStepCircle("1", isActive: false),
                  Container(
                    width: 50,
                    height: 3,
                    color: Color(0xFFC9A875),
                    margin: EdgeInsets.symmetric(horizontal: 6),
                  ),
                  _buildStepCircle("2", isActive: true),
                  Container(
                    width: 50,
                    height: 3,
                    color: Color(0xFFBBA78C),
                    margin: EdgeInsets.symmetric(horizontal: 6),
                  ),
                  _buildStepCircle("3", isActive: false),
                ],
              ),

              SizedBox(height: 10),
              Container(height: 1, color: Color(0xFFEFEBE9)),

              SizedBox(height: 20),

              // ------------ TITLE ------------
              Text(
                "Your Experience",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E2723)
                ),
              ),

              SizedBox(height: 4),

              Text(
                "Tell us about your expertise",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 15),

              // ------------ YEARS OF EXPERIENCE ------------
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Years of Experience *",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),
              SizedBox(height: 5),

              TextField(
                decoration: InputDecoration(
                  hintText: "e.g., 5 years",
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFDCD4CD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Color(0xFFBBA78C), width: 1.4),
                  ),
                ),
              ),

              SizedBox(height: 18),

              // ------------ SPECIALTIES ------------
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Specialties",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),

              SizedBox(height: 5),

              TextField(
                decoration: InputDecoration(
                  hintText: "e.g., Ceramics, Pottery",
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFDCD4CD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Color(0xFFBBA78C), width: 1.4),
                  ),
                ),
              ),

              SizedBox(height: 18),

              // ------------ DESCRIPTION ------------
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description *",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ),

              SizedBox(height: 5),

              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:
                  "Describe your expertise and achievements...",
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFDCD4CD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                    BorderSide(color: Color(0xFFBBA78C), width: 1.4),
                  ),
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // ------------ BOTTOM BUTTON ------------
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(18),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xFFBBA78C),
            borderRadius: BorderRadius.circular(14),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpView(),
                ),
              );
            },
            child: Center(
              child: Text(
                "Next: Verification",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )

        ),
      ),
    );
  }
}
