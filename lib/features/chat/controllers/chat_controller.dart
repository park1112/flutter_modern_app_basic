import 'package:get/get.dart';

class ChatController extends GetxController {
  // Chat rooms list
  final chatRooms = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadChatRooms();
  }
  
  void loadChatRooms() {
    // TODO: Load chat rooms from Supabase
    // For now, using mock data
    chatRooms.value = [
      {
        'id': '1',
        'name': '농협하나로마트 서울점',
        'lastMessage': '긴급! 내일 오전 배송 관련 문의드립니다.',
        'time': '방금',
        'unreadCount': 5,
        'isRead': false,
      },
      {
        'id': '2',
        'name': '이마트 강남점',
        'lastMessage': '주문서 확인 부탁드립니다.',
        'time': '오전 11:45',
        'unreadCount': 0,
        'isRead': true,
      },
      {
        'id': '3',
        'name': '홈플러스 잠실점',
        'lastMessage': '신규 상품 문의드립니다.',
        'time': '오후 1:20',
        'unreadCount': 3,
        'isRead': false,
      },
      {
        'id': '4',
        'name': '롯데마트 구로점',
        'lastMessage': '재고 확인 가능하신가요?',
        'time': '어제',
        'unreadCount': 1,
        'isRead': false,
      },
      {
        'id': '5',
        'name': '배송팀',
        'lastMessage': '오늘 배송 완료했습니다.',
        'time': '2일 전',
        'unreadCount': 0,
        'isRead': true,
      },
    ];
  }
  
  void markAsRead(String chatRoomId) {
    final index = chatRooms.indexWhere((room) => room['id'] == chatRoomId);
    if (index != -1) {
      chatRooms[index]['isRead'] = true;
      chatRooms[index]['unreadCount'] = 0;
      chatRooms.refresh();
    }
  }
  
  int getTotalUnreadCount() {
    return chatRooms.fold(0, (sum, room) => sum + (room['unreadCount'] as int));
  }
}
