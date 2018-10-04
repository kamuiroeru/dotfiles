import requests
from bs4 import BeautifulSoup

# stringを入力する場合
# query = lambda s: 'https://ejje.weblio.jp/content/{}'.format('+'.join(s.split(' ')))

query = lambda l: 'https://ejje.weblio.jp/content/{}'.format('+'.join(l))


def trans_eng_jpn(s):
    r = requests.get(query(s))
    soup = BeautifulSoup(r.content, 'html.parser')
    select = soup.select('td.content-explanation')
    if select:
        return soup.select('td.content-explanation')[0].text
    else:
        recovery = soup.select('.nrCntSgWrp')
        if recovery:
            word, meaning = '.nrCntSgT', '.nrCntSgB'
            words = [elem.select(word)[0].text.strip() for elem in recovery]
            meanings = [elem.select(meaning)[0].text.strip() for elem in recovery]
            return words, meanings
        else:
            return None


import pandas as pd
def makeMeanExcelFile(queries: list, outfname='out.xlsx'):
    trans_list = []
    for s in queries:
        transed = trans_eng_jpn(s)
        if len(transed) == 1:
            trans_list.append(transed)
        else:
            trans_list.append('__Not Found__')
    df = pd.DataFrame({'query': queries, 'trans': trans_list})
    df.to_excel(outfname)


if __name__ == '__main__':
    from sys import argv
    s = argv[1:]
    transed = trans_eng_jpn(s)
    if not transed:
        print('「{}」に一致するもが見つかりませんでした。'.format(' '.join(s)))
    else:
        if isinstance(transed, str):
            print(transed)
        elif len(transed) == 2:
            print('「{}」に一致するものが見つかりませんでした。'.format(' '.join(s)))
            print('もしかして…')
            for w, m in zip(*transed):
                print('   {}: {}'.format(w, m))
