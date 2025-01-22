function init(questions) {
    const form = document.getElementById('rangeEstimationForm');
    const submitBtn = form.querySelector('button[type="submit"]');
    const submitBtnHtml = submitBtn.outerHTML;
    submitBtn.remove();

    questions.forEach((q, index) => {
        form.innerHTML += `
            <div class="question">
                <p>${index + 1}. ${q.question}</p>
                <input type="number" id="min${index}" placeholder="Minimum" required>
                <input type="number" id="max${index}" placeholder="Maximum" required>
                <div id="result${index}" class="result-inline"></div>
            </div>
        `;
    });
    form.innerHTML += '<div id="validationMessage" class="validation-error"></div>';
    form.innerHTML += submitBtnHtml;
    document.getElementById('submitBtn').addEventListener('click', (e) => {
        e.preventDefault();

        // Check for empty fields
        const emptyFields = questions.some((_, index) => {
            const min = document.getElementById(`min${index}`).value;
            const max = document.getElementById(`max${index}`).value;
            return !min || !max;
        });

        if (emptyFields) {
            document.getElementById('validationMessage').textContent = 'Please fill in all fields';
            return;
        }

        // Clear validation message if all fields filled
        document.getElementById('validationMessage').textContent = '';

        const results = questions.map((q, index) => {
            const min = parseFloat(document.getElementById(`min${index}`).value);
            const max = parseFloat(document.getElementById(`max${index}`).value);
            const result = { question: q.question, min, max, answer: q.answer };
            
            // Display individual result
            const isCorrect = q.answer >= min && q.answer <= max;
            document.getElementById(`result${index}`).innerHTML = `
                <div class="${isCorrect ? 'correct' : 'incorrect'}">
                    ${isCorrect ? '✓ Correct' : '✗ Incorrect'} 
                    answer: ${q.answer}
                </div>
            `;
            
            return result;
        });
        displayRangeResults(results);
        return false;
    });
}

function displayRangeResults(results) {
    const correctCount = results.filter(r => r.answer >= r.min && r.answer <= r.max).length;
    const calibration = correctCount / results.length;
    document.getElementById('correctCount').textContent = correctCount;
    document.getElementById('calibration').textContent = getCalibrationMessage(calibration, 0.9);
    document.getElementById('results').style.display = 'block';
}

// questions.forEach((q, index) => {  
//     document.getElementById(`min${index}`).value = 0;
//     document.getElementById(`max${index}`).value = 100000;
// });
