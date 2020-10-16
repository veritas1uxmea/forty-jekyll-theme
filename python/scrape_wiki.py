# https://stackoverflow.com/questions/54890708/scraping-data-from-wikipedia-table
import pandas as pd
url='https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_elevation'
df=pd.read_html(url, header=0)[0]
print(df.head)
df.to_csv('data/us_states_by_elevation.csv',index = False, header = True)

