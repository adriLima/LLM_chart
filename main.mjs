import fs from 'fs';
import OpenAI from "openai";
const openai = new OpenAI();


// Function to encode the image
function encodeImage(imagePath) {
  const imageData = fs.readFileSync(imagePath);
  return Buffer.from(imageData).toString('base64');
}

// Path to your image
const imagePath = './chart.png';

// Getting the base64 string
const base64_Image = encodeImage(imagePath);

async function getChatCompletion() {
  try {
    const response = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": "fait une analyse chartist du graphique, indiquant les figure identifiées, si la structure est bullish, bearish, ou neutral, en indiquant un take_profit et un stop_loss, la réponse doit être entièrement au format JSON sans les balises (```JSON) et (```)"
            },
            {
              "type": "image_url",
              "image_url": {
                "url": `data:image/jpeg;base64,${base64_Image}`
              }
            }
          ]
        }
      ],
    });

    console.log('API Response:', response); // Log the full response
    
    // Access choices directly from the response
    if (response.choices) {
      console.log(response.choices[0]);
    } else {
      console.error('No choices found in the response:', response);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

// Run the function
getChatCompletion();