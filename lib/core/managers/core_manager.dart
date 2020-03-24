import 'package:flutter/material.dart';
import 'package:flutter_playground/core/managers/life_cycle_manager.dart';

class CoreManager extends StatelessWidget{
  final Widget child;
  const CoreManager({Key key, @required this.child}): assert(child!=null), super(key: key);

  @override
  Widget build(BuildContext context){
    return LifeCycleManager(child: child);
  }
}