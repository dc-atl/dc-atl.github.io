require 'erb'
require 'json'
range_questions = [
    [
        { question: "What is the wingspan of a Boeing 747 (in meters)?", answer: 64 },
        { question: "What is the average depth of the Mediterranean Sea (in meters)?", answer: 1500 },
        { question: "How many heart beats does a human heart beat per day on average?", answer: 100000 },
        { question: "What is the distance from Earth to Mars at its closest point (in million km)?", answer: 55 },
        { question: "How many species of birds exist worldwide?", answer: 10000 },
        { question: "What is the speed of the Earth's rotation at the equator (in km/h)?", answer: 1670 },
        { question: "How many languages are currently spoken in the world?", answer: 7151 },
        { question: "What is the average lifespan of a giant tortoise (in years)?", answer: 150 },
        { question: "How deep is the deepest part of the ocean (in meters)?", answer: 11034 },
        { question: "What percentage of Earth's surface is covered by forests?", answer: 31 },
        { question: "How many breaths does an average person take per day?", answer: 20000 },
        { question: "What is the average length of a blue whale (in meters)?", answer: 24 },
        { question: "How many neurons are in the human brain (in billions)?", answer: 86 },
        { question: "What is the height of the tallest tree ever recorded (in meters)?", answer: 116 },
        { question: "How many satellites are currently orbiting Earth?", answer: 4500 },
        { question: "What is the average running speed of a cheetah (in km/h)?", answer: 93 },
        { question: "How many islands make up Indonesia?", answer: 17500 },
        { question: "What is the total length of blood vessels in the human body (in km)?", answer: 100000 },
        { question: "How many earthquakes occur worldwide per year on average?", answer: 500000 },
        { question: "What is the maximum recorded temperature on Earth (in °C)?", answer: 56 }
    ],
    [
        { question: "What is the maximum dive depth of a sperm whale (in meters)?", answer: 2800 },
        { question: "How many bones are in a giraffe's neck?", answer: 7 },
        { question: "What is the speed of the fastest recorded tennis serve (in km/h)?", answer: 263 },
        { question: "How many teeth does an adult hedgehog have?", answer: 44 },
        { question: "What is the thickness of the Earth's crust at its thickest point (in km)?", answer: 70 },
        { question: "How many chromosomes does a potato have?", answer: 48 },
        { question: "What is the lifespan of a red blood cell (in days)?", answer: 120 },
        { question: "How many muscles are in a cat's ear?", answer: 32 },
        { question: "What is the wingspan of the largest butterfly species (in cm)?", answer: 30 },
        { question: "How many times does a hummingbird's heart beat per minute?", answer: 1260 },
        { question: "What is the air speed of a sneezing human (in km/h)?", answer: 160 },
        { question: "How many individual lenses does a dragonfly's eye have?", answer: 30000 },
        { question: "What is the length of the smallest known dinosaur (in cm)?", answer: 28 },
        { question: "How many taste buds does the average human tongue have?", answer: 10000 },
        { question: "What is the maximum recorded age of a jellyfish (in years)?", answer: 4500 },
        { question: "How many different sounds can a crow make?", answer: 250 },
        { question: "What is the temperature at the center of a lightning bolt (in °C)?", answer: 27700 },
        { question: "How many rings are in the trunk of the oldest known tree?", answer: 5067 },
        { question: "What is the depth of the deepest cave on Earth (in meters)?", answer: 2212 },
        { question: "How many times does a honey bee's wing beat per second?", answer: 200 }
    ],
    [
        { question: "What is the weight of the heaviest meteorite ever found (in tons)?", answer: 66 },
        { question: "How many keys are on a standard grand piano?", answer: 88 },
        { question: "What is the length of an ant's life span (in days)?", answer: 90 },
        { question: "What is the speed of the fastest recorded bird (in km/h)?", answer: 389 },
        { question: "How many pyramids are there in Egypt?", answer: 138 },
        { question: "What is the maximum depth a penguin can dive (in meters)?", answer: 565 },
        { question: "How many muscles are in an elephant's trunk?", answer: 40000 },
        { question: "What is the age of the oldest known living tree (in years)?", answer: 5067 },
        { question: "What is the speed of sound in water (in meters per second)?", answer: 1480 },
        { question: "How many leaves does an average mature birch tree have?", answer: 200000 },
        { question: "What is the thickness of a soap bubble (in nanometers)?", answer: 700 },
        { question: "How many words are in the first edition of Oxford English Dictionary?", answer: 252000 },
        { question: "What is the temperature inside a bolt of lightning (in degrees Celsius)?", answer: 27700 },
        { question: "How many kilometers of blood vessels are in the human brain?", answer: 160000 },
        { question: "What is the length of the Great Wall of China (in kilometers)?", answer: 21196 },
        { question: "How many bones does a shark have?", answer: 0 },
        { question: "What is the lifespan of a worker bee (in days)?", answer: 40 },
        { question: "How many times does a woodpecker peck per second?", answer: 20 },
        { question: "What is the air pressure at the bottom of the Mariana Trench (in atmospheres)?", answer: 1086 },
        { question: "How many hours of sleep does a koala get per day?", answer: 22 }
    ]
]

