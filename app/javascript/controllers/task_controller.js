import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  complete(event) {
    event.preventDefault()

    const card = this.element

    const circle = card.querySelector(".check-circle")

    circle.classList.add("check-circle-active")

    setTimeout(() => {
      card.classList.add("task-disappear")

      card.addEventListener("animationend", () => {
        event.target.closest("form").submit()
      })
    }, 200)
  }
}