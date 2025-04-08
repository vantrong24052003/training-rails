import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = []

  connect() {
    console.log("Auth controller connected")
  }

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

  // Flash message fade out
  fadeOutFlash() {
    const flashMessages = document.querySelectorAll('.rounded-md.bg-green-50, .rounded-md.bg-red-50')

    flashMessages.forEach(message => {
      setTimeout(() => {
        message.style.transition = 'opacity 0.5s ease'
        message.style.opacity = '0'

        setTimeout(() => {
          message.remove()
        }, 500)
      }, 3000)
    })
  }

  // Form validation
  validateForm(event) {
    const form = event.currentTarget
    let isValid = true

    // Example validation logic - customize based on your needs
    const requiredFields = form.querySelectorAll('[required]')
    requiredFields.forEach(field => {
      if (!field.value.trim()) {
        this.showFieldError(field, 'This field is required')
        isValid = false
      } else {
        this.clearFieldError(field)
      }
    })

    // Email validation
    const emailField = form.querySelector('input[type="email"]')
    if (emailField && emailField.value.trim() && !this.isValidEmail(emailField.value)) {
      this.showFieldError(emailField, 'Please enter a valid email address')
      isValid = false
    }

    // Password validation for sign up
    const passwordField = form.querySelector('input[name="user[password]"]')
    const passwordConfirmField = form.querySelector('input[name="user[password_confirmation]"]')

    if (passwordField && passwordConfirmField &&
        passwordField.value && passwordConfirmField.value &&
        passwordField.value !== passwordConfirmField.value) {
      this.showFieldError(passwordConfirmField, 'Passwords do not match')
      isValid = false
    }

    if (!isValid) {
      event.preventDefault()
    }
  }

  isValidEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    return re.test(email)
  }

  showFieldError(field, message) {
    // Clear any existing error
    this.clearFieldError(field)

    // Add error styling
    field.classList.add('border-red-500', 'focus:ring-red-500', 'focus:border-red-500')

    // Create and insert error message
    const errorDiv = document.createElement('div')
    errorDiv.className = 'text-red-500.text-xs.mt-1'
    errorDiv.textContent = message
    field.parentNode.appendChild(errorDiv)
  }

  clearFieldError(field) {
    field.classList.remove('border-red-500', 'focus:ring-red-500', 'focus:border-red-500')

    const errorDiv = field.parentNode.querySelector('.text-red-500.text-xs')
    if (errorDiv) {
      errorDiv.remove()
    }
  }
}
