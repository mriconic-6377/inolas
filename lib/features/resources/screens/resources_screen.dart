import 'package:flutter/material.dart';
import '../models/resource_model.dart';
import '../../../core/theme/theme.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  // Mock Data
  final List<ResourceCategory> _categories = [
    ResourceCategory(
      id: '1',
      name: 'Syllabus',
      icon: Icons.book_outlined,
      color: const Color(0xFFE3F2FD),
      items: [
        ResourceItem(id: 's1', title: 'B.Tech CSE 3rd Year Syllabus', type: 'PDF', url: '', size: '1.2 MB'),
        ResourceItem(id: 's2', title: 'B.Tech ECE 3rd Year Syllabus', type: 'PDF', url: '', size: '1.1 MB'),
      ],
    ),
    ResourceCategory(
      id: '2',
      name: 'Previous Papers',
      icon: Icons.description_outlined,
      color: const Color(0xFFF3E5F5),
      items: [
        ResourceItem(id: 'p1', title: 'Data Structures 2023', type: 'PDF', url: '', size: '2.5 MB'),
        ResourceItem(id: 'p2', title: 'Algorithms 2023', type: 'PDF', url: '', size: '2.1 MB'),
        ResourceItem(id: 'p3', title: 'DBMS 2022', type: 'PDF', url: '', size: '1.8 MB'),
      ],
    ),
    ResourceCategory(
      id: '3',
      name: 'E-Books',
      icon: Icons.menu_book_outlined,
      color: const Color(0xFFE8F5E9),
      items: [
        ResourceItem(id: 'b1', title: 'Introduction to Algorithms', type: 'PDF', url: '', size: '15 MB'),
        ResourceItem(id: 'b2', title: 'Clean Code', type: 'PDF', url: '', size: '8 MB'),
      ],
    ),
    ResourceCategory(
      id: '4',
      name: 'Lab Manuals',
      icon: Icons.science_outlined,
      color: const Color(0xFFFFF3E0),
      items: [
        ResourceItem(id: 'l1', title: 'Physics Lab Manual', type: 'PDF', url: '', size: '5 MB'),
        ResourceItem(id: 'l2', title: 'Chemistry Lab Manual', type: 'PDF', url: '', size: '4.5 MB'),
      ],
    ),
  ];

  ResourceCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Resources'),
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Categories Horizontal List
          Container(
            color: AppTheme.surfaceColor,
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: 140,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory?.id == category.id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      width: 72,
                      margin: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected ? AppTheme.primaryColor : category.color.withOpacity(0.5),
                              shape: BoxShape.circle,
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppTheme.primaryColor.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : null,
                            ),
                            child: Icon(
                              category.icon,
                              color: isSelected ? Colors.white : AppTheme.textPrimary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category.name,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  fontSize: 11,
                                ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Selected Category Items
          Expanded(
            child: _selectedCategory == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, size: 64, color: AppTheme.textSecondary.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        Text(
                          'Select a category to view resources',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _selectedCategory!.items.length,
                    itemBuilder: (context, index) {
                      final item = _selectedCategory!.items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF0F0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.picture_as_pdf, color: Color(0xFFFF5252)),
                          ),
                          title: Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppTheme.backgroundColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item.type,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item.size,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.download_rounded, color: AppTheme.primaryColor),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Downloading...')),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
