import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../models/chat_model.dart';
import '../../../core/theme/theme.dart';
import 'chat_detail_screen.dart';
import '../widgets/create_group_dialog.dart';

class ChatRoomsScreen extends StatefulWidget {
  const ChatRoomsScreen({super.key});

  @override
  State<ChatRoomsScreen> createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  // Dummy Data
  final List<ChatRoom> _officialRooms = [
    ChatRoom(
      id: '1',
      name: 'CS 3rd Year - Batch 2021',
      description: 'Official group for Computer Science 3rd year students',
      isOfficial: true,
      memberCount: 65,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 10)),
      lastMessage: 'Assignment submission deadline extended',
      hasUnread: true,
    ),
    ChatRoom(
      id: '2',
      name: 'Data Structures & Algorithms',
      description: 'Course group for DSA - Dr. Priya Mehta',
      isOfficial: true,
      memberCount: 68,
      lastActivity: DateTime.now().subtract(const Duration(hours: 2)),
      lastMessage: 'Practice problems uploaded in resources',
    ),
    ChatRoom(
      id: '3',
      name: 'CS Department - All Years',
      description: 'Official CS department announcements',
      isOfficial: true,
      memberCount: 280,
      lastActivity: DateTime.now().subtract(const Duration(days: 1)),
      lastMessage: 'Internship opportunities posted',
    ),
  ];

  final List<ChatRoom> _unofficialRooms = [
    ChatRoom(
      id: '4',
      name: 'Study Group - Finals 2024',
      description: 'Collaborative study sessions for finals',
      isOfficial: false,
      memberCount: 12,
      lastActivity: DateTime.now().subtract(const Duration(minutes: 5)),
      lastMessage: 'Meeting at library tomorrow 3pm',
      hasUnread: true,
    ),
    ChatRoom(
      id: '5',
      name: 'Project Team - ML',
      description: 'Machine Learning project collaboration',
      isOfficial: false,
      memberCount: 5,
      lastActivity: DateTime.now().subtract(const Duration(hours: 5)),
      lastMessage: 'Code review scheduled for Monday',
    ),
    ChatRoom(
      id: '6',
      name: 'Coding Club Community',
      description: 'Discussion for coding enthusiasts',
      isOfficial: false,
      memberCount: 150,
      lastActivity: DateTime.now().subtract(const Duration(days: 2)),
      lastMessage: 'Hackathon registration link',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Rooms'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search rooms or profiles...',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: AppTheme.textPrimary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppTheme.primaryColor,
                ),
                dividerColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                tabs: const [
                  Tab(text: 'Official Rooms'),
                  Tab(text: 'Unofficial Rooms'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRoomList(_officialRooms),
          _buildRoomList(_unofficialRooms),
        ],
      ),
      floatingActionButton: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return authProvider.isFaculty
              ? FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CreateGroupDialog(),
                    );
                  },
                  backgroundColor: AppTheme.primaryColor,
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRoomList(List<ChatRoom> rooms) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return _ChatRoomCard(room: room);
      },
    );
  }
}

class _ChatRoomCard extends StatelessWidget {
  final ChatRoom room;

  const _ChatRoomCard({required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(room: room),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            room.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (room.isOfficial)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Official',
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (room.hasUnread)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.errorColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                room.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.people_outline, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    '${room.memberCount} members',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    room.timeAgo, // Assuming date is formatted
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                room.lastMessage,
                style: TextStyle(
                  color: room.hasUnread ? AppTheme.textPrimary : AppTheme.textSecondary,
                  fontWeight: room.hasUnread ? FontWeight.w600 : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
