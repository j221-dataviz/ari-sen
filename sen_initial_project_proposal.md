<h1 style="text-align: center;">State School or Surveillance State?</h1>
<h3 style="text-align: center;"> A proposal to examine social media monitoring technology's proliferation on college campuses</h3>

<b><u>Introduction</u></b>

Across the country millions of students are returning to campuses or setting foot on them for the very first time. This new period in students’ lives brings lots of emotions — excitement and anxiety, fear and joy, connection and loneliness. 

For the past decade many have turned to social media accounts to express these feelings to their circle of friends, family and peers. But this trusted group may not be the only ones watching — across the country dozens of colleges have purchased a technology called Social Sentinel, in what they say is an attempt to keep the worst from happening.

<b><u>Background</u></b>

Social Sentinel is a service sold to schools which scans social media messages which tries to detect threats of violence or self-harm. The company has said in the past that it scans more than a billion posts on social media every day against more than 450,000 words and phrases in its “Language of Harm.” 

The service started its life as Campus Sentinel, an app which tracked crime statistics for campuses across the country. The app was created by Gary Margolis and Steven Healy, two former campus police chiefs who formed a security consulting company together in 2008. Sometime in late 2014, the two men shifted the app's purpose away from crime stats and towards social media monitoring, rebranding it “Social Sentinel.” 

So far as we can tell from the company's patents, documents I've obtained and news articles, Social Sentinel’s system consists of two (or perhaps three) pieces: 
<ol>
	<li>An AI system that detects potentially threatening messages posted to social media</li>
	<li>Keywords inputted by the school which connect a given threatening post to a client college. This may or may not be the same as the “Local+” list, which, according to the company, which allows client schools to input keywords related to “assets of interest.” </li>
</ol>
   
When a message is determined to contain threatening information, authorized users receive an email alert that looks something like this (sans the highlights):