range_questions.each_with_index do |questions, set|
    # Define the context for the templates
    @title = "Range Estimation - Set #{set+1}"
    @form_id = 'rangeEstimationForm'
    @script = 'range'
    @questions = questions

    # Read and render the layout template
    layout_template = File.read('templates/layout.erb')

    # Render the content template within the layout
    renderer = ERB.new(layout_template)
    @content = @questions.to_json
    @type = 'range'

    # Output the final HTML
    File.open("range_estimation#{set+1}.html", 'w') do |file|
        file.write(renderer.result(binding))
    end
end

true_false_questions = [
    [
        { question: "Neutrinos can pass through a light-year of lead without being stopped.", answer: true },
        { question: "The Australian parliament building legally allows citizens to graze sheep on its lawn.", answer: true },
        { question: "Ancient Egyptians used spiders as an early form of antibiotics.", answer: false },
        { question: "Neptune's winds can reach speeds of up to 2,100 km/hour.", answer: true },
        { question: "The first digital photograph was taken in 1957.", answer: false },
        { question: "Butterflies can taste with their feet.", answer: true },
        { question: "The ancient Romans used dolphin blood as hair dye.", answer: false },
        { question: "The Mars rover Opportunity's last words were 'My battery is low and it's getting dark.'", answer: false },
        { question: "Medieval knights had a special sword movement to text message in battle.", answer: false },
        { question: "Some species of squid can edit their own genetic code.", answer: true },
        { question: "Ancient Vikings used crushed crystals for navigation on cloudy days.", answer: true },
        { question: "The world's deepest postbox is located 10 meters underwater in Japan.", answer: true },
        { question: "Honey found in Egyptian tombs is still edible after 3000 years.", answer: true },
        { question: "The Aztecs used hummingbird beaks as currency.", answer: false },
        { question: "Lightning creates plasma hot enough to fuse atoms in the air.", answer: true },
        { question: "Medieval castle stairs were built clockwise to favor left-handed defenders.", answer: false },
        { question: "Ancient Chinese astronomers recorded supernovas 2000 years before Europeans.", answer: true },
        { question: "The Incas performed successful brain surgery using golden instruments.", answer: false },
        { question: "Some deep-sea creatures use quantum mechanics for navigation.", answer: false },
        { question: "Wombats are the only animals that produce cube-shaped droppings.", answer: true }
    ],
    [
        { question: "The first submarine was built in 1776 and was called the 'Turtle'.", answer: true },
        { question: "Some species of bamboo can grow up to two meters in a single day.", answer: true },
        { question: "Ancient Romans used flamingo tongues as a delicacy at noble feasts.", answer: true },
        { question: "The Sahara Desert was once home to a species of crocodile that climbed trees.", answer: false },
        { question: "There's a species of jellyfish that reverts to its juvenile form when stressed.", answer: true },
        { question: "The ancient Greeks had a mechanical computer for predicting astronomical events.", answer: true },
        { question: "Vikings used the crystallized remains of starfish for navigation.", answer: false },
        { question: "There's a type of shark that can survive being completely frozen.", answer: false },
        { question: "The first digital computer was powered by water instead of electricity.", answer: true },
        { question: "Some species of fungi can create zombie ants to spread their spores.", answer: true },
        { question: "Ancient Mayans used chocolate beans as currency.", answer: true },
        { question: "The Great Wall of China contains sticky rice in its mortar.", answer: true },
        { question: "Medieval knights had specialized armor for fighting left-handed opponents.", answer: false },
        { question: "There's a species of octopus that can survive on land for up to 30 minutes.", answer: true },
        { question: "The first photograph ever taken took 8 hours of exposure time.", answer: true },
        { question: "Ancient Egyptians used electric eels for pain relief therapy.", answer: false },
        { question: "Some species of sea cucumber can liquefy themselves when threatened.", answer: true },
        { question: "The Romans had a special gladiator class that fought exclusively at night.", answer: false },
        { question: "There's a type of desert plant that can survive 100 years without water.", answer: true },
        { question: "Ancient Chinese astronomers recorded a supernova that created the Crab Nebula.", answer: true }
    ],
    [
        { question: "Ancient Spartans used heated metal plates as primitive night vision devices.", answer: false },
        { question: "There's a species of moth that drinks the tears of sleeping birds.", answer: true },
        { question: "The Aztecs created floating gardens that could be moved during floods.", answer: true },
        { question: "Medieval Japanese samurai carried specialized arrows that could whistle different notes.", answer: false },
        { question: "Some species of desert lizards can shoot blood from their eyes as a defense mechanism.", answer: true },
        { question: "Vikings used crystallized honey as emergency surgical sutures.", answer: false },
        { question: "The ancient Chinese invented a form of ice cream 3000 years ago.", answer: true },
        { question: "Roman gladiators had a special prayer room under the Colosseum with underwater windows.", answer: false },
        { question: "There's a cave in Mexico with crystals larger than school buses.", answer: true },
        { question: "Ancient Egyptians used magnetic stones to reduce pain during mummification.", answer: false },
        { question: "The Incas performed successful corneal transplants using thin sheets of gold.", answer: false },
        { question: "Some deep sea creatures can see using electricity instead of light.", answer: true },
        { question: "Ancient Persians developed a primitive form of air conditioning using wind towers.", answer: true },
        { question: "The Greeks had mechanical owls that could turn their heads to track the sun.", answer: false },
        { question: "Native Americans used hummingbird beaks as ceremonial needles.", answer: false },
        { question: "Medieval European castles had specific rooms designed to amplify whispers.", answer: true },
        { question: "Ancient Chinese astronomers wore special metallic hats to detect meteor showers.", answer: false },
        { question: "The Mayans invented rubber-soled shoes for their ball game players.", answer: false },
        { question: "Medieval monks created ink that could change color based on temperature.", answer: false },
        { question: "Some species of bamboo flowers only once every 130 years.", answer: true }
    ]
]
true_false_questions.each_with_index do |questions, set|
    # Define the context for the templates
    @title = "True/False Calibration - Set #{set+1}"
    @form_id = 'trueFalseForm'
    @script = 'trueFalse'
    @questions = questions

    # Read and render the layout template
    layout_template = File.read('templates/layout.erb')

    # Render the content template within the layout
    renderer = ERB.new(layout_template)
    @content = @questions.to_json
    @type = 'trueFalse'

    # Output the final HTML
    File.open("true_false#{set+1}.html", 'w') do |file|
        file.write(renderer.result(binding))
    end
end