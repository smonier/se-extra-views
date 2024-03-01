function generateInteractiveCalendar(url, calendarId,nbDate,language) {
    const calendarEl = document.getElementById(calendarId);
    if (!calendarEl) {
        console.error('Calendar element not found');
        return;
    }

    const now = new Date();

    // Function to generate the calendar with a special block at the beginning
    generateCalendar(now);

    function generateCalendar(startDate) {
        // Clear previous calendar
        calendarEl.innerHTML = '';

        // Create and append the special block for "All dates"
        const allDatesEl = document.createElement('div');
        allDatesEl.classList.add('day');
        if (language.startsWith('fr')) {
            allDatesEl.textContent = "Toutes les dates";
        } else {
            allDatesEl.textContent = "All dates";
        }
        allDatesEl.addEventListener('click', function() {
            window.location.href = url; // Redirect to the URL without parameters
        });
        calendarEl.appendChild(allDatesEl);

        // Generate days for the next 15 days
        for (let i = 0; i < nbDate; i++) {
            const dayDate = new Date(startDate);
            dayDate.setDate(startDate.getDate() + i);

            const dayEl = document.createElement('div');
            dayEl.classList.add('day');
            const options = { weekday: 'short', month: 'short', day: 'numeric' };
            dayEl.textContent = dayDate.toLocaleDateString(language, options);

            dayEl.addEventListener('click', function() {
                const dateClicked = dayDate.toISOString().substring(0, 10); // YYYY-MM-DD format
                const formattedDate = formatDateForSQL(dateClicked); // Assume this formats correctly for SQL
                window.location.href = `${url}?date=${encodeURIComponent(formattedDate)}`; // Use the provided URL with date
            });

            calendarEl.appendChild(dayEl);
        }
    }
}


  function formatDateForSQL(dateString) {
    // Parse the input date string into a Date object assuming the date is in UTC
    const date = new Date(dateString + 'T00:00:00Z');

    // Construct the formatted string in 'YYYY-MM-DD HH:MM:SS' format
    const formattedDate = 
        date.getUTCFullYear() + '-' + 
        String(date.getUTCMonth() + 1).padStart(2, '0') + '-' + 
        String(date.getUTCDate()).padStart(2, '0') + ' ' +
        '00:00:00'; // Static time portion

    return formattedDate;
}
