READ ME: 

--------------------------------------------------------------
This folder includes Capstone 2 Python Results/Visualizations

- Python File.
- Python File using Google Colaboratory or Jupyter Notebook.
- Dataset (raw).

Instructions: 
- Open using any Python program (preferably Google Colaboratory or Jupyter Notebook).
- Import Dataset (raw) into the program.
- Run all.
- All results will be displayed.
- If error, restart program and run all again. 
--------------------------------------------------------------

~RugbyStats~
A look into ESPN's available international rugby union scoring stats via StatsGuru

Contents
countries.csv: A list of countries, along with their international rugby tier, and abbreviations used if applicable.
preprocessed.csv: The scraped data from rugby_stats_final.csv after processed through PreProcessingScript.R with new features
PreProcessingScript.R: R script to do some general processing and addition of new features which may be useful for further analysis
rugby_stats_final.csv: The output of web scraping from the ESPN StatsGuru database via scraper.py
scraper.py: Simple web scraper using Python's beautifulsoup
README.md: The document you are currently reading
Supplemental Information
Rugby internationals Tier list: https://en.wikipedia.org/wiki/List_of_international_rugby_union_teams

ESPN StatsGuru: http://stats.espnscrum.com/statsguru/rugby/stats/index.html
