import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController messageController;

@override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContactUs'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: (isLoading) ? _drawLoading() : _contactForm(),
      ),
    );
  }

  Widget _contactForm(){
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Your name",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please Enter Your Name!";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 24),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Your email",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "Please Enter Your Email!";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 24),
          TextFormField(
            controller: messageController,
            decoration: InputDecoration(
              labelText: "Your massege",
            ),
            maxLines: 4,
            validator: (value) {
              if (value.isEmpty) {
                return "Please Enter Your Message!";
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {

                //TODO: send message, loading
                if(_formKey.currentState.validate()){

                  String name = nameController.text;
                  String email = emailController.text;
                  String message = messageController.text;

                  setState(() {
                    isLoading = true;
                  });
                }else{
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Text(
                'SEND MESSAGE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

