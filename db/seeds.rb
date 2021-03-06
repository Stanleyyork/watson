# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
pdNeedArray = [
	["Excitement",	"Want to get out there and live life, have upbeat emotions, and want to have fun."],
	["Harmony",	"Appreciate other people, their viewpoints, and their feelings."],
	["Curiosity",	"Have a desire to discover, find out, and grow."],
	["Ideal",	"Desire perfection and a sense of community."],
	["Closeness",	"Relish being connected to family and setting up a home."],
	["Self-expression",	"Enjoy discovering and asserting their own identities."],
	["Liberty",	"Have a desire for fashion and new things, as well as the need for escape."],
	["Love",	"Enjoy social contact, whether one-to-one or one-to-many. Any brand that is involved in bringing people together taps this need."],
	["Practicality",	"Have a desire to get the job done, a desire for skill and efficiency, which can include physical expression and experience."],
	["Stability",	"Seek equivalence in the physical world. They favor the sensible, the tried and tested."],
	["Challenge",	"Have an urge to achieve, to succeed, and to take on challenges."],
	["Structure",	"Exhibit groundedness and a desire to hold things together. They need things to be well organized and under control."]
]

pdValueArray = [
	["Self-transcendence / Helping others",	"Show concern for the welfare and interests of others."],
	["Conservation / Tradition",	"Emphasize self-restriction, order, and resistance to change."],
	["Hedonism / Taking pleasure in life",	"Seek pleasure and sensuous gratification for themselves."],
	["Self-enhancement / Achieving success",	"Seek personal success for themselves."],
	["Openness to change / Excitement",	"Emphasize independent action, thought, and feeling, as well as a readiness for new experiences."]
]

