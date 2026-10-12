// export class routerParam {
//   msg: string = '__NA__';
//
//   constructor(msg:string) {
//     this.msg = msg;
//   }
// }

import { router } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

//后端响应数据
interface ResultMap {
  status: boolean,
  message: string;
  list: Medicine[]
  object: Medicine
};
//药品对象
interface Medicine {
  mid: string,
  mname: string,
  price: number,
  valid: number,
  eatNum: string,
  handle: string,
  mImage: string
};

interface ParamObject {
  mid: string
}

@Entry
@Component
export struct Detail {
  //{"status":true,"message":"","list":[{"mid":"1","mname":"ss"},{"mid":"2","mname":"ss"}]
  @State resultMap: ResultMap = {
    status: false,
    message: "",
    list: [],
    object: {
      mid: "",
      mname: "",
      price: 0,
      valid: 0,
      eatNum: "",
      handle: "",
      mImage: ""
    }
  };
  //数据模型
  @State medicine: Medicine = {
    mid: "",
    mname: "",
    price: 0,
    valid: 0,
    eatNum: "",
    handle: "",
    mImage: ""
  };
  @State paramObject: ParamObject = { mid: "" }

  //只要进入此页面，立即执行此函数
  aboutToAppear(): void {
    //获取点击详情的药品id
    //获取Index页面传递的参数router.getParams()，讲参数转化为json字符串后，再转化为鸿蒙对象
    this.paramObject = JSON.parse(JSON.stringify(router.getParams()).toString())
    console.info(this.paramObject.mid)
    //获得药品ID
    let mid = this.paramObject.mid;

    //向后端发送请求，获取数据

    // 每一个httpRequest对应一个HTTP请求任务，不可复用。
    let httpRequest = http.createHttp();

    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息。
    // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
    // httpRequest.on('headersReceive', (header: Object) => {
    //   console.info('header: ' + JSON.stringify(header));
    // });

    httpRequest.request(// 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定。
      "http://localhost:8082/med/selectMedByMid?mid=" + mid,
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET。
        // expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型。
        // 开发者根据自身业务需要添加header字段。
        header: { 'Accept': 'application/json' },
      },
      (err: BusinessError, data: http.HttpResponse) => {
        if (!err) {
          //将后端响应结果data.result，转化为对象格式resultMap
          this.resultMap = JSON.parse(data.result.toString());
          //判断查询状态--成功
          console.info((data.result.toString()));
          if (this.resultMap.status) {
            //将查询结果list，赋值给全局变量medlist
            this.medicine = this.resultMap.object;
          } else {
            // this.medicine = [];
            //提示失败信息
            console.info(this.resultMap.message)
          }
          // JSON.stringify(data.result);
          httpRequest.destroy();
        } else {
          console.error('error:' + JSON.stringify(err));
          // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
          httpRequest.destroy();
        }
      });

  }

  build() {
    Column() {
      // 药品图片区域
      Row() {
        Image(this.medicine.mImage)
          .width('90%')
          .height(280)
          .objectFit(ImageFit.Cover)
          .borderRadius(12)
          .shadow({
            radius: 10,
            color: '#0000001A',
            offsetX: 0,
            offsetY: 4
          })
          .margin({ top: 20 })
      }
      .justifyContent(FlexAlign.Center)

      // 药品信息卡片
      Column() {
        // 药品名称
        Row() {
          Text("药品名称: " + this.medicine.mname)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          // .color('#333333') // 修正为color属性
        }
        .padding({ top: 24, bottom: 8 })

        // 药品单价
        Row() {
          Text("药品单价: ¥" + this.medicine.price)
            .fontSize(18)
          // .color('#E63946') // 修正为color属性
        }
        .padding({ bottom: 8 })

        // 保质期
        Row() {
          Text("保质期: " + this.medicine.valid)
            .fontSize(16)
          // .color('#666666') // 修正为color属性
        }
        .padding({ bottom: 8 })

        // 药品用量
        Row() {
          Text("药品用量: " + this.medicine.eatNum)
            .fontSize(16)
          // .color('#666666') // 修正为color属性
        }
        .padding({ bottom: 8 })

        // 药效
        Row() {
          Text("药效: " + this.medicine.handle)
            .fontSize(16)
            // .color('#666666') // 修正为color属性
            .maxLines(3)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
      }
      .width('90%')
      .padding(20)
      .margin({ top: 20, bottom: 30 })
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({
        radius: 15,
        color: '#00000014',
        offsetX: 0,
        offsetY: 8
      })

      // 操作按钮
      // Button('加入购物车')
      //   .width('90%')
      //   .height(48)
      //   .fontSize(18)
      //   .fontWeight(FontWeight.Medium)
      //   .backgroundColor('#4CAF50')
      //   .color('#FFFFFF') // 按钮文字颜色也使用color属性
      //   .borderRadius(24)
      //   .shadow({ radius: 8, color: '#4CAF5033', offsetX: 0, offsetY: 4 })
      //   .margin({ bottom: 30 })
    }
    .backgroundColor('#F5F7FA')
    .width('100%')
    .height('100%')
  }
}