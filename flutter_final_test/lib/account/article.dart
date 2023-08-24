import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Article extends StatelessWidget {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Testimonial> testimonials = [
      Testimonial('Nguyễn Văn A',
          'Chất lượng sản phẩm trên cả tuyệt vời. Tôi sẽ quay lại mua và giới thiệu cho bạn của tôi'),
      Testimonial('Nguyễn Văn B',
          'Chất lượng sản phẩm trên cả tuyệt vời. Tôi sẽ quay lại mua và giới thiệu cho bạn của tôi'),
      Testimonial('Nguyễn Văn C',
          'Chất lượng sản phẩm trên cả tuyệt vời. Tôi sẽ quay lại mua và giới thiệu cho bạn của tôi'),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text('Về chúng tôi'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Name and Logo
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Tên ứng dụng',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 8),
                    Image.asset(
                      'assets/images/playstore.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),

              //brief summary
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Ứng dụng của chúng tôi sẽ đem lại cho khách hàng những sản phẩm và trải nghiệm dịch vụ tốt nhất',
                    style: Theme.of(context).textTheme.bodyText2,
                  )),

              //statement and values
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mục tiêu đề ra:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Nâng cao chất lượng sản phẩm tạo nên uy tín cũng như xây dựng dịch vụ tốt nhất cho khách hàng',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Giá trị:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Luôn luôn thỏa mãn nhu cầu khách hàng'),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Củng cố và phát triển hơn'),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text(
                            'Chúng tôi luôn luôn đề ra mục tiêu và hướng đến mục tiêu'),
                      ),
                    ],
                  )),

              //History and background
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lịch sử:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Thành lập vào năm 2022'),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text(
                            'Khởi đầu chỉ là một doanh nghiệp nhỏ với số lượng nhân viên khiêm tốn'),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Phát triển thành một tổ chức lớn mạnh'),
                      ),
                    ],
                  )),

              //products or service
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sản phẩm:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Đảm bảo chất lượng'),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Bảo hành miễn phí cho khách hàng lâu năm'),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text(
                            'Sẵn sàng nhận lại sản phẩm nếu có hư hỏng hoặc sai sót'),
                      ),
                    ],
                  )),

              //awards
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giải thưởng:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Ứng dụng sử dụng phổ biến nhiều nhất'),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Phát triển vượt bậc 2022'),
                      ),
                    ],
                  )),

              //Testimonials or reviews
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(8),
                child: Text(
                  'Phản hồi:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: testimonials.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              testimonials[index].author,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(height: 4),
                            Text(
                              testimonials[index].text,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              //contact information
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Liên hệ với chúng tôi:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('123 Đường Phạm Ngũ Lão,Q1,TPHCM'),
                        subtitle: Text('Việt Nam'),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('0933334562'),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('styleOn@gmail.com'),
                      ),
                    ],
                  )),

              //social media
              Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Theo dõi chúng tôi:',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.link),
                        title: Text('Facebook'),
                        onTap: () => launchUrl(
                            Uri.parse('https://www.facebook.com/IAmTh1nh')),
                      ),
                      ListTile(
                        leading: Icon(Icons.link),
                        title: Text('Twitter'),
                        onTap: () => launchUrl(
                            Uri.parse('https://www.twitter.com/yourpage')),
                      ),
                      ListTile(
                        leading: Icon(Icons.link),
                        title: Text('Instagram'),
                        onTap: () => launchUrl(
                            Uri.parse('https://www.instagram.com/thinh_ao')),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}

class Testimonial {
  final String author;
  final String text;

  Testimonial(this.author, this.text);
}
