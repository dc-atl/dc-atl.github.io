function init(questions) {
    const form = document.getElementById('trueFalseForm');
    const submitBtn = form.querySelector('button[type="submit"]');
    const submitBtnHtml = submitBtn.outerHTML;
    submitBtn.remove();
    questions.forEach((q, index) => {
        form.innerHTML += `
            <div class="question">
                <p>${index + 1}. ${q.question}</p>
                <select id="answer${index}" required>
                    <option value="true">True</option>
                    <option value="false">False</option>
                </select>
                <div class="confidence-container">
                    <input type="range" id="confidence${index}" min="50" max="100" value="50" step="10" required>
                    <span id="confidenceValue${index}">50%</span>
                </div>
                <div id="result${index}" class="result-inline"></div>
            </div>
        `;
    });
    form.innerHTML += submitBtnHtml;
    // Then bind all event listeners
    questions.forEach((_, index) => {
        const slider = document.getElementById(`confidence${index}`);
        const display = document.getElementById(`confidenceValue${index}`);
        
        if (slider && display) {
            slider.addEventListener('input', (e) => {
                display.textContent = `${e.target.value}%`;
            });
        }
    });

    form.addEventListener('submit', (e) => {
        e.preventDefault();
        const results = questions.map((q, index) => {
            const answer = document.getElementById(`answer${index}`).value === 'true';
            const confidence = parseInt(document.getElementById(`confidence${index}`).value);
            const result = { question: q.question, answer, confidence, correctAnswer: q.answer };
            
            // Display inline result
            const resultDiv = document.getElementById(`result${index}`);
            const isCorrect = answer === q.answer;
            
            resultDiv.innerHTML = `
                <span class="${isCorrect ? 'correct' : 'incorrect'}">
                    ${isCorrect ? '✓' : '✗'} 
                    ${isCorrect ? 'Correct' : 'Incorrect'}
                </span>
            `;
            
            return result;
        });

        // Still calculate and display overall calibration
        displayTrueFalseResults(results);
    });
}

function calculateCalibrationScore(results) {
    // Group results by confidence level
    const groupedByConfidence = results.reduce((acc, r) => {
        acc[r.confidence] = acc[r.confidence] || [];
        acc[r.confidence].push(r);
        return acc;
    }, {});

    // Calculate calibration for each confidence group
    const groupScores = Object.entries(groupedByConfidence).map(([confidence, group]) => {
        const expectedCorrect = parseInt(confidence) / 100;
        const actualCorrect = group.filter(r => r.answer === r.correctAnswer).length / group.length;
        const deviation = actualCorrect - expectedCorrect;
        
        return {
            confidence: parseInt(confidence),
            groupSize: group.length,
            expectedCorrect,
            actualCorrect,
            deviation,
            weight: group.length / results.length
        };
    });

    // Calculate weighted average deviation
    const weightedDeviation = groupScores.reduce((sum, group) => 
        sum + (group.deviation * group.weight), 0);
    
    // Calculate overall calibration score (0-100)
    const calibrationScore = Math.max(0, 100 - Math.abs(weightedDeviation * 100));

    return {
        correctCount: results.filter(r => r.answer === r.correctAnswer).length,
        calibrationScore,
        groupScores,
        overallBias: weightedDeviation > 0 ? 'Underconfident' : 
                     weightedDeviation < 0 ? 'Overconfident' : 
                     'Well calibrated'
    };
}

function calculateBrierScore(results) {
    if (!results || !results.length) return 0;
    
    const brierTerms = results.map(r => {
        const forecast = r.confidence / 100; // Convert confidence to 0-1 scale
        const outcome = r.answer === r.correctAnswer ? 1 : 0;
        return Math.pow(forecast - outcome, 2);
    });
    
    return brierTerms.reduce((sum, term) => sum + term, 0) / results.length;
}
function displayTrueFalseResults(results) {
    const resultsDiv = document.getElementById('results');
    resultsDiv.style.display = 'block';

    const stats = calculateCalibrationScore(results);
    const brierScore = calculateBrierScore(results);
    
    document.getElementById('correctCount').textContent = stats.correctCount;
    document.getElementById('calibration').textContent = 
        stats.overallBias + ` (${stats.calibrationScore.toFixed(2)}% accurate)`;
    document.getElementById('brierScore').textContent = 
        `Brier Score: ${brierScore.toFixed(3)} (lower is better)`;

    document.getElementById('results').style.display = 'block';
}