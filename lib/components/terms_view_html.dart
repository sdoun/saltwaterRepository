import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsViewHtml extends StatefulWidget {
  const TermsViewHtml({super.key, required this.termsType});

  final String termsType;
  @override
  State<TermsViewHtml> createState() => _TermsViewHtmlState();
}

class _TermsViewHtmlState extends State<TermsViewHtml> {

  String? htmlContent;
  String title = '';
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    /*
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      );

    _loadHtmlFromAssets(widget.termsType);

     */
    //_initializeWebView();
    //_loadTermsOfService();
    _initializeController();
  }
  void _initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}');
            setState(() {
              isLoading = false;
            });
          },
        ),
      );

    _loadHtmlFromAssets(widget.termsType);
  }
  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadFlutterAsset('assets/terms/서비스 이용약관_1.html');
  }
  /*

  Future<void> _loadTermsOfService() async {
    String htmlContent = await loadHtmlFromAssets();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(htmlContent);
    setState(() {
      isLoading = false;
    });
  }

  Future<String> loadHtmlFromAssets() async {
    String content = await rootBundle.loadString('assets/terms/서비스 이용약관.html');
    return content;
  }
   */

  Future<void> _loadHtmlFromAssets(String termsType) async {
    String fileName;
    switch (termsType) {
      case '서비스 이용약관':
        title = '서비스 이용약관';
        fileName = 'assets/terms/service_terms_merge.html';
        break;
      case "개인정보 처리방침":
        title = '개인정보 처리방침';
        fileName = 'assets/terms/privacy_policy_merge.html';
        break;
      default:
        throw Exception('Unknown terms type: $termsType');
    }

    try {
      String fileContent = await rootBundle.loadString(fileName);
      await _controller.loadHtmlString(fileContent);
      print('HTML content loaded successfully');
    } catch (e) {
      print('Error loading HTML file: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _initializeWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      );

    _setTitleAndLoadHtml();
  }

  void _setTitleAndLoadHtml() {
    switch (widget.termsType) {
      case '서비스 이용약관':
        title = '서비스 이용약관';
        _loadHtmlFromFirebase('service_terms.html');
        break;
      case '개인정보 처리방침':
        title = '개인정보 처리방침';
        _loadHtmlFromFirebase('privacy_policy.html');
        break;
    }
  }

  Future<void> _loadHtmlFromFirebase(String fileName) async {
    try {
      final ref = FirebaseStorage.instance.ref(fileName);
      final url = await ref.getDownloadURL();
      setState(() {
        htmlContent = url;
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading HTML from Firebase: $e');
      // 에러 처리 (예: 사용자에게 알림 표시)
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.8,
      child: Column(
        children: [
          AppBar(
            title: Text(title),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if(isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
