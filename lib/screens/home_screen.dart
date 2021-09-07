import 'package:carsearch_flutterapp/controller/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final ApiController _apiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cars"),), body: Container(child: Center(
      child: Obx(() {
        switch (_apiController.getStatus.value) {
          case ListStatus.empty:
            return Text("List Empty");
          case ListStatus.loading:
            return CircularProgressIndicator();
          case ListStatus.loaded:
            return CarContainer();
          default:
            return Container();
        }
      }),
    )));
  }
}

class CarContainer extends StatelessWidget {

  final ApiController _apiController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(decoration: InputDecoration(border: UnderlineInputBorder(),
        labelText: 'Search Car Make'),),
       Expanded(
          child: ListView.builder(itemCount: _apiController.getCatList.length, 
            itemBuilder: (context, index){
              return ListTile(title: Text(_apiController.getCatList[index].makeName));
            }),
        ),

      ],
    );
  }
}
