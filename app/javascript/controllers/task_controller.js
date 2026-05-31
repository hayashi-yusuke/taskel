import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  complete(event) {
    event.preventDefault()

    const card = this.element

    // チェックサークルの要素をidで取得する
    // event.target = 押されたボタン(form)の中のcheck-circle要素
    const circle = card.querySelector(".check-circle")

    // ① まずチェックサークルを緑に変える
    circle.classList.add("check-circle-active")

    // ② 少し間を置いてからタスクカードを消す
    // setTimeout = 指定したミリ秒後に処理を実行する
    // 200 = 0.2秒後（サークルが緑になりきったタイミング）
    setTimeout(() => {
      card.classList.add("task-disappear")

      // ③ 消えるアニメーションが終わったらサーバーに送信
      card.addEventListener("animationend", () => {
        event.target.closest("form").submit()
      })
    }, 200)
  }
}