import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/cubit/app_cubit.dart';
import 'package:todo/cubit/app_states.dart';

import 'constatns.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class homeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    print('heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer');
    print(AppCubit.get(context).tasks);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var tasks=AppCubit.get(context).tasks;
        return tasks.length >0 ? ListView.separated(
            itemBuilder: (context, index) => Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffaaabe2),
                  radius: 40,
                  child: Text(
                    '${tasks[index]['time']}',
                    style: TextStyle(
                        color: Colors.white
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 5,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${tasks[index]['title']}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff6c6c6c)
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '${tasks[index]['date']}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff6c6c6c)
                      ),
                    ),

                  ],
                )
              ],
            ),
            separatorBuilder: (context, index )=> Padding(
              padding: const EdgeInsetsDirectional.only(start: 15, top: 5,bottom: 5,end: 15),
              child: Container(
                color: Color(0xffaaabe2),
                width: double.infinity,
                height: 1,
              ),
            ),
            itemCount: tasks.length) : Center(child: CircularProgressIndicator()) ;
      },

    );
  }
}
