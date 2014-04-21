function shuffle(o){
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};

function test(){
	var fileref=document.createElement("link");
	fileref.setAttribute("rel", "stylesheet");
	fileref.setAttribute("type", "text/css");
	fileref.setAttribute("href", "/kutfeut/kutfeut.css");
	document.getElementsByTagName("head")[0].appendChild(fileref);
	var img = document.createElement("img");
	img.className = "jumper";
	img.setAttribute("src","/kutfeut/pop.png");
	document.body.appendChild(img);
}
window.addEventListener('load', test, false);
