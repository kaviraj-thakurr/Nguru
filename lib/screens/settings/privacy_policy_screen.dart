import 'package:flutter/material.dart';
import 'package:nguru/custom_widgets/custom_appbar.dart';
import 'package:nguru/custom_widgets/screen_header.dart';
import 'package:nguru/utils/app_assets.dart';
import 'package:nguru/utils/app_colors.dart';
import 'package:nguru/utils/app_font.dart';
import 'package:velocity_x/velocity_x.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            MyAssets.bg,
            fit: BoxFit.fill,
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              20.heightBox,
              dashboardAppBar(),
              10.heightBox,
              screenTitleHeader("Privacy Policy", onPressed: ()=> Navigator.pop(context)),
              10.heightBox,
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    """
              Lorem ipsum dolor sit amet consectetur. Consectetur cras enim hendrerit massa eros. Varius diam commodo sagittis mauris elit ullamcorper imperdiet tortor nulla. Bibendum pellentesque tincidunt nec purus. Nunc massa sed facilisi amet fames luctus in id euismod. Ornare non lacus at volutpat ultrices. Ac vel consequat ut turpis enim morbi. Feugiat lobortis donec rhoncus at. Gravida elit aliquam vestibulum mauris. Tellus et morbi dictum ut purus cursus mauris est. Amet porttitor sociis nibh tempus. Sit sit non eget neque integer molestie.
              Lectus in duis donec a vitae netus cursus neque amet. Lorem urna sollicitudin diam sit ullamcorper auctor fringilla sem. Gravida aliquam in mauris sed phasellus id tristique. Blandit vitae vitae viverra nec. Mauris neque porta lacus in mi at. Augue vulputate lobortis dui adipiscing montes mauris est. Non velit morbi in sed. Aliquet a ac id tellus eget eu et gravida faucibus. Nunc at nulla hac aliquam urna in sed. Etiam est natoque scelerisque eu sed elit ut. Eu iaculis tincidunt porta dis.
              Lorem ipsum dolor sit amet consectetur. Consectetur cras enim hendrerit massa eros. Varius diam commodo sagittis mauris elit ullamcorper imperdiet tortor nulla. Bibendum pellentesque tincidunt nec purus. Nunc massa sed facilisi amet fames luctus in id euismod. Ornare non lacus at volutpat ultrices. Ac vel consequat ut turpis enim morbi. Feugiat lobortis donec rhoncus at. Gravida elit aliquam vestibulum mauris. Tellus et morbi dictum ut purus cursus mauris est. Amet porttitor sociis nibh tempus. Sit sit non eget neque integer molestie.
              Lectus in duis donec a vitae netus cursus neque amet. Lorem urna sollicitudin diam sit ullamcorper auctor fringilla sem. Gravida aliquam in mauris sed phasellus id tristique. Blandit vitae vitae viverra nec. Mauris neque porta lacus in mi at. Augue vulputate lobortis dui adipiscing montes mauris est. Non velit morbi in sed. Aliquet a ac id tellus eget eu et gravida faucibus. Nunc at nulla hac aliquam urna in sed. Etiam est natoque scelerisque eu sed elit ut. Eu iaculis tincidunt porta dis.
              Lorem ipsum dolor sit amet consectetur. Consectetur cras enim hendrerit massa eros. Varius diam commodo sagittis mauris elit ullamcorper imperdiet tortor nulla. Bibendum pellentesque tincidunt nec purus. Nunc massa sed facilisi amet fames luctus in id euismod. Ornare non lacus at volutpat ultrices. Ac vel consequat ut turpis enim morbi. Feugiat lobortis donec rhoncus at. Gravida elit aliquam vestibulum mauris. Tellus et morbi dictum ut purus cursus mauris est. Amet porttitor sociis nibh tempus. Sit sit non eget neque integer molestie.
              Lectus in duis donec a vitae netus cursus neque amet. Lorem urna sollicitudin diam sit ullamcorper auctor fringilla sem. Gravida aliquam in mauris sed phasellus id tristique. Blandit vitae vitae viverra nec. Mauris neque porta lacus in mi at. Augue vulputate lobortis dui adipiscing montes mauris est. Non velit morbi in sed. Aliquet a ac id tellus eget eu et gravida faucibus. Nunc at nulla hac aliquam urna in sed. Etiam est natoque scelerisque eu sed elit ut. Eu iaculis tincidunt porta dis.
              Lorem ipsum dolor sit amet consectetur. Consectetur cras enim hendrerit massa eros. Varius diam commodo sagittis mauris elit ullamcorper imperdiet tortor nulla. Bibendum pellentesque tincidunt nec purus. Nunc massa sed facilisi amet fames luctus in id euismod. Ornare non lacus at volutpat ultrices. Ac vel consequat ut turpis enim morbi. Feugiat lobortis donec rhoncus at. Gravida elit aliquam vestibulum mauris. Tellus et morbi dictum ut purus cursus mauris est. Amet porttitor sociis nibh tempus. Sit sit non eget neque integer molestie.
              Lectus in duis donec a vitae netus cursus neque amet. Lorem urna sollicitudin diam sit ullamcorper auctor fringilla sem. Gravida aliquam in mauris sed phasellus id tristique. Blandit vitae vitae viverra nec. Mauris neque porta lacus in mi at. Augue vulputate lobortis dui adipiscing montes mauris est. Non velit morbi in sed. Aliquet a ac id tellus eget eu et gravida faucibus. Nunc at nulla hac aliquam urna in sed. Etiam est natoque scelerisque eu sed elit ut. Eu iaculis tincidunt porta dis.
              Lorem ipsum dolor sit amet consectetur. Consectetur cras enim hendrerit massa eros. Varius diam commodo sagittis mauris elit ullamcorper imperdiet tortor nulla. Bibendum pellentesque tincidunt nec purus. Nunc massa sed facilisi amet fames luctus in id euismod. Ornare non lacus at volutpat ultrices. Ac vel consequat ut turpis enim morbi. Feugiat lobortis donec rhoncus at. Gravida elit aliquam vestibulum mauris. Tellus et morbi dictum ut purus cursus mauris est. Amet porttitor sociis nibh tempus. Sit sit non eget neque integer molestie.
              Lectus in duis donec a vitae netus cursus neque amet. Lorem urna sollicitudin diam sit ullamcorper auctor fringilla sem. Gravida aliquam in mauris sed phasellus id tristique. Blandit vitae vitae viverra nec. Mauris neque porta lacus in mi at. Augue vulputate lobortis dui adipiscing montes mauris est. Non velit morbi in sed. Aliquet a ac id tellus eget eu et gravida faucibus. Nunc at nulla hac aliquam urna in sed. Etiam est natoque scelerisque eu sed elit ut. Eu iaculis tincidunt porta dis.
              """,
              textAlign: TextAlign.justify,
                  style: FontUtil.customStyle(fontSize: 14, fontWeight: FontWeight.w500, textColor: MyColors.boldTextColor),)),
              )
            ]
    )
          ),
        ]
      )
    );
  }
}