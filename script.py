import base64
import datetime
import json
import os
import shutil
import sqlite3
import sys

def convert_timestamp_to_add_date(timestamp):
    offset = 11644473600000000
    seconds = (int(timestamp) - offset) / 1000000
    add_date = int(seconds)
    return add_date

location = sys.argv[1]
location = os.path.expanduser(location)
bookmarks = {}

# parse the bookmarks.md file and add all the links to respective lists for each browser
for line in open(location+"/bookmarks.md", 'r'):
    if line.startswith('##'):
        browser_name = line[3:].strip()
        bookmarks[browser_name] = set()
    elif line.startswith('- '):
        bookmarks[browser_name].add(line[2:].strip())

# iterating through the bookmarks dictionary and removing duplicates
unique_bookmarks = set()

bookmarks_copy = {}

for browser_name in bookmarks:
    for bookmark in bookmarks[browser_name]:
        if browser_name not in bookmarks_copy:
            bookmarks_copy[browser_name] = []
        bookmarks_copy[browser_name].append(bookmark)
        if bookmark not in unique_bookmarks:
            unique_bookmarks.add(bookmark)
        else :
            bookmarks_copy[browser_name].remove(bookmark)

final_bookmarks = {}

def googleChrome() :
    database_file = "~/.config/google-chrome/Default/Favicons"
    json_file = "~/.config/google-chrome/Default/Bookmarks"
    json_file = os.path.expanduser(json_file)

    copied_file = "copied_database.db"
    shutil.copyfile(os.path.expanduser(database_file), copied_file)

    with open(json_file, 'r') as g_chrome:
        data = json.load(g_chrome)
    urls = []
    for bookmark in data['roots']['bookmark_bar']['children']:
        if bookmark['type'] == 'url':
            final_bookmarks[bookmark['name']] = {
                'url': bookmark['url'],
                'add_date': convert_timestamp_to_add_date(bookmark['date_added']),
                'icon': None
            }
            urls.append(bookmark['url'])

    query = "SELECT icon_mapping.page_url, favicon_bitmaps.image_data FROM icon_mapping JOIN favicon_bitmaps ON icon_mapping.icon_id = favicon_bitmaps.icon_id WHERE icon_mapping.page_url IN ('" + "','".join(urls) + "') AND favicon_bitmaps.last_updated = (SELECT MAX(last_updated) FROM favicon_bitmaps WHERE icon_id = icon_mapping.icon_id)"


    # Pass the query to the database file and get the result
    result = sqlite3.connect(os.path.expanduser(copied_file)).cursor().execute(query).fetchall()

    for i in result:
        # search for the url in the final_bookmarks dictionary
        for bookmark_name in final_bookmarks:
            if final_bookmarks[bookmark_name]['url'] == i[0]:
                base64_data = base64.b64encode(i[1]).decode('utf-8')
                image_data = f"data:image/png;base64,{base64_data}"
                final_bookmarks[bookmark_name]['icon'] = image_data
    os.remove(copied_file)

def chromium() :
    database_file = "~/.config/chromium/Default/Favicons"
    json_file = "~/.config/chromium/Default/Bookmarks"
    json_file = os.path.expanduser(json_file)

    copied_file = "copied_database.db"
    shutil.copyfile(os.path.expanduser(database_file), copied_file)

    with open(json_file, 'r') as g_chrome:
        data = json.load(g_chrome)
    urls = []
    for bookmark in data['roots']['bookmark_bar']['children']:
        if bookmark['type'] == 'url':
            final_bookmarks[bookmark['name']] = {
                'url': bookmark['url'],
                'add_date': convert_timestamp_to_add_date(bookmark['date_added']),
                'icon': None
            }
            urls.append(bookmark['url'])

    query = "SELECT icon_mapping.page_url, favicon_bitmaps.image_data FROM icon_mapping JOIN favicon_bitmaps ON icon_mapping.icon_id = favicon_bitmaps.icon_id WHERE icon_mapping.page_url IN ('" + "','".join(urls) + "') AND favicon_bitmaps.last_updated = (SELECT MAX(last_updated) FROM favicon_bitmaps WHERE icon_id = icon_mapping.icon_id)"


    # Pass the query to the database file and get the result
    result = sqlite3.connect(os.path.expanduser(copied_file)).cursor().execute(query).fetchall()

    for i in result:
        # search for the url in the final_bookmarks dictionary
        for bookmark_name in final_bookmarks:
            if final_bookmarks[bookmark_name]['url'] == i[0]:
                base64_data = base64.b64encode(i[1]).decode('utf-8')
                image_data = f"data:image/png;base64,{base64_data}"
                final_bookmarks[bookmark_name]['icon'] = image_data
    os.remove(copied_file)
    
