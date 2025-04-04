import { Controller } from "stimulus"

export default class extends Controller {
  logout(event) {
    event.preventDefault() 

    fetch(this.element.href, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
    }).then(() => {
      window.location.href = "/";
    })
  }
}
