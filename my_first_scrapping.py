from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup
my_url="https://www.newegg.com/Product/ProductList.aspx?Submit=ENE&DEPA=0&Order=BESTMATCH&Description=graphic+cards&N=-1&isNodeId=1"
#opening the connection and grabbing the page
uClient=uReq(my_url)
page_html=uClient.read()
uClient.close() 
#parsing the html, calling soup function
page_soup=soup(page_html, "html.parser")
page_soup.h1 #header of the page
page_soup.p #p tag
#grabs each product
containers=page_soup.findAll("div",{"class":"item-container"})

filename="products.csv"
f=open(filename,"w")
header="brand,product_name,shipping\n"
f.write(header)

for container in containers:
	#scrape the brand
    brand=container.div.div.a.img["title"]
    #grab title
	title_container=container.findAll("a",{"class":"item-title"})
	product_name=title_container[0].text
	#grab shipping
	shipping_container=container.findAll("li",{"class":"price-ship"})
	shipping=shipping_container[0].text.strip()

    print("brand: "+brand)
    print("product_name: "+product_name)
    print("shipping: "+shipping)

    #write into csv
    f.write(brand+","+product_name.replace(",","|")+","+shipping+"\n")

f.close()
