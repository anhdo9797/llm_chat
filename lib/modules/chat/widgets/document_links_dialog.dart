// Widget hiển thị popup danh sách link tài liệu từ log.md
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:llm_chat/core/extensions/color_extension.dart';
import 'package:url_launcher/url_launcher.dart';

// Widget hiển thị dialog danh sách link tài liệu
class DocumentLinksDialog extends StatelessWidget {
  final List<String> links;

  const DocumentLinksDialog({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Danh sách tài liệu'),
      content: SizedBox(
        width: 400,
        height: 400,
        child: ListView.separated(
          itemCount: links.length,
          separatorBuilder: (_, __) => const SizedBox(),
          itemBuilder: (context, index) {
            final url = links[index];
            return ListTile(
              title: Text(
                url,
                style: TextStyle(
                  color: context.colors.primary,
                  decoration: TextDecoration.underline,
                  fontSize: 13,
                ),
              ),
              onTap: () {
                _launchUrl(Uri.parse(url));
              },
              trailing: IconButton(
                icon: const Icon(Icons.copy, size: 18),
                tooltip: 'Copy link',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: url));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Đã copy link')));
                },
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Đóng'),
        ),
      ],
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
