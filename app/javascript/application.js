// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('.check-area').forEach(button => {
    button.addEventListener('click', () => {
      const taskId = button.dataset.taskId
      const circle = document.getElementById('circle-' + taskId)
      circle.classList.add('checked')
      showPraise()
    })
  })
})

function showPraise(button) {
  const praises = ["最高だよ！", "すごい！", "天才すぎる！", "さすが！", "完璧！", "やればできる！", "素晴らしい！"]
  const msg = praises[Math.floor(Math.random() *praises.length)]
  
  const el = document.createElement('div')
  el.id = 'praise-message'
  el.textContent = '🎉 ' + msg
  el.style.cssText = `
  position: fixed;
  top: 20%;
  left: 50%;
  transform: translateX(-50%);
  font-size: 20px;
  font-weight: bold;
  background: white;
  padding: 12px 24px;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 9999;
`
document.body.appendChild(el)

document.addEventListener('turbo:before-render', (e) => {
    e.detail.newBody.appendChild(el)
  }, { once: true })

setTimeout(() => {
  const msg = document.getElementById('praise-message')
  if (msg) msg.remove()
}, 1500)
}
