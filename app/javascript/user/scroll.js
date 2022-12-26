window.onload = function () {
  let flag=document.querySelector('#scroll-inner');
  if (flag){
    var target = document.getElementById('scroll-inner');
    console.log(target.scrollIntoView(false));
  }
};
