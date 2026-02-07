import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/domain/repositories/client/home_repository.dart';
import 'package:sukientotapp/features/components/common/blog_card.dart';
import 'package:sukientotapp/features/client/home/widgets/popup_search_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;
  HomeController(this._repository);

  RxList<PartnerCategory> partnerList = <PartnerCategory>[].obs;

  RxList<BlogCard> blogs = <BlogCard>[].obs;

  final isLoading = false.obs;

  RxString avatar = 'https://i.pravatar.cc/150?img=12'.obs;
  RxString name = 'John Doe'.obs;

  @override
  void onInit() {
    super.onInit();

    fetchBlogs(); // fake data
    fetchPartners(); // fake data
  }

  void fetchPartners() {
    ///! this is just for demo purpose
    partnerList.assignAll([
      PartnerCategory(
        id: '1',
        name: 'Chú hề',
        image:
            'https://sukientot.com/storage/uploads/323/conversions/01KDTH87AH1ZEMDZX14THM5XZY-thumb.webp',
        partnerList: [
          PartnerCard(
            id: '1',
            name: 'Chú hề vặn bóng',
            image:
                'https://sukientot.com/storage/uploads/324/conversions/01KDTHT4BF7JJGK0X5G09EA75E-thumb.webp',
          ),
          PartnerCard(
            id: '2',
            name: 'Chú hề hoạt náo',
            image:
                'https://sukientot.com/storage/uploads/325/conversions/01KDTKTWSYPWSCV6JPCHZWSYEK-thumb.webp',
          ),
          PartnerCard(
            id: '3',
            name: 'Chú hề MC',
            image:
                'https://sukientot.com/storage/uploads/326/conversions/01KDTM9NMCN0F87TTVJP27KM45-thumb.webp',
          ),
        ],
      ),
      PartnerCategory(
        id: '2',
        name: 'Ảo thuật gia',
        image:
            'https://sukientot.com/storage/uploads/32/conversions/01KAZKSYMMC5D5V8HKP6AXY5Q0-thumb.webp',
        partnerList: [
          PartnerCard(
            id: '1',
            name: 'Ảo thuật gia sân khấu',
            image:
                'https://sukientot.com/storage/uploads/33/conversions/01KAZMNRVPZF8RSQP0HV6HAV4C-thumb.webp',
          ),
          PartnerCard(
            id: '2',
            name: 'Ảo thuật gia đường phố',
            image:
                'https://sukientot.com/storage/uploads/34/conversions/01KAZN2B7ES4X9ASXKNF14QPYK-thumb.webp',
          ),
          PartnerCard(
            id: '3',
            name: 'Ảo thuật gia hài hước',
            image:
                'https://sukientot.com/storage/uploads/41/conversions/01KAZPKNS1SNP1ZNRZV8B91A77-thumb.webp',
          ),
        ],
      ),
      PartnerCategory(
        id: '3',
        name: 'Xiếc',
        image:
            'https://sukientot.com/storage/uploads/61/conversions/01KBC8Z19H8GXWVW2DFC2W0BK8-thumb.webp',
        partnerList: [
          PartnerCard(
            id: '1',
            name: 'Xiếc nhào lộn',
            image:
                'https://sukientot.com/storage/uploads/60/conversions/01KBC8TP1MGAM7F58Y7MRSPC02-thumb.webp',
          ),
          PartnerCard(
            id: '2',
            name: 'Xiếc tung hứng',
            image:
                'https://sukientot.com/storage/uploads/59/conversions/01KBC8GPSXZJDXTP073SNNMX4E-thumb.webp',
          ),
          PartnerCard(
            id: '3',
            name: 'Xiếc thú',
            image:
                'https://sukientot.com/storage/uploads/56/conversions/01KBC4VWD53J4PM8361K0BT4AQ-thumb.webp',
          ),
        ],
      ),
    ]);
  }

  void fetchBlogs() {
    ///! this is just for demo purpose
    blogs.assignAll([
      BlogCard(
        imageUrl:
            'https://sukientot.com/storage/uploads/950/conversions/01KG4EHMY62X2RQ2KTM5F1F1X3-thumb.webp',
        title: 'Lotteria Hồng Bàng - Chi nhánh lotteria nào gần đây nhất?',
        address: 'Phường Bình Tây, Thành phố Hồ Chí Minh',
        capacity: 50,
        category: 'FAST FOOD',
        tag: '#lotteria',
        date: DateTime.now(),
        onTap: () {
          // open browser
          launchUrl(
            Uri.parse(
              'https://sukientot.com/dia-diem-to-chuc-su-kien/danh-muc/fast-food/lotteria-hong-bang-chi-nhanh-lotteria-nao-gan-day-nhat',
            ),
          );
        },
      ),
      BlogCard(
        imageUrl:
            'https://sukientot.com/storage/uploads/943/conversions/01KG3V7F8C9327WMRC8ATMX3P4-thumb.webp',
        title: 'THUÊ CHÚ HỀ ẢO THUẬT GIA CHUYÊN NGHIỆP',
        address: 'Chú hề',
        capacity: 1,
        category: 'Tổ chức sự kiện',
        tag: '#sinh-nhật',
        date: DateTime.now(),
        onTap: () {
          // open browser
          launchUrl(
            Uri.parse(
              'https://sukientot.com/huong-dan-to-chuc-su-kien/danh-muc/to-chuc-su-kien/thue-chu-he-ao-thuat-gia-chuyen-nghiep',
            ),
          );
        },
      ),
      BlogCard(
        imageUrl:
            'https://sukientot.com/storage/uploads/928/conversions/01KG1YGAXR4AKAPND4Q8Y86KV6-thumb.webp',
        title: 'TỔ CHỨC TIỆC SINH NHẬT, THÔI NÔI, KHAI TRƯƠNG NÊN CHỌN ĐỊA ĐIỂM NÀO?',
        address: 'Địa điểm tổ chức sự kiện',
        capacity: 1,
        category: 'Tổ chức sự kiện',
        tag: '#sự-kiện',
        date: DateTime.now(),
        onTap: () {
          // open browser
          launchUrl(
            Uri.parse(
              'https://sukientot.com/kien-thuc-nghe/danh-muc/kien-thuc/to-chuc-tiec-sinh-nhat-thoi-noi-khai-truong-nen-chon-dia-diem-nao',
            ),
          );
        },
      ),
    ]);
  }

  void openBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
