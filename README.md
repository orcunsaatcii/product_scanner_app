Proje Adı: Product Scanner

1. Proje Tanıtımı ve Planlama

• Proje Hedefi: 
Kameradan veya galeriden edinilen resimden ürünün isim, fiyat ve 
barkod numarasının algılanarak ekrana yazdırılması

• Kullanılacak Teknolojiler ve Paketler

• Flutter
• Google ML Kit 
• flutter_riverpod
• image_picker
• stylish_bottom_bar
• ionicons
• google_fonts
• flutter_speed_dial

• Proje Planı:

• Geliştirme ortamının kurulması.
• Google ML Kit'in projeye entegrasyonu.
• Gerekli paketlerin projeye entegrasyonu.
• Kamera ve galeri erişimi için gerekli izinlerin alınması ve yapılandırılması.
• ML Kit kullanarak barkod tarama ve metin tanıma fonksiyonlarının 
geliştirilmesi.
• Taranan bilgilerin işlenmesi ve ekranda gösterilmesi.

2. Geliştirme Ortamının Kurulumu ve Yapılandırılması

• Proje dizini oluşturuldu.
• Gerekli paketler pubspec.yaml dosyasına eklendi.
• models, providers, pages, constants klasörleri oluşuturuldu.
• Kamera ve galeri erişim izinleri Android manifest dosyasına eklendi.

3. Google ML Kit Entregrasyonu

• Dökümantasyon İncelenmesi
• Google ML Kit'in barcode scanning ve text recognition özellikleri hakkında 
pub.dev paketlerinin incelenmesi
• Bu paketlerin kullanıldığı github repository incelenmesi

• Barcode Scanning

• Google ML Kit barcode scanning özelliğinin projeye entegrasyonu.
• Kameradan veya galeriden alınan resimlerin taranması için gerekli 
fonksiyonların geliştirilmesi.
• Barkod numarasının okunması ve işlenmesi.

• Text Recognition:

• Google ML Kit text recognition özelliğinin projeye entegrasyonu.
• Resimlerden metin tanıma ve işleme.
• Taranan metinlerin fiyat ve ürün ismi olarak ayrıştırılması.

4. Yapılan Çalışmalar
   
• Sayfaların genel yapısının tutulduğu main_page.dart sayfası oluşturuldu.
• Bu sayfada stylish_bottom_bar paketinden bottom navigation bar tasarımı 
yapılıdı.
• Kameraya ve galeriye erişim sağlanarak resim alma fonksiyonu yazıldı.
• Resim, isim, fiyat ve barkod için provider sınıfları yazıldı.
• Product model sınıfı oluşturuldu.
• Image_provider.dart içerisinde resimi işleyecek olan fonksiyon yazıldı.
• Ana Sayfada göseterilmek üzere product_item.dart tasarımı yapıldı.

5. Karşılaşılan Sorunlar
   
• google_ml_kit_text_recognition paketinden yararlanılarak Text Recognition 
yapmaya kalktığımızda henüz ML kit fiyat ile kilogram yazılarını ayırt edemiyor.
• Taranan metinlerden hangisinin ürünün ismi olduğunun bulunması

6. Geliştirilen Çözümler
   
• Flutterda yerleşik olan RegExp sınıfından yararlanıldı.
• Ürün ismi, fiyatı ve barkod numarası için ayrı ayrı regular expression yazıldı.
• Ürün isimleri genelde büyük harfler ile yazılır ve metinde KG LT gibi ibareler 
geçer.
• Fiyat ile kilogramı ayrıştırmak için ise font büyüklüğü ve aynı zamanda ondalık 
ayarları ile bir RegExp ifadesi yazıldı.
• Google_ml_kit_barcode_scanning paketinin yeterli gelmediği ya da hataya 
düşebileceği durumlar için de bir alternatif regular expression yazıldı.
• Ürün ismi de RegExp sınıfıda ilaveten “YERLİ” ve “ÜRETİM” kelimelerinin 
bulunduğu kabul edilemeyen anahatar kelimeler adlı bir diziden kontrol edilerek 
seçildi.
