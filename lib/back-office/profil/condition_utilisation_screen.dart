import 'package:flutter/material.dart';

import '../../widgets/go_back_widget.dart';
import '../../widgets/title_widget.dart';
class ConditionUtilisationScreen extends StatefulWidget {
  const ConditionUtilisationScreen({super.key});

  @override
  State<ConditionUtilisationScreen> createState() => _ConditionUtilisationScreenState();
}

class _ConditionUtilisationScreenState extends State<ConditionUtilisationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        title: TitleWidget.setTitle("Conditions d'utilisation"),
        leading: GoBackWidget.goBack(context),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed erat varius, vulputate magna in, vestibulum arcu. Nulla facilisi. Curabitur non arcu nec ligula tristique cursus. Cras et pulvinar lorem. Curabitur sit amet ex at enim tempor dapibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer fermentum risus sed magna viverra, nec blandit metus tincidunt. Fusce tincidunt ex nec lorem scelerisque, sed dignissim magna faucibus. Sed tincidunt, tellus in convallis lobortis, sem mauris tincidunt velit, et eleifend purus tellus eget felis."
              +"Vivamus sed laoreet tortor. Pellentesque a leo ut lorem tincidunt laoreet. Integer ut velit eget purus efficitur dapibus. Morbi semper, augue nec blandit eleifend, metus urna fermentum enim, nec volutpat ligula lorem nec elit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Maecenas in eros libero. Nunc feugiat imperdiet felis, ac tempor velit laoreet a."
               +"Mauris eleifend lorem eget pretium pretium. Suspendisse at volutpat metus. In dignissim ex nec sem tristique, nec tristique mi ultrices. Cras non neque nec arcu tempor sollicitudin. Quisque porttitor sapien nec enim aliquam, in sagittis nulla fringilla. Suspendisse potenti. Vestibulum eu orci nulla. Etiam eget sapien finibus, feugiat nulla eget, porttitor elit."
              +"Donec et convallis velit. Etiam egestas enim in pulvinar vulputate. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse potenti. Nullam luctus feugiat felis. Integer euismod risus sed turpis fringilla, nec volutpat risus congue. Vestibulum congue leo ac turpis tincidunt, sit amet fermentum purus tempor. Proin convallis magna sit amet tortor feugiat, sed efficitur leo porta."),
          ),
        ),
      ),
    );
  }
}
