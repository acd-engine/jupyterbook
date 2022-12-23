#!/usr/bin/env python
# coding: utf-8

# # Archibald Prize

# In[1]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import StrMethodFormatter

archies = pd.read_csv('data/archies.csv')
archies.head()


# In[2]:


archies['GENDER'].value_counts(normalize=True).plot.pie(autopct='%1.1f%%')
plt.show()


# In[3]:


archies['PORTRAIT GENDER'].value_counts(normalize=True).plot.pie(autopct='%1.1f%%')
plt.show()


# In[4]:


pd.crosstab(archies['GENDER'], archies['PORTRAIT GENDER']).plot(kind='bar')


# In[5]:


archies['winning_age'] = archies['YEAR'] - archies['DOB']
print(pd.DataFrame(archies.winning_age.describe()).T,'\n')
archies['winning_age'].hist()
plt.title('Distribution of winning age, Median age: 44')
plt.show()


# #### Colour and Brightness

# In[6]:


from IPython.display import Image
Image(filename='images/colorbydecade_python.png')


# In[7]:


from IPython.display import Image
Image(filename='images/1920_byYear.png')


# In[8]:


from IPython.display import Image
Image(filename='images/1930_byYear.png')


# In[9]:


from IPython.display import Image
Image(filename='images/1940_byYear.png')


# In[10]:


from IPython.display import Image
Image(filename='images/1950_byYear.png')


# In[11]:


from IPython.display import Image
Image(filename='images/1960_byYear.png')


# In[12]:


from IPython.display import Image
Image(filename='images/1970_byYear.png')


# In[13]:


from IPython.display import Image
Image(filename='images/1980_byYear.png')


# In[14]:


from IPython.display import Image
Image(filename='images/1990_byYear.png')


# In[15]:


from IPython.display import Image
Image(filename='images/2000_byYear.png')


# In[16]:


from IPython.display import Image
Image(filename='images/2010_byYear.png')


# In[17]:


from IPython.display import Image
Image(filename='images/2020_byYear.png')


# In[18]:


from IPython.display import Image
Image(filename='images/Brightness_python.png')


# In[19]:


import warnings
warnings.filterwarnings("ignore")
participants_by_name = pd.read_csv('data/allparticipants_byyear.csv', index_col=0)

artist_df = pd.DataFrame()

for winner in archies.sort_values('winning_age')['WINNER'].unique():
    if (winner == '–') | (pd.isnull(winner)): continue

    artist_dict = dict()
    w_df = archies[archies['WINNER'] == winner]
    p_df = participants_by_name[participants_by_name['1'] == winner]
    
    dob,dod = w_df['DOB'].values[0],w_df['DOD'].values[0]
    artist_dict[0] = 0 #dob
    
    if pd.isnull(dod): dod = 2023
    
    for yr in range(int(dob)+1,int(dod)):
        if len(w_df[w_df['YEAR'] == yr]): artist_dict[yr-dob] = 3
        elif len(p_df[p_df['Year'] == yr]): artist_dict[yr-dob] = 2
        else: artist_dict[yr-dob] = 1
    
    if (artist_dict[yr-dob] == 1) & (dod != 2023): artist_dict[dod-dob] = 0 #dod
    
    # if winner == 'Peter Wegner': break
    
    artist_dict_df = pd.DataFrame(artist_dict.values(), columns=[winner]).T
    artist_df = artist_df.append(artist_dict_df)

    # artist_df.to_csv('archies_participants_wide.csv')

artist_stats = []

for x in range(artist_df.shape[0]):
    aa = artist_df.iloc[x:x+1].T
    first = aa[aa[aa.columns[0]] > 1][aa.columns[0]].head(1).index[0]
    last = aa[aa[aa.columns[0]] > 1][aa.columns[0]].tail(1).index[0]
    
    artist_stats.append([aa.columns[0], first, last])
    
artist_stats = pd.DataFrame(artist_stats)
artist_stats['diff'] = artist_stats[2] - artist_stats[1]


# #### Participation over time

# In[20]:


from IPython.display import Image
Image(filename='images/participationrates_python.png')


# #### Prize Money

# In[21]:


prize_money = pd.read_csv('data/Archibald_PrizeMoney2.csv', index_col=0)

plt.figure(figsize=(16, 8))

# Set the x-axis to the year column
x = prize_money.index

