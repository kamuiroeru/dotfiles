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
from time import sleep
def makeExcelFile(queries: list, outfname='out.xlsx'):
    trans_list = []
    for s in queries:
        sleep(0.5)
        transed = trans_eng_jpn(s)
        if not transed:
            trans_list.append('__Not Found__')
        else:
            if isinstance(transed, str):
                trans_list.append(transed)
            elif len(transed) == 2:
                s = '__not Found__\n'
                s += 'もしかして…\n'
                s += '\n'.join(['{}: {}'.format(w, m) for w, m in zip(*transed)])
                trans_list.append(s)
        print(s)
    df = pd.DataFrame({'query': queries, 'trans': trans_list})
    df.to_excel(outfname)


def txt2excel(input_filename: str, output_filename=''):
    l = [w.strip() for w in open(input_filename) if w.strip()]
    if output_filename:
        makeExcelFile(l, outfname=output_filename)
    else:
        makeExcelFile(l)


if __name__ == '__main__':
    from prompt_toolkit import PromptSession
    session = PromptSession()
    while True:
        try:
            s = session.prompt('eng or jpn >>>')
        except EOFError:
            print('Exit...')
            break
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
