import { Type } from "./Type";
import { Detail } from "./Detail";
import { Index } from "./Index";
import { Person } from "./Person";


@Entry
@Component
struct Main {
  @State fontColor: string = '#182431'; //默认导航文字颜色
  @State selectedFontColor: string = '#007DFF'; //被选中文字的颜色
  @State currentIndex: number = 0;
  @State selectedIndex: number = 0;
  private controller: TabsController = new TabsController();

  @Builder
  tabBuilder(index: number, name: string, navIcon: Resource, selectedIcon: Resource) {
    Column() {
      if (this.selectedIndex == index) {
        Image(selectedIcon).width(50).height(50)
      } else {
        Image(navIcon).width(50).height(50)
      }
      Text(name)
        .fontColor(this.selectedIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.selectedIndex === index ? 500 : 400)
        .lineHeight(22)
      // .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.selectedIndex === index ? 1 : 0)
    }.width('100%')
  }

  build() {
    Column() {

      Tabs({ barPosition: BarPosition.End, index: this.currentIndex, controller: this.controller }) {
        TabContent() {
          Index().width('100%').height('100%')
        }.tabBar(this.tabBuilder(0, '主页', $r("app.media.index"), $r("app.media.indexSelected")))

        TabContent() {
          Type().width('100%').height('100%')
        }.tabBar(this.tabBuilder(1, '类别', $r("app.media.type"), $r("app.media.typeSelected")))

        TabContent() {
          Detail().width('100%').height('100%')
        }.tabBar(this.tabBuilder(2, '详情', $r("app.media.detail"), $r("app.media.detailSelected")))

        TabContent() {
          Person().width('100%').height('100%')
        }.tabBar(this.tabBuilder(3, '个人', $r("app.media.person"), $r("app.media.personSelected")))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth(360)
      .barHeight(70)
      .animationDuration(400)
      .onChange((index: number) => {
        // currentIndex控制TabContent显示页签
        this.currentIndex = index;
        this.selectedIndex = index;
      })
      .width("100%")
      .height("112%")
      .margin({ top: -39 })
      .backgroundColor('#F1F3F5')
    }
    .width("100%").height("100%")
  }
}