# Set the y-axis to the value column
y = prize_money['AUD_Equivalent']

# Create a line plot of the data
plt.plot(x, y)

# Add labels and a title
plt.xlabel('')
plt.title('Archibald Prize Money by Year\n', size=22)

plt.axvspan(1981, 1986, alpha=0.1, color='orange')
plt.text(1982.5, 103500, 'Katies', ha='center', va='center',size=14, rotation=90)

plt.axvspan(1986, 1988, alpha=0.1, color='yellow')
plt.text(1987.25, 96000, 'Grace Brothers', ha='center', va='center',size=14, rotation=90)

plt.axvspan(1988, 1992, alpha=0.1, color='green')
plt.text(1989.5, 96000, 'Coles Myer Ltd', ha='center', va='center',size=14, rotation=90)

plt.axvspan(1992, 2006, alpha=0.1, color='red')
plt.text(1994.5, 96000, 'State Bank/\nColonial Group', ha='center', va='center',
         size=14, rotation=90)

plt.axvspan(2006, 2009, alpha=0.1, color='green')
plt.text(2007.5, 105000, 'Myer', ha='center', va='center',size=14,rotation=90)

plt.axvspan(2009, 2023, alpha=0.1, color='blue')
plt.text(2010.5, 105000, 'ANZ', ha='center', va='center',size=14,rotation=90)

# Format the y-axis labels as a monetary amount
plt.gca().yaxis.set_major_formatter(StrMethodFormatter('${x:,.0f} AUD'))

plt.yticks(size=14)
plt.xticks(size=14)

plt.ylim(0,110000)
plt.xlim(1915,2023)

plt.grid(axis='y')

# Show the plot
plt.show()


# In[22]:


plt.figure(figsize=(16, 8))

missing_cond = (prize_money.index > 1964) & (prize_money.index < 1968)
missing_cond2 = (prize_money.index > 1970) & (prize_money.index < 1974)

# Set the x-axis to the year column
x = prize_money[prize_money.index < 1981].index
x2 = prize_money[missing_cond].index
x3 = prize_money[missing_cond2].index

# Set the y-axis to the value column
y = prize_money[prize_money.index < 1981]['AUD_Equivalent']
y2 = prize_money[missing_cond]['AUD_Equivalent'].ffill()
y3 = prize_money[missing_cond2]['AUD_Equivalent'].ffill()

# Create a line plot of the data
plt.plot(x, y)
plt.plot(x2, y2, linestyle='dashed',color='steelblue',alpha=0.5)
plt.plot(x3, y3, linestyle='dashed',color='steelblue',alpha=0.5)

# Add labels and a title
plt.xlabel('')
plt.title('Archibald Prize Money by Year, Before Official Sponsors (1921-1980)\n', size=22)

# Format the y-axis labels as a monetary amount
plt.gca().yaxis.set_major_formatter(StrMethodFormatter('${x:,.0f} AUD'))

plt.text(1930, 1250, 'GREAT\nDEPRESSION', ha='left', va='center',size=14)
plt.text(1939, 1150, 'WORLD\nWAR II', ha='left', va='center',size=14)
plt.text(1964, 1225, 'AUSTRALIAN\nDOLLAR\nINTRODUCED', ha='left', va='center',size=14)
plt.text(1969, 3900, 'DONATION OF $2000 FROM THE\nBICENTENARY CELEBRATIONS\nCITIZENS’ COMMITTEE', ha='right', va='center',size=14)

plt.yticks(size=14)
plt.xticks(size=14)

plt.ylim(1,4250)

# Show the plot
plt.show()


# In[23]:


no_participants = pd.read_csv('data/no_participants_new.csv', index_col=0)

plt.figure(figsize=(16, 8))

missing_cond = (prize_money.index > 1964) & (prize_money.index < 1968)
missing_cond2 = (prize_money.index > 1970) & (prize_money.index < 1974)

# Set the x-axis to the year column
x = prize_money[prize_money.index < 1981].index
x2 = prize_money[missing_cond].index
x3 = prize_money[missing_cond2].index
x4 = no_participants[no_participants.Year < 1981]['Year']

# Set the y-axis to the value column
y = prize_money[prize_money.index < 1981]['AUD_Equivalent']
y2 = prize_money[missing_cond]['AUD_Equivalent'].ffill()
y3 = prize_money[missing_cond2]['AUD_Equivalent'].ffill()
y4 = no_participants[no_participants.Year < 1981]['Entries']

