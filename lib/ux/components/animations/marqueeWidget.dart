import 'package:flutter/material.dart';

//Marquee widget component
class MarqueeWidget extends StatefulWidget {
  
  ///The widget which should be marquee.
  ///Can be Text or other widget or nested widgets
  final Widget child;

  ///The direction in which the marquee should move
  final Axis direction;

  ///The animation duration that animation should take to complete
  final Duration animationDuration;

  ///The animation duration that the animation 
  ///should take to go back to original state after animation ccompleted
  final Duration backDuration;

  ///The duration of the pause on original state
  final Duration pauseDuration;

  //Contructor and default fallback
  MarqueeWidget({
    @required this.child,
    this.animationDuration: const Duration(milliseconds: 5000),
    this.direction: Axis.horizontal,
    this.backDuration: const Duration(milliseconds: 2000),
    this.pauseDuration: const Duration(milliseconds: 2000),
  });
  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

//State of marquee widget
class _MarqueeWidgetState extends State<MarqueeWidget> {
  //Scroll controller 
  ScrollController scrollController;

  //initialising the scroll controller and binding the widget with animation
  @override
  void initState(){
    scrollController = ScrollController(
      initialScrollOffset: 50.0,
    );
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  //destoying the scroll controller when not needed
  @override 
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    //Scroll view to scroll the widget
    //it will simulate marquee
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  //async scroll funtion which will controll all the scroll animation
  void scroll(_) async{
    //looping till it have to scroll
    //like if it already fit the container no need to scroll
    while (scrollController.hasClients){
      await Future.delayed(widget.pauseDuration);
      if(scrollController.hasClients)
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent, 
          duration: widget.animationDuration, 
          curve: Curves.ease
        );
      await Future.delayed(widget.pauseDuration);
      if(scrollController.hasClients)
        await scrollController.animateTo(
          0.0, 
          duration: widget.backDuration, 
          curve: Curves.easeOut
        );
    }
  }
}