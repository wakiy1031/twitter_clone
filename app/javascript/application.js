// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener('DOMContentLoaded', function() {
    const inputs = document.querySelectorAll('input');
  
    function handleInputState(input) {
      if (input.value !== "") {
        input.nextElementSibling.classList.add('stay');
      } else {
        input.nextElementSibling.classList.remove('stay');
      }
    }
  
    inputs.forEach(function(input) {
      // ページ読み込み時に既存の値をチェック
      handleInputState(input);
  
      // blur イベントのリスナーを追加
      input.addEventListener('blur', function() {
        handleInputState(input);
      });
    });
  });
  

  document.addEventListener("DOMContentLoaded", function() {
    // 年、月、日のセレクトボックスを取得
    var yearSelect = document.querySelector('#user_birthdate_1i');
    var monthSelect = document.querySelector('#user_birthdate_2i');
    var daySelect = document.querySelector('#user_birthdate_3i');
    
    // プレースホルダーを追加
    var yearPlaceholder = document.createElement('option');
    yearPlaceholder.value = '';
    yearPlaceholder.textContent = '年';
    yearPlaceholder.disabled = true;
    yearPlaceholder.selected = true;
    yearSelect.insertBefore(yearPlaceholder, yearSelect.firstChild);
  
    var monthPlaceholder = document.createElement('option');
    monthPlaceholder.value = '';
    monthPlaceholder.textContent = '月';
    monthPlaceholder.disabled = true;
    monthPlaceholder.selected = true;
    monthSelect.insertBefore(monthPlaceholder, monthSelect.firstChild);
  
    var dayPlaceholder = document.createElement('option');
    dayPlaceholder.value = '';
    dayPlaceholder.textContent = '日';
    dayPlaceholder.disabled = true;
    dayPlaceholder.selected = true;
    daySelect.insertBefore(dayPlaceholder, daySelect.firstChild);
  });
  