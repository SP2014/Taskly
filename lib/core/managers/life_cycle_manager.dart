import 'package:flutter/material.dart';
import 'package:flutter_playground/core/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class LifeCycleManager extends StatefulWidget{
  final Widget child;
  const LifeCycleManager({Key key, this.child}): super(key: key);
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver{
  @override
  Widget build(BuildContext context){
    Provider.of<DarkThemeProvider>(context).init();
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  
}