#!/usr/bin/env python
# coding: utf-8

# In[24]:


from bs4 import BeautifulSoup
import requests
import time
import datetime



import smtplib


# In[25]:


# Connect to Website and pull in data

URL = 'https://www.amazon.com/Funny-Data-Systems-Business-Analyst/dp/B07FNW9FGJ/ref=sr_1_3?dchild=1&keywords=data%2Banalyst%2Btshirt&qid=1626655184&sr=8-3&customId=B0752XJYNL&th=1'

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}

page = requests.get(URL, headers=headers)

soup = BeautifulSoup(page.content, "html.parser")


title = soup.find(id='productTitle').get_text().strip()

price = soup.find('span',class_='a-offscreen').get_text().replace("$","")

print(title)
print(price)


# In[26]:


# Create a Timestamp for your output to track when data was collected

import datetime

today = datetime.date.today()

print(today)


# In[27]:


"''# Clean up the data a little bit

price = price.strip()[1:]
title = title.strip()

print(title)
print(price)"""


# In[ ]:





# In[28]:


# Create CSV and write headers and data into the file


import csv 

header = ['Title', 'Price', 'Date']
data = [title, price, today]


with open('AmazonWebScraperDataset.csv', 'w', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(header)
    writer.writerow(data)


# In[29]:


import pandas as pd

df = pd.read_csv(r'C:\Users\Admin\AmazonWebScraperDataset.csv')

print(df)


# In[30]:


#Now we are appending data to the csv

with open('AmazonWebScraperDataset.csv', 'a+', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(data)


# In[31]:


def check_price() :
    
    URL = 'https://www.amazon.com/Funny-Data-Systems-Business-Analyst/dp/B07FNW9FGJ/ref=sr_1_3?dchild=1&keywords=data%2Banalyst%2Btshirt&qid=1626655184&sr=8-3&customId=B0752XJYNL&th=1'

    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}

    page = requests.get(URL, headers=headers)

    soup = BeautifulSoup(page.content, "html.parser")


    title = soup.find(id='productTitle').get_text().strip()

    price = soup.find('span',class_='a-offscreen').get_text().replace("$","")

    import datetime

    today = datetime.date.today()


    import csv 

    header = ['Title', 'Price', 'Date']
    data = [title, price, today]


    with open('AmazonWebScraperDataset.csv', 'w', newline='', encoding='UTF8') as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerow(data)

    


# In[ ]:


while(True):
    check_price()
    time.sleep(5)
    
    


# In[ ]:


import pandas as pd

df = pd.read_csv(r'C:\Users\Admin\AmazonWebScraperDataset.csv')

print(df)

