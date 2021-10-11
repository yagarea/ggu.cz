currentTheme = "default";

function setTheme(theme) {
	document.body.classList.remove("theme-" + currentTheme);
	document.body.classList.add("theme-" + theme);
	currentTheme = theme;
	localStorage.setItem("theme", theme);
}

document.addEventListener("DOMContentLoaded", function() {
	currentTheme = localStorage.getItem("theme");
	setTheme(currentTheme);

	document.querySelectorAll(".theme-selector a").forEach(function(link) {
		var theme = link.getAttribute("data-theme");
		link.addEventListener("click", function(ev) {
			ev.preventDefault();
			setTheme(theme);
		});
	});
});
