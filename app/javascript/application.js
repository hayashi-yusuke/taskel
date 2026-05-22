// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('.check-area').forEach(button => {
    button.addEventListener('click', () => {
      const taskId = button.dataset.taskId
      const circle = document.getElementById('circle-' + taskId)
      circle.classList.add('checked')
      showPraise(taskId)
      shrinkCard(taskId)
    })
  })
})

function showPraise(taskId) {
  const card = document.getElementById('task-' + taskId)
  const rect = card.getBoundingClientRect()
  const praises = ["最高だよ！", "すごい！", "天才すぎる！", "さすが！", "完璧！", "やればできる！", "素晴らしい！"]
  const msg = praises[Math.floor(Math.random() *praises.length)]
  
  const el = document.createElement('div')
  el.id = 'praise-message'
  el.textContent = '🎉 ' + msg
  el.style.cssText = `
  position: fixed;
  top: ${rect.top + rect.height / 2}px;
  left: ${rect.left + rect.width / 2}px;
  transform: translate(-50%, -50%);
  font-size: 20px;
  font-weight: bold;
  background: white;
  padding: 12px 24px;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 9999;
`
document.body.appendChild(el)
}

function shrinkCard(taskId) {
  document.addEventListener('turbo:before-render', (event) => {
    event.preventDefault()  // レンダリングを一時停止

    const card = document.getElementById('task-' + taskId)
    if (!card) {
      event.detail.resume()
      return
    }

    card.style.maxHeight = card.offsetHeight + 'px'
    card.style.overflow = 'hidden'

    requestAnimationFrame(() => {
      card.style.transition = 'all 0.5s ease'
      card.style.maxHeight = '0'
      card.style.opacity = '0'
      card.style.marginBottom = '0'

      // アニメーション完了後にTurboのレンダリングを再開
      card.addEventListener('transitionend', () => {
        // resume直前にpraiseをnewBodyへ移動（消えずに引き継がれる）
        const praiseEl = document.getElementById('praise-message')
        if (praiseEl) praiseEl.remove()
        event.detail.resume()
      }, { once: true })
    })
  }, { once: true })
}