ax = plt.subplot(2, 1, 1)
# Create a line plot of the data
ax.plot(x, y)
ax.plot(x2, y2, linestyle='dashed',color='steelblue',alpha=0.5)
ax.plot(x3, y3, linestyle='dashed',color='steelblue',alpha=0.5)

beforesponsors = pd.merge(no_participants[no_participants.Year < 1981], 
                          prize_money[prize_money.index < 1981].reset_index())

cor = beforesponsors['Entries'].corr(beforesponsors['AUD_Equivalent']).round(2)

# Add labels and a title
plt.xlabel('')
plt.title(f'Archibald Prize Money and Number of Entries by Year, \nBefore Official Sponsors (1921-1980), Corr: {cor}\n', size=22)

# Format the y-axis labels as a monetary amount
plt.gca().yaxis.set_major_formatter(StrMethodFormatter('${x:,.0f} AUD'))

plt.yticks(size=14)
plt.xticks(size=14)
plt.ylim(1,4250)
plt.grid(axis='x')

ax2 = plt.subplot(2, 1, 2)
ax2.plot(x4, y4, color = 'tab:orange')

plt.yticks(size=14)
plt.xticks(size=14)
plt.ylim(1,445)
plt.grid(axis='x')

# Show the plot
plt.show()


# In[24]:


plt.figure(figsize=(16, 8))

# Set the x-axis to the year column
x = prize_money[prize_money.index >= 1981].index
# Set the y-axis to the value column
y = prize_money[prize_money.index >= 1981]['AUD_Equivalent']

# Create a line plot of the data
plt.plot(x, y)

# Add labels and a title
plt.xlabel('')
plt.title('Archibald Prize Money by Year, Sponsors/Partners Era (1981-)\n', size=22)

plt.axvspan(1980, 1986, alpha=0.1, color='orange')
plt.text(1980.75, 103500, 'Katies', ha='center', va='center',size=14, rotation=90)

plt.axvspan(1986, 1988, alpha=0.1, color='yellow')
plt.text(1986.5, 96000, 'Grace Brothers', ha='center', va='center',size=14, rotation=90)

plt.axvspan(1988, 1992, alpha=0.1, color='green')
plt.text(1988.5, 96000, 'Coles Myer Ltd', ha='center', va='center',size=14, rotation=90)

plt.axvspan(1992, 2006, alpha=0.1, color='red')
plt.text(1993, 96000, 'State Bank/\nColonial Group', ha='center', va='center',
         size=14, rotation=90)

plt.axvspan(2006, 2009, alpha=0.1, color='green')
plt.text(2006.5, 105000, 'Myer', ha='center', va='center',size=14,rotation=90)

plt.axvspan(2009, 2023, alpha=0.1, color='blue')
plt.text(2009.5, 105000, 'ANZ', ha='center', va='center',size=14,rotation=90)

# Format the y-axis labels as a monetary amount
plt.gca().yaxis.set_major_formatter(StrMethodFormatter('${x:,.0f} AUD'))

plt.yticks(size=14)
plt.xticks(size=14)

plt.ylim(0,110000)
plt.xlim(1980.1,2023)

# Show the plot
plt.show()


# In[25]:


plt.figure(figsize=(16, 8))

# Set the x-axis to the year column
x = prize_money[prize_money.index >= 1981].index
x2 = no_participants[no_participants.Year >= 1981]['Year']

# Set the y-axis to the value column
y = prize_money[prize_money.index >= 1981]['AUD_Equivalent']
y2 = no_participants[no_participants.Year >= 1981]['Entries']


# Create a line plot of the data
ax = plt.subplot(2, 1, 1)
ax.plot(x, y, lw= 2)

plt.axvspan(1980, 1986, alpha=0.05, color='orange')
plt.axvspan(1986, 1988, alpha=0.05, color='yellow')
plt.axvspan(1988, 1992, alpha=0.05, color='green')
plt.axvspan(1992, 2006, alpha=0.05, color='red')
plt.axvspan(2006, 2009, alpha=0.05, color='green')
plt.axvspan(2009, 2023, alpha=0.05, color='blue')

# Format the y-axis labels as a monetary amount
plt.gca().yaxis.set_major_formatter(StrMethodFormatter('${x:,.0f} AUD'))

