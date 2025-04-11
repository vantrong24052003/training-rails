import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdownMenu", "reportModal", "reportForm", "reportPostId"]

  connect() {
    // Add a click event listener to the document to close dropdowns when clicking outside
    this.clickOutsideHandler = this.closeDropdownsOnClickOutside.bind(this)
    document.addEventListener('click', this.clickOutsideHandler)
  }

  disconnect() {
    // Clean up event listener when controller disconnects
    document.removeEventListener('click', this.clickOutsideHandler)
  }

  toggleDropdown(event) {
    // Find the closest dropdown menu to the clicked button
    const menu = event.currentTarget.nextElementSibling
    menu.classList.toggle('hidden')

    // Prevent the click from propagating to the document
    event.stopPropagation()
  }

  closeDropdownsOnClickOutside(event) {
    // Close all dropdowns if clicking outside a dropdown button
    const isDropdownButton = event.target.closest('[data-action*="post#toggleDropdown"]')
    if (!isDropdownButton) {
      this.dropdownMenuTargets.forEach(menu => {
        if (!menu.classList.contains('hidden')) {
          menu.classList.add('hidden')
        }
      })
    }
  }

  closeReportModal() {
    if (this.hasReportModalTarget) {
      this.reportModalTarget.classList.add('hidden')
    }
  }
}
