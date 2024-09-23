// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

function calculation(){
  const showTheCost = document.getElementById('item-price').addEventListener('input', function(){
    const price = parseInt(this.value)
    const feePercentage = 0.1
    const fee = price * feePercentage
    const profit = price - fee

    document.getElementById('add-tax-price').textContent = Math.floor(fee)
    document.getElementById('profit').textContent = Math.floor(profit)
  })
}


window.addEventListener("load", calculation)