![](https://lh6.googleusercontent.com/jjsUA_oo0rDmATgYBB0GGhUK21uZ2DFHHt3kVkJ80Zp9bTrU3_Wp79CIPnYy-SfJ_Rlpno-Wag844QV7ec4aHYOwa1rCnCsj-v6VzKHLvAYlHo2EmdbvqnAGFwY8Jx-Z3DJLPio=s0)

According to data from GovSpend, an organization that tracks state and local government spending, and other records I've obtained, Social Sentinel has been used by at least 37 colleges in the past six years, 32 of which are public. This number is quite small when compared to the hundreds of K12 school districts which have used the service over the same time period, but not insignificant. Some of the country’s largest and most well-known colleges have used Social Sentinel, including UNC-Chapel Hill, the University of Virginia, Michigan State University, MIT and Arizona State University. 

Perhaps because of their comparatively lower numbers, very little attention has been paid to college campuses that use this technology. But, in my view, this is a mistake I hope to address with this story. 

Unlike at the K12 level, where alerts are often sent to mental health counselors or school administrators, at the college level Social Sentinel’s alerts are typically sent to campus police officers. This is interesting for two reasons.

The first is, unlike regular police which answer to a chief which answers to a mayor or city council, campus police are essentially totally accountable to the population they serve. A college student usually gets no vote on who the chancellor or president of their university will be, nor can they usually argue against a police action before it takes place. 

 The second is that campus police were, quite literally, created to suppress student activism. Although the first campus police were established in 1894 at Yale, most other universities didn’t follow suit until the late 1960s and early 1970s; According to historians, these departments were largely formed to quash student protests against the ongoing war in Vietnam. 

I believe these dynamics, paired with an unclear sense of how, or whether, the technology works clearly merit future investigative scrutiny. 

<b><u>Reporting Hypotheses</u></b>

My hypotheses are as follows:
<ol>
	<li>Social Sentinel is used by campus police not just for its stated purpose of preventing suicides and shootings, but also for suppressing protests and activism</li>
	<li>Social Sentinel is not an effective tool for preventing suicides and shootings on campuses, or at very least is not as effective as the company claims that it is</li> 
</ol>

<b><u>Datasets</u></b>

To investigate these hypotheses, I've collected the following datasets:
<ol>
	<li>Purchasing data from GovSpend showing nearly all of the schools (K12 and universities) which have purchased Social Sentinel since Jan. 1,  2015,  showing the purchase date, sale price and description, stored in Google Sheet form</li>
	<li>888 tweets flagged by Social Sentinel collected by Buzzfeed News reporters Peter Aldhous and Lam Vo, stored in CSV and RData form</li>
	<li>Tens of thousands of pages of documents from colleges (mostly in Texas), stored largely in PDF form, which confirm the schools use of technologies and reveal details about the ways in which colleges use Social Sentinel. I may try to OCR these documents to plain text so I can use natural language processing methods like entity extraction, summarization and BERT sentence vectorization for page similarity,  to refresh my memory/get a "lay of the land" for what I've got so far.</li>
</ol> 
In addition to these datasets I am also trying to obtain:
<ol>
	<li>4500 more flagged tweets containing variations/lemmas on the word "bomb," from Addie Beach, a former linguistics student at the University of Vermont who got the tweets from the company itself and wrote a senior thesis on them</li>
	<li>Tens of thousands of more documents from all 32 public universities which have used this technology</li>
	<li>Code and/or training data (ie. the "Language of Harm") from the company which could give an unprecedented look into how Social Sentinel works/worked, assuming I can get someone to leak it to me.</li>
</ol>

<b><u>Analysis and Visualization Plan</u></b>

To support my reporting hypotheses, I plan to do the following:
<ol>
	<li>Preprocess the tweets data by first converting all sources into CSVs and then bringing them into Python Pandas for unioning/concatenation into a single output CSV</li>
	<li>Obtain non-flagged tweets for comparison for the same users for the same period, using the Twint and/or Tweepy libraries in Python. </li>
	<li>Perform exploratory data analysis using unsupervised clustering methods, namely K-means and topic modeling: <ol>
		<li>K-means to try to determine whether I could create a model which succesfully clusters flagged and unflagged Tweets apart (after converting each word/token into a 768-dimensional vector with BERT) and to see whether there are hidden "categories" in the flagged tweets which can be gleaned. </li>
		<li>Topic modeling to determine the topics most prevalent in flagged tweets which aren't present in unflagged tweets.</li>
		</ol></li>
	<li>Visualize the clustering by: <ol>
		<li>Performing dimensionality reduction in Python with a method like <a href="https://umap-learn.readthedocs.io/en/latest/"> UMAP</a> or <a href="https://towardsdatascience.com/t-sne-clearly-explained-d84c537f53a">t-SNE</a> to convert the 768-dimensional BERT vectors into two dimensions, which allows the clusters to displayed as a scatter plot. This plot could be animated with a tool like R's gganimate or Javascript's D3 to show the clustering algorithm working. This plot could also have interactive elements/tooltips with information like Tweet text available upon hovering over each dot, built with Vega-Lite or D3 in Javascript, ggplot in R or Plotly in Python.</li>
		<li>Showing the distributions of certain topics identified by the topic modeling over time, by creating line charts in a tool like Plotly, ggplot, Vega-Lite or D3.</li>
		</ol>
	<li>Create a map using Mapbox GL JS or Tableau showing every college that has used Social Sentinel. This map could have points scaled to the size of the school and/or could be animated to show when the school began/ended uses the technology. More information could be displayed with tooltips upon hovering over each point.</li>
	<li>Create a range plot showing the lengths of time each of the 32 schools used Social Sentinel for, in order to illustrate how valuable the technology has been to these various schools (ie. short bars indicate low value as it means that cancelled after only a small time period). These dots and lines could be programmed in D3 to animate in as the user scrolls to a certain point in the page and then stay static for legibility purposes.</li> 
	</ol>
	Depending on time or interest, I may also attempt the following:
	<ol>
	<li>Trying to reverse engineer Social Sentinel's model, but feeding the flagged and unflagged tweets into a PyTorch/Keras neural network and having it guess at the features. (The journalistic value of this is questionable, as it would be nearly impossible to tell whether this was the exact model Social Sentinel uses/used without their code and training data, and we probably don't have enough training data in the first place to achieve great results). </li>
	<li>Building my own model for detecting dangerous speech by utilizing whichever tool worked best for this task identified in the relevant academic literature (so long as it is availabe in Python). I could then use this model to build a Flask web app which would allow the user to type in a "Tweet" (a string of length 280 or less) and see whether it would be flagged or unflagged.</li></ol>
	
<b><u>Conclusion</u></b>
 
In conclusion, there is a large opportunity to break new ground through the exploration of the rise of surveillance on college campuses using data. This story speaks to many of the most pressing social issues of the day: the rise of artificial intelligence, the erosion of privacy in the digital age, police accountability, the conflicts between free speech and safety, the rise of white supremacy and the racial justice movements created to combat it. Through confident investigative reporting, compelling visualization and cutting-edge data analysis, I hope to illustrate all of these themes and tell a story which will be relevant and impactful for years to come.