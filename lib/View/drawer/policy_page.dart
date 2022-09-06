import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:maxprint_final/Const/app_localization.dart';
import 'package:maxprint_final/Const/app_widget.dart';
import 'package:maxprint_final/Const/appcolors.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyPage extends StatelessWidget {

  String title;
  String content;
  PolicyPage(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.secondaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _body(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
  _header(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight:Radius.circular(30)
        ),
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back,color: Colors.black,size: 28,)),
              Container(
                child: AppWidget.appText(title,
                    Colors.black,20,FontWeight.bold),
              ),
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back,color: Colors.transparent,size: 28,)),
            ],
          ),
        ],
      ),
    );
  }
  _body(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          //1
          Html(
            data: content,
            onLinkTap: (url, _, __, ___) async {
              if (await canLaunch(url!)) {
                await launch(url);
              }
            },
          ),
          title == App_Localization.of(context).translate("privacy_policy") ?
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<th><strong>Name</strong></th>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                          Html(data: "<strong>Function</strong>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_ab</i>"),
                          Html(data: "<td>Used in connection with access to admin.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_secure_session_id</i>"),
                          Html(data: "<td>Used in connection with navigation through a storefront.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>cart</i>"),
                          Html(data: "<td>Used in connection with shopping cart.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>cart_sig</i>"),
                          Html(data: "<td>Used in connection with checkout.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>cart_ts</i>"),
                          Html(data: "<td>Used in connection with checkout.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>checkout_token</i>"),
                          Html(data: "<td>Used in connection with checkout.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>secret</i>"),
                          Html(data: "<td>Used in connection with checkout.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>secure_customer_sig</i>",
                            style: {"body": Style(textOverflow: TextOverflow.ellipsis),},
                          ),
                          Html(data: "<td>Used in connection with customer login.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>storefront_digest</i>"),
                          Html(data: "<td>Used in connection with customer login.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_shopify_u</i>"),
                          Html(data: "<td>Used to facilitate updating customer account information.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              //2
              Html(data: "<h2>Reporting and Analytics</h2>"),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<th><strong>Name</strong></th>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                          Html(data: "<strong>Function</strong>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_tracking_consent</i>",),
                          Html(data: "<td>Tracking preferences.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_landing_page</i>"),
                          Html(data: "<td>Track landing pages</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_orig_referrer</i>"),
                          Html(data: "<td>Track landing pages</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_s</i>"),
                          Html(data: "<td>Shopify analytics.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_shopify_s</i>"),
                          Html(data: "<td>Shopify analytics.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_shopify_sa_p</i>"),
                          Html(data: "<td>Shopify analytics relating to marketing & referrals.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_shopify_sa_t</i>"),
                          Html(data: "<td>Shopify analytics relating to marketing & referrals.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_shopify_y</i>"),
                          Html(data: "<td>Shopify analytics.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              AppWidget.divider(1, Colors.grey, 0, 0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          Html(data: "<i>_y</i>"),
                          Html(data: "<td>Shopify analytics.</td>",
                            style: {
                              "body": Style(
                                  textOverflow: TextOverflow.ellipsis
                              ),
                            },),
                        ]
                    ),
                  ],
                ),
              ),
              Html(
                  data: App_Localization.of(context).translate("privacy_policy_content2"),
                  onLinkTap: (url, _, __, ___) async {
                    if (await canLaunch(url!)) {
                      await launch(url);
                    }
                  },),
            ],
          ) : const Center()
        ],
      )
    );
  }
}
