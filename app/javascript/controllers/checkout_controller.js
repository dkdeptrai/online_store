import {Controller} from "@hotwired/stimulus";

// Connects to data-controller="checkout"
export default class extends Controller {
	static targets = ["checkoutButton"];

	connect() {
		this.updateButtonState();
	}

	updateButtonState() {
		const currentUrl = window.location.href;
		this.checkoutButtonTarget.disabled = currentUrl.includes("/orders/new");
	}
}

