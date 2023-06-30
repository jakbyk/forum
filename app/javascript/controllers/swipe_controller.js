import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['text'];

    connect() {
        const childElement = this.textTarget;
        console.log(childElement);
        const elementWidth = childElement.offsetWidth;
        childElement.style.setProperty('--element-width', elementWidth + 'px');
    }
}