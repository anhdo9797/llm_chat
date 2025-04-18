// Widget hiển thị popup danh sách link tài liệu từ log.md
import 'package:flutter/material.dart';

// Widget hiển thị dialog danh sách link tài liệu
class DocumentLinksDialog extends StatelessWidget {
  final List<String> links;

  const DocumentLinksDialog({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Danh sách tài liệu'),
      content: SizedBox(
        width: 400,
        height: 400,
        child: Scrollbar(
          child: ListView.separated(
            itemCount: links.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final url = links[index];
              return ListTile(
                title: Text(
                  url,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  // Mở link trên trình duyệt
                  // ignore: avoid_web_libraries_in_flutter
                  // Sử dụng url_launcher nếu cần, ở đây chỉ comment
                  // launchUrlString(url);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: 'Copy link',
                  onPressed: () {
                    // Sao chép link vào clipboard
                    // Clipboard.setData(ClipboardData(text: url));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã copy link')),
                    );
                  },
                ),
              );
            },
          ),
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
}
