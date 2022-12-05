part of '../details_screen.dart';

class _ItemArticle extends StatelessWidget {
  const _ItemArticle({super.key, required this.article, this.onDelete});

  final ItemModel article;
  final Function(ItemModel)? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.article_outlined),
      title: Text(article.name ?? 'Unknown'),
      subtitle: Text('ID: ${article.id} - Price: \$${article.price}'),
      trailing: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) =>
                  _DeleteArticle(article: article, onDelete: onDelete));
        },
        icon: const Icon(
          Icons.delete_outline,
          color: Colors.red,
        ),
      ),
    );
  }
}
