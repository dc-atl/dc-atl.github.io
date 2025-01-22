function getCalibrationMessage(actual, expected) {
    const difference = actual - expected;
    console.log(difference);
    if (Math.abs(difference) < 0.051) {
        return "Well calibrated";
    } else if (difference > 0) {
        return "Underconfident";
    } else {
        return "Overconfident";
    }
}

document.getElementById('backBtn').addEventListener('click', () => {
    window.location.href = 'index.html';
});