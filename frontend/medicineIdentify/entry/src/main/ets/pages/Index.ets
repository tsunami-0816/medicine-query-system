// 引入包名
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI'


//后端响应数据
interface ResultMap {
  status: boolean,
  message: string;
  list: Medicine[]
};
//药品对象
interface Medicine {
  mid: string,
  mname: string,
  price: number,
  mImage: string
};

// export class routerParam{
//   mid:string = '__NA__';
//
//   constructor(mid:string) {
//     this.mid = mid;
//   }
// }

@Entry
@Component
export struct Index {
  @State medName: string = "";
  @State imgList: Array<string> = ["app.media.banner1", "app.media.banner2", "app.media.banner3"]
  //接收的数据类型
  //{"status":true,"message":"","list":[{"mid":"1","mname":"ss"},{"mid":"2","mname":"ss"}]
  @State resultMap: ResultMap = { status: false, message: "", list: [] };
  //数据模型
  @State medList: Medicine[] = [];
  //自定义对象类型数组(part1)
  // @State medList: Array<Medicine> = [{
  //   mid: "1",
  //   mname: "金嗓子",
  //   price: 10,
  //   mimage: $r("app.media.index")
  // }];
  private swiperController: SwiperController = new SwiperController();
  private textController: TextInputController = new TextInputController();

  build() {
    Column() {
      //轮播图
      Row() {
        Swiper(this.swiperController) {
          ForEach(this.imgList, (item: string) => {
            Image($r(item)).width("100%").height(200)
          }, (item: string) => item)
        }
        .width("100%")
        .height(200)
        .autoPlay(true)
        .interval(8000) //间隔时间
        .loop(true) //循环播放
        .indicatorInteractive(true)
        .duration(5000) //切换时间
        .curve(Curve.Linear)
      }

      //搜索框
      Row() {
        TextInput({ text: this.medName, placeholder: '请输入搜索药品的名字', controller: this.textController })
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .width('68%')
          .height(40)
          .margin({ left: 15 })
          .fontSize(14)
          .fontColor(Color.Black)
          .onChange((value: string) => { // 注意参数类型用小写 string（推荐）
            this.medName = value; // 输入框内容变化时，同步到状态变量
          })


        Button("搜索")
          .margin({ left: 15 })
          .onClick(() => {
            //获取输入药品名称
            let mname = this.medName;
            console.info(mname + "<=this is mname")

            //向后端发送请求，获取数据

            // 每一个httpRequest对应一个HTTP请求任务，不可复用。
            let httpRequest = http.createHttp();

            // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息。
            // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
            // httpRequest.on('headersReceive', (header: Object) => {
            //   console.info('header: ' + JSON.stringify(header));
            // });

            httpRequest.request(// 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定。
              "http://localhost:8082/med/selectMedByName?mname=" + mname,
              {
                method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET。
                // expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型。
                // 开发者根据自身业务需要添加header字段。
                header: { 'Accept': 'application/json' },
                //卡了用下面这两行
                // readTimeout: 60000, // 可选，默认为60000ms。
                // connectTimeout: 60000, // 可选，默认为60000ms。
              },
              (err: BusinessError, data: http.HttpResponse) => {
                if (!err) {
                  //"{"status":true,"message":"","list":[{"mid":"1","mname":"ss"},{"mid":"2","mname":"ss"}]}"
                  this.resultMap = JSON.parse(data.result.toString());
                  console.info((data.result.toString()));
                  if (this.resultMap.status) {
                    this.medList = this.resultMap.list;
                  } else {
                    this.medList = [];
                    console.info(this.resultMap.message)
                  }
                  httpRequest.destroy();
                } else {
                  console.error('error:' + JSON.stringify(err));
                  // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
                  httpRequest.destroy();
                }
              });

            // 无后端测试
            //[{mid:1,mname:"布洛芬",price:19},{mid:2,mname:"芬药",price:19}]
            // this.medList = [{
            //   mid: "1",
            //   mname: "布洛芬",
            //   price: 19,
            //   mimage: $r("app.media.index")
            // }, {
            //   mid: "2",
            //   mname: "芬药",
            //   price: 19,
            //   mimage: $r("app.media.index")
            // }]
          })
      }.width("100%").height(50).margin({ top: 10 })

      //药品简介

      ForEach(this.medList, (med: Medicine) => {
        Row() {
          Column() {
            Image(med.mImage).height(70).objectFit(ImageFit.Contain)
          }.width("30%").height(90).justifyContent(FlexAlign.Center)

          Column() {
            Text("药名" + med.mname)
            Text("单价" + med.price)
          }.width("40%").height(90).justifyContent((FlexAlign.Center))

          Column() {
            Button("详情")
              .onClick(() => {
                //获得当前点击数据的 主键id
                let mid = med.mid;
                console.info(mid)
                //跳转到详情页面
                // router.pushUrl({
                //   url: 'pages/Detail',
                //   params: {
                //     detail: 'message'
                //   }
                // })

                this.getUIContext().getRouter().pushUrl({
                  url: 'pages/Detail',
                  params: {mid:mid}
                },router.RouterMode.Standard)


              })
          }.width("40%").height(90).justifyContent(FlexAlign.Center)
        }
        .width("90%")
        .height(90)
        .margin({ "left": 8, "top": 10 })
        .borderStyle(BorderStyle.Dashed)
        .borderWidth(1)
        .borderColor(0xAFEEEE)
        .borderRadius(5)
      });


    }
  }
}