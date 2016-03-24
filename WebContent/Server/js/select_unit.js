/**
 * 该文件用于控制单位选择输入和选择，
 */

function changeF() {
  document.getElementById('txt').value = document.getElementById('sel').options[document.getElementById('sel').selectedIndex].value;
} 