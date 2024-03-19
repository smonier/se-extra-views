document.addEventListener('DOMContentLoaded', function() {
    const currentDate = new Date();
    let currentMonth = currentDate.getMonth();
    let currentYear = currentDate.getFullYear();

    const monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"];

    // Example highlighted dates. You would replace this with your actual dates.
    const highlightedDates = ["2024-03-05", "2024-03-18"];

    function formatDate(year, month, day) {
        return `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
    }

    function generateCalendar(month, year, highlightedDates) {
        const firstDay = new Date(year, month).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        const calendar = document.getElementById('calendar').getElementsByClassName('days')[0];
        calendar.innerHTML = '';

        document.querySelector('.month-year').textContent = `${monthNames[month]} ${year}`;

        let date = 1;
        for (let i = 0; i < 6; i++) {
            const row = document.createElement('div');
            row.className = 'week';
            for (let j = 0; j < 7; j++) {
                if (i === 0 && j < firstDay) {
                    const cell = document.createElement('div');
                    cell.className = 'day';
                    row.appendChild(cell);
                } else if (date > daysInMonth) {
                    break;
                } else {
                    const formattedDate = formatDate(year, month, date);
                    const cell = document.createElement('div');
                    cell.className = 'day';
                    if (highlightedDates.includes(formattedDate)) {
                        const link = document.createElement('a');
                        link.href = `#filter?date=${formattedDate}`; // Modify this URL as needed for filtering
                        link.className = 'highlighted';
                        link.textContent = date;
                        cell.appendChild(link);
                    } else {
                        cell.textContent = date;
                    }
                    row.appendChild(cell);
                    date++;
                }
            }
            calendar.appendChild(row);
            if (date > daysInMonth) {
                break;
            }
        }
    }

    document.querySelector('.prev').addEventListener('click', function() {
        currentYear = (currentMonth === 0) ? currentYear - 1 : currentYear;
        currentMonth = (currentMonth === 0) ? 11 : currentMonth - 1;
        generateCalendar(currentMonth, currentYear, highlightedDates);
    });

    document.querySelector('.next').addEventListener('click', function() {
        currentYear = (currentMonth === 11) ? currentYear + 1 : currentYear;
        currentMonth = (currentMonth === 11) ? 0 : currentMonth + 1;
        generateCalendar(currentMonth, currentYear, highlightedDates);
    });

    generateCalendar(currentMonth, currentYear, highlightedDates);
});