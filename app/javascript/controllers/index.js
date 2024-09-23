function calculation() {
  const itemPriceInput = document.getElementById('item-price')
  const addTaxPrice = document.getElementById('add-tax-price')
  const profit = document.getElementById('profit')

  if (itemPriceInput && addTaxPrice && profit) {
    itemPriceInput.addEventListener('input', function() {
      const price = parseInt(this.value)
      if (!isNaN(price)) {
        const feePercentage = 0.1
        const fee = price * feePercentage
        const profitValue = price - fee

        addTaxPrice.textContent = Math.floor(fee)
        profit.textContent = Math.floor(profitValue)
      } else {
        addTaxPrice.textContent = ''
        profit.textContent = ''
      }
    })
  }
}
document.addEventListener("turbo:load", calculation)