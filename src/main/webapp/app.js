/* SmartDesk 2.0 - Global JavaScript */

document.addEventListener("DOMContentLoaded", function () {

    // Auto hide alerts
    setTimeout(function () {
        document.querySelectorAll(".auto-hide").forEach(function (alert) {
            alert.style.transition = "opacity .5s";
            alert.style.opacity = "0";

            setTimeout(function () {
                alert.remove();
            }, 500);
        });
    }, 4000);


    // Animate progress bars
    document.querySelectorAll(".sd-progress-bar").forEach(function (bar) {

        const width = bar.getAttribute("data-width");

        if (width) {
            bar.style.width = "0%";

            setTimeout(function () {
                bar.style.width = width + "%";
            }, 300);
        }
    });


    // Confirmation dialogs
    document.querySelectorAll("[data-confirm]").forEach(function (element) {

        element.addEventListener("click", function (event) {

            const message = element.getAttribute("data-confirm");

            if (!confirm(message)) {
                event.preventDefault();
            }
        });
    });


    // Table search
    document.querySelectorAll("[data-table-search]").forEach(function (input) {

        const tableId = input.getAttribute("data-table-search");
        const table = document.getElementById(tableId);

        if (!table) return;

        input.addEventListener("keyup", function () {

            const value = input.value.toLowerCase();

            table.querySelectorAll("tbody tr").forEach(function (row) {

                row.style.display =
                    row.innerText.toLowerCase().includes(value)
                        ? ""
                        : "none";
            });
        });
    });

});