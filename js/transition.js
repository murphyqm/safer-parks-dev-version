// Loading interstitial for dashboard transition
document.addEventListener('DOMContentLoaded', function() {
    // Find all dashboard links
    const dashboardLinks = document.querySelectorAll('.dashboard-link');
    
    dashboardLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetUrl = this.getAttribute('href');
            
            // Show loading interstitial
            const interstitial = document.querySelector('.loading-interstitial');
            interstitial.classList.add('active');
            
            // Navigate after short delay
            setTimeout(() => {
                window.location.href = targetUrl;
            }, 600);
        });
    });
});
