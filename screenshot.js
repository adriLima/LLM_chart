const puppeteer = require('puppeteer');
const axios = require('axios');

function delay(time) {
   return new Promise(function(resolve) {
       setTimeout(resolve, time)
   });
};

const takeScreenshot = async (url) => {
    const browser = await puppeteer.launch({ executablePath: '/bin/chromium',
    args:['--no-sandbox','--disable-setuid-sandbox'],
    headless: true });
    const page = await browser.newPage();
    await page.setViewport({ width: 1000, height: 600 });
    await page.goto(url,{timeout: 0});
//    const element = await page.$('#div.h-full:nth-child(3)>div:nth-child(1)');
//    await element.screenshot({ encoding:'base64' });
//    await delay(2);
    const screenshot = await page.screenshot({ encoding: 'base64' });
    await browser.close();
//    return element;
   return screenshot;
};

const sendToOpenAI = async (screenshot, prompt) => {
    const apiKey = 'YOUR_OPENAI_API_KEY'; // Replace with your OpenAI API key

    const response = await axios.post('https://api.openai.com/v1/chat/completions', {
        model: 'gpt-3.5-turbo',
        messages: [
            { role: 'user', content: prompt },
            { role: 'user', content: 'Here is the screenshot: ${screenshot}' }
        ]
    }, {
        headers: {
            'Authorization': 'Bearer ${apiKey}',
            'Content-Type': 'application/json'
        }
    });

    return response.data;
};

const main = async (url, prompt) => {
    try {
        const screenshot = await takeScreenshot(url);
	console.log(screenshot);
        //const response = await sendToOpenAI(screenshot, prompt);
        //console.log(JSON.stringify(response, null, 2));
    } catch (error) {
        console.error('Error:', error);
    }
};

const url = process.argv[2];
const prompt = process.argv[3];

if (!url || !prompt) {
    console.error('Please provide a URL and a prompt.');
    process.exit(1);
}

main(url, prompt);
