
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/app_cubit.dart';
import 'package:todo/cubit/app_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreenState extends StatelessWidget {


  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formkey=GlobalKey<FormState>();
  TextEditingController taskTitle=TextEditingController();
  TextEditingController taskTime=TextEditingController();
  TextEditingController taskdate=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: BlocProvider(
        create: (BuildContext context) =>AppCubit().. createDataBase(),
          child: BlocConsumer<AppCubit,AppStates>(
            listener: (context, state) {},
            builder: (context , state){
              return Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  title: Text('${AppCubit.get(context).screenTitle[AppCubit.get(context).currentIndex]}'),
                ),
                body: AppCubit.get(context).currentBody[AppCubit.get(context).currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index){
                    AppCubit.get(context).changeBottomNavBar(index);
                  },
                  currentIndex:AppCubit.get(context).currentIndex,


                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu),
                        label: 'Tasks'
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.done_outline_rounded),
                        label: 'Done'
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive_outlined),
                        label: 'Archived'
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    if(AppCubit.get(context).IsbottunSheetShown)
                    {
                      if(formkey.currentState!.validate()) {
                       AppCubit.get(context).changeBottomSheet
                         (
                           isShow: false,
                           FBIcon: Icon(Icons.add)
                       );
                        Navigator.pop(context);
                        AppCubit.get(context).IsbottunSheetShown = false;
                        AppCubit.get(context).insertToDatabase(
                            title: taskTitle.text,
                            date: taskdate.text,
                            time: taskTime.text
                        ).then((value) {

                        });
                      }
                    }
                    else
                    {
                      AppCubit.get(context).changeBottomSheet
                        (
                          isShow: true,
                          FBIcon: Icon(Icons.edit)
                      );

                      scaffoldKey.currentState!.showBottomSheet((context) {
                        AppCubit.get(context).IsbottunSheetShown =true;
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: taskTitle,
                                validator: (value){
                                  if(value!.isEmpty||value==null)
                                  {
                                    return 'Please Enter The Title of Task';
                                  }

                                },
                                decoration: InputDecoration(
                                    label: Text('Task Title'),
                                    prefix: Icon(Icons.title),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                              ),
                              SizedBox(height: 15,),
                              TextFormField(
                                controller: taskTime,
                                onTap: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {taskTime.text=value!.format(context).toString();
                                  print(value.format(context));
                                  });
                                },
                                validator: (value){
                                  if(value!.isEmpty||value==null)
                                  {
                                    return 'Please Enter The Time ';
                                  }

                                },
                                decoration: InputDecoration(
                                    label: Text('Task time'),
                                    prefix: Icon(Icons.timelapse),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                              ),
                              SizedBox(height: 15,),
                              TextFormField(
                                controller: taskdate,
                                onTap: (){
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2023)
                                  ).then((value) {
                                    taskdate.text=DateFormat.yMd().format(value!);
                                  });
                                },
                                validator: (value){
                                  if(value!.isEmpty||value==null) {
                                    return 'Please Enter The Time ';
                                  }

                                },
                                decoration: InputDecoration(
                                    label: Text('Task Date'),
                                    prefix: Icon(Icons.date_range),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                              ),

                            ],
                          ),
                        );

                      }).closed.then((value){
                        AppCubit.get(context).IsbottunSheetShown = false;
                        // setState(() {
                        //   BSIcon = Icon(Icons.add);
                        // });

                      });
                    }

                  },
                  child:AppCubit.get(context).BSIcon  ,
                ),
              );
            },
          ),
      ),
    );
  }






}
