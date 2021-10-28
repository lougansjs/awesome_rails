import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.element.remove()
    if (this.data.get("type") === "notice") {
      iziToast.success({ message: this.data.get("message"), title: "Sucesso", position: "bottomRight" })
    } else if (this.data.get("type") === "alert") {
      iziToast.error({ message: this.data.get("message"), title: "Erro", position: "bottomRight" })
    } else {
      iziToast.info({ message: this.data.get("message"), title: "Alerta", position: "bottomRight" })
    }
  }

}
