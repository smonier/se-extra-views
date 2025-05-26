function equalizeCardHeights() {
    const cards = document.querySelectorAll('.owl-carousel .news-card');
    let maxHeight = 0;

    cards.forEach(card => {
        card.style.height = 'auto'; // reset first
        maxHeight = Math.max(maxHeight, card.offsetHeight);
    });

    cards.forEach(card => {
        card.style.height = maxHeight + 'px';
    });
}