pdBig5Array = [
	[
		["You are more concerned with taking care of yourself than taking time for others.",	"Self-focused",	"Altruism",	"Altruistic",	"You feel fulfilled when helping others and will go out of your way to do so"],
		["You do not shy away from contradicting others.",	"Contrary",	"Cooperation"	,"Accommodating",	"You are easy to please and try to avoid confrontation."],
		["You hold yourself in high regard and are satisfied with who you are."	,"Proud",	"Modesty",	"Modest"	,"You are uncomfortable being the center of attention."],
		["You are comfortable using every trick in the book to get what you want.",	"Compromising",	"Morality"	,"Uncompromising",	"You think it is wrong to take advantage of others to get ahead."],
		["You think people should generally rely more on themselves than on others."	,"Hard-hearted",	"Sympathy",	"Empathetic",	"You feel what others feel and are compassionate toward them."],
		["You are wary of other peoples intentions and do not trust easily."	,"Cautious of others",	"Trust",	"Trusting of others",	"You believe the best of others and trust people easily."]
	],
	[
		["You are content with your level of accomplishment and do not feel the need to set ambitious goals.",	"Content",	"Achievement-striving"	,"Driven"	,"You set high goals for yourself and work hard to achieve them."],
		["You would rather take action immediately than spend time deliberating making a decision.",	"Bold",	"Cautiousness"	,"Deliberate",	"You carefully think through decisions before making them."],
		["You do what you want, disregarding rules and obligations.",	"Carefree"	,"Dutifulness"	,"Dutiful",	"You take rules and obligations seriously, even when they are inconvenient."],
		["You do not make a lot of time for organization in your daily life."	,"Unstructured"	,"Orderliness"	,"Organized"	,"You feel a strong need for structure in your life."],
		["You have a hard time sticking with difficult tasks for a long period of time."	,"Intermittent"	,"Self-discipline",	"Persistent",	"You can tackle and stick with tough tasks."],
		["You frequently doubt your ability to achieve your goals.",	"Self-doubting",	"Self-efficacy",	"Self-assured", "You feel you have the ability to succeed in the tasks you set out to do."]
	],
	[
		["You appreciate a relaxed pace in life.",	"Laid-back"	"Activity level"	,"Energetic"	,"You enjoy a fast-paced, busy schedule with many activities."],
		["You prefer to listen than to talk, especially in group settings."	,"Demure"	,"Assertiveness",	"Assertive",	"You tend to speak up and take charge of situations, and you are comfortable leading groups."],
		["You are generally serious and do not joke much."	,"Solemn"	,"Cheerfulness"	,"Cheerful",	"You are a joyful person and share that joy with the world."],
		["You prefer activities that are quiet, calm, and safe."	,"Calm-seeking"	,"Excitement-seeking"	,"Excitement-seeking",	"You are excited by taking risks and feel bored without lots of action going on."],
		["You are a private person and do not let many people in."	,"Reserved",	"Friendliness",	"Outgoing",	"You make friends easily and feel comfortable around other people."],
		["You have a strong desire to have time to yourself."	,"Independent",	"Gregariousness"	,"Sociable",	"You enjoy being in the company of others."],
	],
	[
		["It takes a lot to get you angry."	,"Mild-tempered"	,"Anger"	,"Fiery",	"You have a fiery temper, especially when things do not go your way."],
		["You tend to feel calm and self-assured."	,"Self-assured",	"Anxiety",	"Prone to worry"	,"You tend to worry about things that might happen."],
		["You are generally comfortable with yourself as you are.",	"Content",	"Depression"	,"Melancholy",	"You think quite often about the things you are unhappy about."],
		["You have control over your desires, which are not particularly intense.",	"Self-controlled",	"Immoderation",	"Hedonistic"	,"You feel your desires strongly and are easily tempted by them."],
		["You are hard to embarrass and are self-confident most of the time.",	"Confident",	"Self-consciousness"	,"Self-conscious"	,"You are sensitive about what others might be thinking of you."],
		["You handle unexpected events calmly and effectively."	,"Calm under pressure",	"Vulnerability"	,"Susceptible to stress",	"You are easily overwhelmed in stressful situations."]
	],
	[
		["You enjoy familiar routines and prefer not to deviate from them."	,"Consistent"	,"Adventurousness",	"Adventurous",	"You are eager to experience new things."],
		["You are less concerned with artistic or creative activities than most people.",	"Unconcerned with art"	,"Artistic interests"	,"Appreciative of art"	,"You enjoy beauty and seek out creative experiences."],
		["You do not frequently think about or openly express your emotions.",	"Dispassionate"	,"Emotionality",	"Emotionally aware",	"You are aware of your feelings and how to express them."],
		["You prefer facts over fantasy."	,"Down-to-earth",	"Imagination",	"Imaginative"	,"You have a wild imagination."],
		["You prefer dealing with the world as it is, rarely considering abstract ideas.",	"Concrete",	"Intellect"	,"Philosophical"	,"You are open to and intrigued by new ideas and love to explore them."],
		["You prefer following with tradition to maintain a sense of stability.",	"Respectful of authority"	,"Liberalism",	"Authority-challenging" ,"You prefer to challenge authority and traditional values to help bring about change."]
	]
]

