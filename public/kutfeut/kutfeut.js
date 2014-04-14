function isKutFeut(){
	return true;
}

function shuffle(o){
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
};

function askConfirm(event){
	event.preventDefault();
	var questions = [
		["Weet je wel zeker of je dit wil doen?"],
		"Je bent een kutfeut.",
		["Wil je deze actie annuleren?",false]
	];
	shuffle(questions);
	for (var i = 0; i < questions.length; ++i) {
		if(!(
			(typeof questions[i] === 'string' && confirm(questions[i]))
		||	((typeof questions[i] !== 'string') && (
				(questions[i].length == 1 && confirm(questions[i][0]))
			||	(questions[i][1] == confirm(questions[i][0]))
			))
		))return;
	}
	if(i==3){ if(event.target.tagName == 'A') window.location = event.target.href; else event.target.form.submit(); }
}

function test(){
	if(isKutFeut()){
		var fileref=document.createElement("link");
		fileref.setAttribute("rel", "stylesheet");
		fileref.setAttribute("type", "text/css");
		fileref.setAttribute("href", "/kutfeut/kutfeut.css");
		document.getElementsByTagName("head")[0].appendChild(fileref);
		var img = document.createElement("img");
		img.className = "jumper";
		img.setAttribute("src","/kutfeut/pop.png");
		document.body.appendChild(img);
		
		var links = document.querySelectorAll("a,input[type=submit]");
		for (var i = 0; i < links.length; ++i) {
			links[i].addEventListener('click',askConfirm,false);
		}
	}
}
window.addEventListener('load', test, false);
