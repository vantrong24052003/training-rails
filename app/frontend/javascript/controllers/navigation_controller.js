import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdownMenu", "dropdownButton", "mobileMenu", "mobileButton"]

  connect() {
    // Close dropdowns when clicking outside
    document.addEventListener('click', this.closeDropdownOnClickOutside.bind(this))
  }

  disconnect() {
    document.removeEventListener('click', this.closeDropdownOnClickOutside.bind(this))
  }

  toggleDropdown(event) {
    event.stopPropagation()
    this.dropdownMenuTarget.classList.toggle('hidden')
  }

  showDropdown() {
    this.dropdownMenuTarget.classList.remove('hidden')
  }

  hideDropdown() {
    // Using setTimeout to allow click events to complete before hiding
    setTimeout(() => {
      if (!this.element.contains(document.activeElement)) {
        this.dropdownMenuTarget.classList.add('hidden')
      }
    }, 100)
  }

  toggleMobileMenu() {
    this.mobileMenuTarget.classList.toggle('hidden')
  }

  closeDropdownOnClickOutside(event) {
    if (this.hasDropdownMenuTarget && !this.element.contains(event.target)) {
      this.dropdownMenuTarget.classList.add('hidden')
    }
  }

  logout(event) {
    // Any additional logout logic can go here
    // The actual logout happens via the link's data-turbo-method
  }
}
