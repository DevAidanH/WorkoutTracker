import 'package:flutter/material.dart';
import 'package:workout_tracker/data/workout_data.dart';
import 'package:provider/provider.dart';

class Slidertest extends StatelessWidget {
  const Slidertest({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: List.generate(value.getWorkoutList().length, (index) {
            return SlideMenu(
              menuItems: <Widget>[
                Container(
                  color: Colors.black12,
                  child: IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ),
                Container(
                  color: Colors.red,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.delete),
                    onPressed: () {},
                  ),
                ),
              ],
              child: ListTile(
                title: Text(value.getWorkoutList()[index].name),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios)
                ),
              ),
            );
          }),
        ).toList(),   
      ),
      ));
  }
}

class SlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  const SlideMenu({Key? key,
    required this.child, required this.menuItems
  }) : super(key: key);

  @override
  State<SlideMenu> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Here the end field will determine the size of buttons which will appear after sliding
    //If you need to appear them at the beginning, you need to change to "+" Offset coordinates (0.2, 0.0)
    final animation =
    Tween(begin: const Offset(0.0, 0.0),
        end: const Offset(-0.2, 0.0))
        .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        // we can access context.size here
        setState(() {
          //Here we set value of Animation controller depending on our finger move in horizontal axis
          //If you want to slide to the right, change "-" to "+"
          _controller.value -= (data.primaryDelta! / (context.size!.width*0.2));
        });
      },
      onHorizontalDragEnd: (data) {
        //To change slide direction, change to data.primaryVelocity! < -1500
        if (data.primaryVelocity! > 1500)
          _controller.animateTo(.0); //close menu on fast swipe in the right direction
        //To change slide direction, change to data.primaryVelocity! > 1500
        else if (_controller.value >= .5 || data.primaryVelocity! < -1500)
          _controller.animateTo(1.0); // fully open if dragged a lot to left or on fast swipe to left
        else // close if none of above
          _controller.animateTo(.0);
      },
      child: LayoutBuilder(builder: (context, constraint) {
        return Stack(
          children: [
            SlideTransition(
                position: animation,
                child: widget.child,
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  //To change slide direction to right, replace the right parameter with left:
                  return Positioned(
                    right: .0,
                    top: .0,
                    bottom: .0,
                    width: constraint.maxWidth * animation.value.dx * -1,
                    child: Row(
                      children: widget.menuItems.map((child) {
                        return Expanded(
                          child: child,
                        );
                      }).toList(),
                    ),
                  );
                })
          ],
        );
      })
    );
  }
}