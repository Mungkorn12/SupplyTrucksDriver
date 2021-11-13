import 'package:flutter/material.dart';
import 'package:supply_trucks_driver/AllScreens/mainscreen.dart';
import 'package:supply_trucks_driver/AllScreens/registrationScreen.dart';
import 'package:supply_trucks_driver/configMaps.dart';
import 'package:supply_trucks_driver/main.dart';


class CarInfoScreen extends StatelessWidget
{
  static const String idScreen = "carinfo";
  TextEditingController carModelTexEditingController = TextEditingController();
  TextEditingController carNumberTexEditingController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 22.0,),
              Image.asset("images/logo.png", width: 390.0, height: 250.0,),
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 32.0),
                child: Column(
                  children: [
                    SizedBox(height: 12.0,),
                    Text("Enter Car Details", style: TextStyle(fontFamily: "Brand Bold", fontSize: 24.0),),

                    SizedBox(height: 26.0,),
                    TextField(
                      controller: carModelTexEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Model",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),

                    SizedBox(height: 10.0,),
                    TextField(
                      controller: carNumberTexEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Number",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),

                    SizedBox(height: 42.0,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: RaisedButton(
                        onPressed: ()
                        {
                          if(carModelTexEditingController.text.isEmpty)
                          {
                            displayToastMessage("Please provide Car Model info", context);
                          }
                          else if(carNumberTexEditingController.text.isEmpty)
                          {
                            displayToastMessage("Please provide Car Number info", context);
                          }
                          else
                            {
                              saveDriverCarInfo(context);
                            }
                        },
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("NEXT", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 26.0,),
                            ],
                          ),
                        ),
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

  void saveDriverCarInfo(context)
  {
    String userId = currentfirebaseUser.uid;

    Map carInfoMap =
    {
      "car_number": carNumberTexEditingController.text,
      "car_model": carModelTexEditingController.text,
    };

    driversRef.child(userId).child("car_details").set(carInfoMap);

    Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
  }
}
