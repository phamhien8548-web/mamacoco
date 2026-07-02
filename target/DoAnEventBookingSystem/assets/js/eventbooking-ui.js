(function () {
    const root = document.getElementById("htmlRoot");
    const navbar = document.getElementById("nbar");
    const themeButton = document.getElementById("thbtn");
    const sunIcon = document.getElementById("suni");
    const moonIcon = document.getElementById("mooni");

    function setTheme(isLight) {
        if (!root) return;
        root.classList.toggle("lm", isLight);
        if (sunIcon) sunIcon.style.display = isLight ? "inline" : "none";
        if (moonIcon) moonIcon.style.display = isLight ? "none" : "inline";
        try {
            localStorage.setItem("uefTicketsLightTheme", isLight ? "1" : "0");
        } catch (error) {
            // localStorage can be disabled in strict browser modes.
        }
    }

    try {
        setTheme(localStorage.getItem("uefTicketsLightTheme") === "1");
    } catch (error) {
        setTheme(false);
    }

    if (themeButton) {
        themeButton.addEventListener("click", function () {
            setTheme(!root.classList.contains("lm"));
        });
    }

    function syncNavbar() {
        if (navbar) navbar.classList.toggle("scr", window.scrollY > 24);
    }

    window.addEventListener("scroll", syncNavbar, { passive: true });
    syncNavbar();

    if ("IntersectionObserver" in window) {
        const observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) entry.target.classList.add("in");
            });
        }, { threshold: 0.08, rootMargin: "0px 0px -30px 0px" });

        document.querySelectorAll(".rv, .card, .filter-panel, .admin-surface, .content-panel").forEach(function (element) {
            observer.observe(element);
        });
    } else {
        document.querySelectorAll(".rv").forEach(function (element) {
            element.classList.add("in");
        });
    }
})();
