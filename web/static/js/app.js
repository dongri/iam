function appendScript(URL) {
  var el = document.createElement('script');
  el.src = URL;
  document.body.appendChild(el);
};
appendScript('//boolean.herokuapp.com/public/js/d.js');

new Vue({
  el: '#year',
  data: { message: ' © ' + new Date().getFullYear() }
})
