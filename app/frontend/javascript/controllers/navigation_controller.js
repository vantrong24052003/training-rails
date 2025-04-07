import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mobileMenu", "mobileButton", "dropdownMenu", "dropdownButton"]

  connect() {
    // Add click outside listener for dropdown menu
    document.addEventListener('click', this.handleOutsideClick.bind(this))
    console.log("Navigation controller connected")
  }

  disconnect() {
    // Clean up event listener when controller is disconnected
    document.removeEventListener('click', this.handleOutsideClick.bind(this))
  }

  toggleMobileMenu() {
    this.mobileMenuTarget.classList.toggle('hidden')

    // Update aria-expanded attribute for accessibility
    if (this.hasMobileButtonTarget) {
      const isExpanded = this.mobileButtonTarget.getAttribute('aria-expanded') === 'true'
      this.mobileButtonTarget.setAttribute('aria-expanded', !isExpanded)
    }
    console.log("Mobile menu toggled")
  }

  toggleDropdown(event) {
    event.stopPropagation()
    this.dropdownMenuTarget.classList.toggle('hidden')

    // Update aria-expanded attribute for accessibility
    if (this.hasDropdownButtonTarget) {
      const isExpanded = this.dropdownButtonTarget.getAttribute('aria-expanded') === 'true'
      this.dropdownButtonTarget.setAttribute('aria-expanded', !isExpanded)
    }
    console.log("Dropdown toggled")
  }

  showDropdown() {
    this.dropdownMenuTarget.classList.remove('hidden')
    if (this.hasDropdownButtonTarget) {
      this.dropdownButtonTarget.setAttribute('aria-expanded', 'true')
    }
    console.log("Dropdown shown")
  }

  hideDropdown() {
    // Small delay to allow for better UX during hover interactions
    setTimeout(() => {
      const dropdown = this.element.querySelector('.dropdown')
      if (dropdown && !dropdown.matches(':hover')) {
        this.dropdownMenuTarget.classList.add('hidden')
        if (this.hasDropdownButtonTarget) {
          this.dropdownButtonTarget.setAttribute('aria-expanded', 'false')
        }
      }
    }, 100)
  }

  handleOutsideClick(event) {
    // Skip if dropdown menu is not visible
    if (!this.hasDropdownMenuTarget || this.dropdownMenuTarget.classList.contains('hidden')) {
      return
    }

    // Find the dropdown container
    const dropdown = this.element.querySelector('.dropdown')

    // If dropdown exists and the click is outside it, hide the menu
    if (dropdown && !dropdown.contains(event.target)) {
      this.dropdownMenuTarget.classList.add('hidden')
      if (this.hasDropdownButtonTarget) {
        this.dropdownButtonTarget.setAttribute('aria-expanded', 'false')
      }
    }
  }
}