def brave():
    database_file = "~/.config/BraveSoftware/Brave-Browser/Default/Favicons"
    json_file = "~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks"
    json_file = os.path.expanduser(json_file)

    copied_file = "copied_database.db"
    shutil.copyfile(os.path.expanduser(database_file), copied_file)
    with open(json_file, 'r') as g_chrome:
        data = json.load(g_chrome)
    urls = []
    for bookmark in data['roots']['bookmark_bar']['children']:
        if bookmark['type'] == 'url':
            final_bookmarks[bookmark['name']] = {
                'url': bookmark['url'],
                'add_date': convert_timestamp_to_add_date(bookmark['date_added']),
                'icon': None
            }
            urls.append(bookmark['url'])

    query = "SELECT icon_mapping.page_url, favicon_bitmaps.image_data FROM icon_mapping JOIN favicon_bitmaps ON icon_mapping.icon_id = favicon_bitmaps.icon_id WHERE icon_mapping.page_url IN ('" + "','".join(urls) + "') AND favicon_bitmaps.last_updated = (SELECT MAX(last_updated) FROM favicon_bitmaps WHERE icon_id = icon_mapping.icon_id)"


    # Pass the query to the database file and get the result
    result = sqlite3.connect(os.path.expanduser(copied_file)).cursor().execute(query).fetchall()

    for i in result:
        # search for the url in the final_bookmarks dictionary
        for bookmark_name in final_bookmarks:
            if final_bookmarks[bookmark_name]['url'] == i[0]:
                base64_data = base64.b64encode(i[1]).decode('utf-8')
                image_data = f"data:image/png;base64,{base64_data}"
                final_bookmarks[bookmark_name]['icon'] = image_data
    os.remove(copied_file)
def edge():
    database_file = "~/.config/microsoft-edge/Default/Favicons"
    json_file = "~/.config/microsoft-edge/Default/Bookmarks"
    json_file = os.path.expanduser(json_file)

    copied_file = "copied_datatbase.db"
    shutil.copyfile(os.path.expanduser(database_file), copied_file)

    with open(json_file, 'r') as g_chrome:
        data = json.load(g_chrome)
    urls = []
    for bookmark in data['roots']['bookmark_bar']['children']:
        if bookmark['type'] == 'url':
            final_bookmarks[bookmark['name']] = {
                'url': bookmark['url'],
                'add_date': convert_timestamp_to_add_date(bookmark['date_added']),
                'icon': None
            }
            urls.append(bookmark['url'])

    query = "SELECT icon_mapping.page_url, favicon_bitmaps.image_data FROM icon_mapping JOIN favicon_bitmaps ON icon_mapping.icon_id = favicon_bitmaps.icon_id WHERE icon_mapping.page_url IN ('" + "','".join(urls) + "') AND favicon_bitmaps.last_updated = (SELECT MAX(last_updated) FROM favicon_bitmaps WHERE icon_id = icon_mapping.icon_id)"


    # Pass the query to the database file and get the result
    result = sqlite3.connect(os.path.expanduser(copied_file)).cursor().execute(query).fetchall()

    for i in result:
        # search for the url in the final_bookmarks dictionary
        for bookmark_name in final_bookmarks:
            if final_bookmarks[bookmark_name]['url'] == i[0]:
                base64_data = base64.b64encode(i[1]).decode('utf-8')
                image_data = f"data:image/png;base64,{base64_data}"
                final_bookmarks[bookmark_name]['icon'] = image_data
    os.remove(copied_file)

def opera():
    database_file = "~/.var/app/com.opera.Opera/config/opera/Favicons"

    copied_file = "copied_database.db"
    shutil.copyfile(os.path.expanduser(database_file), copied_file)

    json_file = "~/.var/app/com.opera.Opera/config/opera/Bookmarks"
    json_file = os.path.expanduser(json_file)
    with open(json_file, 'r') as g_chrome:
        data = json.load(g_chrome)
    urls = []
    for bookmark in data['roots']['bookmark_bar']['children']:
        if bookmark['type'] == 'url':
            final_bookmarks[bookmark['name']] = {
                'url': bookmark['url'],
                'add_date': convert_timestamp_to_add_date(bookmark['date_added']),
                'icon': None
            }
            urls.append(bookmark['url'])

    query = "SELECT icon_mapping.page_url, favicon_bitmaps.image_data FROM icon_mapping JOIN favicon_bitmaps ON icon_mapping.icon_id = favicon_bitmaps.icon_id WHERE icon_mapping.page_url IN ('" + "','".join(urls) + "') AND favicon_bitmaps.last_updated = (SELECT MAX(last_updated) FROM favicon_bitmaps WHERE icon_id = icon_mapping.icon_id)"


    # Pass the query to the database file and get the result
    result = sqlite3.connect(copied_file).cursor().execute(query).fetchall()

    for i in result:
        # search for the url in the final_bookmarks dictionary
        for bookmark_name in final_bookmarks:
            if final_bookmarks[bookmark_name]['url'] == i[0]:
                base64_data = base64.b64encode(i[1]).decode('utf-8')
                image_data = f"data:image/png;base64,{base64_data}"
                final_bookmarks[bookmark_name]['icon'] = image_data
    os.remove(copied_file)
    

for flag in sys.argv[2:]:
    # if flag == '--firefox':
    #     firefox()
    if flag == '--chromium':
        chromium()
    if flag == '--brave':
        brave()
    if flag == '--opera':
        opera()
    if flag == '--chrome':
        googleChrome()
    if flag == '--edge':
        edge()


html_header = """<!DOCTYPE NETSCAPE-Bookmark-file-1>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<TITLE>Bookmarks</TITLE>
<H1>Bookmarks</H1>
<DL><p>
	<DT><H3 PERSONAL_TOOLBAR_FOLDER="true">Bookmarks bar</H3>
	<DL><p>"""

html_footer = """</DL><p>
</DL><p>"""


today = datetime.date.today()



# create a bookmarks.html file in location
with open(location+"/bookmarks.html", 'w') as f:
    f.write(html_header)
    for bookmark in final_bookmarks:
        f.write(f"""<DT><A HREF="{final_bookmarks[bookmark]['url']}" ADD_DATE="{final_bookmarks[bookmark]['add_date']}" ICON="{final_bookmarks[bookmark]['icon']}">{bookmark}</A>\n\t""")
    f.write(html_footer)



