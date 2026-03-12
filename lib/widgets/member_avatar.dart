import 'package:flutter/material.dart';
import '../app/theme.dart';

class MemberAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final String? name;

  const MemberAvatar({
    super.key,
    this.imageUrl,
    this.size = 32,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: AppTheme.accentColor,
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: AppTheme.backgroundColor,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildInitials();
                },
              )
            : _buildInitials(),
      ),
    );
  }

  Widget _buildInitials() {
    final initials = name != null && name!.isNotEmpty
        ? name!.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase()
        : '?';
    
    return Container(
      color: AppTheme.accentColor,
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.black,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}