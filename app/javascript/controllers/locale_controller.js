import {Controller} from "@hotwired/stimulus";

// Connects to data-controller="locale"
export default class extends Controller {

	static targets = ["locale"];

	initialize() {
		this.submitTarget.style.display = "none";
	}
}
