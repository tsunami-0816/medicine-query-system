@Entry
  //定义为入口文件
@Component
struct Test {
  //1.变量
  @State name: string = "alan";
  @State num: number = 19;
  @State numList: Array<string> = ["freedom", "enemy"];
  @State numList1: Array<number> = [111,222];

  //2.视图 (页面展示）
  build() {
    Column() {
      Row() {
        Text(this.name).fontSize(30);
      }

      Row() {
        if (this.num >= 18) {
          Text(this.name + "is free").fontSize(30);
        } else {
          Text(this.name + "is slave of freedom").fontSize(30);
        }
      }

      Row() {
        ForEach(this.numList, (item: string) => {
          Text(item).fontSize(40);
        })
      }
      Row() {
        ForEach(this.numList1, (item: number) => {
          Text(item+"").fontSize(40);
        })
      }
    }

  }
}