pddArray = [
	['Helpful, cooperative, considerate, respectful, polite', 'Unpretentious, self-effacing', 'Effervescent, happy, friendly, merry, jovial', 'Soft-hearted, agreeable, obliging, humble, lenient', 'Sentimental, affectionate, sensitive, soft, passionate', 'Generous, pleasant, tolerant, peaceful, flexible', 'Genial, tactful, diplomatic, deep, idealistic', 'Dependent, simple', 'Strict, rigid, stern', 'Inconsiderate, impolite, distrustful, uncooperative, thoughtless', 'Bullheaded, abrupt, crude, combative, rough', 'Cynical, wary of others, reclusive, detached, impersonal', 'Critical, selfish, ill-tempered, antagonistic, grumpy', 'Insensitive, unaffectionate, passionless, unemotional', 'Shrewd, eccentric, individualistic', 'Coarse, tactless, curt, narrow-minded, callous'],
	['Dependable, responsible, reliable, mannerly, considerate', 'Stern, strict, rigid', 'Ambitious, alert, firm, purposeful, competitive', 'Cautious, confident, punctual, formal, thrifty', 'Particular, high-strung', 'Thorough, steady, consistent, self-disciplined, logical', 'Sophisticated, perfectionistic, industrious, dignified, refined', 'Traditional, conventional', 'Unpretentious, self-effacing', 'Rash, uncooperative, unreliable, distrustful, thoughtless', 'Unruly, boisterous, reckless, devil-may-care, demonstrative', 'Indecisive, aimless, wishy-washy, noncommittal, unambitious', 'Scatterbrained, inconsistent, erratic, forgetful, impulsive', 'Informal, low-key', 'Unconventional, quirky', 'Foolhardy, illogical, immature, haphazard, lax'],
	['Social, energetic, enthusiastic, communicative, vibrant', 'Opinionated, forceful, domineering, boastful, bossy', 'Active, competitive, persistent, ambitious, purposeful', 'Boisterous, mischievous, exhibitionistic, gregarious, demonstrative', 'Explosive, wordy, extravagant, volatile, flirtatious', 'Confident, bold, assured, uninhibited, courageous', 'Expressive, candid, dramatic, spontaneous, witty', 'Verbose, unscrupulous, pompous', 'Unaggressive, humble, submissive, timid, compliant', 'Skeptical, wary of others, seclusive, uncommunicative, unsociable', 'Restrained, serious, discreet, cautious, principled', 'Indirect, unenergetic, sluggish, non-persistent, vague', 'Guarded, pessimistic, secretive, cowardly', 'Tranquil, sedate, placid, impartial, unassuming', 'Inner-directed, introspective, meditative, contemplating, self-examining', 'Somber, meek, unadventurous, passive, apathetic'],
	['Emotional, gullible, affectionate, sensitive, soft', 'Temperamental, irritable, quarrelsome, impatient, grumpy', 'Particular, high-strung', 'Compulsive, nosy, self-indulgent, forgetful, impulsive', 'Excitable, wordy, flirtatious, explosive, extravagant', 'Guarded, fretful, insecure, pessimistic, secretive', 'Excitable, passionate, sensual', 'Easily rattled, easily irked, apprehensive', 'Patient, relaxed, undemanding, down-to-earth', 'Unemotional, insensitive, unaffectionate, passionless', 'Rational, objective, steady, logical, decisive', 'Informal, low-key', 'Unself-conscious, weariless, indefatigible', 'Unassuming, unexcitable, placid, tranquil', 'Heartfelt, versatile, creative, intellectual, insightful', 'Imperturbable, insensitive'],
	['Idealistic, diplomatic, deep, tactful, genial', 'Shrewd, eccentric, individualistic', 'Analytical, perceptive, informative, articulate, dignified', 'Unconventional, quirky', 'Worldly, theatrical, eloquent, inquisitive, intense', 'Introspective, meditative, contemplating, self-examining, inner-directed', 'Passionate, excitable, sensual', 'Creative, intellectual, insightful, versatile, inventive', 'Simple, dependent', 'Coarse, tactless, curt, narrow-minded, callous', 'Conventional, traditional', 'Shortsighted, foolhardy, illogical, immature, haphazard', 'Verbose, unscrupulous, pompous', 'Predictable, unimaginative, somber, apathetic, unadventurous', 'Easily rattled, easily irked, apprehensive', 'Imperturbable, insensitive']
]

big5NameArray = ["Agreeableness", "Conscientiousness", "Extraversion", "Emotional Range", "Openness"]
pdBig5DualArray = ["Agreeableness", "Conscientiousness", "Extraversion", "Emotional Range", "Openness"]
y = 0
pddArray.each do |x|
	a = 0
	b = 1
	c = 8
	d = 9
	(0..4).each do |z|
	puts big5NameArray[y]
		if(big5NameArray[y] != pdBig5DualArray[z])
			PersonalityDualDescription.create(category: "Big 5",
				primary_subcategory: big5NameArray[y],
				secondary_subcategory: pdBig5DualArray[z],
				primary_high_secondary_high: x[a], primary_high_secondary_low: x[b],
				primary_low_secondary_high: x[c], primary_low_secondary_low: x[d])
		a += 2
		b += 2
		c += 2
		d += 2
		end
	end
	y += 1
end

pdNeedArray.each do |x|
	PersonalityDescription.create(category: "Need", attribute_name: x[0], high_description: x[1])
end

pdValueArray.each do |x|
	PersonalityDescription.create(category: "Value", attribute_name: x[0], high_description: x[1])
end

counter = 0
pdBig5Array.each do |big5Grouping|
	big5Grouping.each do |x|
		PersonalityDescription.create(category: "Big 5", subcategory: big5NameArray[counter], attribute_name: x[2],
		low_term: x[1], low_description: x[0], high_term: x[3], high_description: x[4])
	end
	counter += 1
end