plt.yticks(size=14)
plt.xticks(size=14)

plt.ylim(0,110000)
plt.xlim(1980.1,2023)

beforesponsors = pd.merge(no_participants[no_participants.Year >= 1981], 
                          prize_money[prize_money.index >= 1981].reset_index())

cor = beforesponsors['Entries'].corr(beforesponsors['AUD_Equivalent']).round(2)

# Add labels and a title
plt.xlabel('')
plt.title(f'Archibald Prize Money and Number of Entries by Year,\nSponsors/Partners Era (1981-), Corr: {cor}\n', size=22)

# Format the y-axis labels as a monetary amount
plt.gca().yaxis.set_major_formatter(StrMethodFormatter('${x:,.0f} AUD'))

plt.yticks(size=14)
plt.xticks(size=14)
plt.grid(axis='x')

ax2 = plt.subplot(2, 1, 2)
ax2.plot(x2, y2, color = 'tab:orange', lw= 2)

plt.axvspan(1980, 1986, alpha=0.05, color='orange')
plt.axvspan(1986, 1988, alpha=0.05, color='yellow')
plt.axvspan(1988, 1992, alpha=0.05, color='green')
plt.axvspan(1992, 2006, alpha=0.05, color='red')
plt.axvspan(2006, 2009, alpha=0.05, color='green')
plt.axvspan(2009, 2023, alpha=0.05, color='blue')

plt.yticks(size=14)
plt.xticks(size=14)
plt.ylim(0,1190)
plt.grid(axis='x')

plt.xlim(1980.1,2023)

# Show the plot
plt.show()


# #### Start Age

# In[26]:


# Archibald start age
pd.DataFrame(artist_stats[1].describe()).T


# #### End Age

# In[27]:


# Archibald end age
pd.DataFrame(artist_stats[2].describe()).T


# #### Participation duration

# In[28]:


# Archibald overall participation duration
pd.DataFrame(artist_stats['diff'].describe()).T


# #### Archibald Prize participation trajectory

# In[29]:


from IPython.display import Image
Image(filename='images/test_sankey.png')


# In[30]:


tt = artist_df.T

fig, axes = plt.subplots(tt.shape[1], 1, 
                         figsize=(9, tt.shape[1]*1.25), 
                         sharex=True)

# plot each col onto one ax
for idx,(col, ax) in enumerate(zip(tt.columns, axes.flat)):
    colour = 'green'
    
    if idx == 0: ax = ax.twiny()
    if idx % 2: colour = 'orange'
    
    tt[col].plot(ax=ax, rot=0)

    ttt = pd.DataFrame(tt[col])
    markthis = ttt[ttt[col] == 3].index[0]
    
    ax.axvline(markthis, color='r', linestyle='--', lw=1, alpha=0.7)
    ax.set_title(col,x=0.115, y=0.6, size=8.5)
    ax.set_ylim(0,3.5)
    ax.set_xlim(-1,111)
    ax.axvspan(-1, 20, alpha=0.01, color=colour)
    ax.axvspan(20, 40, alpha=0.025, color=colour)
    ax.axvspan(40, 60, alpha=0.035, color=colour)
    ax.axvspan(60, 80, alpha=0.025, color=colour)
    ax.axvspan(80, 111, alpha=0.01, color=colour)


# #### Who is in the portrait?

# In[31]:


from matplotlib.pyplot import figure
archies['Decade'] = [ int(np.floor(int(year)/10) * 10) 
                       for year in np.array(archies["YEAR"])]

t1 = pd.crosstab(archies['Decade'],archies['ANZSCO_1'])

figure(figsize=(8, 6))
t1.plot(marker="o", markersize=4)
plt.legend(ncol=1, bbox_to_anchor=(1, 0.7))
plt.show()


# In[32]:


from matplotlib.pyplot import figure

t2 = pd.crosstab(archies['Decade'],archies['ANZSCO_2'])

figure(figsize=(8, 6))
t2.plot(marker="o", markersize=4)
plt.legend(ncol=1, bbox_to_anchor=(1, 0.7))
plt.show()


# In[33]:


archies['ANZSCO_1'].value_counts().plot(kind='barh')
plt.show()


# In[34]:


archies['ANZSCO_2'].value_counts().plot(kind='barh')
plt.show()

