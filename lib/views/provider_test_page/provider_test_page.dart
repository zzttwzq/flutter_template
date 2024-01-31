import 'package:app/views/provider_test_page/provider_test_page_provider.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ProviderTestPage extends StatefulWidget {
  final String imgTag;
  final String titleTag;
  final String authorTag;

  ProviderTestPage({
    Key? key,
    required this.imgTag,
    required this.titleTag,
    required this.authorTag,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<ProviderTestPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        // Provider.of<DetailsProvider>(context, listen: false)
        //     .setEntry(widget.entry);
        // Provider.of<DetailsProvider>(context, listen: false)
        //     .getFeed(widget.entry.author!.uri!.t!.replaceAll(r'\&lang=en', ''));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderTestPageProvider>(
      builder: (BuildContext context, ProviderTestPageProvider detailsProvider,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () async {},
                icon: Icon(
                  detailsProvider.faved
                      ? Icons.confirmation_num
                      : Icons.confirmation_num,
                  color: detailsProvider.faved
                      ? Colors.red
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              IconButton(
                onPressed: () => () {},
                icon: const Icon(Icons.confirmation_num),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                color: detailsProvider.faved ? Colors.red : Colors.white,
              )
            ],
          ),
        );
      },
    );
  }
}
