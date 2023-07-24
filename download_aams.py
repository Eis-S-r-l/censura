#!/usr/bin/env python3

import requests, optparse, sys
from bs4 import BeautifulSoup

def main():
    global options
    # Definisco la variabile sotto e la inizializzo nulla
    # Questo perchè se in tutta la pagina non trovo il file
    # allora lastFile resta non inizializzata e manda
    # in errore lo script

    lastFile = None

    # Elaborazione argomenti della linea di comando
    usage = "usage: %prog [options] arg"
    parser = optparse.OptionParser(usage)
    parser.add_option("-o", "--output", dest="out_file", help="File di output generato")

    (options, args) = parser.parse_args()
    if len(args) == 1:
        parser.error("Numero di argomenti non corretto")
    if (options.out_file is None):
        parser.error("Numero di argomenti non corretto")

    url = "https://www.adm.gov.it/portale/siti-web-inibiti-giochi"
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "html.parser")
    for div in soup.findAll('div', attrs={'class':'container'}):
        for ul in div.findAll('ul'):
            for li in ul.findAll('li'):
                if not ("elenco dei siti soggetti ad inibizione - txt" in li.text.lower()):continue
                tag = li.find('a')
                
                lastFile = "https://www.adm.gov.it" + tag["href"]
                break
        if lastFile is not None:break
        
    # Controllo se ho trovato il file vedendo se la variabile inizializzata è stata modificata
    # Solo se lastFile è stato trovato, allora lo scrivo nel file di output specificato

    if lastFile is not None:
        response = requests.get(lastFile)
        with open(options.out_file,'wb') as f:
            f.write(response.content)
        sys.exit(0)
    else:
        sys.exit(1)
    
    

if __name__ == '__main__':
    main()
